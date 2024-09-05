Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3970FCD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAyB-0007wN-Ea; Thu, 05 Sep 2024 07:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAxz-0007vH-Ti
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:47:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAxy-0000sZ-5A
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:47:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c7d14191so976006f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725536876; x=1726141676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=12l9s4B89MeqT235OtJWJugeyF+7i4Pp5Amv9d5gRdY=;
 b=uPJW1jhlPxrg1+UDPgDMoA7naWGyuZJDVRXMellGRM6EdO20ZPhzth23seR4Ngt8zl
 Q8VI462K4ZVclQ3zRJ6xfoDUs4vRvL1QiNtRBgxOjthglXdChnH5re3bRyJyNdPUndBF
 3s9Oz4ux8wSkRmfPbM+gPE/rXMz0K2dxZwWl4ZmFemU/i+oG/PEZHKaiGAKjcB2OuQ+n
 /3eobR8n+ja/oLysEn2F/79d8LrpADCwjRfsCBmIkizyLBDh4VbfLMre6z3RFBQYgTp+
 KDNLb51zBNbNAkgRnxT6YrwWZyO3is62UMThzZLvNrsz2X5dLUvJgNn/9GPQD747Bx3I
 f6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725536876; x=1726141676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=12l9s4B89MeqT235OtJWJugeyF+7i4Pp5Amv9d5gRdY=;
 b=w8VeXcX5WhlmpIg0YUZ3VL41ZHbk4f/MPX/yfsCoja+sNArptDJ/PGY0S9jlK9BjuR
 pytKj4va1MK5AeHE+HLuvInfHhR+JsXqcgfWxci7IJt+FCP74UlCzHoUL6+z1J/3qotp
 SPncU9GdPWIrzDCbKJOie6Uc4DPv97oO8ySwE2/Ag5fw+T06dNazWAyIQFXYQpudGmAl
 +diCGE/vslH6R+sql5AAPMDcZb+Ozvu/p7v0GaLea+ZQX6gtc/KH6rrznPJ2NYMBAFym
 xbVH86VtLgBqYEvY0sD2xt4RjKTfVo9BSmvSA1m1iDYt7l8vw8TT+sioPBOYub16Ognd
 qK3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlef3TzqvLGKJtaBCUA+zBIJCTd/dBQ4rnBCc9MBqgSZCk7LaXW9fdBPtiMThoZ422C8yyDVqwKaAV@nongnu.org
X-Gm-Message-State: AOJu0Yw884CYsnPqLSej6GJof/+MA2+Ov7SGen1bWfaVSvMVFjqtW+km
 Ab+pPK5svCkMkuaHJ8OJ2GR1mn3PDciv9d7sF8l7JHepC19WMeP/IFBB/bmvLRQ=
X-Google-Smtp-Source: AGHT+IGXAGKUiAxWmLOYpl76FlGpcUQXtp0muXLNAUqKni0KxVoWWAmm2iMCWM28cAf+gagxbcJAGQ==
X-Received: by 2002:a5d:55ca:0:b0:374:c11c:5024 with SMTP id
 ffacd0b85a97d-3779a612bdcmr3515127f8f.16.1725536876237; 
 Thu, 05 Sep 2024 04:47:56 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4d391sm19276932f8f.3.2024.09.05.04.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:47:55 -0700 (PDT)
Message-ID: <5801aaa7-7e8f-4cc7-ad86-1545e5eba4cd@linaro.org>
Date: Thu, 5 Sep 2024 13:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 20/53] hw/pcmcia: Remove pxa2xx pcmcia device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-21-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the pxa2xx specific pcmcia device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/pxa.h  |   8 --
>   hw/pcmcia/pxa2xx.c    | 248 ------------------------------------------
>   hw/pcmcia/meson.build |   1 -
>   3 files changed, 257 deletions(-)
>   delete mode 100644 hw/pcmcia/pxa2xx.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


