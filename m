Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416FDD2CE01
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I3o-00008y-Md; Tue, 22 Oct 2024 12:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3I3d-000082-TV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3I3a-0005uP-8o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M9r/to+7nSPPKXNH/051YkACbMSe1k0XBBrHXb1DatE=;
 b=PREE8A9d5z/hKFw+oEpLTFEH0Sf9aDotISltR+2GlZAa2JRXDX4MR6yXB7sxRGK6SmVDaO
 20IQsHFFhQI8mrAA3zEmeLM/OU16+0lZdzyy7YxrDZpSeTxFsRLxDhJd8frQd6IwZw1lG5
 FuDWqWoCUBnzCTLGRJEsAwIYLE7Dm44=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-i1U8SpwQPNmHQ9mBTMVjPQ-1; Tue, 22 Oct 2024 12:48:21 -0400
X-MC-Unique: i1U8SpwQPNmHQ9mBTMVjPQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf496eda1so90536866d6.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729615700; x=1730220500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9r/to+7nSPPKXNH/051YkACbMSe1k0XBBrHXb1DatE=;
 b=LqXwkKmXFM58yIXM4qkI65lpJ+8xKi2UEEyv3NDd1SI3fJkQDrpRGsMxFYFSfdrlSy
 cA1ORB2vNS2GHiy1vjomo0SfkUMrxwziC2rwf5wZiMeOCb4EbsObhbOwYfpjcXnl1NQm
 Nj846ZrnkAIhL9SAkWfUCo1pfs6mNCX5UH+YiKR03OxbHcbPxWB2Iz+jHX8MItP/lOjA
 V3Yvm1omTaKOazlIUocYyQnvm2cYd82Pbu3t8vb/q6tw8rAlZtOGvDW/rSnPPP15sg9Q
 DRG2U3h73cSAZVuF5oKDdghxuReLzjjyVgzx24qWHKNL2FLIvZFCnNYbVcTEVCunfZ++
 myqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWanXdU65eEMcwOhFK6gQXT4+Ncr6KEgXXS6Ru5/5nsqBkS3vC6Xz3kIThxmtZWJOgQuy+/YDxAiI0u@nongnu.org
X-Gm-Message-State: AOJu0YwR8HPUBwU0Nv1Nl04Callg4qOM6PLpvc04z9pFTlPCh8PgFQ5w
 esRYQ1exWGJNvgz9shJdrTiwo7Q0QcapjtKLWvC9bFmml5JV1tF4ImQd1ZpiyUVw4ztvvgKzZtq
 rQMGv8bj7G7nZtM+Fc+mS/tomXCeV75IRy+DT1ZyOVs8w00O2Kvf4
X-Received: by 2002:a05:6214:450a:b0:6c5:b6de:5ee with SMTP id
 6a1803df08f44-6ce23e2eb33mr49272616d6.30.1729615700593; 
 Tue, 22 Oct 2024 09:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/ni3lfa6K/RK00URrjm5wCT+bp/XTl7U544HVj3xAhbWnW11wcX5gUSUO1lTUqKZjyTYurg==
X-Received: by 2002:a05:6214:450a:b0:6c5:b6de:5ee with SMTP id
 6a1803df08f44-6ce23e2eb33mr49272306d6.30.1729615700285; 
 Tue, 22 Oct 2024 09:48:20 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fe312sm30680196d6.49.2024.10.22.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:48:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 12:48:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Deprecate query-migrationthreads command
Message-ID: <ZxfXUazNDDigvXe3@x1n>
References: <20241021215220.982325-1-peterx@redhat.com>
 <87froo34xy.fsf@pond.sub.org> <ZxdujhRo_kSkdkbX@redhat.com>
 <87jze01kzp.fsf@pond.sub.org> <ZxeBuXQB3hd2avUh@redhat.com>
 <87plnsz7pm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plnsz7pm.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 22, 2024 at 01:40:37PM +0200, Markus Armbruster wrote:
> If we want such warnings for QMP, they should be automated just like the
> -compat actions.  Any existing warnings rendered redundant should then
> be taken out.  I considered that when I did -compat, and rejected it as
> not worth the effort.

Fair enough..  It's better to be done automatically if we decide to.

I'll respin, thanks.

-- 
Peter Xu


