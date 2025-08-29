Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E68ACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjD-0006Aa-Qi; Sat, 30 Aug 2025 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WY-0002dm-2l
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WU-0002Ya-WA
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:45 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2490753b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506281; x=1757111081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOcWUc5rHijwQW3sC3RaBXrOkg4imftVqoCeUx1b1us=;
 b=HGDZ5/PPPPUzCT0QP20gHWeZmiFFKlyFCbDM/g93bzV5bnC3Qs+rwxcq7WKdAgLp9C
 bIv4BblliapAShNE8OPjJafHMWAnd4Z2Rk/MRk8VPhG+UYonAWcxGxqEP6LRV44aN1el
 MDxBOKrhN/dmGkb75AtVRLCTt0BHlQ08XhIVlRjNGx/tvHWpL0CD7PxagSTEt/zc0RDU
 TROwn7S3toaMgI7r596Ayj3bjil8o8S7sOqx++pvvYRCgwO5esglMMzkhUYESrY1/ld/
 mQx8ZNCQfzFAW4v/b5TOLaT6YcFAj9w0oyPjSyCoURMFS3rOsRyhZdP1q09EmYtDOriL
 iIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506281; x=1757111081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOcWUc5rHijwQW3sC3RaBXrOkg4imftVqoCeUx1b1us=;
 b=BHvhMnKu9rcFKCOARtZNVdJg+/x227usPiiLTCxGf4udo6pJ7w+3ad/1ekFt8iLTOt
 dAD2wQRrGUTrDMG0qGGJOEWmVhERffvksIMyWgS29MWdoO73iVMVwDkviijjT16Ky6so
 oKs2/6Kl5G98TIQSZS5zhqA0MOc0jY2RXkRtzasngRoVfMBjmnsG8aNgszMDJvf/TPpR
 tXqtajJV+unVq0OrKZAk6rKfGA5ZP9hfR4OL+p6iuJv9/eSMrDKzAXiZSloSBwCkbKOH
 SlP1OEGpbgfhPoHHelkdjnUUQKuGUopwgVT31RuqHWreAskcSoAkuOc2j2fINSufqnA8
 T5qg==
X-Gm-Message-State: AOJu0YxA8V6JpjVkah3eHvYyMmrYWBjNFt1s+VNh3YV97mrECb3MNNbv
 ZtzBWBhVzMMi3AmnBZQ2hxywK6sC1IWnwB+kyw0CrYZ1+gmBNeiYwXIIqus9bLwCRYlKU8W+W2q
 GJvMO2vo=
X-Gm-Gg: ASbGncvvSmjmt4CPByBNq97Jnq49GvcMA6n4yznd09H9xx4DhjgpYYpjYFk52BVxu7Z
 ltO3lli6+a4lkIf0F/xenZwuPyNvDATRuo7z0ohDaSt+Yjlctydyk+McflusDMos55pJrJ820f+
 mjBsuZddyx1rM6DIo956DsbG2LtvlVaC3wo4XqDbmUc1Wu4OAFqkBKlGxXtiiimQxYLIF9DTjAU
 kswWfYZ/SRPNk6zvM/12AbmaxCJcF97LpMXbHgEiMYb4YHgEp/8VEhdY6vScan+JIv+IL0tKlXl
 cUoqHyl6oWwSJicwl90mYHzjpxISdexGua9NzYq01MXeSVLnr8FpwzFSbNSxWr9ERpWF/hbgeHy
 0JlpXbiJdTuF1VVnxvDCeT6mDSmM60PJvrzpYrvybYiRtUnklYUzBw0yPM9o8
X-Google-Smtp-Source: AGHT+IHuUveqfkfC+6KXlw/14GbFhELbZIwmXziACfIQGIKoyWGgbeNp6mlG+cxoKUQzzqEETObESw==
X-Received: by 2002:a05:6a00:1482:b0:771:ea2e:b002 with SMTP id
 d2e1a72fcca58-7723e22d0a2mr244843b3a.10.1756506281271; 
 Fri, 29 Aug 2025 15:24:41 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/91] linux-user: Tidy print_socket_protocol
