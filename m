Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F18FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOHb-00070X-HL; Mon, 27 Apr 2026 11:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wHOHY-00070D-3n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:54:00 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wHOHW-0005Dm-I8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 11:53:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so6253490a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777305236; x=1777910036; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bs/WIiKT9fGWokLiv82djlu3t8U5ROmRCWW144DG5Pw=;
 b=SEAIjSoi4pnrhgwXHr0eQJlrZudvnAxrhCq1tNfJErWijG4AmPv8W00CQHV4C4v7DL
 zE/TSqkSZJ3rXPc5jSj6Toe/GUmh4vNWdff8iHAYZtCm+W/bRJfD6eIgwEMOBUFMsBHR
 zKZ10goLDvo6apvB4dx5sJM4wLDccza6XxNG/qnZp/TehlTBUHiMI2zwudvCSHwpaFp1
 udBtr7EwxHZnv+1kua3g2aaCZXEC+zgkhSENK8cLtCyQa46Y3hMawJg1+x/aNl9G5FYC
 BlJea62sKo+Jrs9d68ftlNV5rjbw+QYtOaJJ5cJdIT1BTc46g65Jjza2bDxej/u7PH5t
 /BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777305237; x=1777910037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bs/WIiKT9fGWokLiv82djlu3t8U5ROmRCWW144DG5Pw=;
 b=NHdqs/SCdMLN92KbE/HOckN/y7BJwo69zVZZxnBHoVxg+z2G+LWJDrlSt5gve0aYv9
 60CU4C4JWE8PFox7rzO6lQW1gerxfUWNYk4rOJVOw8OoLNj0gf9RYdynzEGqmHHVScvH
 kdObw4Y6rTsFbQ8DBpxoY4yz7HK02iT/u8GrUEAf+ElGHUw3k3A7uQpP0rrm+X/7jGm9
 skEF+ocCBTYtS0vrYHUZ6t8N9rq+tWqUwEngihwDIFXV5GWODqWtdZ2pUxNEsbAgMgHG
 idcCdNZiBp1QZ6//LIb/6BZ5OJNyqb/8pP9g5VCNU0KbkDHFwUDNvK8pKt3/W9nl1fWk
 wlRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e8a5N5EDWO4rINJo/IpRiChr7NSVQvuWEik0FqDigjonuBcPvu87pf1phwFEvrJOZ1BNn7vE+Q7Jc@nongnu.org
X-Gm-Message-State: AOJu0Yy3v9qFU2U/KBNXHe8rc5yC++eJ6NKQSnRXM+oZlW/9QJ/pwcUs
 ZOo3GAAnqf4SeYW3tBBsRo7mYodyHDHwxXIZrYMQvPtA6Fm+dDYKxRKd
X-Gm-Gg: AeBDieuDXMJelRuduY9+CMFnSy2+xM3NrDVeJSRnQGkG/jWZwUUbU0F15J6eeS6dyNp
 IK8TsJKVm7CJwvpdiuoz3HlbptROdRfgwm+gDKAhyV8vGlVx8dso0mkDEztfnH78KJpyRXu8PSG
 Ixgnx7V0FKza/GafOU2Ad5WIr/WHv/r1pS/jfqV+cfN0dNlikfemReTAo17DneLmxzKMWoHKCE/
 RfRbbd9bMTBgDByutKaqrZyNvDKLVFvFXBjh/r+D5Xt2U1eG8FGry/AVw//jui3enTu/oKeYTsK
 1uynagV3xDl3BjBux6GIk77mScmsBGJsTz7bL3PXjlizazJJ27mgFOL+z8F+xX2+6WLHEljvx3F
 4NLBDq6vEQJu3s+6d60jjpUzzbXNp3tc1wiyZhZRA95i/yS8HkwqQSwLSNjSLS5JIdkIlb0T964
 eS4hJtUhAK4OXPh+CwhB+UppOYpvUevbDxkmizqMHRFdfH
X-Received: by 2002:a17:90b:164a:b0:35f:b572:ece3 with SMTP id
 98e67ed59e1d1-361403bd001mr44721973a91.6.1777305236485; 
 Mon, 27 Apr 2026 08:53:56 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141990bb6sm33638182a91.17.2026.04.27.08.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:53:55 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:53:52 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, mst@redhat.com, cohuck@redhat.com
Cc: eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] virtio-rtc: Add basic device support
Message-ID: <ae-GkNZiVNzX1W91@google.com>
References: <20260228182246.700714-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228182246.700714-1-visitorckw@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Sat, Feb 28, 2026 at 06:22:44PM +0000, Kuan-Wei Chiu wrote:
> This patch series introduces initial support for the virtio-rtc device
> (VIRTIO_ID_CLOCK), based on the OASIS virtio-rtc specification.
> 
> This implementation provides a single read-only clock that returns
> the host's QEMU_CLOCK_HOST time in nanoseconds. It handles the
> basic control and read requests necessary for the device to be
> successfully probed and utilized by the upstream Linux virtio_rtc
> driver.
> 
> I have verified this implementation using the virtio_rtc driver from
> the Linux mainline. The device probes successfully, and the host time
> can be correctly read from the guest using the following commands:
> 
>   $ cat /sys/class/rtc/rtc0/time
>   $ cat /sys/class/rtc/rtc0/date
>   $ hwclock -r -f /dev/rtc0

Are there any comments or feedback on this?

Regards,
Kuan-Wei

> 
> Kuan-Wei Chiu (2):
>   standard-headers: Add virtio_rtc.h from Linux 7.0-rc1
>   virtio-rtc: Add basic virtio-rtc support
> 
>  MAINTAINERS                                 |   7 +
>  hw/virtio/Kconfig                           |   5 +
>  hw/virtio/meson.build                       |   2 +
>  hw/virtio/virtio-rtc-pci.c                  |  65 ++++++
>  hw/virtio/virtio-rtc.c                      | 190 ++++++++++++++++
>  include/hw/virtio/virtio-rtc.h              |  22 ++
>  include/standard-headers/linux/virtio_rtc.h | 237 ++++++++++++++++++++
>  7 files changed, 528 insertions(+)
>  create mode 100644 hw/virtio/virtio-rtc-pci.c
>  create mode 100644 hw/virtio/virtio-rtc.c
>  create mode 100644 include/hw/virtio/virtio-rtc.h
>  create mode 100644 include/standard-headers/linux/virtio_rtc.h
> 
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 

