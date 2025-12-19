Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8BEE6689F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiuT-0001gs-TM; Fri, 19 Dec 2025 17:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuL-0001fs-2d
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:10 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuJ-0004xN-Dw
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:08 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so2685137a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183105; x=1766787905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MejsQZQjfmF8E8MVD9Zf65G1EJeaO/noNkfID1o3ciw=;
 b=Dt2nzoXbVefh8IQb90IrIFPV5172waFynTKYeAKLwpob5z/AmdzjY2MOHZATc3hGKj
 NtpbdLAvw9fZgUcvWl/Vro2JKFO2xWijfNZ2OlwADhF2XmpujI8W/4o1yND/Ww5QTzAs
 Hw1LqDkP+M5BanrKLrdUXfmBYFmEC7No2qsmnXGcyR92PFqwAP+TB74QGFb3o9vUtgzn
 +sIzXm2GB8WSd8JUqoCL4n2oPx4KrFWiuNAeSOtkNS3FRJkTt5Ht8DUIFpjhCO657wf7
 1E9AmSLlSFQ02KLSywPNhEdYCJcJ6YthrI9dD0l33KBvZguGjtHm80Nm7jiDkOPBSUws
 ZRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183105; x=1766787905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MejsQZQjfmF8E8MVD9Zf65G1EJeaO/noNkfID1o3ciw=;
 b=hOibLBYGc7gO+pGHhZz/g+MUOsAr6g27+5vP9R4OuKDn56GFAp3HuMfUSVJHeRxgYs
 NEmub2hQ/Eg+JSqXVeKZjWzMfCNN266x4VEeyRO1NR/VtCesp/Ihl5BBtQVkWG6+h9Ld
 feKBZgAKKe8wiOzM/lzyd8ekD5PbROPVw4MG3YMCmpPUj5StboLVxDsAk1ZifkVZzbVx
 2h1OB4oHguRbhFTGV/cIKWlkhiynI5zk0o8D023vbCyzSO/sz1nrVm4mZSDMFBo6OBRf
 js9om6yXWrvqJk8qJsVXLPN5nYzhvzvYeskLhkhuz/sCJBshqKlLhY4CGyq0767ywb9R
 t/Fg==
X-Gm-Message-State: AOJu0YzF+Tn1CSgpQgay4/I1oaMMlFnY5YwO7CWCYQ6NuRsD7up/nbw/
 SnqmnBYSWtzSsxzSCahSZlwjH+yNTJnvgLsodkyumQwInYW11iY3+2qo4CY2tVr+
X-Gm-Gg: AY/fxX533XRudMk26HuCQ2Zhj9/lr6BwDwVTIkiHQU7YbWgN4taOv8dlXiB1pv+caSq
 /Td1nMBs7CFnYU8eSxOKK6ZRZ6P64q/qL4rKjD8fQkxFI1j6CNAQQQMnTCCbtjjeFxOhiMdS6z5
 Vt9tDqKIkWqn6bvUg9KHiMeLdjEZ3PeF7kMqjm2q8FFWHowUnE92kDU4efq69xo4Y7Qk3KijpOP
 8Jcd7g0t28bbmpBE2cy6q/wavuf7GQe+0PKlrnRs4mlg0EHGfoiOfahU9rEiQYBLdaukExGHS4C
 Oh9QsWVz91/OQI6cacugXkamzomvzkWGXPybLDAmbFPauqZqoU+OzEZn893bfhBs6DdD6RtVhG7
 lTEwgwPQhuzuVp3zAMUKpgEJMat4ldeCAF4zwe+AumakesGNHX673W6TWAnFrz+217psdkZwYzm
 2RqVoELWkXjDImubFwZl2EzYRXBHvC4pMKrS0mcdjOU4yx3WHXO7GFyKijVhR9GA==
X-Google-Smtp-Source: AGHT+IF2NJk/peIrFsaWn6AilLOlXpCYNUpQyDhmIG2QknoLmhlgZnEFPY6UaiiCkw1HqJyZ9hrPPg==
X-Received: by 2002:a05:6402:1d48:b0:64d:cf9:a79b with SMTP id
 4fb4d7f45d1cf-64d0cf9ab8dmr189505a12.26.1766183105291; 
 Fri, 19 Dec 2025 14:25:05 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:25:04 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Subject: [RFC PATCH 1/6] hw/sysbus: add IOMMU ops support to simple bus
Date: Fri, 19 Dec 2025 23:24:34 +0100
Message-ID: <20251219222439.2497195-2-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
References: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

In preparation for IOMMU support for simple bus,
add new BusIOMMUOps structure which need to be
used by devices to get translated memory.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/hw/qdev-core.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2caa0cbd26..e3862279da 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -366,6 +366,26 @@ typedef struct BusChild {
 typedef QTAILQ_HEAD(, BusChild) BusChildHead;
 typedef QLIST_ENTRY(BusState) BusStateEntry;
 
+/**
+ * struct BusIOMMUOps: callbacks structure for specific IOMMU handlers
+ * of a bus
+ */
+typedef struct BusIOMMUOps {
+    /**
+     * @get_address_space: get the address space for a set of devices
+     * on a bus.
+     *
+     * Mandatory callback which returns a pointer to an #AddressSpace
+     *
+     * @bus: the #Bus being accessed.
+     *
+     * @opaque: the data passed to bus_setup_iommu().
+     *
+     * @devif: device identification number
+     */
+    AddressSpace * (*get_address_space)(BusState *bus, void *opaque, int devid);
+} BusIOMMUOps;
+
 /**
  * struct BusState:
  * @obj: parent object
@@ -376,6 +396,8 @@ typedef QLIST_ENTRY(BusState) BusStateEntry;
  * @realized: is the bus itself realized?
  * @full: is the bus full?
  * @num_children: current number of child buses
+ * @iommu_ops: TODO
+ * @iommu_opaque: TODO
  */
 struct BusState {
     /* private: */
@@ -388,6 +410,8 @@ struct BusState {
     bool realized;
     bool full;
     int num_children;
+    const BusIOMMUOps *iommu_ops;
+    void *iommu_opaque;
 
     /**
      * @children: an RCU protected QTAILQ, thus readers must use RCU
-- 
2.43.0


