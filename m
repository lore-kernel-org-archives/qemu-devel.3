Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64D8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSh-0006y8-FL; Wed, 24 Apr 2024 18:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSg-0006xk-IO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:34 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSe-0006gJ-MJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso408927b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999091; x=1714603891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDr6R2ma44jwvkJI3Qs5id/WJ2z4/lQ44GztsnjZcyw=;
 b=M+6bxgx24/yGZb2/YF5Kgwo/p7qWkjo599pFHECqFoFZ06u/7GIeXkySB5tJnnycNx
 xaLDHGGo15F502rCTDUJcIKRlmnawWIaYRSTSY7z4UDLsrtRbNwHXF/ftM9FautDS8Xp
 t1MhxOqf8trJbHI/+JTBdsNnH5BycRM4JIjBqmecjKyExL6oQYoK6dQYBm3qVyg1dd44
 4+yjQWcbp52DsEI3RlP9LfZce2bM2tQIdGuVCbPUFWw3/7X0lcSA4sxF0gPcgSm3FR2Z
 oYMpKOjkXj7PYQw2QJOSsHowumXf5WKOhKrLcUAhBsNK4G0aU5wBo3Rkj/RNnKsDtQun
 aFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999091; x=1714603891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDr6R2ma44jwvkJI3Qs5id/WJ2z4/lQ44GztsnjZcyw=;
 b=FUdujB6c/lA7rUH04LGxmzBocyi5nFcZ/+W5p5grNEvwgxkIizVagspJnpxCu7IAlb
 gbX/6p0C0JCs8Dbe9MG/1QRX503NUth/SjZ2eO4mkiYAhPjjlwj2eBr6mNTAd1fC7Y1n
 Ec8BfpCDGO+a1m1Mc4cAVA+hXvlSSzxjM9IgxObVv7Pywo/9uUd/EIXbhptX/6USTgtd
 nTQpwN/EUtXlw3Nn/SVd1JsbDPcYSwPUD3VaetyjNoekRllWaAbJIgAzqTQMAvIxZJ9U
 fpr75YndaqWtiCUwhReXBVQfBnXz7esojcQ3+ogzTk1RvH4Obddwzyy/rDgoq8q0PUef
 W83g==
X-Gm-Message-State: AOJu0YwxWcXuq4D02omQycbAIWsmlI3YG3fqiPLkbdrN+XVTSql8vHaU
 fv6W4o9AVaY31DK9e6OfZhAS1eQnURA5DRFuSxsKHenpI+KJyhBsFt2hhtjJSuXB+AKRPUu08Sv
 E
X-Google-Smtp-Source: AGHT+IHytaQk4tIr2c0NQEtKdGTfvZV+Bmq00AG3grIhMNYz5sA8mQWgN5bNTYxC0812lBG4GprxDw==
X-Received: by 2002:a05:6a20:daaa:b0:1aa:5e75:d31f with SMTP id
 iy42-20020a056a20daaa00b001aa5e75d31fmr4467488pzb.16.1713999091197; 
 Wed, 24 Apr 2024 15:51:31 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>
Subject: [PULL 6/9] linux-user: Add FITRIM ioctl
Date: Wed, 24 Apr 2024 15:51:20 -0700
Message-Id: <20240424225123.929152-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225123.929152-1-richard.henderson@linaro.org>
References: <20240424225123.929152-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 3995487630..a00b617cae 100644
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


