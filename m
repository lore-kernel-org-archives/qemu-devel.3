Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613AFCD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnyU-0002E8-M2; Sun, 31 May 2026 17:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnyS-0002Dc-HW
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:45:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnyR-00082T-4O
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:45:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso328829f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780263933; x=1780868733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=waPpctzfOFksuANLhh4IqXKNTUYxd9EvBZ05WImIpBw=;
 b=jWydO6vVs6V3A6+3nZmOuKI5ur9HDOWq0W7HvTGLUaJ3H1mci45ovaYRr8yEY6hhpr
 ChPZcz0dcN4Y6AlSvvd56P7Nk5DypZQ9X4ya9DKDEap6gS+o2oRHRxTvsqCvHyD7G53d
 S0jIasEK/L+OlHRxadEr+rp/HKF9yAXd52dy/hNKWmF3pHkei9E9JR1lmoPP75oXycs4
 3AoPkkFlozCJGxa50D7jwyaKHMzutP6I2yO0ZXphIxNTOi9i0RVziIMWY7ClY3MacHte
 L83Df/vbaQ84IziLbA5XK81SlE4CzS49W1yCVHxKyJWCrqyxzW9i+OK/C4k88enOkjEe
 ZrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780263933; x=1780868733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waPpctzfOFksuANLhh4IqXKNTUYxd9EvBZ05WImIpBw=;
 b=seYVQGjJKbUxJtDB7Enb4bd8tZmuajuEayNp+ervFQfiqTb+WYo6lI3/mN/aKta5S+
 0/vMomx30LLwK+BJOp0bSqu8plycvoJZAk+MOUHiAlHo/0eGUEEcsG4t01cIT+M+ytB+
 f6qGVJW/e7ivSFLKKuMlyaME8alV2/cKl7wMtqIAH55zRhRTSH0wEBDRU2y1kDyEWZuc
 QGDuno4Bpmz1amm4ZKM+fcqcn1MPAMPSZDHxrMnl6kDTWFaOWaWB6MMe+9myXFPvWvcD
 fj2+hlDVrRS45thJAt7TEOZeY8lmzxatQzETOin64T/s/e4Z/GSPsHZDAc8tBfPNcDxX
 COTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ktKzxYAbBqz7bsUn1+u+t0DPo55bD1nD2ca/8gwO0/3IMhF6Egz1nEmmGejpKNrBB033JADnpPjPJ@nongnu.org
X-Gm-Message-State: AOJu0Yxtw/cd7lGUgW+x2Oz0MdlLDOsjLLkFoJY6aDKIgcfWaVvQjVpy
 /NQF6o0uCm2R8Kk0jfgbDW6S5V2YoDrQdgxJushLIUgi0Ow9WrLMCswFUSZzy7A7Gpg=
X-Gm-Gg: Acq92OHjEsABEhOlnb6/lyTDyQ+IXdI0rYg4mnrEBTxIQAS4JW+Ov7y0Wtb9e5+R7zf
 blKO+Gi2m1iotw4zijFdW3NDKpyOqXpl57UAeiOFt8e7F7byMtLxyN3FJuVADX0f/JRxOrTKvyA
 DR8oyrQXGq1HWjn8ai7kWait3/CMZyBWY7cQtdypN/VCG7BdlKlryIZs/4ehtKw4u2E054m2CNi
 aefoAvcvbszU+07Kz60jyd+yKTokNpuXceCMBRqOjmY52z0csKOTprhuxN3YCVamNB4A7kF3uxu
 J0Y0w96M0xYha19u8BG+WnWBl4zcCi5OOu8+cmbTUVlAMZgUad3glatSEoHxt/H8aPO4NHyvhSg
 DRTGWuVfbL9ZqDmeGt/TeIA5LQW3PNVG/Sf/kNcP1/xxt1L8wMX7rchFi5VL0UzFSn8OknzZEiU
 7mVa3WF22sbZm0ffu+2udVsNwvvWxm6LYHWxL5TxG4qCx4MEQPTfIMtmHhCMtkN31K06hgfqond
 vQi
X-Received: by 2002:a5d:4566:0:b0:45e:f5b5:885 with SMTP id
 ffacd0b85a97d-45ef5b5139emr11501168f8f.2.1780263933488; 
 Sun, 31 May 2026 14:45:33 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356a4c4sm21022904f8f.31.2026.05.31.14.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:45:32 -0700 (PDT)
Message-ID: <2440030e-99e7-4b0e-83ac-6a0d707ecdd3@linaro.org>
Date: Sun, 31 May 2026 23:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] linux-user: Use PGBRange in load_elf_image
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260530211248.375318-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 30/5/26 23:12, Richard Henderson wrote:
> Collect into range instead of loaddr+hiaddr.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

