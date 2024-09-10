Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8504ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snv7R-0002NJ-00; Tue, 10 Sep 2024 03:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snv7Q-0002HL-3i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:16:56 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snv7O-00013o-9Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:16:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365b6bd901so4113400e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725952612; x=1726557412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9m5MkJJxPo4aaWradbNIrvSPpPFE7H0lhUsyEGriQnc=;
 b=ymlZ1GTLdw5uAKjTgtZllR82rzcD3r1uXO/JhPMMtpe4hNIn7aqnBFB1BlU/RBD9+k
 W1btJ63fcJewFKg+MPmYPXJfNA0hTUxE0sWvlb3P7y22sWCDUC+6DOp9ZbEOHK3M3Gie
 +bpNQcaFYq2oEKSfbo20Gg0Z8uotsEVdSS5PMmuIQ0BeLa+kBRr7/iUbMQnwk7ADJkEv
 AZaBZLVDL3EeXGO6flHlSw7ADVyTFipxCKQh0fVvfkU9VrZAY0dSU+2WlL9TTk5cB2D1
 bm/bax3wlkui9KbjwHr4F9ykHgucSt+IgGdOlMWrZDymfg3X37dndd8kly6wxNM3DFVN
 23jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725952612; x=1726557412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9m5MkJJxPo4aaWradbNIrvSPpPFE7H0lhUsyEGriQnc=;
 b=HPwwlYmOW9NPNGhJXfPg7UR+LG2TQaXK2C70rr9IWOoqjrWXZUNxg2zZA/YFa6OE04
 V4qFhKSO0i680ZiU8HuvmU09OjXuhwTuwX5ATlDrkwfe2EbE3bbCMs4Bd/jMTpevu5rR
 46TmOlWYepiWpGjUK/RfxuWsCjVC0wWnSNgURRgBJKWwOGpT0Zu5Mbekpku6kEABjq83
 sxWsBRr+Fxqq1hZGf4UqvvNOLf6Zx+iLcmZzaNp91y7dPaXr8WWKngNxaUvJW3NAkoy4
 keHVy9ff2BsrhQaf/+II1k7xz5kZZQqltSec4vHJkbPiRY1Exf5F9FIlIjtVITAxejW5
 A5eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdDDMyvnNBnm0B5G2a5+nb53a74hljQ1zwOqavgV0zJF+mkH0hp1Ey11Mt2ir3cPULUHt4jGB3ePry@nongnu.org
X-Gm-Message-State: AOJu0Yw6l5misROkAKky1DmBr1CwaXhSuKaO9lS6eJn2YlxPzA6421JD
 jP7YFTeoQCAXLrdMbdI/OlDacZ4cbxce4hgPN9tTNyw0hjZpI/8d5GpaoSALzKo=
X-Google-Smtp-Source: AGHT+IEPOVKbaxxg0SuK4uoS2w12b+xE7aefHsgnJwx3j+LLac9TNnJQE0y4lMSo4pYg4bPoeasleA==
X-Received: by 2002:a05:6512:230f:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-536587b424bmr7232348e87.22.1725952611893; 
 Tue, 10 Sep 2024 00:16:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a2b281sm444501366b.92.2024.09.10.00.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:16:51 -0700 (PDT)
Message-ID: <0a2bf4a5-b3e5-4b36-8e78-29014296cbdf@linaro.org>
Date: Tue, 10 Sep 2024 09:16:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hw/char: riscv_htif: Use blocking
 qemu_chr_fe_write_all
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Cc: Bin Meng <bmeng.cn@gmail.com>, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, dbarboza@ventanamicro.com,
 Thomas Huth <thuth@redhat.com>
References: <20240910045419.1252277-1-alistair.francis@wdc.com>
 <20240910045419.1252277-2-alistair.francis@wdc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910045419.1252277-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 10/9/24 06:54, Alistair Francis wrote:
> The current approach of using qemu_chr_fe_write() and ignoring the
> return values results in dropped characters [1]. Ideally we want to
> report FIFO status to the guest, but the HTIF isn't a real UART, so we
> don't really have a way to do that.
> 
> Instead let's just use qemu_chr_fe_write_all() so at least we don't drop
> characters.
> 
> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/char/riscv_htif.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


