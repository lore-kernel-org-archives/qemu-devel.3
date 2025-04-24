Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EE8C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kro-0006Ku-Lp; Wed, 23 Apr 2025 20:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015S-MH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqB-0004iw-B3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so396929b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456002; x=1746060802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43YpcfeoVoWWDUGo+tAp4Ol8hUTU+r+JKYk8jD3UJRA=;
 b=ucfo4MvsS0/lkZnqDH3dSWPSHQV0tn1rOkK7HCvTEMJmzg3Xa1UjYStNTc7rKGlfea
 o3dRDbdhaM21/b79y7D8Wwn5xIPvatrSMkMvjRVhlyhx/CbKzVGLk7rKgP3OmcGlSu1m
 GbjIolOwcrDmboThjjFr+HgF+bwSRIp8Zose8YbuICL2qw387chrIjgnv+Qf4iUXGdzx
 +sojyHXkUEGUKwB+uZLpguzMHFUim8fjCFArGsBGlv3AucKgMynCDYo3SMBHk3zlvHAW
 qr272q/LP7WcZsVVp/6q3bwKdgSKGUeeHSX6DQ/6KIhFDzg1Rt91shfunJy+UF3kJFKf
 dMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456002; x=1746060802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43YpcfeoVoWWDUGo+tAp4Ol8hUTU+r+JKYk8jD3UJRA=;
 b=QhDtoe+GWnOmYRz5FsPoK2MdzBTTFCOO42EijwKjIvHFSGBLqWKeGlqICh1QQLsIm1
 YlYa80DJrVTGJCnWB9fKSvsLl9NeYdF9nA8gkY60m5NWVomouQxzGMYxD8ekB/0VeWtH
 dtx91jRLcSJFFlRU5lVuKyjsW9fadsxbS0dB1KDY00c6m3imavUwxhNekgKWGMGtu9m/
 LbcVPHpcz3J8BRAQDgDbhCZwxJWFF/5lVhy9Tf+rhslxRFqp+s7bmmRgsoKraMcSuBCs
 Ce5DD1MgWSTjAjA0mZRB/uEgX3lzCs+0doanhR3qaEeR+6XC+yy5y5ZaM8Ewt3/LvJ6z
 dTWw==
X-Gm-Message-State: AOJu0YxlnHynjTxT+a1LGtIgcX6/Jkzd9OkOzZ4zTofZfVuDtEiqwPdM
 ptFKn5w/oh/o5Y6vl+sVN75U8o/yxieuiDMzNW9+11Izjx0apo/yAECNTIpn7IynOZ4QOgzJkka
 z
X-Gm-Gg: ASbGncuHdpkZGIutJHFy7QSp8iRk0fY0B6e3sfLl6FehlCKRFnBew9xQdmORpTyBqoQ
 amh35itoGT0EJNzANaZwNxDXKS70tpBwbA5wEgk/aTyzs1nGwax73SDkldMBpv5gdYZXoWct1oZ
 xhqbPB+HUDYHH6CcZ/0vrDOv34NhOtxge4q0YirQJNo18seCSr9u2VlIQrjXWv6z4IFe9JJP+hi
 BqMQITxhSKW49UEjBUf3AO+PNbQt38AM2RZiO4+iB1sCkt1U9d/Ac2WkWm/2g9q+wKXNdW58AjR
 vjQQUzLIxQOvsiKct4aZu4P0y3Dvuo89QWh/bXOcnMBApclKwOjTDK+OZDzB5ATianhCO2KmpJY
 =
X-Google-Smtp-Source: AGHT+IFG9AfBLnuVln3o96fTVuT4Bwz6XZfKxdyeISUhi5Y1xBf89ENt0+SB7HPpZYvtHgO6bEa3Gg==
X-Received: by 2002:a05:6a00:1150:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-73e2460ecd0mr1183724b3a.8.1745456001799; 
 Wed, 23 Apr 2025 17:53:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 061/148] meson: Only allow CONFIG_USER_ONLY from certain source
 sets
Date: Wed, 23 Apr 2025 17:48:06 -0700
Message-ID: <20250424004934.598783-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Poison CONFIG_USER_ONLY and CONFIG_SOFTMMU unless
the compilation unit is in specific_ss, libuser_ss,
or libsystem_ss.  This is intended to prevent files
being incorrectly added to common_ss.

Remove #ifndef CONFIG_USER_ONLY / #error / #endif blocks.
All they do is trigger the poison error.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h                       | 5 +++++
 include/hw/hw.h                             | 4 ----
 include/system/confidential-guest-support.h | 4 ----
 include/system/replay.h                     | 4 ----
 include/system/xen.h                        | 4 ----
 meson.build                                 | 6 ++++--
 6 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 2c151fd1e0..4180a5a489 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -66,4 +66,9 @@
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
+#ifndef COMPILING_SYSTEM_VS_USER
+#pragma GCC poison CONFIG_USER_ONLY
+#pragma GCC poison CONFIG_SOFTMMU
+#endif
+
 #endif
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 045c1c8b09..1b33d12b7f 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -1,10 +1,6 @@
 #ifndef QEMU_HW_H
 #define QEMU_HW_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include hw/hw.h from user emulation
-#endif
-
 G_NORETURN void hw_error(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 
 #endif
diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index b68c4bebbc..ea46b50c56 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -18,10 +18,6 @@
 #ifndef QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include system/confidential-guest-support.h from user emulation
-#endif
-
 #include "qom/object.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
diff --git a/include/system/replay.h b/include/system/replay.h
index 8926d8cf4b..1c87c97fdd 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -11,10 +11,6 @@
 #ifndef SYSTEM_REPLAY_H
 #define SYSTEM_REPLAY_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include this header from user emulation
-#endif
-
 #include "exec/replay-core.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-types-run-state.h"
diff --git a/include/system/xen.h b/include/system/xen.h
index 5f41915732..c2f283d1c2 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -10,10 +10,6 @@
 #ifndef SYSTEM_XEN_H
 #define SYSTEM_XEN_H
 
-#ifdef CONFIG_USER_ONLY
-#error Cannot include system/xen.h from user emulation
-#endif
-
 #include "exec/cpu-common.h"
 
 #ifdef COMPILING_PER_TARGET
diff --git a/meson.build b/meson.build
index 7e22afe135..657949326b 100644
--- a/meson.build
+++ b/meson.build
@@ -4050,7 +4050,8 @@ common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
                          libuser_ss.sources() + genh,
-                         c_args: '-DCONFIG_USER_ONLY',
+                         c_args: ['-DCONFIG_USER_ONLY',
+                                  '-DCOMPILING_SYSTEM_VS_USER'],
                          dependencies: libuser_ss.dependencies(),
                          build_by_default: false)
 libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
@@ -4060,7 +4061,8 @@ common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
 libsystem_ss = libsystem_ss.apply({})
 libsystem = static_library('system',
                            libsystem_ss.sources() + genh,
-                           c_args: '-DCONFIG_SOFTMMU',
+                           c_args: ['-DCONFIG_SOFTMMU',
+                                    '-DCOMPILING_SYSTEM_VS_USER'],
                            dependencies: libsystem_ss.dependencies(),
                            build_by_default: false)
 libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
-- 
2.43.0


