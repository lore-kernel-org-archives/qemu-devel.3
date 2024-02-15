Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C594C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rad0U-0006h0-Ea; Thu, 15 Feb 2024 09:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0P-0006gM-RJ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:29 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad0O-00071c-7z
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:46:29 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a30e445602cso390696366b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708008385; x=1708613185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xhIBMIkX1ghGSDx6f2nTkZtFRBG5UrUvlZ+ly9AROVY=;
 b=s4JXEoI8qWX8rSaI8eUqIbC8M8UDCZV6wn/YxNeztGAn3jJRwde5KkogXivWomDj4i
 FfdRbzqOQCeT21+z7yWDAnkp2Rv1Orsl/cBCcA8hXaOLmucdCSkNofgR1HQzMV5gyNZp
 nGdctWuu1e11K/c0EiY1SFpqrDNopyb9HYALEJe5kHmp9zR9CLE/XlUb8mgEoGyR894H
 AuSOz4RWN5q8qHYFnXBxAmt0T9peTurqDPYvFln+Qz6dWqBQBsXTeZnDRNZ4h4+dPJ5o
 U3vJtW0DtqnHLIVejH7IfGywykI4/I3VzIwKvrRc4Ipnucx8vVDUoydduItDLnuDU51H
 tgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008385; x=1708613185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhIBMIkX1ghGSDx6f2nTkZtFRBG5UrUvlZ+ly9AROVY=;
 b=If2AJislq2557b4te/Y2vKS3JL7HNyaVtRxb7Z1xWUccW0nbirz3/Gzy7rworg24NE
 VC18yUAcwVbyBoi/E6UFr0SHokjqt+QRkaZiTyaJFIUzgp7+jEHslVwor/oDL300+lJ8
 KVAmPb3gvlHN4AY0uszSaxFzMfEaFRqtKqBGCPHKfTXsDUQzrMfA6b9HNu3S03HuJAgS
 XiA3NleaIS+hqrz5rOBd6OvwzIvhKfMa1Hdeb6DvL6upjNgthBK6JmJMyfRqGUFFwa+K
 Ew8WLOd2BEqcJZJ7lEmM0opRNeOr1uhw3Z/Iag+pa7buLHJdrwrCT/cQrEfiwj094FoT
 uZSQ==
X-Gm-Message-State: AOJu0Yxx89WvqKYVLgCkT3zXTW0Vscp4NikZM7JY87ZAD6+ULzq3yafS
 ah28lMdervQV3NOWq5SoEUjYFvLE7zNyL1+bpxPktqHwaWp8GS10My4XFT4C8sEiBkdFq+1TKrR
 QMX4=
X-Google-Smtp-Source: AGHT+IF9hw6qLYVmTcM3Cg371Hf9UmE9mucdwwBxw+TVY6/0BIYNaTUcz2iCkh72Oo+y7rOFhBYpog==
X-Received: by 2002:a17:907:2d29:b0:a3d:7dca:4c81 with SMTP id
 gs41-20020a1709072d2900b00a3d7dca4c81mr2797873ejc.18.1708008385544; 
 Thu, 15 Feb 2024 06:46:25 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 kf23-20020a17090776d700b00a3d014fa12esm613750ejc.196.2024.02.15.06.46.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:46:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/3] hw/sparc/leon3: Strengthen SysBus & QBus API
Date: Thu, 15 Feb 2024 15:46:19 +0100
Message-ID: <20240215144623.76233-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v4:
- Rebased on Leon3 SMP support [1].
- qdev_init_gpio_in_named( leon3_start_cpu ) without opaque

This is the rebased patches of v4 [2]. See cover:

Hi,

This series ensure following is called *before* a
device is realized:
- qbus_new()
- sysbus_init_mmio()
- qdev_init_gpio_in_named_with_opaque()

and these are called *after* it is:
- sysbus_mmio_map()
- sysbus_connect_irq(),
- qdev_connect_gpio_out()
- qdev_connect_gpio_out_named()

[1] https://lore.kernel.org/qemu-devel/20240131085047.18458-1-chigot@adacore.com/
[2] https://lore.kernel.org/qemu-devel/20240213130341.1793-1-philmd@linaro.org/

Philippe Mathieu-Daudé (3):
  hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
  hw/sparc/leon3: Pass DeviceState opaque argument to leon3_start_cpu()
  hw/sparc/leon3: Initialize GPIO before realizing CPU devices

 hw/sparc/leon3.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.41.0


