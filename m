Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4268ECF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLIa-0005Am-9R; Sun, 22 Sep 2024 08:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHT-0000xP-LV
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0002PR-Hg
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so499936066b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006487; x=1727611287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCxOZrHA9KO++5sk9CI1DtuqpvUPuY/JWcvFhFjKE7I=;
 b=mwNn8+Y644GdGDEBNgAxDOApgMqNh0b9lntA4/aEXYeHZmd6aL5i5B3lAZfuZFcwhj
 qyktLSu4wobj7u6AS8P5AF7ODOilhInDZXHfGb7cuqHM6l7KF8QWCqT31E924k88e0B6
 yE2daq27htk5pOv02nWToPKJ1by8WqO94plFP5g0Gc+SnUDa38YwGwbAp1V5H0apgVwD
 be6TomXpLsQyNShKn4d0RFibvSH/ZkSC7zAAvsbnmA6GmiUGcW8BvquspuMTQ9d1JUvR
 C2oHo8Ns+IV5/IOm0FA1nm6Qsbu/TCSfEMUYyi4813z0a/Wuq6quymIneLCjzmk7W5si
 dW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006487; x=1727611287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCxOZrHA9KO++5sk9CI1DtuqpvUPuY/JWcvFhFjKE7I=;
 b=bt69L10tn08ZvcmCIMdIDh24+S2VAIwk+b54+cpBBy0VhBRmeoFMi2a2oZMj0TwHXk
 lJRvOFMhcKMnaN8KbFfuXMZBar/3Hd2oRiPBtmldFR7NOMP2qreCKjbkuPErCuxfMV5g
 usU35nPiUDbvARQ9sjwkr/vB+3eyf+FSbUakCSaIwgjOoiwjoryUbhoiPu7NHpWaMziH
 OByp4xJtYFptsoDnlsb1lo1v+a2H3nsWUfZiu7d+xEFU1apE6xJGDKLTtPX4KlecdUp5
 QhNVvN4NwvA1TOnJcD56riRHeU+NnYLlClfSsYg7JjkFVq+8hmkieCvTMC9Q5Q0BE5Wm
 rMjg==
X-Gm-Message-State: AOJu0Yz/qrn/5Bwqc2WIx1a8VugoU8XGJv0KXZP5fUaVmdXbAUJPnqdW
 Zl+IQJxCINEv4NEDo8KIOl1YmQjFFiSmtObZUlYGS66cpaFzNQJLBudwGGbcs47SeYumQjbPu78
 lFN0=
X-Google-Smtp-Source: AGHT+IEnCzOiMiesevAWYPiCyZcyEIUyaGR+HYOEqZWFhXoL/9w6eitxjkGwaZYPymecaTSdjNqqbg==
X-Received: by 2002:a17:907:2d22:b0:a8d:3998:2de with SMTP id
 a640c23a62f3a-a90d566cecdmr805473766b.12.1727006487403; 
 Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <bcain@quicinc.com>
Subject: [PULL 23/31] linux-user: update syscall_nr.h to Linux v6.10
Date: Sun, 22 Sep 2024 14:01:04 +0200
Message-ID: <20240922120112.5067-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

From: Laurent Vivier <laurent@vivier.eu>

Automatically generated using scripts/gensyscalls.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Message-ID: <20240918074256.720617-2-laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/syscall_nr.h     | 19 ++++++++++++++++++-
 linux-user/hexagon/syscall_nr.h     | 20 ++++++++++++++++++--
 linux-user/loongarch64/syscall_nr.h | 14 +++++++++++++-
 linux-user/openrisc/syscall_nr.h    | 18 +++++++++++++++++-
 linux-user/riscv/syscall32_nr.h     | 23 ++++++++++++++++++++---
 linux-user/riscv/syscall64_nr.h     | 23 ++++++++++++++++++++---
 6 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
