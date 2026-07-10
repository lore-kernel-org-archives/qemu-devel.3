Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8D5C4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAk5-0002TX-4j; Fri, 10 Jul 2026 08:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1wiAk3-0002TG-Gu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1wiAk1-0004ss-G1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783688044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Cp1BjII0FuKVOdJwcODOGG4IVFWnhrJeFpeInpRWrU=;
 b=BV+rcCOEMzSrs7vK+jzKtHieZCfqGWJjs4d33u2YDwTQAqIGNnqIrUgdLVAH+aINBl77++
 pIhm6Dl48syreq33AaOiSRR8EHZg1F/WeXCUFhULa3pXDWcQgNNaT+Mvly+ZayL8/REWfx
 SHYOuWpSdfUyYiIiUG4Tbepf+i20B5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-6XQiJn7IOnSz9R9Lv6gHHg-1; Fri, 10 Jul 2026 08:52:58 -0400
X-MC-Unique: 6XQiJn7IOnSz9R9Lv6gHHg-1
X-Mimecast-MFC-AGG-ID: 6XQiJn7IOnSz9R9Lv6gHHg_1783687977
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so6196905e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783687977; x=1784292777; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Cp1BjII0FuKVOdJwcODOGG4IVFWnhrJeFpeInpRWrU=;
 b=eQLwj5OqYCfCoBiMGZC6PyEoTF4TYFxoRwgF8oJqB1fgT+WwD6NDueDHNanOZPIEUL
 ciIXt3C2v3955dXJwvLFAjquY3rMH4uCd4wI65VLOwusNhcGw03tRMrFWAUriwviR5Ma
 l8QtVhWHpXfuNAr2W6sTfMipUH49pGIl83nPrVe1UfB2NO9fldd6AudOeyT0nFtbVorS
 mNEZy0YKN41zXjb7lYja/+tOrKMO2Nv0jlL1MPlUXznAKaQfFuFToPL8XmQHSImwN4ys
 uUZYBdxaJGcJGTMdff9UUz3PFISw8hhEQcmVxCgGaVyD2sxs2ADUJ325689WVY4/N11S
 PV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783687977; x=1784292777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Cp1BjII0FuKVOdJwcODOGG4IVFWnhrJeFpeInpRWrU=;
 b=BkVatagU84NxUPwCLyWwGNZruWmscLLeb7TuImm59NNfwiWWuoURKI1WGDSWeHL/7O
 3n14CCsl0nFRimT6fbwI4lvXdttaf4LAVapCiJCRhSGf38UJ4EH72rGZtTHVGIf98Wzb
 T9pmV9DsSTLv7uy6z4RTgmpvpmd1Aoz0ZbpUSi0yis7PhyzyDRKR42N1IhxLGcJTbwtY
 VVWOWAhbSAi77X7uy9x+lLoHxybRNcGd1SSGH/Iy9RH+x1iizPpJcE/TRgCr8f9Qdhxo
 ZVi4hN3SMLcTQs0SROHYVweCsk2CZwZFbkkFZvV+D2b4iil02fh1VF2WXXampWvxIYKQ
 vIZg==
X-Gm-Message-State: AOJu0Yx1r6tVfQD0oFS81fZnnhrjZDpGnFpLT9XTc9J9zqpCkkLYUbEk
 T+HbIqIYyEwLlMg/ZKrgimw5kseRa5JqtoHaRKM9WOz+X8mRCD6pm+Zm/yo864DL+KDvakAmV4X
 F0fm7yy51X7W5GvYZA+cbDOad9XyAz/50DChjUUyOwUD5enP7bbgHAK/1KU0oUs0k
X-Gm-Gg: AfdE7clbI/1N8esdorrTxh/95gvrwn49gYEfDarDieWdopbQoJ/EWxUBl4Jc/zT7P9q
 kNJ1I6NRcj178fBmes7a64XoECXerMIAxmMvC5bWU5UmBQQxin+jB+0mr11WSLk0QEtqhr3XYYm
 e6Y//uDbQRJZGTtQOrUmT0o4IAqYRTDeuREgQ7TS1XUwXoniSvqWz1fI5Q9AHbBN5YZSkrRr+XU
 pgRQsRVhHdl56Cq094vf39tCDcurINX6ssZof+Rs5nZEbgHudbLRB+rZq8Qqo6pQZDO0bPFzmoD
 6K2d1NBxmyRi5NG/cp072I6dq1CrCW0JXZl5UZchLd+qIn2N7LEeZm00VWGz8UyajcIz2zxexRN
 0V3Wk
