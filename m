Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE45C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkh-0007Fs-Pb; Mon, 27 May 2024 17:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkf-0007Ed-JL
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkX-0003dI-S2
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8eaa14512so101098b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844760; x=1717449560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrqrwiUB30mLfDa3vSrOyifnLgQm0sJoOyLeI731Ly0=;
 b=lEBXS/iVyfqlFc9xjRlJlO9EHkZIEaExNya87QtDvhgZPDiFPFUqccS5LY7RNQvQPt
 +0/hkqVwwWzvrHrO0rwHXsH2iCLd71WcSfwVYBwRlk16xi1umcPv7nuYFIoWz6IDVnff
 x2JaUdxIqICdVa1m1LRulqBFEaQDwKzdMjtZ8B5qT5td/UEgmDfI3hSkL13H3jG8RXxR
 tQumV9qRKrfYJBbL9O/N6UBvfrF+73hyT7G7AWMyQTMPufl6RdeZYmhZqsuZZ40LJaOE
 VywWCgiLrlvT1pOmb5gXlACSWD9the6n3zuoOKZMXA0EnLkC6ExOOs0UYmspX1VdPMuz
 o4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844760; x=1717449560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrqrwiUB30mLfDa3vSrOyifnLgQm0sJoOyLeI731Ly0=;
 b=SQ3Cr2+ECzIYLlAvHAHihdEi4b0cLxN9Kn5SpodJsorE4oFAEtIYAnSgIv+JU1Tdfs
 hlDIjoY8GFlYwgh6aPSkjcl92b84Lj0IsKLvvKSkcQibjqoW9Kk/aNyn66VV7o18SuK3
 cdsX4eD2JfCefuBRXj46ITb62fKNGo365Lw3TuHi7WQFDi8PSQIeYofjA9kaMfTF5Ght
 RBgVa2HU0bIyPoeFzFitgYDGNm821fBoC3ahVojA9TSJ41SaP4QajTspUdtk5uhai7LU
 fs1XgOeyFeRvCA3u5xSsVDyW0fTczNLCBfs4MQ+nkIVrI0DhHP8LUUHUakZTMv6MFav+
 mkcQ==
X-Gm-Message-State: AOJu0Yz5JJLDbyUQrvE6DcUmGugUnC+H1wH98gMqTC76fo7YEuCWFNek
 Y8U3zvvTqXXPAYltOkJi5TRsly2p3PUbs/jsOEK/tnhPi+W/qR/1PPVyOTsnouUvsaKVM+mfJ0h
 j
X-Google-Smtp-Source: AGHT+IHtRFNoTbDFvun1+eDUuiaOCnmwbepv8f2wZ9W6X3gJ3nE9X+tq9Ob0hld8VFx01jZGz0bgHg==
X-Received: by 2002:a05:6a00:808c:b0:6ea:ca90:3459 with SMTP id
 d2e1a72fcca58-6f8f43c1d40mr10685175b3a.32.1716844760304; 
 Mon, 27 May 2024 14:19:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 07/18] tcg/loongarch64: Support LASX in tcg_out_dup_vec
Date: Mon, 27 May 2024 14:19:01 -0700
Message-Id: <20240527211912.14060-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b1d652355d..cc54bc4a53 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1674,12 +1674,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
-    static const LoongArchInsn repl_insn[4] = {
-        OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H, OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D
+    static const LoongArchInsn repl_insn[2][4] = {
+        { OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H,
+          OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D },
+        { OPC_XVREPLGR2VR_B, OPC_XVREPLGR2VR_H,
+          OPC_XVREPLGR2VR_W, OPC_XVREPLGR2VR_D },
     };
+    bool lasx = type == TCG_TYPE_V256;
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_out32(s, encode_vdj_insn(repl_insn[vece], rd, rs));
+    tcg_out32(s, encode_vdj_insn(repl_insn[lasx][vece], rd, rs));
     return true;
 }
 
-- 
2.34.1


