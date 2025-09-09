Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526ACAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvsYM-0004ZK-Ev; Tue, 09 Sep 2025 03:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uvsYK-0004Yv-Uy
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:14:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uvsYH-0000VX-Tx
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:14:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so33641525e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757402042; x=1758006842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18bWt/tr6EURE8EiER9IjYrcprROpj4SinHw/Fvv6fo=;
 b=amMSkcTq0961ZcpoviX7YjLaq9XhICoZiFTXGjduZbo57j932HrzPbWUW1wCg0wk1h
 v32P4nUYHapwM0AOqmS0C0azy3b2IJxQiErQ7pWUZPQGjF9pMJSLdDfe5CkrrGiunoYQ
 suKai2B4+0AyjNSwTXI6Zzyigtgiq0TnvCeAXkGFZDBQk8rQn3AfUGeXffuszEcVHul8
 /W21vSSRHDtxdgm9bRut+5CpcvdXBhVxPp+Lh1abfKcDHAHox4SSe3TwLp3vEL3udEqK
 xC5AutFTaaj5JmY38BIOw7eXmnAVXm7s4xvKF6anhcumT1ZyZrT+ejddFOE7rUW20CJt
 1o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757402042; x=1758006842;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18bWt/tr6EURE8EiER9IjYrcprROpj4SinHw/Fvv6fo=;
 b=r4gDvIQZbpJHhDoKte8fuykML4Bc3j2bcQDX5zTZc1Kjl+msuMn1HdmYICasoJRryy
 gNpnfi+GnyiHtx2DEuV6T5Uk18DYRXBOSWTVm++imN06oKxkE6iJ7IYsgGpTychGeWoI
 oOpKHqnVIQiS0tRxq2pDoRpxavYRIg+IKn8Y6wBVeADJOneaiDBgJ+gIEhY6TO4DyumT
 3CE+F4+fzNbtQT+kAKp5GpKxhckuFjX5NRV4Vwwmp5U86ZevBPN3iaqN5kyRIm0msqCs
 sqZqEZxekvs7RFNF1X04MdX6jCIClX+VJwztpkRaqE2TlmPzgbPC7zgFReI599c3wb8h
 sOhw==
X-Gm-Message-State: AOJu0Ywk9PDYFrKEZzKgtfsVRE+M/UDCwjvTyc7rzBvD8Z23ReHkJjVD
 r4XbD8vc1LUGMsybPyzzVsAQ8oFP6IMfHROiLLA9LVU9O+2rug20TOd/PWw8/g==
X-Gm-Gg: ASbGncsHxSAcUFJ4Tgiqv7M6G9nb/FGKS0x3b49uvPTLc1CqsClqZgLfLPL5RtpM3om
 qAGh6/KR9QiYHPtMrIY7o5wQgZD4XPAd2SlxZE3CHXPR/xy3w6bghvrRAzRcJcerHkSOcxPCF5J
 H3j5hI/Veqd6/2i2MvVsA5XI5N/N7h2sprvjlHzN5dSidcIHYguKc/YVReYzPmJKfvs0HbWSywl
 LKOxZxuzAjMyF4STUZcA9HTcmX+gm2t5wRM1XxcybtAwT2C61ZQ3I6+MCLPjU5ALQ7vWCa5Zf7f
 LYk4MzfjGTZMkyw++Eai8ELInlyYU/TPgcsbAp/3zoBc0/mx+QKlx0SQmd1NS9QW8P9KVyo9MmO
 uU1denJvR8jQtPa/pduo/k3ppS5mHJDqDUt1sxnM=
X-Google-Smtp-Source: AGHT+IEfnruvq2UFgoGPKqsYNK3YQ3K2VccO7NTpP/Z79cbPJJu5mlnP5448qK6qZJzoCnbjih4pRQ==
X-Received: by 2002:a05:600c:4f4a:b0:45c:b523:5a09 with SMTP id
 5b1f17b1804b1-45dde21d0c0mr96729155e9.16.1757402041706; 
 Tue, 09 Sep 2025 00:14:01 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de5eabdb0sm80303845e9.8.2025.09.09.00.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:14:01 -0700 (PDT)
Date: Tue, 09 Sep 2025 07:14:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/5] hw/pci-host/bonito: Add comments about documentation
In-Reply-To: <20250508-bonito-v1-5-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-5-4f9f27733028@flygoat.com>
Message-ID: <AB55B48E-F903-4524-9D6E-058238D33EC2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 8=2E Mai 2025 14:46:10 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> hw/pci-host/bonito=2Ec | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index 49b4be26393a08eda4f99c8e2ef8a0c455c57bc0=2E=2E918ee39661004d902d2de=
b25dd5e782855a11854 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -1,5 +1,5 @@
> /*
>- * bonito north bridge support
>+ * Algorithmics Ltd BONITO north bridge emulation
>  *
>  * Copyright (c) 2008 yajin (yajin@vm-kernel=2Eorg)
>  * Copyright (c) 2010 Huacai Chen (zltjiangshi@gmail=2Ecom)
>@@ -8,10 +8,21 @@
>  *
>  * Contributions after 2012-01-13 are licensed under the terms of the
>  * GNU GPL, version 2 or (at your option) any later version=2E
>- */
>-
>-/*
>- * fuloong 2e mini pc has a bonito north bridge=2E
>+ *
>+ * For 32-bit variant:
>+ * "BONITO - PCI/SDRAM System Controller for Vr43xx"
>+ * https://wiki=2Eqemu=2Eorg/File:Bonito-spec=2Epdf
>+ *
>+ * "BONITO - Companion Chip for Vr43xx and Vr5xxx" (uPD65949S1-P00-F6)
>+ * https://repo=2Eoss=2Ecipunited=2Ecom/archives/docs/NEC/U15789EE1V0DS0=
0=2Epdf

This one gives me a 404=2E This link works for me: https://www=2Erenesas=
=2Ecom/ja/document/dst/upd65949s1-p00-f6-bonito-companion-chip-vr43xx-and-v=
r5xxx

>+ *
>+ * For 64-bit variant:
>+ * "BONITO64 - "north bridge" controller for 64-bit MIPS CPUs"
>+ * https://wiki=2Eqemu=2Eorg/File:Bonito-spec=2Epdf

This is the link to the 32-bit variant=2E Correct link: https://wiki=2Eqem=
u=2Eorg/File:Bonito64-spec=2Epdf

>+ *
>+ * For Godson (Loongson) 2E variant:
>+ * "Godson 2E North Bridge User Manual" (in Chinese)
>+ * https://github=2Ecom/loongson-community/docs/blob/master/2E/Godson_2E=
_NB_UM=2Epdf
>  */
>=20
> #include "qemu/osdep=2Eh"
>

