Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E16DF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRfX-0001KP-6p; Mon, 13 Apr 2026 20:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfS-0001J8-Pn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfQ-0002ib-VP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so48075135e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126610; x=1776731410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ic1a2UScFm+l31qFyAeBECmSh2Gb91aNOowxEajWjpI=;
 b=n/3YsrQTztswBfRiq2esjfseFvG54/HZSXSx7K4chREEAu0SoQbppf3hDYx2G1XfSY
 K8USQnq+mslq/NzfT+4JDlQQKnG0ers+tmqKNt1PPjsx6z4RsgayMjr1uKYVpXL8YrR9
 qhPzlkIJ07NRmf/mPpr2KxgMU2jUJomTDJ6/fBZcGHbKuY5sH2EVH4QWz9XopAB/pzOw
 bgRaNaaQRdBKm56D3bqC0ACB3/LYCYKQcFfzAqULC2w3QtmZ1gu2jMCpu0SWk3jB3SIH
 XUMexxoxGS7kyMIrASuzcH3QXCKS/+BhPj2nACWMGdu2BwOMdekwqpftexGAGyVWLn1k
 3RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126610; x=1776731410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ic1a2UScFm+l31qFyAeBECmSh2Gb91aNOowxEajWjpI=;
 b=qwFxLYSCj2W21bbZlPjOzcEtoAX0GzBEWj2p5oHuVerXE8pN0pSTOev/k4tSJWR8/g
 52ObLiAMDas4KYdapvRUCM5yk5peRfQw0j0eIez3zucsvhiJb1ENoV0MgwciAw5hrtW9
 uVuIjzKY1JhraD3bBcWOiwA5apc7R/H3fhk37lr/9H2xS43CqP+e7RZPvhkSYBSOw7Yk
 P6GVY2Nv3Udwl1++3ajcbSC5gkT1cKJVzAg1RW/y5kXLvt+59xMuEzL0znwlSs6DXbht
 xl4T1nbOIE4ZScFe9VhyYcx0H6VKQG1as4eAH8uPCiOH3tcqC76HPO+17+690+6Uxv4O
 w2Aw==
X-Gm-Message-State: AOJu0YxLz6JrEJHir6sboOmMsZF9PIbEaSF1KxTAsps1iLOBLhwICipV
 NV3fHQaeHOYo0fT4vOLIOUIBINLncQDIaWF7tDPlyEEqPfOx/OeIH2JjNEiupTWpv67ERfzZ/Ns
 PI210DA0=
X-Gm-Gg: AeBDieviLqDod1PJEEIfUb7fpP18FwIZs/sCtFFVirs+6j5TaGlJbWkCVP7mnXCHQgL
 ZGzJ4el++WIe3OiWUJEKtI7wlqldkYAgYmoMsm8TmZkmlHHwicEeSgwvZXWKQoczm7Xxpd8e5Da
 ni2v8MsP1GjAiiK2YolfFs6DDPAQYi9s68bw+et3njmMWMzZzC4YIruyzKKpM0Nh+wdhowPsFyT
 YgLkZWkfZ9PRdYeB+CPILBoGx9oi44OTOEuIsx1XTnBXdNCttBocCE1mcKwtsFlGl1rT88r0Hxt
 agEmcziYckvHvPxO7uauJUmrPc7XERomOz5KwzbNvQBblr7odxcaCrxXXdiMvDEofbL+jRBz1Xk
 K7Ukc5qTBJ8iBADjbp/ALmnRD+PujKsN9shd5hefKvVYnbau/2faGArdnFZbm5m73fHNheURKrN
 ULJ/V0/57mz0kcf4IMKaFRI7O7t1QHndQnbqJX8Ds8A0UywAoC1L8hT9EhH6IsCD7yQopcvXaI
X-Received: by 2002:a05:600c:4ecb:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488dc76d45amr173706655e9.13.1776126610324; 
 Mon, 13 Apr 2026 17:30:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5df2062sm111489175e9.12.2026.04.13.17.30.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/27] stubs: Rename monitor* -> qmp* files
Date: Tue, 14 Apr 2026 02:29:33 +0200
Message-ID: <20260414003001.97571-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
index 535d1d3398e..eb212c31ac2 100644
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
@@ -496,6 +497,7 @@ M: Christian Borntraeger <borntraeger@linux.ibm.com>
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
@@ -800,6 +805,7 @@ F: include/hw/timer/a9gtimer.h
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
index 7189ff63ed5..2d334a5a8f3 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -78,14 +78,14 @@ if have_system
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


