Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B67C021B6
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGJv-0000Hf-51; Sun, 23 Feb 2025 13:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGJh-0000Gf-P3
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:03:04 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGJf-0002Ni-6m
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:03:00 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso7487167a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740333778; x=1740938578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ubDPHPRJKF93TJnMnaYQ03b9jO8zC3zQO/AmjLB3G1Y=;
 b=tWOaqh61yfe28ar98WL6GJU+2ghJEtXOwQ22eNZHMT0a9YIZomBMKNYBLmWJoEO77U
 ehBFkEpMLX4ZtPDmSGE6P8WQ58bwTfAEHWcyjxs3ju2I74WVFJJ1yyYvvUo1yiZ+5SzK
 IJXW2rGPHrWPxCndI6VJCjsHwfOyxIzk6VFHs+i/8EcQET8ISlR8v0rXL8lE0aRrB/t9
 cG2P5yK6vl1fqnr/hJc9auj+77IkhlxOQOUq1m4F136HtQWBgpyldEs0nVeBSDBuTWhk
 2f3e9DH2O7RSsTyRzcA/R+JetUmXrFjAP+dto/1o0vLV65imUGAC59RG7WYUeYiPxgnp
 peLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740333778; x=1740938578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubDPHPRJKF93TJnMnaYQ03b9jO8zC3zQO/AmjLB3G1Y=;
 b=E6d1vMcTiS326LAv/5qxnLOGHTq2HwavTNu38Apu8H9dsg3I2HNo/iQvNttr8TGwe/
 umjW/h+2b5g8Ke+y0F+ZQtbBKKTgVxblbuw8Ngx4HjBVDFr/kEGgejuJnmc+tKp3BWdB
 0LyhSn3MlS0/2U8nbvysf7cvQxR6Zb+sXGQ2RJcU+GKhQ7zZQfJo84h46+fUiEzCzE69
 Vvl0objoOI1+CBQWgxVOlXnGG+T5H+Wsl2Am1anx3dUDrSHsSCxIbsh1GI7+L+L0uYRT
 AqeishsD7drHLgOAG5UWXZRF5ZtVp5eMXOR0BNMKRY9shNkq4aUU2ZGGwH0fB+VtAxOn
 ml6Q==
X-Gm-Message-State: AOJu0YxCoTmPGy5QTzxiNcqLsKAxLHDF7AKEU0wRXBluSAFhMxEnpBBZ
 X/q89NdHqgfeaKBOIJ12JEZZT5H71pmOArwKAYbJMvfAbZhgGPbe+rXaWmBIsGJ9xDS6LawyOha
 h
X-Gm-Gg: ASbGncsLkW2E/H9yEH7V8Xn3TncQ4+l1MFqpdhnYNZ1Ut5LVQ8xOP+2b9qxwJnBcoJT
 FFZLPNDlOEKaYAhg6v4qY6NMLB+97thTjhXxh9UyAnFfEp8hK0VzNpCDLYTEt4Jc8vef5n4i6Cd
 bElkGgKiikjfbdys3AYQx0aUbp9LQ2QrOqRbcBDS3sD678oD5AkFGr3vnbxGcBS7mejUynxBdk1
 F+Gn7eAKkQfYW5rDvKsR9xrijram80th1uZsgZwXkk4xjW9ECDSHBtxNFdRUU0VsjjKINm4VyCP
 QcZ5fp0Jobk1rZG3HYtJK55LTfRCgaZcPRqBgkF+xcGcLkiRjDQ+F8axB3dgaoNc1DE1lCYJvR2
 edzATxI4=
X-Google-Smtp-Source: AGHT+IGBzGiAmKelLTVaKyvxSlMDRHd6foaV/S0GZuzxqUgTqpbVzfjta0TC4QsXTi0jf1Q1oDQMxA==
X-Received: by 2002:a17:90b:3b83:b0:2f6:d266:f45c with SMTP id
 98e67ed59e1d1-2fce868c637mr17972871a91.2.1740333777786; 
 Sun, 23 Feb 2025 10:02:57 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb12dc0fsm5536383a91.46.2025.02.23.10.02.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:02:57 -0800 (PST)
Message-ID: <6b4ec443-98b4-4cb8-8c9e-feb40c738120@linaro.org>
Date: Sun, 23 Feb 2025 10:02:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] hw/char/bcm2835_aux: Really use RX FIFO depth
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 2/20/25 01:28, Philippe Mathieu-Daudé wrote:
> While we model a 8-elements RX FIFO since the BCM2835 AUX model
> was introduced in commit 97398d900ca ("bcm2835_aux: add emulation
> of BCM2835 AUX block") we only read 1 char at a time!
> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/bcm2835_aux.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

