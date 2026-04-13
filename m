Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836EE9380E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 03:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8SJ-0003D2-Lh; Sun, 12 Apr 2026 23:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8SH-0003CW-DR
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:59:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8SE-0002KO-Vj
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 23:59:21 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c74244dc0b3so2419964a12.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776052757; x=1776657557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DxRbxg8Dl45tJ3KaekQoaNpVkcP6TDtqvHIeRgO74Nk=;
 b=wFPrdaFeUkZJdk4H8FmX+aQH8DNEgizCoMZs1LKuVtspSDuEDGTiVgi/cIFsE/+Qwc
 la2boQ+/dwHY8zTJ7X4L5iMN0FptSDU3odhcDvnmN43/xckISq0qhFijADJdkuxenIMO
 52B+3AsiSXwN1ggpqG6CZM/sEQUn5AB+ItOns5IZDn98xZ/ja9Py2lNOXd7oxOYz9B1X
 gjsZlfqtTvENQDVCh2FvdvBQW6ZwRhoy1lkjyxsED+8bmb/FPv/Msm2TTJRsc6CCB+LU
 LTv/Y5l6dImTLog9ZFV3yBYccmhD76dEBZM5Gr9kLGhKC2xVKEeZRAJlGU+GdCCP1huj
 79vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776052757; x=1776657557;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DxRbxg8Dl45tJ3KaekQoaNpVkcP6TDtqvHIeRgO74Nk=;
 b=aMQ3tpvu9c4L0NIno11yRa5hI1PrXODHUqkEsSklqYlPTFiRQEzmsiWNxzl+ICF01j
 9y2ibQjyLkRanWO6LdjcoAh06UqS/aEx0wQ+H8Pjnr+TY7Pnk3lDRZNod1/u3Qa4ie3E
 2gik6rlDWMhvBCvDBV8TTaI9AmBj/ldAUzpTSSiOOZXb3mExpCw5X1l2JMa3qbrj1nWI
 fTm2dVySZbDnpyw4AuX8SQ9rS8wNvW4edMxlVyJIoSwDngfn9NZAaoW7aQd2zU901uR6
 dq5DXu7KY7sukDXx0c6ztGZBdWCU8cDFjRA13ekAA53iYGn40t4fOeKS6lIkMhra3el0
 1enA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r9mpNgBHNXWEjS+L3ylM12VxKPWhiHFrOmTcm96gbr0qiXpcyMrq7KerDDnPwEL9qK0uxQrL0Gfzy@nongnu.org
X-Gm-Message-State: AOJu0YzIuBsRpja2lvNcj0Zs7VpFdMkIrfUbDekfmjmM3EQeDqQYEPuI
 MpYc+fcEFrMFtXtgnq38CBNSCozA3XvZJ96z0yNyuLNNoBmLqWrrsqJ7vZYB/z48U+lE4C4WPil
 NJ4NT2Rs=
X-Gm-Gg: AeBDietRl9NQnEdgDvKkyKcO0t0c30StWLVeEANA0YgCo6IPHwtOv9Yw8AQp9//I+Tf
 4qLnfUcn10rn2OtUlWoq79s1JrhJM1ggOV0Y5OsCxnUf31eh8OKTo5nvjKNkdGvwGLZOGNf31eu
 wbPR6C/D88M4aksrlKDMsT5ZlJghaeKBRF9zf85NQxRJxZdDombkZq0bbAPzLtGyp16mk4WrqEs
 FbXjjuGzWY1iICv2xPg4joWW7/JNJhvSIl6M8ls9LM6ZmH8FkyDlTOHLCVZDLasQThTBj0CSiI8
 jU4K0K83vKNWH6lRNYIQOKC9MOvvJR3kjEMVY2HsNRwQjW5OwkKWfj4bcndWreKIxmhgo3ILBMH
 OFr1M19+uZBdlLG8lutKzjD12SbTOys939iAC/avs+UgwkXvmYPaG3LteJ9F2E32qGWvQxC76r+
 /YfNyIg3FUs5jySG4+i99q6SkmVR7ZX0dSheWBkODaihjz3MCbxsrSgEmgERT91HeAD/X2qAir2
 1aWMpsOoEU6Ec9PmCiEOqtb3t8wN1a7U+RYQhb9rz5R0abkJ97OjIc=
X-Received: by 2002:a05:6a21:338d:b0:39b:f433:945a with SMTP id
 adf61e73a8af0-39fe3f3f110mr13413019637.35.1776052756898; 
 Sun, 12 Apr 2026 20:59:16 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc424sm8401019a12.9.2026.04.12.20.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 20:59:16 -0700 (PDT)
Message-ID: <41c52a26-d5bf-40e0-a7e8-7d8ad8d7bc0e@linaro.org>
Date: Mon, 13 Apr 2026 13:59:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/27] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Restrict m68k_monitor_defs[] to cpu.c, register it as
> SysemuCPUOps::monitor_defs hook, allowing to remove
> the target_monitor_defs() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/cpu.c     | 18 ++++++++++++++++++
>   target/m68k/monitor.c | 21 ---------------------
>   2 files changed, 18 insertions(+), 21 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

