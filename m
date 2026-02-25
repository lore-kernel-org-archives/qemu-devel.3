Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF53FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO6o-0006zw-37; Wed, 25 Feb 2026 18:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6V-0006h9-PF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6T-0002nX-WF
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-43767807da6so148727f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061335; x=1772666135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mgh3pXx3/FXyu63G+DeVDmfrgJg//6Ux80N4glwlmy4=;
 b=QgtRles+SnU/LmZswTMolNARJvOtuITTHWrlcjGKHHaN4CTeUnHdumLZQVy3TxmISX
 Kw3wk9dQZUrj7UGl126go/tO/bi56i36Js4AH/xyseczMmodhn7MZahvxNyA3aYrHbPI
 ZWUtkp7r8zUQoCo4D16+9kst3kBlwCQ67Bpcv17J3TQ5mqzjANknTzM/MA2TOj44oYca
 Cr1GHUc4TWbA5NokbsOD8x+ZpputTZrf+B8FWgsYLaf2vQL5EtMDz/Z7JTu9PeFt2kFU
 ngD+IIW0tHR3rV88Gi7qwyAPo9hd6VtXXfo7u8g/UoddcYCxeFpZDFTt8dcgUp/GmqmG
 iDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061335; x=1772666135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mgh3pXx3/FXyu63G+DeVDmfrgJg//6Ux80N4glwlmy4=;
 b=hf2gVzdpUZr2EvkidNQvbHcte1fnHg5C1jHsc3AIgCZ/MRn5+fIlLu0uz6M1FosZNT
 pwN/TzoBJSBQ5hCvjYDSttRgKwHUMIUSDC1naMfF+tEXK3+o7x0B0FLcjU+QWE0f3AMJ
 iWlouaklq4X8f7BIcCozG5QU1jBoSvI+215UuNpI0j9zf8XpUnWZVl4YLbMDnk6ETj1h
 iXfm5ejLTGleLLOzFkos2QdYVT8nYtUAwitgEJGJNGeC+Ih6O9ohtsAkKHgTeo82xmnb
 I9KJUFt8OO5caOlNFZO4/nZ6rz9NmhmJ3+jZz7g76AJeIkhxqbnfxsEAEqy6zZoQNPi/
 x0tQ==
X-Gm-Message-State: AOJu0YwEtFgdQ0/REuFVni4xYkRlFfTpDClun3wOz+TY2YILaa3ZjGS2
 j1+fqmU1O5gxuZywzcQ9tHG686gEyqsWZma12dtmoMP7b582QAeSFJglCp8IZ0m2ssXT6zwOi55
 e6oHUx7nZVA==
X-Gm-Gg: ATEYQzwj2ZcmaNE6R+RGxMAIFmrdwntCZ/LPohpBoITPupGDI1VJFcPL/DrUybWdh+Q
 NYVktl2rQu0fG+KH8qplNEsiaDMOm88NW6+2Ky51xp+U171emhldALBKZkYDVn831gomwU+rKZ8
 8qdmgNjwARGBJANM3AsYR2Sp4VuuJ8XeHVchHejXlALzByWBm2aNdm6kIvrUzUZiIOXVWOFmi2q
 1Yw7Qk+JCsropkMNcCp2WdA4GmT8yCPeAA7PITOkGiVmUgkKTlZMfJMwDKOTnLzFKNsh0dwJXM6
 PcHbcGgQQd4QQDvuUExcNE86f7AT+Zghk5gjLwvzmlceSdAZPd+Dxs3mZRMv829tBgtH+f4e0K5
 18cCaVETAeVvqYSDR8h4GImF3sMPt2QXOvzG7002bzTG7Vlx0Ea7GR1ymlr8n7YNMWPttqzZiAv
 i/QbSM47jJfheLTr6T56K4bYx1tuDr7NBoN28/yS2LQw17e93Cx+4AR5HHgTpRJ99n/8oMiGkc
X-Received: by 2002:a05:6000:290f:b0:436:2f66:5d1a with SMTP id
 ffacd0b85a97d-43997eda5d9mr616441f8f.8.1772061335463; 
 Wed, 25 Feb 2026 15:15:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c982sm36934910f8f.31.2026.02.25.15.15.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/70] target/alpha: Document gdbstub register indexes
Date: Thu, 26 Feb 2026 00:13:12 +0100
Message-ID: <20260225231411.96482-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-6-philmd@linaro.org>
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


