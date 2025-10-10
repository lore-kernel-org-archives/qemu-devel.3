Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0420CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77EF-0001ia-OZ; Fri, 10 Oct 2025 03:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77ED-0001gc-Pb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77E2-0007yL-DA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso10116355e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080053; x=1760684853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIyiqfArKbn1ZklyRRQRhl2a6Voqe2HH/5GIa/YoHgM=;
 b=TsVjVuXcA81kT0pSmWNzS1Qhc4rHPIRc7jpyG1ynaSus9JcIfN4fiLCG3+IRAAKwLO
 kGIohDCYAMpg22cDk8c4WgHE42rQk/L1B8NBblKI0Lz1CdJ/qkxWfXcuQVGJYVZ0Exmd
 P1jwjtrPektfdmVGtLAJVK4PnmQHK0d3K1qVpHRtf/jm+GuFW/cli19eFzRmKKOHoLMB
 lDAve9Nsf9xcgJTVvPQKA6KsMDHI4Qgq8xQGriU6l/XsJ4GQJ0Cp7J8VSGsY8UFmvOe9
 PMH9vlYZOe7eMefwZ1GfpEKgaAyRbcQxTPF5Fa3nESzh964qNq1j6tiaOJbo35ztfewh
 OSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080053; x=1760684853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIyiqfArKbn1ZklyRRQRhl2a6Voqe2HH/5GIa/YoHgM=;
 b=ZChptpjtBu2l2rKiXij1SmReTcpImwVWf57Zcrq+j7U86onlnoDfypv22GSXYx0Fda
 2VwlwaYCUm3WfepV/D43f/p8Ee9YMp/SKksXum4FcPPblWoG2PHYPBohYIu7QfqDdsqq
 0wCnO1IkpQaM9StqwrUPLaGQUla6U4eedmkZU5aSe6te0sFnAtrpwW9vTzTO64AAWUeE
 2k+ll7jsu0E7NowKDwuvM269CDkyZ2hSlRrNINt77dk/PBdl63RauUuL53PzmVfDvnwy
 KzocUFq7XvPvhW9PuE12/tmwyHEq4tp1Mu4B0ThlFkKvxd1Ic6j/WxzI6YKSoVAVBpWa
 wo1Q==
X-Gm-Message-State: AOJu0YyA9/63MZaiyHxecj/1aUczIiy9v8z/Poxhl7RgS4WrLMukKRWT
 mXH9du90XkyKxDZP154V3U9SY5A/tDGeD2rQgqo0esu5jm160dsvmsqFO4bqYP9N8ou9x+QJW92
 hbdT2+KWVCA==
X-Gm-Gg: ASbGncv9sXId3tvdpgPjbWs7txgtzHsTogrELK+jH/6Clm7E1m9dp1LzKjimrBixXhP
 ZICbSCxVwyEOt3u6fheCoRYLvNVzcxnUUX8cdZbyfkZgAayBLlSO/vpyCqVvySMcYelIKiEXmIp
 LjncnfQMgr7NVLdBeWSTsdfkRVO/QKE25Ed0lcwvAtjNu/0yIYyXNhv08TUZC7RzOISYiYVjQjV
 iib8bN2gl/Mfhgn59E5Jo7Ah5heoFljsOehp62ftY6yy0IilVnh6MWAjMnjJI6b+bgf7TOGDWTh
 qUBpRzGv/oNaTuyzIZnnqkaV1+U0Ak3+tzaQ7/A6vNOaA86Q3QbNjc2kvrzWXaa4jVaIMIDQ9qD
 aT9TyzrcA7QrlxUvJThvdj6g82cqMbQYc+dqNIitjFUd/98P0sAStT0xmfP2Uup+9hR0ROpKmfN
 5/kxQfs4+rGVsaV8rE3TQydUdg
X-Google-Smtp-Source: AGHT+IFA78mo7ijo7/Er8oO/YGBVp61TQW6mOYJgFMcM6dFRpavVrhkdHbQAvrjwngZrYCHdpMxRbQ==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-46fa9b1b277mr70248935e9.37.1760080053006; 
 Fri, 10 Oct 2025 00:07:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb497aec2sm31238245e9.1.2025.10.10.00.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/13] target/openrisc: Remove 'TARGET_LONG_BITS != 32'
 dead code
Date: Fri, 10 Oct 2025 09:06:54 +0200
Message-ID: <20251010070702.51484-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Remove the dead code guarded within TARGET_LONG_BITS != 32.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 9f61f917b3b..29e6b51a930 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -298,19 +298,8 @@ static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
 
     tcg_gen_ext_tl_i64(t1, srca);
     tcg_gen_ext_tl_i64(t2, srcb);
-    if (TARGET_LONG_BITS == 32) {
-        tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_ov, 0);
-    } else {
-        TCGv_i64 high = tcg_temp_new_i64();
-
-        tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
-        tcg_gen_sari_i64(t1, cpu_mac, 63);
-        tcg_gen_negsetcond_i64(TCG_COND_NE, t1, t1, high);
-        tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
-
-        gen_ove_ov(dc);
-    }
+    tcg_gen_mul_i64(cpu_mac, t1, t2);
+    tcg_gen_movi_tl(cpu_sr_ov, 0);
 }
 
 static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
@@ -320,18 +309,8 @@ static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
 
     tcg_gen_extu_tl_i64(t1, srca);
     tcg_gen_extu_tl_i64(t2, srcb);
-    if (TARGET_LONG_BITS == 32) {
-        tcg_gen_mul_i64(cpu_mac, t1, t2);
-        tcg_gen_movi_tl(cpu_sr_cy, 0);
-    } else {
-        TCGv_i64 high = tcg_temp_new_i64();
-
-        tcg_gen_mulu2_i64(cpu_mac, high, t1, t2);
-        tcg_gen_setcondi_i64(TCG_COND_NE, high, high, 0);
-        tcg_gen_trunc_i64_tl(cpu_sr_cy, high);
-
-        gen_ove_cy(dc);
-    }
+    tcg_gen_mul_i64(cpu_mac, t1, t2);
+    tcg_gen_movi_tl(cpu_sr_cy, 0);
 }
 
 static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
@@ -349,11 +328,7 @@ static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
     tcg_gen_xor_i64(t1, t1, cpu_mac);
     tcg_gen_andc_i64(t1, t1, t2);
 
-#if TARGET_LONG_BITS == 32
     tcg_gen_extrh_i64_i32(cpu_sr_ov, t1);
-#else
-    tcg_gen_mov_i64(cpu_sr_ov, t1);
-#endif
 
     gen_ove_ov(dc);
 }
-- 
2.51.0


