Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444DEC54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M7-0001Sf-Hr; Wed, 06 Mar 2024 22:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M6-0001S4-Cr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:38 -0500
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M4-0005hX-PP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:38 -0500
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7c8713acecfso18328139f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781815; x=1710386615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qK5soASicTv0ySk9Xejx0X64X5wdWSDVESyTR2YQY0=;
 b=ilAX8v1riW22Vh0JiK/9h2vhEBpcox+jGtz8so+DOnmRKslzLrMwjbTXmnaV4OwWzx
 PWD7vNxh0F28fU94v/xpqp/B4Xo27ky4wywPm3TLJzUFd3wVXzOB5dKFFYVQLGBAoYUn
 rA/foiEKxXtsoNpVBQZEIterxfZJh/H7TFIK2CgZRsbLUwntTt6U52fz+IhYnK8BFQ4B
 CXd9vECO2Q/QVr85emb552oMWIXtPYuXUam1QGecdrEQFeykyPysCYwJlvNbxhSm6qyP
 tsMVTRPjjNyYcGgMVIGLtNmkOibtDPCV951lcTpckkeDAMdLYBGWisriU3b5SNTxm27l
 lD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781815; x=1710386615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qK5soASicTv0ySk9Xejx0X64X5wdWSDVESyTR2YQY0=;
 b=YAsojyg0XHFgtRC3B0NXexeXlQdUbTdPuDTgahuakX4NsTe7wEbtcVxSrVY+koxyQa
 c3G/WjuRrKPUnydRvioBxmlM8Yeg154rfGXXboNJyJnc+rRDza/80fo7W7PZ8+ItOTxG
 nWookMNq2sw3IogJFt4pfTDzU91xZp7xkid62oDzZmgh4esoemOgKwQVbF+yQFs+Khk8
 CREfr6LQHxPeVEsjCEUDoq3H48OG9Syvgly1G3qRNGVoe30SyDEev5kJio3ykEJR0B65
 5XV8d0n3zVWIIkwlJ0hgrN0pFectaWVglKN7v/dembcKl7xMmsJ2nd21sR9H95kmierH
 ceyA==
X-Gm-Message-State: AOJu0YxQJxYpDXYi/viSSFWPGgy0IwtA5tC8p6qoWaliCAFpHgEhP/qw
 nCwpx6JgpGGw+g/VVhRvjsMF9Jtft9U8LVvhiibd/jAZ2Zrib+J6dJoO58jEOZk=
X-Google-Smtp-Source: AGHT+IHCYXhwlEnh9azO4p7RvPu/STaxqGsUQMHm9jMrqwaTiA13lbOsGIMuCt14SJAsRjiF+vMxlw==
X-Received: by 2002:a05:6e02:1d83:b0:365:b9c8:4436 with SMTP id
 h3-20020a056e021d8300b00365b9c84436mr20744030ila.10.1709781815208; 
 Wed, 06 Mar 2024 19:23:35 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:34 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 4/9] Hexagon (target/hexagon) Mark has_pred_dest in trans
 functions
Date: Wed,  6 Mar 2024 20:23:22 -0700
Message-Id: <20240307032327.4799-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd36.google.com
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

Check that the value matches opcode_wregs

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h             | 1 +
 target/hexagon/decode.c           | 3 +++
 target/hexagon/gen_trans_funcs.py | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index a770379958..24dcf7fe9f 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -41,6 +41,7 @@ struct Instruction {
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
     int32_t dest_idx;
+    bool has_pred_dest;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index a4d8500fea..84a3899556 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -366,6 +366,9 @@ static void decode_shuffle_for_execution(Packet *packet)
         for (flag = false, i = 0; i < last_insn + 1; i++) {
             int opcode = packet->insn[i].opcode;
 
+            g_assert(packet->insn[i].has_pred_dest ==
+                     (strstr(opcode_wregs[opcode], "Pd4") ||
+                      strstr(opcode_wregs[opcode], "Pe4")));
             if ((strstr(opcode_wregs[opcode], "Pd4") ||
                  strstr(opcode_wregs[opcode], "Pe4")) &&
                 GET_ATTRIB(opcode, A_STORE) == 0) {
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 1201172dda..9f86b4edbd 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -70,6 +70,7 @@ def mark_which_imm_extended(f, tag):
 ##         insn->regno[2] = args->Rt;
 ##         insn->new_read_idx = -1;
 ##         insn->dest_idx = 0;
+##         insn->has_pred_dest = false;
 ##         return true;
 ##     }
 ##
@@ -88,6 +89,7 @@ def gen_trans_funcs(f):
 
         new_read_idx = -1
         dest_idx = -1
+        has_pred_dest = "false"
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
             f.write(code_fmt(f"""\
@@ -98,6 +100,8 @@ def gen_trans_funcs(f):
             # dest_idx should be the first destination, so check for -1
             if reg.is_written() and dest_idx == -1:
                 dest_idx = regno
+            if reg_type == "P" and reg.is_written() and not reg.is_read():
+                has_pred_dest = "true"
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -121,6 +125,7 @@ def gen_trans_funcs(f):
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
+            insn->has_pred_dest = {has_pred_dest};
         """))
         f.write(textwrap.dedent(f"""\
                 return true;
-- 
2.34.1


