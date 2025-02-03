Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C90CC02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temys-00086s-NS; Sun, 02 Feb 2025 22:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyq-00084x-UG
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyo-0002hG-La
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:36 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216401de828so66999695ad.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552713; x=1739157513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVuDSdWtHZ7fHHcMQ0XabT+yWocq8eUf3nBsOTxNFSU=;
 b=uGGltaG2ryZIjZeQppHHOG3AiZFvW7TRW0RgnwcMuDr6nuiPW30GpDNjOTmYkNImVm
 aeqo2nVCV/huq3YKCJNNQxWB/eTsLNF7qR1Zeedii1ZBUX7AndJurmpD6p1MaDofGZz1
 8QjyyDx4+v/RESLRUimKUVLllDmSr6VrXlSJhIYAWERYwA5N3HbIJN0lYJRodrlWSuI9
 OZHQ2kp/bKTSyPBmZ10nYs63ZkVIJdAQcD/FfGCzZIq4QBHqeecL9qyGADUhJ61RveCx
 gOyTLHe4PyfObO6n63wYLzGdL3PdCwoaeza99IcqihuQNGBqFvgE0DM2nl3zxEoV5SyI
 8c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552713; x=1739157513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVuDSdWtHZ7fHHcMQ0XabT+yWocq8eUf3nBsOTxNFSU=;
 b=I/dEVPZPFtWgBsHYNOX+CKtYV71DdW+g0HSciMUIGrb8lWiW18v35M+LDUPuuLTipk
 oUr/56BtPFF8pyZJbAoQ6jzxNMPUMCIF4Hx9tyLJYUUzHdGDaV2qzr6arjHMB1D8tiQa
 0PIQ6i2SCfwxkrrueZnGUYxURW1KRRIZ4esg1gEilVY2lrVVx/EZV8HajzGQj+TcRkWW
 7c7tFnUtlOHGF0t71w+HxVcAUOaIqI/fdfVM5K5Zf9duftgAn1N8/d4bJgZyJ7uG//3S
 c/9KHu1qOed+b05Mv5PQa2e79GWYwIsMsrsh21rY6/cpvvsTGWgQQYZoSOkQssIZUC61
 Xz8A==
X-Gm-Message-State: AOJu0YyZ4NsmWwtmRWDwJebFVXywLpy4AUDJpsvE5F/nle1bPIZwMND3
 oO6jY9dc+W/hm6S3Oox04FLpc5BmKKF99N4ss/yMF4nv4i2P5GohROXZBF3UsSqk5MSelN5tlAe
 X
X-Gm-Gg: ASbGncvi1XWZnz8dyMllzId/UvUkDdbLshUAbU5R7Bf8gMcs3/nt5JmU65o3PGXzsWn
 LTXDRlLb9JHrt0J/81jao5jQKZCOSpwAJlARhiGz5yiBqH0YoI8JefQHn7zYqFDPgf2HjRTT/bH
 KM1wZKXWHk3eMVyyoCeLIUd1NUXr76083B/+gYcTOpFK+9xknFgyRtDkY3s/pFIu7BCzOJ9BgBs
 9vAeAmAuudT+s4unCVtrlZzkN0Om7F/Nagy+hf8hOKlBqIyoqNEyoyrVS1bKf/jjP9+GEnyN4Ja
 lltthqA4pwjK5BBYoY1a+FrnlB5d6eb7FA3GSKM1vxhiiV8=
X-Google-Smtp-Source: AGHT+IGwo1U/9Bd6gvRD1PyXg20Savn4geopY/UG/7ATUk+mSciSF/ilA74va7wx3iSNTSa0eUQ83Q==
X-Received: by 2002:a17:903:943:b0:215:431f:268a with SMTP id
 d9443c01a7336-21dd7db6e5emr313501085ad.31.1738552713077; 
 Sun, 02 Feb 2025 19:18:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 12/14] meson: Disallow 64-bit on 32-bit TCG emulation
Date: Sun,  2 Feb 2025 19:18:19 -0800
Message-ID: <20250203031821.741477-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
the guest requires. Emulation is restricted to round-robin
mode, which solves many of the atomicity issues, but not those
associated with virtio.  In any case, round-robin does nothing
to help the speed of emulation.

For user mode, most emulation does not succeed at all.  Most
of the time we cannot even load 64-bit non-PIE binaries due
to lack of a 64-bit address space.  Threads are run in
parallel, not round-robin, which means that atomicity
is not handled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 5ca3cc3f34..866b8ce477 100644
--- a/meson.build
+++ b/meson.build
@@ -3176,6 +3176,9 @@ if host_os == 'windows'
   endif
 endif
 
+# Detect host pointer size for the target configuration loop.
+host_long_bits = cc.sizeof('void *') * 8
+
 ########################
 # Target configuration #
 ########################
@@ -3268,11 +3271,18 @@ foreach target : target_dirs
     }
   endif
 
+  config_target += keyval.load('configs/targets' / target + '.mak')
+
   target_kconfig = []
   foreach sym: accelerators
     if sym == 'CONFIG_TCG'
+      # Disallow 64-bit on 32-bit TCG emulation.
+      if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+        continue
+      endif
       config_target += { 'CONFIG_TCG_TARGET': 'y' }
     elif target not in accelerator_targets.get(sym, [])
+      # Other accelerators are handled by accelerator_targets.
       continue
     endif
     config_target += { sym: 'y' }
@@ -3286,9 +3296,6 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  config_target += keyval.load('configs/targets' / target + '.mak')
-  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
-
   if 'TARGET_NEED_FDT' in config_target and not fdt.found()
     if default_targets
       warning('Disabling ' + target + ' due to missing libfdt')
@@ -3301,6 +3308,7 @@ foreach target : target_dirs
   actual_target_dirs += target
 
   # Add default keys
+  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
   endif
-- 
2.43.0


