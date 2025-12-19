Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9811CD7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdUR-0004AK-29; Fri, 19 Dec 2025 11:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdUI-0003sh-1l
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdUG-0000XG-HB
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so13041105e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162269; x=1766767069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=m7MyR4wigTY6kksUbDZu83wAT1LxTCEmOXNetFq/vXMuVHwA8Sf2jKR/ODPCjbBbF+
 YkuwShgPtGDIvN1iP6WR7OQql6f5rt4VcvS1uo0fkJjRPXRE9K0aO6IjuGbA09n1ggOb
 RPgjNsfZejwP9H5Ff9Nq6BYU3a6l7ccCqrBkBdLjVFv0MD8MArssJVvSWfxQ0WB7DQou
 chTUNRyEVox2XCfOeqtCPgWxmSkof+5ciQKA+cjwmXqlTBjK0d7SWJ6Fu3SB9+AVvN6G
 dDzHfk0F2e33GzLoOpF6vb8xzr3xhtB4sAP7r4y1haPoiiFxF2yH/BlX2NHmug1UeBDy
 e+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162269; x=1766767069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yCWaAKr9HKDQPOGDVeV4ELgBSGxrVu16jLOCiFl1Ing=;
 b=v0Vst58Su+mXfRoyfzJc92G6CNRqAAC+YAV9k7JKkgDgWJR/PDhqRnx52W7rMdL5IB
 RnsPKZB0iC9CStv7P/VbX5CtvaokGNGSfRpQ+tixMLlZ5pHLQceu1ZG07cfPus8H4HFu
 +m8bB+Qz+7CBLFL6lg/pqoOkSIsJsCJ9roCIvJGj8BplnWvxIY1LIg4wblWIGUh9P/H6
 02rwtny8NKNOAWWeWKVGheUTZvGXR7ahNGBSXOL4JbWlwDSwdWeCxV9YuYeIaWJLI8jg
 +UxAC3nHiQ8bE1ao500Sr/Ku3eLWfSGq5nYIpbu6HGI9gNVKIvfvqifoilNb1ki/jtMN
 Lvrw==
X-Gm-Message-State: AOJu0YwsOzo26ddjf5TzZZ6DEmarYgv7JKtt5w9DVSNGI8f3iGjpNxDb
 cekxtTnsvarRjuaIepEBmNtVOX2HfDxHkJv88TQRleQvF4C6axf3gUAfWZmZSKWgtn0n2C3iEh7
 yZ/58sJw=
X-Gm-Gg: AY/fxX5QCuo7rIK5UwjcZG9puyXdsi0C5xkW4weV6MSa/f2kiUdtGD989Nig+VfbmOw
 XExiVvHgewCrmC1I1OE/KfN/HME0WO197VdFPpuhW4IbU6B3Y3u5wU+4zcw/Kgy5llNs/rggPzX
 nMr6DrL3LfxUvIT/qSZu7WlPdFyk6T1h/A0nZvRyNHX93hQvNPfKenrE2puoOlRYijbYgma37k3
 BXfoeVPxviIH9E3OtvF5n1OhqUC6YOICoMT2DXlvXKmLSDCMiKesp5z6WGLlq3byr43XmKd8E31
 UT2Axj0+SccCk1qVP7BLnehgx8u/dowiB9mxehHBU7sGiLaj6OQPeAtP3gQ6URJmhaPb8bJzn2I
 edYRuL1a023jvNqBlVv5Q8Qanj6V7Si54IHFI3jo9pjGme5DnxGeywgSVwAdzUlIk5tgNAbvxKb
 PuiltczZb17Hv+380kFYktJk2DPharZdCbPc73Nn+yFg1U6ymVXrdZXs1D799l
X-Google-Smtp-Source: AGHT+IHS3o2ne2jByPhxFqzTUpZuP1OM+2Lt2dFxexatKapa1bDWoGL/OS0cQYAiHj2a1vDa3NmVcg==
X-Received: by 2002:a05:600c:4e05:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47d18be1546mr36811585e9.15.1766162269385; 
 Fri, 19 Dec 2025 08:37:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm50782315e9.10.2025.12.19.08.37.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] target/sparc: Simplify gdbstub
 sparc_cpu_gdb_write_register()
Date: Fri, 19 Dec 2025 17:36:48 +0100
Message-ID: <20251219163650.74303-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Rather than ldtul_p() which uses the underlying 'unsigned
long' size, use the ldn() variant, passing the access size
as argument (evaluating TARGET_LONG_BITS / 8).

No need to use #ifdef'ry to check for TARGET_ABI32, since
it is 64-bit:

  $ git grep -E '(ABI32|LONG_BITS)' configs/targets/sparc*
  configs/targets/sparc-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/sparc-softmmu.mak:4:TARGET_LONG_BITS=32
  configs/targets/sparc32plus-linux-user.mak:2:TARGET_ABI32=y
  configs/targets/sparc32plus-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-linux-user.mak:8:TARGET_LONG_BITS=64
  configs/targets/sparc64-softmmu.mak:6:TARGET_LONG_BITS=64

Directly expand to the big-endian variant (with the '_be' suffix)
since we only build the SPARC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 134617fb232..d265681f6d2 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -112,15 +112,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-#if defined(TARGET_ABI32)
-    uint32_t tmp;
-
-    tmp = ldl_p(mem_buf);
-#else
-    target_ulong tmp;
-
-    tmp = ldtul_p(mem_buf);
-#endif
+    uint64_t tmp = ldn_be_p(mem_buf, TARGET_LONG_BITS / 8);
 
     if (n < 8) {
         /* g0..g7 */
@@ -170,7 +162,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #else
     else if (n < 64) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_be_p(mem_buf);
         if (n & 1) {
             env->fpr[(n - 32) / 2].l.lower = tmp;
         } else {
-- 
2.52.0


