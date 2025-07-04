Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E274C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOl-0008TQ-Rl; Fri, 04 Jul 2025 07:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN1-0004qZ-Sw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMz-0004MI-Rx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234b440afa7so9365725ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627656; x=1752232456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTSow9pTiEtZE4+cEk1d0BTAuVgvunpVUSHTyJlNheo=;
 b=dV71zFS/9f42Zix4c0Lbpi4DXZfZWHJ+s+SLVWFMGl3E5eaZSXjO6Z1hASo/gYu7O7
 34fmfhkcUPGIkdCwFAhMnKY2xct8fBWwuDONc2vonGm+WUYMsYlNQhjyrqOYPzkRJBTj
 u2lCydupLn65MojS4J9bnKSl4wVw6QuwfcUs0chz2aCeHnP2Ep2IDCgkH7K/xVzExIqM
 8POHOpItn+cNCvgI/u8T+ENJ9qBNn58L+eBDew67G2SWjZkwRqhR/0uskGwo6c8KXWiO
 9AyH2cxKPs81hp6VGsQtuXMdWeyK6M5YHiJT/PD/XOd7GrsbS6O864GeVyBbr+PmNvZp
 4mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627656; x=1752232456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTSow9pTiEtZE4+cEk1d0BTAuVgvunpVUSHTyJlNheo=;
 b=s7v6QJBGWSpKnXIAho+ugwmAGbgdbiRtXJBtzmFKrlneyCDnCzW53FA1TaMXML1eQs
 jx2BZ+5p1x0x4St5ZT2fzT0A60u813aAG/+TMJJ9SDt8U0cv8xQcXD5USviTKtgN3WNb
 WVPWdwWCiDpoYZRsuoklu9+qQaXw2amUt9V+NNp7p+IYK5p/RPJOu+fPm+XdpCh6HaPl
 rLlYDO+oVaNFdEm1BLSFc3DkRJjhu+JA9gMHed8oTkdWkcjUWvMyfMqJJiJREM/qQd+1
 ijpnlF8uGEIu3+8dSLwxFgM34p/pbiPVY1xSY3Y+hpfu8U5W6sIyekk/3LmFOgGvZazI
 vxxA==
X-Gm-Message-State: AOJu0YxzF5F64aYERaGfTN0vsSdkwCQzxga1+dN1HG9Uq2/Nw1DuCi39
 lVAa7n8/EwmQ9dzE6VMIRsiRXgZ8rucBM/suc2u4RcXNOAfwJNlsaCERFP3UuQ==
X-Gm-Gg: ASbGncvX5hGKJTmAwuKvRirWnD9Go8ltpur4+mrxRZHi16O38Ybeas6lpGuxp1u1FCM
 9+JUC3/toxsqFNEs4b7r+PZWkvahEB1Kbvwwgi4YxXu7thiuBJbO0A5qSJUAwroFVjCnynSXCJz
 6sv9vt9NW80BpHphtFODxLip4PPmGuNFwc68GGQ8vGSzlEbQyPmO9ePoMlRJaUIQdqldVPBgSyE
 WZLJVxpcln+fPPYGbH7zuZec1gAga3G6o/+Vj54avtJhD6vxicrtSw3xFSyC7UdnFo+d2UIWfUS
 SfpAqRS1kpPlsDfZHTIAGSRVJOnfIdu451vU3NT9h0psh4Wh7qs/xKa9uDcJ9Zf7yYSa6CEkQwn
 BPvrHzB031+/tXOsYH7cr7lSoPr2rf5h/r0fygyg4aMvpwSssdzW8ae4mlSBbUuRhIvM=
X-Google-Smtp-Source: AGHT+IG6mZiW19ayDX48ICOlRBrwJCvcG8KIxMcw3Fj7caXky9WdXzLYi5+ot84kmTmvn5zUjDv+rQ==
X-Received: by 2002:a17:902:f78a:b0:234:c549:da14 with SMTP id
 d9443c01a7336-23c860d39fbmr42556645ad.29.1751627656326; 
 Fri, 04 Jul 2025 04:14:16 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/40] target/riscv: rvv: Fix missing exit TB flow for
 ldff_trans
Date: Fri,  4 Jul 2025 21:12:02 +1000
Message-ID: <20250704111207.591994-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the V spec, the vector fault-only-first load instructions
may change the VL CSR.
So the ldff_trans TCG translation function should generate the
lookup_and_goto_ptr flow as the vsetvl/vsetvli translation function to
make sure the vl_eq_vlmax TB flag is correct.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250627133013.443997-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2b6077ac06..4cd030c7eb 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1361,6 +1361,12 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     finalize_rvv_inst(s);
+
+    /* vector unit-stride fault-only-first load may modify vl CSR */
+    gen_update_pc(s, s->cur_insn_len);
+    lookup_and_goto_ptr(s);
+    s->base.is_jmp = DISAS_NORETURN;
+
     return true;
 }
 
-- 
2.50.0


