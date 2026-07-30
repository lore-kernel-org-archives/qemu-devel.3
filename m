Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED462C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKxg-0008Af-EA; Thu, 30 Jul 2026 03:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxW-00089m-Du
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxU-0007vd-M6
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJcuyb3AxRla6sGdYaiJHnYR2it2xiiFc/9EPVdWCnw=;
 b=Sffhzhh5aGTe9stdqXZQBQsCvUaBIn9fqW4law6ju589p6Fx1JA99MxyTKRGYpLzVa16V2
 pDH/g0jedIeB3xsl1FTqwTXYF3osaicaGcoWlRlzhKXkWT8T/0UJMD2BnoijrN8tTrm+4h
 SYMbL64K/FBFmU/NNkHbz9dJm0sHr2A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-6ztPYVBJOE2WP8AZxiKP4Q-1; Thu, 30 Jul 2026 03:13:33 -0400
X-MC-Unique: 6ztPYVBJOE2WP8AZxiKP4Q-1
X-Mimecast-MFC-AGG-ID: 6ztPYVBJOE2WP8AZxiKP4Q_1785395612
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cca3673560so32574875ad.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395612; x=1786000412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DJcuyb3AxRla6sGdYaiJHnYR2it2xiiFc/9EPVdWCnw=;
 b=Ro6d09Awqrpfu02nC3JOoaS2xmbueaWoU1TAzsrHK035dCh/qVo7sONlnYxbjujkLj
 elrpfcuJ3pqDmgG8cu1Qeuf3TKWPV5XdhO4U+n9jVXBZTbRweaLmmT3EpKx0hWg51Vq5
 8P13ej0og9hwc7B5fIllCIFB6d0lgoqGTJsgAHuJNCdAL01yOKl4rodjx7yIeQKKQecO
 wVtlm6n77LaopCTsKmnVL8e92Dw/lUSgWi/Qv8FguNt8YraMS5Zcw3nm0ItkH38PKIKk
 6rogZpY9z1u6T9z4+hkKJYHTSRAYesL006BZomsQXYv8TjYV+yyliuf0KrF8UzSkMi1g
 D6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395612; x=1786000412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DJcuyb3AxRla6sGdYaiJHnYR2it2xiiFc/9EPVdWCnw=;
 b=KGlHKxS9KzGYS7r94Z8ZaE3WzjjCMlSCytYRHkMQ1i63XqdQOInpb/imTcZ4L+5/3L
 Lxhy5F09qJFaOVcewiplDDwmuv3rnHfCUt2RaHKEs79Ap6uGV+bDoTm4NE5FSDZxK4J1
 7qh+HyUmzbvypnGfqzq0xLc/KAJ7QbQQisscugi5PoEdv/N/dhQ5EcX0PSXBEBtlvyJV
 O6zZqqr278uhH3Ia+QEt1RQERUc5PCHYligwSw7pz5xUA9KwvUKob0HizC7GDNNobb1D
 AllusOmiQuAFEXrJcIiuzjerUiGdSC55OJrsoLxnHWhk+mlyd5wW59TNfopggoZgOf4p
 F/wQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2blMCQq2ReucKqKEvssxvIA3tId996sydEkjyAZugxwMww5OBJBvGExYXdHzJFXYTQ0GptqAbn1zX@nongnu.org
X-Gm-Message-State: AOJu0Ywu9FJFBcc9fHAEoMC0G5qi2/YmWSbV+2DFctvF/SakI/iubuEZ
 0SM5uSSxH7vPXbPeFJoUejKU1VAwxtAN1n1V1oMfShmX2CdEiXNE8eLbeojxcgU26HT3cXGL2ee
 QDKvA0mnX0wjytPEkXx0T6TU84D865ZPVG3R91VTx0CbzV7Mbr+TiE19M
X-Gm-Gg: AR+sD11cqM3llXhZPMF7KsNKyRvzNZstywt6dATlrUHLaHatk/VlutOp2A/+m6eBKc1
 HzM/uGuOitTCIJff0CAEAZTyWgh8JiHNEEFF0MZpYVjLtbXvtQCggOTJhErjGxWApFlt7dKwt5v
 KFtlGgyIVV4G5VefhzvjOQWugXogF+d481XopHok9NhVCYQ7rSLOPbMQwkfijrETroejz3lUaoj
 3qb0W8jyuuLrvsDHLrB/s/srh6BkOg/Z1wRvKxZmCfBa2UOlhMtRfUbaEpbj8Pk8WpK7wEywoMR
 IQUQ9SBs9lNsyNnktK29wUqs9mYmlM6me+BRgG2IWEZ89x375+gBjqAuZBIhdC/vasF2Daa8eS7
 tp+ayj/+mTzYXmgKc2todE6rtAqjACZWiIAY=
