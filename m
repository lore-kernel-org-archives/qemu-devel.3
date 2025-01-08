Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DDE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdPz-0008Td-80; Wed, 08 Jan 2025 16:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVdPy-0008TV-31
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:16:46 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVdPw-0002Vz-79
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:16:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4D4895C5694;
 Wed,  8 Jan 2025 21:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30991C4CED3;
 Wed,  8 Jan 2025 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736370995;
 bh=I7GRQFr384582pMoul1vLbgXHyoJtm1fafNIJKxg0T4=;
 h=Date:From:To:Subject:From;
 b=sEIwYTvAromNEIurvxQLPtaF235kDj29YRgUckiVKawphfaVeAFaLdw4QRDs0T5IL
 xmfB3jzV6vKhpP7kWHoPCN0y8VcvXHZbFrqUE3mXpnNKka/SpFIIGe1JdLCskVaDHA
 0pR1cS/4g0aqxFranyRYGTzrgYyC6cClCrh3pun06doDwQYaBrII5LAlf0H4GbcC//
 eaoYfd7K4sue8jPu5wpv2fIsGbGOWEpK3qH340bo16vau+5ZmGbegqzL7S8JO0mddR
 JYwWgQoDAJoKc6spH0l/8A1l3A9AUbGw+8WWrPjkU9mrytvWjxI5DSQKdZCowE9jHP
 3jUA/xiUQnEDg==
Date: Wed, 8 Jan 2025 22:16:31 +0100
From: Helge Deller <deller@kernel.org>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Add missing /proc/cpuinfo fields for sparc
Message-ID: <Z37rL5jVYpOk6ufc@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
index 3bb3134a47..172d089fed 100644
--- a/linux-user/sparc/target_proc.h
+++ b/linux-user/sparc/target_proc.h
@@ -8,7 +8,23 @@
 
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
+    int i, num_cpus;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+    dprintf(fd, "cpu\t\t: TI UltraSparc II QEMU (BlackBird)\n");
+    dprintf(fd, "fpu\t\t: UltraSparc II integrated FPU\n");
+    dprintf(fd, "promlib\t\t: Version 3 Revision 17\n");
+    dprintf(fd, "prom\t\t: 3.17.0\n");
     dprintf(fd, "type\t\t: sun4u\n");
+    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
+    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
+    dprintf(fd, "MMU Type\t: Spitfire\n");
+    dprintf(fd, "State:\n");
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "CPU%d:\t\t: online\n", i);
+    }
+
     return 0;
 }
 #define HAVE_ARCH_PROC_CPUINFO

