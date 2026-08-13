Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DCEC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmI-0005yi-7N; Thu, 13 Aug 2026 06:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmG-0005yZ-Jg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSmE-0000Cb-WD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=aCciJOjEB99xrZ80iaRG/dhK5JVXEa5UDSPAFqakKxPLwqCvbiaqUy3Ek7OEzXjdxaEcbV
 uXDNnfio5iaOq3/mmSc3mVBVJWcaAYsFA5vCIs3HbT2EjTaC9baCM5l9UYX2f4Kqo60q1M
 onn0OaFmz6zpaL0K84wU1LDTxM0w/uU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-BfFCnbbgOqCjY41dL3rnBg-1; Thu, 13 Aug 2026 06:35:09 -0400
X-MC-Unique: BfFCnbbgOqCjY41dL3rnBg-1
X-Mimecast-MFC-AGG-ID: BfFCnbbgOqCjY41dL3rnBg_1786617308
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso2188555a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617308; x=1787222108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=e1gc2QHhWTyjMkSYIB+rn3q0zrV6w/y7tk8k8aPqBcAnQwIE2wysgXrcTSqD4BKNoX
 RLkzQ80VSJn+vHBOHSghrooyUOu5uvbIaXjAsq5raXIl7mXSdkXBbTnDyyx0L5mjEXFm
 ZYNRBvM5bDPbjEheIWlFlVpbOcnv7nZ2XYjWcG+3sj/FxMNUZ8aw1rk476u4r1zYc1/T
 R13VkLslpD4M2hZRSpC8L+5FVplbqmGGJMFYuQt/Ovox9sarxsu2v+FuCpClQBFVTWGP
 bkzRB069xcTjBG1hqFcGlTeyvyEwDl6n72a2WetziliNP2sAcmCxZzWduIeJemciBe6O
 PlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617308; x=1787222108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=BZZN3ie3O8ybw7ZT66kI7q3x41Gku4lElHF1d0ZBnZ9cb0OvnqW3J/R15Pdvo5Qp2C
 Fg3p/MTbBVXLMrXZWFE2XbdtCYQWLTeBpfK258Mof5PXzWE7tFZCFAOHS6wtJIyyyjT+
 HmiL4Vglb8H4Vkolz/SvUOAnDVSvLxoj5S5p1AVGf2ztxL46+Vgtu15Cwcwvfz04ci0u
 fXTo2dSuuHw55RL0jszB61CosF0qv4sR/h9YEOcLNo31WGmy5s51ISQ+Wg5wqqRz5LzJ
 0bZvX43yEVgAY3IVjji0yltSDhE4Sc3KNQagbm7luZ4vNBwuPJIFFXqOIIiXevyCazvy
 mB+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEg26ol8Uw+NFCSPHwnsNWHujSPN8FmR09eGAFOePvgvWgjKbAVl4PmVRERvFN3/vvM2gAgrrwZwek@nongnu.org
X-Gm-Message-State: AOJu0Yy3dLV8MlBgPXTU2FehfzmcBtkJNq8IODnYfqMyma/8mLNmJtXO
 5+GOXEXcpwIXPXW4oJuMDElGdZqsMxIrrCeFxi5rWQ7oYaY0JteZH2sDkicEuHAiFKMuSnCzoW2
 +Lo1EqYEEjOdB316wri3B3j33x6G4Oi/H3OM55otyNWAD4wsyri7vUROw
X-Gm-Gg: AR+sD13zeQJ+RZl/cKjaPnoCY30jPUyojdP9S/jAe3n3tTHh5mVXN9pmWHcIsje5W5x
 Xh7EDPhyxNpMRqQQ8DXdkpQYD1hX1QB0ggvNjSKuGXpTh8VUYZQeV7qx1h4gkM+IaQTv3Fgmvo8
 byGnQR7sN2OrzD4cqhJ4FcAVcIS9W+GIiIWjT5UWgFI+nYMri9Alx5Au0qyvRpuE5bFbugJByS7
 vStTb8pARV5sPuf9ZjCyhLc669vDXLTa8A1hHLd6mcJBDUXx9I391xzgnaFfGPIv+zak4Tq2g8l
 wkA6bYQ2VdoEtyE+6JAO7vlLTO7iV+ngh1ba/sWI1Hh8JGBV9vn6M1U3x1g1/abcZT4+hWhwCQ7
 zBaflGxTvzyXUNn5X1CBYlW4siJNiQ/z0Qg==
X-Received: by 2002:a17:90b:568d:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-3931e02fb3amr6079797a91.7.1786617307759; 
 Thu, 13 Aug 2026 03:35:07 -0700 (PDT)
X-Received: by 2002:a17:90b:568d:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-3931e02fb3amr6079751a91.7.1786617307231; 
 Thu, 13 Aug 2026 03:35:07 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:35:06 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 06/11] hw/misc/vmlaunchupdate: add api header
Date: Thu, 13 Aug 2026 16:04:08 +0530
Message-ID: <20260813103425.24474-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h

diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
new file mode 100644
index 0000000000..66daed701e
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
+typedef struct QEMU_PACKED {
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


