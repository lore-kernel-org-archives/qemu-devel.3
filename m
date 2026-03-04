Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED39EEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTo-0007pj-Qq; Wed, 04 Mar 2026 08:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT0-0007AI-B8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSy-0005Iu-SH
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:46 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824af5e5c81so6953449b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631643; x=1773236443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNeSTCxnl/4dEFi1O8PoZDAXMyY5R5y97EyDpIbW7Ns=;
 b=jeisMZ7rlOQmcTqNrpxQSoGodAP1Qmp60w2QXOCsTTPYUseJ9cJxNQX0ExekYG8k+E
 I0oQdkBpvBGygmwQpuezX7T/AdouHQ53Mmpie6/AfvKq/aZU7g79h+YJAcwGVU/HO56I
 UnH1Kiocki5vL6p39Wc8h8WC+JO3HdKoVAH5+lPUX94HmAuR2Ymo5bl2p0lnUwZ6GnNz
 nFAYrZU6ezxPE9hh+yg1UjcXTyro6AmgP3GpgSiFxHOwFYCH1nOl6nqBu+NPI6blpD6Q
 AosgCI1pn+dBiDSR9r9HlypPphMiMpnw9sENziJD6hY+/0OEyM8hI9dbM7t+4TIL4QIa
 u6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631643; x=1773236443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UNeSTCxnl/4dEFi1O8PoZDAXMyY5R5y97EyDpIbW7Ns=;
 b=AVW+dGYUH3YApNp8Xq1KpMiW5087amXcpf0newGYGSMlI6AmHOxT58/g7YpJfbdjMn
 dZr/7S2kbq2CZGOr0vHiElJEL6oIDV64RIy+GxAXxNuBngjxKyGcPIKsiaJckQY96jXV
 RYMlvUgiVMgHidUc5CFYWgE0OqUkJxxo3F7T3fjX7MrqAxOCnw14hG6Ho/P/FNtrQymF
 RJGfvnCBbplBlRKC2pFlFwS6lBgIjI2o6sDRnet7M4DN1yamftexof7zuMnLKuTUw6zw
 mhwFn5yI9XiwfyuIg86LXthxnRjP4vIh/v5loFT758nhKeYdYKV7AyOq4KJFC0VbUPrt
 z2+w==
X-Gm-Message-State: AOJu0YzglmYEu+wjHBrUVsiNC4k8GRc+dnHgqyiLfJ3Qjhu66dj+Kh30
 xJzZZFOgRg3544i/f6Z6FTTfFHeOcITF97XRfqMN/M9q4houp65fq4CB4YIpmzv1ed4CTsVNvkU
 5bsE351dvrjDESFpFKDeIvEiStsZc+y86KaNtj1LVuWlogONwTjTK8oE/3X1TaLux7r8cUAOACA
 lEUypio4R++19g8lQHb3B28fIaTVfCZgMWeUkUWq7+kA==
X-Gm-Gg: ATEYQzxaqPlP2RuoxjBkPsg0ZHp4sH7lx23ApDVihycmTvAmw0TtVAnO8pY1H1mGkp9
 0OInjeYGBh4Px/oyBDdvhZvCuGOM14aRuqdfy4GrUwsdm2DcuD5qyPlb5BNnNpd4bv6mMIPa8WT
 t9QjliY0X+owmCuH+YI328zxVw0i7M3m5i/ylv2DF2ksq4/K3S9JPViZNXlcs2gQh6A/gEXN1OI
 mk3NOoVY0iDaz2LiK5LX2DT2NY/lXkOOwIC7q1O9Rm7zQxM2/sECYnOh/PCzCYOC/HN6gIIUXL5
 y+x109yKO41sNbhwMabGdQGY/BjKbdm9AhYxk9hcrLw6QYS71eH9vS2TN6cJLRFgX5p99eV+n6x
 KmBCGdvcg2HsgVuecBvj8B0O7ifZucn0yGCb0nqLvuq10LtxjY6wX+EDlR4emdbuih7yYaUHTNj
 7RJ6Q1X7gOVq7QulN1E2z+4KNEF217phICsSfgmDBfDZgjEGaiFhtPcQWcl5jsm+uYOMLEX5vwt
 QO+Bs+rtL1X1jrcKwaFmVNFW/0=
X-Received: by 2002:a05:6a00:1ad0:b0:824:4a41:bff9 with SMTP id
 d2e1a72fcca58-82972ce95e1mr1827995b3a.51.1772631643420; 
 Wed, 04 Mar 2026 05:40:43 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:42 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 09/14] disas/riscv: Add support of Zvfofp8min extension
Date: Wed,  4 Mar 2026 21:40:01 +0800
Message-ID: <20260304134006.2908449-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

This patch adds support to disassemble Zvfofp8min instructions.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index 6f2667482d..30f585772a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -984,6 +984,9 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_vfncvtbf16_sat_f_f_w = 956,
+    rv_op_vfncvt_f_f_q = 957,
+    rv_op_vfncvt_sat_f_f_q = 958,
 } rv_op;
 
 /* register names */
@@ -2254,6 +2257,9 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3630,7 +3636,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 21: op = rv_op_vfncvt_rod_f_f_w; break;
                     case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
                     case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
+                    case 25: op = rv_op_vfncvt_f_f_q; break;
+                    case 27: op = rv_op_vfncvt_sat_f_f_q; break;
                     case 29: op = rv_op_vfncvtbf16_f_f_w; break;
+                    case 31: op = rv_op_vfncvtbf16_sat_f_f_w; break;
                     }
                     break;
                 case 19:
-- 
2.52.0


