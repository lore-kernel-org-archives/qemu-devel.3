Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C671E6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP6x-0005fs-AZ; Tue, 03 Dec 2024 04:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6s-0005eR-Pb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:22 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6r-0002gR-8i
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:22 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53de92be287so7765032e87.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217738; x=1733822538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Z0cleQPrNy9NjZu27Yx3P0Ha1Flw6gQBqfbwRAF2Ak=;
 b=Pc4YCdmPZUhHTeD1/Km4Uw7qWk2LiwV/pRWaVuzftMIiyyV6jPshU9VzHM1sB27s+M
 pvDDdsENBb9xrMuRdaJBp4kSsdKrpjozJC2rZTN+HV192ThE8aSxb+m9nkfOIh1Q50Ck
 zA+PuMZJoeVNf96jk4fbBSXgBZhW0VOQbn03s1aKCr2Cs82BiuEV//6RkeYlCM+E8Kxb
 ziqZrlCqejENofkhyUJqPhhXeSg2ElhLT2KoaBlrJK4MXgnCn5geBnGSSFWdjABV1U9h
 umWNFheXy6xv3Elwacy35DhqTAKBJck+9t2VtEgrFCUbIN7sNbc5+o6EdK1ah7XfBPgd
 HDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217738; x=1733822538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Z0cleQPrNy9NjZu27Yx3P0Ha1Flw6gQBqfbwRAF2Ak=;
 b=riSl0sINd1TfHipVo+1PmFCZrQQJ0nUL1ei+yk0wTo+n5nFGbp9UekWokQKSTYtmzI
 KJ+5dubeR3s5WEHl2jtLNQipGOPmQ8ZX3dfAeD7P8i3o0hpTph6bTkZEw2hshcu5aFCK
 v27oSife/WleuIL08bUTw4exHz5vje8l3e8o0+JP85hcemjRMzT0Pdvi0eabui0USWW3
 ER4MHiI99QiK/Gbj+YdPzvAbL7dybf5CJ9lOW+C+e36yUZ2VwrngatK3UWG/PJVrqSZB
 ryBkmT/a43ybhIDDMfs41lMRfHru2gevfJ+3i78YvXQIy2EhXKO2401M2YehoATDEQWf
 JcZg==
X-Gm-Message-State: AOJu0YySavVTg2eUAxI9ErKI014n3hWDco233HCzqstmQaWGnpT4/iBn
 W+erGawdfDYCWo3Np20lcJHQOjYEDLOcecqSOq/4wgWUfamJPs6oB4KtfCuz/1RBWHHNYnBH3zJ
 4Jyo=
X-Gm-Gg: ASbGncuLyXND1jbESm3z9WLKL/97TLOqRb3XR6oVOci1lMGy6WYjEvwAL7yMhHmHULI
 R7lRSnyAqPTyzOYbmrfThnpFeb3HeiFXfWYhWc54fXN3E8hn0DYqTspoH2tJdwibE6RhaRKS3yi
 mUB24PWssnVnTWZ61srkc41Q11BsXH/DEpoM02btAwAsjwMSwpMtDogn4YpCutliORNj/7NwCJO
 /UwYwOHBVWXBs5ZFaBwO11RtAD8ewO5WWyKLuzgX9Akm69NVWYtAfEsuy5TjkP4o7RxOuwR
X-Google-Smtp-Source: AGHT+IFKXdzCHgoYrbBgxEetwk2wWIxXomwv6Wa0ZHXf5sB1MUtHIOwB2t+dSu80nFR8vz7SoiVkxQ==
X-Received: by 2002:a05:6512:124f:b0:53d:ed0a:8113 with SMTP id
 2adb3069b0e04-53e129fef1amr1251543e87.14.1733217738255; 
 Tue, 03 Dec 2024 01:22:18 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997d5625sm600599666b.63.2024.12.03.01.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] scripts/device-crash-test: Remove legacy '-machine foo,
 accel=bar'
Date: Tue,  3 Dec 2024 10:21:50 +0100
Message-ID: <20241203092153.60590-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

Replace '-machine foo,accel=bar' -> '-machine foo -accel bar' in
the device-crash-test script.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/device-crash-test | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index da8b56edd99..2b139e29ba0 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -295,7 +295,10 @@ class QemuBinaryInfo(object):
         self._machine_info = {}
 
         dbg("devtype: %r", devtype)
-        args = ['-S', '-machine', 'none,accel=kvm:tcg']
+        args = ['-S',
+                '-machine', 'none',
+                '-accel', 'kvm:tcg',
+               ]
         dbg("querying info for QEMU binary: %s", binary)
         vm = QEMUMachine(binary=binary, args=args)
         vm.launch()
@@ -358,7 +361,9 @@ def checkOneCase(args, testcase):
 
     dbg("will test: %r", testcase)
 
-    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel),
+    args = ['-S',
+            '-machine', machine,
+            '-accel', accel,
             '-device', qemuOptsEscape(device)]
     cmdline = ' '.join([binary] + args)
     dbg("will launch QEMU: %s", cmdline)
-- 
2.45.2


