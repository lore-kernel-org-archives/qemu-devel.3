Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA5DD3E77B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 19:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTQ7d-0001Jd-Th; Wed, 10 Dec 2025 14:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQ7b-0001JA-Li
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 14:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQ7Y-0001aZ-VR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 14:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765395906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYGEyR9FHcwRPRZ9G4gpquq4iorSfWvfm/IkZwOMdLs=;
 b=imnLapKggnXm4mIKekHrjfoTpKPrZw/ABXp+jLkZTBifjKJCLh07j7xieexlo08tUWuCIW
 M+ua3AsZ9hJ5AY8QyOH383ziiuuImJ5VFMod6BB6YA7v59U13L0cOF6T5fqEbiyAO5qsqu
 znc/j4VbmnHxCPvl4kkA7cXn98me4/A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-X5s6RFd7OK2nZE8AAbcirQ-1; Wed, 10 Dec 2025 14:45:04 -0500
X-MC-Unique: X5s6RFd7OK2nZE8AAbcirQ-1
X-Mimecast-MFC-AGG-ID: X5s6RFd7OK2nZE8AAbcirQ_1765395904
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed79dd4a47so2936421cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 11:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765395904; x=1766000704; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jYGEyR9FHcwRPRZ9G4gpquq4iorSfWvfm/IkZwOMdLs=;
 b=ELLSZUDcOCYgbljG4FVjyZdf2bfChAGDvWRM2GL1JYrEbaJBk0f4/2jJ4FhM5L0GDb
 UlYS7j/4Y03OlamyJR589tEBzNxzpssfkYyKB+l9Fk+EuSEF7Btjs/Hg0Q/H7q1r7N9N
 Kgr/sFPWr4d29MvoCpMx4CtggakHYBrw8KK6vVZk0U4g7e6yNLmLmcrkK8EI8ESu50Xd
 yEX7DIvtT6c4gJa6rLsdJ4694yPE8obLORD1ISzrOZDo+1RJHrAzSbzvIbBiktNHPAU9
 nd/92OIw/syHf5ml56QRGZil2XWKBwwlyAPGyzb8Nr1uSeSlxgd7m0PpjkvI5/LKOiB9
 CWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765395904; x=1766000704;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jYGEyR9FHcwRPRZ9G4gpquq4iorSfWvfm/IkZwOMdLs=;
 b=oachwVY7BSTl5t25jic/Dfx8YzCNcb1X8ehPuyokZfXVaeEnvTx9xpjB5EtNxLGx62
 r3Jjp1bwN+NOQRK7rdeX6WsEN8r9tR/mN39m195LLtLZaiuzO+nJDg8GysGneB0Ggx7L
 3NRcM4sDVJxEQ/fWrBBxPlMjBFd6yzrCAR6ZjZ0ZRPqiKuVtXgfvJ1Ew5AzFXmqtKFVv
 xG0sp54oXXWjAMgK9IWCgMldjuBKzRLEem1ZM1WZLHTaHZzG5wPic4p8yZ5iU6v7smp+
 PwBXrhWCGALqj0DjZd7NAERbcmLYSrrnEVTxMkLt8CPyaQh8tDK4oK1ODeAwvtFBrc5h
 J8SQ==
X-Gm-Message-State: AOJu0Yxa6b/0KTC+GHI4QuCdoZYTlXnr/h2PCzSdqFHQvz0O1WBAWIQ6
 WQeWCMdgN4fEI1sCexb79dXC0WC6C7mTPADoHFM2yqx7nGUamMxESDyp9TgOYcgokLQvulcXZBH
 G93dj488+nZjiNmdNz0Kqr0nRsiGB4tlJ1H3u+yM70qrbLMPu2pLmoODR
X-Gm-Gg: ASbGncvNLoMB5LHqH+P5tT1nDII8M/7xI6wMXopXsjfnDM61/bogq6YEYUJ43Iy4HOA
 MldkpflgrcEaKOe696Q8oIAfo69VebdM8iiWPOR/6WKDrfhbdxQJ+2rSX8HQ4gwafUnEZ+LCm0N
 RcWYPzQTDvcTUZyZEu5PEHYYHXny2tCHmtW9ZFDyXf8vgBca0BAhhZoxvJBapQ8F3zONxxXVxnS
 Ukm4zw/k3X28jlbGlUsb5/vBer6bvWigQmCp+7XPMmykz1MvvZoDTwtNn960le/S8Fbem3wbGyB
 MKa5yVdDYlBdr9/bIpH0hVXndNrNxzvvbYN/tnGz3G5XR4j2iuuUOmAA8wqjl0J3ExxZTtNUGK8
 YKYA=
