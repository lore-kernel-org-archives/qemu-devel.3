Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F79E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUukR-0004Mn-AQ; Mon, 06 Jan 2025 16:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUukP-0004Mb-Ok
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:34:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUukO-0004GQ-Cm
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:34:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862df95f92so6512922f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199291; x=1736804091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUPDWfvjWBVU4s+VJ3KPIT4k83aWYBki6D5qh5sE3Ho=;
 b=vm5QgxipqxgPXTv8ED2sr8Pg+fFESyfrJs2TV4GUejglgsxabunTtjpNREwCS2MBHf
 DtjChp7W1WcB2x0FbpXmZiiCBIMOxnpp3XEBAe1oGJeQed5EMapktywxeHwM093Z+FKj
 FUtJPQI92ZYbYU7i9TTaY9gEvIECby3AA7JOTQ6i8x1o4GEkMYGkoq+rgp9FgLZ/Vzld
 AF0m4gSUt5+5oOFe6KHm/VbqVFicJAH64xCiCtIN6Ozk6jjFB1Hq1C/4N9VfCZz/OcOl
 B/vtrYGd3lYafyF7yDRQcaeZ2ZuliEnsHmtgi5g41GEwuJfhmkHKQRMGts0exlfTNKGG
 mIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199291; x=1736804091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uUPDWfvjWBVU4s+VJ3KPIT4k83aWYBki6D5qh5sE3Ho=;
 b=WsXPqmLD72nehXLq4mNeX/MYHkfyqFd6ekblqbzHjgx4+W9I1JfpBanP11oYGaS+1e
 ticJFtzphfCqwora3Xoa3TXVP1pVvRWLp2iqwAJTAuP/yrSH+8lJiJLdq2/NANT7+SSw
 xWsngaFcCV7h5giBk4lKLjc1pUStN+zObzgIT+Fnly2J/62epYOblSu/Tjgu8+1VyUH/
 85RT/cXgtyu8YSvm31JcnH5srMoYX30zA9m5oNh4bUKfKDp3bkKWMNlxmZ3LH4ikizKl
 07+CgCkD5TUZoBoAv2tyktqg+sMTgvDEYTVnxGntm/pcpdaERPhHJ29+sdl61yKyjpdS
 hxQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWXR4HV919VGZDr+iungJmcCT32Oyvs21Uw2lk60DaI+A37Rc7acV/cxbOftuN3W/pli0XE6eKoBE0@nongnu.org
X-Gm-Message-State: AOJu0YyVoyGSq4TGI5Q4jQy+jn2u9y8u5NBAYsxLQ9vmXLL1Ux4hkI9T
 9NDDglNLn9R4WyVDPOG4X/I5eP2b2rf/XIaZ8UGjV5fjhbMiBcDPLzglKmWcDCw=
X-Gm-Gg: ASbGncvFoNpssyxqhaCME9vmejIJSaDP/gLo28UDkrQ6HhpmxRP5pYl+popsg1BVCVx
 eJ/cisBnN2uXZN4XGgInM7HFgnz032Z2PlWg//rGE/ybPkk/bKILDeKmxW3jBzi0bLFQfpJZuDE
 sUvldBz7ViJ/6KWfTMT13hNLiPiMEtaNHkn4g+NVs9d6gtQib/y3T54QTL+WZeGhTAPxmhgz7ua
 9pJ3gEnHsFiqLz2TDmnzSKgIt0Rx0ctZtnscPeHz4f8fCBHpICDSVaF11udfpuZh3w0rJXj42/2
 EKOMADIvOxjsA9YjFzQDwYmK
X-Google-Smtp-Source: AGHT+IGpE8hpbniCp84o7/2ETMuaHZQH0LWoZ2oarhghJQiVPW2ytDJS2yI5J5jrc4xiXtRo0we11Q==
X-Received: by 2002:a5d:6da1:0:b0:385:f631:612 with SMTP id
 ffacd0b85a97d-38a221ea944mr46305626f8f.17.1736199290858; 
 Mon, 06 Jan 2025 13:34:50 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366112e780sm576217895e9.0.2025.01.06.13.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:34:50 -0800 (PST)
Message-ID: <890093cb-4f73-4e4b-9b44-fda2c49b5cff@linaro.org>
Date: Mon, 6 Jan 2025 22:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/73] tcg/tci: Move TCI specific opcodes to
 tcg-target-opc.h.inc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Now that tcg-target-opc.h.inc is unconditional,
> we can move these out of the generic header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h        | 6 ------
>   tcg/tci/tcg-target-opc.h.inc | 5 ++++-
>   2 files changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


