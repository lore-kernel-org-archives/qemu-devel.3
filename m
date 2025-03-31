Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3747C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL96-0003c4-TS; Mon, 31 Mar 2025 15:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8p-0002hz-N9
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8n-0003SH-UP
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso21920015e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450588; x=1744055388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1rAoFw8FyG6NwD6es9o9iWAe5ykbL1RM+kN37mtk4M=;
 b=hJ4u3E6uyxbvRjd0UHvEkeIYiR1E/13EaW+veqoKHkaiGucdtDYX8Ft28WzubQrulO
 v5wSPpQvFsrGJ+2Y9SYmwzAJ3OgWQDMlZq01Nc6aw1vJ5UHvJk1kzh95lTvBf37jN6jy
 Pzm5q03eaK/xTkMM/4x54765lfPMstR8hpQBZR5uHaDRUnsVUOWWKEDG8sBVN/RgJiAr
 SymdsKJKNoCPBKkBEEF2nirsTxCR6Hcmv2T5e1NlPyHv5FJ5NuL3djR+9nQvHetl/TPr
 ij0horQ8xODIBaV/o94yfHbr6ylXaIJPLIZ+WeMNIZ9eYMwnmqYa4plyk4nQLqlybcN8
 16Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450588; x=1744055388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1rAoFw8FyG6NwD6es9o9iWAe5ykbL1RM+kN37mtk4M=;
 b=qglBz2Wy5TF6gAUOcElTlwjCfXCrxJ4ogliiG3uGoo525phsVvuYa/zDVWBxxO/9it
 ORjSqiGOg/DGp56Rarl572eJ1nQ1mA17yfuODLYVEbv2tpKM63014ct5N78BLb5MT92v
 jz+v3PVoiNXYYt+VU/XShlgsPr6OW5PTZATWEY9MLMztx+QTlnxBpdnGcnHzdm3GRTDb
 F3io0gdPJ599nqxs8oNGWis0SgOuNvxczyNYRMFvs9PBpFVhExlNsInLSHP4JTUv07Za
 aFTUXoRCwsqq4llD5noTP8GL/WAUXjniv941o3JmxfPWD+jHxuSnRpL455wXez+QsR96
 /RpA==
X-Gm-Message-State: AOJu0YyoCpCawqfKT1rTNFpPMpMbaiefJ7qIihmnP+nMYZFvS9JAtoqI
 cQcYMghW/lPj2VyFqH1JNodoYxXzSujDMnqrXrtz2+24Ux1+owDj9D1MW1HOIIMkaFxsZKdeGXY
 S
X-Gm-Gg: ASbGncv1u5PPOZJ1OL7C2E1ByQxATnbU3/W7RSz4qR5mbkmZ4XDAxAf3etIV6ytV9fL
 T7KboVGGUMQQZQmAFHHFg9PIabbdldounHI5vOuGYEMZKDASKEwVv+fLp7A1mBV0cnfZk5+/Csy
 jHRsHSuZqA3rgp8eCT+ZZ0+9FYGkVCWXq9ThBkv1W7oC+EiDfb2oEtAYjhOJQXdz+REJY87j9bt
 V1lAFhUxbwljghxk05+OHOuy4ALN5QFwO/pKciMtpeZzv1iIAkGhWhmtDrwntI2ThMaNlOuziXg
 vRzpzHu0X7popepfOmrVR2RrTMu6Fiv9Qe13vSVvEZH5o3XJdP85ZLuRyKFpAkcwHKM4Y/2o7RI
 PhYWQ46r7I5cOUVFwU44=
X-Google-Smtp-Source: AGHT+IE+fSoHtmGLpdKLJSche7MhHuCLx8vQsi/hHC5wJFbsGh7ORDYphg0LlhjFxNjUgMF/dDj7zA==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-43db61ff68bmr106197175e9.14.1743450588152; 
 Mon, 31 Mar 2025 12:49:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc10f7sm132920615e9.14.2025.03.31.12.49.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Joey <jeundery@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PULL 17/23] hw/pci-host/designware: Fix ATU_UPPER_TARGET register
 access
Date: Mon, 31 Mar 2025 21:48:15 +0200
Message-ID: <20250331194822.77309-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Fix copy/paste error writing to the ATU_UPPER_TARGET
register, we want to update the upper 32 bits.

Cc: qemu-stable@nongnu.org
Reported-by: Joey <jeundery@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2861
Fixes: d64e5eabc4c ("pci: Add support for Designware IP block")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20250331152041.74533-2-philmd@linaro.org>
---
 hw/pci-host/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c07740bfaa4..5598d18f478 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -371,7 +371,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
 
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
         viewport->target &= 0x00000000FFFFFFFFULL;
-        viewport->target |= val;
+        viewport->target |= (uint64_t)val << 32;
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
-- 
2.47.1


