Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F8E7718E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 04:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPZlU-0000HU-56; Sun, 22 Dec 2024 23:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlR-0000GN-TE
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 23:09:53 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPZlQ-0001PM-B3
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 23:09:53 -0500
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21675fd60feso44372655ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 20:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734926990; x=1735531790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEkjq0W66WCq5brXRIKY0Ob+ncJIl6VOgGA08W2xzgo=;
 b=oa2U1EC8zjAi1S96y2qSDdPtnNO9X1pG/gB/AfvPj7keXuzbnFrDz+poJ66VZ28otQ
 5YkfmplWlzxVZsdl6ln0rmfp4d5L5YBB4jJdsPUgU/g4V0mGdaOLbCJgJXnztNdhu7jr
 syjcy832X6+KSieXTl63Sfjc0YhMQB3Mx0LmqNzxqxEVjY+75DspxjceZyK2ltY78AdO
 K/365bhcPD0K3e7XAM9TtHv6zKx8bqi3Fd5FkEjARfuWZsCq+qBkDQ1pc/S6EWPF4qkt
 vXrOJpAAO6u88i0v5WWQbzHp8pS6Mf8HfUMd/1TEOVFh8FWILzk3uQVi283i7cJhcy+B
 5Y7w==
X-Gm-Message-State: AOJu0YyHRmZJODs3nji3qfkGaGXWMORpj4OQ9D5S7euL19OW3sCv4L41
 8nucP12JW/SvBHjIVpqZZEEnNnT62Lb4yulINJ2DL0mtTBWIkLJkIY48oqvQ
X-Gm-Gg: ASbGncuBc8cCGHmBbdJfSF42egi8SJXqS/uuNV2C/LY2pEplRNMrnmf/IwKFh6plSlM
 MePGDIe0sjsvtyR8Jj5iyC0aRF0f8NEKo8EeOz0duPMxchYSIxAK4XWFyu9N3XzzTIpwsUoaCqV
 jBaJZwC5ax77e7s1MB0NVPqrzG+7T67peNeHot/SvvliKDz+yOdLBpFsHbb8y1k/+L+YEJSX6Ng
 iU6RLbEoo+Zxis3b13hhQ8Qed83NGiUr8tS198ecWAYBVb1LjC8DzMU+o936sYm1Gxbj1x9tV7c
 r7wEa4lUfg==
X-Google-Smtp-Source: AGHT+IE42LHgYuthXRv5QS47k4tJYEmG+mBA2qVN8LcARdg4iKgbEE5uJORdd1U8ubKPZNNb3Nseeg==
X-Received: by 2002:a17:902:ecc2:b0:216:6435:5001 with SMTP id
 d9443c01a7336-219e6f3ab68mr131110755ad.57.1734926990302; 
 Sun, 22 Dec 2024 20:09:50 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c02:c8b4:911f:687c:35b2:bc4e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f4429sm63921115ad.173.2024.12.22.20.09.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Dec 2024 20:09:50 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] vmnet: disable unavailable features on older macOS
Date: Sun, 22 Dec 2024 20:09:44 -0800
Message-ID: <20241223040945.82871-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241223040945.82871-1-j@getutm.app>
References: <20241223040945.82871-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f179.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.167, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some options require macOS 11 or newer APIs. Instead of crashing (target
version not set) or failing to compile (target version set), we will just
return an error when the user tries to use the option.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 net/vmnet-host.c    | 48 +++++++++++++++++++++++++++++++--------------
 net/vmnet-shared.c  | 23 +++++++++++++++++-----
 net/vmnet-bridged.m | 18 ++++++++++++++---
 3 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/net/vmnet-host.c b/net/vmnet-host.c
index 49fb25c224..f3f0ac89e4 100644
--- a/net/vmnet-host.c
+++ b/net/vmnet-host.c
@@ -21,12 +21,28 @@
 static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetHostOptions *options = &(netdev->u.vmnet_host);
-    QemuUUID net_uuid;
 
