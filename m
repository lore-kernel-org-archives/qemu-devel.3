Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BFBCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0QW-00019v-Te; Mon, 18 May 2026 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0QF-0000Vl-VH
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0QE-0006Gl-4g
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:02:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-452169ae568so1608708f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779120143; x=1779724943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpSVbcWtsb1XgYzrv/fBQFzeGb8SOko7ov2BWscxtF8=;
 b=EhdMV2ZzF5RRPNb21oqluJRDplWINGIwki+tOMvChPHDYiRz50Fv8Ytnse3dtokR9p
 xAXjXIkiUHm4PVacWvVEfoZqXVCD6TH1kIO8j7WCkzzkOhGVfrFldCnFFdSjpybuUT3x
 Tg7xAcS8yqPZoNvRKpkRuqkfJsJhavm6RBLJe9VTAjiiI7XZ/arKcguKW/FY3gAmlUCC
 rt2fc3f/gRhpP6ebkvarAiHAXgXT59RG71RzCIuwhaIrIYBNNmLcvsXDUPpbOL8r/7tu
 uwbAbCbm4HB+du9pGoDLC5UDiBb4vgaMubA8XAsKc/T3y6YTznnpaCSVlzuKAJ4mLFN3
 9JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120143; x=1779724943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpSVbcWtsb1XgYzrv/fBQFzeGb8SOko7ov2BWscxtF8=;
 b=m8kxY3ZKknqby8AE/JPSyJnwaKWZX889k6lm0gto7n1m0Fq+sSApoFYy5IDnn1o60y
 8mAMW9K4o1fZI7POQT01uB2g0FZnq6Qu0/BMqONuD1CqiKBvXJWc42zmNCutWZ6IXro+
 bVFB1SJ3WeggaWUQRi94KtMuiHi+C8RlYs/5XnPHyRsYUkNxiMeB0WOQoQ2kISpVM/32
 52zq3tCCcNKTo1orOJx11QdIQt9Ehmr18GbSXKMs6EMMvOmaO/3EAdh40BYgmkf/CClY
 s6AMWSvf3wadVwcCTHPDtbx+4Ndi/eoYXZooQe2WQGIlYm2GJwMGDXbudGtBjyI2B/b7
 VOFA==
X-Gm-Message-State: AOJu0YxZOO1ujh7vuMqwyARPg7Hbx4xRl9nBbr7mPoO7RCr7pD2YYI0u
 WO/EBXJjmnIlngasBq0ATZsOgaGYXDauro/Wv6WtA4FYdM+J/V/yO0Rm5oFHtBL5oE3NM07FXhe
 kucEdk5A=
X-Gm-Gg: Acq92OFi7qcb603VGdfMHvWCNcRp8RH36C1Qu6dIUAzMPxSXWsQlzSW9fQH9num5fX0
 pGWo7b6dnO+2mEQ18Inpy2YsfiB7m5ysGowu8Sq46pJGo2ySfKMCcIgDFJFuFIuK5eIVr1iNgYJ
 7YdmX5MOOC5Kpg1xBMG8dYvGfuohyr04FG4CIkh28FCA68/nuUSd0+hSyHUp+lpQ7IrcqIiS4F4
 FTw2rYCHMieNLJAa30v2XPtvFz8sFAg4cV9u7JhiE2bYz0f2m+p0bubeR9WbNSleYRtwYITlxWr
 S4wwfPw9fZSSdmKJfEQppYUpgO3EIeH8EBrxmE1VGJEk/Z2UQ71OlQn2hUwu8SFPfS3oldvvNlU
 5YbpO9stE19fnCaE5qcW3C/ltKFCPDtLA4BG7sGeWM831l1dspeXnsR0i4nNn7CcRD8R1m9CnYu
 G8wSTba4YxO3bG8xuVoP8O/boaBB1SaIhNoltNLZNXBlkkB+ybJ0QmSFXkSf4GaQ/Gdw==
X-Received: by 2002:a05:6000:2383:b0:441:1e41:194 with SMTP id
 ffacd0b85a97d-45e5c5cca8amr25597222f8f.17.1779120142246; 
 Mon, 18 May 2026 09:02:22 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a562dsm38633087f8f.33.2026.05.18.09.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:02:21 -0700 (PDT)
Message-ID: <129e7c07-c5d9-4eaa-bfc7-8eddc276e2ab@linaro.org>
Date: Mon, 18 May 2026 18:02:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] buildsys: Remove support for MIPS host
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260511135312.38705-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511135312.38705-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 11/5/26 15:53, Philippe Mathieu-Daudé wrote:

> This series removes host support for MIPS.
> 
> Philippe Mathieu-Daudé (5):
>    buildsys: Remove MIPS cross containers
>    buildsys: Remove support for MIPS hosts
>    hw/mips: Include missing 'cpu.h' header
>    buildsys: Remove MIPS KVM
>    buildsys: Remove MIPS TCG backend

Series queued, thanks.

