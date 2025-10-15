Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDBECCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95ky-0007gH-Tx; Wed, 15 Oct 2025 13:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kw-0007f3-2e
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ks-0005Uh-OO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3923294f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551060; x=1761155860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLu3e9Eqgay3pYMDRNyYdIv4urmYssz3/strFFntMuE=;
 b=mqeJx8KjyGvmHKTx4ugMbKF4z9zMV9KgOPsg4F0qUauLv2g4myg8x16zjy0tcJdYMg
 FF/aMUN4q3TEO25jQAh3d2DvSThp7BENLSGwQ8z8KqM+5LEhzhIokEC5KO3FWNBiG/VT
 SJ59kKV7U1UHoyeKPIljz7W3cORC3LhyaUpDkSFLwEDJg7wq15+WWn2Ncolkn3WEZQm9
 8gPcf9ux20m+1rzDShsVApAHO8hdlpWPIIpbKPiGxaEvPGVkm/vkYXthN6hsaTcVYbOT
 OvMjPS93gkkRX4u0emxwtVQQ0T3Zk0OGrFAwQjlD3gPBPmuKPfC6s69Jhd4HzjLQzNvj
 EObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551060; x=1761155860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLu3e9Eqgay3pYMDRNyYdIv4urmYssz3/strFFntMuE=;
 b=ZGgakAVYc1qkA2dGYsSaOu2orqQRY5yoBRZFK8Qcy2UwIj+vdFKsdjwb8E2hTEyJgV
 TrIwiuYJD19TGWyL6rts8GMnp2e43FnduhKRZhEQosGZoElvv/vq2hRVoz+2JyucgEch
 HcRe6e9HH5rzkyROc+gC8iJvE0E8rPvDSsYMWcQP4zC/ln47zL9hy7H35nEqGclAI2v9
 xxTHzm0d+aE0fOARDokym1zoMbxsWVHqSXtAWmtO8TikWMLNVWqpNLJ60x6nERPuxrXF
 tYd/8n/YoBnEnqOLOE3AChL6IWJc5R1VWVwo8CuMXQltfdd5R1nzbVY2TxmcNccy7zT2
 cP/g==
X-Gm-Message-State: AOJu0Yx9TRWXmKvLNZTVLnY0WIgc2R++9dtSS/CMDfb/s/DOC9nELmyu
 k4DAvanN3L6TW1xGK/H/8DnSQG7TyaTfaNgCl80v/6CQefp/puyAb1qbDVOflc1kGBXSExrredH
 pYm5BXJVeyw==
X-Gm-Gg: ASbGncsx7fGih7an5pergCHb9PeJYiYv7tqbHHHE3lcqKsZikDwD5SXgYknx7DvjAw8
 26iBYZgBSmMHz1OlU3LHsPCWLTcjOuhafik6aey0eVGawFZpDG1BN/R9tlfja5rAotAHIkVlC6D
 f8cW+QUF1qAx2q4CT3dNF99yQI5Y/Nn2rGNbtiC6WHc+ZVlHcbUguAeH8gLlPkULeJzi/qNKQah
 eHrQk5npzIT6VZ6tq5CfPdhd4sjgukS+okvB/tUrIMrBuoFHaDzsZKcQiT6g0lTLQc17k6hTaRY
 OsmUBrqBOFLWd9KMSd7X44j+pyuD8isoIaw95CFsE9WZ1pVqetyQgOGMn+mhA9PrAbe3ayZRQ9/
 Il2ISX796RmDdy8lFFcguC/lzriJhg/8KhMsDSqK3kyDzn/la+WPKJ+kCFtInB30PEAY2FIUZg8
 0uHbyLNK0GQq0c+7g6GzA=
X-Google-Smtp-Source: AGHT+IEK+jOU9NgZheBtv88kAeU7elbFeuRppPxCONLLyhZ9xLQS+uoXeQA9tJHXXLe7OBXodyzPKQ==
X-Received: by 2002:a05:6000:2207:b0:426:d5ab:789 with SMTP id
 ffacd0b85a97d-426d5ab07a9mr12001829f8f.53.1760551059615; 
 Wed, 15 Oct 2025 10:57:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf790sm29202697f8f.28.2025.10.15.10.57.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Date: Wed, 15 Oct 2025 19:57:14 +0200
Message-ID: <20251015175717.93945-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since commit 36a9529e60e ("target/microblaze: Simplify
compute_ldst_addr_type{a,b}"), helper_stackprot() takes
a TCGv_i32 argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/helper.h    | 2 +-
 target/microblaze/op_helper.c | 4 ++--
 target/microblaze/translate.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index ef4fad9b91e..01eba592b26 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
 DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d2..df93c4229d6 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_stackprot(CPUMBState *env, target_ulong addr)
+void helper_stackprot(CPUMBState *env, uint32_t addr)
 {
     if (addr < env->slr || addr > env->shr) {
         CPUState *cs = env_cpu(env);
 
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
-                      TARGET_FMT_lx " %x %x\n",
+                                   "0x%x 0x%x 0x%x\n",
                       addr, env->slr, env->shr);
 
         env->ear = addr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b93a40fedbc..bc38ff0af92 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -606,7 +606,7 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
-    TCGv ret;
+    TCG_i32 ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && rb) {
@@ -628,7 +628,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 
 static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
-    TCGv ret;
+    TCG_i32 ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && imm) {
-- 
2.51.0