Date: Sat, 30 Aug 2025 08:22:59 +1000
Message-ID: <20250829222427.289668-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Sink all of the qemu_log calls to the end, collecting only
a string for the name, if identified.  Merge separate if
blocks into one switch.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 102 ++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 786354627a..1233ebceb0 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -499,116 +499,118 @@ print_socket_type(int type)
 static void
 print_socket_protocol(int domain, int type, int protocol)
 {
-    if (domain == AF_PACKET ||
-        (domain == AF_INET && type == TARGET_SOCK_PACKET)) {
-        switch (protocol) {
-        case 0x0003:
-            qemu_log("ETH_P_ALL");
-            break;
-        default:
-            qemu_log("%d", protocol);
-        }
-        return;
-    }
+    const char *name = NULL;
 
-    if (domain == PF_NETLINK) {
+    switch (domain) {
+    case AF_PACKET:
+        switch (protocol) {
+        case 3:
+            name = "ETH_P_ALL";
+            break;
+        }
+        break;
+
+    case PF_NETLINK:
         switch (protocol) {
         case NETLINK_ROUTE:
-            qemu_log("NETLINK_ROUTE");
+            name = "NETLINK_ROUTE";
             break;
         case NETLINK_UNUSED:
-            qemu_log("NETLINK_UNUSED");
+            name = "NETLINK_UNUSED";
             break;
         case NETLINK_USERSOCK:
-            qemu_log("NETLINK_USERSOCK");
+            name = "NETLINK_USERSOCK";
             break;
         case NETLINK_FIREWALL:
-            qemu_log("NETLINK_FIREWALL");
+            name = "NETLINK_FIREWALL";
             break;
         case NETLINK_SOCK_DIAG:
-            qemu_log("NETLINK_SOCK_DIAG");
+            name = "NETLINK_SOCK_DIAG";
             break;
         case NETLINK_NFLOG:
-            qemu_log("NETLINK_NFLOG");
+            name = "NETLINK_NFLOG";
             break;
         case NETLINK_XFRM:
-            qemu_log("NETLINK_XFRM");
+            name = "NETLINK_XFRM";
             break;
         case NETLINK_SELINUX:
-            qemu_log("NETLINK_SELINUX");
+            name = "NETLINK_SELINUX";
             break;
         case NETLINK_ISCSI:
-            qemu_log("NETLINK_ISCSI");
+            name = "NETLINK_ISCSI";
             break;
         case NETLINK_AUDIT:
-            qemu_log("NETLINK_AUDIT");
+            name = "NETLINK_AUDIT";
             break;
         case NETLINK_FIB_LOOKUP:
-            qemu_log("NETLINK_FIB_LOOKUP");
+            name = "NETLINK_FIB_LOOKUP";
             break;
         case NETLINK_CONNECTOR:
-            qemu_log("NETLINK_CONNECTOR");
+            name = "NETLINK_CONNECTOR";
             break;
         case NETLINK_NETFILTER:
-            qemu_log("NETLINK_NETFILTER");
+            name = "NETLINK_NETFILTER";
             break;
         case NETLINK_IP6_FW:
-            qemu_log("NETLINK_IP6_FW");
+            name = "NETLINK_IP6_FW";
             break;
         case NETLINK_DNRTMSG:
-            qemu_log("NETLINK_DNRTMSG");
+            name = "NETLINK_DNRTMSG";
             break;
         case NETLINK_KOBJECT_UEVENT:
-            qemu_log("NETLINK_KOBJECT_UEVENT");
+            name = "NETLINK_KOBJECT_UEVENT";
             break;
         case NETLINK_GENERIC:
-            qemu_log("NETLINK_GENERIC");
+            name = "NETLINK_GENERIC";
             break;
         case NETLINK_SCSITRANSPORT:
-            qemu_log("NETLINK_SCSITRANSPORT");
+            name = "NETLINK_SCSITRANSPORT";
             break;
         case NETLINK_ECRYPTFS:
-            qemu_log("NETLINK_ECRYPTFS");
+            name = "NETLINK_ECRYPTFS";
             break;
         case NETLINK_RDMA:
-            qemu_log("NETLINK_RDMA");
+            name = "NETLINK_RDMA";
             break;
         case NETLINK_CRYPTO:
-            qemu_log("NETLINK_CRYPTO");
+            name = "NETLINK_CRYPTO";
             break;
         case NETLINK_SMC:
-            qemu_log("NETLINK_SMC");
-            break;
-        default:
-            qemu_log("%d", protocol);
+            name = "NETLINK_SMC";
             break;
         }
-        return;
-    }
+        break;
 
-    if (domain == AF_INET || domain == AF_INET6) {
+    case AF_INET:
+    case AF_INET6:
         switch (protocol) {
+        case 3:
+            if (domain == AF_INET && type == TARGET_SOCK_PACKET) {
+                name = "ETH_P_ALL";
+            }
+            break;
         case IPPROTO_IP:
-            qemu_log("IPPROTO_IP");
+            name = "IPPROTO_IP";
             break;
         case IPPROTO_TCP:
-            qemu_log("IPPROTO_TCP");
+            name = "IPPROTO_TCP";
             break;
         case IPPROTO_UDP:
-            qemu_log("IPPROTO_UDP");
+            name = "IPPROTO_UDP";
             break;
         case IPPROTO_RAW:
-            qemu_log("IPPROTO_RAW");
-            break;
-        default:
-            qemu_log("%d", protocol);
+            name = "IPPROTO_RAW";
             break;
         }
-        return;
+        break;
     }
-    qemu_log("%d", protocol);
-}
 
+    if (name) {
+        qemu_log("%s", name);
+    } else {
+        qemu_log("%d", protocol);
+    }
+}
 
 #ifdef TARGET_NR__newselect
 static void
-- 
2.43.0