index 12ef002d60..c2e09ed5c5 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -305,9 +305,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
index b047dbbf6d..f3220b74f7 100644
--- a/linux-user/hexagon/syscall_nr.h
+++ b/linux-user/hexagon/syscall_nr.h
@@ -90,7 +90,7 @@
 #define TARGET_NR_sync 81
 #define TARGET_NR_fsync 82
 #define TARGET_NR_fdatasync 83
-#define TARGET_NR_sync_file_range 84
+#define TARGET_NR_sync_file_range2 84
 #define TARGET_NR_timerfd_create 85
 #define TARGET_NR_timerfd_settime 86
 #define TARGET_NR_timerfd_gettime 87
@@ -324,9 +324,25 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_HEXAGON_SYSCALL_NR_H */
diff --git a/linux-user/loongarch64/syscall_nr.h b/linux-user/loongarch64/syscall_nr.h
index be00915adf..fefca6f5f6 100644
--- a/linux-user/loongarch64/syscall_nr.h
+++ b/linux-user/loongarch64/syscall_nr.h
@@ -307,6 +307,18 @@
 #define TARGET_NR_process_mrelease 448
 #define TARGET_NR_futex_waitv 449
 #define TARGET_NR_set_mempolicy_home_node 450
-#define TARGET_NR_syscalls 451
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_LOONGARCH_SYSCALL_NR_H */
diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
index f7faddb54c..2b66f99ea6 100644
--- a/linux-user/openrisc/syscall_nr.h
+++ b/linux-user/openrisc/syscall_nr.h
@@ -326,9 +326,25 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
index 412e58e5b2..42376ac8c7 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -7,6 +7,8 @@
 #define LINUX_USER_RISCV_SYSCALL32_NR_H
 
 #define TARGET_NR_io_setup 0
+#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
 #define TARGET_NR_io_cancel 3
@@ -227,8 +229,6 @@
 #define TARGET_NR_perf_event_open 241
 #define TARGET_NR_accept4 242
 #define TARGET_NR_arch_specific_syscall 244
-#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
-#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
@@ -300,9 +300,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
index 29e1eb2075..96ee92ec31 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -7,6 +7,8 @@
 #define LINUX_USER_RISCV_SYSCALL64_NR_H
 
 #define TARGET_NR_io_setup 0
+#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
+#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
 #define TARGET_NR_io_cancel 3
@@ -250,8 +252,6 @@
 #define TARGET_NR_accept4 242
 #define TARGET_NR_recvmmsg 243
 #define TARGET_NR_arch_specific_syscall 244
-#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
-#define TARGET_NR_riscv_hwprobe (TARGET_NR_arch_specific_syscall + 14)
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
@@ -306,9 +306,26 @@
 #define TARGET_NR_process_madvise 440
 #define TARGET_NR_epoll_pwait2 441
 #define TARGET_NR_mount_setattr 442
+#define TARGET_NR_quotactl_fd 443
 #define TARGET_NR_landlock_create_ruleset 444
 #define TARGET_NR_landlock_add_rule 445
 #define TARGET_NR_landlock_restrict_self 446
-#define TARGET_NR_syscalls 447
+#define TARGET_NR_memfd_secret 447
+#define TARGET_NR_process_mrelease 448
+#define TARGET_NR_futex_waitv 449
+#define TARGET_NR_set_mempolicy_home_node 450
+#define TARGET_NR_cachestat 451
+#define TARGET_NR_fchmodat2 452
+#define TARGET_NR_map_shadow_stack 453
+#define TARGET_NR_futex_wake 454
+#define TARGET_NR_futex_wait 455
+#define TARGET_NR_futex_requeue 456
+#define TARGET_NR_statmount 457
+#define TARGET_NR_listmount 458
+#define TARGET_NR_lsm_get_self_attr 459
+#define TARGET_NR_lsm_set_self_attr 460
+#define TARGET_NR_lsm_list_modules 461
+#define TARGET_NR_mseal 462
+#define TARGET_NR_syscalls 463
 
 #endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */
-- 
2.43.0


