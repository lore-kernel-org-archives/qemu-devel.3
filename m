Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B2AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZbX-0001tO-SF; Thu, 01 May 2025 15:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZax-0001Ra-U3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:29:23 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZaw-0000P3-C8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:29:19 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d93f4fe5baso4438295ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746127755; x=1746732555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cOHSlVnVUYbsq+LzS7RdKhTmiXHT7BnynLD9UnP6g6Q=;
 b=qzWQGaEqVL5o0PJh7GuWqKiMICe+wwrwH5ciJdJO1GOcqcinmtxG4xrNFl1Gt+RGKE
 /BP2fTcWtwP6Ldckvo6a0Zyd2vYq4i4VN1fDFgoI/thzv28FC7HArkhRlGUXFUHJtl09
 Q8zW93h7OdpO4He8wt8vu9rC/hklhai3ehJChgG2WyxBr892Z9ufJrwCEeorQ4I0WsjX
 Hm5CnxsKtBCSaj5juyBFA086V5VgEhVwHYzjK8dgzIPQ0VceSIsUhy0AN6HmZ5YL11FW
 9c0DaTqQjBmy1aLnuANeXvft/zZZ0IZNni0VNXIQEINp16KVRN6dKzBhCXSNeNPMRzo5
 qSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746127755; x=1746732555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOHSlVnVUYbsq+LzS7RdKhTmiXHT7BnynLD9UnP6g6Q=;
 b=OcSfMZgLkvrb91VfAev56eAI8494mBagnRzKAPdJ6QCxciRhzfxWllHJxjPs5y81Jx
 bfsBvkbVevb1KF/PQ35gWURNAaAfw4E2C01QdI1dCAH9q/LSUdXvYhp38iYXia1/zAKn
 7A9q+yQCrVXotg6Ks6IO10129PpyUoBikkqIU4bm6iGGo/DflDcnOsuUltfk/65QbzsS
 UYbCZPqb6m2AJHA44I6GIO+fgezcbaJJhMo4L77nmpjQAQUlEoHjAHkPwukx+B+Bxgjm
 razhbSOFmDzFt8AYtqQh3Ws8QkjG7ULb4gLbBQ73N3oB5X/8ID3wDE4WcAOEHhTc4m7T
 raCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfl9eh/+4uS+l9Lddnq9TdmtLvDoeJ2sXgEVZlLx2ey2HB4doMTnfrBm0SjB8/3EOxu+PqJ2HKk1cY@nongnu.org
X-Gm-Message-State: AOJu0Yxkyuqfd7PYcNaujXsefzj6WRZt0cf/UMbIjNCKmMkcbY8Y/g2H
 C7Ue4sv3P888mr/3Ix2/OS1dbRRJWhp0XAOrxn1mVMdU+ldJCrShMyklprkDRas=
X-Gm-Gg: ASbGncuiD8g6l5osWTucfzwnvYmrKIAt+LylzrH7pz8rcwjEvwGb5GS+6wEeHCfwJwi
 h2rASBVdLscbTcCVNMDPHgna8gj9uFlVcRDCLDRCh5cg++1eEfdIz4hR4eKNfUh5gAOdlt/KZ3C
 xGMJkPp+ul1+5rBSvc+cVTtSz0hbQor3Oqq+jpsX0e/Kbc1Dc8N42dZUpvtNkGeNXBm+J9m3nSk
 q4/VGjdnVZqLzMap6ElWU+5OFG7nVlEpvki3SXR4zSqrk1riBSH3t9J46zoxiSC/mPbjfvPJJH7
 l1fX5QZ8pUX01kiBiIHfNEjULFrE9gfh0DE7ySbjIAXl0+gE+dUoaFw7i9lMOfadr84TVwh1TrQ
 01F9J5sSihz6+Jg==
X-Google-Smtp-Source: AGHT+IGmmsBx1v0Mc9NmngwCAaVLMxSI/zjfAdzKAyEaHpmHH+kM83IMv5j4FaPz2DvLozh56NJhYg==
X-Received: by 2002:a05:6e02:1a85:b0:3d5:81aa:4d0a with SMTP id
 e9e14a558f8ab-3d97c1705e6mr1486405ab.6.1746127754958; 
 Thu, 01 May 2025 12:29:14 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a8da518sm12648173.16.2025.05.01.12.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:29:14 -0700 (PDT)
Message-ID: <e9c82559-77b3-4e5c-bcd1-05e39c8c7dea@linaro.org>
Date: Thu, 1 May 2025 21:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/33] target/arm/helper: expose aarch64 cpu
 registration
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-22-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-22-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-il1-x135.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> associated define_arm_cp_regs are guarded by
> "cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
> target (32 bit).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 7 -------
>   1 file changed, 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


