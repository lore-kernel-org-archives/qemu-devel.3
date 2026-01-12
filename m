Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9498CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkB-0004YF-Su; Mon, 12 Jan 2026 17:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQk3-0004K3-EJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQk2-0002tI-2K
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so75820045e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258228; x=1768863028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mINH6M7nng1493oAgY6IBRpu8wBUUifHNGaks61qUKg=;
 b=Ufcaw4nE5Msu9xbYOE0oBM/OyDCSE4nOSYzfQhXanYVmtiwfh9QNGrrsVQIDib3XVK
 xXZ4e/TBNUhtSWZEF7vJbagD7I915RnqZ/EpUzumPgUw7iaas5apkFgYexqTUZyzMCgw
 Zivgyp/nsnSINaNtOm5CYeI5Wm9wletSzyqwzIXWRSNZntYWqgqxZdA3FBUSURAgv5IP
 +5Ah65prIW2OpqklJw0S4u/LVkK6MFouk4U/kZ62JuRUGHqWgewpPBOkwUZi9XZQCgBs
 priMDgtoW+x3SEAXCiiB8VUHn/FcARtUBRkjie7Pa9dXZjKd5vDROjN/pehNDLgMOsAc
 N6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258228; x=1768863028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mINH6M7nng1493oAgY6IBRpu8wBUUifHNGaks61qUKg=;
 b=B/VgMs6ZLHRymDNSi+r4DN0uX1Uqdj/KsJuoCAHmrqu1YBKrw+TLcbJ151HX9bbGPr
 qhp3J2UKGop9pogdTaU69SKP5jxqkB5Ys2dCbwN2LeUcx7X5Yo+GlcfaUvvvMZ1ep7VO
 FffZZOZe8B5vzrFVN6SjT5OZqRoJIGq4tjhTHQY5qM37rcejTHAUiyMczxzA7p0XPB/a
 Qq0dmEa2OwTtvesQ6YwmkhfnuWgBuZXfCQnOSYiJw7uUGaDT3OvlqkupejjuCEgaV4su
 UbITatS7DjcawiRPUeRECsLp4t8gd2d9uvChzLwPh/uCNzDC+RofRTYBnt4f15vEpYPw
 0vlA==
X-Gm-Message-State: AOJu0Yzfr/EPJNuCC5rPzj/IKEXDRqoF2tx0IeeHcl+uTnIfnO299J7L
 jJii5b7Lf4p75zXZqkKvPJhr6xw8Je8yuGFbyQla7L/Q22Thwzp7XWxN43SsDLacvk73V1KLOSr
 s8CQlzc0=
X-Gm-Gg: AY/fxX5uVaLKcvONrQZ8/98JsBXGoVNKjokFYD7O5LSwFzSlXizpinnQmLU6pmLrdUD
 XDTTJYh7d6TG1yW/FPSmkKx4FFqXUIaHyb+ppXN0pdDFJbiqev7lwRkHR23oDXYY4EOKgLToqvz
 m16Gf9A/KAVwpFqYjKpnuZG6LgiIPhGQiQQvnEvYJn157ngxKnQdKZ+A55tjpyIxsa+CtWsKyEg
 JWC91lisuOo2bfgzYEbw8SLV5SdUGJ6GKxVPftIjneI8h+IBR5xxCT6m1NxmYMPcpycCju/3/6y
 F5urr8tXtm6FD4/g6cxZ34UIiL1ed+aKEPNJoeuaoSzwBavzCo3LB9f2HNnJ61do/4elB5C11lk
 vrH7Z5/W9ZPBe6cqyVwACcmbcqJww0J0xdY28LJDlyDBuQHjkjctCj0rcSw9QkbS4C3m7MQeDxl
 Vf7fawuReT+hSGtdaQhvsE6s/eXpTMw0CyJW8zLwCJB2H6Ef6We/Ttm1Zl8WTV
X-Google-Smtp-Source: AGHT+IGqm0nQfk+a28QgRHhNZ3s8OZOjErRCby1nrwnq2Tllu+DshkcHK+Uhdk1rLWvXyyXN2EWINg==
X-Received: by 2002:a05:600c:34c5:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-47d84b3275fmr265726515e9.24.1768258227730; 
 Mon, 12 Jan 2026 14:50:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm367717425e9.8.2026.01.12.14.50.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/61] target/alpha: Inline cpu_ldl_code() call in
 do_unaligned_access()
Date: Mon, 12 Jan 2026 23:48:08 +0100
Message-ID: <20260112224857.42068-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
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

In preparation of removing the cpu_ldl_code wrapper, inline it.
Use the return address argument.

Since Alpha instructions are always stored in little-endian
order, replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260106155755.53646-4-philmd@linaro.org>
---
 target/alpha/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..572ea9cb418 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -24,13 +24,15 @@
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
+    CPUState *cs = env_cpu(env);
+    MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
     uint64_t pc;
     uint32_t insn;
 
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_code_mmu(env, pc, oi, retaddr);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.52.0


