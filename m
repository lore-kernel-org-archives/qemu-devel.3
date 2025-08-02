Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A992C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjl-0005J4-S2; Sat, 02 Aug 2025 19:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLh7-0007Vl-Lq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:22 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLh5-00050e-W2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-741a8bb8aa4so160515a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177474; x=1754782274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P80G+Mqq/PBj5fm0u9e6xc+6PUuM6bwSvtsR/7Pt9Yc=;
 b=TfmsKU8o4q/LgSrOIcAl2mwjkja73vmQKQOaMyxlpwE8r40q70xdkkwdxEXKQUEKR8
 b5wNnGv4E0fzhARVHxzJxLBLQpuOZufe+Ipq3lHvcl+oFu2GVj5VwWuRX65a5bevkVl+
 1rOWE1lO9dNnKy/a45KjVFhK+RF7pBo94VPn64kpX+ZoofLsQQ+G9DXMRt0okevhXOJj
 62WKWQCw2BMJbZe/wfni8bjtelvK4cLsrja/z8pVSkG0/s2SBMV8WVU2qfqmH08WJbTo
 Nt1DNezxXmlvtKeMl743yAMOOkg1sUVGNLcgPO3nLBIOc7MbJHeiilDQTjxoATW7CpjY
 M9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177474; x=1754782274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P80G+Mqq/PBj5fm0u9e6xc+6PUuM6bwSvtsR/7Pt9Yc=;
 b=ZNcjTFWUN6rY5zqpZRYrCpf/wHXKzkm72ig//ecUsffDdkPJqp4K7fVYOgwSLcBD+i
 5hGNfkahUI27MznSg7sOQAGqyqU+Y5d3lWTs0k8XQrXQqLxk28/v6IXylgvrKI8qqmcx
 tYSRjRe6g0+oJuEUW4kvqYAnbW04RNP+U0953Els8HFxni7layD2GXOoYDuin94CyA+j
 Kectzi1xkL97IgTzLmRXc8eEjAYqy/HWuf/1o2/z7UVgxqzJhN5pxbrZAT0n8WTWL/cF
 P0fPpzfJRIOpx1LT3Ihemrb+BxPoKWJskcE6jfx6VREurOIscWsay1STyVJuUMKoyfhQ
 LC3g==
X-Gm-Message-State: AOJu0Yzhx73SyQip+L3lI3BWbu3Onjv+JPLEivjEgaK1LMwNPxKI3RVh
 J+SUfPU8yR5NchD5mp0EyNVRepHmyjol+Qr8mkR0Gn04Bawv8zpAxPDMS1F6EqgxcOzVkZfmxje
 BgCooZKs=
X-Gm-Gg: ASbGncuINYGhOqmQnku1a0UmGUAjiD/oohK02gQCNNCZ2hwVhX6QYvVRZWPhb5EtG7N
 Ohd6Lkp4/vhG0XYOXfmcCyXvZROvFmpGUJzmNctsKFWgE5WNJx9PYX7ArMrgeaHYsf7+VzdoR2L
 Scm1daXerLmeq9tOnuSvhnm7qV+qp1vVBLzjxoH0cn6vGvl/JKFOt4/LuHqGIIXMLZoBvz/wMO6
 n22yhZ29S9M7GAht1zc9F+Olvx6yZvaM7qotU4ZAWvnPKwAfw0qa+OMIfS4EhORpmP9Bc2qdutD
 fXbZSAZpecM5oTV9pPL1iJ2hn7qE5UJCzg80VbnUq0+ufw5T7NUj0/mqBqBBDCLO3yCj/V4a4fJ
 xZ3ItQ46pXhTwsY3iREnxVsazAGjHPyqjK0XLTt1z7I1xTv2ze8aKbgs9Di9Td4g=
X-Google-Smtp-Source: AGHT+IHAge1UajJHYqO+OIVab+CpN2HvImOtBO/RfqnCiNnB3htLrlzQlMc0rD/udKK8v2aPQNWB6g==
X-Received: by 2002:a05:6830:7187:b0:73e:a0fd:ac84 with SMTP id
 46e09a7af769-7419d165690mr2980159a34.8.1754177474493; 
 Sat, 02 Aug 2025 16:31:14 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 16/85] target/arm: Force HPD for stage2 translations
Date: Sun,  3 Aug 2025 09:28:44 +1000
Message-ID: <20250802232953.413294-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Stage2 translations do not have hierarchial permissions.
Setting HPD means we can eliminate an extra check against
regime_is_stage2.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c |  7 +++++--
 target/arm/ptw.c    | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6353b2dea1..a6130f7dcd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9639,8 +9639,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         gran = tg0_to_gran_size(extract32(tcr, 14, 2));
         if (stage2) {
-            /* VTCR_EL2 */
-            hpd = false;
+            /*
+             * Stage2 does not have hierarchical permissions.
+             * Thus disabling them makes things easier during ptw.
+             */
+            hpd = true;
         } else {
             hpd = extract32(tcr, 24, 1);
         }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index efbad7af1f..2eb2041edb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1472,8 +1472,12 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
         }
         tsz = sextract32(tcr, 0, 4) + 8;
         select = 0;
-        hpd = false;
         epd = false;
+        /*
+         * Stage2 does not have hierarchical permissions.
+         * Thus disabling them makes things easier during ptw.
+         */
+        hpd = true;
     } else if (el == 2) {
         /* HTCR */
         tsz = extract32(tcr, 0, 3);
@@ -1979,16 +1983,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * except NSTable (which we have already handled).
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
-    if (!regime_is_stage2(mmu_idx)) {
-        if (!param.hpd) {
-            attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
-            /*
-             * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
-             * means "force PL1 access only", which means forcing AP[1] to 0.
-             */
-            attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
-            attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
-        }
+    if (!param.hpd) {
+        attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
+        /*
+         * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
+         * means "force PL1 access only", which means forcing AP[1] to 0.
+         */
+        attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
+        attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
     }
 
     ap = extract32(attrs, 6, 2);
-- 
2.43.0


