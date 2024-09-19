Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D4ECF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srM9l-0000dq-Nr; Thu, 19 Sep 2024 14:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srM9j-0000cY-WC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srM9e-00085n-NW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726771525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NOOPSwgBmptuEr8Xcr2EN/01UHX9UtE7SlfEgvtAAE=;
 b=XjFdTAkH6N//JnKxnQzidvuRsKNCZadht5oZv/lFAK+E/zM7FZuBiELqnxqxkKAczh7+Xh
 +mDWjHukLuEcyQjPr1KfiiPcdkJ82s3SU266q/teeTqwzV0derk+UaZAqaRUP0xWGhV/1f
 V7GTixWnJhJEEC7tWtNgAwMzxP1H6X4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Lc_uzdRhOEqrnRXx6Mo5ZA-1; Thu, 19 Sep 2024 14:45:23 -0400
X-MC-Unique: Lc_uzdRhOEqrnRXx6Mo5ZA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7d4dee4dfdcso1329008a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 11:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726771523; x=1727376323;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0NOOPSwgBmptuEr8Xcr2EN/01UHX9UtE7SlfEgvtAAE=;
 b=TDOB+yfMO3Hvzi2PpSucj6GC6fm6iVh5gCbHnNFbUnfgLcP68ld3gbZ0oK+5DszJpq
 RzdIw4jXJ12LImkqR12c9CfV8NGBrHJL27KcjzIbaHVdhCpXK+8b76uDYA5hPJ/lbUxc
 tVmP2dgZLLe9uuj2Fo2PbNLv1vFAEpq1Rlcu0zJ8lbNJmO5eFmLZ7kpufQLnwhgwzuhd
 SXg6UOkDjCh/42l1aOuu5JIaGX9oJIIi8gEOTQBjVzSpxf/ZkDtK13cPolnJ/Z8ROqTe
 ZTNwFdXx/HSCmI93KNpNtaqnIBMfmQWL6agA1ztE0XCZNmNc+Zqio2qa55xWc3oTjWxB
 4N7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Gwq/ceoQQmYs7cFQVKLXjJ3B8oGqNL0Eew4mXK0Pl0X1CHYs6dMyWnOx9ebgqF3Bl32Bx8d0EJeh@nongnu.org
X-Gm-Message-State: AOJu0YwMkiymH6/on1NeXHHGAc66lf39FYSdunHSO+KupT8GQj0zfymq
 WqmNfEAWjOxt3tAMHeV7iOLYUdxohaUI9xHZg9az0xPHA/M9p7gzQe4fpsNk80S7YgO/nJjOeaJ
 Iz63mV4zuWsELyKlXFeyLZhsdCqMYAqSLS/XYYaj4G+GBpIATr5c9
X-Received: by 2002:a17:90a:3da3:b0:2d8:6f73:55a with SMTP id
 98e67ed59e1d1-2dd7f6c1852mr440660a91.25.1726771522723; 
 Thu, 19 Sep 2024 11:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKjPtFak4af+kRUqfoqhA6iXJMhmt9S4HLYKIxuhPoFK7jku9rTH+3E/SBVpDJX3fluhe2HQ==
X-Received: by 2002:a17:90a:3da3:b0:2d8:6f73:55a with SMTP id
 98e67ed59e1d1-2dd7f6c1852mr440644a91.25.1726771522412; 
 Thu, 19 Sep 2024 11:45:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd6ee7bffcsm2308567a91.8.2024.09.19.11.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 11:45:21 -0700 (PDT)
Date: Thu, 19 Sep 2024 14:45:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
Message-ID: <ZuxxOObKqS_G0Ela@x1n>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 17, 2024 at 02:48:03PM +0800, Yong Huang wrote:
> On Tue, Sep 17, 2024 at 5:11 AM Fabiano Rosas <farosas@suse.de> wrote:
> 
> > Hyman Huang <yong.huang@smartx.com> writes:
> >
> > > shadow_bmap, iter_bmap and iter_dirty_pages are introduced
> > > to satisfy the need for background sync.
> > >
> > > Meanwhile, introduce enumeration of sync method.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >  include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++++++++
> > >  migration/ram.c         |  6 ++++++
> > >  2 files changed, 51 insertions(+)
> > >
> > > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > > index 0babd105c0..0e327bc0ae 100644
> > > --- a/include/exec/ramblock.h
> > > +++ b/include/exec/ramblock.h
> > > @@ -24,6 +24,30 @@
> > >  #include "qemu/rcu.h"
> > >  #include "exec/ramlist.h"
> > >
> > > +/* Possible bits for cpu_physical_memory_sync_dirty_bitmap */
> > > +
> > > +/*
> > > + * The old-fashioned sync, which is, in turn, used for CPU
> > > + * throttle and memory transfer.
> >
> 
> Using the traditional sync method, the page sending logic iterates
> the "bmap" to transfer dirty pages while the CPU throttle logic
> counts the amount of new dirty pages and detects convergence.
> There are two uses for "bmap".
> 
> Using the modern sync method, "bmap" is used for transfer
> dirty pages and "iter_bmap" is used to track new dirty pages.
> 
> 
> > I'm not sure I follow what "in turn" is supposed to mean in this
> > sentence. Could you clarify?
> >
> 
> Here I want to express "in sequence".  But failed obviously. :(
> 
> 
> >
> > > + */
> > > +#define RAMBLOCK_SYN_LEGACY_ITER   (1U << 0)
> >
> > So ITER is as opposed to background? I'm a bit confused with the terms.
> >
> 
> Yes.
> 
> 
> >
> > > +
> > > +/*
> > > + * The modern sync, which is, in turn, used for CPU throttle
> > > + * and memory transfer.
> > > + */
> > > +#define RAMBLOCK_SYN_MODERN_ITER   (1U << 1)
> > > +
> > > +/* The modern sync, which is used for CPU throttle only */
> > > +#define RAMBLOCK_SYN_MODERN_BACKGROUND    (1U << 2)
> >
> > What's the plan for the "legacy" part? To be removed soon? Do we want to
> > remove it now? Maybe better to not use the modern/legacy terms unless we
> > want to give the impression that the legacy one is discontinued.
> >
> 
> The bitmap they utilized to track the dirty page information was the
> distinction between the "legacy iteration" and the "modern iteration."
> The "iter_bmap" field is used by the "modern iteration" while the "bmap"
> field is used by the "legacy iteration."
> 
> Since the refinement is now transparent and there is no API available to
> change the sync method, I actually want to remove it right now in order
> to simplify the logic. I'll include it in the next version.

How confident do we think the new way is better than the old?

If it'll be 100% / always better, I agree we can consider removing the old.
But is it always better?  At least it consumes much more resources..

Otherwise, we can still leave that logic as-is but use a migration property
to turn it on only on new machines I think.

Besides, could you explain why the solution needs to be this complex?  My
previous question was that we sync dirty too less, while auto converge
relies on dirty information, so that means auto converge can be adjusted
too unfrequently.

However I wonder whether that can be achieved in a simpler manner by
e.g. invoke migration_bitmap_sync_precopy() more frequently during
migration, for example, in ram_save_iterate() - not every time but the
iterate() is invoked much more frequent, and maybe we can do sync from time
to time.

I also don't see why we need a separate thread, plus two new bitmaps, to
achieve this..  I didn't read in-depth yet, but I thought dirty sync
requires bql anyway, then I don't yet understand why the two bitmaps are
required.  If the bitmaps are introduced in the 1st patch, IMO it'll be
great to explain clearly on why they're needed here.

Thanks,

-- 
Peter Xu


