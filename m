Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A7C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwP-0007vL-Er; Tue, 04 Jun 2024 05:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwO-0007oK-Cu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwL-0002N0-SX
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35dce610207so3378663f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495127; x=1718099927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGqa4LCtUPmfqT7FCKxDXiSWjLBqv6GKh2fc2iPwQg4=;
 b=Urb4x7Qt7N3XyuJxgXhZbii6bOtI0Sk3xMOqO5B5DlVLF4BntRwNHOW7B1XZfsnQRJ
 18HlzU+aKV3giCPdW3If1j/m/DC16YoEklXrl2tYXoyXiKjYcKP9GbrO0a/WAYAvdg9E
 e6ZmYE2YaH6wvMSHkAek757cqajdJwTN4L+ng+/Crlf0rAWSiH14w1vXLZJAaUORNt3A
 q1Mlh0qsZT6N10hN1drLa+qp0lQWiUgj2kbIZQk/cLhzgWIed2xQ7m33z1s/5/7aHhx7
 iQl5trgOYlfSw2uegTVSpnxzL1kq6CSuvP6stNa3E5H6X99fhstGXcpI6avsHK9fI/hx
 fV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495127; x=1718099927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGqa4LCtUPmfqT7FCKxDXiSWjLBqv6GKh2fc2iPwQg4=;
 b=YrIQjH9lvC+JCNnzlrOgxg/94sD867u/k78jlppmulhbbzqN8u2YMKMLsfbcXC831j
 UmsYvRpfk/FrJHSoOYRkkPaKZ2wDozQssqAefXleMHJZicDNWlM/MrRpCRGKuJ/ZSuWh
 oaJXmAavgMtWL4sAjkyvn+rSYd5/HZHFmunZBkapLjU5NRGloAVydne+YuD1G2dZ+08d
 Nzas5EP/3Zx+9ToT2Utkac8e5W6YgYP2z44BBWv++T38lxW/zmxRby6TPzoFytHileui
 LHdnwcgOVFuDyUdZTz/Ss3VwwUOQCeE2qzXOUdFh4YAu7H//TM5KBjC//mZ1Fke9nXxF
 R75w==
X-Gm-Message-State: AOJu0Yw3MoLluuSJPFGe5oopj+sEKxw0+AOCLh1ChuY3VpFoK/kjhbj/
 giechi7eG6aQzcBO21Xo3toUjWoTpotcmDm1CwIS0RcOUJmavbqRXHStYD/BDHqfAy7mCm75q6f
 z
X-Google-Smtp-Source: AGHT+IG94P5WWPomVHoZIPdJKM7vpl6wDv2k1eL81l1TaEoE4MJF3s2yBYxpESSwDCnW58uEBYVcVQ==
X-Received: by 2002:adf:e88d:0:b0:351:c960:b5a2 with SMTP id
 ffacd0b85a97d-35e0f254f8amr10288142f8f.6.1717495127353; 
 Tue, 04 Jun 2024 02:58:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062ecd3sm11240886f8f.74.2024.06.04.02.58.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 29/32] hw/acpi: Remove the deprecated QAPI MEM_UNPLUG_ERROR
 event
Date: Tue,  4 Jun 2024 11:56:05 +0200
Message-ID: <20240604095609.12285-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240530071548.20074-2-philmd@linaro.org>
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


