Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB72F4613C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4h4F-0004gV-MI; Mon, 23 Mar 2026 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4h4B-0004g2-Qc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:19:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4h48-0002EQ-I0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:19:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso2288175e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774279176; x=1774883976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NOEBFAr9NIyUeJhcmsPDZUWYMCRxOf1h9zZJVvCw+wY=;
 b=qJGdALnYaULHxRDmcST4CYHcSJkeXDScV87OdrwEy9B7YuGF+p7DOA8u4VCOnxyLS+
 HcE8NtCYbTYn9Al+n3pWUYrIOrW/UAkve/f3aF+BZ6n38S8N+hueQHuqxVTeNlrhTKRK
 UDi6yzgbPays097P60Zw4Tijpfod2ieFt4lySz+HfbkcXWL45ib3twl6i4m5gzBA+Jgu
 8M/jYKUxng5QaMURWQtKPwl4oqZsvPv5if+PzRwZUXX0x2qee0EFpkXHjJWiOsg9bd0R
 TSYGOJBiLqyyNIetuJsrlcGBDBm2Wt22+stVheUKXylsbbJWNULW4xELYacOVayAhVbl
 C3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774279176; x=1774883976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOEBFAr9NIyUeJhcmsPDZUWYMCRxOf1h9zZJVvCw+wY=;
 b=dnnCz2mzZsoLIxgqEgiRWFOPMqgTdywmyloq4bTnLBbNbpFZp8ErDmqbBVHz1GMzLz
 yN/tPeYBiSJo7On1b67f4jlT1HRX8Cq60cznHdzxlfgVUwBc4VEKIk3kbY+/icPT/GtG
 TaG5noLOIyQNSkCSH3V4f7D43/ISDQzVb7YH3lt6Aw0ssiNoMylrHudGjyA1LoPyhgOJ
 rx25ZP86UCIBBhmpHi2l9wbHxTWQK/bhfYc7+gZ6BZGYInck05pz9pe/bmEUinUTb1sh
 wF+MxXcCt+rDyOriyq8D3qwTjGnLpy7SZu+NV767C578dFwvTBJydXCOflyRUQLrU09S
 Wi4w==
X-Gm-Message-State: AOJu0YzQhCjg4lGgiwosDbBqPLOBSnF3SkgsOaoXdY9VaDpvn3j9Y5Mi
 qkzg+dMV2jBeTqb1caENXt8OkuQEj1ER4r9bKZ665I9abc9J8POQ0tHeBDEX+uI495t2ExH+O+V
 /KBooEJ4=
X-Gm-Gg: ATEYQzyRCxTd4vF8Ns+A91tkWWn6sfAYjC5necAJLEdyJQgp42YMXnmtX+hgBJJo2aW
 KKGTkq/DfKIb8DJp9/MOOUkyv45iRqN0c2VXKR2CzitFzGMGNhHNSVBbe7AUOt2mdHsXzqeIqZn
 YNVcQjQSitg9QloOyi071c/GaqRxqQOTLUJXCsbr5YjaA1qFJKOOcoxAGdwCkv0gmMZqf9ByvUu
 9GKINBxJwppcRjAkpxC+BJLHzRvk9CmS63PsOOXkXfY/GUZTms0nd0gH90Ws3ikGQ2c4nMubdtH
 GSX98Xd77S7QOIS+U8KFFPOBqAorGq59TiyrYFRycsYdE9MrNPeRjuXzCIN9jUhorugHcecjZLV
 R1EWeta7FMwtfehD6IxuYYW8eymxU9pR0RbLlakq6pxYgYyigPVyCQMIA74mus31mV078QJzVO2
 wJLXETgWAeIjMAYrffLMIQMU2p8+o7FJ3FS9z+F183jSRwTwXSTlXemqQR/5USycaIcFHX+89J
X-Received: by 2002:a05:600c:319c:b0:487:288:1199 with SMTP id
 5b1f17b1804b1-4870288126emr97639285e9.28.1774279176375; 
 Mon, 23 Mar 2026 08:19:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm423162975e9.0.2026.03.23.08.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 08:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
Date: Mon, 23 Mar 2026 16:19:34 +0100
Message-ID: <20260323151934.92880-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

We use "deprecated since ..." and "removed in ...".
Replace "since" by "removed in" for removed features.

Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument @detach")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 557a24679a1..e75db084108 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -782,8 +782,8 @@ without reporting any destination threads, or non-multifd source
 threads).  For debugging purpose, please use ``-name
 $VM,debug-threads=on`` instead.
 
-``migrate`` argument ``detach`` (since 11.0)
-''''''''''''''''''''''''''''''''''''''''''''
+``migrate`` argument ``detach`` (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
 
 This argument has always been ignored.
 
@@ -932,14 +932,14 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
-32-bit MIPS (since 10.2)
-''''''''''''''''''''''''
+32-bit MIPS (removed in 10.2)
+'''''''''''''''''''''''''''''
 
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
-32-bit PPC (since 10.2)
-'''''''''''''''''''''''
+32-bit PPC (removed in 10.2)
+''''''''''''''''''''''''''''
 
 The QEMU project no longer supports 32-bit host builds.
 
@@ -1172,8 +1172,8 @@ Mips ``mipssim`` machine (removed in 10.2)
 Linux dropped support for this virtual machine type in kernel v3.7, and
 there was also no binary available online to use with that board.
 
-Arm ``ast2700a0-evb`` machine (since 11.0)
-''''''''''''''''''''''''''''''''''''''''''
+Arm ``ast2700a0-evb`` machine (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
 
 The ``ast2700a0-evb`` machine represents the first revision of the AST2700
 and serves as the initial engineering sample rather than a production version.
@@ -1290,8 +1290,8 @@ by using ``-machine graphics=off``.
 
 The 'pvrdma' device and the whole RDMA subsystem have been removed.
 
-``-device sd-card,spec_version=1`` (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''''''
+``-device sd-card,spec_version=1`` (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 SD physical layer specification v2.00 supersedes the v1.10 one.
 
@@ -1396,21 +1396,21 @@ device driver such as RBD.
 VFIO devices
 ------------
 
-``-device vfio-calxeda-xgmac`` (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''
+``-device vfio-calxeda-xgmac`` (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''
 The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
 10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
 string) to a guest. Calxeda HW has been ewasted now and there is no point
 keeping that device.
 
-``-device vfio-amd-xgbe`` (since 10.2)
-''''''''''''''''''''''''''''''''''''''
+``-device vfio-amd-xgbe`` (removed in 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
 The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
 to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
 is not supported anymore and there is no point keeping that device.
 
-``-device vfio-platform`` (since 10.2)
-''''''''''''''''''''''''''''''''''''''
+``-device vfio-platform`` (removed in 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
 The vfio-platform device allows to assign a host platform device
 to a guest in a generic manner. Integrating a new device into
 the vfio-platform infrastructure requires some adaptation at
-- 
2.53.0


