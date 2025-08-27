Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B12CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNql-0005Nl-Eq; Wed, 27 Aug 2025 17:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNqj-0005N0-3b
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:38:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urNqh-0004HK-9U
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:38:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-771f90a45easo315290b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756330709; x=1756935509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TcqGqwXH8Y34JU3tiokZ9VuiXu0XJnAQ+5ZmwRYI344=;
 b=lYWrFsnlP+pUjkTc6nw46Bweg2BbW1Q9IhAfGnGgi/BMKPTP2oX8fr8YLFEdMDBXpQ
 vfEnjJzrkG7GeIdg3QesY+P7qg1S1x2KNnJDQhfnqLQyt/PMQasqWJMYikJyGG8M0awO
 6OShdP4Rqbkf/3OLOgZy/1MRVKxPJ6JzDW32Rzi6RJbQVGubxMzIRLrG16V3N7HZwrii
 RAE1CS/58qrqPpA99XKI410L+qh8OUaphv4y8axzkB9Kwavvq5y5oPBHGG3ups0fAjkw
 VNn8aVWTHdm0FsgXth5gCMKPznIpD1LyJi7Y60ioYjbqKiqp3LbbmdF7EmDWNzhu9+7U
 i52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756330709; x=1756935509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcqGqwXH8Y34JU3tiokZ9VuiXu0XJnAQ+5ZmwRYI344=;
 b=d0aML4iB+dB9BabCKU7ns/Ce+L4wq8Wb7Ecq37b1UibRXAAl/PA9VCYTA83BMcbX3y
 YBhsKnzs3M8VjDJUpqU8JGhxPERPWOSZAgMr37opzwwN1xoTB1QcCImvSO3XVgPU7XzJ
 qt3g6eEpe1ad4zG9jDBUTQe6R1ZsjJuDOP8FM8Fw6QU2I/lVVAmleDzc106mnJqvcgXI
 X0cNNkP0J2bqqdPt6DpxoF3zBKjCj+jZI1/EERXPqKIIqgKIKk2dJxhsHxFCLVaQI/p9
 gQU7CyaynrvYTfbVxibMYzv2HEuBmpeDsNqAWAGasENxC+D5C2fsqMBjyMSWVvnVsLxG
 SVEg==
X-Gm-Message-State: AOJu0Yye3nJQSTieWNWErwSiMQzx+N1rztYchphLCyFr6uUc/G7r5pdO
 t92IUR3bYj8mlx1LYdch7NT7KUDG0IS/oHs33iax79mHPTIhHO8HBX6+C79deZU8x5Y9uBTPN+p
 e0y8nWTU=
X-Gm-Gg: ASbGncsb0PaMHzX8izWaJv3yjPOORqCB7Z9IhGI1koFhDksaVgeIuIyCr2zh+8meY8K
 7zPLPZIDuj2wGW8ZDBmjXPB/H0J/+FFq0gBpZRuAE7VjY8V9yD9ldIkIoerEqtjWSNvz4IENRjW
 KrIKfSiyw/hy1QjfOLfULTSZ0qDUSJhUv2dUnjmkvCo4y3VCTD9ezWxdazs7r6iihU+wWiRXJel
 4dS4R0x/QZ5AWH9U0kK6nRfUhpEw62Pi31X0os7Su8hY0Sd8l1i7brHXSaqYtJOacnouRQ0BnOW
 hsKe8zYPS9lLmwm1brQPLLMzstZq5oo4Yd1YhdgKxeXcpj32uqrn4+Z1vbkwIDRshpN3H2lsDL0
 R8C3/BUFUjyW37bkZ17LZ03Yk/Q==
X-Google-Smtp-Source: AGHT+IEuLPBTWGRnNbTlH6nQ0r+s0RGpEYrW4SdvN+oG6a6ZBS4LC3bHrBdzpdXww5lCLbo1q7tjjg==
X-Received: by 2002:a05:6a00:a1e:b0:76b:dd2e:5b89 with SMTP id
 d2e1a72fcca58-7702f9d8b6cmr33331644b3a.6.1756330709358; 
 Wed, 27 Aug 2025 14:38:29 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7705406d213sm11414109b3a.81.2025.08.27.14.38.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 14:38:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Tidy print_socket_protocol
Date: Thu, 28 Aug 2025 07:38:20 +1000
Message-ID: <20250827213820.37624-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 102 ++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 50 deletions(-)
---
Based-on: 20250827095412.2348821-1-l.stelmach@samsung.com
("[PATCH] linux-user: do not print IP socket options by default")


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


