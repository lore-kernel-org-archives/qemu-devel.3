Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26829C56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7t-0005rm-NM; Fri, 20 Feb 2026 10:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2C-0008D0-6P; Fri, 20 Feb 2026 10:03:13 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS29-0002Kr-F4; Fri, 20 Feb 2026 10:03:11 -0500
DKIM-Signature: a=rsa-sha256; bh=l6zKq+H7M6nbmk+wPFI6JyTis646VpV4edPZH5Wq97I=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599788; v=1;
 b=Q+k+Fx/ZLLukMuaEksjQAQYnJamwm2l74t4fyoexuw9o2O3u9+79O5GZdEJuLV4upt9kDZRc
 hKfj1c2G/+8x+M2Kl/rXR1eYr3xaUFF8z2YuKMzutRkUn++CFV53XBLWkLC4GqBgZsXh+t76gL4
 0SvWM5rpX/5b6tnji4K8taxkePDLkrFHw7P8eSdCazfoq5Jkk2DZajprB2s8q/StU4s1r5LyXf2
 tfPzCIpxVDt/e04LaXNfQZJZjIPJ2v2boD+53+dW2vClfMzPAIxhh8xTVKGRhMU9H4CnmpAqnz5
 H39E0N7IRUKgvjMii5/lyRqLx9wgWgK70yQ0Ft5jMgYzw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 0EFA12501D;
 Fri, 20 Feb 2026 15:03:08 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Wed, 29 Mar 2023 19:16:44 +0200
Subject: [PATCH qemu 05/11] [ot] target/riscv: add custom mtvec CSR management
Message-ID: <177159976712.8279.7732381632410882915-5@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>
---
 target/riscv/ibex_csr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/target/riscv/ibex_csr.c b/target/riscv/ibex_csr.c
index d62638bbfb..a6e815e782 100644
--- a/target/riscv/ibex_csr.c
+++ b/target/riscv/ibex_csr.c
@@ -69,7 +69,37 @@ static RISCVException any(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
=20
+static RISCVException read_mtvec(CPURISCVState *env, int csrno,
+                                 target_ulong *val)
+{
+    *val =3D env->mtvec;
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mtvec(CPURISCVState *env, int csrno,
+                                  target_ulong val, uintptr_t a)
+{
+    /* bits [1:0] encode mode; Ibex only supports 1 =3D vectored */
+    if ((val & 3u) !=3D 1u) {
+        qemu_log_mask(LOG_UNIMP,
+            "CSR_MTVEC: reserved mode not supported 0x" TARGET_FMT_lx "\n",
+            val);
+        /* WARL */
+        return RISCV_EXCP_NONE;
+    }
+
+    /* bits [7:2] are always 0, address should be aligned in 256 bytes */
+    env->mtvec =3D val & ~0xFCu;
+
+    return RISCV_EXCP_NONE;
+}
+
 const RISCVCSR ibex_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MTVEC,
+        .csr_ops =3D { "mtvec", any, &read_mtvec, &write_mtvec },
+    },
     {
         .csrno =3D CSR_CPUCTRLSTS,
         .csr_ops =3D { "cpuctrlsts", any, &read_cpuctrlsts, &write_cpuctrlst=
s },
--=20
2.49.1


