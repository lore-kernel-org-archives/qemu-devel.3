Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAB7C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCa1x-0003FZ-Ud; Thu, 30 May 2024 03:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa1s-0003Ej-NT
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:16:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCa1q-0005Og-Ns
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:16:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dc7d0387cso530949f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717053407; x=1717658207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+58tUuGz0yGO1o5h74G/F6IT3Lp8NPe7dBq6tqbQHc=;
 b=mFjTupopEE4J5VfSKzKRZTb584cilPlxGOZcjtHm/0f6xZyWYESNsFS6NRBNoPgjHx
 ZNEGdQ+E0QbbDQxwF3cO2K0dS5zZKzGKTZ82M5e955WfBQxG+/J4Wc7SpvO7HD/bX/wh
 fXqmsF6Dx22iJGnRCn6+LBIVpIbDKttTwcv0wQ1O4IwIbzNJ8mUk8MccF6n6LE7Z3DbU
 NBhiFJnbHBwWID6Rp8ijj2SRh+pefS8zf0+DizsvC+W6najaRO7jbIygoLvv8uOUc0At
 jFTfJA4JXSoq22LqeLrFVNK8PUqJH5EylyVzkf4rf0d60R3LAVGQAkeJ7YK9lnURet5J
 ykcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717053407; x=1717658207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+58tUuGz0yGO1o5h74G/F6IT3Lp8NPe7dBq6tqbQHc=;
 b=PtV3jLEelIEK2lhV64s0udCGBRiS468TUbMJnTWPmZBvX+xM4pAD9aHekfYjMvEnIq
 +h+MOLmMQc/SshHENpM8R5FELbQAcEjEBZJYWEZVS+/5PXq7v+O0h1A4o/bYAzdTariD
 6J2djhsHoSKM6t0AbaTMJ1cY7O3OxuzzzGuW38Q+en/A79Z+3Wfdcfto4diifmRGzdrZ
 AxhXsiVFYR+rwIfGE9xmcxA9XZYuMzaSYPFEbAFO+Gx46gsmHnZNoReqoR6aIpeZBoFj
 a30ZbsiamZMCzrbmekC3YPczgiwbZB90uPAbK63bE9pvJ3WIIbM6qg/b7Zy8s7hg7jdq
 YfgA==
X-Gm-Message-State: AOJu0YyZZ/Omd1loLWynw5vXpBgkfrikIZMKflHM0XlJrtdxINXwyQII
 F1vL6oI7s8qf9wGjsVLnG6v04gwZbaZwLdwPE1hRwwvCmwWjT+az0HXmfNfFVXMVIIdZ1CtuwLn
 0
X-Google-Smtp-Source: AGHT+IFrRf6G3dH6JenGxfs0CCjXm1XMPGE6etFhotLnSH6QgE8WIgdzEyPJoGBfRJvIpdvJZ4Xj6g==
X-Received: by 2002:adf:f30c:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-35dc0096b5amr995402f8f.35.1717053407114; 
 Thu, 30 May 2024 00:16:47 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7d88esm16752281f8f.19.2024.05.30.00.16.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:16:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 1/2] hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR event
Date: Thu, 30 May 2024 09:15:47 +0200
Message-ID: <20240530071548.20074-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530071548.20074-1-philmd@linaro.org>
References: <20240530071548.20074-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The MEM_UNPLUG_ERROR event is deprecated since commit d43f1670c7
("qapi/qdev.json: add DEVICE_UNPLUG_GUEST_ERROR QAPI event"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  5 -----
 docs/about/removed-features.rst |  9 +++++++++
 qapi/machine.json               | 28 ----------------------------
 hw/acpi/memory_hotplug.c        |  8 --------
 hw/ppc/spapr.c                  | 11 +----------
 5 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 40585ca7d5..4a61894db6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -151,11 +151,6 @@ property types.
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
-``MEM_UNPLUG_ERROR`` (since 6.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
-
 ``vcpu`` trace events (since 8.1)
 '''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index fba0cfb0b0..f1e70263e2 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -671,6 +671,15 @@ Use ``multifd-channels`` instead.
 
 Use ``multifd-compression`` instead.
 
+QEMU Machine Protocol (QMP) events
+----------------------------------
+
+``MEM_UNPLUG_ERROR`` (removed in 9.1)
+'''''''''''''''''''''''''''''''''''''
+
+MEM_UNPLUG_ERROR has been replaced by the more generic ``DEVICE_UNPLUG_GUEST_ERROR`` event.
+
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
diff --git a/qapi/machine.json b/qapi/machine.json
index bce6e1bbc4..453feb9347 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1607,34 +1607,6 @@
 { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }
 
-##
-# @MEM_UNPLUG_ERROR:
-#
-# Emitted when memory hot unplug error occurs.
-#
-# @device: device name
-#
-# @msg: Informative message
-#
-# Features:
-#
-# @deprecated: This event is deprecated.  Use
-#     @DEVICE_UNPLUG_GUEST_ERROR instead.
-#
-# Since: 2.4
-#
-# Example:
-#
-#     <- { "event": "MEM_UNPLUG_ERROR",
-#          "data": { "device": "dimm1",
-#                    "msg": "acpi: device unplug for unsupported device"
-#          },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-##
-{ 'event': 'MEM_UNPLUG_ERROR',
-  'data': { 'device': 'str', 'msg': 'str' },
-  'features': ['deprecated'] }
-
 ##
 # @BootConfiguration:
 #
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index de6f974ebb..9b974b7274 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -178,14 +178,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
             if (local_err) {
                 trace_mhp_acpi_pc_dimm_delete_failed(mem_st->selector);
-
-                /*
-                 * Send both MEM_UNPLUG_ERROR and DEVICE_UNPLUG_GUEST_ERROR
-                 * while the deprecation of MEM_UNPLUG_ERROR is
-                 * pending.
-                 */
-                qapi_event_send_mem_unplug_error(dev->id ? : "",
-                                                 error_get_pretty(local_err));
                 qapi_event_send_device_unplug_guest_error(dev->id,
                                                           dev->canonical_path);
                 error_free(local_err);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4345764bce..81a187f126 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3786,7 +3786,6 @@ void spapr_memory_unplug_rollback(SpaprMachineState *spapr, DeviceState *dev)
     SpaprDrc *drc;
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
-    g_autofree char *qapi_error = NULL;
     int i;
 
     if (!dev) {
@@ -3823,16 +3822,8 @@ void spapr_memory_unplug_rollback(SpaprMachineState *spapr, DeviceState *dev)
 
     /*
      * Tell QAPI that something happened and the memory
-     * hotunplug wasn't successful. Keep sending
-     * MEM_UNPLUG_ERROR even while sending
-     * DEVICE_UNPLUG_GUEST_ERROR until the deprecation of
-     * MEM_UNPLUG_ERROR is due.
+     * hotunplug wasn't successful.
      */
-    qapi_error = g_strdup_printf("Memory hotunplug rejected by the guest "
-                                 "for device %s", dev->id);
-
-    qapi_event_send_mem_unplug_error(dev->id ? : "", qapi_error);
-
     qapi_event_send_device_unplug_guest_error(dev->id,
                                               dev->canonical_path);
 }
-- 
2.41.0


