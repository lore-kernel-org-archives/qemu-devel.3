Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1554C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wS8-0004Qe-Rs; Wed, 16 Apr 2025 02:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wS3-0004QI-IW
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:40:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wS1-0002bZ-UR
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:40:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3782363f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744785648; x=1745390448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4NXBNlNuSuqBXX55i9+06BaEj8MjcRu1YtIcsqbIqJ8=;
 b=XZbWmfRbg1zn+77iorKZQ89ihSnPbDFvtLCew9Z5nxM3nnskYIIcNF95Dz9oXmQqIP
 RQAafVjpMdfpy/zh7x12FHlDAtoW++TN6zrwABMOAQ7e9zZTEG6MjAVgh55A6dWJIRoG
 7ztia8uUdyhwlEzMhx6F+UeUQgPdF4Xpd2huedUw9EmiASVXN4UTmugn5Oxg3RXOhqxB
 y7zPUuCtA/gg8QkQTQcg8KM0talRTl7zVeIhY0dtSQDBAUUbuA0FCI6QUZSD0mhZI8OX
 isHgsvx1Fm0ig+/X4F+xSHR1ihhgkZIxNx79nePYgOChaEOtlm3p5zT5Ezjm4KiyyepC
 311A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744785648; x=1745390448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4NXBNlNuSuqBXX55i9+06BaEj8MjcRu1YtIcsqbIqJ8=;
 b=xUhYAjUriLL2p9s9/vEWqj7zMfA93pzB5zMSVsONgxP7wXdML/3L+jAUzZ2TScBlK3
 RODIzJ1qYAwCznM5pUSPQm85djh/gT7BGVRBwgAzsIMKmOfuQcZlO2fguTUNpqpe+/x7
 +livB+CwGJZIf11wfg8ZcyEyOanGrwCbLSDwMThUShBtzNHrCnzopkupFt3dkgN4jRl2
 aD6UtjjIbltNM6QXVpobPWc2Arqm84iIKbHDAQHj4xFh+gslICSTpwHnXl6gw189LZGL
 n6lRzzZ6YUGiXJnEJgK+4qIqNTbreOXOgy141kPQitucmNlNmbTfZdX8Xv2IfVVISBA6
 vvhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5kHRH554y4gjck4EUV3vaIVNASsZbyHcMhfYGSdGWH0pT8TKI/DpyzfOYIx8q33LLuzDoDxMW6yGs@nongnu.org
X-Gm-Message-State: AOJu0YzTfXTitNKPgCi06ubI09DKLkeA7rkFBQCIfgU9LamN5qSBfxYZ
 7gbbmgc9q0OcUcgQVO1hTTrgdgituDMI5ZmbJ6NC/oS+MxY82y9CF6xCeRonGoZTkOykyWomsUf
 a
X-Gm-Gg: ASbGncuNHe4m1B+E0Iq5znEccyKkagxEwX37tOycQpecyAeVfnZ3rWbzuzquBDfVVTG
 2+8WguchnSnEDsg4x7LXt/KhFK70KrPQfX+kv04HnyHikxxaHb5N7Y0ca85lgMCZJRLgm5BivSG
 0BReaDj0/rilUqa6ReccgWLg6YukrRWufcDPwI/6XHmsYFvNEzpIbpuXq9TqezMntdOtqG5Bt2q
 Zjb65Gf80Fw8SPv4sVbB0ciWaKMwZCaXuZa8D6L4GT+S38Ah6nH4S5OkIm2D2LnNgQWDrBrZG8M
 08XuhaZFtk4DmVemZgp3ou+GFlv3NaEeueTl7CCdFnbFnHQ7E51VjzjzHsCBRr2vRLGY+tVgzms
 luoDy2w==
X-Google-Smtp-Source: AGHT+IEbK/yR7gcrAuipj4j6LTtzZuZOR6NYtedNvxcoFBCjYOwul2FuByNg93DMm+0T+zrjwDuuBA==
X-Received: by 2002:a5d:6da6:0:b0:390:f738:246b with SMTP id
 ffacd0b85a97d-39ee5b1891bmr589257f8f.15.1744785647892; 
 Tue, 15 Apr 2025 23:40:47 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c05asm15977502f8f.26.2025.04.15.23.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:40:47 -0700 (PDT)
Message-ID: <b2a7524c-5c67-4d68-a365-bcf93b432708@linaro.org>
Date: Wed, 16 Apr 2025 08:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 144/163] tcg/sparc64: Hoist tcg_cond_to_bcond lookup
 out of tcg_out_movcc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-145-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-145-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Pass the sparc COND_* value not the tcg TCG_COND_* value.
> This makes the usage within add2/sub2 clearer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