X-Received: by 2002:a05:622a:5509:b0:4ed:66bd:95ea with SMTP id
 d75a77b69052e-4f1b1a6ee7cmr57803481cf.29.1765395904027; 
 Wed, 10 Dec 2025 11:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/nhTbYpnw6kv2/xQNZGXfgN1XXpilhIgYQaxGQtZ6G12vDrgfSml+671rt0Y2+K8lMsdLSw==
X-Received: by 2002:a05:622a:5509:b0:4ed:66bd:95ea with SMTP id
 d75a77b69052e-4f1b1a6ee7cmr57803121cf.29.1765395903521; 
 Wed, 10 Dec 2025 11:45:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd6e0c3csm2189271cf.23.2025.12.10.11.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 11:45:03 -0800 (PST)
Date: Wed, 10 Dec 2025 14:45:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, david@kernel.org,
 philmd@linaro.org, farosas@suse.de
Subject: Re: [RFC v1 2/2] migration: merge fragmented clear_dirty ioctls
Message-ID: <aTnNvcvHJBvnbExC@x1.local>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
 <20251208120952.37563-3-xuchuangxclwt@bytedance.com>
 <aTiQK-a-ZcANCFbk@x1.local>
 <58c1e3f7-be13-4a2e-a1e6-0a8295d83345@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58c1e3f7-be13-4a2e-a1e6-0a8295d83345@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 10, 2025 at 10:18:21PM +0800, Chuang Xu wrote:
> Hi, Peter
> 
> On 10/12/2025 05:10, Peter Xu wrote:
> > On Mon, Dec 08, 2025 at 08:09:52PM +0800, Chuang Xu wrote:
> >> From: xuchuangxclwt <xuchuangxclwt@bytedance.com>
> >>
> >> When the addresses processed are not aligned, a large number of
> >> clear_dirty ioctl occur (e.g. a 16MB misaligned memory can generate
> >> 4096 clear_dirty ioctls), which increases the time required for
> >> bitmap_sync and makes it more difficult for dirty pages to converge.
> >>
> >> Attempt to merge those fragmented clear_dirty ioctls.
> > (besides separate perf results I requested as in the cover letter reply..)
> >
> > Could you add something into the commit log explaining at least one example
> > that you observe?  E.g. what is the VM setup, how many ramblocks are the
> > ones not aligned?
> >
> > Have you considered setting rb->clear_bmap when it's available?  It'll
> > postpone the remote clear even further until page sent.  Logically it
> > should be more efficient, but it may depend on the size of unaligned
> > ramblocks that you're hitting indeed, as clear_bmap isn't PAGE_SIZE based
> > but it can be much bigger.  Some discussion around this would be nice on
> > how you chose the current solution.
> >
> 
> On my Intel(R) Xeon(R) 6986P-C(previous tests were based on Cascade Lake),
> I add some logs. Here are some examples of unaligned memory I observed:
> size 1966080: system.flash0
> size 131072: /rom@etc/acpi/tables, isa-bios, system.flash1, pc.rom
> size 65536: cirrus_vga.rom
> 
> Taking system.flash0 as an example, judging from its size, this should 
> be the OVMF I'm using.
> This memory segment will trigger clear_dirty in both memory_listener 
> "kvm-memory" and
> memory_listener "kvm-smram" simultaneously, ultimately resulting in a 
> total of 960 kvm_ioctl calls.
> If a larger OVMF is used, this number will obviously worsen.
> 
> On the machine I tested, clear system.flash0 took a total of 49ms,
> and clear all unaligned memory took a total of 61ms.

Thanks for the numbers.  It might be more helpful if you share the other
relevant numbers, e.g. referring to your cover letter definitions,

  - total bitmap sync time (x)
  - iteration transfer time (t)

that'll provide a full picture of how much wasted on per-page log_clear().

You can use those to compare to the clear() operation it took after your
patch applied.  I think that might be a better way to justify the patch.

In general, it looks reasonable to me.

Having a bool parameter for the old physical_memory_test_and_clear_dirty()
is fine but might be slightly error prone for new callers if they set it to
false by accident.

Another way to do it is, since physical_memory_test_and_clear_dirty()
always takes a range, we can pass the bitmap ("dest") into it when
available, then changing the retval to be num_dirty:

  (1) when dest provided, only account it when "dest" bitmap wasn't set
  already

  (2) when dest==NULL, treat all dirty bits into num_dirty

Maybe that'll look better, you can double check.

Looks like patch 1 will be dropped. You can repost this patch alone when
you feel ready whatever way you see fit.

Thanks,

> 
> Regarding why the current solution was chosen, because I'm not sure if 
> there were any
> special considerations in the initial design of clear_dirty_log for not 
> applying unaligned memory paths.
> Therefore, I chose to keep most of the logic the same as the existing one,
> only extracting and merging the actual clear_dirty operations.
> 
> Thanks.
> 

-- 
Peter Xu


