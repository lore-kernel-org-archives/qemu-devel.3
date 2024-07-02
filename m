Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD510C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfy-0006kE-6y; Tue, 02 Jul 2024 01:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfw-0006Zt-Qq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfu-0007jH-Rx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:03:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36743abace4so3058669f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896607; x=1720501407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqSkcaHksS2cqMSoL7Eku8EtIEifuvQ5Pl0L19IlD0A=;
 b=B20hqhmICiiAkIiiB3zmghz23/lx1cZ9fsATCi+BbR+QzPjjK0Z3jrxAmbqZRJ2vRb
 0FOEaxnEgyYxmQCvlLN19mvcLbvKeuutFg+EJRr6kVReiWms5FN1PK9fTAGQxXVUmsOa
 FCvZymuSp0cDamW6Hzt4GcjDba730lnVVla40TQYxlCrpClCAQ8unukRBpaOXzRD/ZnA
 /y7yyRCl6ftKQNAaJxufEMZnZ99xQwwhXHxDR+1+ClEt6jWZK7As2xtLC53kFFJ+DeP/
 QcEDjWqbiJwrvjiq9LbsP3UPXE7ojXPbwEkssem0IOpkuJON1AuTzp9YhzKtrtI36fft
 lm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896607; x=1720501407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqSkcaHksS2cqMSoL7Eku8EtIEifuvQ5Pl0L19IlD0A=;
 b=O67VmY5/h93uTViBULVI0far57HI3p/On7Eqie4EpdfutieUD+svqUawcMW38YVVxM
 WhQ6vCFDz/11jc4dPWtAiNgLz1zHpy3q70jeFR6VJD5nwEczuxjZmNL2Jz6UehOcJBFD
 4H6wYl1njp30m3IAivcypWj3dYUHWvyepSH68HAMBS6drDIePP3Cuymka62YhD8Eqv2M
 j3J6CJlKY9JMLga2QLO4C3tP5cWdg9YdL2jPhXoRIpFgUfAFr8lcVn59HhGBb6ybSzSV
 A+6lXO3UAr8TCFk9JShDXQAmvj7RNOtfBbfVjKcyuaiQ937bBE8nlH3jK5dS1rRdur5e
 wOcQ==
X-Gm-Message-State: AOJu0YxwSyQsTFn6g8AW5bpNRh37QPugHUxpj5ccJos33l1CpIht7KoC
 x1XqEt0gkloJBRkLpf/ZQv3kBx0hsTHjTpzXVOwj6HAx3GA1eY1CB59glBXzEuztX5AEqLwd+KH
 G
X-Google-Smtp-Source: AGHT+IGumnLFzdNEvjn/7mA/AIS+is9JD1ebCdr7fsuOUDOjfmCSSAGBVPlDTGu8nIXCBV9VBODgAA==
X-Received: by 2002:a5d:5987:0:b0:363:776:821b with SMTP id
 ffacd0b85a97d-3676045b4a0mr10874244f8f.0.1719896606899; 
 Mon, 01 Jul 2024 22:03:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc4c9sm11968503f8f.86.2024.07.01.22.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:03:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/22] net/vmnet: Drop ifdef for macOS versions older than 12.0
Date: Tue,  2 Jul 2024 07:01:11 +0200
Message-ID: <20240702050112.35907-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240629-macos-v1-4-6e70a6b700a0@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/vmnet-host.c    | 24 +-----------------------
 net/vmnet-shared.c  | 13 -------------
 net/vmnet-bridged.m | 13 +------------
 net/vmnet-common.m  |  3 ---
 4 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/net/vmnet-host.c b/net/vmnet-host.c
index 1f95f7343a..49fb25c224 100644
--- a/net/vmnet-host.c
+++ b/net/vmnet-host.c
@@ -21,31 +21,13 @@
 static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetHostOptions *options = &(netdev->u.vmnet_host);
-
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-
     QemuUUID net_uuid;
+
     if (options->net_uuid &&
         qemu_uuid_parse(options->net_uuid, &net_uuid) < 0) {
         error_setg(errp, "Invalid UUID provided in 'net-uuid'");
         return false;
     }
-#else
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-host.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-
-    if (options->net_uuid) {
-        error_setg(errp,
-                   "vmnet-host.net-uuid feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
 
     if ((options->start_address ||
          options->end_address ||
@@ -71,9 +53,6 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_operation_mode_key,
                               VMNET_HOST_MODE);
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-
     xpc_dictionary_set_bool(if_desc,
                             vmnet_enable_isolation_key,
                             options->isolated);
@@ -85,7 +64,6 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                 vmnet_network_identifier_key,
                                 net_uuid.data);
     }
-#endif
 
     if (options->start_address) {
         xpc_dictionary_set_string(if_desc,
diff --git a/net/vmnet-shared.c b/net/vmnet-shared.c
index 40c7306a75..4726b07253 100644
--- a/net/vmnet-shared.c
+++ b/net/vmnet-shared.c
@@ -21,16 +21,6 @@ static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetSharedOptions *options = &(netdev->u.vmnet_shared);
 
-#if !defined(MAC_OS_VERSION_11_0) || \
-    MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-shared.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
-
     if ((options->start_address ||
          options->end_address ||
          options->subnet_mask) &&
@@ -76,14 +66,11 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                   options->subnet_mask);
     }
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     xpc_dictionary_set_bool(
         if_desc,
         vmnet_enable_isolation_key,
         options->isolated
     );
-#endif
 
     return if_desc;
 }
diff --git a/net/vmnet-bridged.m b/net/vmnet-bridged.m
index 76a28abe79..a04a14fa11 100644
--- a/net/vmnet-bridged.m
+++ b/net/vmnet-bridged.m
@@ -88,15 +88,6 @@ static bool validate_options(const Netdev *netdev, Error **errp)
         return false;
     }
 
-#if !defined(MAC_OS_VERSION_11_0) || \
-    MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-bridged.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
     return true;
 }
 
@@ -115,12 +106,10 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_shared_interface_name_key,
                               options->ifname);
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     xpc_dictionary_set_bool(if_desc,
                             vmnet_enable_isolation_key,
                             options->isolated);
-#endif
+
     return if_desc;
 }
 
diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 2958283485..30c4e53c13 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -47,11 +47,8 @@
         return "buffers exhausted in kernel";
     case VMNET_TOO_MANY_PACKETS:
         return "packet count exceeds limit";
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     case VMNET_SHARING_SERVICE_BUSY:
         return "conflict, sharing service is in use";
-#endif
     default:
         return "unknown vmnet error";
     }
-- 
2.41.0


