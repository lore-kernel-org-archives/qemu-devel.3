Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C095ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwh-0002TH-5S; Thu, 16 Oct 2025 08:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwB-0001p7-Hy
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvv-0008Q8-UX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-426ff694c1fso421625f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617083; x=1761221883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yoY8dHy+MRIsrCJAbFg9AUBDRefvmT0hUj0DgIJZDQ0=;
 b=TzaFRXZgGiyo50OruF81wdJM84yQcZCqnInrcFK5V9W232dQ2MOD9edTyjfHosZp6c
 8Mt6g80MVqTfHVSOOADMg/kcwoFliUbdl1QQuOOJIukMezx+jmKA9yIAm8um4VhpJ4eK
 GvmqVAT5ppNa0Ip/kaM3ueBTtzVin2OLdsDnypIcARNC81WwzCtLEV6Nm1/2hlzlVrMQ
 y/2PogANEWm75j1QakHfnJ/UjfljN/6tR2E58lDYVXIGRoKbZw06n60Km84escCf/LrD
 FhfSESOnjvUTy4ZJernIuOj6h23zk8q8AlGLNGTr60btxwlEUsqIK9b7PhKqy55U9LW8
 14rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617083; x=1761221883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoY8dHy+MRIsrCJAbFg9AUBDRefvmT0hUj0DgIJZDQ0=;
 b=mlJPpqgV0j7lIrWLu4ArU70gSvvSOx/RpclE+JQhOfWdH+e63KpZM0LU2kH7MpqUEw
 euhGp0ca/ddqk+1wucmpsDUZqaczIJH9UU7B8mGzxUuMYiVqxaTlJsDkYQL5wfPjLcr9
 Bbwl4p0nBMsORiXtN3A3dlIrrB1XhpoK/bsWlY5q6S8vP20jKLs9//hiJ3mqGWZ1Gct2
 wNjrZt6nNMs6V7kfWk5dkq33FyJRApcbf/ToOT88hSF1PFXQ5WLUeSWE/Nn3aZWZvIET
 wN68e0ETifjk65NHdd4vu1lUgj/4zA500sndV6aaKXg+3kZzsAxO+6rpLg3wPIgkCkDz
 K0cw==
X-Gm-Message-State: AOJu0YzYH2ZPqRtulQQ71Fhz8xsyn17K+oxuCT7Qblqnhje/oe7mg2+N
 /4qj6yc7EPBgLrV7kSmIVikfccISimSrEHFJYPTxtC11vmQw4vOhrVyl1d8CJsglHH6nAgJFp0X
 byjDz2xs=
X-Gm-Gg: ASbGncsZDieH0HO3jmUbb3Iqm9r+ZEw3n27F7spaDZalGRVOCkIoXSBoGrNIUNjgK9n
 e0Uuv4DrFA/IAzFJm84zzpeh7DfgaY2JV7RgedZWwTEo17OHvlkm7J9Ydvji2jyj6vVaVH7HkYP
 IrixkM/HnUfxe31XuCb9dOY2cG9UPnv6Zp2u8c0wEV1N49F+9mgNgqPXijTYEHpwNII80AqED52
 lUmNMn2L01Es2Hj7p2EwERw8dpcKGLO/EhTuexPZvAUo6TxAaMtjxL7NepXHX/QH/pTtn2n5cxY
 N1FBYmIG0FF0jrqfaeKSfK0Pv4neeAlCekRTX1UFrJlXPjAkmWsdoG/PBIwBi4eXVkfdxsiTRK6
 W+q0pZilp18A/5OKqhJ352tqoExUK0+EXziQ/cu/ZYjp3IGiWKbTqEaqARSDvwkvb32SoEp9KZp
 nkEok56hoW43OxzVwHmn4OJsBTYcreEXmTwOrJNkkz3hJqmds4QFMHzQ==
X-Google-Smtp-Source: AGHT+IEzUx6+2xmbnndCje9oBUFuafY8Uudzkry9ikhAivnadW2GpEixfgJvjW7b1pB/h+jnLVS0pg==
X-Received: by 2002:a5d:5f43:0:b0:427:151:3d9c with SMTP id
 ffacd0b85a97d-42701514223mr1242083f8f.16.1760617083330; 
 Thu, 16 Oct 2025 05:18:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm34153379f8f.42.2025.10.16.05.18.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/75] target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead
 code
Date: Thu, 16 Oct 2025 14:14:48 +0200
Message-ID: <20251016121532.14042-33-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Message-Id: <20251010070702.51484-7-philmd@linaro.org>
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


