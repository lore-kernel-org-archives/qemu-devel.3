Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D32606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL22w-0008HA-Ee; Sun, 25 Oct 2026 13:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22v-0008Fo-5Z; Sun, 25 Oct 2026 13:30:13 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL22t-0007D0-3m; Sun, 25 Oct 2026 13:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ZaNDMhNHX8odw4RDhctG2uu4XIjXG6Yg0otveYbOIq4=; b=gke5FCCi3LtBTG2xgHpNPVk4tt
 XTaaPkuwNp6ZI61ikFJ6/uBMFNU6TaAAp6jJBBJYJnpWmDVLdJa9LAUwhAjAfEGItBemI+hbnm4v3
 rpi5dzdif4ViYqg2lJS7zMfcJx7gZhaElzQe3weMCsV0NBLlqLwZVDSXkOLqs9XULtiW3/T++qmEQ
 lUiakzhDlX0NUy790wvSexHdIwZMHE+nv86cg3nWfaB485Jj4VNPRDmrrBnTBIEzvlsB11Rco28XS
 /qDRiRCFyjDBC+zK6q27Gjw6VN2taAbfrUmXFWCCm9InGf0qAkEjJa2MNG5HSV3HmMkEpl2oxvyI1
 DmQ/smYQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1gS-00098j-1f; Sun, 25 Oct 2026 18:07:00 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vw-000OzG-19; Sun, 25 Oct 2026 17:56:07 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 25 Oct 2026 17:55:33 +0100
Subject: [PATCH v2 17/31] target/rx: add RXv3 three-operand XOR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-umar-rx-series-v2-17-9e846577cad0@sayyadumar.com>
References: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
In-Reply-To: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=2034;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=w6vs/90JD9TcnPg/pZanjClEzzVtyRseMPTK06o8ss8=;
 b=/9R4Hsu3TpoNfQXXsosJWc9fgNHGKXsM9s5DoxOXxom8WwrXdhxMYulQFeqcey5skg6bjGiDA
 lLvj/wA7v0SDtg0H3TiAkVzHzuZdxXZS3z6eb0QLVcZg812n0ilNdSk
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the XOR rs,rs2,rd form, reusing the existing rx_xor helper and
the three-operand register template.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/disas.c      |  6 ++++++
 target/rx/insns.decode |  4 ++++
 target/rx/translate.c  | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 46148c4087..924cfdd382 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -1519,6 +1519,12 @@ static bool trans_RSTR_i(DisasContext *ctx, arg_RSTR_i *a)
     return true;
 }
 
+static bool trans_XOR_rrr(DisasContext *ctx, arg_XOR_rrr *a)
+{
+    prt("xor\tr%d, r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
         char dsp[8];                                            \
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 450949a4bc..4ac849d32a 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -730,3 +730,7 @@ SAVE_r		1111 1101 0111 0110 1100 rs:4 0000 0000		&svr
 RSTR_r		1111 1101 0111 0110 1101 rs:4 0000 0000		&svr
 SAVE_i		1111 1101 0111 0110 1110 0000 imm:8		&svi
 RSTR_i		1111 1101 0111 0110 1111 0000 imm:8		&svi
+
+########
+# RXv3: three-operand XOR
+XOR_rrr		1111 1111 0110 .... .... ....		@b3_rd_rs_rs2
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 93174f5e1c..7b5f74fb5e 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2543,6 +2543,16 @@ static bool trans_RSTR_r(DisasContext *ctx, arg_RSTR_r *a)
     return true;
 }
 
+/* xor rs, rs2, rd */
+static bool trans_XOR_rrr(DisasContext *ctx, arg_XOR_rrr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    rx_gen_op_rrr(rx_xor, a->rd, a->rs, a->rs2);
+    return true;
+}
+
 static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
 {
     TCGv_i32 val;

-- 
2.53.0


