Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62486FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5c-0000VL-HN; Mon, 27 Apr 2026 17:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5Z-0000OO-2S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:57 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5X-0003X1-A9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BB7A040979;
 Mon, 27 Apr 2026 21:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37916C2BCB5;
 Mon, 27 Apr 2026 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323713;
 bh=KG2fwHQvDISByslvVy41WuAySIFV/sri4ZntnBzQCgY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QrfCq7fg5Gt8lgBWYHXyxT9bxIlTKU6EXx4r+JIfiDYKBcYAUzZ4EGLwpUXOI10hy
 ZWScrmuR0jKxKt1MXAleT1RjQDc7QGoULmGQpN+11y06Jvn5WVXmTIiOS6fd2GhmHH
 875cW+xQjT8IQyC5DTJybpUr5f3yuZ8QkzxeLOJfyZ8V/rYsJZEzwguDqV+vh/ZbgC
 TzH9DD7BoTfJ/WjVw3VTiZSzOLhdHvcyRV4At+8UGx0ccohCopBUqL8PWAvDHyvWwi
 7P4DzzY4PkTT7aEKPkA1Rv2MfrybaYi8rcNm4oauh90IS1lNVYAodbwl8vu40tH6h5
 al9013YmhO8nA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 09/15] linux-user: Define SO_TIMESTAMP*_NEW and
 SO_RCVTIMEIO_NEW
Date: Mon, 27 Apr 2026 23:01:27 +0200
Message-ID: <20260427210133.6016-10-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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


