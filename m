Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD6BC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvUI-00020i-Ln; Thu, 20 Aug 2026 01:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wwvU4-00020D-KR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:38:39 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wwvU0-0002UX-3T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 01:38:35 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66c67a73eb7so1023476d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 22:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787204310; cv=none;
 d=google.com; s=arc-20260327;
 b=Isj/4V4ymM8RkQHk3bt3EZKpBfJ1P3FnMZCbAou4+exUgLI4Xg3l74Umx2FngllXnQ
 gOLm1s8qVqI1G1cLWbHG3Tr7JxU5zLgV4Ig7pmbMU18tsEkIWY6outO0d8peH7V+wFWv
 aEEMun1GCcS1XG4r6rVqnJAeWi6brCkenQCe8Lnca7kYfFlWrrTNyGvUJsjaIAMMEGIw
 75omaO54I3wRrOA1vBIsZNWF4x7Z84KVdXYnitugm4OxS+BvQ4ENgo2n4TNS9nyPdzSo
 L9sssnxWnjs9uycbyP5m4MNVmQqjKOTIq056BBrlMpe6JqiJcKLlZR5/XKrluKhxqPi9
 C4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8tAPdeXuFOSer+0GgMhti1jiYqc5de8tbD4UHaAkuUo=;
 fh=KXNQ9XmFBOlSIff3X3hN9n02+QHDK46FBHy7KKDTkOk=;
 b=Af3Ql80gwQucpNLqgceyFSbY/WxFIR5gkGbCQ0AD5m39jJ3qPO7v1aff7tbW6TD25B
 KfJSDxPRYS3BQq1S8ycxFneqvOoNXG4Cb7lnJXzPxAxqWRz1m9OgZkM3ZCX6ELiYbOWq
 evYb6IG0TEqN75FH2pe/blaytrVVzqRDlYRRzaRADAMOWtYc9i26xwAzaoOJwM+7Smf0
 5Ed5bOAuC8XiZWSB61RV2qX8CZLazaY/nZjpLYXqKjgic/WTefa4H/myeSvVSnrmSsbx
 2Vm/SNd0/dAWNfnDNreVlbtRJ+Qgf//5ifZ5Uvdbbcw8+YRBUdh1HM4/kLyGZ568l6yg
 jkqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787204310; x=1787809110; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8tAPdeXuFOSer+0GgMhti1jiYqc5de8tbD4UHaAkuUo=;
 b=DmNqyP8LBSW3KZA7y+7jBLa6tXoLEcB1vUnm8ZDM1tIUTlUozKGgDSWDvAJbwuwDO8
 lH5ypelE4sgE/wxwvg1kTR7sc64iNYsv1ALMaoK5OR4/FrotrZgEVbVuyKc8DWDA3/SY
 wq3O2w6tEyk7NG1Zrwb7uICW7lUL2Sp7bfkik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787204310; x=1787809110;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8tAPdeXuFOSer+0GgMhti1jiYqc5de8tbD4UHaAkuUo=;
 b=aQGGzVUKEi0FRXb/p4ukfOTHeqqJ98sevzsnoi0MNs0qNFXah4tdS4DCrpPEGNk1qV
 Vzb/FnH/YxythlnIr3mvRgSiSP3WyoED+xqkEq67eyjCsb5eDTTEElM6cmgdeXFd1GsH
 lJDpZ2lKqR1TBXVjgZdjOPZIrTQYVt7ljvHFouH+eIh4c3PFGRWlKSYEokCYsCcABJP7
 u/MXx4a7MJZ5MfHL6sX4wMgFinM0Tz+kIrVyE+PZ/6CzcmiMQWowJHJ0FSP0mpee3fqI
 o7rPeV4O4vz47fhHwd3QRlYjg1y0onivCxgUJgoXUPzxV2etxvasJk0/g4OY9pOuf/gG
 yugQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RomSiQNAPMk5HbBTHsh517cWdbLc5UlJHBUfi5bl9ty+hyCbqXcKgaO+TIh78LCBI9JctFYxXelYa/I@nongnu.org
X-Gm-Message-State: AFuF++m07+zg2TOe8YYNwm3rz3R7DfpWvfvGdmwKX/8hja+4PoX052C4
 bVcloF1Fj75ZrGmEVqZxLXrhgManm716AVNkavu95JUi+TU3vMPwkXlf3rgjQXWd9tLd+n/RmgU
 Rx2stHWPPaRdxvDBZC8xBuMSwpMaE+e4=
X-Gm-Gg: AR+sD10WBZxvNM/J3383/5IoHHjkXO+8YG+hZjopIJex53nT/u1MeyweXETKrzhKkR6
 JBhcesMASVdSeqysJgmobThoH9isXR0ezELfPiHxydX8APbxAa66Ksj6jO8ORlCct7YRHYPBGhy
 S9JuX75NzOl+xh6SLSEnKWZJN6Fp4wh/vr8HtheLk8QcqRCAn4UEdm4MO9nJh0gtneL4FkMlC2P
 8MoU8UFp97RM4Q7SCkxoESwZup21bTmEmqElxQt7mUuHpxMA+OKPRLfAHKkkQZvmegquk+Y/T52
 Kz38eX5cWyTECVIGKpZDUp2afR0grs81+/9l8/thzykb1wpZnOGUJzSc2HaUAodPwtZyyBD/XlO
 +MGX5QSSAy+Ah3sSnzQup+mhA+tBwIKwX38X2sItCvIg8ZPB8WqF5WZJ0sQC7beZHtbfuUc10Ot
 GlkWN/AXextw0Kz22OiL8lu9wg1g==
X-Received: by 2002:a05:690e:4507:20b0:66b:28a9:5729 with SMTP id
 956f58d0204a3-66cd68909d4mr1079939d50.8.1787204310251; Wed, 19 Aug 2026
 22:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
In-Reply-To: <tencent_4EEBFC805F3E59863BEDC38094EF5A109206@qq.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Aug 2026 15:08:19 +0930
X-Gm-Features: AcwNN1X7R3F2N1_8svoQgdgp7EIDnIe3SCNkCgp0YjzHIq1wWDKZ8dv6vARowkc
Message-ID: <CACPK8XefKWYjBqZrhbgf62QaSGqdgGMFwVbB4uwoWz+4ZfhmkQ@mail.gmail.com>
Subject: Re: [PATCH v3] riscv/virt: Add optional UART1
To: Yanfeng Liu <yfliu2008@qq.com>, alistair.francis@wdc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, 18 Jul 2026 at 11:46, Yanfeng Liu <yfliu2008@qq.com> wrote:
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -16,7 +16,7 @@ The ``virt`` machine supports the following devices:
>  * Core Local Interruptor (CLINT)
>  * Platform-Level Interrupt Controller (PLIC)
>  * CFI parallel NOR flash memory
> -* 1 NS16550 compatible UART
> +* Either 1 or 2 NS16550 compatible UARTs
>  * 1 Google Goldfish RTC
>  * 1 SiFive Test device
>  * 8 virtio-mmio transport devices
> @@ -27,6 +27,9 @@ The hypervisor extension has been enabled for the default CPU, so virtual
>  machines with hypervisor extension can simply be used without explicitly
>  declaring.
>
> +The second UART only exists if a backend is configured explicitly (e.g.
> +with a second `-serial` command line option).

This breaks the docs build. I think you want ``-serial``.

Cheers,

Joel

