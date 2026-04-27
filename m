Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8FAFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUV-0007s7-3n; Mon, 27 Apr 2026 08:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLOB-0008K4-Vo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO9-0005ny-4B
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso94455495e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294115; x=1777898915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qx/HoouzfD2bG9m7t08A8JbHrDNgqGRID4fYcDYHUJo=;
 b=Yfs7VbLSYkMf7YlLAauI6u/HknmDQGOCtzhvQj3o32GERSE+foP6NnQ8PG97e4SHft
 RM98Uf0Y/n1qRAJxvSIs1VUBYpWFdFDZeGbFTmb4qZ6lfwDY3O6R7I199Kn2u+cWzfTX
 3gIpo+DzXlt1MkmAgQT4xwbcmyYjg5dOgORiVHKp2nLSPiymoH1mCOom2lAOzb0Or1ML
 eGboGOhmF9YwunUAeDf8xFxamf2/V7vhvwDEAosAZAY+8wQoa9KXI2HD1nnXtgpg82qq
 P/Zpqr1kGKm+iHwmjFU4MkwtjeMxauCLz5xf3Jjt07hSgnlqkmN9Ez8v1PnrFOBVpSR1
 dbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294115; x=1777898915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qx/HoouzfD2bG9m7t08A8JbHrDNgqGRID4fYcDYHUJo=;
 b=X4BkIWvEYjKvM8Hqd3uwVVIUHQBunVKnnqJrWf/WnFf1twVaqYLIssdPYXGUyA2jMv
 GQnNRV7GS0P/Ynb7oxX+fG0uZ5WIJ7S+dq8K7xDI6/AiBVlIfrQm1sjuXnXRGQTuqGsy
 2ObEc+do6844NQskD8Nn4lylzjUWK2/jhm4PbfmKb1oTQfokOCoTMQ4eW6CRCmZTTEo5
 O3DFEYwk28mObDYkJQtffnIdkwzzCqI2jo9iQWyurB5PAPaxG0Ito9LYMYF9vm009Rw2
 hY1Vsk79VAV7o+plStofCicaF33IU2/HImtrsq+JvoH6z1bXJbyDGek+rLZuan0/DGSp
 Ey4g==
X-Gm-Message-State: AOJu0YwPfexo2wU3EHsRTE90l1GcIxkPnl9teZH6OJKbk9OrovGvVrWL
 LkUDicE/NQrdJVvJMDxDIL4zwn4SSNcmly69LkBaz20/uU+GKcpBT4PuLdkYP8JYv+L4Ss3rUfy
 rSVSq
X-Gm-Gg: AeBDievZO97BQt6foclfuNl60iu+OcYOTfzGzlRMD2hwLz0k6ngaT0fn3UpV9tk94a8
 OJkZD0ytEUx5nEEE1IFz2xgTFLsBJyTrhSINMTMmCzSV7ksd+oT41D5+IuncgeAz2naZgkYW+mY
 jrzpbPeAYEYC0S4tes8lTge4Ej85UHm73StrW7G0wqaYUmNnhMMZUZdF76RNvakL8TxBIe20tMX
 dh4J1Gk8qmGIJJ5PIsYASpW/oZE9NTNOffJ7cU0ePaIcFXInwa395GpcORoKv346za0oofQtdUp
 42ZrwiJZUkYTnXMf62ZnqF+QjIcmw1qv2bkN5uvy7BdMv3PfCGucdM7OQBU7yMqJqCfs+awwf2y
 hz/6AGDZP/OVQT3J4WNMTYWJijTYUO3c6P8HrdulqzDp1IhJ2uuRbc4Hnqn2kvVbddDMWH5E4PI
 /Xc2Ph2Kt9wj4sJPBxPEYdq4IiExr51H2GbbSDyeJ2hkqRKoKFIQlMlOTbbo4eV/zO/YqCaXYTm
 zeOrTCVQYKaUFtNNbgEdJ69fUccT71WIZYWomB8mA==
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr414429935e9.19.1777294115339; 
 Mon, 27 Apr 2026 05:48:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/63] target/arm: use syndrome helpers to query VNCR bit
Date: Mon, 27 Apr 2026 13:47:35 +0100
Message-ID: <20260427124738.966578-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

These are only valid for data abort syndromes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-22-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index c74d8e785a..bbe1e70bc4 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (template_syn & ARM_EL_VNCR) {
+    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
         /*
          * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
          * they are always reported as "same EL", even though we are going
@@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * because we masked that out in disas_set_insn_syndrome())
      */
     bool is_vncr = (access_type != MMU_INST_FETCH) &&
-        (env->exception.syndrome & ARM_EL_VNCR);
+        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
 
     if (is_vncr) {
         /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
-- 
2.43.0


