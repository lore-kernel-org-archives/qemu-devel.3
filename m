Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FB9FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLR1-000321-QJ; Mon, 27 Apr 2026 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BI-Os
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005jU-Iu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172752535e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294102; x=1777898902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rTgagNZc5+/mV+3XbzfZwoEUH7aZwakCX4wYssDEI18=;
 b=Kj5y3IkmBd25Vh/MIBjZEDW0TO3/ogcQFqL1Wprm3LWYqgZW5b4Z9nnDiGW9CmyGTf
 bTpjhDlxIIj/AjrMJ07g2FytNjtQiFidZ1uOm1yKE9HdTVLc6j/10KLgGpE3QIcwfH3f
 JJXFdC3vUzGW1qPC4Rbcez1zpoyE4NiU05B5yBmPd8qypo1Rovs2HIyJMTmsHyBF2hli
 s9NWltFWHZbdr/NXIzmC03PjuAnPS88KloIDf4bTJl7Gvhon3S/Yf6CqCdi0dbXceSMY
 hvV18S5EQCCCrBXCIZr8T6y8auQN6fh3MGsyXaJaPYGjDzFZCX2ZWIgkR4sbKtTnyKgx
 7IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294102; x=1777898902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rTgagNZc5+/mV+3XbzfZwoEUH7aZwakCX4wYssDEI18=;
 b=PCOcVt2kUtzqFhNiV9wRh4NuuPjKJ8YpXceGj16DpPULTURGx6rAKFIuWbL1ihdmxW
 X3w9jO/HVsmKXIVXurLPhTyv2pFc4J1RSUG1ileGAga86GSGVromfyA+IfTiU+g7aC6o
 kiB2Ri5I0UbAyqiJKLXz7pmSP79wgBtpUZDv26gu88voutWUDmSHlV/vxBplMgKE+Cc7
 xDO49Y8V1BohQ/3tTupiSYio7TVYiFvaSzueAK4zJACtp9VlJQiKDh+83wYoA8wYTEU1
 60IrM0P6KDWPqqNLtg5QiYPVWtMB4t8nEdoJe18vZxtv9Xk0W5HJUQHCzfMRmfA52afJ
 BhJw==
X-Gm-Message-State: AOJu0YyEgCufEHpWEorCQC/E8aYwMZvAfXvJlLdMgQijMFLWOVLXKVf9
 jjpmL+fjaADxvm5C5SP9NqWa6wM+ABoC0aPFLsJ4dk3+oAbmAvksioVoh1eY7R1sdOZ9UjpasEm
 1eqNl
X-Gm-Gg: AeBDiesxCortpk3BLYkVfgJzd/G/ohp78j6/4ztjolJE0xn8dsr5bybZP7m+hNA6ciG
 v3TBscyT3k2bhFGyOztDO/o3L0CLPjE/gq0HPHjo1xpcpNxW4eQvyNJhh+pIi2MGI4YrLXkT+Ix
 u0Uqn3law/EOVkrdtM31TRdDroUB28K1PSoYBJdd0VLKi7SKOCtopQcNb3nwrMNj+UUoGg3Vtx7
 eSeOQl/+uM10ciFJVLDc5fNFalQpuuXzrRdWI89UaWtCLJ5TNYEhcKnlRRBvWoxvfdfWKZy6uCv
 2AQUpi1rp8J86CWubcVdT/XT/+Hl0zuvJPzjU4le5WUPHUChJVpQbParGHlaVrCXnpiHy3i4lAW
 uMpCG3G0B3MFrRFxiRw4njTwjc3MghgngB6kVCUkJtHE+zRi++ySPwdLh5WoozYjjVzc2KOX31R
 z6NSjaux7IdRJWqk1wbGttSP5W70TWiJBzPEViBHnhGkfRWZshFYbaHS4QxMLBeiGEOYP8L0cjA
 9SuVfDHltLOBmNYJ1W0yvaRaZ7ul4PEAYRM2Uec+9gnllTsiZk1
X-Received: by 2002:a05:600c:26d5:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-4891c1f3715mr294847215e9.10.1777294102058; 
 Mon, 27 Apr 2026 05:48:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/63] target/arm: migrate PAC trap syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:20 +0100
Message-ID: <20260427124738.966578-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

syn_pactrap is fairly simple as the ISS is all RES0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 6105347598..fd8639d4f0 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -398,15 +398,32 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
     return res;
 }
 
+/*
+ * ISS encoding for a PAC Fail exceptions
+ */
+FIELD(PACFAIL_ISS, BnA, 0, 1) /* B key or A key */
+FIELD(PACFAIL_ISS, DnI, 1, 1) /* Data or Instruction */
+
 static inline uint32_t syn_pacfail(bool data, int keynumber)
 {
-    int error_code = (data << 1) | keynumber;
-    return (EC_PACFAIL << ARM_EL_EC_SHIFT) | ARM_EL_IL | error_code;
+    uint32_t res = syn_set_ec(0, EC_PACFAIL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, PACFAIL_ISS, DnI, data);
+    res = FIELD_DP32(res, PACFAIL_ISS, BnA, keynumber);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a trapped Pointer
+ * Authentication instruction is RES0
+ */
 static inline uint32_t syn_pactrap(void)
 {
-    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_PACTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_btitrap(int btype)
-- 
2.43.0


