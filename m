Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8ABFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0v-0000d9-Dy; Mon, 27 Apr 2026 04:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0t-0000cV-OF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0r-0001Wn-US
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so8221006f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277296; x=1777882096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=soongvcfrV5N/fMvpjm2AWSwT0obpT+oO9D8kh7HmCM=;
 b=o3EAJkGdzvkFzsUQjLmpB2D1E2dVH9yA7Dds+Uar2ceTHJqHPRomKQNiAa918FV1Vi
 449mVXEmOhbEpd+0Ksa4k/oJMiUD1WAzCuRMx3TpWzRDenrZCSxKp1hfRB1noIyn5umm
 DyVn1u6nsot9OJ5oVZO6nXx+VYmeBdGKbJDBhBlYGNsVqjkH5F8qWtCAV3siIfl26uEv
 /qh3kXmPATmetUjQCHdUyKYOaTXsqlLKi4iANyH8b4WvaEJiDFeKlxXKRfFi2hZBUhdO
 JPD54612Y2VJ6FVprDbHEL2KACwwNeMpWYDg+g7rVLlw1Qfpe1BDvt6zrpU0OY5BZ4R/
 m4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277296; x=1777882096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=soongvcfrV5N/fMvpjm2AWSwT0obpT+oO9D8kh7HmCM=;
 b=G77OHz9i+YnQDHv0zQz1R585dkjKS0wHbyyEel9NvtfR39mQc+dml7qImXQm/M41DB
 DYrkKsN+NJKsQnSUvdJVvId13gRgc2c+wlaGJwfg5T6aZQX8kfoayTsmBKG6lsqPBKbx
 c4GgglcELtqX4ihBE2EmmFEizQ/fI1JOo4MoKOTGup4lLvZiqIjxYpU2l+8AwjiGI7ZX
 0NobcQ3OUiMRoVc4G6mCss9AvOXFxv3ZY/o0/VfbWx6aTQXnS8O63WBu7HtJJUW/iWqW
 1pVAu/lsTtDfth7K01PWXeLc+mAXGaXqlWWB/PCTuKBvAcV1Uv9qewWwJVq7l6yue4AR
 mCdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CeAsZSiMaDL9OY1po0SGOohfe+qyJoZh5amM4lyeZE5tT39dQiZMSsaFIo4Y7DE69waKGr4h4cPZY@nongnu.org
X-Gm-Message-State: AOJu0YxtAO4wWlFykfnD1mCI1HxdZ0QFizcJxKfpbCiELS52Pk9NAZG+
 DpDEEjMqj9B0Z9HtuNIK5xtae7lzwBsfZC4UEWLdVZRmRutGSLs9td0izapFAvH4CtfTuRXO8jy
 r3dA1XGY=
X-Gm-Gg: AeBDies+Cguvvo2sJjulzdnlvyc+dvLQPleNkX2ZNdqfAIjiLaY2h0AKSel4ZDk4TgD
 b9NwvhYVSYqPLb4SLRtw118hpNL5qz/1DLRbu4p3eBR4ImwJ0sCjcXMFKmNw0U7bMtpp+vVhMj2
 s1ugBfNaJ2rSNkgsuWkWzBRLcl2eoFlmTbCf+Rqar6n+WQRUpcC4zNBJq0OQqogjyuy0GWwGn55
 YcLUOssUKAHaQ31lNS55m+VxZXUwsemt5dYm7JMrxTcbG/czaJ9eUR9aOl+PbX1vFKAvRofudrF
 mHOK4VGNlpYz/TLBD+ECR+kSMGQoYnUvsId2UUlHpQNIGshPXbUHQ++76zCmGbOVauAIdBYC0tU
 1Hxx9aiN3XjGdTyAWQ48rt0H448IZ7wvEPgLau/xIuWNRjaCowoBkscRvda6ysY0lbDLd7/XM48
 ks97OhhnUENTWhX+rSIh207FL9KA8HLyEb1C1XtC1n3OHe/zBN5fY/ZS5riHEn3LFKmUhGpnm3z
 yCzhZIOiPE=
X-Received: by 2002:adf:fad2:0:b0:43f:e439:5c2c with SMTP id
 ffacd0b85a97d-43fe4395ccbmr46157638f8f.1.1777277296026; 
 Mon, 27 Apr 2026 01:08:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm80108909f8f.0.2026.04.27.01.08.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 05/32] stubs: Rename monitor* -> qmp* files
Date: Mon, 27 Apr 2026 10:07:11 +0200
Message-ID: <20260427080738.77138-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
index fda43a7605b..02628ca20cb 100644
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
@@ -798,6 +803,7 @@ F: include/hw/timer/a9gtimer.h
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


