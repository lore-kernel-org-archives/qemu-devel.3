Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4FFC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7X-0000fe-C7; Sun, 09 Aug 2026 18:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7U-0000e0-LX
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7S-0007GN-Kn
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:35:52 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so872000a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314949; x=1786919749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+47W1dMYD4zx8+XNZWBhMOb1gbJPKHgkxxVD63BRs5o=;
 b=fkALENKKNGDgvym3w6UxOleaazz3KgwAykMI8oWQyN0H/XdMV+eE3NXKb/6N2Djtt+
 vvNguf+qd7He9Pc1JVnMF4j/CjsE0IETOJA9zbDI+M21Pcxytz1mAHBskobj/+aK1z/g
 WkcpmVicE/EVeXujKPtTKFD9eoXzUyy27F7M0ukqnAqt5aq/o3JbP8imdcO87e7heUnO
 +w7YyWh2VyF8YFZtajaafeZDpiCCsBC43CX4iijyyZeNZnUTORBrHwje33kDAWzPvT/l
 9InMTytAj2E3+3t69EqnJ3t9IIWq9XMFAdGMw2O6TinICSthrgK6GwgOh9K7nfbtpkMT
 ctYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314949; x=1786919749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+47W1dMYD4zx8+XNZWBhMOb1gbJPKHgkxxVD63BRs5o=;
 b=WYojP2iJlNE+Q+ruWkHpEMzGpayV2b7+G7PnDu8YFA9CcVJT379zUJrTsechFJ32g8
 +iqZmU5O4HIzMIFWrLcxobj5vPmGdK9f2EXCj2B3GmNWVuLN3Ys0CNdRq2cWG9W9oQNe
 9DcSRg/2wl7ttNW7jJ6g4sDdjJYuRNGhVR9prs6qid/E2DfcMB5vSQq/6sAghI+P0CsM
 BYtW5WktJTV0+iaJS8SUKwfyrK04J8Hp3Slxg+hQjbpWACb20hk8xHqbgLpD5W0Qy1PU
 bNMkIphVI5VknviAmKXuDPd9O2mNeUEU45Q/FvIeHsgb2yoZkHcTRL2f3J0ihjcAgzcI
 Tidw==
X-Gm-Message-State: AOJu0YwuufQ82k1AVXfRGZK3wNJ5fkw44ndAE9/SOld5WGiXZ+fz5toh
 fJ1kZ6ra0DWvyFsA3BjzVYqMWdpOfZJEhwIYSDT7qIsLvL4jH5jdfNnRrhTs+981Ge/ZdHzwQRQ
 EaL8Y
X-Gm-Gg: AR+sD12TVbD4Qm0xkPXp8WlMROfACLQzxS4kb8Nzr54zx3qeVrMCrYwD/ahUTwb1fhb
 iJ+Y1X++fWxHA9yU/ee89oL8Zk/9fk5ETZUygZGrTRBXEbZlyQyD4G48paY+9iK1LYtgNfr5hrv
 5pKIV7klXvEkxSwlp8bDsy+MQr4YNIZN5TFyi1WfuUrHbBWYm4WKBkHxoe7kYbaYFghTVRu4Ajz
 EDNBnhc6k2AuowoMibHr2yzlcK0DLMRIWij0TJaRV4yrs+ScJeyqcxiU4CNdLMJG7aTdNsvZtfm
 NaAgUcWzOXYKgoWWvS4iobuBteVdVhkHLs9KVd5d+/gpCUCk9I/Dw/hBFgycwBotsJD9paHvglY
 fwu0d+fDEgbHxQPzXreaqXfUR9UN6lBS7ILhbmV9EelzrHoV0Qew8EI5rNxdo/8iXqygLIFWS6C
 gfPFY+CGwM/XYyAd3+5qndGaRjRpJR52bmk9MrkV2QHN2jCbIWRbCICZCYtzD0wyYBuQeiB+CgB
 nZRiPi7vUR2BPr4O6jI
X-Received: by 2002:a05:6a20:3d1a:b0:3c3:719d:dfe2 with SMTP id
 adf61e73a8af0-3cb85f4e179mr42084703637.36.1786314949015; 
 Sun, 09 Aug 2026 15:35:49 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:35:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 02/56] disas/riscv: Fix 6-bit immediate extraction
Date: Sun,  9 Aug 2026 15:34:51 -0700
Message-ID: <20260809223545.730664-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
immediate field is encoded in bits 25:20. The old expression
left-shifted by 38 and then right-shifted by 60, so it kept only
bits 25:22.

Use extract32() to decode bits 25:20 directly. This fixes the
immediate printed for th.srri and th.tst.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-Id: <20260703-b4-disas-xthead-fix-riscv-next-v4-2-84c566330bc7@linux.alibaba.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..fdf75a12ef 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
 
 static uint32_t operand_imm6(rv_inst inst)
 {
-    return (inst << 38) >> 60;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t operand_imm2(rv_inst inst)
-- 
2.43.0


