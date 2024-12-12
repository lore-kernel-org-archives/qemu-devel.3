Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0681CE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 21:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLqe1-0008Qm-AD; Thu, 12 Dec 2024 16:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLqdw-0008QP-Oq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLqdu-00039t-7C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 16:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734038560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjcMtJDfP3p5CSvSVrzoEwAIZHvXQYb7y3KECZ/FUJ8=;
 b=iveXlDvHYBKK4QF66DNYM4PLbxBQPwZmdNK7kZNbDEvGj/sDhiLpwAyJLwl0djZpZ5cfWF
 hyy9PtyUKrPFNw434B0jn5bTZ1UAKaiP6zv6QGad84B6WDa+7Js9CsGtm4Daw9d0fUBei1
 P6OdQQNO3zbvxFc9jprH4TI792D9dMk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-0VkDDYlQPTCioKsnHuOwPg-1; Thu, 12 Dec 2024 16:22:39 -0500
X-MC-Unique: 0VkDDYlQPTCioKsnHuOwPg-1
X-Mimecast-MFC-AGG-ID: 0VkDDYlQPTCioKsnHuOwPg
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a814406be9so19683105ab.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 13:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734038559; x=1734643359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjcMtJDfP3p5CSvSVrzoEwAIZHvXQYb7y3KECZ/FUJ8=;
 b=RaGiqC1XD8BkhZ+DlsHr13R4t6sjvTXoU1dgpJjFxJePCglnS0PEP9qDD61/yWaSHn
 /oETpaRzyR6U6clW46MGFUQYhX/m+BLHfOEWPPq7HgTxFrk9kWIao+jsfbWl2ELCd5d7
 /llQI/1aZ+ksaoqYzsrSvVfPfEJAeEZh/idtHvw94Ucc6AXDjcUfFiOhAFGQ6y1R1xxK
 mJ9cnKJrVK5LAQu6DwViRsv6dWike0pAkuDQUbPPqgXdeDSaKJN3KbYO8aMRqYd6nT5l
 SsusNEMDR5IeUQWp+/v3JXcWgivKcee+9jpTtBZp4Jo51G3d1s7888i+FtihbH+Sngrt
 a35Q==
X-Gm-Message-State: AOJu0YzF8k95w9dxwQwjpY4a2uW8OUZt//shurhEzhHf4k104aOmAsQG
 ctfW1174DkibUFgrisMW6C7dhpQQQpyiPTbRg5Az2EzIvjRF2O4Tji+fZG6l7LKuJ6lLAi4xon8
 PGx7UmXsO8VjzTBqdcbhc136zAG6HwYDn9khaOXgJKlARMgHLCMhB
X-Gm-Gg: ASbGncviIVcnw6IgW6baQhKIYYfS0o81/oBGqqZ0kyhmGt0ipjhdHp5ZPyQrBch5XWT
 H9BO8Jpj620hYxgzeaQ4/Y8zzO+YWsFzMAngXKccpjbdBj0Vc5DldZG31Ydq2AHi2WkgdtxnD5i
 rfR6fHUn8Vb77haP9yTZDuaEInpMtujIgwmnBisN0ir+f/6bdr5XvCeQvqFzOqZSpr0T/m2pWYe
 EdZR6lNhbSO1ZGmxv/hyUrfhpD7K+FFBW7k93O6dCAmoJtVmAVK41jyHJKaATvz+i+Rlmj9d4HB
 dM8gTxn5p7d94ZKsDA==
X-Received: by 2002:a05:6e02:168e:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3aff1118613mr4702815ab.20.1734038558965; 
 Thu, 12 Dec 2024 13:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAHCwqd/MTQSEKtpYHbDw6s1thRiCMpQHW31SnFnr6ijwzRMbkFGuMMLvEPSoMkDfUUr/BCw==
X-Received: by 2002:a05:6e02:168e:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3aff1118613mr4702575ab.20.1734038558658; 
 Thu, 12 Dec 2024 13:22:38 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808db3250sm45200715ab.39.2024.12.12.13.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 13:22:37 -0800 (PST)
Date: Thu, 12 Dec 2024 16:22:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 04/19] machine: aux-ram-share option
Message-ID: <Z1tUGwLb9KoOs_0b@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-5-git-send-email-steven.sistare@oracle.com>
 <Z1dLECXaEv4Q0BO6@x1n>
 <57501760-df02-4a39-86fc-8001952bb458@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57501760-df02-4a39-86fc-8001952bb458@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 03:38:07PM -0500, Steven Sistare wrote:
> On 12/9/2024 2:54 PM, Peter Xu wrote:
> > On Mon, Dec 02, 2024 at 05:19:56AM -0800, Steve Sistare wrote:
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 36f0811..0bcb2cc 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -2164,6 +2164,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
> > >       new_block->flags = ram_flags;
> > >       if (!host && !xen_enabled()) {
> > > +        if (!share_flags && current_machine->aux_ram_share) {
> > > +            new_block->flags |= RAM_SHARED;
> > > +        }
> > 
> > Just to mention that if you agree with what I said in patch 2, here it will
> > need some trivial rebase change.  IOW, IMO we shouldn't special case xen
> > either here, so it should also apply to xen if one chose to, changing aux
> > alloc to RAM_SHARED.
> 
> OK.
> 
> So, if this only requires a trivial change, do I get your RB?

Yes please.

-- 
Peter Xu


