Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A6BD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfSM-0007Xk-V1; Fri, 19 Dec 2025 13:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSJ-0007XB-My
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:44:00 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSG-00017O-PY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:43:58 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb3801f7eso1154707f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766169835; x=1766774635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=fIcDoKdIKuoQCVc/Ye9jRehbhX3F/5Awm+U2203Zm6lFuiOVIy0E0DcgznwYbrvU7/
 VWo8G2FVwxb1h30hCGygBoeaqqKBP8DpZ9GrAN6mvFPvPTaESM8Gtnrp+Ke9WHcjfvqw
 KjB5eEDr7iu/Rzg5KvkSYitNYBHQPJNSXftYx5rc0HJV1vAEZn3WQ9IFC1liZHF24TFk
 sOT1Z7P4317GlCWeo1vD6+W7cstDGlqr7wnllIuzYNS1S1q84PWYXFyETaC9NE9ahedv
 QtFmBHnfpsabxkLhT1oaWsNh/NzOs505wHX/YVSS/js8tufXctg7KYPDOUoqsWwyHw1Q
 EL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766169835; x=1766774635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytV7sRjMhiZ+N36QlRegSL9F2KH4Bl+JY5tBc1NaTPk=;
 b=wWjWEmJirkEAfgV/1xLLXp1cisxr3wkZ8tN20nAzIKXh5pmAhF8gbKomKvpnoreybi
 nJxICXfwmDSe9wjWAhjvS1JAb/IIxx34YFXSHxMTqP+5lPy5bSyl716Ne2ZhHr7fVDtv
 HhbuQ0oLlt6/wLhm8mMzSTnkd6oL27p02Ks80Ew7PGnczzbx8QDoCF7jdaLs6fRNPd+x
 vP9XDjachaPgAkhTrZizZtG35kt8/XMQ/RkBAcE7atrQWO3y3CWmnqBi26Z5ixvJ3ilv
 pZ3sZmNm5b3HBZIPxa6XCoWvJrZqvrkL4HQ99OrSrE5oCI8+c1SGc71VdFXo8oGzCiu/
 YIIA==
X-Gm-Message-State: AOJu0Yy/h2J9jLs47woz65A3f2fQTYro+c1KEPiSzeWiwAJytkRb/NMm
 A0IPgudzwkp40hMutPKXM6b3yz3EFKL/cKnosqZbgOZPo2USDAo/tDJqZTcjBGMxBM7+o/duWZ5
 L8KcOiRk=
X-Gm-Gg: AY/fxX6+qTX+W6LY/xh9Wl5zAySvlcQhW+uoj6x3B4v/1H4ETvQwG/Zz0DC8q81RbQt
 3Rb5vt+mk9DJrTsde6xjlLItLtvoFeH9lkns2HF04BUJCtKJ83dchmKrgdGp7/nOgi/RHzvYQOk
 tulU1VxBz8n40lWN6IO9aDR3UzmQgMiHw+73uam++J1mz3XgX6ulpWZoYOkNZ23XesN6gS7dTji
 nb1kU/1WPhUiWdCyZRmdszn7dRtN766Vkm2VA+muuBhbGm6YW4D6lZBf6l4Up2JiFx5eQ4GPjCX
 UXClzDk2ABE/UzQrRGxb+pSmUEKKLPqSli9gt/9Pvo/gr0eMGPxbah/y8jzMHeq+DPDwEv7iGDp
 0VoS+r+thlGQ1gJ37gLDQIm47txtCY19sAdIJVUMc0aP3MeHWVh+prrsNcR1k8nzsw+q8eO4RoM
 SXD83Ry+426LR/R+jThNgWmC3AH1kQWxyvwwD7Zv68SlPXqFotesztmaJFyAs/
X-Google-Smtp-Source: AGHT+IHimj4Pe72o2RpDwXv8f7SaJhSauRVPOVVu+nvSQG17NxKA6D1ARsvc5NHTQIYatUj2yl2zNQ==
X-Received: by 2002:a05:6000:178d:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-4324e506649mr4236211f8f.42.1766169834668; 
 Fri, 19 Dec 2025 10:43:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82e9fsm6685949f8f.26.2025.12.19.10.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:43:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/hexagon: Inline translator_ldl()
Date: Fri, 19 Dec 2025 19:43:43 +0100
Message-ID: <20251219184345.96786-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219184345.96786-1-philmd@linaro.org>
References: <20251219184345.96786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_LE
since Hexagon use little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0de..c37035c4774 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
     memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
         words[nwords] =
-            translator_ldl(env, &ctx->base,
-                           ctx->base.pc_next + nwords * sizeof(uint32_t));
+            translator_ldl_end(env, &ctx->base,
+                               ctx->base.pc_next + nwords * sizeof(uint32_t),
+                               MO_LE);
         found_end = is_packet_end(words[nwords]);
     }
     if (!found_end) {
@@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
     int nwords;
 
     for (nwords = 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++) {
-        uint32_t word = translator_ldl(env, &ctx->base,
-                            ctx->base.pc_next + nwords * sizeof(uint32_t));
+        uint32_t word = translator_ldl_end(env, &ctx->base,
+                                           ctx->base.pc_next
+                                           + nwords * sizeof(uint32_t),
+                                           MO_LE);
         found_end = is_packet_end(word);
     }
     uint32_t next_ptr =  ctx->base.pc_next + nwords * sizeof(uint32_t);
-- 
2.52.0


