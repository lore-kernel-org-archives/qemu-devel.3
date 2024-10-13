Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7FDCF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t01EZ-00041e-Fv; Sun, 13 Oct 2024 12:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01EW-00041M-RV
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:14:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t01EU-0004dh-W2
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:14:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2bd0e2c4fso2741280a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728836053; x=1729440853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FHDRP1Cnae9Y91xyHkYgFeOsq/CriXBppPvzoTa2nhM=;
 b=idmT71u84r8gnvwceeo+CeoHX860fPnsHi9CjQuHvMQEFZSsRqvzC8kyO6NkTtkW2X
 jEBqGSdFM3exQZZY9L6aHhrKO2Ov/o1Xmm57+4pAzYl1AOKg0B1YVzhVVpxug4tAtlPt
 Jt6HsRJV3JcsAbjTW/Lu+r/+00VL8sFunujxM2Hv2QKZhaF9LTKdNiZaGMKxBBLeCJkd
 2/WXC5N8nFdCGpdE/2NbbuJf+9TcvfzDzeB21TygfqXefVLeT9g1KmSuqF0aefvaXUrg
 a4k0MoPwPMrs+fDkFQK9IxfOihsTZ+FZ4uN8noeyvFfxAmJX2TJmhuvJSiyAKzPIfDes
 cxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728836053; x=1729440853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FHDRP1Cnae9Y91xyHkYgFeOsq/CriXBppPvzoTa2nhM=;
 b=lx+/Vg9pZ36FbH+zCrthOm1OzNuknd4sPWRTpafWNQ5EXv/LpLq8ShGJ/T7UQg5a/3
 dBP/Yqr15SHFNH68GIwGR45iwTmGbe5Z6h0lsMQE0MfZ7Ycs/HGEmZUZOBjXZRU8Pf6Q
 r3QsdanULeYAm2BMslyQsEUaxikpqX3V/bPzAn4j1lzPToBoxcDNYaSDQ/kOjAYFovCc
 9cbv5u3Jj2pUihkmIYsq8uwu4YF6aG7OkoItitnWLZ7sLXFwfDF1opqCFUq0l0FOk7MA
 9okg2zdD89G56sU2OTuJQHo+/NQPio9WrFg4pkYTMg2MbcjFOFwBGUNrDzIVkY9rzsZN
 0pBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRZ4JXHfZqCyP9biNwyclA93Rz2gR4AcbNu/iMmko6qgR8LIeEo4+rV89srIm1GohMqlpDsfSFAvpT@nongnu.org
X-Gm-Message-State: AOJu0Yw7jXHEfMSp1HXzwS7wlfamD6RlDDNGvCVnXd97EvRxSL56bM5Z
 AcZc060zqsar0Poej3gwuE2G0U/IGWc9NfpAuq3iNGCiNmzVTN3yFUJ7PqRNEg4=
X-Google-Smtp-Source: AGHT+IGUGRF5Hvx8AnktA1EUafKzEO3qtfQF10DmM6hJQHDMXW/WnH5pCuXmMro2ByWSy8947Vg80w==
X-Received: by 2002:a17:90a:8cc:b0:2e2:c64c:a1c9 with SMTP id
 98e67ed59e1d1-2e2f0b2b844mr10833068a91.24.1728836052932; 
 Sun, 13 Oct 2024 09:14:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3132badd2sm3518327a91.40.2024.10.13.09.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:14:12 -0700 (PDT)
Message-ID: <3fd36e15-476b-404f-93f3-6a607be68ff8@linaro.org>
Date: Sun, 13 Oct 2024 09:14:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] target/mips: Expose MIPSCPU::is_big_endian
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Add the "big-endian" property and set the CP0C0_BE bit in CP0_Config0.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/mips/cpu.h |  3 +++
>   target/mips/cpu.c | 12 ++++++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

