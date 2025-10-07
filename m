Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D371CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68RB-0006Ab-La; Tue, 07 Oct 2025 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qn-0005wE-Pc
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QU-0002Mc-No
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so68785075e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846341; x=1760451141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkslV1yaMtt0NINKDoLOHpZl/KR79AU0Um8mFMWwiMQ=;
 b=QIUHacq8OVckniQRcXc8woW+JYLZQMZYMs8cdvyeeuidjXHmxM2CYzoDxtDhDa5gzB
 Ux3XxB85AHF3UVfAG4AQIEo9nNCnIpDPEXgI1ls7uv6/kbzF2u6EvcSYCzsrgiun+bUq
 a42W/tzuVGBre0Pks2FCVu1IrW8yTNyp/pNJrobldzNu/yhrg0j0kGRdgvjAD5Ujwu1M
 pgb/ia9FyjEAASaebEnTFsrHlXWIrPlVEmbMoeJKm5rPYr1fCdkwtD7uBb9kYTJjLucB
 OAWBKXfi/LDwADLq9uXPolTAorjAgnJXiR4G5VCjnRc2q3W1u5tJJmoMqcQH4qzCHCTI
 6/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846341; x=1760451141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkslV1yaMtt0NINKDoLOHpZl/KR79AU0Um8mFMWwiMQ=;
 b=PCOXkU6ra3Sc5T1zQ+a/JhFt3EM0yQ5TsW5pO6vryuz3AbZgvBgqtvUMDZApPe25zV
 wm8ado+0nbgXLvrIb1kJFgLSwyubYTTWVWsKCzsv6viz/Wd8N/rEiP+E0cbBjSOmedZ8
 c5uXXY3KttYFFGGRyS2LYdai9DCbFu+4QAHsYGmioHWvv/UZ3WWtryT6g6eYXt/Ih9qu
 5XKXB2U1ENIyWlhuxexRoR5lKXZzw4oVs9T60YCZxVYzC0bUDMo+b8+QqXWQz1ECLlcw
 F9pstNPPzdkVs4UgRq6h8EbwkRTDooYAZpmI3V6oTH5fKPtdqOdLSvME66Mk+OtXqbVA
 JsKg==
X-Gm-Message-State: AOJu0YxMAXyKCI6lUca097ryeWxK8Af/2JdSeqrT6oCpMA+SZCDExuCZ
 3V9KpBCsoN8b81f0Q4vpBs0DbPio3rhW1ZEldqozjesL/nQtK3mmz+94BGaP41gfiYqPVOexLQR
 m+SVF
X-Gm-Gg: ASbGnctcJ4lXO9sdKCo4Bva3XVYSY1teYqyUxTMCUYvqUHXGlHv5FkJ+jMP4pK/HSMh
 ZWb/53rYDgfd3VJwTI/ri7KMOtjp8DM83fTbdyc54en8Snfs9Gv16fauoHiutZmM4EtLO2R8IeL
 eQy/rijEzue0KVhEv8cJo7ns7FayCU3x3NcNc2VKQYN750daLfjxkcpB2QH9+qruHppqAugAyEq
 BH3qas91muJ/+Yakd2MOye8EqvLxUPmXlS/AzCmc+f4CWxPtsDSOk6mi+JxFwRClkSmo87oQays
 T9MCSO0Ob2hmyrd0PVBIrCvisEyRWsEFF4vb2vuzVf4luJeY9erRWoVJtAmJqTxqVkUqNf/K9Q8
 NC3ezskkCJWBNZ4A1lG1HXRz2U4tTM5b9bYYw04K60U3B7lGJzXELiZDLa8OVgDaw58Q=
X-Google-Smtp-Source: AGHT+IGolDlbRhT6QPyq4Cgp0QifFfrsGrrakuToeRVi39amWEVWlAzUFGZvwe1ZuSI+ucxCJ8kvXw==
X-Received: by 2002:a05:600c:1389:b0:45f:27fb:8016 with SMTP id
 5b1f17b1804b1-46e711043b1mr88268245e9.1.1759846339178; 
 Tue, 07 Oct 2025 07:12:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/62] hw/arm/xlnx-zynqmp: introduce helper to compute RPU
 number
Date: Tue,  7 Oct 2025 15:11:10 +0100
Message-ID: <20251007141123.3239867-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Clément Chigot <chigot@adacore.com>

This helper will avoid repeating the MIN/MAX formula everytime the
number of RPUs available is requested.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20250930115718.437100-3-chigot@adacore.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d7adc070f8b..3d8c46986eb 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -207,14 +207,23 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
     return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
+static unsigned int xlnx_zynqmp_get_rpu_number(MachineState *ms)
+{
+    /*
+     * RPUs will be created only if "-smp" is higher than the maximum
+     * of APUs. Round it up to 0 to avoid dealing with negative values.
+     */
+    return MAX(0, MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                      XLNX_ZYNQMP_NUM_RPU_CPUS));
+}
+
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
     int i;
-    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
-                       XLNX_ZYNQMP_NUM_RPU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
-    if (num_rpus <= 0) {
+    if (!num_rpus) {
         /* Don't create rpu-cluster object if there's nothing to put in it */
         return;
     }
-- 
2.43.0


