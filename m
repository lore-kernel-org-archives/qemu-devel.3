Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB5C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59QF-00037h-LJ; Fri, 11 Sep 2026 18:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QE-00037Y-Hh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:38 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x59QD-0002H2-10
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:08:38 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f4e729368fso1549389a34.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164516; x=1789769316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FlYU++VZ36XrURfV9zayG6TRI9jMCa2vNXzMZcBaP6Y=;
 b=qJRl1XbtWOGEGO5dVKwEKcfPwpyKOfy7hGzuHgADttzddNu406/S713iKcTs+gww2r
 hl68jsyL+hxf83o9rHIiQKrDGYuF1KKyD1D0w0qA5ZO/SAH6TLmM+W7M3RsrnlkQ/4Fi
 TK0vxq007Ccu2u6JY/5Nez6O1bzor0SGMfZUyq0oCnde7s57uT3Xf9Bf/xfm4/dlp/3s
 8q91dbsmdP+XqiwoPfa3sTO9+iMupmLnw2tvdLbtmBp4UOudRcRuocsSOT87t3v4gIEr
 kChz+FwxbMyfwaMC34S0xeKS+UtT1wfI2Pe3Dpgcrdbb0WEgX+XpNNKJG9FcKnHHwbtK
 5Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164516; x=1789769316;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FlYU++VZ36XrURfV9zayG6TRI9jMCa2vNXzMZcBaP6Y=;
 b=iNTsGlxGD9uVgcztJ0A5JGeRWM+G+jQPkpzyrWDkEWV7gC1vM1/iMSZS0CdDgaPCBs
 gfwmBpxfsmEsC2UznQvZjcq7vPjnHDH6Z1F6fZb/HebftlByRl8OGVbd2Ogat+HbNu7D
 fADXRucoMGgN3BsTxgCBLO6ElqYlo4Hs8Z92FGb0WEorIhKaUnzZe3yfid+5AEb6QuJ5
 FDrQJhoAFz/G1TP7KL529lV2qwnwq0XdQlHooVe/GoOmWEFSBpUGscSp7xYXTq461Xkf
 v62V0BdAiVUgD70j/7GAojCTSYZzBWIs+yX2PhnEZ2fptgNQKGijb8gjHBRrMaswIOsz
 Fkpw==
X-Gm-Message-State: AFuF++meRrlwmkg7RuCkcJm3srji5ztbpY/a3rVs4C21Qdb/0WubtNy9
 Hw56pL9oZxfIT69UVqXjzRVhOpCi+TkVeWjvaXXkBZW2qBogsKu9gihHFZGiuJ7J
X-Gm-Gg: AYBFou2IqyeLXQiyN8myyioYjbZMzGLWD+0nPA+tsC/aFCXP1KGUcqsL7bYbQgTuo1z
 Q58cY9Wd1wVU0MXUxab5sVD+74vJ44Dsna32De+fZgY62195zDml92HSLY0vmb6Cmm+iBqpouBK
 5omeKForwvJ1JRbFDERGb+7CPFPsOXTRWq/2Bl1GmNsQ3YgCxd788CNu6UfzYFXfco9P1l/00Wr
 28l7YYkjJ/SG/RepEfazbW70e7PcIuCk9SrwfRM9xnfXLpyl6HAlHZRgfLQ2e9k0p8+lPHDGAVh
 iWRPXTCciBy0FbsYZjw7kKXyo/Rm/ToxqpLqZYDUvGh9m4JIaSofQlyhdzR8EJUAvXoO0ld3+Xj
 o1F1eaqGYJ4ZakegkR/i35DK2QF1YUJ2YqdEcFzOerglX2Z8Lw6HF1vFgDEWh0rQ3PnUHnndGKZ
 yiOZoTm7wOVZD6fAIMeh38W7qN3dAoea5qudZDaEgBGuqUMA4/ECeSr+DEbBOz4+b1CExQ6HseM
 2hM93F9lZMAi0btrO9YA9GpwxJF3e+Zfbs4ony1hLP3Pn6gHuPj8o7Xz1zRiY8jDg==
X-Received: by 2002:a05:6830:6181:b0:7fa:ac4f:793 with SMTP id
 46e09a7af769-80401760f38mr5025875a34.31.1789164515855; 
 Fri, 11 Sep 2026 15:08:35 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-804de582afcsm1889193a34.16.2026.09.11.15.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:08:34 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
Date: Fri, 11 Sep 2026 16:08:20 -0600
Message-ID: <20260911220825.143115-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/multiple-writes.c | 46 +++++++++++++++++++++++++++++
 tests/tcg/hexagon/meson.build       |  2 +-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
index 4305903547..b93f2ab32e 100644
--- a/tests/tcg/hexagon/multiple-writes.c
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -199,6 +199,49 @@ static int test_post_increment3(void)
     return sig;
 }
 
+static int test_vreg_legal_predicated(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r2 = #7\n"
+        "r3 = #13\n"
+        "p0 = cmp.eq(r2, r3)\n"
+        "{\n"
+        "    if (p0) v0 = v1\n"
+        "    if (!p0) v0 = v2\n"
+        "}\n"
+        "1:\n"
+        "%0 = #23\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r3", "p0", "v0", "v1", "memory");
+
+    return sig;
+}
+
+static int test_vreg_illegal(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x1e0361e0    /* { v0 = v1 */\n"
+        ".word 0x1e03e2e0    /*   v0 = v2  } */\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
 int main()
 {
     struct sigaction act;
@@ -224,6 +267,9 @@ int main()
     assert(test_post_increment2() == SIGILL);
     assert(test_post_increment3() == SIGILL);
 
+    assert(test_vreg_legal_predicated() == 23);
+    assert(test_vreg_illegal() == SIGILL);
+
     puts("PASS");
     return EXIT_SUCCESS;
 }
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 4a2826c427..08c6e34c20 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -54,7 +54,7 @@ tests += {
   'load_unpack.c': {'cflags': cflags},
   # Build this test with -mv71 to exercise the CABAC instruction
   'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
-  'multiple-writes.c': {'cflags': cflags},
+  'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
   'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
   'preg_alias.c': {'cflags': cflags},
   'dual_stores.c': {'cflags': cflags},
-- 
2.43.0


