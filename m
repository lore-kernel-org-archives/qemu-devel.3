Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1863C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7h-0000m1-A6; Sun, 09 Aug 2026 18:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7c-0000iM-Ke
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7b-0007Ip-3V
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:00 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1042519a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314958; x=1786919758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VukrFpkUNm4nthzSgzNlJ3ujYBfx48VnCBP4yqJMbWs=;
 b=LHvLMeq4ueUnTrcT4yo8HwxC8HkLHUT9VHeAl0WjTQruUFfKEaG+alZHccCxUZqBrQ
 mM0nyF0cUC+cBouio7n8VLbZB+w2kPB4b8zl/BDYPobhfLRPdeJLotwycse257rPheg4
 Esp6cT/om37efUz+AZBJeNIHSeT3Vdz8xvAUDqC7hvHZd9ZGBJ0cEbsnvkT6mkXAA2wA
 bNsHdLkxtG/rEQZgbpxFrl4jt25XqKypQTuOtImDUHVWTjaoeyypmJnHL0TIH/2PuSCZ
 liqn3jpZQlTE9rwlKrlED8Ag1ECSVoq+joD86FkbDEGOvt52xkLv89/lU6tXaVgUBoZW
 cKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314958; x=1786919758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VukrFpkUNm4nthzSgzNlJ3ujYBfx48VnCBP4yqJMbWs=;
 b=AQFl5RmbdvAX+v5h0/jsy1jX6NLEoSHPbD9w2cRKOoCOlGIQjKNwzxji9XqMUrCtK+
 QJTPGXFhdby7m20+DxSsvVA3dDQr9k1gVmZoTxiBCfo/8tBs5kq6229j56TV7ZkWtM0c
 9xgfvJmrLQ6cOlYhSXMLHhlYWlEG21DTplRUgKvJroLYkwX+LykDspcgRrYTNtZbwvjS
 Q+sqMbI9ytf7Zzf2DHKA55++5i+8T4Cv3E/fgAC3cf3llEqWD2/ORVOuJC6itrFNzPHw
 Jnc29EkEhkriQ7yI0E8D4ajpINrkUGi3loL9WNMSIzWz8HfDUE/MzN/2c26j2GLbb9Eg
 N5zA==
X-Gm-Message-State: AOJu0YyeNH3/nw4B7GSxGO7YWac48tbLzb0Mhub4UZpeqOfjNs+/o67o
 MI5RLqZtdqttZyA5UJtOBYJ9B5AvK3CGCW2BBlVgaiUYRe682nh2JSPMlApwsXGBTo7Cp1Us6/G
 IItqu
X-Gm-Gg: AR+sD10IV4zKWJdZ/JPeij6/L2CmTs2tBfLYK9Vzymni2PiB7T1EQnMly8BIspfLSOd
 5U5YDOjripThHcSASPig+4e0J14qxE62CdCbGeCA0hPXCBJZhMgfyUMTitBkE1L17KwTMUC+XYm
 PwFqHbibqgWh6YVQDWUctaf8U0KkcYIaC6DAwRsOAVYmLNdgR7o57Q8spUUYu9qOCrUtFGAw0Kk
 82oTDhfjjnzy+TctivZ2z6sl4ORa5tZ/TCL+SNjLP3iL1121zOehwn91HSd7+R3gclbO4Axollf
 +J+bCPd1ibr4G9o9crdJY5l8QuUa8eARTLrdA0fRD7LUykXxLSO8hqnH/eB9SxEVWnMv2c07KD6
 Q8zSLkybLJVM0AeDWaNp1pojUS2guxI3MShJuJ8xG5ziExzKIhS22UlpNgbIfvgBrn8IigUOPAw
 VJPnW15Oe0bNyLyrygmpgFqoDCZ7T/aCWuM+Vg5l74RAnZ7kMj+5j8Rn45uHbEtS4dQ5Ohkt3mM
 iUKPcXLev0Grz0k6CL1
X-Received: by 2002:a05:6a00:4652:b0:848:51b3:f3c2 with SMTP id
 d2e1a72fcca58-84f2e0dd0a0mr39726423b3a.33.1786314957563; 
 Sun, 09 Aug 2026 15:35:57 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 08/56] disas/riscv: Tidy dec initialization in disasm_inst
Date: Sun,  9 Aug 2026 15:34:57 -0700
Message-ID: <20260809223545.730664-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 012f90fce6..986dc6b752 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5441,10 +5441,11 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
                             const RISCVCPUConfig *cfg)
 {
-    rv_decode dec = { 0 };
-    dec.pc = pc;
-    dec.inst = inst;
-    dec.cfg = cfg;
+    rv_decode dec = {
+        .pc = pc,
+        .inst = inst,
+        .cfg = cfg,
+    };
 
     static const struct {
         bool (*guard_func)(const RISCVCPUConfig *);
-- 
2.43.0


