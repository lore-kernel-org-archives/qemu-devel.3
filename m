Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76D1CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd18-0000kG-9A; Fri, 21 Nov 2025 21:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcUc-0000ab-DA
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:32:50 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMcSZ-0001Ep-2H
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:32:45 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6431b0a1948so4387126a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 17:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763775018; x=1764379818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vESko8GQ2ceP2oMkbBNKvzIYyYx9GKCYINNyOwGklUg=;
 b=yQLHSJ9VSbXQSo+w+5sEEmjcZ+oCtFAwyF8hSCdY9DmduJ3epsj1etdoVs6a9XZ19X
 8F+yVtqm7B8M6wc9N5KMIVy3OoYI1pb+eHamSD2Um2Vu2UuT0vB/J6kOMFQ/aN00iZOd
 qI+s85vD07amoh4uMWJ4OJf1rX7TL4rpaOcq3154mFxE0UhmSS51DcX5ZNCfDryMfLhT
 CJrlUJpIEkc62C+QLRt0AsqMMS1MStr8et6ulVIOW/eUvH+dJ7lcCxb7zDQeMIMM5gZd
 S3hW4S5Snd+xDB1D/0qJ4argbQbLJaS5niyaF9pbA1C9Mb/p3oW4GHVjhCXDvshIU1di
 48xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763775018; x=1764379818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vESko8GQ2ceP2oMkbBNKvzIYyYx9GKCYINNyOwGklUg=;
 b=Or3/zbum+A6ZMyENhpWVM9ht/46GBR4DZKcF2pYywuI9oAgDulVXnDrjpRDlWvd/a1
 oUZ1yABzQNfo7d9+ESVagm3fDSgiTVp32OMjUzrLSa6m8zsOolKxU8zobaki4FPjdlNE
 CLxQuLBthnJhsGwfNHEaMk4kILVs7kpHIB+n5DQo2CjZ9tE7XKLNcjZru0vm7+wmKgaB
 0f8FRFKq0jE3jdd8+RkSztNFka+cF6cHEFtnaPabGbovJaF6C7R1KvYNqIK4BiZcsPQx
 QjCoI5CQwzinLNFFP2yCNqD/+DuBerZ5zOmwbrWmToBsdL5q320nbEqQziwwardl4bS0
 YDRw==
X-Gm-Message-State: AOJu0Yxo7mCwB0XT2uAKLUQGDNA8vqeI5uvpN4nGWlGxLV5QZeL50zFx
 +YE5cDM8/B5G9MIS3rKZ2QgQfd/ydVtoEIiogUt/9ZexKfYycs3z03lelHKaK9FoFjcRN2OltsK
 mgJWoCQy2Bw==
X-Gm-Gg: ASbGncsrc2iWrTcdr0YudGTBhmwRkjfn9sllW8lujpJnzcC2jJwkJIuecdyIu114vem
 p/GBZseFbGCRXuXe3v4VrG/XCZrEUA1u1d4JgYUv4tCEa57rqHAyrvx/tDzDRPj7Z51JCBErzxY
 r3NDbmPrQv4pwZEz9eUfL3tLPg0oW1scJ0Ek4j1oXA89tHj6vw1qgqVtJVrN6MgkXZMNl9tvud8
 AOWKCyVbW9ovZeM5TD9SKBlmCzl4CJ1X+gRN7N20DJW87sPs+GkUm10LQcZJpR0a+N3wUESEBTE
 vh46CD4YJRaxkuEwffjs2gOrHhUjzxvRXJdfhg2w0HwYvB2+fvXysKMv9aMN6QbmzK6j6jb/Naj
 zO599V/gVXG4RA8hzDBbr76g6i5GIVtdjiSeIl/ngzLGNDzrvSmBA2VG3dVi1Eap46slQ5qC/8k
 xHfZhS3QROUCIH0NnZI83D9lkJATiO1HOw51k2Y0S7Sdt9WB5feTyXE4q0op0w
X-Google-Smtp-Source: AGHT+IGHTqgyl1vrXL3wcw+ANlMLiuuycekcVyYOBzjuSrK6eO43371ZUi+5CO6J8ZKFoSmLyQgWag==
X-Received: by 2002:a05:600c:4f83:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-477c01fb88cmr27959155e9.31.1763732772260; 
 Fri, 21 Nov 2025 05:46:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3af0e1sm42006415e9.10.2025.11.21.05.46.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:46:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 10/21] target/hexagon: Use little-endian
 variant of cpu_ld/st_data*()
Date: Fri, 21 Nov 2025 14:44:52 +0100
Message-ID: <20251121134503.30914-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

We only build the Hexagon target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=hexagon; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/macros.h    | 6 +++---
 target/hexagon/op_helper.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 088e5961ab7..6c2862a2320 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -519,9 +519,9 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
 #else
 #define MEM_LOAD1 cpu_ldub_data_ra
-#define MEM_LOAD2 cpu_lduw_data_ra
-#define MEM_LOAD4 cpu_ldl_data_ra
-#define MEM_LOAD8 cpu_ldq_data_ra
+#define MEM_LOAD2 cpu_lduw_le_data_ra
+#define MEM_LOAD4 cpu_ldl_le_data_ra
+#define MEM_LOAD8 cpu_ldq_le_data_ra
 
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
     do { \
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7efa..08db1e9c56b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
         cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 4:
-        cpu_stl_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 8:
-        cpu_stq_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
+        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


