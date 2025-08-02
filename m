Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7776C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLSc-0003f3-Py; Sat, 02 Aug 2025 19:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSQ-0003Wd-GG
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:08 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSO-0002Tk-0N
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:06 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741b1fe0dc7so50877a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176562; x=1754781362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ac5U1ZjOBvR1Fua4Opx4nZaR3yDnqonHoG3yV/Hdq8M=;
 b=zIKCi2NeApEIJHFjKa1falzu0eeJQejVbZO4hXHio2Xuo7I7Gs9VzTSM08qtOYiomq
 YTnO8cpkdRBGaHNTY64o0hoTe1f8ElKLnFt7sD9YgWPUuB6gv7tGvjIh3umfs0rp415U
 KqT2HSU2hd2//0Rj5HPEEcPZe+Vv7bHS4Xrxjy+/8Po/eG/6F5J9khUKYiB/zRDWIMBe
 thGtTL4QlDiuwHWPlCbJycRqAEIlZSwzm8ghvpwgoZ01RVc1wY/CpXX95RzyZLOEwSF+
 PNEsq3DBtHDGo83I1OVdwbWqTSrmvQmSNGlLU7/k3Jiou4tcK6FNPk77EVsFZ+ATpf/O
 EMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176562; x=1754781362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ac5U1ZjOBvR1Fua4Opx4nZaR3yDnqonHoG3yV/Hdq8M=;
 b=ior2bBag1+p+f40jC/yNCH3jU8DDbe3DNxUB4qBxBCc2GXV12l3XB79Jq+t2+zfmxO
 ciE0w7t842vBIFEhhWkRLCjngCrkHArkKWJtsLGAcp2qidj30+X2cCKuvsDfk4+4KUNi
 K1wbg2X+JXfpGDtuD1Ro8dK6qVGnJAOxMQEH6/I3gZ53rC06Hq+x0QoeUPC0ln9/GZlU
 BbJBKchCW/XJHWIIvb517F+5hGMAowTKldcZl31JsA55dPwjEVUvgHBhimT3NP02WOiE
 7nBAUhDDzKRP230DHyoeLGpiIIIdARtat0BGUH8ZsLvNKG4R76v4uJYrOJHPW7mXXuuw
 6Vow==
X-Gm-Message-State: AOJu0YxJCBD4V41/dl8YIt4s3RBBkoVSWfdKxTDI2UYZjXjiv8+qEw4+
 x6z+BSWDdvxW6vw95BcRH8xNt0LSSa3wUx9b66OTV5TTUYNhnZdECw7ZstzHgKQYOC0i5qI4ZmV
 GXa3q1mM=
X-Gm-Gg: ASbGnct1hJXm42eYyNnDARzvpl+tFI1itfuxsX4v0jkpm8/y4+8xVa7QpmKUvOlmCqJ
 DCnhdrZFSFOvMGxQVQN76fwO4G4KOOdgPX7kYVqMP1nfn5tABGOvh5h42nXcWVOrGm0wFsUPafl
 4y/SbQn6tQZwFi/74mu/rT1D1PPEryYR95sILg57Ir90nZVkVlp5xrzTGM578dbgaPJQZWB38uA
 8qPf7gX0KyGqTDsHe4xz7yrMdEEBgDIdbdjsjG0Gpfme4X9HJK4WGYzSXdMSBDr/Jr+nRX6vEhM
 J7uQD4LMnB4KVl7lz6VwxCtr+ECQddnW3OFbYN6MjD428QjewsPLmf8hLPfRsw+8bGUXuowYHx7
 YA0QV9tp3V+7LOadaQTqJaH2KtWGkhMeT2dQ8MLjeqvDx9S2zVj+ewxhMVhzgIVw=
X-Google-Smtp-Source: AGHT+IEOn9zoWX8NLDtVgGhKWI7cqfeN5lQLcTav6UiZ+3FacfZ3fdR/CQxNbfVrtWX1yMtPdvJ6Bw==
X-Received: by 2002:a05:6830:438b:b0:73e:9293:556e with SMTP id
 46e09a7af769-7419d0aea04mr2236392a34.6.1754176562432; 
 Sat, 02 Aug 2025 16:16:02 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 80/95] linux-user: Move elf parameters to s390x/target_elf.h
Date: Sun,  3 Aug 2025 09:04:44 +1000
Message-ID: <20250802230459.412251-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_elf.h | 4 ++++
 linux-user/elfload.c          | 9 ---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index f83fdbbddf..3d6317d14f 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -8,6 +8,10 @@
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_S390
+#define VDSO_HEADER             "vdso.c.inc"
+
 #define HAVE_ELF_HWCAP          1
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 729ce4dc19..1025ee5fac 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,15 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_S390X
-
-#define ELF_CLASS	ELFCLASS64
-#define ELF_ARCH	EM_S390
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_S390X */
-
 #ifdef TARGET_RISCV
 
 #define ELF_ARCH  EM_RISCV
-- 
2.43.0


