Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2C9FCB60A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfw-0006kP-MG; Fri, 06 Mar 2026 10:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfT-0004qm-UW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfS-0002pQ-Ac
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:43 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so2301590f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809241; x=1773414041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TUbzVPCJHafQ9ANhUjINzIDMnhhGghwfl2F9rNmrhP0=;
 b=sN0ZykfN0RCA9mjuWxSwU9KtVWIDWGwH4ywm2rCbB+tv9WiYTqgrB6lo9MQ5IdeJh4
 RRSGpLNzdRJkLTK36Hf4ii7pH8zkAVBQbvSVdKK9kUH3tdWy+Mf10Pr+CtAhqgclkjQt
 RA2e2UpA0um3cw/SfPmwB1Ur6Qv73unhIU4zTUOK807IJwWL6gMQos1DuaeqJbVirFsS
 xdRVx8vdkc/JuzHZKF/9g3mfwRDdhwYYAk76iFzfDfUu12Zz/EEdEihstlhQqDdJXZVi
 Jx/Z/OLwtwa6O1XPihkom0zZkami2po5TKetHUKeH6MrhLCVzLqpGEdFmBhk/4wCW1hM
 8mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809241; x=1773414041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TUbzVPCJHafQ9ANhUjINzIDMnhhGghwfl2F9rNmrhP0=;
 b=SzmbGMXEkPC606Vf5TGCzAarN65tmBSfq98EVHV3FDKBAMy2ULemLEvf0Z6zTsOZwc
 yD9RQw1KpucABtfE03Ve1b5dgb4E398N3D0ya/OmkgB1rGizbNx2uO0xiP6L4B+TSmWp
 is+4HtUdK/MA1a/gMr0+rbcaWqgj2Zjg93UFeCVyI4fO3MT3RNWj18ZS4GVzLKPm8Fgv
 jtqHX16YfQXDPGMPL/3NChVNyOxMs6D9vRP95pNSdURO30ngI3uLjerLyVc3LNzkwBUU
 eQ2yRyEy1b1Lua7GI4aPhG6fLrCHNLsqu3OSbXfgJioEeSvXhcso07C8BhFJTsp94rvh
 sv/w==
X-Gm-Message-State: AOJu0Yy/HJpbxhWWkZIFay6djveF85S2aWEQkPEF8DZXAObLEs0q+K4q
 syjy2SL04l8bhfXYrONW1qpP6yWYF4KLuNp6j0NfjJLc004gjRaM0kH74zmQaEB9H5Sf/B08Nho
 udUvb
X-Gm-Gg: ATEYQzzG7c/i+V/wnOxVHU3Fpl02/9PRDpJibeXjlaKMycCqgXZ5yPOJtYY+YALmsyf
 YgEqYOCOaYdP+Sx7iPLn6Cer9ShiHkexcfI/KQmVxwaB9WoGWJQXorOCRnFwHT5LU+UyUizvFEL
 ZyE0OSY4DRj2Q5BHgbMD2lUZ+63NRl6ayXG6N0uwWIZDsL837xdcTojaULzi4NgeftwjUkkMA8Q
 JddESc9vYZxYkK/MbO+00DA+B9HZ0Wan+Zbf5NcLmPviP90KAPc2dh7juQV+UzXOowsdfDTtbWV
 nUQnhtH9lhfgePFQzgfOT2p7VcHWOHGcb3g3zOtUV9H5VnatvVY4Lupw0WTsSj1FwHOytn3ripO
 HPqbESevntMkrPl7gp+HOiVZI1a0QMZ4mw2wJ8vZBYqGlrBeI/2wl29Vxzsg3/WKiDRFBa3irAg
 up0guBTwO7PfFTblGzs3EXlfb52fK0BKQfQfMoNsif5nHr6QjHFMOXDOjGhH98QaIH2bo4LqbRA
 DaW81l9yNbnngaVGhHDM1XRSWIUGok=
X-Received: by 2002:a05:600c:4710:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-485269792ddmr35632595e9.34.1772809240632; 
 Fri, 06 Mar 2026 07:00:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/49] hvf: enable nested virtualisation support
Date: Fri,  6 Mar 2026 14:59:39 +0000
Message-ID: <20260306145939.2162189-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-18-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90769936d0..bced9f67f4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2393,13 +2393,20 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
         exit(1);
     }
 
+    if (vms->virt && hvf_enabled() && !hvf_irqchip_in_kernel()) {
+        error_report("mach-virt: For HVF and Virtualization extensions "
+                     "only kernel-irqchip=on is currently supported");
+        exit(1);
+    }
+
     if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
-- 
2.43.0


