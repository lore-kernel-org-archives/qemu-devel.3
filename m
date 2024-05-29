Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF34C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGxf-0004bn-Hd; Wed, 29 May 2024 06:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxe-0004az-Dj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sCGxb-00038M-UF
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GyYRSkELlfnbhEfugR7UfUM9SFCQGfkQTU4bDJyXro=;
 b=U0qvNpZp13C3Ni691ZmEE4/JkJu1tzGU6jM/CW+rW5/5//UnUMLAPN7UmokO8NkYgAiWG6
 YobAgfWny06Mc6erxBrozeI/xoFshyzUhnyz3PvqubMlOzPHEiFYw+nW9r7jpCZfGxLt3S
 FxDIUP0qw4kdzd7anDv82SekGYPGEn0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-O06KanVNMzC8iu1JtWAb9Q-1; Wed,
 29 May 2024 06:55:07 -0400
X-MC-Unique: O06KanVNMzC8iu1JtWAb9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 487D429AA386;
 Wed, 29 May 2024 10:55:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0263105480A;
 Wed, 29 May 2024 10:55:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 06/22] target/s390x: Introduce help_goto_indirect
Date: Wed, 29 May 2024 12:54:38 +0200
Message-ID: <20240529105454.1149225-7-thuth@redhat.com>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
References: <20240529105454.1149225-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Add a small helper to handle unconditional indirect jumps.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240502054417.234340-7-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 07620948ae..7ae928c3b0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1118,6 +1118,13 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
     }
 }
 
+static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
+{
+    tcg_gen_mov_i64(psw_addr, dest);
+    per_branch(s, false);
+    return DISAS_PC_UPDATED;
+}
+
 static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
@@ -1148,9 +1155,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             goto egress;
         }
         if (c->cond == TCG_COND_ALWAYS) {
-            tcg_gen_mov_i64(psw_addr, cdest);
-            per_branch(s, false);
-            ret = DISAS_PC_UPDATED;
+            ret = help_goto_indirect(s, cdest);
             goto egress;
         }
     }
@@ -1463,9 +1468,7 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 {
     pc_to_link_info(o->out, s, s->pc_tmp);
     if (o->in2) {
-        tcg_gen_mov_i64(psw_addr, o->in2);
-        per_branch(s, false);
-        return DISAS_PC_UPDATED;
+        return help_goto_indirect(s, o->in2);
     } else {
         return DISAS_NEXT;
     }
@@ -1495,9 +1498,7 @@ static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
 {
     save_link_info(s, o);
     if (o->in2) {
-        tcg_gen_mov_i64(psw_addr, o->in2);
-        per_branch(s, false);
-        return DISAS_PC_UPDATED;
+        return help_goto_indirect(s, o->in2);
     } else {
         return DISAS_NEXT;
     }
-- 
2.45.1


