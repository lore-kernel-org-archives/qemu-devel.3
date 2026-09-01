Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AC5C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONN-00018p-Dd; Tue, 01 Sep 2026 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONL-00017i-Aa
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONJ-0007Dp-HE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:07 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so986652a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268683; x=1788873483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H88xTirtnPHyU63a2JcqL06O/ZlckMHEOU9Rdvl6mmo=;
 b=iOq7mgtsUXLrlXlZQJoAJy5BomiJhDjrGG8KlVeSiVEkAh7sgIhsWrtt16T32NhM+Q
 5sK2oKVbiFIyiwPA1ZrhlzRY4knO6W7T+wNfjzpPftdrj/IN8ZuiG+x8mTcsvlbVK3v/
 KnA6x1/tlB8OQmJG+O8rYH/s/3zyiUK7ugrfmflCavXQ9nToBIscayFhauX3Cj+5rPiF
 FEbZZ+xW6ZiK2mQyB8e6Mv4XBCdrRnrM4a/kxPjAqyu8cDy7+wvkEOUXo8MIX9g6Ok0k
 gYP6hAznh0XhPKCx8svhzPopo9Y0WRFzVp3uEizGjWcWe+5NFDyDxK7hlT3i3/PEigmU
 MWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268683; x=1788873483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H88xTirtnPHyU63a2JcqL06O/ZlckMHEOU9Rdvl6mmo=;
 b=GIkHXoHUbXTlnuAGOaK9G9gby2L3aKTHP1NfNATYGcFhFOq6IguHFSywuq0MUtZpM5
 XfCQ8gFdxUPlrZTxCR0nPvyfhWeR8TfPh+BSvKgEy/PqR2to7Dtk1G23TU1+ZkAzr7YJ
 VCrOCJg29RghMet5iGdwt9vMCGlKHODE6prUPZHuKwTOlZjsXc7HKNJ11yt43R7VPuC6
 TdEaIA/G6ShXTYjrP4BBabm7lFgxRdm8vCCfWKIDlwIxvnspmyid8mDnNsOCAxm66w7P
 Y0rvOkvBkFy+Bv1072VQjnRvDO0lVT6VZNblpOQs1zJmcok9oCjW0AxRh+RtO9m8tEm9
 6UNg==
X-Gm-Message-State: AFuF++lrIi5UWHOdhi7COS641En2nXdhIv+qov0JrmyNixi4g8iA4W4T
 PAH8tSi6wP2VX9K8bWfFX5DYfW9Sz+3cW70h2I4U9tKJb7CgmivA+luBgNGFl8SD464JBf3R2Jw
 G3OEJAVU=
X-Gm-Gg: AR+sD12dfHxo+m9k4tWxQFUpXkre5ic/ftyvnDKkikvHl0Sx4NkjHsVF95KcqwtbESa
 w7ALmD4BthOyTA8otWqR/AGU+exhggJyjozyIzDlr92xZfiVWPf0B/XK4Fzaq1cZEDBVpKNKMO9
 xb5tpAvqYAZi6k0xyWWiPn0q2mmVKKeL+fGEML+u5NW8zh2mU60Y8hpmzilfDQP040bswNlMrTH
 nWWcyHKDvsBUPmqGyBp/ZdkQzM0a03pv9dkVB1Re03H9YLk8IsCgTnKBzyzY/TYid+jhL6U3P44
 z3c47wxs3FpskbhbwbNlku1V8rwOENVlI9zAnslJrKlu1tf7rVU9fzqGwpm4GRO3GMFCmrUSj+d
 W7holSrnsJGNfnfcpBgbYBTQSla2M0QN9zvrfERQtzgpJVk8dYvEY0fflVJyvdokl2F9kQtabt7
 z8UbmaWeVCpfRSCi9U25g27XlkGTMYZXRA1acQVXEhbuIpgVSKEN/JmIT0fYq8Lu6zxBjC/RhYn
 v9m2JR6wjJNn1bFXaioO7RwZcee3GwrH3l84cqshVTz4iqBE/kp8gGV3bv8KSs7E814FQ==
X-Received: by 2002:a17:907:c81a:b0:c25:31b4:5f15 with SMTP id
 a640c23a62f3a-c2556babb2amr2093724566b.1.1788268683483; 
 Tue, 01 Sep 2026 06:18:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/58] target/arm: Add FGWTE3_EL3 bit definitions
Date: Tue,  1 Sep 2026 14:17:03 +0100
Message-ID: <20260901131732.2263947-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 34592679e49..2c9927b1d95 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -689,6 +689,30 @@ FIELD(HDFGWTR_EL2, NBRBCTL, 60, 1)
 FIELD(HDFGWTR_EL2, NBRBDATA, 61, 1)
 FIELD(HDFGWTR_EL2, NPMSNEVFR_EL1, 62, 1)
 
+FIELD(FGWTE3_EL3, ACTLR_EL3, 0, 1)
+FIELD(FGWTE3_EL3, AFSR0_EL3, 1, 1)
+FIELD(FGWTE3_EL3, AFSR1_EL3, 2, 1)
+FIELD(FGWTE3_EL3, AMAIR_EL3, 3, 1)
+FIELD(FGWTE3_EL3, AMAIR2_EL3, 4, 1)
+FIELD(FGWTE3_EL3, GCSCR_EL3, 5, 1)
+FIELD(FGWTE3_EL3, GCSPR_EL3, 6, 1)
+FIELD(FGWTE3_EL3, GPCCR_EL3, 7, 1)
+FIELD(FGWTE3_EL3, GPTBR_EL3, 8, 1)
+FIELD(FGWTE3_EL3, MAIR_EL3, 9, 1)
+FIELD(FGWTE3_EL3, MAIR2_EL3, 10, 1)
+FIELD(FGWTE3_EL3, MDCR_EL3, 11, 1)
+FIELD(FGWTE3_EL3, MECID_RL_A_EL3, 12, 1)
+FIELD(FGWTE3_EL3, MPAM3_EL3, 13, 1)
+FIELD(FGWTE3_EL3, PIR_EL3, 14, 1)
+FIELD(FGWTE3_EL3, SCTLR_EL3, 15, 1)
+FIELD(FGWTE3_EL3, SCTLR2_EL3, 16, 1)
+FIELD(FGWTE3_EL3, SPMROOTCR_EL3, 17, 1)
+FIELD(FGWTE3_EL3, TCR_EL3, 18, 1)
+FIELD(FGWTE3_EL3, TPIDR_EL3, 19, 1)
+FIELD(FGWTE3_EL3, TTBR0_EL3, 20, 1)
+FIELD(FGWTE3_EL3, VBAR_EL3, 21, 1)
+FIELD(FGWTE3_EL3, GPCBW_EL3, 22, 1)
+
 FIELD(FGT, NXS, 13, 1) /* Honour HCR_EL2.FGTnXS to suppress FGT */
 /* Which fine-grained trap bit register to check, if any */
 FIELD(FGT, TYPE, 10, 3)
-- 
2.43.0


