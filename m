Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08D8C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZY5-0007mv-LY; Thu, 01 May 2025 15:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZY2-0007m2-By
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:26:18 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZY0-0008ML-7D
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:26:18 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso47254539f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746127573; x=1746732373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOEvc0SSn4n4LmFVDeAobZ/gyH4Gzc1mitFhkjq5Fbs=;
 b=V5no5+Dqgv5MbVTQhoJeB7s/0siQEnYYb793BC/3il57E7f9H79rkAcWuS3ayFXD0Q
 qFzu8EhnQ0lSqvIEDa8YjS4dTWIRK9Mj1jw404lH6ZJk1ox/XF2T6FAd4cqSd2427DuB
 1CxmKgm40/M+thEmXKrJmAm2hbxHwNyqsJK0+3PXB7BgKVzfxzSaeAtOyjoRTdH4hLfZ
 bO9NhE3jIWn6QNSnd8VeHId+nSdPlwceSECu8WeeWvGEYxfPRPzVQjUhPhcoL/kMyOmv
 7oYVJbcEJ8qGYchov3LRHR7j2S7z/EPbiqsq4BciffytN/PBQLRLMPuhsvHw7driki6j
 8vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746127573; x=1746732373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOEvc0SSn4n4LmFVDeAobZ/gyH4Gzc1mitFhkjq5Fbs=;
 b=BH+Zk6ysmoBSEelDDRtCs+RqNqUf9PObdZAc9WNXHIdc9GWpmf+08eHj+gMkFmQbBD
 6QDD0dTUjoNrPI6LC6x6pVOG7qZK+4q64Z7Wx+fAyo5pMln4Pkk/820POFVsF4MCUOcq
 2/zqMcabrkOyYwxfiW3p7M3LVaMYIKegLVS+WFDd1W17EPi6x8WaXlebQ+mavHd5Lu20
 kq3kkUec9Qzu/jgc/RhmXFOWyCLfE176nvXU4pE8u/g3sAVtHdzp2MBnQXgCcbdZdBUE
 40ufc/P0xvuR7obKGOL59VlKPCJe2TVHa28USHVaM9BgVmphcl1uQamPOxKUzbAsR0BA
 Sx/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBbNbPS/EaAZTqjTOwO5p9N/u3ssmO4K6u0kF6GeZTraekcCPztilcbFquPb951h3UsKwS34s/dDn@nongnu.org
X-Gm-Message-State: AOJu0Yy7c4NYN3WmB27u6C3KzPJzLmrxmwrQRydO5BpxIAfk7bPDvUWe
 ny/5A8IHLXgZDTHLpmZCvko+jByWYxY81c4sLNtbbchSb5juWAwDUAsEs+L+Wro=
X-Gm-Gg: ASbGncsJyP37F62haRgh4c+tD1Lh/cJHNfiqy1hswOIvWNSTroeqlAnKbOjb15MAAAx
 BRACNdf+U7LMgEFeF0u5AX83yXqHhBCnIN6dME+qykJBNLt72lNNJTxpEvX7SdthrV5vy+Bt/vR
 Hdm8UbGRqt1v5Hiict/7HhsM2GI+DykGdHKBoxVQP0bMwAaYsYj1iYJ08aIai1Zxx/XOw9rZJry
 DlSnR7xr7qGjwg4p8Km34/AvUoAuoNmj3HxRYXtXy5ZyfQzxrFfB/OxXVPug1VYDJzxg3ABGg42
 NfejVoz/t4LpstNxm+SvLVWWVePEgh9Q5sNkLdiFEWIP05gkXhmdXscQ3lWanFZ8a4syy2XSyy3
 AdPqcg8p9D6Zbmw==
X-Google-Smtp-Source: AGHT+IEnseijY1qZFqXaH/JWrG++6y+RPfgHvgSE0pN11DNLZSAd2eF21TBG53pPmJQRnKWTEfeZgQ==
X-Received: by 2002:a05:6602:6ccd:b0:861:c238:bf03 with SMTP id
 ca18e2360f4ac-8669f9bbb08mr51312739f.8.1746127573026; 
 Thu, 01 May 2025 12:26:13 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa591a6sm7263173.83.2025.05.01.12.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:26:12 -0700 (PDT)
Message-ID: <2ac29f3e-3026-4384-8f49-0549d7368043@linaro.org>
Date: Thu, 1 May 2025 21:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/33] target/arm/debug_helper: remove target_ulong
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd29.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/debug_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


