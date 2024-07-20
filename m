Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E10C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 14:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVBI6-00089n-IF; Sat, 20 Jul 2024 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVBHy-000899-SG
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:42:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVBHw-0007zP-J1
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:42:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70b1808dee9so1216202b3a.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721486539; x=1722091339;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DwPAuo/7rz2gW8o4CO78MQtw/IJxJKFvi/JhEDhcpWs=;
 b=y/sdHk7uxHJunTgb6vZ8UzximeZFhMUSxlbZgxn6oguOTLYuFDEMWNYBTmvFZzPBW3
 P4yI63576+KYd5ICbAvrIikycFrntLEutxWqYxPIPxqsWVv0hcn7Anc6PlKCFgBPdfX7
 ws5Jz/TT90G4j7gDnf9L2JgWq5IiBsYyzqYbEYlJdMHm+dyxE2NrlNnZ7y40Q5TyGdHM
 3mzuSNYedYLQ272m8facAPEa27gaBKyKAh4EEZelyxy5flFfF/IsdESNyoQW1aEjRxDT
 HTFAUeBg78Rzg7JzYNBMlENq2966XNp4RZJO7UqlB5UtRMEUkPMak5q6y7sH6jZ1l6jd
 W0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721486539; x=1722091339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DwPAuo/7rz2gW8o4CO78MQtw/IJxJKFvi/JhEDhcpWs=;
 b=oDeUEau+SVTy7/rb4kYdT5aLJ2EiwDXqAkLjsIoOddFA1EVifEJxG+ma2sBxNHlR//
 wfcogorbK/estlQNefJyyjf9mhZDKUM05dq1Opdk1c7d0Xft+UwO6Nb+v387CWMdEhyl
 LhEKQX5mh3CChrnPWPkDzU3epJu6hsASPIu9eXDkLkGBaap9aGNXq7cFyXDSJn2r+iwR
 7Rvys/674wu4ky4ZfIFcQkDoN0s1A21aNJt4I33W0CPFE+2rcG9EYnXsLuYxmkTwwz5s
 nEAELawfy40uWv24rNfg5ysqwwiZFbMz/R7FrQZMpfgPa5bhEHqj3lZ41nFgV07SRgsW
 +3aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgcJeBa+Z9iiHdc8q/S0nkw8ZKJLEIXtUtx/1zt5HTH/5qp/RJAlwoynQV448iBgHAdm4tll4XTBXJbBm7YKs03K0ECV4=
X-Gm-Message-State: AOJu0YwenZoe9kn+gDPCzgB/ytmOgsRKUFkpjT+oFadh6JLuDnXvBXh3
 oO8NKLCGujcKzSj2iU6tChr0qlMRdYX0k9okrHC2krF5ky1IB3raIHBe+6ZOrCbM/lIZaYmoU+s
 KDpA=
X-Google-Smtp-Source: AGHT+IGk9LV9bAjObySsxGjx0EEWEN/RygHhST7VOFhAkRP72h9HtmfdlFTLFBg+lN8zxNZ17JzA0w==
X-Received: by 2002:a05:6a00:148d:b0:706:6f18:839d with SMTP id
 d2e1a72fcca58-70d0f0ae1a6mr933228b3a.14.1721486539129; 
 Sat, 20 Jul 2024 07:42:19 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff49152esm2703066b3a.20.2024.07.20.07.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 07:42:18 -0700 (PDT)
Message-ID: <7c545db7-1899-49a9-82ba-967f9e0a9000@daynix.com>
Date: Sat, 20 Jul 2024 23:42:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] hw/display/apple-gfx: New macOS PV Graphics device
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20240717110326.45230-1-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240717110326.45230-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/17 20:03, Phil Dennis-Jordan wrote:
> This sequence of patches integrates the paravirtualised graphics device
> implemented by macOS's ParavirtualizedGraphics.Framework into Qemu.
> Combined with the guest drivers which ship with macOS versions 11 and up,
> this allows the guest OS to use the host's GPU for hardware accelerated
> 3D graphics, GPGPU compute (both using the 'Metal' graphics API), and
> window compositing.
> 
> Some background:
> ----------------
> 
> The device exposed by the ParavirtualizedGraphics.Framework's (henceforth
> PVG) public API consists of a PCI device with a single memory-mapped BAR;
> the VMM is expected to pass reads and writes through to the framework, and
> to forward interrupts emenating from it to the guest VM.
> 
> The bulk of data exchange between host and guest occurs via shared memory,
> however. For this purpose, PVG makes callbacks to VMM code for allocating,
> mapping, unmapping, and deallocating "task" memory ranges. Each task
> represents a contiguous host virtual address range, and PVG expects the
> VMM to map specific guest system memory ranges to these host addresses via
> subsequent map callbacks. Multiple tasks can exist at a time, each with
> many mappings.
> 
> Data is exchanged via an undocumented, Apple-proprietary protocol. The
> PVG API only acts as a facilitator for establishing the communication
> mechanism. This is perhaps not ideal, and among other things means it
> only works on macOS hosts, but it's the only serious option we've got for
> good performance and quality graphics with macOS guests at this time.
> 
> The first iterations of this PVG integration into Qemu were developed
> by Alexander Graf as part of his "vmapple" machine patch series for
> supporting aarch64 macOS guests, and posted to qemu-devel in June and
> August 2023:
> 
> https://lore.kernel.org/all/20230830161425.91946-1-graf@amazon.com/T/
> 
> This integration mimics the "vmapple"/"apple-gfx" variant of the PVG device
> used by Apple's own VMM, Virtualization.framework. This variant does not use
> PCI but acts as a direct MMIO system device; there are two MMIO ranges, one
> behaving identically to the PCI BAR, while the other's functionality is
> exposed by private APIs in the PVG framework. It is only available on aarch64
> macOS hosts.
> 
> I had prior to this simultaneously and independently developed my own PVG
> integration for Qemu using the public PCI device APIs, with x86-64 and
> corresponding macOS guests and hosts as the target. After some months of
> use in production, I was slowly reviewing the code and readying it for
> upstreaming around the time Alexander posted his vmapple patches.
> 
> I ended up reviewing the vmapple PVG code in detail; I identified a number
> of issues with it (mainly thanks to my prior trial-and-error working with
> the framework) but overall I thought it a better basis for refinement
> than my own version:
> 
>   - It implemented the vmapple variant of the device. I thought it better to
>     port the part I understood well (PCI variant) to this than trying to port
>     the part I didn't understand well (MMIO vmapple variant) to my own code.
>   - The code was already tidier than my own.
> 
> It also became clear in out-of-band communication that Alexander would
> probably not end up having the time to see the patch through to inclusion,
> and was happy for me to start making changes and to integrate my PCI code.

I think you also need to take over the base vmapple change because PVG 
cannot be tested without it; Only macOS can use PVG, and macOS requires 
vmapple in my understanding.

Regards,
Akihiko Odaki

