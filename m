Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5CC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD6L-0001S0-OX; Fri, 07 Aug 2026 01:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6K-0001Q3-Cn
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD6I-0000kS-QF
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=c0gHwP9vjnGJkXQHOOTrEOd4toYDhTB1n8ExglJkElbmp2gB7ZAYLT+Bb0QELc7cKZjusa
 gUG52FE8OI3riu+NgDz05jV6TaTE6t0vBj3XHQd9+sPpiWU0pU+err98USHTU08my27SN2
 7tsLPBvXLx9Z8VZD/UgjvnkI25Ncq8I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-JQwKl39zNNimkVmtn5l6RQ-1; Fri, 07 Aug 2026 01:26:27 -0400
X-MC-Unique: JQwKl39zNNimkVmtn5l6RQ-1
X-Mimecast-MFC-AGG-ID: JQwKl39zNNimkVmtn5l6RQ_1786080387
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so4345103a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080387; x=1786685187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=RHrl1hSd5ZGb0vNVQlGzqpUDvo5treY/KNn/5Ss0J0oDIqHI7mL+hvA7wb7ya1AOQM
 DJJy1MBouDSjBMzfjYNEurvkbTE0RozTWqhn6KzoHx1NNcHdiaQIVyD+avlU7R0jGrce
 ba1scldBMUJcvJ0zGF7U42Mm76qaPFx1Nq6BvcGXu0C3N8r3hXmfU8aLV8Wel80lJCSF
 w3EaiZG6I0Ij7GPmg7qf5Qn9TbpzzNch9EJ9yWg/TR0lmCEtKdPx1ZkBovIHtk+n7pvP
 LFQldrh5EsSAagDDsQ/TK+dPN/7qgh0FoRE1GJq8ieug2oKtQCy9F4Gydjvr0wbNo3yQ
 cJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080387; x=1786685187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=LxqsQ54GuTshAFjDnv0MqoOIicveaqFq5rnu+4slIpmgidIMGA2o+wA7JFJITo6xdf
 r0uDaXqzyh/R4oL0xlY8Q2cAzkFMV9J/uSkvRtBXGa2uIaBuohnXy0iZ6dP8nEOkcToR
 +MMctKf2Et/B4fnXMdhTSY1y6lH37dHzETbael79WDQfyE9izd72cEr9ZxuVzEQLQ8aP
 +bZPXB5ZnmkKiO8SvXIHyMrzDQkJBewb+MOaZiSDos5L3JeituXZjseWW9xjjwZjzrmZ
 oLAx/Uj77txZjpCLkWic4Z6bV1RZlkUwVhI9HoSHQOdSLfMvn0QSyTC0OL7h4/R+Iyes
 Pw5w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrro3RROx+TvQAy8jUbtlOobkY5JQIiqHL96heNdw+A2/SChc/1gk9C0bhfFzWXFlmswCq8aC4tFlwo@nongnu.org
X-Gm-Message-State: AOJu0YzvU6WxXkbilWEvMU2N3rdGDcT+4H2L7FnRIg+r4agOXOO5KN5g
 jnzImZRYZ1Vbv35TbzWj/jZnHz9QnOX8vZX/gJ7kjjT9Ikl4ZVhr1ilyQHpdEfBvlKR3GdPb3KX
 cXV1Tuzy4DbXCTpUak7MpS6Z0kzipM/DYboR02OGPwegCY+XHfyfhWG21
X-Gm-Gg: AR+sD12bETcHRFNbfVGQS0B72B6OBBRDjXICVRjWi2Gd9W5kjy2POg5C7ziTW8hnc8u
 fAVDMApizdXSTRRyVdNnCIvO3vchSUd2GlEOnig6/Bz8BsvC7PcogBoi1wMaWz1BamDyp2r9VSO
 jSuBCxSWspC+uIwtvugvdTv8vpOZPgjaLe9u6asIBllLkmrAWMTdVjrM2IcN8QkaNNpw6i64hh3
 UpJBKqS2289f+HvwRv/uZQQD1dXny+d+2reBll2nM8vLJnQMXgeEq/kVq+FOBpg6I2T8fmQ9Nl6
 2jDt44YTj260QSolI1X2ophtAeFCLKuwx/SfZfjPNeb6Vyr3yeRJRuLc4VnLFt8LlAMg0nwCZiX
 BcXnBY0Lpz4Ejm17+QC7qcoDPeDzhPsn70Q==
X-Received: by 2002:a17:90a:d2c3:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-3908361a861mr8358090a91.7.1786080386554; 
 Thu, 06 Aug 2026 22:26:26 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c3:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-3908361a861mr8358067a91.7.1786080386048; 
 Thu, 06 Aug 2026 22:26:26 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:25 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/11] hw/misc/vmlaunchupdate: add api header
Date: Fri,  7 Aug 2026 10:55:48 +0530
Message-ID: <20260807052559.50643-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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


