Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16E7C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pXA-0002MN-5I; Fri, 18 Apr 2025 13:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pX8-0002KK-Gn
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pX6-0008L3-Q8
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so15567505e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997383; x=1745602183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwvCBszA0F93ULs3epuAUVWkefEQwiSSHWBh59z/0XA=;
 b=MPkG47tGlldCxlj680bIi0oALyoKhtVwwsRV4uK+p+m7tY59G14Qw2SLUObnpQCRqe
 83xnx4lUSH7ZTlenWVd5pJ74EUJJTYOw4LCmbUHGdIMcsjEzu8/7Tvrd7ZLscO6DMH9P
 Kc/UyD2f/mJ1hOBhsRaRea+dflge40/z9IBSYFXFkQMFCh//ky8W26u3+TzI1WJHbibi
 2/v/1SSxV1Y2eKylYywWCujvhu95tnbQ+kPIuY817ZIopahbJoVUTV22EJhT/peDVOf4
 bDf9qQJXq35a7CCtG4P7dxdHzaNdkhoa/jTW0oD4/ocButb45BSXUQeXaLZh4Ti03+ok
 uHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997383; x=1745602183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwvCBszA0F93ULs3epuAUVWkefEQwiSSHWBh59z/0XA=;
 b=SG7mPhXsf0iyMasae8FYznYZ7y80HzsshRBsj2xrSJplcCD7xfF/fN2O2iqAQMSYa7
 lKDgKng/y9xryAh+RaqvwEaczNrDZGuhjySYo9FrJRlXiAKnmfImF64yezI4ibPib54q
 2lDDlbcaIQOhQtJsBuCfhEECdbzhi6O0tuzmxd1CBLAfBEp/5cbze6K4VX0MVFj20qfT
 TM/K9r2zfXrG0xGmBY/gle/S7TS8snmoxb62cQ0m1FFetqjdMzwUGLvWfWxJ2qC7o1RH
 MLz1kxE/qp6SBsjc4mS2JhygrDmU8q7yMezqQixhbPvODT8s06BGM1m/VgAjjDtlow5l
 7MxA==
X-Gm-Message-State: AOJu0YyJcr03sC1RP+VxNSIs3ZUvagdL9dqSojE9r7uBdJqKWWWvQmxn
 mzYn7+sSDEib/TQsYvImZKWf/iTvmPrBtf9fyuFRyFqZtkGU/X6AL0f0QrvdQx5xc0jL8yj9zMl
 5
X-Gm-Gg: ASbGncu3KXgg1xvCSop7nhmYdCw3Pn4qIXLy5tUm3Du79IyHc+EUlk/7TUzIkT6mx8j
 rD4i6AANnCup/9Go543Duv3oPPWSVdsBozZfDbr2PBs4VjHXYFr6yS8woa0q/QxzV4n4rODXwqT
 kIPrJ0kJZGptcy3wAoT0KjfTg+tcyraAofc8KVXVmoY9gr+3QGpxnPWyHF0vBLZO6eqdYK6GAyc
 2yC/E5aPyjEfDnWj51BItdWGG06LXmNv7PAZOS9oZEr4DbGSWo7iB0FNaaT6AkEcq0tCLx7+rz1
 jAE85RcbIRnXFy4tZEwOdS+ZYRAloRmNYSFK0dgxaEWQK1P2yDFb2hhtlE+CgbjIOZA2eYtYBmK
 QtVOue5fjkGmnOaA=
X-Google-Smtp-Source: AGHT+IGQDUJC6h0iAZd/J5qy7d1IMNFEeK6GNAgdSY0MQGiX/VTdX4kAaaDTz5qXjiJdp8U7XoA8rw==
X-Received: by 2002:a05:600c:154f:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-4406abfabe7mr24487675e9.26.1744997382797; 
 Fri, 18 Apr 2025 10:29:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbc81sm28942445e9.19.2025.04.18.10.29.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 07/14] meson: Prepare to accept per-binary TargetInfo
 structure implementation
Date: Fri, 18 Apr 2025 19:29:01 +0200
Message-ID: <20250418172908.25147-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

If a file defining the binary TargetInfo structure is available,
link with it. Otherwise keep using the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                 | 9 ++++++++-
 configs/targets/meson.build | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/meson.build

diff --git a/meson.build b/meson.build
index 168b07b5887..b0d4a9fcd36 100644
--- a/meson.build
+++ b/meson.build
@@ -3216,6 +3216,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_target_info = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3809,9 +3810,9 @@ specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target_info.c'))
 system_ss.add(files('target_info-qom.c'))
-specific_ss.add(files('target_info-stub.c'))
 
 subdir('backends')
+subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4272,6 +4273,12 @@ foreach target : target_dirs
     arch_srcs += gdbstub_xml
   endif
 
+  if target in config_target_info
+    arch_srcs += config_target_info[target]
+  else
+    arch_srcs += files('target_info-stub.c')
+  endif
+
   t = target_arch[target_base_arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
   arch_deps += t.dependencies()
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
new file mode 100644
index 00000000000..e9a5f7b078e
--- /dev/null
+++ b/configs/targets/meson.build
@@ -0,0 +1,3 @@
+foreach target : ['arm-softmmu', 'aarch64-softmmu']
+  config_target_info += {target : files(target + '.c')}
+endforeach
-- 
2.47.1


