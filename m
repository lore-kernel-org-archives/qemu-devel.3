Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyAO-0008Bf-3n; Tue, 25 Mar 2025 02:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9X-0006IB-Jd; Tue, 25 Mar 2025 02:52:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9T-0001xr-QI; Tue, 25 Mar 2025 02:52:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E6BE1107D7D;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 890751D5E88;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7E30F57058; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 59/69] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
Date: Tue, 25 Mar 2025 09:50:32 +0300
Message-Id: <20250325065043.3263864-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Deepak Gupta <debug@rivosinc.com>

Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
`ssamoswap` instruction. `ssamoswap` takes the code-point from existing
reserved encoding (and not a zimop like other shadow stack instructions).
If shadow stack is not enabled (via xenvcfg.SSE) and effective priv is
less than M then `ssamoswap` must result in an illegal instruction
exception. However if effective priv is M, then `ssamoswap` results in
store/AMO access fault. See Section "22.2.3. Shadow Stack Memory
Protection" of priv spec.

Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")

Reported-by: Ved Shanbhogue <ved@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250306064636.452396-2-debug@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d2c5759c8dd4c00195d4ebecc7d009e41df6baef)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index e3ebc4977c..b0096adcd0 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -15,6 +15,13 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#define REQUIRE_ZICFISS(ctx) do {        \
+    if (!ctx->cfg_ptr->ext_zicfiss) {    \
+        return false;                    \
+    }                                    \
+} while (0)
+
 static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
 {
     if (!ctx->bcfi_enabled) {
@@ -77,6 +84,11 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
 static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
+    REQUIRE_ZICFISS(ctx);
+    if (ctx->priv == PRV_M) {
+        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
+    }
+
     if (!ctx->bcfi_enabled) {
         return false;
     }
@@ -97,6 +109,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZAAMO(ctx);
+    REQUIRE_ZICFISS(ctx);
+    if (ctx->priv == PRV_M) {
+        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
+    }
+
     if (!ctx->bcfi_enabled) {
         return false;
     }
-- 
2.39.5


