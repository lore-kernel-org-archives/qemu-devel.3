Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D36E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 03:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVjBi-00078Y-LS; Wed, 08 Jan 2025 22:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVjBg-00078N-If
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 22:26:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVjBe-00040W-Um
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 22:26:24 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 821D95C57EB;
 Thu,  9 Jan 2025 03:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A607C4CED3;
 Thu,  9 Jan 2025 03:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736393179;
 bh=5AoBu/zXJxWuKIY1FmCVzFPtyEPj2z3jX147SxIEUL8=;
 h=Date:From:To:Subject:From;
 b=j/aeW3rUmyGdWfkKaVr0UZ37IwLopGXninns83woghCSPdxT32hL/2nf6PiJBrv5z
 9dfh6QowHI43bHPMSSwJ6cIwqriYj+37MWViKht5geLKbjMVxcDmUKPdXOhWW7G0lW
 Nc4c2WNKR1QxYYV9k1P+xX07gl2fXcKZDcQqwwq+WZeSdqPaHecFakh0413+eCLCzc
 sZJZ2Zqh2aR0tnX1PeNteEo0hHkVxAg9FO0f7KgHtTVeP8OFacQJhTEK4v7RGG/hM2
 MUmslEK99h2m1Q+jL7m+IIkzEd0OKLYUX224cdqfkmL41fZF62+uonaD9kIdFjQjiY
 21kcJpJtebWMw==
Date: Thu, 9 Jan 2025 04:26:15 +0100
From: Helge Deller <deller@kernel.org>
To: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: Add missing /proc/cpuinfo fields for sparc
Message-ID: <Z39B1wzNNpndmOxZ@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add some missing fields which may be parsed by userspace
applications.

Signed-off-by: Helge Deller <deller@gmx.de>

v2:
- fixed cpu name and type depending on currently active CPU

diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
index 3bb3134a47..744fa10730 100644
--- a/linux-user/sparc/target_proc.h
+++ b/linux-user/sparc/target_proc.h
@@ -8,7 +8,25 @@
 
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
-    dprintf(fd, "type\t\t: sun4u\n");
+    int i, num_cpus;
+    const char *cpu_type;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    if (cpu_env->def.features & CPU_FEATURE_HYPV) {
+        cpu_type = "sun4v";
+    } else {
+        cpu_type = "sun4u";
+    }
+
+    dprintf(fd, "cpu\t\t: %s (QEMU)\n", cpu_env->def.name);
+    dprintf(fd, "type\t\t: %s\n", cpu_type);
+    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
+    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
+    dprintf(fd, "State:\n");
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "CPU%d:\t\t: online\n", i);
+    }
+
     return 0;
 }
 #define HAVE_ARCH_PROC_CPUINFO

