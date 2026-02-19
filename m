Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1989E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9do-0000qU-Go; Thu, 19 Feb 2026 14:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9d0-0007WN-N3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cx-00008s-N8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so10337365e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529034; x=1772133834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35EJSc4MAJTbE4qZx3wrJXdZgZzTvunYbbMbQ354pW4=;
 b=Izp9H5q+6wqWPk64Jum02XsGBR0lNwQWs+qAPdg6dLXEnW2K6/dposMxNcxNZIsVwg
 iVE3MMtu5iWqKN2ivsKoGabbKXaATSihlmJ88pdLODR64Xl+wGuXNYIGb/7y0+mqEFFr
 4H4LQvOEpSDEuCsueY027Qr/qnkJbcFpJQcVjfxisKAsTgACoSVMP5Hb2KY9KRyTkEq1
 0aIVH2nQEPrxSjbY0WNm9rzrpu0Q1u2V/SA1DKRy2GZXo9NT9z7WcRDZQhL+vejmgGph
 MrMLjnc6CWuLqVrHTRKvv0EjgW1SpxiRaF0gDtFk5iIRKgkGOzTTAQilJvtBGwQf19qQ
 MDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529034; x=1772133834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=35EJSc4MAJTbE4qZx3wrJXdZgZzTvunYbbMbQ354pW4=;
 b=A+/Qh4aG0x8a588Df/d2ZDNccXqN2yOI/4GRFWfhKI4s2nirY1ud4l0EU0ioaLs9JB
 8PIgpNTsW3lGH//FYNvkkQehibNxUYVATKRq/x0WzNWzXWnZaE5lV4uCHrpS33xfF9om
 J6g7kBl4rFooadsezCF34V0g6lzDvgAul3Vw0G2EKdedY+FdTf0w42hJ1SqdiYW7AUid
 +bbncYTPjSRGDF7vjiKpoQFz3C6zy1Ad3dgLVghTPSGb5IvBIJtuf5zLiecNp7NAFiOV
 QLx6f8pRaiQBgtHg81LZ3kLFSHede2fZEulPH3u2jXoXhEoanQcsSey4eY4OHbFHM/9L
 aAqw==
X-Gm-Message-State: AOJu0Yxx3tsO5pZRkhAixL9JMYfiVBE1Ohn8qAV6OZPiw9BwA6ZN7gd1
 RYYAWfc5Vm8CHVZjuQYcDf3xM+aphqU0N4PB8tUBlqD6Hv8j4hp8DpruyzGZZYrgm/YWHWMyrcY
 g0PAElKkmhA==
X-Gm-Gg: AZuq6aLgxITcggV67uW+fupaIbC6js0MDVhzadEt9fF4GmAF6blTa/CGzqOmWknTaDe
 8vCRiI5nxf3jpgwYMf9cLixLl6lqU7keTZnHQ5pTAjqcvkfSSXid29BL1mKY0l3q+EUpVqQgtc+
 uafAUDqOZkybjsW2ooveJiFWixyndzythqfACE5yXy4UXOH1aVcextXkC327/WaXu0yHdSjbJy2
 Kj/SjHySrEOJW3jmMZ4an9hgsdk96V5GpdAPXn/imOtEnd4xL3uB8m5Y8wOf6sxtELzqVn365Pl
 RbFvonvZUA0WQqwGRJ/BFkXou5CkBPoORQCqODwQvb5SGUUrGcyoqRFBYMMT45od9V10kvXdkKd
 xu5eDhSNxCN52XCE0u/Q6Q1gpZYyo+QwGCJPQKeXcrVP46cHEgXvSZ3eDAqG/ut3hqAybydomE1
 0pt92+M27u2SX23lAk6kgWfJQC3kyVBk4ITwLKqBDXknKJxL9y9o+nV1JMDtGF/TsPclsFEOIX
X-Received: by 2002:a05:600c:1f92:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-48379bfd727mr311617775e9.17.1771529033784; 
 Thu, 19 Feb 2026 11:23:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bac27sm23915875e9.5.2026.02.19.11.23.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 33/50] target/hexagon: Expand gdb_get_regl() ->
 gdb_get_reg32()
Date: Thu, 19 Feb 2026 20:19:35 +0100
Message-ID: <20260219191955.83815-34-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Hexagon target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/hexagon*
  configs/targets/hexagon-linux-user.mak:5:TARGET_LONG_BITS=32

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg32()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/gdbstub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 12d6b3bbcbb..b9856cfc978 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -29,11 +29,11 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         for (int i = 0; i < NUM_PREGS; i++) {
             p3_0 = deposit32(p3_0, i * 8, 8, env->pred[i]);
         }
-        return gdb_get_regl(mem_buf, p3_0);
+        return gdb_get_reg32(mem_buf, p3_0);
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
-        return gdb_get_regl(mem_buf, env->gpr[n]);
+        return gdb_get_reg32(mem_buf, env->gpr[n]);
     }
 
     n -= TOTAL_PER_THREAD_REGS;
@@ -56,12 +56,12 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         for (int i = 0; i < NUM_PREGS; i++) {
             env->pred[i] = extract32(p3_0, i * 8, 8);
         }
-        return sizeof(target_ulong);
+        return 4;
     }
 
     if (n < TOTAL_PER_THREAD_REGS) {
         env->gpr[n] = ldl_le_p(mem_buf);
-        return sizeof(target_ulong);
+        return 4;
     }
 
     n -= TOTAL_PER_THREAD_REGS;
@@ -81,7 +81,7 @@ static int gdb_get_vreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
     int total = 0;
     int i;
     for (i = 0; i < ARRAY_SIZE(env->VRegs[n].uw); i++) {
-        total += gdb_get_regl(mem_buf, env->VRegs[n].uw[i]);
+        total += gdb_get_reg32(mem_buf, env->VRegs[n].uw[i]);
     }
     return total;
 }
@@ -91,7 +91,7 @@ static int gdb_get_qreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
     int total = 0;
     int i;
     for (i = 0; i < ARRAY_SIZE(env->QRegs[n].uw); i++) {
-        total += gdb_get_regl(mem_buf, env->QRegs[n].uw[i]);
+        total += gdb_get_reg32(mem_buf, env->QRegs[n].uw[i]);
     }
     return total;
 }
-- 
2.52.0


