Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA822C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkC-0003Ze-Ad; Wed, 19 Aug 2026 23:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkA-0003Ql-MG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtk9-00048N-3J
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:06 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1835707a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197624; x=1787802424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVsDsTudT9XSJrI4vG0rDBo8u+xmKSjOUGQovOsJcVY=;
 b=Cnj5q3qYzAUdQuLu6gZBCsbDBqGJdhLXRsdk4W+Y9P2HCWjQpEh1GIr6uvZgbDRrBL
 YZIIE7TOYMQAjbrutcedyKzPSIpCP68njacwTmhEMUXwzT9beRXKi6n0p66idiRScrju
 jJNI/2oPvoen2V3OXWkvVh/NlwpLUAu0JXhKQphXjNxAiWfHqJLiGMCRM+1kPo/BJtCh
 YrTYvxlycbCHj0EJKDdNCVRGKBemL/kEPmxp1gywGEU0FWfndiLYVf9ocdar8F5UPNaI
 OzxGw2+u5lq7uM3fdsepYGRC22ikr1UDd2lK/16i75nVnMEsIBD49apnzRFN+6Ic6OWp
 yfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197624; x=1787802424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVsDsTudT9XSJrI4vG0rDBo8u+xmKSjOUGQovOsJcVY=;
 b=AGscT5WH1cIdjvO1VUJw2Aq7duWM+TkTRHwJomyAGfCPmSAWNgP3ZraP0vAhswa7t2
 lv4o5wkg+J9p2OM9BS6opjvT7mrsU4s2CFLL5t/C/IvNDDrjNzHf1lxIYAGsL7ziLzlk
 xydDZq/lLReD9SoCKIui7q9KaGnl+Gg2CRpBme2ciTFr/KmLFf2VRsxsYKoWZNa2dLfn
 m/henLpWUpI+qEoIdzNRSTJ5OaN2S/pvbaeJMvcPzL4o65O8jeCc4RqEeccva20+omSd
 U+HRBRfOXY4u21iJmUmhgOQWNy2focjQakPnL1wiP/UiLfrXLJk9wg+hhbiUenoqNjoc
 4spg==
X-Gm-Message-State: AFuF++m9X8YdNrHi4v51BYaYSy28BdSpsLrBFs++mbAenjCAMiDML/aL
 McYlE25ScBvmAAPwVHG1ugi4V8aBGzcP5dzFoC4nXX9c4FTQ1TXSwb4dHQi3Hg==
X-Gm-Gg: AR+sD10bCpvBRpjB7wADzASr0XIcTo1lofccOA8XVmelA1JSUeIS8/3rPk/85VArFK2
 3nd1gwRom1NCUAsx/SuZ0G4qeuNfiUE8y4zQLrldY5BwQWrV+XJOodEV3tYIDlR1xJwbZRytO32
 2+oYyHy56kBJ0xUWN8RzrRtrQuHbFkeDUrOg5PNF+ilobrpU1uDCqw3pnQ50X3vdjIuAFE2G2EP
 LzZX9p/rr5g152b6lKmFAKRTgRI6BwBmC/fGmGRByCuBgCzs/Vu2rVxYl8txyzUjquxwtCBnvJz
 OEeySHAQTCzjkw1xflrwPQLDXhrKdEItkmSny0cvuf7AhP/3w4dKjs8SDJip9eFp+FqhGn+IK4a
 RKmz7TCAHTdYDmZsZuSdN5VP+u6L9i3ErHjTH5dF53z7YP8iq8AotprLQNKoCLTc2jdoFuIc4gH
 4d5GycevV8o8QFLkdikuWSXvoKXzviwnUzcDzg9yEY1gw00DKN3gP2qOb9WWnJmXPhMlVxSliGk
 hKXpQ==
X-Received: by 2002:a17:90b:3c8f:b0:395:4de4:92c8 with SMTP id
 98e67ed59e1d1-395810e9626mr19183261a91.15.1787197622957; 
 Wed, 19 Aug 2026 20:47:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 47/93] disas/riscv: Drop useless const in structures
Date: Thu, 20 Aug 2026 13:43:44 +1000
Message-ID: <20260820034430.1186695-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Individual fields should not be const, only full structures.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-12-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index eabe193b4f..3325b7b4ef 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -174,19 +174,19 @@ typedef enum {
 /* structures */
 
 typedef struct {
-    const int op;
+    int op;
     const rvc_constraint *constraints;
 } rv_comp_data;
 
 typedef struct {
-    const char * const name;
-    const rv_codec codec;
-    const char * const format;
+    const char *name;
+    rv_codec codec;
+    const char *format;
     const rv_comp_data *pseudo;
-    const short decomp_rv32;
-    const short decomp_rv64;
-    const short decomp_rv128;
-    const short decomp_data;
+    short decomp_rv32;
+    short decomp_rv64;
+    short decomp_rv128;
+    short decomp_data;
 } rv_opcode_data;
 
 typedef struct {
-- 
2.54.0


