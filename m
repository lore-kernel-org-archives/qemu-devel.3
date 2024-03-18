Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C3DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDt-0006vX-Hj; Mon, 18 Mar 2024 11:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDn-0006eX-Pg
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:21 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFDg-0007xM-3d
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:48:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6bee809b8so4221047b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776890; x=1711381690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyLvGmFiLkd1QrQEzobFQyubgUDWC+tz3WyBBbJBYXU=;
 b=dJfrg8RJ8HbVukWu4sj7Q4gi5a2HAalmBm1EfIrA30jEjtX9+3GFEe6s+NXFEGSYp8
 2Obbi3Cl/iUbeLynPX5SsRO/5AlloM/0mIfyPUt6XZ/04NfTuXANtiv+Xki1/TtEHGls
 VeKNMRnjkoZ8tI5Y5krLh31wsWOa/ykD7mP4L2RCnuMsXSo1M0SBaRgDYwBFX0X4dAKn
 lWxBw9Wy5pM6615us4VFxcnOAC6ogfVNyTTPjegEWJa0NgHrqrERiBQjnKFhij40koaY
 wKbLE66EbbQMT+4wxluz+pTTqOIAONzajzxarfTFjH6/QB3puhLtgq9Fhm6joQoqNTdr
 7qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776890; x=1711381690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyLvGmFiLkd1QrQEzobFQyubgUDWC+tz3WyBBbJBYXU=;
 b=hQ+PVpnPOkIJ/5dGc0+zb5CQyPWxoo3idPIk/MtQ1r5/y+2y9++Z4IxUPoBQ3EIa7G
 EUaVfDA0AP7RlFgBJYvg3ptH76Or0+wIvtdzm5SX6ABSmlzByA0vy8KvV/k4OstvoyLZ
 zfWv9PcpVcvf2KwgXi724fhnRLWMVmJYSUyPMOGUcSCUiiCyoib23TPvH1lHHKQMcgdL
 N920EPlq0CALtUukeFYu11hmeDZz8OuvsOWmzUPuAfttmHaQ79s0P/kr19/hFxtTQX1n
 7hiVL+ykutDh9glJbJvmYeHHW1tpO1dc5rVdibelsLqzanvzeXtbxJqazgo9Gq8btnqG
 ZeVw==
X-Gm-Message-State: AOJu0YyjY9Zgz0ThBjf95B+Ei8H7Q8hNskQHi/FIaC/NGzt8p88i6F1J
 ZC1X8CEL9WeMoyz2+P5lZUx42LDUNVkv26bgbjgkPA5Fj8Vm8ZI+H+2Jmzs55wU=
X-Google-Smtp-Source: AGHT+IEQzhr6JzmFVuY6L3R02QjO2VcOXBLXHbBTwZAMnLEc5xiyLKCcdPUkKHwV9d+DptY2Ry3gUw==
X-Received: by 2002:a05:6a21:a58d:b0:1a1:67a6:bba7 with SMTP id
 gd13-20020a056a21a58d00b001a167a6bba7mr16958566pzc.1.1710776890531; 
 Mon, 18 Mar 2024 08:48:10 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:48:10 -0700 (PDT)
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
Subject: [PATCH v5 17/24] tests/avocado: reverse_debugging.py stop VM before
 sampling icount
Date: Tue, 19 Mar 2024 01:46:14 +1000
Message-ID: <20240318154621.2361161-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Rather than sampling icount while the vm is running, stop it before
sampling icount. This allows the actual last recorded icount in the
trace to be found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 8a9578ad5a..bdc9082c85 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -156,19 +156,20 @@ def reverse_debugging(self, shift=7, args=None):
             if self.first_step_workaround and i == 0 and self.vm_get_icount(vm) == 0:
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


