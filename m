Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8DDE77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMqD-0000it-SB; Thu, 05 Dec 2024 20:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMqB-0000ij-Uu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:09:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMqA-0001bM-5W
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 20:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733447343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1Mtxxgqg6jVzoxPtxm+RoTFopkEEAxe5lJjlIDGmkE=;
 b=E/2sftWkWXXEOgeXd1t/PKjd17qXY/oHInWBFMEqfkjP5NPN/90QGe7P3zdQXbniYmjxYV
 STlaVCQ6h2TbZFnMh6a/epeIV0NMDwYsTk6WKeeto+VdKM/EgxigtwtzbjpdFX+krDC1I4
 G0CbKO8VV3zRxbKC/qbisMa7v/CIo34=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ylH7h2MxMFK6gPzM1wSzXQ-1; Thu, 05 Dec 2024 20:08:58 -0500
X-MC-Unique: ylH7h2MxMFK6gPzM1wSzXQ-1
X-Mimecast-MFC-AGG-ID: ylH7h2MxMFK6gPzM1wSzXQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-466911d43f4so30484041cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 17:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733447337; x=1734052137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1Mtxxgqg6jVzoxPtxm+RoTFopkEEAxe5lJjlIDGmkE=;
 b=CRyRORa71t714f3BjtQ3+NLL/kg4zhcngIQeLXkADqqcLWOQExFMxkN/foI0vBp0xB
 h8ZX3Mo/qhrbc2t0zbTH6g0Tcw5TNu+XP9sejkzO0p+7eIF8FycWM0k+mcNHSg6S/O4A
 pb5F9GC0x+ia96o3k2k7558HPTVF/7F7PHzoueqVkzBRF+R2pKrbRBoI/Ge1/uKH6BL/
 ubhQLvo9rJkJfN8M+6hL2XuI4kGqBdEbRhqPcRrhM+adzXCohOq2inIUh60TCPSPFdwh
 feDga56fEQe5TGJd0RaO/o7wWi9zPJ3bgCoyJoclgtCtzWC/EZSxco3M9m3jJsFscLoB
 0C9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGm5/8GOkLBxbWs4nIrPN5MY9uX0mSD96mBV5yYHk60HtF5TIv+NC1FA4a9HaSL2SILvLVJ2hV3mIH@nongnu.org
X-Gm-Message-State: AOJu0Yxl2FbePXgE5axZ+ADK/CUmqhzYgE+3jRTRnyoxhpvjyyjBA1a7
 v1svZjs1bBraimq+uWXfXvlKeavN+HHkuCDBaIGGi6AGde+pZjAe887fveG2aeX/P30zgepbxuD
 2T5/PdcAtSSTnLzoNiIzbsLp8CfYtAsrV5Oow8PpO0R3dJ9EymHeh
X-Gm-Gg: ASbGncsuw7t7+ejla9C/w163wJD5JUvAtJ30LDXth8eH2YRB12LBUYfsEMB0DlYq7VL
 WqU0DX5EHyxMAhVynUvx1y9EBHqvTiM1pHOSFzthdQqFtR6Nc2L7OzNgcq+gKxvW2AXaeaQxEvA
 DzRgITPku0Ws2MAYex6fc9lSDyrvkNdzTh+s7S8L4gTvvf/SK6vYIN+y298St04xy3Ru1BLDFyF
 LOJnY/RB6mejv3V5f4vJCESZZBkBrdTz1/cgPCD1pFs5p4V36ilLbtGK/WtpBU3U+ifJd13Ra00
 3PsjhKS2Aws=
X-Received: by 2002:a05:622a:1b94:b0:461:17e6:264d with SMTP id
 d75a77b69052e-46734ca3879mr23361831cf.8.1733447336719; 
 Thu, 05 Dec 2024 17:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHajZg/1LyThU5/W6ba+NW79s7yC26qzIW59i/dGBVh6WGF+HEaa8cJwPwCe0p8D3wNwk42GA==
