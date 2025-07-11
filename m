Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48740C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuZ-0005N0-1U; Fri, 11 Jul 2025 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtv-0004RI-9E
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtt-00035t-G0
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so3370235e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240891; x=1752845691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fnzvogd1uSvEdf0/LpDdDirPBucDnCNCJdSSizExPTI=;
 b=Is9Tp8DejD5H30qLQgftsm0Z/DzMoUQntnz6S0gIJcVTn3HXHf5po8YKfvubdo3t8n
 QhdiXrnyZU0vtxsKnKCZ2DzrIeNmfpiK609ah0KygBWHTykbtolt1Hb/xMNwP5QIjGxy
 oUzx4cRU5vy6Jqs7y3PF9hRbyBmusnrVRsfWmySFcvCXJxJuPUM6u4p515dfdv6qI4AF
 oUfwTwIa/kXIi+QzvWOrh9NU+bZTcb/5D0+oQePd1p1Bt4tO0AtRZ+qNSv2PeLOXJq7u
 pvFOU6OTeblHKbieM8a+bm3SLOA1LZ2tuQqaLy4cB2TyBNCxkxBrwcKSm0VRgxtlkEfq
 lJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240891; x=1752845691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnzvogd1uSvEdf0/LpDdDirPBucDnCNCJdSSizExPTI=;
 b=nvhhTh8RdfseMs+7u3bLblKusaYKkG2ev58u8D3R7CwDvUfEQ6UE7juwuzAwMIFYZf
 u3NwSMC11CVbXugLxL//OnAPeevydn80lXNSZlHWkfbBsdWaZardarScJbN11zqZtHhg
 WMX+YFccAomQiOkZZqI62ZvhrynK2dy+2BUz7TGiwpj98ez8nDMTg5R4vRDS4uBBkcky
 CK1a4WsHPAUIox3Xvd1IsoyfnhSzd7TXN/aBwQaZYSw7rVcEnTdTYhzd44g90b74lh6E
 IyKYMsI0tmMRha8FJzRaDPnr7Kc1g0LL85d+crghQiZX6Ff9E+yj/j85wes8PmeQ6OK7
 szMw==
X-Gm-Message-State: AOJu0YzGQ8YqIpI/ynAk2jgfuoRCa0Yo8ZBj6xvXq6As7rU/oszVBTqp
 JyM6fxHnCgj2rsa1B6pPibi8f59mxEmpyGClzn+2rC2YPJPugYtMWYCn5f9E82gaPqe9lDZaRB1
 rrw8q
X-Gm-Gg: ASbGnct3f/mRFUul6Wbvjw91mSjHGqbAyxxksPjf1eTIaRldI17fXxU6yxNvVcorSkh
 A7whBOZZADktPl8LEXb7A6dUtTqFWRTyv+9pFCXjGfb10vDJVcaXMymvPMIjLela5J/IMrCrLis
 cRiVzAZ1YOuf0l+JRr/vqZKEB2iT/E6X7LK/GNv/OkJGpUyIUoPrptUYbJ9yBiMGbUUDmWMoTI/
 ts0wUSIbDUtdFX1mCyUzW48Rz1mN3GNWUX4ZCs+QldyzlCaiYusg/2qlp1n/yYzkG2OorqJXViD
 x5fV8nS/g0g6eeMSi/XjPeBHbNk0DzOOT+PhLTJGwk9jCPHeSIYMk8GTrFXlxY+q0iqkxxOnzVw
 rgnUhT1WKQqfQKaijOdtlR4TxrjVQ
X-Google-Smtp-Source: AGHT+IGzcXA3lMsM+9ouXeJu3D1hElHuhjfDIdEei8Vuh0fHpID423iCzgnUXJHlSJXIgSz9ukNgxw==
X-Received: by 2002:a05:600c:37c9:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-455e7b63b8emr22499435e9.27.1752240891532; 
 Fri, 11 Jul 2025 06:34:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] arm/cpu: fix trailing ',' for SET_IDREG
Date: Fri, 11 Jul 2025 14:34:12 +0100
Message-ID: <20250711133429.1423030-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Cornelia Huck <cohuck@redhat.com>

While a trailing comma is not broken for SET_IDREG invocations, it
does look odd; use a semicolon instead.

Fixes: f1fd81291c91 ("arm/cpu: Store aa64mmfr0-3 into the idregs array")
Fixes: def3f1c1026a ("arm/cpu: Store aa64dfr0/1 into the idregs array")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250704141927.38963-4-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 3a65d3903bf..bcc8e2dfafa 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->clidr = 0x82000023;
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
-    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull),
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101122ull);
@@ -426,8 +426,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
-    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408),
-    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000),
+    SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
+    SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64AFR0, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000001122);
@@ -678,13 +678,13 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
-    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull),
-    SET_IDREG(isar, ID_AA64DFR1, 0x00000000),
+    SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
+    SET_IDREG(isar, ID_AA64DFR1, 0x00000000);
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
-    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull),
-    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull),
+    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
+    SET_IDREG(isar, ID_AA64MMFR2, 0x0220011102101011ull);
     SET_IDREG(isar, ID_AA64PFR0, 0x1101110120111112ull); /* GIC filled in later */
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000020ull);
     SET_IDREG(isar, ID_AFR0, 0x00000000);
-- 
2.43.0


