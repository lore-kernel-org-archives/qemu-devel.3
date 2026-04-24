Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D3FE51F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCZ9-0001y6-PS; Fri, 24 Apr 2026 05:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYZ-0001eB-NY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:41 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGCYW-0001HJ-Uh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:10:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 11581600CB;
 Fri, 24 Apr 2026 09:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F51C2BCB4;
 Fri, 24 Apr 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777021835;
 bh=KG2fwHQvDISByslvVy41WuAySIFV/sri4ZntnBzQCgY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tyReEN4/9ySbmpiDMrHWpAZO+ieFyaqIrAYd6RVwyOPjkJF1FWfpDIWbm1P9SKtCR
 9vejfHtSUeearcmXURD3xAyyAnwh/Q/ChSTYApr5X8I21DQLpN/b7PZ3G7K8g1tkgv
 X66j79pYCDRUEZD96PaHMGB9QwYOEOSoj57shB11p4Xow7HHMAlgmYL5t2c+VJnidl
 IxytNXHYitOw39hJOWAUg7blPZXJMPhUUWbyh2NM+6bwYEU0v/neLssXpoA34zHulS
 T9rIHsJyYhHDz2YjgTruMYiUzJHBx8o1/Asp6TSLRZ203ONcC4AQ7xIyZ+lQCJEj65
 m4vWgwcZ1sA7A==
From: Helge Deller <deller@kernel.org>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/4] linux-user: Define SO_TIMESTAMP*_NEW and SO_RCVTIMEIO_NEW
Date: Fri, 24 Apr 2026 11:08:48 +0200
Message-ID: <20260424091024.23495-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091024.23495-1-deller@kernel.org>
References: <20260424091024.23495-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Define the entries which always use the 64-bit timestamps.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/alpha/sockbits.h   | 7 +++++++
 linux-user/generic/sockbits.h | 8 ++++++++
 linux-user/hppa/sockbits.h    | 7 +++++++
 linux-user/mips/sockbits.h    | 7 +++++++
 linux-user/sparc/sockbits.h   | 7 +++++++
 5 files changed, 36 insertions(+)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index d54dc98c09..0201ab9374 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -75,6 +75,13 @@
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
 #define TARGET_SO_NOFCS     43
 
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index b3b4a8e44c..33e6c3a572 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -58,4 +58,12 @@
 
 #define TARGET_SO_PROTOCOL             38
 #define TARGET_SO_DOMAIN               39
+
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 23f69a3293..2304dbbf79 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -67,6 +67,13 @@
 
 #define TARGET_SO_CNX_ADVICE           0x402E
 
+#define TARGET_SO_TIMESTAMP_NEW        0x4038
+#define TARGET_SO_TIMESTAMPNS_NEW      0x4039
+#define TARGET_SO_TIMESTAMPING_NEW     0x403A
+
+#define TARGET_SO_RCVTIMEO_NEW         0x4040
+#define TARGET_SO_SNDTIMEO_NEW         0x4041
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 562cad88e2..1f479d54aa 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -71,6 +71,13 @@
 #define TARGET_SO_RCVBUFFORCE          33
 #define TARGET_SO_PASSSEC              34
 
+#define TARGET_SO_TIMESTAMP_NEW        63
+#define TARGET_SO_TIMESTAMPNS_NEW      64
+#define TARGET_SO_TIMESTAMPING_NEW     65
+
+#define TARGET_SO_RCVTIMEO_NEW         66
+#define TARGET_SO_SNDTIMEO_NEW         67
+
 /** sock_type - Socket types
  *
  * Please notice that for binary compat reasons MIPS has to
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 0a822e3e1f..42ecfdc8f9 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -61,6 +61,13 @@
 #define TARGET_SO_TIMESTAMPING         0x0023
 #define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
 
+#define TARGET_SO_TIMESTAMP_NEW        0x0046
+#define TARGET_SO_TIMESTAMPNS_NEW      0x0042
+#define TARGET_SO_TIMESTAMPING_NEW     0x0043
+
+#define TARGET_SO_RCVTIMEO_NEW         0x0044
+#define TARGET_SO_SNDTIMEO_NEW         0x0045
+
 #define TARGET_SO_RXQ_OVFL             0x0024
 
 #define TARGET_SO_WIFI_STATUS          0x0025
-- 
2.53.0


