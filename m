Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD7BCF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t012U-0006QI-3D; Sun, 13 Oct 2024 12:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t012I-0006Ig-6h
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:01:40 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t012F-0003PS-4O
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:01:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e579abb99so551440b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835292; x=1729440092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFbtyZEb39FL3bkMw/0UQ8Mn1CL3g+A7fBM14Yr6fbI=;
 b=BJCS2cMwvag6LNwyU+KhxfmhvxC994AQROBEwy6Ig71rdCihFHGHq9u12ZsZh+zOj9
 YgyzANjlubucWqI9xK+V7Gq6R8oRmaDltzAXgHhkWIKYi+Dj5H2mBjBJk18Ul5qf1oLy
 wxI1XXA8PYqeYradEpQkfda75a33vEgAsUUl7mnWTXRWhz9QMniuTgSpXD38ZvB/fjGR
 Bl8O2h2D0OjlR8DHQ8Bw5+IGiYyYD4FTRQhQ0O/Iti9v1ynraxf4xPqFZn1wWocJUWmZ
 cp1nWqhL1q8UwWMbsLL3M0Fjz0vNHdaJMrJy19TnNb7NP1zmdjJ2A76xnYsaVs79bWLV
 UNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835292; x=1729440092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFbtyZEb39FL3bkMw/0UQ8Mn1CL3g+A7fBM14Yr6fbI=;
 b=G3trikn7N8mPQJquubzF7F+L+Huk7B8arChSUCsoFdThznrEY00TE/+iw0IPApAfqU
 qVtljK0aIuTP6UHMTmK1F8xAzHpQ2wdnVsW5Np4y1OB0531tPBxuP7jQpwyRKGzUCEP5
 BHLZbhgbsDMfXzrE/9zUZSxvL4KvTmd6MoSCt3RYusgWG40nWldTbRbJsu6oXz2iBfiY
 sZysbXfWHZBsoTDfce7AAjIo6RrnivJl7hXKxQKvzhxylI9iOhiAhH4PTx+8pAMV6bM+
 BL1KrRWX9C8EJy5Q+hGU4Tz0xpbWPR0w5acEcapaAR01G2IXxg4UxfUMV3IktFhfyukP
 I2fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDtGXj0q4XtIJaYR8Eq7MwkAis4sJixWvRRtvULDZakVtnRDITj9gDRIYHV9h8cx8x5wBl7jc/CE0i@nongnu.org
X-Gm-Message-State: AOJu0YwVCaYAhlJxQYipvEMjFUv3x+f9fDHuVxL1CKlPPIbTVSR4l5FQ
 k9YnKjJJZql5G1ZZbPFlk1KmNAQmC3Gu0VBNaO3CO7qvmsKFoHEfiY+WL3/vt7o=
X-Google-Smtp-Source: AGHT+IFdVji8r+v1z4YDSc9RYdy+/v7MBrwAijKaS6gwnfHM7eqH6ZVSOKN6ovJgisKSFySYxxj2Nw==
X-Received: by 2002:a05:6a20:34a:b0:1d8:d8c3:fcac with SMTP id
 adf61e73a8af0-1d8d8c3fccemr2017575637.6.1728835292444; 
 Sun, 13 Oct 2024 09:01:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e4dbad815sm2978548b3a.175.2024.10.13.09.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:01:32 -0700 (PDT)
Message-ID: <5551b28f-43ee-4004-b677-53459cf764d2@linaro.org>
Date: Sun, 13 Oct 2024 09:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] target/mips: Introduce mo_endian() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
> Introduce mo_endian() which returns the endian MemOp
> corresponding to the vCPU DisasContext.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/mips/tcg/translate.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

