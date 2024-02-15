Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0A0C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag68-0004Dq-AZ; Thu, 15 Feb 2024 13:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5Y-0002tL-NB
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:04:02 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5U-0003FA-Tr
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:04:00 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso172947066b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020235; x=1708625035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Trz8Izvuz2UeQ/LEyIdx4V0+3quGaJPJGfbh/3eXoI=;
 b=S7LzbEBVn+eZK1SRonVtsvutPGUzc6Bjzh8TmKaMXRmqm8FCuCd0NQxwRm7uR9I3XZ
 tNib4W+TgJCmDu50eOUKnOvLgGClTek5OMEiWt5qLmYJ+FrIrI6pgdv2h/rcqHhoEMTk
 f6P6oTQPcQdn8vdVLFXE72/gioopTbBZg6t5olPhIzgpABpoL6H2m4w9Kf0juMNoOZyn
 O/hnrvNgmp0Z141x2tuMsINp0u4ePGI2iZGlJvPj1BeB241yLLzNSaoyvDsOeG60Bx5h
 ZnIRQDBJktlaqUQ8cb9wag3A1br9b3Grbduh90OSKvkHsRRagAPl8wRMz5mbJXQDgpG2
 pbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020235; x=1708625035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Trz8Izvuz2UeQ/LEyIdx4V0+3quGaJPJGfbh/3eXoI=;
 b=SVPD1Ol5pLoYsSfnJCRuNvZnnDWowwTlZQbkYqFBPpDoS7uukB9cSmHOvKWGSJB42r
 yIe8VQTcNuLwChA9CRp7eJtFWSLOyooj8THto0dd1MZoKR70xiohjm6yYfAL2FJpozdX
 F0l3/tRtkb0Nm2Ppm256fYIw+7+PxVzADckLVMFK2LGUrQ0BsBRyZuLk2J9qFEApw8vs
 hAz6UjSS+mjVQVwUXv9GPGi0hSSOOYH2eR+7IJ6u1i7dnogKZzxUBiwVWvwTNaSz2O+D
 nIOvdBRLM+N233lIUZzvHbk8SOyGLiIdblDPxUJqnwdhdn9bbl4/u3dJrkTD4rmKzi+O
 5r5w==
X-Gm-Message-State: AOJu0YwdiLdHClurZ0hHhw/adPqIq2GzwsiPOvFBFUaID30eKcvwq59M
 ShQFdIIHKqbb3loVi8ApTdAkFUkeLi7Ut58/Kjk44danFcC5tMxERHtJCqWPmUYeC5vBT1YvzgL
 aGNc=
X-Google-Smtp-Source: AGHT+IEdvTuJDoJp3t8WTfGfS89VHZCM4nxJqZcfu1K91gFKsCQkwBHjYuDAu7IEeeJY6BXuK1VJkw==
X-Received: by 2002:a17:906:338b:b0:a3d:125b:d221 with SMTP id
 v11-20020a170906338b00b00a3d125bd221mr1667572eja.26.1708020235273; 
 Thu, 15 Feb 2024 10:03:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 sn24-20020a170906629800b00a38a705121csm779300ejc.47.2024.02.15.10.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 54/56] hw/ide/ahci: Remove SysbusAHCIState::num_ports field
Date: Thu, 15 Feb 2024 18:57:48 +0100
Message-ID: <20240215175752.82828-55-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

No need to duplicate AHCIState::ports, directly access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-9-philmd@linaro.org>
---
 include/hw/ide/ahci.h | 1 -
 hw/ide/ahci.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 604d3a0994..c0b10c2bb4 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -63,7 +63,6 @@ struct SysbusAHCIState {
     /*< public >*/
 
     AHCIState ahci;
-    uint32_t num_ports;
 };
 
 #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 33f7e83687..041cc87c11 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1862,12 +1862,11 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
 {
     SysbusAHCIState *s = SYSBUS_AHCI(dev);
 
-    s->ahci.ports = s->num_ports;
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
 static Property sysbus_ahci_properties[] = {
-    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, num_ports, 1),
+    DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