X-Received: by 2002:a05:622a:1b94:b0:461:17e6:264d with SMTP id
 d75a77b69052e-46734ca3879mr23361531cf.8.1733447336372; 
 Thu, 05 Dec 2024 17:08:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297c23fdsm14363121cf.79.2024.12.05.17.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 17:08:55 -0800 (PST)
Date: Thu, 5 Dec 2024 20:08:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
Message-ID: <Z1JOpadES2iV_i0v@x1n>
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Dec 06, 2024 at 02:19:06AM +0300, Daniil Tatianin wrote:
> Currently, passing mem-lock=on to QEMU causes memory usage to grow by
> huge amounts:
> 
> no memlock:
>     $ qemu-system-x86_64 -overcommit mem-lock=off
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     45652
> 
>     $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     39756
> 
> memlock:
>     $ qemu-system-x86_64 -overcommit mem-lock=on
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     1309876
> 
>     $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     259956
> 
> This is caused by the fact that mlockall(2) automatically
> write-faults every existing and future anonymous mappings in the
> process right away.
> 
> One of the reasons to enable mem-lock is to protect a QEMU process'
> pages from being compacted and migrated by kcompactd (which does so
> by messing with a live process page tables causing thousands of TLB
> flush IPIs per second) basically stealing all guest time while it's
> active.
> 
> mem-lock=on helps against this (given compact_unevictable_allowed is 0),
> but the memory overhead it introduces is an undesirable side effect,
> which we can completely avoid by passing MCL_ONFAULT to mlockall, which
> is what this series allows to do with a new command line option called
> mem-lock-onfault.

IMHO it'll be always helpful to dig and provide information on why such
difference existed.  E.g. guest mem should normally be the major mem sink
and that definitely won't be affected by either ON_FAULT or not.

I had a quick look explicitly on tcg (as that really surprised me a bit..).
When you look at the mappings there's 1G constant shmem map that always got
locked and populated.

It turns out to be tcg's jit buffer, alloc_code_gen_buffer_splitwx_memfd:

    buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
    if (buf_rw == NULL) {
        goto fail;
    }

    buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
    if (buf_rx == MAP_FAILED) {
        error_setg_errno(errp, errno,
                         "failed to map shared memory for execute");
        goto fail;
    }

Looks like that's the major reason why tcg has mlockall bloated constantly
with roughly 1G size - that seems to be from tcg_init_machine().  I didn't
check kvm.

Logically having a on-fault option won't ever hurt, so probably not an
issue to have it anyway.  Still, share my finding above, as IIUC that's
mostly why it was bloated for tcg, so maybe there're other options too.

> 
> memlock-onfault:
>     $ qemu-system-x86_64 -overcommit mem-lock-onfault=on
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     54004
> 
>     $ ./qemu-system-x86_64 -overcommit mem-lock-onfault=on -enable-kvm
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     47772
> 
> You may notice the memory usage is still slightly higher, in this case
> by a few megabytes over the mem-lock=off case. I was able to trace this
> down to a bug in the linux kernel with MCL_ONFAULT not being honored for
> the early process heap (with brk(2) etc.) so it is still write-faulted in
> this case, but it's still way less than it was with just the mem-lock=on.
> 
> Daniil Tatianin (2):
>   os: add an ability to lock memory on_fault
>   overcommit: introduce mem-lock-onfault
> 
>  include/sysemu/os-posix.h |  2 +-
>  include/sysemu/os-win32.h |  3 ++-
>  include/sysemu/sysemu.h   |  1 +
>  migration/postcopy-ram.c  |  4 ++--
>  os-posix.c                | 10 ++++++++--
>  qemu-options.hx           | 13 ++++++++++---
>  system/globals.c          |  1 +
>  system/vl.c               | 18 ++++++++++++++++--
>  8 files changed, 41 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

-- 
Peter Xu


