Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B801C0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 16:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb078-0005br-BX; Thu, 23 Jan 2025 11:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb074-0005aw-0e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb071-0003rX-Ee
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737649881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1DYv4w8zQZT6U8R0Bhl214YCyVWA/VEvMoYZ/665Mc=;
 b=Ds9vNA1ScuVM/QNLSmVurzeqZjvPc5inwzu1Jd1e7ELJHfYKa/T5dmGxPBnMl23tlSh14Q
 ryiuZB/TNCf2VEjFmBAZAoEavY/gnlulmBXSSGybS7T6jTkjjSyZ2B6b7mMxYJTOF6fOqF
 FCo24MqUGuKq+8fs5BC0biUOPoREKBE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-jEuoRb0uMUC8Nf867CDbOA-1; Thu, 23 Jan 2025 11:31:18 -0500
X-MC-Unique: jEuoRb0uMUC8Nf867CDbOA-1
X-Mimecast-MFC-AGG-ID: jEuoRb0uMUC8Nf867CDbOA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b7477f005eso243206985a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 08:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737649878; x=1738254678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1DYv4w8zQZT6U8R0Bhl214YCyVWA/VEvMoYZ/665Mc=;
 b=csF67ni+qOrna1bADrNPSnN1GjNbCoppL2WSeLswLOwu+IrfjCsaMmDIdmXmPoUwRo
 xnbLydQxSwIWNaQeeJAkt1a9kDTcNxy+LVJ53cUnPmqaES9BD+n1/9za44+JNCQdr03s
 XEf1eVzUMOPR2nV+1L50wlehWRcBddkmlJo61aa2E+s8TfMgIBjlHF/BeQOgWIWgRX4Y
 B83eMjo+EzZ6kbIFNI5lOWko7IG2opKfp8mEmW+UsagIyvbDo/r6Iaa5G+74Rkd/txvb
 ugPFYJwwJmjMgDYWTHiOrUz4Lp5RIgQafhvHwc5waIX7vloDYgTjykX8MZXiFSGslRiQ
 r9Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmCAGVdWM51LwF7fPCIK+wXdkH9mFqAYq3PMt3ERqAH8Adeerbk9FH2w4mATbclqVvBaanihK3P0q5@nongnu.org
X-Gm-Message-State: AOJu0YyA8bJwE5sBQIdOyNWOPqkwzC3nnSdCXIs67rqZCEmjy8YM6XBF
 iS9uDIQFkUehx+49VKvhYhXjyBDFEi+ATQzAJR+lUWh1EDG3j00s6p/R0bCybYLA+5s/5zxAV4K
 4jhdpBil/9qBeTENHHqg0yoxArssJtrfrlHvFIiieqGQNYFKrF6sV
X-Gm-Gg: ASbGncuaNF0yb/Edqc2RiGPSw6QegenHMn4lOHbSqbdL6P3wN87gEaKcYw2YzT2KCZJ
 drmm39llEbfguijuqa2OoLw7XJJGN5ogC3emb6YapshM8/Fjf4jYYnNwnFhNH+t84f+Mau8M/gK
 D0qdG8hxvjf6UFJ57gW/7DGFVTDBDYrG5RJ1dXGwO7sPTbITAXxc1T4jM7nAU6uckocBOqHzJwj
 E4/8WSepHkZyY1ziudPlAsCx3OCzfXqKztPv9OvzhrTCxJ0XX7pjJH5QIzRPpRAf1i1qbr/8Xgc
 VSoU4pWVzGxkzxIq82T37ZnIKHnIn70=
X-Received: by 2002:a05:620a:601a:b0:7b6:f1be:4f7e with SMTP id
 af79cd13be357-7be6320bd00mr4045797585a.26.1737649877966; 
 Thu, 23 Jan 2025 08:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFccdTl99KrmqxOf5Xs+ndxLWK8PuavQNR09viJ6etdhXhytQkGNDQA/eDGTiJf/ukHvr7CfQ==
X-Received: by 2002:a05:620a:601a:b0:7b6:f1be:4f7e with SMTP id
 af79cd13be357-7be6320bd00mr4045793185a.26.1737649877652; 
 Thu, 23 Jan 2025 08:31:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae8aa1bsm1187985a.35.2025.01.23.08.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 08:31:16 -0800 (PST)
Date: Thu, 23 Jan 2025 11:31:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/4] overcommit: introduce mem-lock-onfault
Message-ID: <Z5Ju0ZnR6KEEF-Bu@x1n>
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 23, 2025 at 04:19:40PM +0300, Daniil Tatianin wrote:
> Currently, passing mem-lock=on to QEMU causes memory usage to grow by
> huge amounts:
> 
> no memlock:
>     $ ./qemu-system-x86_64 -overcommit mem-lock=off
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     45652
> 
>     $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     39756
> 
> memlock:
>     $ ./qemu-system-x86_64 -overcommit mem-lock=on
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
> is what this series allows to do with a new option for mem-lock called
> on-fault.
> 
> memlock-onfault:
>     $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     54004
> 
>     $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault -enable-kvm
>     $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
>     47772
> 
> You may notice the memory usage is still slightly higher, in this case
> by a few megabytes over the mem-lock=off case. I was able to trace this
> down to a bug in the linux kernel with MCL_ONFAULT not being honored for
> the early process heap (with brk(2) etc.) so it is still write-faulted in
> this case, but it's still way less than it was with just the mem-lock=on.
> 
> Changes since v1:
>     - Don't make a separate mem-lock-onfault, add an on-fault option to mem-lock instead
> 
> Changes since v2:
>     - Move overcommit option parsing out of line
>     - Make enable_mlock an enum instead
> 
> Changes since v3:
>     - Rebase to latest master due to the recent sysemu -> system renames
> 
> Daniil Tatianin (4):
>   os: add an ability to lock memory on_fault
>   system/vl: extract overcommit option parsing into a helper
>   system: introduce a new MlockState enum
>   overcommit: introduce mem-lock=on-fault
> 
>  hw/virtio/virtio-mem.c    |  2 +-
>  include/system/os-posix.h |  2 +-
>  include/system/os-win32.h |  3 ++-
>  include/system/system.h   | 12 ++++++++-
>  migration/postcopy-ram.c  |  4 +--
>  os-posix.c                | 10 ++++++--
>  qemu-options.hx           | 14 +++++++----
>  system/globals.c          | 12 ++++++++-
>  system/vl.c               | 52 +++++++++++++++++++++++++++++++--------
>  9 files changed, 87 insertions(+), 24 deletions(-)

Considering it's very mem relevant change and looks pretty benign.. I can
pick this if nobody disagrees (or beats me to it, which I'd appreciate).

I'll also provide at least one week for people to stop me.

Thanks,

-- 
Peter Xu