X-Received: by 2002:a17:903:98d:b0:2cf:8363:5ab7 with SMTP id
 d9443c01a7336-2d035ceb2damr13944615ad.26.1785395612370; 
 Thu, 30 Jul 2026 00:13:32 -0700 (PDT)
X-Received: by 2002:a17:903:98d:b0:2cf:8363:5ab7 with SMTP id
 d9443c01a7336-2d035ceb2damr13944365ad.26.1785395611907; 
 Thu, 30 Jul 2026 00:13:31 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:31 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: graf@amazon.com,
	agraf@csgraf.de,
	qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] hw/misc/vmlaunchupdate: add api header
Date: Thu, 30 Jul 2026 12:42:31 +0530
Message-ID: <20260730071254.80695-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a separate header file for guest usable api definitions.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h

diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
new file mode 100644
index 0000000000..fc18f8faf7
--- /dev/null
+++ b/include/standard-headers/misc/vmlaunchupdate.h
@@ -0,0 +1,102 @@
+/*
+ * Guest driven VM launch state update device via IGVM.
+ * The definitions in this header defines the API for the hypervisor interface.
+ * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+#ifndef VMLAUNCHUPDATE_API_H
+#define VMLAUNCHUPDATE_API_H
+
+/* fw-cfg file definition */
+#define FILE_VMLAUNCHUPDATE "etc/vmlaunchupdate"
+
+/* version */
+#define VM_LAUNCHUPDATE_VERSION 0x01
+
+/* format bits, used by both 'capabilities' and 'control'  */
+
+/* igvm */
+#define VM_LAUNCHUPDATE_FORMAT_IGVM           (1ULL << 32)
+
+/* 'control' field bits  */
+
+/* disable vmlaunchupdate interface */
+#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
+/* revert to the original host provided igvm */
+#define VM_LAUNCHUPDATE_CTL_HOST_IGVM          (1 << 1)
+
+/* The combination of the above two ctl interfaces work as
+ * follows:
+ *
+ * A) CTL_HOST_IGVM=off CTL_DISABLE=off
+ *
+ * Supplied IGVM file replaces the firmware permanently.  Updating the
+ * firmware again is possible.
+ *
+ * B) CTL_HOST_IGVM=off CTL_DISABLE=on
+ *
+ * Supplied IGVM file replaces the firmware permanently.  Updating the
+ * firmware again is not possible.
+ *
+ * C) CTL_HOST_IGVM=on CTL_DISABLE=off
+ *
+ * Supplied IGVM file replaces the firmware for one reset.  Resetting
+ * again will switch back to the original firmware.  Updating the
+ * firmware again is possible.
+ *
+ * D) CTL_HOST_IGVM=on CTL_DISABLE=on
+ *
+ * Supplied IGVM file replaces the firmware for one reset.  Resetting
+ * again will switch back to the original firmware.  Updating the
+ * firmware again is NOT possible.
+ *
+ */
+
+/* status code */
+enum VMLaunchUpdateStatus {
+    VM_LAUNCHUPDATE_SUCCESS,
+    VM_LAUNCHUPDATE_LOAD_FAIL,
+    VM_LAUNCHUPDATE_NOT_IGVM_INIT,
+};
+
+typedef struct {
+    /* api version */
+    uint16_t version;
+
+    /*
+     * The guest can read this in order to determine if loading new IGVM
+     * succeeded.
+     */
+    uint16_t status;
+
+    uint32_t _padding;
+
+    /* VMM capabilities, read-only. */
+    uint64_t capabilities;
+    /* control bits, see VMFWUPDATE_CTL_* */
+    uint64_t control;
+
+    /*
+     * address and size of the IGVM image.  Will be cleared when
+     * the write completes successfully and IGVM file is correctly parsed.
+     */
+    uint64_t fw_image_addr;
+    uint64_t fw_image_size;
+
+    /*
+     * address + size of opaque blob.  The guest can use this to pass on
+     * information, for example which memory region the linux kernel has been
+     * loaded to.  writable, will be kept intact on firmware update.
+     */
+    uint64_t opaque_addr;
+    uint64_t opaque_size;
+
+} VMLaunchUpdate;
+
+#endif
-- 
2.42.0


