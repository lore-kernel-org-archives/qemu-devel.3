Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD5CCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpEs-0002UJ-4s; Thu, 23 Oct 2025 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBpEq-0002Tf-DF
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:55:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBpEm-0003rI-FH
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:55:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso5483465e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761202551; x=1761807351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBjsiZOdEn77FHXbaFH/pyzY5kAYbLCRT+sJz0dq6fA=;
 b=MAl0EdifKB7nEfBtFd4hmJ4NHsVqUegp720GrbjTUGvyCUMMC/sSoebrAhUxBuuceq
 mYSlkBJzXrDb1XG5t/73Wmp9T/kPygmYbZ5iJdbInvW/3oMhSswTFconW+4fCKW5vYgs
 rzTJbSG1jpwblLkjxNVwe5JK2ps/hxv6DcJEGK35B3Tloj/x7UplzX+Us0Hez13jNQOX
 PzWzYg0diG8WxGCUVbI92bEU6WrzEB57DU+FXHNUsWKEpkQRki4ZS2rclW9C4FOPea+b
 +062MqgYokmahzDF8VawksuMzdC2l7siO06+TVOV9rbNxECJcPKKqcNXJIceYKJxCApo
 A/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761202551; x=1761807351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBjsiZOdEn77FHXbaFH/pyzY5kAYbLCRT+sJz0dq6fA=;
 b=gPAKS+vHqcx/18qR/vXq5lorI8n2BWFtdiYBovjVL8vgYWvFEtOhKRP1eplNpmY/7p
 zKVVO3zsUpIg0oQCj2tKNP5tSY17n50TGGfpEE39Pf91XUX3UhRb1+IiYnG/XUNphAW7
 CB9yzt2L8aBOHyvERvvxXH+3okCAovLxhQGxkIvY3iw0cTnD0JYZauJEpUsqMyPfAAMz
 MSit/GQPqnGdA6dpwU3x8N3DoLMFOVTbls4GEqXV8BUvd33YjH0Oaemj5gZUMJYwbyme
 St7bdzHNAxRpi79Tj7YOSH6r2Qm/KAmh1kifBCilI9q8F2V/615sng18DbfEdim/kNQ7
 WSZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMG6S47ecuAwVCx/XbgZzHz+jmcinthJd5gRsFSiQwchoHDjHUgbgEPJZ4un4eZMWCDF/Cf5xjOX7z@nongnu.org
X-Gm-Message-State: AOJu0YxnWJd8oHZiFuEqFRBAI04RlNE5V2n8cX6eQx+lGdTdUuqWjkQO
 RNS5kSVtgKR4071fn3/D9K7f/tURLqvLzV2C77AHE6l6a46DFPgwgtLKoyr3/lJapDA=
X-Gm-Gg: ASbGnct9bGRINr/SrMZZNrMT0U6fOvUdZ0D1uQUyhyq2czfSGgmg6753FqDKou/LQyk
 M/2m9fjLarQpj0jZ/iSYUScg4Ll6BxfUO1A0PajZD0w1yqN8dJ29Q60loFIP3p+SqV77prVH+Ah
 7/vZZICGs5cuF8Z+Atgzn8PwWTkFrelqVDI0zM8pFjBlmzPcBpGgKqHcNEnJWaFA5wYB9YOSrAR
 0uvVZwVGqmCJTn+X8EytdNQPubv9F+zFAsClS/xeq+HpUDSQl3faahfYLw9WyniBxtxj/UITnqf
 Yg+DD+lhu4SRKgMiC7zvBmsbL55b0Hwgjw1G9o7IhxRLavMZDC9LW30YuN7IG9S8vFuNZbSknVh
 9rAKENV2Yj+7e9GZOJ61yDED0an+M/Bs9HgGjI6IoFjd3M8/INNxFx2oS+eV1D/n6WFHglhWO2d
 nSwEBXtfNNbPkWdN++Fsx/3ddw+qU47J7OWeYXgLYXFt4vt+U9whjVBg==
X-Google-Smtp-Source: AGHT+IFc7GZgQ+HjgYh3w9CjXImj+3Na+YnYobgCi3dJmLowW01x3YzXkb4t8JrWd9L/fU1Q9uMKFQ==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-471179123admr170521105e9.21.1761202550629; 
 Wed, 22 Oct 2025 23:55:50 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff3f5sm2354381f8f.22.2025.10.22.23.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:55:50 -0700 (PDT)
Message-ID: <c013adf2-9620-4766-8f5b-1000ed1a494a@linaro.org>
Date: Thu, 23 Oct 2025 08:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove redundant typedef when use
 OBJECT_DECLARE_SIMPLE_TYPE
Content-Language: en-US
To: Nguyen Dinh Phi <phind.uet@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20251023063429.1400398-1-phind.uet@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023063429.1400398-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/10/25 08:34, Nguyen Dinh Phi wrote:
> When OBJECT_DECLARE_SIMPLE_TYPE is used, it automatically provides
> the typedef, so we don’t have to define it ourselves.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   backends/cryptodev-lkcf.c               | 1 -
>   hw/char/ipoctal232.c                    | 9 ++++-----
>   hw/char/xen_console.c                   | 1 -
>   hw/dma/pl330.c                          | 6 ++----
>   hw/net/fsl_etsec/etsec.h                | 1 -
>   hw/net/xen_nic.c                        | 2 --
>   hw/pci-host/bonito.c                    | 7 +++----
>   hw/ppc/pef.c                            | 1 -
>   hw/usb/dev-mtp.c                        | 7 +++----
>   hw/usb/dev-uas.c                        | 7 +++----
>   include/hw/char/serial.h                | 1 -
>   include/hw/input/lasips2.h              | 6 ++----
>   include/hw/misc/auxbus.h                | 7 +++----
>   include/hw/misc/bcm2835_mphi.h          | 7 ++-----
>   include/hw/misc/npcm7xx_pwm.h           | 7 ++-----
>   include/hw/pci-host/pnv_phb3.h          | 6 ++----
>   include/hw/pci-host/pnv_phb4.h          | 8 ++++----
>   include/hw/ppc/mac_dbdma.h              | 7 +++----
>   include/hw/riscv/iommu.h                | 3 ---
>   include/hw/scsi/scsi.h                  | 7 +++----
>   include/hw/vfio/vfio-container-legacy.h | 5 ++---
>   include/hw/virtio/virtio-serial.h       | 5 ++---
>   include/net/can_emu.h                   | 7 +++----
>   23 files changed, 43 insertions(+), 75 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


