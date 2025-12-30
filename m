Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C5CEE4992
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeJu-0002Wm-JJ; Tue, 30 Dec 2025 13:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeJL-0002R9-6l
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:19:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeJI-0005fB-8H
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:19:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so65806865e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767118746; x=1767723546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOXCcYLrTLsLyM1e+EC++PJwLGR9RG7RAXwWUvdTbyA=;
 b=XXpMtTyB94/Grn/X8GbKE0xqQbNPltg867uC+w0TNlybvDh2o6hLgD17V/dXvKv4af
 up/6XvXRgA6wo5rc9zUSFfQGdM/ExWKcrowV5AKTKxOvV6C1USSLN8pZ3e37SoiFiOXE
 Y/+sJVYQ5l7oJPOZh2hyvlNn+tnbiq3A9fBv/2onD6P6SkEzsSWA2ilE8pSAnj36y47h
 5Oo2F6Hq8ga0GQiRO1J40aPm/ghrgQxtYDyCGdYp0ne8nGY1i+znDVJd8+LYKCxrjg4O
 skqiUKo8d7giptYn+760j8q/8s49MIltKgXJQR3La6E7bou6v2L6OY6xbf+BmI8a+rDV
 8bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767118746; x=1767723546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOXCcYLrTLsLyM1e+EC++PJwLGR9RG7RAXwWUvdTbyA=;
 b=oLt/9E/tm8o0YIyvsShklysQfEiYtB9nIb8DCiFYVnLkcJC61hrk4bOw7la7wJbmCh
 WU3iu/8Ac59nl8X+42u7dddncpXTmG2HGdb7SfCpMdA6klqKewoPN04/GfeyUOBveoCe
 UkDh82z/3ICGiFS78nv4Pa0bSo+BjtunUEJDRZElBdLH8YivX/jI0/FFtwumeC8hwPk5
 x8oZIjAsxujebZYZbJ7x+331LHTJ1LjGBt+rhfS9hiaew9o83IQuUmFR9c3B89H0V22F
 yrtjoY1bCwXDhZFc+blaBlbRVPgZEVLrd1cnjrJni81i/zIwnaSNxrjl8SSNIZLYJh9V
 OqXw==
X-Gm-Message-State: AOJu0Yy0ZndP278KTY39oRSaJP1tQgpreP4mxb1ytccc2V8l1Rx839ee
 x7drWt0r2fpFwj9T1QrQ5xJA/zoI+j9Gt4XSV46t3DuNbCrg+D9ag4MfHgyZhmJyOBykf8Kegc7
 1H2VBK3Y=
X-Gm-Gg: AY/fxX6L3OgflC3TuCExnzjNqRbMpEQR5NFcqkFGKq6GJSI8TGwggCOtd3ICtX+NziZ
 xbSB+kxWg+qnCempmgkckU6P5qB/04j1NTjXbkUK3fiLVX5g4LgFMEtFdf3/TBvWxE+u3jJrYA/
 erl7BLAVJ+dw2YnCXIs3J2PdTHtSWu+JX+KMBaEVjkqk8KxziCdmmC/wQk4UnUMqPhWHVrdcAeJ
 xMQLE9cGn0wKboBBzLRRfyN52qL/tpgSBaWsD3Fnb1th2PL8dM5TyXFQQeOrbuXj4+fC0t6gOf4
 ehd/2vY8i1p+/LIBKrbQ1TVgnglDJc0uyiXM1P3yP6NcuZR2LalBQ/1sLnUiB52c4B6zEOvBrS7
 OHW6lUyS2kzY1CIgXz2ot1WYLqkfbzBCQvCSSH7/ATk1HJDf/XoJwu9FWtw7QS0cWrsLXi+xW2Z
 Y0G1P/kjBeZDs2E5i8Uq0Vxd/kO6THfk1tBzX7bll1bDOwCN2J/hF6Kw==
X-Google-Smtp-Source: AGHT+IE4PK1GX6O1L96PnEfLQcsXm8qzukmLk2w77whCWl/t9FgBmXRp+0FviwCCQAaZ4i+4WSZj1A==
X-Received: by 2002:adf:e883:0:b0:432:84f9:8bf9 with SMTP id
 ffacd0b85a97d-43284f98d39mr14248394f8f.57.1767118746289; 
 Tue, 30 Dec 2025 10:19:06 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227e0sm71454237f8f.17.2025.12.30.10.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 10:19:05 -0800 (PST)
Message-ID: <e764a2e3-dc0a-4235-ab03-b2896b55ed16@linaro.org>
Date: Tue, 30 Dec 2025 19:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] system/memory: Mark ld/st_phys() API as legacy
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, David Hildenbrand <david@kernel.org>, qemu-riscv@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Alistair Francis <alistair.francis@wdc.com>,
 Joel Stanley <joel@jms.id.au>
References: <20251224151351.86733-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/12/25 16:13, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (9):
>    target/i386: Remove x86_stl_phys_notdirty() leftover
>    target/sparc: Update MMU page table using stl_phys()
>    hw/arm: Avoid address_space_stl_notdirty() when generating bootloader
>    system/memory: Remove address_space_stl_notdirty and stl_phys_notdirty
>    system/memory: Allow restricting legacy ldst_phys() API usage
>    configs/targets: Mark targets not using legacy ldst_phys() API
>    hw/virtio: Remove unused ldst_phys() helpers
>    hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
>    configs/targets: Mark targets not using legacy ldst_phys() API

Series queued, thanks.

