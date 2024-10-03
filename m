Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C08CF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVTr-0007wt-JY; Thu, 03 Oct 2024 19:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTZ-0007hm-K8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTY-0003pI-08
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so12171895e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998993; x=1728603793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gli2giWmo6/3/Q3D0dlOvqkXZTs2pwWeMPJl2E3h3vs=;
 b=YcXLwcrgzol2HcyeU7eme7WKRviJcfPOei3p/7lJN7+hxmEp7Om1rPOelEaZzbVtix
 1ZXAmsk6MtQ0xSst88adylWUvm06leeF0nCEtmPYf0fumN4iGyt1YteQJ/UqYxK5Sjck
 AGuvNGd/SWfbyAvREeIYNUdynLTyd4GYkbVrrHhMwtC4j9odK9VeacEoIPKIdbS8o1kW
 xJBSkHit7yBi8XHtuIkBP23dtLO7e5JSAwDA01SWdpzXIIPLgFCqZ7g8liQuq2wTLMfO
 Lsi7C5DT1vlThGNCEEMxy2jOYeowKj6VT8Mw34JlyMQ7Lkx2be1L7ho7KQkJTzcncosE
 NvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998993; x=1728603793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gli2giWmo6/3/Q3D0dlOvqkXZTs2pwWeMPJl2E3h3vs=;
 b=jG9J1HUagQ7CESV4r0chzI+U4rFo7T3NkCcFWYNdSzJJx3mtjRLu9lvFBBhtfYaS9R
 HnQkFKnMp53nRp0EyAdFNC3SJQzQVJFYciQ4nheNVZ0gUbyCA8KtwZDwNhn3RuEZNvzk
 YVuwH0Bpsx65yrSHcd48mTYZIJcFkXiXa2Zpxz27aphhZhnYvaO69UA7xXHdfipXEPlV
 8m2IX+DvInnsllqAtyrtXuSbWThyJH58srDi0Oiu0iPl4F7Pfv6U2Tw9PpcaYYefXPTw
 8x8IDbYzk/HLrDO0kX8m/tWF+M9TT+LwHJ9LMxoDd+LRKHkYTXpIlm0wsv+kOg7Ldfhf
 bVIg==
X-Gm-Message-State: AOJu0Yyz6QCURas7Hxk9ppIrBYCU3CEaO/FRDh0ONvnR3ys55L+W2hyK
 AK+EaK4z1YdlCRdb8NI5RSDPXb96eUlOhWnX9U5zHpV5imTVA6+LPVsPstuD72U//QLVIHOuwZ0
 fiZE=
X-Google-Smtp-Source: AGHT+IGge2F93OrH2klnGwt3dIb8agKpbifshJKqK7rUzjjxA19COIOexEf6CgqE/jWM1h5MMa9GuQ==
X-Received: by 2002:a05:600c:1ca4:b0:42f:8515:e479 with SMTP id
 5b1f17b1804b1-42f85aa142dmr3417795e9.4.1727998993421; 
 Thu, 03 Oct 2024 16:43:13 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d06csm1322645e9.11.2024.10.03.16.43.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/16] target/m68k: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:02 +0200
Message-ID: <20241003234211.53644-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The M68K architecture uses big endianness. Directly use
the big-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/gdbstub.c |  2 +-
 target/m68k/helper.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 15547e2313c..136159f98f2 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -52,7 +52,7 @@ int m68k_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = cpu_env(cs);
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 
     if (n < 8) {
         /* D0-D7 */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 4c85badd5d3..9d3db8419de 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -57,15 +57,15 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 8) {
         float_status s;
-        env->fregs[n].d = float64_to_floatx80(ldq_p(mem_buf), &s);
+        env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        env->fpsr = ldl_be_p(mem_buf);
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
@@ -107,10 +107,10 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     }
     switch (n) {
     case 8: /* fpcontrol */
-        cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpcr(env, ldl_be_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
+        cpu_m68k_set_fpsr(env, ldl_be_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
-- 
2.45.2


