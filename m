Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496DFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 20:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk7dy-0000PS-5q; Mon, 17 Feb 2025 15:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tk7dv-0000Ox-05
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 15:23:03 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tk7ds-0007d2-Eg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 15:23:01 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e0452f859cso2849744a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739823779; x=1740428579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TYWyrchUK6/kz4m4SFvU74GuvLK7pWit2+MOlwNuSA=;
 b=jY20xu/fiibJ/zmEqkLHemg6yk9BJ8QHzj4yV9swow98Ps3eF0P6KYTXVeKXJJfCUw
 gdUExsz2ppeH+/llqR9T9Qjg/GMWPhYw+yAXrB2fDy6SwXlJ5893KDhdAsaj/mZtJUYq
 RQaAK6+i00kue1Mze1VTF6xe+gCoFX3gml8FsFOJ0cOzPbKNEetwiLkCEpBC8h452AS0
 C0/4X7PSV17jCAnN2J7DSIDPIf4UjROk7meatXD4Cc8YUR+aivESKnBqV+i3b1pTivZQ
 Z39hG5gMhOkCIwzjBpJ0tmxd5xTGF1WJEkeraGR3Nv+GkEnB4rU7rbkXDXvEPs55EsnT
 ab+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739823779; x=1740428579;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TYWyrchUK6/kz4m4SFvU74GuvLK7pWit2+MOlwNuSA=;
 b=E9hno8cXWU4Mqpo4NrnfhgTo73FU2UFDkLMG/c9SytcuzvcFTvWupIncHhTLxTXBp4
 EimLLKO7wb2EndrhlKeX8UPsv335XHh9TsRH4QGRUoTK5rWJes7XnhyDUlvw4f3UsWEL
 au/J9ajRLj1WbyiV7ZAyE3K1GieiiBUudTmB/8x+pswH1sA/RpjKHJWU5ltPocuNCfmO
 2I/gGgpkqEMASGYqgWrMrIV/di+6awWLr21X4s7lukAxOmA+4OOJ3/NQRz7Ncxrpyw6W
 nJOu+zBzPjUh8ft8ZPGtsVo61KEAl+YT4q0ttwF3aqIl0gDpJKS7xVLkS1LctHex9CUu
 VlwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzUuC2wpu7w0e7a5uVXD3lrBwibjRCwU0Tj4oV+6Us252oGkV2JI5Qc22dvs20kiI6zloLFRAX/xP2@nongnu.org
X-Gm-Message-State: AOJu0Yxm1yPQTShE6zwsV3fxjlDVCL82TKRECIu3Tm7y8qaQxkEKAXWG
 nzlFd8hkZZIDY/2MqCp2+DQVeGUesg7QigGxW9VCd0BT4tpTGAtQ
X-Gm-Gg: ASbGncvmg2OveHjBFppkCvzE4B39kRnxt/eFWNh+PifP//JoWbg50Gud4i2OTL85EWs
 o3qqkNFbGhOF3KV55U2ZQcsl7ruSuQj4h205fu2Rm0+MiQvMgbBw0sLbN/HLTYgGx+I/9PRLBm8
 q2kRx+epwyJ0MaXB/rYVtpYtE3QraODRQw9fILdA0XcOY32FIajONoFz6xVsI2sxjuloz6ESIhP
 wmf87XSrgaASmqRDN+4vW+9BuHjybFfyXQaGO+7pgj4WXmOdCVAInVD953j30UGZLdvmTg8ng7K
 Fa4AnN5ghD96UREjy/HYJWSFaPU2ExKJcSmasj4sJ93F2JRBpykMU1Q6dlPpAORtB7E=
X-Google-Smtp-Source: AGHT+IFYlYu4n9DPiLospEBVzR1cxAjCdB2K96I8AOXpD/QX6t23P40cdu5FS9Vn6t0Jxo1Lc1x1kQ==
X-Received: by 2002:a05:6402:13cf:b0:5e0:7199:5495 with SMTP id
 4fb4d7f45d1cf-5e071995c7cmr1913816a12.6.1739823778583; 
 Mon, 17 Feb 2025 12:22:58 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-175-027.77.191.pool.telefonica.de.
 [77.191.175.27]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1d3693sm7609593a12.39.2025.02.17.12.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 12:22:58 -0800 (PST)
Date: Mon, 17 Feb 2025 20:22:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/2] Move Fuloong2e PCI IRQ mapping to board code
In-Reply-To: <ba385271-bad2-9df2-e3e0-9f7018a77b81@linaro.org>
References: <20230105154440.259361-1-shentey@gmail.com>
 <ba385271-bad2-9df2-e3e0-9f7018a77b81@linaro.org>
Message-ID: <F7FB9E8F-6DC5-4DB0-A82E-0D7E1ADF851B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 16=2E Oktober 2023 09:05:00 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 5/1/23 16:44, Bernhard Beschow wrote:
>
>> Bernhard Beschow (2):
>>    hw/pci-host/bonito: Inline pci_register_root_bus()
>>    hw/pci-host/bonito: Map PCI IRQs in board code
>
>Thanks, queued to mips-next=2E

Ping=2E I think it's not merged into master yet, is it?

