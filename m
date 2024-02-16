Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC8C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw2A-00023L-3p; Fri, 16 Feb 2024 06:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw23-0001ZY-VR
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:28 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1s-0001FM-Hx
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:27 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33934567777so1057476f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081514; x=1708686314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELKUbUBr744bWbi9HHUFUd98mluSMaEj1sworCQzpug=;
 b=Hx/8fgPXQq5hg4OPgOcSzsfgVa+ySPBuLbXb6XoE6MpS5Qt3zWfpoMP4G9rBhVzLf3
 holnO1KCNPid2zQheWFV+d3TSmLDlTkdoeX6tNHhk8LfMWXfNC2pmLOhKoxiSefimFcE
 DOXXH9E1XEz638rO60CAgUaIafpoVcPMWF697jVf7wRXNvjGteM8ouE1RYJChM0ibVy3
 5waXu1msyJM4lwfvnAgMrtVWtwFv9oAFqWfq1JRPreIGSRklGvw664q5HRLogkYebKIW
 /v+VcW695zUrGewdh9BAtwEFFizcD86om7VEfTNNxwxEivGpBgTGwfqFa+UytEQ0c+hL
 ZRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081514; x=1708686314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELKUbUBr744bWbi9HHUFUd98mluSMaEj1sworCQzpug=;
 b=EZOKFfryG9YKIZFW0pu1Y+F5jJ6Q0h25MI29GOUBs0pQp2eQqDx3EE4/2jdo3NKJMM
 WXiwBdW0FQ5VjQ6hBN8PylXZ1Y4aWIquA8jwzcyf74i+CqERqe4qhLX7xygMx5RXIEif
 OamxmroLsy8TpvaiYGXjVRL2fm4KDPOQ2QqMr4EXcyc4/H5oNFxjDIFnPK2wzRKca9Ii
 TDS02b1O0xoajW5ch5Uz3E/LIMnaiXJCZYJEqbNk5S/mJX0dGKarIGVSpMIiQCjHA9Lp
 niBHNhzLurVgJDo1TLPXI7KWU27vnGjCFO8f7JLMKQXOA/Gz2fUZRqgYEWjPXrBBu7VG
 R/Yg==
X-Gm-Message-State: AOJu0Yw4/kwi0akbgR1mUtLQBMKl3IXV1qiQqoedQYRWFynnsqyED0vl
 B0yYPTRzHH6i8TWrBsB8rem0Xubcz62otwD2+Jy0Y0YiCIYXcSiLCFpQUscxJdrFdPRgZHT1NSn
 S
X-Google-Smtp-Source: AGHT+IHLOkpd1E3B//Qhh6skOFM859/0GFEnyy22LpH6nRR/jpLF34pA2atSRcEoUH04EYIRGJGmiw==
X-Received: by 2002:a5d:4a4f:0:b0:33b:5087:c913 with SMTP id
 v15-20020a5d4a4f000000b0033b5087c913mr3438284wrs.54.1708081514666; 
 Fri, 16 Feb 2024 03:05:14 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 x6-20020adff0c6000000b0033cfc035940sm1889460wro.34.2024.02.16.03.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 18/21] hw/pci-host/versatile: Replace object_initialize() ->
 _child()
Date: Fri, 16 Feb 2024 12:03:09 +0100
Message-ID: <20240216110313.17039-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When the QOM parent is available, prefer object_initialize_child()
over object_initialize(), since it create the parent relationship.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/versatile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 0e65deb3f9..5d1f9cc96d 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -410,7 +410,8 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
                       PCI_DEVFN(11, 0), TYPE_PCI_BUS);
     h->bus = &s->pci_bus;
 
-    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
+    object_initialize_child(OBJECT(dev), "pci-func0",
+                            &s->pci_dev, TYPE_VERSATILE_PCI_HOST);
 
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
-- 
2.41.0


