Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D6CC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHC-0002Es-Fg; Fri, 26 Jan 2024 09:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0002E2-PQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH8-0007rm-Fo
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3394b892691so284537f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279625; x=1706884425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vu5+mTBX8rW6qLHNzt1OhoCL6zzW3Ic3LDbMk8svH4c=;
 b=xLV76L0ZlCnlIIn2vYMAbdPAU2eF3kQEIxSVQtrT4MImawa8urMkhxLDQiZZ0X2J5J
 F62xto0ZJBEKeKIrjVz/FjwrgjQozSc2J6Fn2cQbcGR3pG4B5xu11GVFLVORrt2vANo9
 mxu2IoMXs3QPRt02DxlYMaJkXJ/q7nnojjNSWK1xoQ7LVNYkpWs1gXVL/SjALhK9rKnR
 qyHGqpMZ6hfLQdvS3FDgJGI84CI1M7A68h5QhEUYPh/LdGWzRqY8pzM9nnqI4q/Y4hqE
 j8pIl6JTahfhewSfj2xcRc16kYRMSp/eDyTwhKzFYmOFfqE+2XYQRr2VuKWompzfZ3st
 nzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279625; x=1706884425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vu5+mTBX8rW6qLHNzt1OhoCL6zzW3Ic3LDbMk8svH4c=;
 b=ianeDiFhm19f06b9GlP0CEItMEpGLCS/PHSyQlG8AdnKjZ0X+s5SNMj6ux9kOCQzCB
 mH19R0LlOd/bt5mpT49ppdCVzStqUQ1wcYTYGWi0yx1u3oFnE5PzYE7D5sdfonfMghmt
 A0Q86DsNQK34ctFNX/GGa+eB62mgdzgC+3ok6vXuIAJ4YP71l/EMck1aDCNpTJuJdMSO
 LiYeLROSF8Zl9XHMrcaIGW0RsQ0bqWD6BFAaM7X03VBnjG4E1xpiKk5mJnZFlDuoa6zQ
 4OTLbNXopEOOv/Ui2mkK8r8MPs5M2mlE37/HUm8Dl3hzWouuBGSn2sPlOxCadQLRXQ4y
 zlvw==
X-Gm-Message-State: AOJu0YywbZJDg9h5dHhJXb7TqSgb7V8TdFGjsmtXI74AOxy/MRKlilnU
 jKf/vFFikQu3SME+cJPMV5+E0y4GcFCv4ADhoHl6QLVHLqhIVygTyangx6tT6/gOvBT504TltAS
 F
X-Google-Smtp-Source: AGHT+IGSpBAopCijh62thggyhIvqVDqZbQVke8A9WRn+bhR7trijqZ1bHS7S8gHtUgnlfG/v83w62Q==
X-Received: by 2002:a5d:5748:0:b0:337:b74b:6f1f with SMTP id
 q8-20020a5d5748000000b00337b74b6f1fmr582892wrw.22.1706279625123; 
 Fri, 26 Jan 2024 06:33:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] hw/arm/nseries: Unconditionally map the TUSB6010 USB
 Host controller
Date: Fri, 26 Jan 2024 14:33:11 +0000
Message-Id: <20240126143341.2101237-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The TUSB6010 USB controller is soldered on the N800 and N810
tablets, thus is always present.

This is a migration compatibility break for the n800/n810
machines started with the '-usb none' option.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240119215106.45776-3-philmd@linaro.org
[PMM: fixed commit message typo]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nseries.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 35aff46b4b4..35deb74f655 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1353,9 +1353,7 @@ static void n8x0_init(MachineState *machine,
     n8x0_spi_setup(s);
     n8x0_dss_setup(s);
     n8x0_cbus_setup(s);
-    if (machine_usb(machine)) {
-        n8x0_usb_setup(s);
-    }
+    n8x0_usb_setup(s);
 
     if (machine->kernel_filename) {
         /* Or at the linux loader.  */
-- 
2.34.1


