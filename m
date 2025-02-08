Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70696C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtS-0001ui-Eh; Sat, 08 Feb 2025 15:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtP-0001tR-AI
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:35 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtN-00058I-AL
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:35 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f4500a5c3so57841115ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048252; x=1739653052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eG/d8IONo4okZHoOBktlmuHynzB6DQe11EAuukemM7Q=;
 b=OxAsnNWj8OyD7uEI7W5eqUZ8yfjydvr+VkNo/Jkb6EOgPPOfDHMUxvUSn9kcNnhist
 2BV/iVb+E+vig8AZjhYBB/1lkHyZVaV3RDFOVPZaWxvBVQ+TvrJ/evKp655to+e0Uc6A
 bYoLnDr1vYQxdBpdc7kY/ojBertxGWb230vKrhoOUViiryRU0ld7ldrasWqDX/Ns3JLj
 vZYnWIOB3D8hmcqYaypXlKOXna+W4QilVeKwKCjijz5OI5E1sj3RK4I2HHX411VRm+zZ
 T155veSuLFdXQ05Tf1pJiUECGGMpsu8C1ZBW2WcWy4X3K3d7x+ICm/ZAl+ti2hptZxuO
 vZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048252; x=1739653052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG/d8IONo4okZHoOBktlmuHynzB6DQe11EAuukemM7Q=;
 b=UII48c0BUOGx0HobYfsfA6INomZW2QUNccxisJlixhkvWvpotPKu6oR1KpC5EmFWIn
 CpcFGzvqZgxSg1FxAltyZmqdoQD7zJV0hd5vTa7OXIVqHB7kKlFfWsWnp6KVV2w7JkG5
 WVzyihjakRQtsj+Hkjl4gTs2qJGD5xJSSKmi+vewb98uQduK1rCrGHpxypbx2exjTenQ
 Zc2aq9OiAGv4IJgY70ecZVOf5D6dxNUIZ1XbE2SdXx/VcBQNZvmflSDt/mwUnRZf8KNJ
 5HrcoaHa8EcaP6K0xFJDfLbYVH1U3eDlb/MEsqabJgU0cvSHYUrMpnAXENjz+VXuhYLb
 ciig==
X-Gm-Message-State: AOJu0YwFuGI/JSiPrrIsinMTHiwTWfb6Ee84/KGC6uJog5TZQPDG8V03
 7ZvP7z8DsFty164VZqBd18wW1c3uPdUF06WYIpsiVZIjwdgEt5ajoIo/7iByfvVGYra9QdvnQQG
 Q
X-Gm-Gg: ASbGncv2JnJPGf2Dllug8D/cHEdeLhpmHA8Z07P4Qlt3P405WHp7t3o/thgKCQJDwpU
 ZOvY/R6+o+uMnuecl7ZTKBVuabDsJrhWsVBxkh9hDwpN2I819BjUbCyR1HBZz6O1QjWYrvAkYQo
 lEomtHjVcv93pXqAHq405MFdarD/FXg8fdWT4H2VyNqE5NXgnfwqgPkLxdyDdnlnQh4RVClTJ2b
 Vn4yI62zH5RKIq0oQqT2HWTQe7aGH9U4RtBN/pIaqZRNLbHsDETZ/+Z1f6V/D59zj+Cr/3LB1cl
 kPpSvvQHH6dvW4H0c/BocqkTsaFkyl3njHvLsPsGJ+jgGdI=
X-Google-Smtp-Source: AGHT+IHuzG2ZotrVY8dk5FVqrNKTuItLVBRPbYsh3ZhCHNynrkr6hsEvCUzXmzaR67a42g9WMaEjSg==
X-Received: by 2002:a17:903:104b:b0:215:bf1b:a894 with SMTP id
 d9443c01a7336-21f4e7249bdmr114952075ad.24.1739048252018; 
 Sat, 08 Feb 2025 12:57:32 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] meson: Disallow 64-bit on 32-bit emulation
Date: Sat,  8 Feb 2025 12:57:23 -0800
Message-ID: <20250208205725.568631-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

For system mode, we can rarely support the amount of RAM that
the guest requires. TCG emulation is restricted to round-robin
mode, which solves many of the atomicity issues, but not those
associated with virtio.  In any case, round-robin does nothing
to help the speed of emulation.

For user mode, most emulation does not succeed at all.  Most
of the time we cannot even load 64-bit non-PIE binaries due
to lack of a 64-bit address space.  Threads are run in
parallel, not round-robin, which means that atomicity
is not handled.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 85317cd63f..ec51827f40 100644
--- a/meson.build
+++ b/meson.build
@@ -3185,6 +3185,9 @@ if host_os == 'windows'
   endif
 endif
 
+# Detect host pointer size for the target configuration loop.
+host_long_bits = cc.sizeof('void *') * 8
+
 ########################
 # Target configuration #
 ########################
@@ -3277,8 +3280,14 @@ foreach target : target_dirs
     }
   endif
 
+  config_target += keyval.load('configs/targets' / target + '.mak')
+
   target_kconfig = []
   foreach sym: accelerators
+    # Disallow 64-bit on 32-bit emulation and virtualization
+    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+      continue
+    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -3292,9 +3301,6 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  config_target += keyval.load('configs/targets' / target + '.mak')
-  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
-
   if 'TARGET_NEED_FDT' in config_target and not fdt.found()
     if default_targets
       warning('Disabling ' + target + ' due to missing libfdt')
@@ -3307,6 +3313,7 @@ foreach target : target_dirs
   actual_target_dirs += target
 
   # Add default keys
+  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
   endif
-- 
2.43.0


