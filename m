Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB75E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9Zn-00086u-Sh; Thu, 19 Feb 2026 14:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zm-00086P-7N
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zj-0007f1-QI
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so980649f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528834; x=1772133634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PDhRTW7GAmDuTAr0/yRpyrzR0th10/L/WUOf8KgycY=;
 b=obrEx4477JqtnuKmzeDXJe716HrZXY9p6CxHD0PlhdqqP3Z9WjIBZVTjy51FCobzTL
 ZBz6rgvOnRL9VTo/fzT5tt7WvHjamUBT2s0wx60BL63Bn5TwZLZSn22Y92y50EgRQ6dp
 hx58OZGPCczL9S5pD4tZZXeat3Yifj7JI6BB8Yuo6sSQr4Tv3vGuceRmAgXPaWnZ58OB
 +hgmYim7F9qUtUWXo5xHVkX1/OUE+5zbA34Wgl8pdIXvVCKXsg/2R80lV8SKpSrUq5ya
 TYDP+CKeB4nPsBLSclDaMVeT2PXSiLFBY0xSW0WCNMV5DjIDAJGl07BL5pL2VnNeQBNw
 v1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528834; x=1772133634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6PDhRTW7GAmDuTAr0/yRpyrzR0th10/L/WUOf8KgycY=;
 b=HtVob7uuxyRwQZTnXjXrdPAp6Shxmanf2q+znD5H4jAKb5sJ+M6A56mRqMEUYv1049
 Kad4e59NXuJmVzEXLA7veqZ74KFAnpsZ3sZNr//W/LEoEzD0HFCGdYH4HQWQpknr4vTb
 zmzATiGKa2dz89H6MT4CQKD7oMSq0iWNEYpmOG8tbY34MrlgFuz4SuSqSuGWKJf8d7vh
 nGtkunJ2UwLDZifuyFvf67h3VD0QpsZGB7OJU+6nMPkpeLk79BgOUg04gp37Y5xHIY8o
 zqzWfsgBrsTI8wW6n6Tk4Mg7ffzgTycB26IDq6HD+cifHn3rLoJ7EYbYjtCLl6PN1nC9
 dNcw==
X-Gm-Message-State: AOJu0YylQyha3IZrOUUCkGET6Ia45GtzGna7WOq3ZoRZ5Ki4BPZxk3L1
 d1Sce4qdSjUkmVI4JztcfKDo/EXO0umCszI8KVpUaPn2t+ASGOt3kt5fkE8ha+jcVtahcx3kICn
 xYgqdr9clsskf
X-Gm-Gg: AZuq6aIlDNRpvW2sEY+2Y/0ekDDSJEIlAC8OQ+yQ1NXS7EQEAtsJxMyiI0R46b94d3B
 3mMwFyj1HaTV5+f3KOlrCmSD6nMxzOhe9McVRiqLowPMtTYHEkMkuE9GE4eykwKSTGNxDfpBADq
 jyrBAkKgdDANXIWHATolbuAkA4IGyIZOkMrJZ5VYjx081PEG8pJ0ubYtpJiA8h6p6TVmCXoJ1Po
 /wPHgSaz66VkRc6tl7zkcJwglaQTJcPmExDizHMWruzRJUS087zaJvxLmgmYfGsml8RBGelBg8Y
 rkGmew877KnTV2mV/VKrM3dcyAk3t7a8xgTWARvgWROoZxNTp3M68s1/yzgMNJt2OBWo2FEfQpx
 ie0Kkq4cmcxpdYMerWOrTEDf5MXDq/D8mqOT+kaOlEDyja8LsRip+qO3H23oA+DkcMovKQOEJKa
 SM9n5fYZ8y4cp1rERMewcIZgBeeA1I8tHIH2BPq0NnfIRtOFFpdnKAdzLOTsoVyhywhc05pGuy
X-Received: by 2002:a05:6000:18a7:b0:437:6dac:458a with SMTP id
 ffacd0b85a97d-4379dbb080dmr32659457f8f.57.1771528833850; 
 Thu, 19 Feb 2026 11:20:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5f0sm49463838f8f.11.2026.02.19.11.20.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/50] target/alpha: Document gdbstub register indexes
Date: Thu, 19 Feb 2026 20:19:07 +0100
Message-ID: <20260219191955.83815-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

Follow GDB XML comments. Re-order switch cases for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/gdbstub.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index a7110e8d1eb..7722eb46806 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -31,6 +31,9 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 0 ... 30:
         val = cpu_alpha_load_gr(env, n);
         break;
+    case 31: /* zero register */
+        val = 0;
+        break;
     case 32 ... 62:
         d.d = env->fir[n - 32];
         val = d.ll;
@@ -41,15 +44,12 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     case 64:
         val = env->pc;
         break;
-    case 66:
-        val = env->unique;
-        break;
-    case 31:
-    case 65:
-        /* 31 really is the zero register; 65 is unassigned in the
-           gdb protocol, but is still required to occupy 8 bytes. */
+    case 65: /* former Virtual Register (reserved as unassigned) */
         val = 0;
         break;
+    case 66: /* PALcode Memory Slot */
+        val = env->unique;
+        break;
     default:
         return 0;
     }
@@ -66,6 +66,8 @@ int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 0 ... 30:
         cpu_alpha_store_gr(env, n, tmp);
         break;
+    case 31: /* zero register */
+        break;
     case 32 ... 62:
         d.ll = tmp;
         env->fir[n - 32] = d.d;
@@ -76,13 +78,10 @@ int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     case 64:
         env->pc = tmp;
         break;
-    case 66:
-        env->unique = tmp;
+    case 65: /* former Virtual Register (reserved as unassigned) */
         break;
-    case 31:
-    case 65:
-        /* 31 really is the zero register; 65 is unassigned in the
-           gdb protocol, but is still required to occupy 8 bytes. */
+    case 66: /* PALcode Memory Slot */
+        env->unique = tmp;
         break;
     default:
         return 0;
-- 
2.52.0