X-Received: by 2002:a05:600d:8496:20b0:493:ae5d:8c40 with SMTP id
 5b1f17b1804b1-493e68e9ff7mr81865625e9.27.1783687976858; 
 Fri, 10 Jul 2026 05:52:56 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:20b0:493:ae5d:8c40 with SMTP id
 5b1f17b1804b1-493e68e9ff7mr81865395e9.27.1783687976405; 
 Fri, 10 Jul 2026 05:52:56 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d53absm134675665e9.6.2026.07.10.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:52:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:52:54 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
Message-ID: <alDrJiFzJsf04RFT@fedora>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jul 04, 2026 at 03:37:21PM +0200, Anatol Belski wrote:
> Hi,
> 
> I would like to share virtio-villain, a guest side fault injection
> harness for virtio device models. The repository is at
> https://github.com/weltling/virtio-villain
> 
> Comments on the approach, the coverage so far, and test cases worth
> adding are all welcome. While the tool targets multiple hypervisors,
> QEMU support is active and has already surfaced a few initial bugs.
> 
> Threat model. The harness operates under the hostile guest model. A
> malicious or buggy guest driver violates the virtio protocol on
> purpose. It targets the modern 1.2+ interface only. The test binary
> runs as init inside a minimal initramfs, bypasses the kernel virtio
> drivers with initcall_blacklist, walks the PCI capability list
> itself, programs the queues by hand, and asserts on the exact spec
> mandated values. Each test violates one driver MUST rule and checks
> that the host VMM process handles it gracefully without crashing,
> wedging, or corrupting state.
> 
> Scope and status. The primary target so far is Cloud Hypervisor,
> which accounts for most of the findings to date. Testing focuses on
> the amd64 and aarch64 architectures. QEMU is supported as a PCI host
> and as the microvm MMIO host. Differential testing across VMMs,
> running the same suite and comparing outcomes, is the roadmap. This
> is a spec violation fault injection tool that surfaces unvalidated
> input handling rather than an exploit framework, so no CVEs have
> been issued.
> 
Thanks for sharing it. I am also interesting on finding violations of
the virtio specification. I presented something two years ago in LPC
(see https://lpc.events/event/18/contributions/1897/). As a result of
that work, we worked adding kani proofs in rust-vmm devices. The
validation of the spec is coded in RUST and by using kani we verify that
the implemented devices follows the specification. For some
requirements, we were able to prove that the device is conform. The
proofs are written together with the implementation of the device like
tests.  

> What is already covered. There are two transports, modern virtio PCI
> and virtio MMIO via the QEMU microvm machine type. A dozen device
> categories are present. They include net, block with zoned support,
> console, entropy, balloon, vsock, virtio-fs, IOMMU, virtio-mem,
> virtio-pmem, RTC, and watchdog, plus the admin queue and the split
> and packed virtqueue layers. Test cases derive from the virtio spec
> normative text, each tied to a specific section.
> 
> Beyond the static suite there are two extra layers.
> 
>   - Host coordinated sidecars. A test can ship a small Python file
>     that drives the host, for example pause, snapshot, hot plug, or
>     config change, while the guest makes a precise assertion the
>     kernel driver cannot make. As an example, snapshot the VM while
>     the guest sits between two block reads, then assert the used
>     ring drains deterministically on resume.
> 
>   - A coverage guided mutation fuzzer. It encodes a descriptor chain
>     into a 4096 byte blob, patches it into a fuzz guest, boots the
>     VMM, and classifies the result. With a coverage instrumented
>     build it feeds new edges back into the corpus. Crashes are
>     grouped by error class for triage.
> 
> Impact. Many findings have led to substantial improvements in
> virtio spec compliance and stability in Cloud Hypervisor, from

Feel free to file patches to the virtio specification in cases you think
the spec is too permissive. 

> input validation gaps to a config read that could take down a VM
> on aarch64. In QEMU the harness has surfaced a few guest triggered

At some point, I wanted to add some checks in QEMU to inform user when
guest violates the spec. That would help to catch some issues with less
testing. For example, two years ago the virtio-sound driver was silently
violating the spec by writing the content of the buffers that were
already in the available ring. 

> hangs and a double completion. The repository README lists the
> details with PR links and the test ID for each.
> 
> Thanks for reading.
> 
> Anatol Belski
> 


