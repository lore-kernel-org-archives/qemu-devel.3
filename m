Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD1DCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKco1-0005H3-2I; Wed, 06 May 2026 10:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnt-00055o-W5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnr-0000aB-Vu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso71280545e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076040; x=1778680840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qre66aPGzaHyRW/mep22O0VUOmIb2TridNeuU/H0ZPg=;
 b=JUYQ5GhaWZQIyXwQObpkvljrCL3llPfrIRSq4chagcP11QXzqW6P+rNelfPFBrYaiM
 D+RzCnqi+x8AqK55NYoSDXWzAUi9+l3gHBqORuSb6sHJc1e+TsZcsCBtHIs/2WaQ8GJv
 GqxMXoVTy6BKXLCn4LtB+bjrl2JAZpdVTGRD4NjWK8l4rlsNEE6h/jsmw3bYj2XVb8GO
 7S7/fxlnHqIG5i4kGsptb5lAoS/M+n9+FD2omyzf6OdcrNR5Iw9vi4erNZDVinBJywX3
 asT9z3+QvnyrRjTFmtduqceCcGpU3q61a+sBHJj3s9XJ9m4s87rNRcwEX62w6cu7RMPP
 Sj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076040; x=1778680840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qre66aPGzaHyRW/mep22O0VUOmIb2TridNeuU/H0ZPg=;
 b=flvyFDJ4GgMwLfX7iaz+wElSd5A1q9YnugJsgULmT3zRv8Klo7QjXQvnutBDOojQGR
 sF7yivzAk/j0UbugY4xY2NqZeCFj7xPsL6pwnT6Bv9mGyRhPyAgbb26gMFHnMrU7N65e
 6PzxGH4kmFP/hGaItwdQPil6Am0f1Djgu/vvNLgBkrVbJ0iunZgzMKNBD2Jb5RxQW3JT
 LFFhvk8rXJN8/Z3dV/G3re2wHT8a3ckhLM9R8bu1fefOUB8XtjzKgYTCq+/zv1hSsWRi
 51koyvd11qPxzrxJVIyVCEzhPnpaNJY2HOfcY9kgmE5FduLkeeeYPUytezmDpVKfsN4Q
 uqsA==
X-Gm-Message-State: AOJu0Yxw6DYVt89HHJcAklwyu13jhwTwcm6RiCUqk/DB/0vFieCA7Cw4
 vXG/5xY2+5GRNrTlreaWeT61iRZIWu7qDN55GrrFFWrk/shFlYysJ/T7Rd3g7NbNXCwQKU9AeqR
 FLcemzyk=
X-Gm-Gg: AeBDievL+cvMumNNW3I/Swemzczoqay+X2jhjYQJ0zk4BpfMnnFE1okL9l44VrBUDN+
 oh37aa5GUGIpzjSR7taXElHGuXR5Tlc55NzMPo3e4M/jGZw3rZ1+9cCgfDYmSrCn2Xi2JsgutL6
 qtTW7Vtr6rZavNAxHA8KVaIGVzjUrIs4JCY4IDcu6M1x5ceuxgE6+eAfuSTSc/EyO6cpghONXyM
 5Z7REuYmkptB13EnXTTLZtsnI6gAjM5ktuQ2nAC+nkEw16Gb4fDyhTd5Hghh7oXkvYbPEtU0etr
 6Fd6Isl3jeNfNoRQGuBRT4UFrdRYTqFWlgq4E0RMwgKefBhZBtQa30G0q1CN6sYqKqSDO4phRmG
 9M9TTXdOCtZwc7b5DZwKGmxTvKFmWvkzvGzVE+LczYy43Oqi+sOzGA5KyUhYtzHbqkM1zr3X4Fm
 8AVrcekXhlLn31aBmTcWqXtLTXeRVTY77vpnLZEsmkOlS1vPFjPo7wkULuH9fx+6Ile5rYfRHv/
 9lfbN/7hj4=
X-Received: by 2002:a05:6000:144a:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-4515d3dc683mr7111055f8f.31.1778076039480; 
 Wed, 06 May 2026 07:00:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm8110787f8f.8.2026.05.06.07.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 041/110] stubs: Rename monitor* -> qmp* files
