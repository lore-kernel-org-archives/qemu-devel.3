Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95932C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 07:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te7yJ-00059N-6j; Sat, 01 Feb 2025 02:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7yF-000553-T7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:31:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te7yD-00026e-If
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:31:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so31622705e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 23:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738395072; x=1738999872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/WhZsq896KEikgXl3hrYIDN1TZJxEljMBSUI/at75Is=;
 b=JjgtuKQqFDSfD5v9mwlJpep6p/ylYekYzil7FGLSHNOsh3uY2FKa9bM5V6qdUMEk59
 CPn9LF13w2HCOgCfebUlcDyDyDj+SmmhHiRYbpDUa/6YmcA/sdMSia/VbrePjNod9Bc7
 d+0lv5n/bwaAywUpf/4hyi/dsINJpxr6v56Ub+p4dC50AV3ChgSkbzihjfj3p0ufRc+N
 KImOKdojGbxQ4MJf4hmSomS+IYz0LaJZZGhWJaK2wd5QQt435Aaf4rmYzzhvE7XMDoHp
 vXy4CsqQy/Lcpu4ct0hoAFWBJvbPaW1EjrXW31Y5AdFcZ6+C58WbPhyOvO1RBQcZrOzZ
 pGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738395072; x=1738999872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/WhZsq896KEikgXl3hrYIDN1TZJxEljMBSUI/at75Is=;
 b=HOjzP2WgSsV+dZ7IlYwsi81c9fTUkdgcTx5Z8FcLG5IcydPkz4xhYA3atEooPl/YNQ
 35F9/D2Qk+eU/H6wo+DNN4vLQXIzOelYbXJATy22hcCz3RpxD3Nty4+zvn+yjqn89Q5J
 GE2jqBVhILDo361uwqx67j5HdNZS8F3q3NGjy+tHnbHpqhoIfaTSDWAi5No3oteock9M
 tlpIdyVzGSozyOZnZQ5zP1JhOfSjViwtO7PfI8Urq4p2cvgY7K+FqucYajiqgGK1pi3R
 SdXOz5cfaMeipbF7dQEkhW0xUTXAZQHGlNg1xej/R5iL0Ra/+JrcxUO/TM7E5Y0pIEy0
 jy4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEaJK/xmY3xeR+k6Spa86OxAybKH9to8k77QXVoPv3cy0H6So3b6zTeBpGeluUjxnGmlCWJRKfp0T@nongnu.org
X-Gm-Message-State: AOJu0YzHEU1rQl6URfe8skH5hZkQyFMSPMUMcEN4vXeoPVnelDZXwpG6
 0YIG8rKWyd9Zd7tjT66XzBElSR8+D8LMClVph7QNsEGmEF9qPWTNCGye83sm+sg=
X-Gm-Gg: ASbGncuH8k+Dm+SAVGyoS/xIRMVPqPPAmoXIiZRERLqmFEn8ovUtDI5UjaiByBB2o4a
 M+e99O6q1nivQHSdr3kZn6bFvOjoDUiCmlIIdpg0lA5U/WUmZxARXykBj/cPfI8ELtNaFkiFM5c
 rlTqQkudRclsT7sxyKZ6P5xjAksNvTDlp2Ka/XJ0uLszNAKqcRY/AVHC/4mV4IE2Gb6yxXYMWlu
 mzAHICbML9sEB++rYHd5Gt2NzMkodvS4MP3EECUE5gH9uWOr+m75sPH8b4sanzWW7fonNyttl9V
 ogOZ+LUZ4th2/LKZd7Mcrz8kSXms
X-Google-Smtp-Source: AGHT+IGjabXuScDPjcoDKpFrRUYnVXvwEh04prGOGfnHkHtIytvXzcm1iOH3aPHCt1Go52whE58Agw==
X-Received: by 2002:a05:600c:1c1a:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-438dc3c4623mr138572325e9.10.1738395071810; 
 Fri, 31 Jan 2025 23:31:11 -0800 (PST)
Received: from [10.1.1.154] ([45.93.146.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d4456sm80051125e9.7.2025.01.31.23.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 23:31:11 -0800 (PST)
Message-ID: <5272691c-9bda-4f9a-a79b-88d8d3d7c7a4@linaro.org>
Date: Sat, 1 Feb 2025 08:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR
 traps
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-12-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250130182309.717346-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/1/25 19:23, Peter Maydell wrote:
> On XScale CPUs, there is no EL2 or AArch64, so no syndrome register.
> These traps are just UNDEFs in the traditional AArch32 sense, so
> CP_ACCESS_TRAP_UNCATEGORIZED is more accurate than CP_ACCESS_TRAP.
> This has no visible behavioural change, because the guest doesn't
> have a way to see the syndrome value we generate.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


