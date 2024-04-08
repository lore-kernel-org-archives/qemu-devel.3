Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D98CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7v-0001yz-Gw; Mon, 08 Apr 2024 13:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7q-0001vc-KP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:47 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7n-0003cd-De
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:45 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a519ac18b3so832247a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598582; x=1713203382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ClDgWE+squc24jCQx5ASDG99O/TQsFv8OJ3ohhBsa3Y=;
 b=yLK1y3OEUThstbGG+U0rwnNtyeVJFACwozio/4T9aA2OGMqkdvfdKDEQN5NuT9X8d1
 rqxwfWY3OeIjnxIp+aw3ut67lCYRvSmNa3XZnQDWf9MDhb9rD2UeFN+wg6VpqXw0rVrb
 si49M7zv6VebaoN9Qouy/+0WF/ugubV2wr7TQsDe97dENmL5r8E/FMUHqZ1w7QTZoN9z
 uDZi/Pstr6TKDwp8C6w2eboHx9abTehT46NBchV5faJKj1OFz4m1Zz5qbv83RVBoWsgW
 Yw69SsIx4AScLDcWJu0cWWNxmU4rd8qQNhm8XGcPT7L5erqPqP2CliHMc6Hzzm70YaFP
 h4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598582; x=1713203382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClDgWE+squc24jCQx5ASDG99O/TQsFv8OJ3ohhBsa3Y=;
 b=Q6NnrzcKld/O+6xuQ3k122TDnCYhffLTtkWCqi5wwHWhuY/6x3vyeRwkVZJYNd9ald
 oqaPSJHn43FR+47GgS/3wNO6C5VctXKzUH4Y0dxfsdvjfoTrhW7a3Z2/lIzvhiXUxi4h
 Ea4z+T6QnhQvf8XFqeHnZivhpgqi9cTlFPITKUuxpnzk6Pr5tkZhQztSeW5XsUvtMq2a
 IFU/tcRzjwYm2an3A7ZuD/47IVkX69pcTgzWTs5PZNzwEtRrlgEz43KLT0m8ZTlwB3xX
 7AWbiySisIxgnRVt7sSyGpfFuFOoi/qkae78YafGtu//i19rCnwLnJeEns5OKUcQMPax
 /IhQ==
X-Gm-Message-State: AOJu0YybvNUZAMPyl57dVh2KPed/iVjkOT2GRun+p0vp0aBZ5UsflKf3
 pmD6eDtLdnsMM3TW1KSpjOW8/JybX+jPcu2xW/5btw+kvzyQDUu7VTWorx46HcOOlKOz5Zq69uc
 u
X-Google-Smtp-Source: AGHT+IEqR7Syjv4KeQ7C+jDud9uVEuYWENBx7KP442H2uM03hh+wQQHei9DrW3gGRJ1/gVUgxpdAwQ==
X-Received: by 2002:a17:90a:ce18:b0:2a5:24dd:bd34 with SMTP id
 f24-20020a17090ace1800b002a524ddbd34mr2206044pju.27.1712598581991; 
 Mon, 08 Apr 2024 10:49:41 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>
Subject: [PULL 07/35] linux-user: Add FITRIM ioctl
Date: Mon,  8 Apr 2024 07:49:01 -1000
Message-Id: <20240408174929.862917-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Michael Vogt <mvogt@redhat.com>

Tiny patch to add the missing FITRIM ioctl.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Message-Id: <20240403092048.16023-2-michael.vogt@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 1 +
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 1aec9d5836..d508d0c04a 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -140,6 +140,9 @@
 #ifdef FITHAW
      IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
 #endif
+#ifdef FITRIM
+     IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
+#endif
 
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #ifdef CONFIG_FIEMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 744fda599e..ce0adb706e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -945,6 +945,7 @@ struct target_rtc_pll_info {
 
 #define TARGET_FIFREEZE    TARGET_IOWR('X', 119, abi_int)
 #define TARGET_FITHAW    TARGET_IOWR('X', 120, abi_int)
+#define TARGET_FITRIM    TARGET_IOWR('X', 121, struct fstrim_range)
 
 /*
  * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index c3b43f8022..6dd7a80ce5 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -341,6 +341,11 @@ STRUCT(file_clone_range,
        TYPE_ULONGLONG, /* src_length */
        TYPE_ULONGLONG) /* dest_offset */
 
+STRUCT(fstrim_range,
+       TYPE_ULONGLONG, /* start */
+       TYPE_ULONGLONG, /* len */
+       TYPE_ULONGLONG) /* minlen */
+
 STRUCT(fiemap_extent,
        TYPE_ULONGLONG, /* fe_logical */
        TYPE_ULONGLONG, /* fe_physical */
-- 
2.34.1


