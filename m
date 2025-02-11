Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA70C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 19:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwND-0002Iw-3V; Tue, 11 Feb 2025 14:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwNB-0002IC-KE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwNA-0008OE-7a
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739303803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M63kfrmskX6hMdRrB4pW1eocJkfk22lzF/M15ulWIkU=;
 b=D5SH1WXXTMpVsH2lSIqr/uAPjjK/eNiHgg8cEQWR1ITtYhC1oD0vAoQGTJdCG+fEWgGiOx
 ditGufnP+5I5F6qKpsx8BYgSzfozq4zOZ0+LPv8eLz41Yv9HKYlCloApPCsyec/wQcxTIg
 kR0PE/ju6kaip5B6atm+3bKFE0RmX60=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-_wnfNkQMP5CjxSQt4zc2OQ-1; Tue, 11 Feb 2025 14:56:42 -0500
X-MC-Unique: _wnfNkQMP5CjxSQt4zc2OQ-1
X-Mimecast-MFC-AGG-ID: _wnfNkQMP5CjxSQt4zc2OQ
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c04e4c62a8so578225985a.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739303802; x=1739908602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M63kfrmskX6hMdRrB4pW1eocJkfk22lzF/M15ulWIkU=;
 b=M4bG/4r3kwAZtIRIrlFZZY46XarbloMuI1ZPZItCI6wBXFcmL8NlFJKey9K6WRk+fy
 HXL+L9NiI5iHR9dBVEo0zlEQmThdZoFGyGXaHtiaUA50aKUhIkqqmtfocAvvASSk1R8d
 pluLNtuW4KbHj+7P/pFQkG3UrDQQX5eGjwNTwUAAH9UnzBNQnXY0SEqKWaYvvs0NkvqT
 lOdLFde9Lbwax1cSfWBpq3NuNJ1uSoNIDInwOTSRxipWtzIe5B5+ALw8pgyMWDRoD7tr
 G3k/XMDDjCXW5mBIDiVmGGea580N95eKf8nyCB22h1HntWjqR1Pcmpf2goJEJAdEerl1
 xIlQ==
X-Gm-Message-State: AOJu0YxOrR9u17i6gzWfjKuzFvACi7qiPflaSewSQLfK0yzs87dGepgR
 WSrSDr0vQOybG9YiUyxbm/AVTq7r6pa+qjzKYvG0cqtRkeRTBdk7tsNx+dzmaOvKJEt+MIR9GHa
 pbIre1pBY8a6YkmH7hacGJgLHxuJiVzQW7lOC6UeKTSDkugAsrDLc
X-Gm-Gg: ASbGncvMsvkFu2+92k1DMZSVIuTKxNzsPQvbB4tmnb/IFXKetPeizdIk69D4QaWmuib
 zqe+rkNM8QxHeIrnh4HVPa0dk74yy7Rq+yZYUY4UPRrz0FbrRvAdpLEY7gmchziWa19sgzeqyAv
 fhwYrDTY6+dd8bTF1wu75EAQJHM5sr77NbL43/C6s7FunifWVh+TAmfVv8qaXHchtqR8ZZfuTK1
 rWehPzGFfwzIMz/fKsK5LuEtftyvap1GRuvIlS5MdRQ7diStIYUMT2/4D4=
X-Received: by 2002:a05:620a:26a7:b0:7b6:73de:f340 with SMTP id
 af79cd13be357-7c06fc578b4mr83569185a.12.1739303801772; 
 Tue, 11 Feb 2025 11:56:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwKqYX66riDxF4o/ryvEM4aycA8eXtNh9SwZ/N8OTeUXwKc6uDJg+JBUL+YbHlnpA2gfl0QA==
X-Received: by 2002:a05:620a:26a7:b0:7b6:73de:f340 with SMTP id
 af79cd13be357-7c06fc578b4mr83565885a.12.1739303801403; 
 Tue, 11 Feb 2025 11:56:41 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c054580f06sm440424285a.65.2025.02.11.11.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 11:56:40 -0800 (PST)
Date: Tue, 11 Feb 2025 14:56:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 9/9] migration: Update migrate_cancel documentation
Message-ID: <Z6urdQwbKktZJel3@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 11, 2025 at 12:01:36PM -0300, Fabiano Rosas wrote:
> Update the migrate_cancel command documentation with a few words about
> postcopy and the expected state of the machine after migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


