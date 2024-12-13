Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D4EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB8x-0000Um-I8; Fri, 13 Dec 2024 14:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6w-0006CS-5I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:03 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6r-0007V6-PQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:01 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-71e3048970eso969353a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117236; x=1734722036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64LQD24VMAIMkteYN4P5d7TN93Cyp6BtJD4NU+G8oL8=;
 b=f5hX8SJRNssTBh6nbHRH3Amk2Nkfh0WJb6/tSfVxKwQHeUBdJKpW+5t7joOKHxbCCs
 kiYmi/3WnIidma9NcXiirIka/TLnAPZMiKFKefEqo6m/vOfgp+Uac2t2Vn2s+VXpEwsf
 ZYJvYtAZ5Yu/WYQgXN49/gMashCyEQUnYzNrAsvmubNRP1G+bBij89xzQDrNmO4auphW
 kcy62vM+rC6O23sguyZIAOtObNlWYFAYd8gn0Y5hYsHzdgt9x7e8Q5I27wiNy39AnI72
 pX997nsT5DKph5Ur7tCqHJAunjx3YN/OOSj6zhHJVd5KeOLx5vQFMVP+OgxyZg+rdebl
 o/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117236; x=1734722036;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=64LQD24VMAIMkteYN4P5d7TN93Cyp6BtJD4NU+G8oL8=;
 b=SrQIabeJKqeS7pzO4RkjF1RTJ2jAuR83BqfOoT996PvaQDo3uYutD4Ybd+eaks5WVO
 5n2D9cGRTML0QhBp74Jvf/E0k7D7IALSf8F2kgS/PZYw84gUYxtAyOxxSmkwYZbq4EhA
 2LsS29thviOAB/LRfHMhcEFMw6ALGoFGnP1p0ExRFuWkDr/rQKcv7YS/7TgE75Q7E1un
 nOTOHGj3hDShLhUrNZVT31YdvjKHyrKFc7NGdpypvfIEmuzojNQREQ5qk/BApz+QStQs
 /i9vlGS7SRtEhXje0iJxVh/z9VXuXMTVCwNB/zETKuXv4VbCBgrZczfk8Vmovt5OyFFE
 TyeA==
X-Gm-Message-State: AOJu0YyStBIXc/6VTBwlWVk5By1Eygi6xxTNbYA/lkxZi9t/TsA0xs7z
 zXHT55D1NdPCtUa/5mTgXOQxjp2ReXuvRR0BNd1tvz+/4ejM8rJUN+Xhw3Rh4sHtvn4KpkuURob
 odxaJAwgy
X-Gm-Gg: ASbGnctPURN96dT4moKIIaPEqKHUUp/SQAiHXljepsmLuesGQE1UQokrIBQQc8stPp5
 yhEGo2FE4UpclYzJIRJ2HaMeUyjPFi4R6ClzcM9QbYo4x6Ev3gj0l1nLkxGD5J8ZwJYCAMjLA1r
 Qqk3UxRtDUvE3HiV7SEL1i+HUozvphWrmfHS0KI3m7ZHQtjOxK/HDttF1DbUnfH9/uVKSMnW/7U
 ZPCStLVV2TjGyDlwajYhMIRCsrG5elICducEdjULZMB8/RW42ZbaKixr3CC4A4DC71UrFejMw==
X-Google-Smtp-Source: AGHT+IER03JtsRYIQ+qyF3vhlgkF2pvO9NaBNVpljoO2tEg267KOKPNfUPprD0lKP1LI9VLWVRee7g==
X-Received: by 2002:a05:6830:3493:b0:71e:4fc:6ee1 with SMTP id
 46e09a7af769-71e3b8782c5mr1917948a34.9.1734117236391; 
 Fri, 13 Dec 2024 11:13:56 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a9392fesm47785eaf.35.2024.12.13.11.13.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 11:13:55 -0800 (PST)
Message-ID: <2a28ca94-8c0c-491b-b763-09e9c09df43f@linaro.org>
Date: Fri, 13 Dec 2024 13:13:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/71] whole-tree: Constify Property structures
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 12/13/24 13:06, Richard Henderson wrote:
> Since d36f165d952 (qdev: make properties array "const"), we can
> define our Property structure const.  Do this across the entire tree.
> 
> There are a few other minor changes:
>    - Two instances where it was obvious that an empty property list
>      could be removed entirely.  There are other empty lists that
>      probably should be removed, but I didn't look further into usage.
>    - In hw/misc/xlnx-versal-trng.c, adjust a Property to use the
>      correct PropertyInfo in the definition, rather than setting
>      it at runtime.
>    - One instance where { } was used instead of DEFINE_PROP_END_OF_LIST.
>      Not a bug, but wrong style.

I also meant to report that for qemu-system-aarch64 (the only one I checked), this moves 
150k from .data to .data.rel.ro.  I'm somewhat surprised there's that many, or that 
Property is as large as it is at 88 bytes.


r~


