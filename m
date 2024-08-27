Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBA5C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0La-0003af-1o; Tue, 27 Aug 2024 13:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0LX-0003Qi-Ie
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj0LV-0001AS-8v
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724781066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BsITNDDJpI985fMszxgjGuKQ1g7I20LfcexypZNUBo=;
 b=bmlricQP4T7GUcmPLhpB96myy8EAdcK1MyZxvs00sOh+i75yIGuXiueDc1lzLhZyUjzK3d
 7Pj1R/gXe0gYnOhu/38i3xD9HDO1EekTaqkDzZC/EiwYe1gYHdZmMfhgwQnbdpkbyJlFHn
 v5QVns4ezrf8l7eWoR//fm1xe/Ac+g0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-CpmH-10mOtqSPOxAzQQGcQ-1; Tue, 27 Aug 2024 13:51:03 -0400
X-MC-Unique: CpmH-10mOtqSPOxAzQQGcQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-709664a6285so7702666a34.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 10:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724781063; x=1725385863;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8BsITNDDJpI985fMszxgjGuKQ1g7I20LfcexypZNUBo=;
 b=NDMsnAuJbi2fXZZ6GUdbNMgFyL1Cdy7S6I1GbePrNyomWUIXe97Dc01lUF9voAuqA1
 KaLDi3IO1UASVtQefN5RZDaIJ4p1JIgTtroEGEnSQB9PfUcvNHKdomrIqEA2LCWpsYuR
 LXuFvg8F4aPBbI0R3BzMV4Fa/19yCSGcuq6ma7gkI7LlcMeoSQSryx/xm56WSig0Qmhv
 EhtO6SYrZsaUKOK1DYoHNbtXzsXecS9lfyyo0fsWN+Tj3NiHDkssBLym9yj8V6jTC3D7
 Z35uwQAMPtMEwRxINyVj3lptX2jCODtpKPQ9s2JFSWuezVzPrao2rA5RjEDKA5lf9Jlb
 qwWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbGcyH4lz1P6stpKbCsUEANHiObSolZxSuuHv03/0np0mJhj1utzhG8sPRxW4lWrPW7q/AaBdVClSt@nongnu.org
X-Gm-Message-State: AOJu0YzAEgo7V4jb+vd17p8kGG4rhfusgqnr8YyOGnl8Q+a1yyqVBIqi
 Fc9BafBupf99oeNQaPM8jQBaFFDmXwp+IPbU2zIgrLHN5tdiXzvKZELfJqArhYHp054B/u/3yMd
 DuYYkj1+caUqfQuhquK4aL7hKhCMOvFOZlk7VB3gnWMOzacfFZyEom8O8sRwj9KI=
X-Received: by 2002:a05:6830:44a1:b0:703:6883:30be with SMTP id
 46e09a7af769-70f482e8fbamr3351306a34.11.1724781062726; 
 Tue, 27 Aug 2024 10:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKJziV2W81mehtP66qlS4CpSxcbTZpc3DqMFTDZf1wO2K0KLFDBbcfqGCthlLQPQfVMEnmQ==
X-Received: by 2002:a05:6830:44a1:b0:703:6883:30be with SMTP id
 46e09a7af769-70f482e8fbamr3351284a34.11.1724781062390; 
 Tue, 27 Aug 2024 10:51:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03b8a41dsm2417598a34.77.2024.08.27.10.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 10:51:01 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:50:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
Message-ID: <Zs4SA8CYxK15CG_5@x1n>
References: <20240827083715.257768-1-david@redhat.com>
 <CAJSP0QX+NiO7An468cKMFja3TGmgGzyNcPZjEtpPrfi3Q_1xgw@mail.gmail.com>
 <36402f8f-dc97-4eaf-8197-1df2bc01720b@redhat.com>
 <CAJSP0QWed1ZjRZ2pkUgx0j+9bepKg1hfaWXQLzP613xsiHtwyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWed1ZjRZ2pkUgx0j+9bepKg1hfaWXQLzP613xsiHtwyw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 01:28:02PM -0400, Stefan Hajnoczi wrote:
> On Tue, 27 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
> >
> > On 27.08.24 18:52, Stefan Hajnoczi wrote:
> > > On Tue, 27 Aug 2024 at 04:38, David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> As reported by Peter, we might be leaking memory when removing the
> > >> highest RAMBlock (in the weird ram_addr_t space), and adding a new one.
> > >>
> > >> We will fail to realize that we already allocated bitmaps for more
> > >> dirty memory blocks, and effectively discard the pointers to them.
> > >>
> > >> Fix it by getting rid of last_ram_page() and simply storing the number
> > >> of dirty memory blocks that have been allocated. We'll store the number
> > >> of blocks along with the actual pointer to keep it simple.
> > >>
> > >> Looks like this leak was introduced as we switched from using a single
> > >> bitmap_zero_extend() to allocating multiple bitmaps:
> > >> bitmap_zero_extend() relies on g_renew() which should have taken care of
> > >> this.
> > >>
> > >> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=AfX6A4kScq=VSSK0peqPg@mail.gmail.com
> > >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > >> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM hotplug")
> > >> Cc: qemu-stable@nongnu.org
> > >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> > >> Cc: Peter Xu <peterx@redhat.com>
> > >> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> > >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > >> ---
> > >>   include/exec/ramlist.h |  1 +
> > >>   system/physmem.c       | 44 ++++++++++++++----------------------------
> > >>   2 files changed, 16 insertions(+), 29 deletions(-)
> > >>
> > >> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> > >> index 2ad2a81acc..f2a965f293 100644
> > >> --- a/include/exec/ramlist.h
> > >> +++ b/include/exec/ramlist.h
> > >> @@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
> > >>   #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
> > >>   typedef struct {
> > >>       struct rcu_head rcu;
> > >> +    unsigned int num_blocks;
> > >
> > > The maximum amount of memory supported by unsigned int is:
> > > (2 ^ 32 - 1) * 4KB * DIRTY_MEMORY_BLOCK_SIZE
> > > = ~32 exabytes
> > >
> >
> > True, should we simply use ram_addr_t ?
> 
> Sounds good to me. In practice scalability bottlenecks are likely with
> those memory sizes and it will be necessary to change how guest memory
> is organized anyway. But it doesn't hurt to make this counter
> future-proof.

IMHO it'll be nice to only use ram_addr_t when a variable is describing the
ramblock address space (with an offset, or a length there).  In this case
it is a pure counter for how many bitmap chunks we allocated, so maybe
"unsigned long" or "uint64_t" would suite more?

Though I'd think "unsigned int" is good enough per the calculation Stefan
provided.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


