Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04438C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGuG-0002Sr-Ig; Wed, 12 Feb 2025 12:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGtx-0002PF-Vl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:51:59 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGtv-0007kY-RB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:51:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220c665ef4cso12035655ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739382704; x=1739987504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+IHgi8A4FQmqHxwR8123uukF761i7mOI5ZqWU1j14A=;
 b=gdTbnCeABwTotk8Dmsi5XAvO6ucE/jHLl07U4OFpoz2tn22O37itPOyZn3VXMF8+g3
 3XhTWpPrzpx32HlJU1YDr74GDwbMuV6WyQM9WTcis/oxd3TRREQhdO3xf883J5l1Rxnv
 ddGK/OvUci1iAjEQlWyTwhRbowaQVlepYs6uIKdhObaeFnTGO7uxovAzXKD+1w5IDxnw
 5Mntn7A3SeW3BTB1dHjjjkHSBuXKeFW8etKRZCaj1yEOTFOML/L8bEFUdhuOFpbXWu2b
 n5qV8B5WY7qaHAq9RdxmZW79qwdN6qtg5FH7CUrs10Xm+paFUHH6AXd3ni/XNWjESthm
 vfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739382704; x=1739987504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+IHgi8A4FQmqHxwR8123uukF761i7mOI5ZqWU1j14A=;
 b=JyhjtaniMe0vC7QfSiSQQNIQ0yCZQNa8HVKbfGaZMaNhi2L/OrX3/DFHw4wZzjMlOX
 tk6P04HS7ehGyijuPyXxSFSzu0Y+qavSkKqxeJBpWr9v9W/k1s3L9u3yc2XKC7RPmPHi
 H+o+BZvrdYqWxSpcotBXfYUlCuUtonmJE+s31gVY43CZJIMHHafl3D9rLPNMCFfh7GUC
 3RlvbT+yzvxDTxXW1qtdl4kgCVtIeDw/LaU+gnhB3QJgv2OEawkkadCANsyCeNq2YXil
 fQ6UYUv+Yva7RJ79KazW5HhgFjTYFTxAn9wg246pTZ95+eUq7xkxXdR3dUNsOggBUYGL
 4Cyg==
X-Gm-Message-State: AOJu0YzYV8dKqNKVz0iYPQ7U1xke68W77HQkmMPfOFFheQEOn48PwwI/
 OW3WLxxh8rs+fvV7j2beRfQlCVn0pgOxvsu3sCF90jU94DI5e16obJqQuyLFAGjtMxha3bCfvyC
 i
X-Gm-Gg: ASbGncu9qkoljOxNqLLZdnfDb8HV0izHu4eMJGYln4XjwWEbYUPUp8ETqQWr7b+WuaW
 dxS9CejhPc3R+QRuviKg6VCyS1sERbOTUkBTDwfv9+INX5wnFLGJEkhm3552rVzv8I1opPePhcS
 2MeZ/kcmqu4JiMYbtWaEVqlA6PxpFmh702HsozpwAM8uMeyz1KwpccDmVcZZTMmMvqd6feFPT5q
 yO6SRzQ9QPSw69n3oSiRHEM8Xltlt5+4R0IjPAickQQRZnZMx4bPShcm3NUx/0hbB3ha8zC6Rk9
 Vz7AEO1YCAyOuPPsgYzk7k/oR7QN7z7XDy/Ei80wPi+IGuM5m/TcJ50=
X-Google-Smtp-Source: AGHT+IGmfYEx1fQDieZrJQVbm6iYRwtQd9TNj+kofspC0Sfqt05bVtkKhiLzypH2tBHtIDbtTq8sag==
X-Received: by 2002:a17:902:c942:b0:20c:5533:36da with SMTP id
 d9443c01a7336-220bdfec885mr53771605ad.42.1739382704161; 
 Wed, 12 Feb 2025 09:51:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220c1f9794esm13887415ad.235.2025.02.12.09.51.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:51:43 -0800 (PST)
Message-ID: <1bbfe907-8cae-435d-ad8b-c2b36b823512@linaro.org>
Date: Wed, 12 Feb 2025 09:51:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/mips: Mark Loonson3 Virt machine devices as
 little-endian
To: qemu-devel@nongnu.org
References: <20250212113938.38692-1-philmd@linaro.org>
 <20250212113938.38692-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212113938.38692-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/12/25 03:39, Philippe Mathieu-Daudé wrote:
> The Loonson3 Virt machine is only built as little-endian.
> Therefore the DEVICE_NATIVE_ENDIAN definition expand to
> DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
> isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

