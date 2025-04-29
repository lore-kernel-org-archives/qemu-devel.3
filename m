Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3D1C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9efA-0002sF-DE; Tue, 29 Apr 2025 02:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ef5-0002rq-5s
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:41:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ef1-0000XC-2O
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:41:45 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4059192f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745908901; x=1746513701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N20g7q8+jz3n6iwYSqv5tG9RdHzqq2SwTudMigGh1BI=;
 b=eSzRTdcTdvt2tYZ/ePAv+Ug5orWxtck81ZRtZMgzwHm3QbEVbFQBBthe2oDygnTgyo
 IMreJA3zO6dwLifmZn8zx0NeT6FDzaz9SWEC17NDvswlNWHZWOZ1SfFFOqPoDOprQCiF
 dgYzOPHgmH1StuQNQ12oaCnffj2GZ9jJrK2EPCjbq40I8MBIZrXEAMNBfxhBoY+wd8Zd
 G2+Alg8nKCcrpVhCga6fL6W1LDl51feeLwY51Yxq+H/WqifxhI/UCjAhDWHNuwzLIrf8
 5U2elvcFg8WVRbY67vJcMpviwuNj7xBofbEYWyGQTYc3ID8/F0sWZ9Etuz+OUjg71UqO
 M+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745908901; x=1746513701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N20g7q8+jz3n6iwYSqv5tG9RdHzqq2SwTudMigGh1BI=;
 b=QxEkY4FplXBfc4XX4bKyiIVQr/63CJIA/AeCwFycwcmILrVCwGiE1M59MNZKVH4zDc
 h/i7DuiIppVP6PZyZz51J3TIpAYnbe0JclOSnwzeowwOaKQTmJcir76kOf2/u3iISROB
 K3kfv8YMLW/GB26aAvPJqQ6bwGvSfIhyaHKyqXryLgIZRm1lZCqHL9SyZuHbAdB7pWr6
 E5rRF4wzp6DRaEhKvgtM8PT1cz6mus0tY2gQIKQL8ZkBDWxzy/8IPOhXcPWM40/iOVR4
 640p9FL1nauY+b3IQNRqzT2ehe0c9QNH59CHi0pAJ9bTTLzflw/VdmKamIA5nslYjGse
 R7Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV72DF00tSHrruBOXwDpoELI0Cqu7c8ijoH6SkK5OttZpQ6T3oTxNHt/LJUQSHTsD4aEBoRzVcWeJL2@nongnu.org
X-Gm-Message-State: AOJu0YzjDcYh+lZcRBsH7oozsXCFQ92gsPQAUNE351yiVOedo7NegS/h
 wOtOZa2m2C8fCUWGHa6DI2PZerLxXP+PMd8z2UxBxekbKNne9F+Znp4SLjcf5JI=
X-Gm-Gg: ASbGncsYJYcYVOgvl3Mb63ULrqe8DYaQenJTKNtnmq3qeUK3FYwWquqT3iP8BvdibKX
 Y14SYEbmy4Zv8gz8WvBBgaqi2HbjNyAkhRoR9JxiFDZJt0NYoSwYGmFgA/8wUAVgHO6q0ZvB5Un
 qDq5pbw18mIvHyV4uyYOk+tCXjV1tiCYfgbXOVDPwGJrlg6NCmjiOdXJQ031USDGH8Ktaf7uu/k
 WUUjW/PifI4LN5J5qbF6wvYEHYmkZU49qJg1z0PfrrfwfX5XfcxiVihNLaGomOrN840fWtMBAmG
 1q3312fTNr0+HecouuObE55SZPskruit/meaFAvvUZODUtyBgqqUUQdvwkGRB3IjCSX0/Hxowws
 SPpILa51n
X-Google-Smtp-Source: AGHT+IGM/6U68NqfI01Xoy8zun/KOA+r1zmo7BOLLLK2FG/0SfK2jGRopKaL/2dT2Icl1BTWRq5Fnw==
X-Received: by 2002:adf:e548:0:b0:391:2e6a:30fe with SMTP id
 ffacd0b85a97d-3a07ab9bcd7mr7573454f8f.39.1745908901480; 
 Mon, 28 Apr 2025 23:41:41 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8da58sm13155853f8f.15.2025.04.28.23.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:41:41 -0700 (PDT)
Message-ID: <d1bbb933-8f9b-42de-93c2-b1d7ae984553@linaro.org>
Date: Tue, 29 Apr 2025 08:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] accel/tcg: Split out accel/tcg/helper-retaddr.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250428201028.1699157-10-richard.henderson@linaro.org>
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

On 28/4/25 22:10, Richard Henderson wrote:
> Move set_helper_retaddr and clear_helper_retaddr
> to a new header file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h       | 34 -----------------------
>   include/accel/tcg/helper-retaddr.h | 43 ++++++++++++++++++++++++++++++
>   accel/tcg/cpu-exec.c               |  1 +
>   accel/tcg/user-exec.c              |  1 +
>   target/arm/tcg/helper-a64.c        |  1 +
>   target/arm/tcg/sme_helper.c        |  1 +
>   target/arm/tcg/sve_helper.c        |  1 +
>   target/ppc/mem_helper.c            |  1 +
>   target/s390x/tcg/mem_helper.c      |  1 +
>   9 files changed, 50 insertions(+), 34 deletions(-)
>   create mode 100644 include/accel/tcg/helper-retaddr.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


