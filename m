Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4761C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPr-0001cL-7X; Mon, 26 Feb 2024 15:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPp-0001bb-T0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:33 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPo-0007zh-6T
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:33 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bb9b28acb4so2482055b6e.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978650; x=1709583450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKDpTWyScsaSBI11X+2N+qTatk0v8tuwGtm68rKYDSc=;
 b=fDJfjxdsXXog2SQOST/zChPImlnccMqkCvbsgoADahMjLbI5IK8IUEouIAKSu2gZkU
 8A/M4J2vc2b5Z0IVbDl9Na4R3UnD57a1Dya85lfspHsu8bgcRtumyBPzJ041FveCvY/l
 GSYH1RFYR01CREK9H+QMiqE07KhLdSgLItLV6ZfbQWhNuIp3SMxXrfFakWlmBYz1VwVY
 Q14rxF2nOsiv81c+1vbx3qJ/51DoPocMCtc56YPFi31rQlxHwz88vvznPAVzzmBFragZ
 CTQ9RJYYMh1JtQj4aY039qQdIn1m3x/xbtEKQkj/bwQdaWIpRjyX6K0iuA1HDyGTWZVr
 XELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978650; x=1709583450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKDpTWyScsaSBI11X+2N+qTatk0v8tuwGtm68rKYDSc=;
 b=qqPazthVnoePMORDXQpIBXs2jbnaCUuG7xQMxrizihqD1ONAd7sB7JCEAO5fq8Asao
 NxWpK9mN8yBRMjWlD9c4tGg4yRAaAvKR8cECqV9ACf52n0vdpAtXPGs0wRn0+z7N/Yco
 OKdzJX3a4zptyQJzCtBB1pU6W17eLwlF3CvwCvzCQq7RD4zcQ6rTYGqzMgnv5mblUqMm
 q+GrhR293pQSMHJb9uZ/i5PJwus6L+sijN1/x14s/DEFn4xW5bN5CK60/5txJB/o/2Jp
 zilZcpzhzma6n3wvDUO4hLRxF2oYJA4EKAgj0Zmxjuc8aK6dzZX6EgvFhXY64xC7uJ5U
 MpxA==
X-Gm-Message-State: AOJu0YwtDZ3O9PliGnFKyswPNrpTdjaLzThePxRM2AsK4CHFS/FQKblL
 rYQheLtdVCtnceeg1+8ZMKWoiPHQEsaHTsEJruSGZ/cSrLHi8lJQGZ3WxxyezSM=
X-Google-Smtp-Source: AGHT+IEVH0ezXJDe2WjAD+U30CNhVeDx+5TgV1dWJQd9Q0jS57IeWHDd107TwZPYXhyCQ6kAoTrjsw==
X-Received: by 2002:a05:6808:1286:b0:3c0:3e27:b122 with SMTP id
 a6-20020a056808128600b003c03e27b122mr184923oiw.39.1708978650061; 
 Mon, 26 Feb 2024 12:17:30 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:29 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 3/9] Hexagon (target/hexagon) Mark dest_idx in trans functions
Date: Mon, 26 Feb 2024 13:17:16 -0700
Message-Id: <20240226201722.391879-4-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Check that the value matches opcode_reginfo/opcode_wregs

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h                   | 1 +
 target/hexagon/decode.c                 | 2 ++
 target/hexagon/mmvec/decode_ext_mmvec.c | 2 ++
 target/hexagon/gen_trans_funcs.py       | 4 ++++
 4 files changed, 9 insertions(+)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 36502bf056..a770379958 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -40,6 +40,7 @@ struct Instruction {
     uint32_t which_extended:1;    /* If has an extender, which immediate */
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
+    int32_t dest_idx;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 4595e30384..a4d8500fea 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -184,6 +184,8 @@ decode_fill_newvalue_regno(Packet *packet)
 
             /* Now patch up the consumer with the register number */
             dst_idx = dststr - opcode_reginfo[def_opcode];
+            g_assert(packet->insn[def_idx].dest_idx != -1 &&
+                     packet->insn[def_idx].dest_idx == dst_idx);
             packet->insn[i].regno[use_regidx] =
                 packet->insn[def_idx].regno[dst_idx];
             /*
diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index e9007f5d71..c1320406df 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
@@ -86,6 +86,8 @@ check_new_value(Packet *pkt)
                     /* still not there, we have a bad packet */
                     g_assert_not_reached();
                 }
+                g_assert(pkt->insn[def_idx].dest_idx != -1 &&
+                         pkt->insn[def_idx].dest_idx == dststr - reginfo);
                 int def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
                 /* Now patch up the consumer with the register number */
                 pkt->insn[i].regno[use_regidx] = def_regnum ^ def_oreg;
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 79475b2946..07292e0170 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -85,6 +85,7 @@ def gen_trans_funcs(f):
         """))
 
         new_read_idx = -1
+        dest_idx = -1
         for regno, regstruct in enumerate(regs):
             reg_type, reg_id, _, _ = regstruct
             reg = hex_common.get_register(tag, reg_type, reg_id)
@@ -93,6 +94,8 @@ def gen_trans_funcs(f):
             """))
             if reg.is_read() and reg.is_new():
                 new_read_idx = regno
+            if reg.is_written() and dest_idx == -1:
+                dest_idx = regno
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -115,6 +118,7 @@ def gen_trans_funcs(f):
 
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
+            insn->dest_idx = {dest_idx};
         """))
         f.write(textwrap.dedent(f"""\
                 return true;
-- 
2.34.1


