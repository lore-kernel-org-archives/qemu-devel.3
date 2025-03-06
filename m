Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87E8C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq50J-0000mR-Su; Thu, 06 Mar 2025 01:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq50H-0000km-9f
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:46:45 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq50F-0006iE-4i
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:46:44 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so588336a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741243601; x=1741848401;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbZuOP22vzkw2+P6QIU7v8LOOYj3TomNQdTgry0GHck=;
 b=YJ7jFCFA90M/J7no+m+25Yc1DqbzZ6MjCCG8l+6mMCXIFfmFgBQk9NpZ75YX9Rcf8W
 fPV5AIPgUW1QnLMkcD/1uujxFRIfPPvZ65LB3b8FyglzQyWJ1dCJX68z9vGAJnRKbhe7
 WDCvSM+/LRdq9xLfSzjhSwqw1bUg1lyEc8Wcau3stHnjtGjgqy9ker2ahzKkhy6mCpQY
 /G/2jVUvaKreEmQ9rlfj8UHQypNuuKWZ7tVOgY0ZLAca3k6dKNltc/0F0D1hzTHO8lXO
 TVAgOjEgkUOWYbniLnRNr0hx6b5ui6cN5P/E5UKfIRHyr76GkLvWlwV0mJRav48nx7pS
 UQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243601; x=1741848401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbZuOP22vzkw2+P6QIU7v8LOOYj3TomNQdTgry0GHck=;
 b=JbsT9TANqVEPeDl5OGE+dKP2FFzsroEJe0YEi0CMcDAUZ7VaPotM5MC/ghsl21Tt8A
 exxfFV7My9cZ9OG/AKJPcbDG0I3xcgRLHUwXxNSp4to6IH2CYQ5Icfk5c0gpTS8Qvanh
 lQMJn+UDFWnAtzuSoCSBjuciPtdLZclnB8SWb0ZE01yTUHMour+m5PKMrpTaku1IZVnw
 VWH3exp09zJ8R6Vh0DLxCVWbplxgeTi3liTHEwPT7WiPVO3RXi5qhW0r1pNP+c/Fye+o
 mP8RgwXmTF/NrOR6Pxjo+car+tGZRzuUpqg7rzqZpdfOF7ArmXLlB9luKdC2mWfi3iGl
 yCmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpp3zxfJhUtLxcsqtaNNZ3Cl/HtNYWuPEqT2vW6MggnBbAJGYXmkZGzYuwvqVS43dC63wlMi0kRL5f@nongnu.org
X-Gm-Message-State: AOJu0YwCvT7OdXahPNTw3yQDqM8Il44tODZ04lfKiBKxNsqYziDZYM/s
 VmEqyDhXbGbFP30ez8U7TT9X+76DlfuBm7I6XuwTphV17/Z03Ekset8Fp9mu9cLzoD3mHSRGqTz
 i
X-Gm-Gg: ASbGncvq2oZdMEACkEZFg62bSVch51olqRd7J/EV+Nf7VrWpBRAvveSN8nsssuzbl0v
 4HVAdOyz93HVmNhAniQz/ibf2a3LqHVnTH0nygDWM4GO79c01bb9bD4CNL8Oo7mtXIqkRtEFnSH
 De0/Xs0vBxvDKakIA+1S1s3W+espqpXFKybc2aRp7ClycN5BB3EKvl3PRTfe1QFjdC9WwAX2P4g
 gIq+oNms2Cp4j3tHIjoG0I2Y4gKs4d4G0hb9nl0BcvP5uoryRVCbQrDoHSEpZfZMtQo/m0aZ4x7
 Uicniav4sYNqcdEKQ9Q1Ih+A6K9+MLZPDxIcrluktSyDD1Xrs8NFBdI=
X-Google-Smtp-Source: AGHT+IGhglqGWLeZ6lwM5EYr1+qz51yIjo0EHhJOf0aJQYQCjWxHZbjlnBRTeyAwOrlfeWEURf/cUw==
X-Received: by 2002:a17:90b:5147:b0:2f4:4500:bb4d with SMTP id
 98e67ed59e1d1-2ff49753b47mr10071962a91.20.1741243601389; 
 Wed, 05 Mar 2025 22:46:41 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a80edfsm4828185ad.150.2025.03.05.22.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:46:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>
Subject: [PATCH v2 2/2] target/riscv: fixes a bug against `ssamoswap` behavior
 in M-mode
Date: Wed,  5 Mar 2025 22:46:36 -0800
Message-Id: <20250306064636.452396-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306064636.452396-1-debug@rivosinc.com>
References: <20250306064636.452396-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

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
2.34.1


