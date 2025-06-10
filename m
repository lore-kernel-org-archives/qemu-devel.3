Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B7C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtPM-0007KR-Dn; Tue, 10 Jun 2025 03:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtPJ-0007Fm-Ls
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:28:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtPG-0002aZ-W4
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:28:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so2416065e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749540505; x=1750145305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r3Yc93fNuln0QE9qklfeBpcnFF7U5rWP3SnOLIRjd3k=;
 b=kHmmFK/E0wJFZeAHdfoonOB4Bt7oSXqiUQN/rtSibt6k83Qs3TK++UGkBNh6LMiBRJ
 PVn8UBfs0KW8nAJgDc+ZwefaWdy5HXDVdemfEe3feppdTuoq3Dgda4BDZXTEH5n0HbjS
 KKwa3y4GqkEO/+Qu7WPT0/PjgMdSotyxV4OKrN+V7cgSCUEOQV97w02cfpxx7XJx4D2y
 O+K3EIGzLGQUpQHryQMD78kPLwa4lUYKbiVwEFEPoRsLGd9ValWkZmMVKiuFzuRlE5Q3
 ohG7lIhmSgh+qDxyFQstAPOAgSELVFOzOsMyzDTRyoKSvDOX+UiaMkPuLDoR8EXAQ711
 Yc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749540505; x=1750145305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3Yc93fNuln0QE9qklfeBpcnFF7U5rWP3SnOLIRjd3k=;
 b=hu+pxJOAfNfG5aPZerYI+49/2kXP+k/riVyzhWo8oSX4x5pevuGzRIJ58BLGZQMTSS
 nvowI9mXI+1HKz4kkL+MDSTMTmYFkP+vIdYkeXXHUsdlAm6jDy8tQZ2nLFFnjfoy+fdg
 IY4PJQAGK3Dvi8zXG+caau+ryZmNI8QqDHjtBcWh0yv8dNxnD9udjA4hjklGMrhj3xuo
 wtu7/00Wsk0Nbck4OmXb8NGnFqqj69oeaBJIWJr/TYSxQGUUIdZKe3+UTRywKeIIbQu0
 +3mqKu/g4MUb5aJz2U4PuQMKPhmm48p5wO37UnuM3wGwXZzhCajI1PmbG8RHRbyHEdPC
 INHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV66BeK2VwE+g8W8uUdxEg8IwM7QMtEzsS+I3qQ1hNDm6mtglr2AIlMUDQsK9/za0XSk+rx3qIjvoXL@nongnu.org
X-Gm-Message-State: AOJu0YwmxQGhM7wCdkGoTXoqt7zkOC6jNxVL7UaXeAIfn8f6zIMm1II+
 kn/uCJiYlyrnoINab6AXiAX+TuuKnVjeSvlF2pMSNTSTc2+EN4hbR6leXI9Nl5D2lHdj8Psp04a
 ybv49xPA=
X-Gm-Gg: ASbGncsj8yvy01r+kmpf8DNP0yFEZAB6pB98YP4T7cnS0InmzMYZ8P7rWSSj10T67JS
 69TwZ5MMu0ABLTSJS1n0wJU48+EZlXqubMV09Seq0LymUGx5NppNKZHoK9Q0NNIf5IXne/86Jxa
 RoHwrAotanWxIGT+vtLDNw6Bryq/fzhVgkXFobqA2TAK4IK0+LNSS42nPiVK3YpWFt+8/MLCCeG
 vsnjgVImRd8q42EAHr2FIptS2/sq882ADZSncq3drejrdloRT6kXB7ar1ZUQdh05sSgia+szQay
 pqw1tYfxjXq6kwpwkN4x8w54TpPE72TtPdtw+p3emtwZLHrAfMUFH84RQEyGIn54bUz5GABov5i
 XE9zuXa54Ceid4cbMoxmK1Dd4JHP66zYh8O0=
X-Google-Smtp-Source: AGHT+IHf3lbUt23iCLBSbBzOSVdrNxJh/vBWgNLtwFqqmb/5svhKRHIkozvml25CKaPXtCQ/RUMP3g==
X-Received: by 2002:a05:600c:4691:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-4531de673c7mr14772225e9.17.1749540504614; 
 Tue, 10 Jun 2025 00:28:24 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b9b3esm129632925e9.25.2025.06.10.00.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:28:24 -0700 (PDT)
Message-ID: <f1d82662-26c1-4d8f-a5a7-5a01a63b4231@linaro.org>
Date: Tue, 10 Jun 2025 09:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/ppc/pegasos2: Add south bridge pointer in the
 machine state
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746139668.git.balaton@eik.bme.hu>
 <0e77e44fe99c3cecbe17d6a8b697c996d2a0923c.1746139668.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e77e44fe99c3cecbe17d6a8b697c996d2a0923c.1746139668.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 2/5/25 01:20, BALATON Zoltan wrote:
> Add field for the south bridge in machine state to have both north and
> south bridges in it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


