Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD92C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgAS-0007Qi-NT; Mon, 10 Mar 2025 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgAQ-0007Lr-PC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:39:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trgAO-00043g-Df
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:39:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224019ad9edso102552975ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741624786; x=1742229586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UxOfK4U13fTLVC5tzar6EnHE8Ldn/ZrMRRghAx8n6lc=;
 b=PNESKqcLEebjTJzfkNPs9F4LnXWtW9SaQh6vAneEUEHjx6z00tBMoHz/MEv0wgLpIQ
 Rt9Tt/LQzre0Qmpp2xWGIDFxMMvSArkNrqck/UuBdoq5swdu32MXbCieiOzz8VB130Q2
 BaedCuPy9e05pVI36kL/wQ63cA4s5LsBM9ypACgHhwStzHwtH1qWKM1XmSvPLx3xSPIy
 W/7HnBthgGeE9nLaNQPc/n4sO93174nlqlBva8FOp0u6iRqw8yN3mxTsK1L4c0wIJPnQ
 w9A67T4MKUibtHXMXGGhTNzrsccf8n3IP0I6kMx/wS8yTpQCff2lCAXYIclZrt+PddyU
 1TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741624786; x=1742229586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UxOfK4U13fTLVC5tzar6EnHE8Ldn/ZrMRRghAx8n6lc=;
 b=uAf+ZdCd/GoOwO132njly3vvJVHIAlYSQvgHY/WP+O8+FC4gXNfqRqzpWCala5Dx/z
 cTkhdWRwZyy+jwfOy3Ll0trvyQDH/4idAkfxtAPFwiQ2Hj0RvV75OtF9aOE8BTyaE3ZF
 CgsGfBPwTwVxOzQ7flgHxyH+i0dxUvwx7x+UDL6hKIV4l7Sq5+YOnAhJ0FWfegN5gHtJ
 KieaHmomdsjq6vztwBOqOxku0muQfijZMzssclNEt3R2EhsqEpH8H7/mfQ9gCquEX9iC
 OkpRQot0rf47dKZoKbmi44o0Smo29/xw6eimwpvS0LTexbbtkLcv+1K3N8CpvYWh6X/a
 vuow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUIGgDlz6+zpJI+GMJoyJrGAzdID0WVXAgoUr2BWYQtV0vt/Fo7VHmMJlEnmO68wbNC14iDVTp5HEb@nongnu.org
X-Gm-Message-State: AOJu0YzkGJgZrV7EenZgQis4VTy5MLHeSQNrXKGLXnGppWH81CNLgAPW
 juunCbB8H2LDdw/g8Yle/+mYng7kY6MintspudKZP4RL61nYq7vNcvOxz9jXwIo=
X-Gm-Gg: ASbGncuhX8QzCBEuepXm8Elxm2xhHObc498/HfaGjHohCZhtF8SPNnCM5RbeTIuec58
 lJaFK6dDAC8A9HEaea3lug9o+4i6fg7Dx3fSSdS7Tc7U67ej/wCVnBnj+zNtSTUAVpwaA34zPFz
 +DG4yfsb9Si3J9TW58pjfWrQ9lZta+rrHZ6z+bdIh2yK5Rx/9DNBxkaiz4/TQjvXv3Gely6DOsw
 yrWzQt2oK4DeCRSwzr1xE1Odgoj6nesU3N+jCqcmlcHzw5u5MD8va+ZaojAnQh+vOTPZ/zSHppl
 5LDUJ91Y0yRz38AywTfD9ISpTNIYctUkR9ZJy5sqX4iZ5q7vp7dH46Zz3Gw1dj/A989dYPqOyW3
 IAWVDG9Mt
X-Google-Smtp-Source: AGHT+IGpbMTftGFOpu5yXWZOAJmPR5hnTYpZQr5LkUIVN2cERuP5KUWCdUqf2SZPIZ5nR2sMl1IP8Q==
X-Received: by 2002:a17:903:283:b0:21f:1bd:efd4 with SMTP id
 d9443c01a7336-2242888ab0cmr242161995ad.19.1741624785872; 
 Mon, 10 Mar 2025 09:39:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693527f9sm9214668a91.11.2025.03.10.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:39:45 -0700 (PDT)
Message-ID: <1ee6764c-5b44-4cd4-8cd9-b0aaaf31f0fb@linaro.org>
Date: Mon, 10 Mar 2025 09:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] exec/cpu-all.h: we can now remove ld/st macros
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Functions declared in bswap.h will be used instead.
> 
> At this point, we finished to extract memory API from cpu-all.h, and it
> can be called from any common or target dependent code.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 25 -------------------------
>   1 file changed, 25 deletions(-)

I think this should be squashed with the previous patch.


r~

