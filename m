Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DD8C61DD7
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 12:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0IDP-0005uy-K9; Sat, 29 Aug 2026 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ali@iusegentoo.com>)
 id 1x0ESO-0000eS-8u
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 04:30:32 -0400
Received: from sender-of-o58.zoho.eu ([136.143.169.58])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ali@iusegentoo.com>)
 id 1x0ESM-0002Cu-Jd
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 04:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1787992223; cv=none; d=zohomail.eu; s=zohoarc; 
 b=EvCJNp0vt2IwzIPhJ1tRzeMRisUf4NYhO1AMTwu6MA5Wnpg5XJzsMHyga38NhlCjV/7RqHz6ePpW1N8NK1CFO/+tBTPKs8WKLu51IOPf83mp2L6i8kBZcP4E2cbnHR1mQjiZJ9eA7EpAm6R75QPK9ObtUlWjm8sTH/A39+PqUak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1787992223;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IAA4G3XKZTpZrERxA/O5HIyaveszDLi254+2Znopn2s=; 
 b=kfCHmoYSvwG7fblGGaUQjCWzEcJMIFDkMzN6VsxkCJJEvPXjMqwja9w/CGEl29miOMY0mIJmBiEgzg8/kN/weGpx9c6wBU7+FKzSqia4QHJthpAsfbYwLogSCqJdftqZ54hMOIJZ6NW1/Gdd7a+Af8hGhz/GGGlgWowHmya1kjI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=iusegentoo.com;
 spf=pass  smtp.mailfrom=ali@iusegentoo.com;
 dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787992223; 
 s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IAA4G3XKZTpZrERxA/O5HIyaveszDLi254+2Znopn2s=;
 b=NOnHfAteLSN7LiQutltl8ecHhcM4yB+PfIvtRwVIb9OCXXQxHf7uOPhFhO4rfJr8
 JdV4bG54mrzSBKELfzJ6JWv/2T2NJnrxGfep90ePPSy0FUkNmR4rFdzxlC8ZgcQHk1G
 n6SRzXNXdKJaye8kMTMTaAOfZ+r2p2Vp6Z4zsCgg=
Received: by mx.zoho.eu with SMTPS id 1787992221703226.72690195269513;
 Sat, 29 Aug 2026 10:30:21 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: shorne@gmail.com
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <ali@iusegentoo.com>
Subject: [PATCH] target/or1k: Implement l.extws and l.extwz
Date: Sat, 29 Aug 2026 08:29:48 +0000
Message-ID: <20260829083010.2424941-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.169.58; envelope-from=ali@iusegentoo.com;
 helo=sender-of-o58.zoho.eu
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2026 08:31:12 -0400
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

From: Ali Ahmet Memiş <ali@iusegentoo.com>

l.extws and l.extwz belong to the ORBIS32 instruction set, but the
decoder has no entries for them, so they raise an illegal instruction
exception on every CPU model.

On a 32-bit implementation both are register moves: there is nothing
above bit 31 to extend into. Implement them as such.

Found while writing an OpenRISC port of Valgrind.

Signed-off-by: Ali Ahmet Memiş <ali@iusegentoo.com>
---
 target/or1k/disas.c      |  2 ++
 target/or1k/insns.decode |  2 ++
 target/or1k/translate.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/target/or1k/disas.c b/target/or1k/disas.c
index dc025bd64d..0a46d68d30 100644
--- a/target/or1k/disas.c
+++ b/target/or1k/disas.c
@@ -71,6 +71,8 @@ INSN(exths,  "r%d, r%d", a->d, a->a)
 INSN(extbs,  "r%d, r%d", a->d, a->a)
 INSN(exthz,  "r%d, r%d", a->d, a->a)
 INSN(extbz,  "r%d, r%d", a->d, a->a)
+INSN(extws,  "r%d, r%d", a->d, a->a)
+INSN(extwz,  "r%d, r%d", a->d, a->a)
 INSN(cmov,   "r%d, r%d, r%d", a->d, a->a, a->b)
 INSN(ff1,    "r%d, r%d", a->d, a->a)
 INSN(fl1,    "r%d, r%d", a->d, a->a)
diff --git a/target/or1k/insns.decode b/target/or1k/insns.decode
index 0d6f7c29f8..cbf8af7f8b 100644
--- a/target/or1k/insns.decode
+++ b/target/or1k/insns.decode
@@ -112,6 +112,8 @@ l_exths         111000 d:5 a:5 ----- - 0000 -- 1100
 l_extbs         111000 d:5 a:5 ----- - 0001 -- 1100
 l_exthz         111000 d:5 a:5 ----- - 0010 -- 1100
 l_extbz         111000 d:5 a:5 ----- - 0011 -- 1100
+l_extws         111000 d:5 a:5 ----- - 0000 -- 1101
+l_extwz         111000 d:5 a:5 ----- - 0001 -- 1101
 
 l_add           111000 d:5 a:5 b:5   - 00 ---- 0000
 l_addc          111000 d:5 a:5 b:5   - 00 ---- 0001
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index eb4485312f..e00ef45b9b 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -502,6 +502,20 @@ static bool trans_l_extbz(DisasContext *dc, arg_da *a)
     return true;
 }
 
+static bool trans_l_extws(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
+static bool trans_l_extwz(DisasContext *dc, arg_da *a)
+{
+    check_r0_write(dc, a->d);
+    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
+    return true;
+}
+
 static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-- 
2.55.0


