Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6D1E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuR3-0003Bf-6Z; Wed, 18 Dec 2024 08:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQx-00030X-9z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:51 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQv-0008GH-Av
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:50 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21683192bf9so62272045ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529786; x=1735134586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XrOGLllFXH+C652gZuYQ0cg5AKkPqtfSn9PKBIlMYJQ=;
 b=EvB4Cs0yrdN2kCdUwxvb8BG4NHQZivJ4XmjRnSylVWzJm9cp3HAH66W/hiqWPDxL2O
 Cj7loHKcB5q/l34RszJYhs60NKlqjsFzdofFgpt1ADMN1xtSufQx3fMT02gcO1sDK0b4
 Tp31x6F7JNncLMTkrMwlTW73EhFVW0MCK6T2MmGjCYn6mtnqkRtIhNTK9rcxEJuupgnF
 iwpWtiULUzR44T6Bp5Bi6YoiGECMM3KgkrZlCbZ07HZ7hppXcZkbpzM7oaopWsBGbgjE
 pUHgSDbUfKfwVhUwLZkQSxrpvWBR2UQWaM5R3xWuc/WAyaCYxfUilzl24seO5a3CMj3s
 EodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529786; x=1735134586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrOGLllFXH+C652gZuYQ0cg5AKkPqtfSn9PKBIlMYJQ=;
 b=HS3KhbK0Z9SzwGZgXO5Bs0l9KQVRuQbTQ/bfqCy4vYX6Fb1CfYj5VPRP63q1T5G3k8
 6VvFRf2+NdZPSQu4duuAKGePvH9AaUJIVXyzdpwKSP9yYh4i0voYlCrcY/6SC3PdigD0
 6IPHz/lwaTD7pI1D40lp28BKbR9cnbZthws4iFPKm8lQLR+UnkUoDVeqSXSFMS9xYKgH
 z3X8Wcv2855Y6CL1LsP7JyGD4vnzGakQH4tOoWoAy+NdslBpV5X5giAWdxeU4bLj4e/X
 /wKSpWXH4fLOptKEIH7TMirGtIwCFoolqKoaLXFqKtQWlWy/TyDJ7igLgwstlKw9OJEf
 s3dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAdmufZumIqyuPW9FRvyg4IZFELfwH7nKwpRnW0ZwAeRPZ75LDtCTiMprpJ+13GSW5bCcX6/JvZZtR@nongnu.org
X-Gm-Message-State: AOJu0Yy22uIuhCDFpp4r+UEZU6unCpiTF+jQKcu9sAKDCajjeqCut5/X
 KB3/V+3k8PXFo5v3aYxIE5VEWyMUapRvfyl+8aI+IVqmG2YFVqVT4KrkEZyydtA=
X-Gm-Gg: ASbGncsenYnvIi1IM0Tho9A9lIlJP0Hi/Md+Cd1/PvdkyCgCfJbiQOGJ3LF/ZgvQ/A8
 gjwI0QnFWSefFIafBtFX9B7Ob90GURUKgEVr/moBgdj/Z+fEOZ2UP37Kmvc46rzP8dRFx/zCCXC
 HiH2nUIAzZHKWa+ad3HzfryxAuOTrFsXu8v0DPhCkXoxh5RBLIOzqbU8zzzQVkjw3b795U06l44
 xPKdefydt5nQDFpxWipFfjoRHsiQ62fYq5ZFLrq1begNJuLHzvFbtqUJj9p1jrNGxrQMJUB
X-Google-Smtp-Source: AGHT+IHpUQOm0d9zUR4N9mGODQKn9rzWCSEXec5vhaTs5MK+fh8JxkeLY0cD7nApRrFhp4G9syYz9w==
X-Received: by 2002:a17:902:eccf:b0:216:32c4:f7f5 with SMTP id
 d9443c01a7336-218d70e524bmr34460155ad.19.1734529786652; 
 Wed, 18 Dec 2024 05:49:46 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db5de1sm76224345ad.19.2024.12.18.05.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:49:46 -0800 (PST)
Message-ID: <99b51335-c2b3-467d-bc13-e57ebce44581@linaro.org>
Date: Wed, 18 Dec 2024 14:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] hw/s390x: Remove empty Property lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/s390x/3270-ccw.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


