Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E74CC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCv-0007jm-Df; Tue, 18 Aug 2026 13:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCu-0007im-64
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCs-0004sD-My
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so82812b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072553; x=1787677353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6IAPatcjPdJ/99HpKAboVrpyprZdgYaQqpnnlke8PKI=;
 b=kXTJzrueGFJRP2mLHn75NjyBMag1vlL4HF22fqsN2osaJQOT+LcxXgRSZNWRtsjgKQ
 kbPCcw7rD1knoCLDQfJojArsKzHU0Njqr7HBK9LRjP1MdxsEqN0zD8Zikh354ssFXpWs
 RP/o3Qs5+GjVaw0wmoyFJPJkPKtamV+mX53fJMU7uczLIQ++JmQXgrND+QnQOBMhxPcp
 M9mx4oHBEyinuoKonfnbYSd2vXGoHzDzr3n8Afcj5y4GDCvSp9NZGjzwhN3lwMebJso1
 s/B57Njlo4FI5Tbtw+3y/JQWbTghG+nhhXTjlr6NVJIe1PWseCjeRvC7dQiqkXIZtGei
 CEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072553; x=1787677353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6IAPatcjPdJ/99HpKAboVrpyprZdgYaQqpnnlke8PKI=;
 b=TxS1qDr5wh/7fXiJ+QUaMSyOMKMXNtd5seK/2PvJNfkC/MwyCYPElJyiU+b4EnoMoX
 uh9vMkLU50lEfrlvSl5mM9Df5wgVBAtWIkLaBnHxzeho12HvnOhi/WknlyWTAswYSSu5
 TnrkC7Q2+BRNkVt/nBnk2DBSMVKydRdS82sT19ISjExccB3+1Y8y2ikpo8g0DxAFKKdA
 Gtw3fLoKr3kif+HqIogadgam1aXvTRbtZYmoxrVqsd1CFlk9juH6E3iDFkRR0F0QT07E
 p2LwbZlc8HUflIDW+LY31fHlzh1WasGkjBANYet2EMYlvFvXrJUV42+TKhVn/2sjJO9t
 qkxA==
X-Gm-Message-State: AOJu0YxWyDHtxwzeHfUy/a4FueEpl6h+oGv0r12DHzolfgKPNQmeGzlg
 u9kzi/8QFhBHQ+ppgeJcIzCVCZQ0u5uYF0Jm0uoxpZJ7VrEerhKQfcrE3X7hVv7Nm5dhmpL0dZE
 Wwpvo0vU=
X-Gm-Gg: AR+sD13MZTXBXV2OX2olp2LyO+Zn0B3mZmkZZcJHHLFBQkc1sdVDBrhnnGScmigUKGo
 /NgNvGgmrIuJ5PbKpdMoBoArh7Qa/QjMHBF90/TwJrkDYZBitDIKXyaybAgmsUyAA8R3j+s/wA6
 +N509LtsSOh8cNPFlfHdU6XWWKM5ooblL/SFB8SExg2Wt8FKWhrtTDZU28FVxAnERADRMdOcofQ
 ksPo3N/ii7aHuScsIAfDd1exSr+tzVF0T/pHYgx2594/hR1DjV6qiza05LVU20mpjjBd65u18DL
 TZ80AWLX3wdjiS9551XGVutjUhCzAMM6zToqiNOlgBeIbD1Poj9TNn3aL/qN4b4oqlSCyuGsXcp
 OBaTv1SpyGCzOa4xflpRgBWwBv2OfXOGgUaNj5LRim7/vxbtMlvGrDoTxiLmBicFSv+rGHEm2+r
 HMfeUlmr7JqpD+9GU2wi+ScQnMS5vMUkPlajz9uNTgoq4wlKwVAvOc8AByGBAANHi1zzUCgn0Hj
 xAwNo0nbCFUnbko2KO76n/PzvpdG4CrPNQ=
X-Received: by 2002:a05:6a00:1c98:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-84fde1cd25dmr37278618b3a.10.1787072553173; 
 Tue, 18 Aug 2026 10:02:33 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 31/38] disas/capstone: Allow for cap_insn_unit > length
Date: Tue, 18 Aug 2026 10:01:48 -0700
Message-ID: <20260818170155.1907006-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

cap_insn_unit is designed for targets like arm thumb2
and s390x where 4 and 6-byte insns are displayed in
2-byte chunks.

For riscv, we prefer 4-byte insns to display as one
4-byte unit, rather than 2x 2-byte units.  So we will
want to set cap_insn_unit to 4, but allow for insns
that are smaller than 4.  Emit padding to match.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/capstone.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/disas/capstone.c b/disas/capstone.c
index fe3efb0d3c..8fb8d0724c 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -107,8 +107,9 @@ static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
 {
     fprintf_function print = info->fprintf_func;
     FILE *stream = info->stream;
+    int unit = MIN(info->cap_insn_unit, n - i);
 
-    switch (info->cap_insn_unit) {
+    switch (unit) {
     case 4:
         if (info->endian == BFD_ENDIAN_BIG) {
             for (; i < n; i += 4) {
@@ -140,6 +141,11 @@ static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
         }
         break;
     }
+
+    if (unit < info->cap_insn_unit) {
+        int width = (info->cap_insn_unit - unit) * 2;
+        print(stream, "%*s", width, "");
+    }
 }
 
 static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
-- 
2.43.0


