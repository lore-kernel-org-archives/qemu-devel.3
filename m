Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBFCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQI-0007S7-Md; Thu, 15 Oct 2026 21:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNm-0002HE-7n
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNk-0004er-DJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:05:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e934449bb0so20569855ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112711; x=1792717511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZGgEFWFAbkubMX1vcL/XCPcKrA4dkwEh07nh0CExxo=;
 b=Nu2hSsYUZ6ndGfjmR4iHrtrdGr80ZcKGCn8NkwNP4EbBEOGuzFaX9rRDPHEpNtJdf3
 PZ7Nmo1hnVON/S0m/0ztos9t7bI8/727IzxLmnVUVgFGpnsk+CpZFlNfoW7UbDEsRRyR
 ZdYQb7Fj0vLqS+hch0sIEL0QQfiIajuWsyy3CES8iN7D8iCF/JCRAGDaKognUj85JX3m
 wSEmSVa7FdJHcnPdAtESJNHh0GmF9bk7pe1Kl6DKxJwG69CS0T/zOT3+G2PZ4Dly5Yuq
 3iu2oR87SGEW6Cs726mhIX3aXfo/5XuPxEBfvaagtXOLHXk8bMmyWO/wA+RztYbeej96
 sKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112711; x=1792717511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZGgEFWFAbkubMX1vcL/XCPcKrA4dkwEh07nh0CExxo=;
 b=CartEKo53P5J9QCvLczgEeFJjq/f+abQ9jdNWcqv8DExVrjwGHYlBAi7WKV9YQ2U+O
 k8VpGiilaQIznieNEPzvBkgzc5KGpy/9UM1qcTXuzEu5p4Ng8IG+kizOWcYqUhfSSHrR
 mkZKjf1pI3M7tkQUZCAAIETR0nZNdL30LCIJLr2/BSxwBPZILAfJlZSx31vZ3V5s0iGZ
 tqZJrWNwMIAs04iguIyesNlZsYX9KoHGlTlYydkZOJwfqqdc8rqOZVLgQQZ0ljTwN8rh
 sL4h72dUZNMiG0TGOmS5Iu7fK7q8S8tZsdGbl+7YMaUGfkbj69klRWGZZo+8EpKQ9+KR
 ks6A==
X-Gm-Message-State: AFq9FYI89W8TtWLsvQ1e0f89tdwnX9G1B/KOLS93jQtAxYNTOMBVp7bQ
 jwh4abwm8oOp6VT1qAcE+SppUrhxVJw5fu7B9CrulZHCxbk/BLMJLUOKXUBFQg==
X-Gm-Gg: AYBFou0y2JRCCvjpKPDl6tC2VYQjW9cIHHMdoc+z3pxzUFnUax4gmdKFsoEH5Pd6kvo
 /ZLuVJLSA/Q740Qje0Lhq7wny77uAjpJ103ptH4FiY4PJVds32sLc+MqJDBaYpnCg4Bpn6EatsC
 3yeSpaRiR54UUCynSbXagIDKF+FGoMYifcbum4aKW4uuninQlcHXgxjpJHKcNlyWc+7wDo9HVEW
 JmtKukA9bE5dj95xlVDnzMyJwQ+8YigQv2izrKVlKKQ4n7zn32l/gWxl2B7Vr/8IFc8ES15AYnW
 8PDG86FarHvsZmVpCu1ugmRxfGmDKhFKuXeOfOQUjkiyPadDbFq9bK6sQNO9QGliVvWbZgd2Xol
 B8IiUOqfuCrkIOkvmu9rRK+59OkTezAqZMZpnylG5XIZO263NMmfIdW+5MpaWA5NwvoKjNMfxMg
 G+6h64uy5cDJMnFzfwV++LaLBuJ8dlWmmXscvBkhlqk1WWc1fC66pzG6cCZq1KbvXtHwKIX4Etq
 0OFEQ6n//XJMqUA
X-Received: by 2002:a17:902:d4c9:b0:2e8:18ca:5f30 with SMTP id
 d9443c01a7336-2e842f30fbdmr170611325ad.48.1792112710986; 
 Thu, 15 Oct 2026 18:05:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:05:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 49/50] target/riscv: write back fsgnjn.h and fsgnjx.h results
Date: Fri, 16 Oct 2026 11:02:36 +1000
Message-ID: <20261016010237.1102834-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_HEX=0.1 autolearn=no autolearn_force=no
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

Under Zfinx/Zhinx, trans_fsgnjn_h() and trans_fsgnjx_h() compute their
results into a temporary but return without calling gen_set_fpr_hs().
The instructions consequently retire without updating the corresponding
integer register. Add the missing writeback calls, matching
trans_fsgnj_h().

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4407
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <ebb7f8a1c374783dd585ee838e1d30f4d2bfbccc.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
index b17ef9541c..4af717ce54 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
@@ -319,6 +319,7 @@ static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
+    gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
 }
@@ -363,6 +364,7 @@ static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
+    gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
 }
-- 
2.55.0


