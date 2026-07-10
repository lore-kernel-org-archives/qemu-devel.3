Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC069C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qh-0001nA-J8; Thu, 09 Jul 2026 22:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QL-0001cP-Dl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QI-0008V3-LO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84864b41122so242384b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652225; x=1784257025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bGm16Ac/ND1idT2A8VfTVEu4e8kNxtj4BOaAI19EInA=;
 b=YixW6SptEFxjY4U9aPeVqurMhY5n66dR3vXLGhtVD1mVb7kzBKkttK1Q2kC5uDwNGx
 AxrZGYvhlnOp2SgTxt5ikEgxzi2dLm5ICdxK5tstYg5uR5YaoY11hvjNNY4jAvfbyBzx
 jS+dcNzNUN74hoNl4GEbvtLCRgYB9ekK/XS82zUs8rW7GVZIBQ5Mka9pd3pCg2WsOAr0
 Tid/YMMuctl+jjHSQDC4WZPoJK5r4iJCxRopA+MYZLyRondd54lEToGtjUNIcqVpO/HP
 NDaUF+/46RRRcF3fVxUggT+zd+c5CiD7OInIDGnCcZBxJ1pbAqxfxvjcIo0JYxXaHyoQ
 VdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652225; x=1784257025;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bGm16Ac/ND1idT2A8VfTVEu4e8kNxtj4BOaAI19EInA=;
 b=B/Purk90RAtR1jE425/MQgt1D+I7Cf+cjXQFgrp3LEblDdQvmRl4Cuzqax0F80ZIZh
 YfxYdLni1ka9GmpHKACRcUfzH/gF363FqNvkjH4N2IqoKQxuNPe67uATnQ5P6p2uXW9+
 IKxuX4TT8XJ3oeLc4shOn7rxJ9KBurwB6vZxaetA3N+DkpGNOVH1rDGbvQDUWPRygOfu
 0MiJ5W1UeNJ8iPhe18JobEUMum4P2dSNm1lRWYV4yQrOPIA/SuZlIfK6n3lZgqCHOVBu
 HEVmL4ztcnlAIRrl4/NyG92/0QL5adx5BEOrIpUD15w7KIVIHhHd2IeW+kOK8lTY3st3
 yHMw==
X-Gm-Message-State: AOJu0Yz+2n66JkVqHo9dRniaPk7LTMpcxPERhvV3UC96FOdft49pbDsm
 fotxWN5bw9Py7FY+DmOZqBSpcJrV/RSwO9xyHkVBvVRNNakJtmoxsEV3nbYLkQ==
X-Gm-Gg: AfdE7clXrjkM2cdCBzYNu/7EX34VzBdg19qc3pt4zYWPeHT+skFRFYERtqcK7t7fFsY
 dvvnEicHDbW7yiio5KWsZHBQEW+m6bgCdWhR/Vi7Nu019O4CMzpLvZbORTN7mDM46A42SwuGxaZ
 GBeOAEDRX66y1F85jge1mUPzx6uTTHLYtNwmc+9XVW9b4tdrtpg6ZZpuRyWt2ZXWOFR5oCdKEB8
 XyHkDTWFdmrvnsb0hbrELnA00vdLXiQ9WGq5VVwaQrg+Vosn/XELXN5eOmx+j6dRdyJcKdJQNY2
 EcAQoDgE3gb4/O1HWWPjU/V4P7o/qjYYQSELClXEZKn0LE6ZbSJo62+4xVQ7M7Okf1csvLyDIfS
 2Z56lLpg/7AJxwfGHYITe01vteLD1YshEbw4+nTFgkO6vV1KyzYlTwbJSXnNfqB23pOGXrtViBz
 jDO2pUmteqy+liWih3D9FlVpKhPvdp+zGuKHwDdsV4xw==
X-Received: by 2002:a05:6a00:12cc:b0:847:770f:da4c with SMTP id
 d2e1a72fcca58-84842ebd1d9mr8712630b3a.16.1783652224709; 
 Thu, 09 Jul 2026 19:57:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 27/40] target/riscv/tcg: remove unused riscv_cpu_get_geilen()
Date: Fri, 10 Jul 2026 12:55:12 +1000
Message-ID: <20260710025525.1704417-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

No one uses it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260703180538.3346781-22-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            | 1 -
 target/riscv/tcg/cpu_helper.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d6c5d6c1db..7618110412 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 7a1ea53ae7..6b39152ee2 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,15 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return 0;
-    }
-
-    return env->geilen;
-}
-
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
 {
     if (!riscv_has_ext(env, RVH)) {
-- 
2.54.0


