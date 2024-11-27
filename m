Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49857D6ACF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLyx-0003bX-ED; Wed, 27 Nov 2024 12:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLyt-0003YX-Am
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:37:39 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLyr-0004p2-T3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:37:39 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb59652cb9so76616201fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732729056; x=1733333856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnVeKhxaCYr2jqeRRLUkUw9/ulJHjpcZJYWy3yaxGM8=;
 b=avO9vVtkV2/7WGVXSwf92kFVC3WpmezwKE473GILckObxhu0teS/VgOrQTn36SR0Ro
 z4s3Heg5rjXvDi9yBnhxEUjO1WT0p+ko+0mGfHnnk+uZQLxwjSQPa5rQqk4PKkdmNJZf
 biILVh2Cy4NEHmLr1NjMJDCo8J1iGqCr/LETg5PipL6fP2V7afXoUF516RiUim0UybhW
 6R0mbLx28T1mihICydPrUMq5HFI1P3rXOIlLxOQbfYqVIctVjApUWOH9GV5CVtsB8cj5
 pha2HWDkO5OS/kcXNfP4lNPH5cYfM3Lz18OE51lSg5Do3F1gAsvf2jAojU55blBJ9H8d
 jxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732729056; x=1733333856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnVeKhxaCYr2jqeRRLUkUw9/ulJHjpcZJYWy3yaxGM8=;
 b=fEW74uLA09Xl4q3r6bJoINFlgCPbnwaQ5GitHUnhbrYKUtQrcDb3v+LqKagpzkZiUd
 DaGMwpudXrSHImTdJn5y3OiXbEha6PkUk5IeMDDyWnr8SCSK0wi2wPShM1OVPm9DkqdV
 w85bjS4WKVp9lSaJF1GSQIs1eHF2Z6APnKXmpTWCsijTiRYMJAtGERdok6U8vlC+IUBg
 5mvV658+GYehK9ew91pU8iHrRScax35lbvRKVbRL8MmqXmMGyF/kiJ4IWtefRS/jJPRg
 yIUiSqt8RE3HHLXOELcE0Cb1iJe6W35vZuKdDB0zFQKjPdhpQXN5wzMEqgQlqbPiHYdK
 VgcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ8yVCAAZWWSXdu/KIluYTK8QfJ/MQ9bkyBrbn+X4ZOuEo+MgWXI8PHFAl+KRPgSmMiGfboaxcRKaL@nongnu.org
X-Gm-Message-State: AOJu0YyTrqck/88/y35kb5MJOJIPEXOESBIUgYZTUw8zeRXGOFMY/1Hm
 +tHAkWE9q5gN0hkKoNrT4gj395KUPNe+fkOItSBGUfOe3jNG9ErHEnxW5X5qnAM=
X-Gm-Gg: ASbGncvjxZ+hId4zvSJ/RowrKxZmhKW6OGBMANGE0P8LF6oZprmaS4lCBgBXrjb4DsP
 nTZBX74Degx53ARDEzk3nmy17XzRAYUHbdTah6ADj9FgNaGRMvDH+RMrQt/mlG8RGTQmd1yiGga
 rXZH90/6tfqeUWC0+3gosuePrBKsx4c7lbiajFnKYt9F/X9nAF16KF2bxWlU4pAOlMOBmXRRoaz
 pbKaeYwGDVNn5zSqWvvhFp+KfJxwQKDOVMYgInwIw7qhFJwGHkZIWkcqM/AjBa91k4x
X-Google-Smtp-Source: AGHT+IFSP+Kns/hnJCRt9t9MDQzgJUdOBALb+/E4JEcnDbAnoAlGsMchVfUNaB0xhqZuaCGoHdZAzw==
X-Received: by 2002:ac2:5695:0:b0:53d:ef60:ca9d with SMTP id
 2adb3069b0e04-53df01122cdmr2523867e87.55.1732729055839; 
 Wed, 27 Nov 2024 09:37:35 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd24513c0sm2391778e87.97.2024.11.27.09.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 09:37:35 -0800 (PST)
Message-ID: <dec361dd-70c7-405d-ba68-def84e1274cb@linaro.org>
Date: Wed, 27 Nov 2024 11:37:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 5/6] accel/tcg: Add TCGCPUOps::arch_id field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
> When using multiple TCG frontends concurrently, we need to
> be able to discriminate by target architecture. While we
> can infer that from the CPUClass,

Can we?  I thought the only place this got set is arch_type in system/arch_init.c.

> it can be quicker to get it from a direct field in TCGCPUOps.

Since it's not currently relevant to other accelerators, this seems ok.

Other possibilities collecting a set of pointers (e.g. the called initialize_once), or 
requiring that the initialize function notice the second call (e.g. a TCGv non-null).

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

