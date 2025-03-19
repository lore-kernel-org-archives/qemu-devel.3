Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90AC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPZ-0008Vw-GE; Wed, 19 Mar 2025 04:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOk-00080w-2S
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOi-0004Q6-0m
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2260c91576aso55807885ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371410; x=1742976210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D41W4Q8+joe9dO5MBm79suNRGDyG9oLnqdd8A4ljE2s=;
 b=OqVfxSFExO++3Cj3FCYp6KZjfLcAT4Dvy0QRQHWaKC+AZF7NG1Me0pWZKTH6G+87dB
 FbK+HsiMiYBQyq91p3xBU7CrYe3jLlDa55r4DGGTOYZBfh72rh1hbFO8DnD6KAyphHWY
 jxIhtj4ajOEDauTcdRB101mZb69huDxffFEM6xsz01PC1YK2/qBM98XkvFH+YW7jy/At
 DUEXHV4Ws2QzofdXy9Eh3CFcqp9sn3FRrUkjy8lJ/V+L4fE25EqM4w5I/oCZrO6tv+X/
 HSN6y+SwSLZVl24zNvdSCmo69sASDkRK27BOHdvxpesdLMWfUk0Kixt2S8QBycJxT8xa
 WQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371410; x=1742976210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D41W4Q8+joe9dO5MBm79suNRGDyG9oLnqdd8A4ljE2s=;
 b=MAOv36Gl69+FwmP+PFovEMjEW17GfAEjdYbuRYCJaJ3LGryLe5QVVMneVGQryAPrCy
 ZWX7rr+OyCVzmR0nlBkNahIRI3vp0F8Tz5XHObhWWqs0kaK/vs/ecO1gHjcUJumPNCnC
 miWW63E3TERTRrAsyw0vO8AvCJ8LADNJsAcMTUQmAfhIoWp7xysyFnUi4uH/BB7VPELV
 f/S8khMyp/3Ty+RcB9i+oaHiZJozCkszKYX598kz5uKwm0q2k7KR8XPVkJNY1vuqu5IO
 a+bz8XbA4SAFW0YS51mllht37H2ElqeW2uvkeVpa95+6mKmISoLIQ3hrsaIFxWuaeSx5
 TaHw==
X-Gm-Message-State: AOJu0YxWgylmszddEjh7hMWp7pSbTo26GeDExYFxO09Br/lEbLkZ4dXo
 4p3eTY7sqvyU28EuXmERotdxwE/b8d4wsTlBBwS0DkeUnFTE3lpc6/EqyQ==
X-Gm-Gg: ASbGncutdxq7y7z8fQZxno8Y4B/0kOxjmug3uAlvOYbnCjOwfkesV8k2h2O9fTCdgyE
 jF2N+NGiurhgsfWz1mL/V8oQcHn7zkfl8WkGzXW/MiO8c5ZU3qwZAw03yS+SBzKeH72i/XfBxOG
 M/R1lsyveoKRWlv5p3mrawLprkXp642yL/e0FOcGgBFkSwQ9//5grTw9bdHnsDkV+3kQGYOg99E
 mHc7iuEooxmT4it1jd28QPH/R6Zk2OxEmDi7VxUacc4G3vEMWXP37AZBZU+rziswezzB/g0DuyB
 g4aEAvj6SYqfsm/wLg9Q3WSur8w02J6YuvWq+VEk3pvYSuJK4bdS0uaKHjmlyTRGgzWPL9qVZKD
 zWCTACExlwmMFyABH++4utEgaqmXURLs+vMfoMFyMnEBVWLwQ
X-Google-Smtp-Source: AGHT+IESFOJd/uy3NCSaU1KtHRzUNvfsJy493/9GQK0XHTUe/3TRiKWV3RYRTKkhKgZbg44zWEQptg==
X-Received: by 2002:a17:902:e846:b0:223:37ec:63d3 with SMTP id
 d9443c01a7336-22649a2f067mr23379685ad.18.1742371410383; 
 Wed, 19 Mar 2025 01:03:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/10] target/riscv: fixes a bug against `ssamoswap` behavior
 in M-mode
Date: Wed, 19 Mar 2025 18:03:02 +1000
Message-ID: <20250319080308.609520-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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
2.48.1


