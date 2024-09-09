Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C05ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmPg-0002Nc-Ii; Mon, 09 Sep 2024 17:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmPf-0002N6-6L
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:59:11 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmPd-00072f-N0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:59:10 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53659867cbdso5808662e87.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919147; x=1726523947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7TUnFYGTb+v1A2nMIGKdEQ+UviYFwdpokXcyyE0n0M=;
 b=FQk5d4v0RdlqFY0t/zNc/KINJxIELumFrls3gXffSyuvpdumPZc59nN7dMDttUqrdu
 XMms9JD6ILWW3mvwmGANWyjAwSZP4IuwuUmTn2G0CRGTkr98/v+eUpwKoeQsV6FlLQ1A
 gXKTrfU+Kz+lSmhVqw59WzApEx4aAYQtMfT2GCeHjGaV3p+3igC9yBwYhh1IFFqZMsJK
 ZqSWrihnksXHkkc5JuXiHtaPMcV4pJg9RlIgLxUFKmeokKc0C9aLpEUc9mTIGmv9YwmN
 Wwr+AoOrpr/flH0HZGfBdBwPK3/75b2hyGbv1Km1rEGm28QfPLFlr1pF96iVt/9Fd6cL
 2d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919147; x=1726523947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7TUnFYGTb+v1A2nMIGKdEQ+UviYFwdpokXcyyE0n0M=;
 b=OXgbC08uhP3qW1/lhnRObOK9rhHRINUpZgtnnAUgwe8TgGSoW/16r+nMwV+fIn7O/n
 EOVCcKkk0WwBBzP5kfsgIZrWjvbWAU7e9PwKhloaATuvM36Vx1SV/w7FpPkDh+14xQL2
 0q/gxL0dx+jDw+19mfod2n560DNpI6fGNmjDUrdOs6No14o16tOQimHFhsd1XLWLYnoW
 uYxCnBvN9OjuYynBsZXi7ar4cAQVF5K8m43nxWNv/uKm7ooCvHJWWFFhR1tYIaRtqtzj
 AUAjxVXLxlH23yUTrV2rn6Vi+RA+ORy/aa3WtsbHwKiCg38kV4M1CQgJkZc6gsT/WzVL
 wV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCcm/FjZSA7aplDQJRJr+ilHXfvi5PXKTqRw/CHMPcVjEl3JyX5NrWFHG7B7002jfNII736otnm1St@nongnu.org
X-Gm-Message-State: AOJu0YyW47bbMM2mV8A953UbitODuXhChE/Q480DVaaRUUAqrMFty/i3
 2dP5Z5Pd0/x/Ez99oN+gkUY+lLbXlNEYiW2Zlz3QPID8GZ32+r2iAOMzWPn4naw=
X-Google-Smtp-Source: AGHT+IGDhKjnhG4Sw84oOhu9KYNhvfAiF+oyKGBgsD4srSSvv6ZEY+uxyuMQhBPye+0TAkt8GKMAMg==
X-Received: by 2002:a05:6512:b03:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-536587a6800mr12028342e87.5.1725919146477; 
 Mon, 09 Sep 2024 14:59:06 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583555csm395459366b.15.2024.09.09.14.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 14:59:05 -0700 (PDT)
Message-ID: <c969b1b6-eb46-44fd-8a2d-7cbef8fb27fe@linaro.org>
Date: Mon, 9 Sep 2024 23:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/26] target/m68k: Restore fp rounding mode on vm load
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Call cpu_m68k_set_fpcr to make sure softfloat internals
> are up-to-date with the restored FPCR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