-    if (options->net_uuid &&
-        qemu_uuid_parse(options->net_uuid, &net_uuid) < 0) {
-        error_setg(errp, "Invalid UUID provided in 'net-uuid'");
-        return false;
+    if (__builtin_available(macOS 11, *)) {
+        QemuUUID net_uuid;
+        if (options->net_uuid &&
+            qemu_uuid_parse(options->net_uuid, &net_uuid) < 0) {
+            error_setg(errp, "Invalid UUID provided in 'net-uuid'");
+            return false;
+        }
+    } else {
+        if (options->has_isolated) {
+            error_setg(errp,
+                       "vmnet-host.isolated feature is "
+                       "unavailable: outdated vmnet.framework API");
+            return false;
+        }
+
+        if (options->net_uuid) {
+            error_setg(errp,
+                       "vmnet-host.net-uuid feature is "
+                       "unavailable: outdated vmnet.framework API");
+            return false;
+        }
     }
 
     if ((options->start_address ||
@@ -53,16 +69,18 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_operation_mode_key,
                               VMNET_HOST_MODE);
 
-    xpc_dictionary_set_bool(if_desc,
-                            vmnet_enable_isolation_key,
-                            options->isolated);
-
-    QemuUUID net_uuid;
-    if (options->net_uuid) {
-        qemu_uuid_parse(options->net_uuid, &net_uuid);
-        xpc_dictionary_set_uuid(if_desc,
-                                vmnet_network_identifier_key,
-                                net_uuid.data);
+    if (__builtin_available(macOS 11, *)) {
+        xpc_dictionary_set_bool(if_desc,
+                                vmnet_enable_isolation_key,
+                                options->isolated);
+
+        QemuUUID net_uuid;
+        if (options->net_uuid) {
+            qemu_uuid_parse(options->net_uuid, &net_uuid);
+            xpc_dictionary_set_uuid(if_desc,
+                                    vmnet_network_identifier_key,
+                                    net_uuid.data);
+        }
     }
 
     if (options->start_address) {
diff --git a/net/vmnet-shared.c b/net/vmnet-shared.c
index 4726b07253..e6c65f3417 100644
--- a/net/vmnet-shared.c
+++ b/net/vmnet-shared.c
@@ -21,6 +21,17 @@ static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetSharedOptions *options = &(netdev->u.vmnet_shared);
 
+    if (__builtin_available(macOS 11, *)) {
+        /* clang requires a true branch */
+    } else {
+        if (options->has_isolated) {
+            error_setg(errp,
+                       "vmnet-shared.isolated feature is "
+                       "unavailable: outdated vmnet.framework API");
+            return false;
+        }
+    }
+
     if ((options->start_address ||
          options->end_address ||
          options->subnet_mask) &&
@@ -66,11 +77,13 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                   options->subnet_mask);
     }
 
-    xpc_dictionary_set_bool(
-        if_desc,
-        vmnet_enable_isolation_key,
-        options->isolated
-    );
+    if (__builtin_available(macOS 11, *)) {
+        xpc_dictionary_set_bool(
+            if_desc,
+            vmnet_enable_isolation_key,
+            options->isolated
+        );
+    }
 
     return if_desc;
 }
diff --git a/net/vmnet-bridged.m b/net/vmnet-bridged.m
index a04a14fa11..13fa2d16b6 100644
--- a/net/vmnet-bridged.m
+++ b/net/vmnet-bridged.m
@@ -88,6 +88,16 @@ static bool validate_options(const Netdev *netdev, Error **errp)
         return false;
     }
 
+    if (__builtin_available(macOS 11, *)) {
+        /* clang requires a true branch */
+    } else {
+        if (options->has_isolated) {
+            error_setg(errp,
+                       "vmnet-bridged.isolated feature is "
+                       "unavailable: outdated vmnet.framework API");
+            return false;
+        }
+    }
     return true;
 }
 
@@ -106,9 +116,11 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_shared_interface_name_key,
                               options->ifname);
 
-    xpc_dictionary_set_bool(if_desc,
-                            vmnet_enable_isolation_key,
-                            options->isolated);
+    if (__builtin_available(macOS 11, *)) {
+        xpc_dictionary_set_bool(if_desc,
+                                vmnet_enable_isolation_key,
+                                options->isolated);
+    }
 
     return if_desc;
 }
-- 
2.41.0


