Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B48C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfY-00048B-8g; Mon, 11 Mar 2024 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf9-0003ZJ-Qx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjf8-0007Rw-Bd
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:42:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e63e9abf6aso2563163b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178928; x=1710783728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+Mw1KOsAKdIljnyOdgS7xf0wpaG47NUuB98WZioiqA=;
 b=fSc7hieTuQGNKfiaeqUYYXRmO2vJiOaqpRG+iM53kZTKQGEGARylBxX+5d7Nqjpucp
 hTGn1d/NJyrR+mnn0kYy5REbKHCyzbebTY8RPM3idCCNpd/UZyj9l0j62Ln1T1hfmM7g
 HlrqVD+J/joMhjtcYNVbfNd3sg6A5dd/IIzynrMVPtGcxgpyBCRPaVj+KMimx8yIYMKA
 9mDk9sCSuMi0XAN6KBVglHdI8FgHuMxzCommhb8U1KL7aXn+UGjYgpXxkBSvqNiPaxhw
 yhUsAyVPZ7vlIdK7kNnufgyWkvGH0xr6Y5WO5kCNR8S+fLebd2JcLvsDQ9a/L9PI2KkQ
 mCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178928; x=1710783728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+Mw1KOsAKdIljnyOdgS7xf0wpaG47NUuB98WZioiqA=;
 b=i+cgwnzAsD+pj/AHzZF2/Qu8smmFNwLMgOJ52Hxy/KeZ3hCOB+5QD3ZdUZlAyheH/X
 AXXqQFPWVRhmGOUbTOYPIkwehd4o299Z5VkMqzkIwPNQmtnq5mKTGnLrDj1nxnboKeu4
 TktY8Z0bVrZg3DBdUJMTxXHUhptwBwjzLnzjpYoJzDWeLactGYbgatdysRYJ8XY9nYne
 eDndz/YS26ZfK9ci3rrp8BHnDV325hVdTz+G56OKoiKLfOlSP7sQcYoQ7bSdqXJCi/2B
 9jN1h6b1VWMZAWOuJsvepYIFZyYBhAPg1k2m+L/FkF/yfsE6RIc76H+aM9B0C+4PIIdU
 diMA==
X-Gm-Message-State: AOJu0Yxjri4O40e6bTr+sn5eSLhBWbiNM2vGRHQncP4DsoxRSIP+DHcf
 Somf2/+wDqP5ZhhxC1xABPR7PkL9Scb1EPUPC9EoKra3ZJovNVR76JPpcIcSvOE=
X-Google-Smtp-Source: AGHT+IHfPujORP8WjpLarS0aDP0D8Sild9AbjkJ1WvBAubb6ngXAyL2hXVRyBqT1rDGblvkXj0uGSw==
X-Received: by 2002:a05:6a20:a105:b0:1a3:1469:38cc with SMTP id
 q5-20020a056a20a10500b001a3146938ccmr3872276pzk.16.1710178928143; 
 Mon, 11 Mar 2024 10:42:08 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 17/24] tests/avocado: reverse_debugging.py stop VM before
 sampling icount
Date: Tue, 12 Mar 2024 03:40:19 +1000
Message-ID: <20240311174026.2177152-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rather than sampling the "last" icount then shutting down the vm
while it is running, stop it first. This allows the actual last
icount in the trace to be found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index a790c342a8..c84fbcd8bd 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -152,19 +152,20 @@ def reverse_debugging(self, shift=7, args=None, x86_workaround=False):
             if x86_workaround and i == 0 and self.vm_get_icount(vm) == 0:
                 logger.warn('failed to take first step, stepping again')
                 self.gdb_step(g)
-        if self.vm_get_icount(vm) != self.STEPS:
+        self.gdb_step(g)
+        if self.vm_get_icount(vm) != self.STEPS + 1:
             self.fail('icount (%d) does not match number of instructions stepped' % self.vm_get_icount(vm))
 
         logger.info('continue running')
         self.gdb_cont_nowait(g)
 
-        while self.vm_get_icount(vm) <= self.STEPS:
-            pass
+        logger.info('stopping to read final icount')
+        vm.qmp('stop')
         last_icount = self.vm_get_icount(vm)
         logger.info('shutdown...')
         vm.shutdown()
 
-        logger.info("recorded log with %s+ steps" % last_icount)
+        logger.info("recorded log with %s steps" % last_icount)
 
         # replay and run debug commands
         vm = self.run_vm(False, shift, args, replay_path, image_path, port)
-- 
2.42.0