Date: Wed,  6 May 2026 15:54:13 +0200
Message-ID: <20260506135524.20617-42-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
These files aren't about human monitor but QMP, so rename them
for clarity using the 'qmp-' prefix instead of 'monitor-'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260427080738.77138-6-philmd@linaro.org>
---
 MAINTAINERS                                      |  6 ++++++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
 ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
 stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
 stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
 stubs/meson.build                                | 16 ++++++++--------
 10 files changed, 14 insertions(+), 8 deletions(-)
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac47299fd83..f560853ea41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,6 +121,7 @@ F: include/hw/s390x/
 F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
+F: stubs/qmp-cpu-s390x.c
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
@@ -497,6 +498,7 @@ M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Eric Farman <farman@linux.ibm.com>
 R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
+F: stubs/qmp-cpu-s390x-kvm.c
 F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
@@ -510,6 +512,8 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: stubs/qmp-i386-sev.c
+F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
@@ -522,6 +526,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
+F: stubs/qmp-i386-xen.c
 F: tests/functional/x86_64/test_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
@@ -797,6 +802,7 @@ F: include/hw/timer/a9gtimer.h
 F: include/hw/timer/arm_mptimer.h
 F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
+F: stubs/qmp-arm-gic.c
 F: tests/qtest/test-arm-mptimer.c
 
 Bananapi M2U
diff --git a/stubs/monitor-arm-gic.c b/stubs/qmp-arm-gic.c
similarity index 100%
rename from stubs/monitor-arm-gic.c
rename to stubs/qmp-arm-gic.c
diff --git a/stubs/monitor-cpu-s390x-kvm.c b/stubs/qmp-cpu-s390x-kvm.c
similarity index 100%
rename from stubs/monitor-cpu-s390x-kvm.c
rename to stubs/qmp-cpu-s390x-kvm.c
diff --git a/stubs/monitor-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
similarity index 100%
rename from stubs/monitor-cpu-s390x.c
rename to stubs/qmp-cpu-s390x.c
diff --git a/stubs/monitor-cpu.c b/stubs/qmp-cpu.c
similarity index 100%
rename from stubs/monitor-cpu.c
rename to stubs/qmp-cpu.c
diff --git a/stubs/monitor-i386-rtc.c b/stubs/qmp-i386-rtc.c
similarity index 100%
rename from stubs/monitor-i386-rtc.c
rename to stubs/qmp-i386-rtc.c
diff --git a/stubs/monitor-i386-sev.c b/stubs/qmp-i386-sev.c
similarity index 100%
rename from stubs/monitor-i386-sev.c
rename to stubs/qmp-i386-sev.c
diff --git a/stubs/monitor-i386-sgx.c b/stubs/qmp-i386-sgx.c
similarity index 100%
rename from stubs/monitor-i386-sgx.c
rename to stubs/qmp-i386-sgx.c
diff --git a/stubs/monitor-i386-xen.c b/stubs/qmp-i386-xen.c
similarity index 100%
rename from stubs/monitor-i386-xen.c
rename to stubs/qmp-i386-xen.c
diff --git a/stubs/meson.build b/stubs/meson.build
index f33b1d2a089..af4051e6c5e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -79,14 +79,14 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-  stub_ss.add(files('monitor-arm-gic.c'))
-  stub_ss.add(files('monitor-i386-rtc.c'))
-  stub_ss.add(files('monitor-i386-sev.c'))
-  stub_ss.add(files('monitor-i386-sgx.c'))
-  stub_ss.add(files('monitor-i386-xen.c'))
-  stub_ss.add(files('monitor-cpu.c'))
-  stub_ss.add(files('monitor-cpu-s390x.c'))
-  stub_ss.add(files('monitor-cpu-s390x-kvm.c'))
+  stub_ss.add(files('qmp-arm-gic.c'))
+  stub_ss.add(files('qmp-i386-rtc.c'))
+  stub_ss.add(files('qmp-i386-sev.c'))
+  stub_ss.add(files('qmp-i386-sgx.c'))
+  stub_ss.add(files('qmp-i386-xen.c'))
+  stub_ss.add(files('qmp-cpu.c'))
+  stub_ss.add(files('qmp-cpu-s390x.c'))
+  stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


