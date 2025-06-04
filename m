Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE26C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnL4-0005zF-CG; Wed, 04 Jun 2025 08:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMnL1-0005yN-1y
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMnKu-0006LB-It
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so5727535f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749040514; x=1749645314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zVXeZkET302bdJ2mMiYB86Yu/U8ZHwDhxPtTLSFmI38=;
 b=gccmJJu5rTIr9jNZ8zFNTez/52ZiPu8qYuaswQ26y7KGYpDdbExKk4oF4i01Qs4T5a
 t1l0+SONFNxbX9oT/Ubs/OMRhzvd51VchpPvEpkFlKHGryRF2C3NokLS+hbx75Bri23O
 hiMIXu/9Qu1ffqa8jrsoJszC7Y7wgCLNcn2OwmRz1PPqaT4XWp7A491G++GTE+wES0FN
 ht/C+3VktpVM0kgyF8Nl2F9pTHCvSMrXK7+wapsNf0b6zyPR6pRsv2wdltWM+/yi0Z8U
 Hunkbg4x+aHAq/Tu86PUE2/40RMUdjNiKt/zXSntq7wuSz9jfEK1TQx1OBDDsNg4YT2S
 D2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040514; x=1749645314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zVXeZkET302bdJ2mMiYB86Yu/U8ZHwDhxPtTLSFmI38=;
 b=tHgCouOZfyQIYEKIyJO+cAqK4Ru1PemhZY3/S/+/yMxDygggLBQ5oElXSFh43AV5vh
 x55j7q4RVVeuZSOtetPHZUdjLbdxCCi3g8fU7Z1NAyMGnf1eq09Kmz0AC7HRigTh19kE
 lOLAY43tW3ELWnpiHyxa+TljC4bnUO+CxQPAf3NO80N3WSQoWGIuoQHSWXWsItNcBh6N
 fTBa8sXZ1i1rMgPkpgI/kM4qg30joCsvc+3oSOgbv9MWBzsc0BonP/LE12hJZkA/Lgkx
 xdIG+B/nHrZqHAzcxX6bsfYFD+rsc83VuRPCCIIQP7ldtQfYaFW5XnEYbnaKFJgVAx80
 fUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzSX3EkQrBCHBMejU3ivhVISJL/rWGIGq437Z3UT3rH+p3ehVu12wa+gV4PtH0xdeSkiwP+F797TaQ@nongnu.org
X-Gm-Message-State: AOJu0YwApBY2IIFq8t7JD4g7nVJPAjUU69+V2fXxkeQfr48MVCas3ZUh
 HuoLopxPiP2xEggELXDiVS3+jRmBE6xPvsaxIE9w8eh6WaTUva/+izZ/KIuG7aLu5nA=
X-Gm-Gg: ASbGnctuxFmvP439bdxvql+fEscT19HDz4YUxQBMPbH7EIRSekHg8/luEW/iU0wQdzN
 m9Knbgr8IryMY5DxURJdjypETatmMh5QegWPZeentltbUse7aeRiNBB37XK0WESsHjmV15trVGp
 nowS1zTbqpL2542cq5hqiyK+Yv1JEalLA7Ns1KN5LvOmMzbU72kQUjTJDDQ20lkc73sGTwBPBdR
 75ylqUx16DEObypjiOjceKoyGDahvxpzvHtfQLd9cUA1HPt1wVWs/R3wMOulb8bT3DwqSjUak4F
 mXo25p8r6i1/6cFsTlOoAqOT7P2MJhOQQYKJ51yKX2Fq1hNpPnjaVvk3W+EHGbwEGkhU9/QN0HM
 5EeLpru70IE9EjSNhtvM=
X-Google-Smtp-Source: AGHT+IEhfmjKIDBEwMJlALVbhOORPLwU+gykkE7jO3kyp0isMyGpD5WeJRmdlX8jd/9sTnNEXRfNcg==
X-Received: by 2002:a05:6000:1448:b0:3a4:ffec:ee8e with SMTP id
 ffacd0b85a97d-3a51d968aadmr2051017f8f.36.1749040513490; 
 Wed, 04 Jun 2025 05:35:13 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f92585sm211497715e9.5.2025.06.04.05.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 05:35:13 -0700 (PDT)
Message-ID: <16032058-90c9-4a52-9035-94c8491fd277@linaro.org>
Date: Wed, 4 Jun 2025 14:35:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/gpio/aspeed: Fix definition of AspeedGPIOClass
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20250604115400.98905-1-zhenzhong.duan@intel.com>
 <20250604115400.98905-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250604115400.98905-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 4/6/25 13:53, Zhenzhong Duan wrote:
> AspeedGPIOClass's parent is SysBusDeviceClass rather than SysBusDevice.
> 
> Fixes: 4b7f956862dc ("hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/gpio/aspeed_gpio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


