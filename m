Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F9ECD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNip-0005So-ID; Mon, 11 May 2026 06:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNio-0005SB-Ac
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:18:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNim-0005lf-Nq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:18:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso37550925e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494723; x=1779099523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1DjE5PKYeX7+QdB3awLwZpR9eXsUK/Tx+YY/itOrFtM=;
 b=CdE0Iy1BRJMR4El9exu6u0BvI1gFBiddssrRHtvPdmAb0NcQggTHjPBY+GKFdHpZin
 cYuQJaw0tICkinuITjyZGKgFKzEvG4ygPCJmb6HCYP5TLx2AGRYnG0CwlIntWjqNY8Iz
 IE/xyf/yK7QT0XB/SAC16N0hws6VUcmrHzSPpnOsXCUgrRTmh77Y7deuFKf4CNvj6F5c
 RdUbWJMO0rV+Q/vfI+J8O/H+rGlzahnZy9mYNFKSO8XJPXXrLKnv+GbGHauL88CGqFYR
 T/uiJ+ep0tW/GBY79ybcd+FAteL0PlbHCvxtjxJeSpLHbPYH7BkuqSDH8VZnQCA0Xpdo
 VE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494723; x=1779099523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1DjE5PKYeX7+QdB3awLwZpR9eXsUK/Tx+YY/itOrFtM=;
 b=T7T+o6R+7lV2GSdLAmqTueKtTXshJ9goUzU2VMCWHTPI8iHkRc1CKRuAb3TWEqgu2A
 Tqn7uo9rlR3oLkpsBe2gbuZxKtQ+4qCOTMTBKXjqUaK+/tQPWcxwlIoMT6DzfqCFPLky
 ojbbT5dTUkWaYoTW6pzq5ZtGLZRUsKMWMidzzBPhIkCXteRVCuEg0/yl9vh/V+V8DUfO
 nR6KFzIkSy0OboAaxQ4Ul3+5bJFkDPwwKGiN6GYJsrnGttNe/ZFEGBEY6K+Kna8LOWuo
 VHmkvzPRggY9mbeW/7s1RJVH9xiE95cfGJjVG+6aaSSMjrooxM5d1gj4z2UyeLagwl52
 UhUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XY0Sj4V7IeYb1+DhnLYn10S53ja+oAEV6l/8gdZDAJGX6oW1dUoPksheBeHmwNRCe7FK3rGkASBfN@nongnu.org
X-Gm-Message-State: AOJu0YyUf6B+DVwduedBCx3SGlnhZ8kJ6cCMcHz08AsXYtIw4PKAtTAl
 BkPtRcvlJozcubLv5A5/WLwv+7DNppu7P0aCM6mwyFLzEBCBtQu0qb+cYACWaKx6Pp4=
X-Gm-Gg: Acq92OEGxvDPTr83wcSEKePrQR3SpAJxVse003pdozAtg5v+Km0GfirlaWsBuPaZjvD
 pfsAclPW69Ajq2xi1tjYjcEHcFzNGza52AJFTK/2CaKhQsQ/A6EqDpyDR05Xyo9eyxrA6NuccTf
 wklIJFV85OI8YW05WrSUcRktvsvB7OlVZ79fLzn5e2sfZnHnpsd8aFyvcqd4YsohsS+ufdy+C6c
 sQRN5KZXrQfWINvQaq8sVjNEMUePtnmIdv2ymgxFrPPogaaMG3CPp27HeOkkThWqI3iWpYsCH1c
 +70/sAxzoKr+poSlZiBBsVDjkz9VdJ/uhtltsmp4FycT2Cb/TLeSkl5vQETRXrH4ES0jNGUdU3v
 PH/H7XtJqjIhvLFrzCMmUwfkJjx72lZUve44THgB220ln8V73FzklKfFyDN5YIYLHGA0QOaCA/7
 R4wDUm/LFRKgR+oCrFhDQFTCoehdX+nsV+Y+H/xKx5m4nSg/tHKmNr2Qv4yMJd6gYudQ==
X-Received: by 2002:a05:600c:859b:b0:48e:7f1c:875e with SMTP id
 5b1f17b1804b1-48e7f1c87d4mr81830135e9.1.1778494722715; 
 Mon, 11 May 2026 03:18:42 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702f48a8sm171139595e9.15.2026.05.11.03.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:18:42 -0700 (PDT)
Message-ID: <9c5d66ee-0e50-4311-8dc8-17797e92fdbd@linaro.org>
Date: Mon, 11 May 2026 12:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] [RFC] hw/i2c/designware_i2c: Switch to Fifo8
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-3-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507120524.111056-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 7/5/26 14:05, Nicholas Piggin wrote:
> Alistair suggested moving to Fifo8, which I think is
> a good improvement.
> 
> Broken out for individual review, but IMO we should
> squash before merge since it changes VMState format.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/i2c/designware_i2c.c         | 37 ++++++++++++++++++++-------------
>   include/hw/i2c/designware_i2c.h |  7 +++----
>   2 files changed, 25 insertions(+), 19 deletions(-)


> @@ -53,8 +54,6 @@ typedef enum DesignWareI2CStatus {
>    * @ic_comp_version: I2C component version register
>    * @ic_comp_type: I2C component type register
>    * @rx_fifo: The FIFO buffer for receiving in FIFO mode.
> - * @rx_cur: The current position of rx_fifo.
> - * @status: The current status of the SMBus.
>    */
>   typedef struct DesignWareI2CState {
>       SysBusDevice parent_obj;
> @@ -88,8 +87,8 @@ typedef struct DesignWareI2CState {
>       uint32_t ic_comp_version;
>       uint32_t ic_comp_type;
>   
> -    uint8_t      rx_fifo[DESIGNWARE_I2C_RX_FIFO_SIZE];
> -    uint8_t      rx_cur;
> +    /* fifo8_num_used(rx_fifo) should always equal ic_rxflr */

Why not remove ic_rxflr then?

> +    Fifo8    rx_fifo;
>   
>       DesignWareI2CStatus status;
>   } DesignWareI2CState;


