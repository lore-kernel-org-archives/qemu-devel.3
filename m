Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B035CCF258C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLeke-0006Cr-Cz; Wed, 19 Nov 2025 04:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLekY-0006CW-Vy
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:45:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLekW-0004Vx-Qx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:45:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so44177815e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763545515; x=1764150315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvg0fgO2nGcFVRCnfeynzjJEhbZDESto3ylZtQr9q9Q=;
 b=Fr40ayhWNzwW0aP+XDcHc7shRVBuWUw2+HGR4xxfHintLsugHl4k91WjxVhNMoueLx
 Ubm3CskUKQmKJGBaX3EfVfVT9egCLoNkcHThp4CtLqHeobXf/SxSGK8HhaP0q+0OhKP9
 lgU11+ZvgCA/UKoTjUcmEqsnn9wYtxdNdN8yLTRJCUTE7s3rTUKWV9I7R8a32CDPOZBg
 BHmxe/YekRcv6TO6PWbHyv8H5um9AoCmt2W22puy6O2+hBY0EX5jen68I6CBM56l+Nck
 nar1hSfRGBoNgRcqRvUYnpv2N2XdX+rAqpanvKKcO5oPXcClFTsrvNfUICWilwApfVZG
 R7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763545515; x=1764150315;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nvg0fgO2nGcFVRCnfeynzjJEhbZDESto3ylZtQr9q9Q=;
 b=LUSVriTGaPecaq2Fo2e6diu5bar9MGCn6s4mMkbJ3KdJ6NZTiPZrGCPDQla3NnGiz9
 2hckwCHdLVWRwztY/aEjG3li1XinJHHMxLkVc3woMU0AigOJ7xlJ4J/HVDcs5PzS0WxH
 JB6Hm/8j4/mthYfgoqNlZUvOUnynL5eIpjHsh+PG89xfKbqbms/lhpSVxvk0clVyHzMU
 VqkM4Y3IzSvuFlEi/LOr11IMT4VImKePpQYigwqWPMBohmfvK0H/cTIHJUv9h7KU73sR
 yPK0JaTSxFHAfzQbio+iH6fJoAH+jEsQvgFT41DFBJgnW7wb2w8zwUyD/sepGgseZPVy
 pZGw==
X-Gm-Message-State: AOJu0YwU8RLpZ5j8rxVpapoek58EQKEk4WmWzewdt0ecup1n1j80plX7
 vJlN4d1XriLY+nrkv+Ze1O4giRpXl8kJej3tD0BNropqlSMIcsX0tzyJiDESFnmlPBQlGKklgBc
 Kh9HZqTX/YA==
X-Gm-Gg: ASbGncuB/ISzIpI1iwZN1AhAlCaUlzUQUvOd6J9OrQLrGKFI44LZSMp4RmGYw3vNaql
 5sLKEjFtuffVqXyWjp51pLdub6B/m1ZT4Kv88eACno0WDsIrXmzE1r2zqk79nc+aMGeDMoGQCHG
 mD9WWH/+/Xdj1DayS1Kap1KGLFYntt0Xar7Wv18h29aJ0tOTKDlhAgx2ircU5xO1WQg4B62p3yQ
 gRd0rxHT3z5DoXH8LB3SStHVY0OhyZJOA1Rgc+OvdY91arHGsSjfbgTy9JOl7HZd99QFnpF++8T
 6vI7BRgCtEihSNHfSXbA+zyRfo81R0DqWNpJrcCSJiH3fjaFvgIe/HgiDPdgAiyf8UcPd7Oq1a9
 yZPUkwgOFEkE1/AwYaq3rG2JiZmzNnThEc8XKa9UyYkydlouCH48PzcS4A4PfgxW2GzTMWzLMGn
 rhsRe6ANVobN5h0w9cYzVJBbeexEGG3Lbul8Z8ON12tIiAj4+1MmZ4aiLk9KknFmd5DjQ0NEaG2
 2/d5Q==
X-Google-Smtp-Source: AGHT+IGqoK5Yo9clP8tL1TjnpQNV6s50oT+xyw4gp+vBXdaa7B6okcos5rNEZhrA1jABb7AMFLE74w==
X-Received: by 2002:a05:600c:b85:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4778feb151emr182290335e9.34.1763545515115; 
 Wed, 19 Nov 2025 01:45:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b62dsm37009301f8f.24.2025.11.19.01.45.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:45:14 -0800 (PST)
Message-ID: <5a4ca35f-c90d-49b8-8928-901f7ed1c0e6@linaro.org>
Date: Wed, 19 Nov 2025 10:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] Misc HW patches for 2025-11-18
To: qemu-devel@nongnu.org
References: <20251118190053.39015-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/18/25 20:00, Philippe Mathieu-Daudé wrote:
> The following changes since commit 711a1ddf899bef577907a10db77475c8834da52f:
> 
>    Merge tag 'pull-10.2-maintainer-171125-2' ofhttps://gitlab.com/stsquad/qemu into staging (2025-11-18 09:18:23 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251118
> 
> for you to fetch changes up to de285aa9076841c618d068f7b838e312fc8b26c6:
> 
>    ebpf: Make ebpf_rss_load() return value consistent with @errp (2025-11-18 19:59:36 +0100)
> 
> Ignoring following checkpatch error:
> 
>    ERROR: line over 90 characters
>    #26: FILE: scripts/checkpatch.pl:3205:
>    +  ERROR("DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead\n" . $herecurr);
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Re-enable xenpvh machine in qemu-system-arm/aarch64 binaries
> - Correct Xilinx Zynq DMA Devcfg registers range size
> - Correct ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo
> - Allow for multiple CHR_EVENT_CLOSED events in QTest framework
> - Fix ACMD41 state machine for SD cards in SPI mode
> - Avoid confusing address calculation around eMMC RPMB HMAC
> - Fix a pair of build failures on Solaris (guest-agent and RDMA migration)
> - Correct QOM parent of LASI south bridge
> - Clarify MIPS / PPC 32-bit hosts removal in documentation
> - Prevent further uses of DEVICE_NATIVE_ENDIAN definition
> - Fix Error uses in eBPF
> - Update David Hildenbrand's email address

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

