Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79AAC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCz-0000Bk-Sw; Mon, 17 Aug 2026 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCy-0000AR-5R
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCw-0002iH-JR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=MkpfVQN67iX2X+qOAnYjT5jeaUP280oiTtAgSqvavfKTYqM0HYaZKDFGMfjwS4hkqfV7eG
 Zb7xDulp0IbN1vgcni/GluVDQzTaowOt7FlGxcOkZy9AWITs7a1AZYOXzVl8oNAYbw+l76
 Nynwcbv+a91kPynKDQ61ZkNY6D6nnco=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-WC0IbeRoO12sL-iCV-RTQA-1; Mon, 17 Aug 2026 10:20:56 -0400
X-MC-Unique: WC0IbeRoO12sL-iCV-RTQA-1
X-Mimecast-MFC-AGG-ID: WC0IbeRoO12sL-iCV-RTQA_1786976455
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so69495475ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976455; x=1787581255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=UyuLMBaMi/tnyjzN99qSUpISbQruIrFPjgZrKTLmgpGOB2OWjN0ayUnpCPPo3KUdKT
 AYmDEW0NposBU9WZ6YCnEUNLHOhIctsJD+a1JzKR2uBLDzDdiICVRjF4g8OuGiRMY6y7
 In8RAiEPl7wRj1NW9FpoyKY8MDVy+u92aBpfT0B6sAcR3uakkcYWwpoOCQWzm0DUCoB0
 wiooT38jRMY+APQauLOLtI2hAl7tuNqsHiXCyq7/65dsicapkEqFgSknsGbCaei+lyrO
 yIS1wQwt5neYI/VuLUVPexM9bPFh/zxEXvFQk5fnqLrQ06kvx1ArKc108XgHH80Blhpl
 FkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976455; x=1787581255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0G9kJaM7xTotO+IG4PqVpRqk49NAmKccnDH91l20TNU=;
 b=lx6054eonv+QH3wh78k3qqS/GSXa8ECZHRqIx7FOVRvHlLtPMtap3QACQgWuNVhHch
 Pe3+wcLIc4vyMyMrlGj6Zyj5Zkoh3uXWtcUpoggOmbZ8qM+r3qM0OQYY1SgvUHo+dZZi
 bXjfQYHM8TNvxRsI+QuWiOi8ww81KXuywFIj225IPtb81tDeBuCgLGK/zvnpoR3D0HVg
 cqVyIjprdGw8iaZiaqDYOWAUygAFtI4fbHBXnB0YSsOxtadbTFKDiQxh6g7DGikMPu/A
 EBf5OROi+Wd8KeJeJ6BVKByaheMjlOUJuPXTAuOhFVX+JblhzlcDXI4xt8EEe4+oAjzB
 XjaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RouXIiktxCIZZb23WRQNA1+aFJhCqxojtoKu+LQGMoHP+bOJSIgSVV3/kHVdp4SgxxFZNoXDlePfhWk@nongnu.org
X-Gm-Message-State: AOJu0YzK4Mv4qmESpiptWvbufarnCra/SlPOVX2Wg5dUFpZQwKPx1l+s
 FJ1a11pr3CiMGhvBD/7Xz7q/RGc5bgzzTmLKLuzvhlSx2dNnMZmPaYJPs/kVVMn5A5wu8uxPgDq
 AVVM/lDccf8SYgknMNkMenASp0VnbUwkSW6eslPIf7kkj7Cj0g9g7OBTgHKvDkqhP2Ds=
X-Gm-Gg: AR+sD124CevQEgnKSdQuqTwTa3hYPuCfQL+DOCaBwNje+o/Os/DtFDOnbY1dhwF56aV
 OwHri2UFxWeGjXfk1PPtj0yYUQ88r6j0j/FmhQ+q9IXYk783o7hNI0cOqypFybCQyFvfjQuHEK5
 WLsICGDI9E983FJxUora6AQ49jroqvOJYD3FVK66EgjbDAxozZ1iHm/zLFlRtJXNod82gGWdU6E
 BaOxUeM4A7zUXBJ49NxJODWC8JTW3uIW2mDO3Od648ytmyBFEmAysYJnJwid7Uq2fEaNxoqgJ1r
 YtHo6IuCr69o1AKnNKNyVSZAr8LRyizRGLEOL5R7l5MGJqJNMrIeEG0c/DmhUHYeTsGPQjHG8fq
 RFvA2kO9h0MlnouNjEajvufkye5xZ8g/M4Q==
X-Received: by 2002:a17:902:f647:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2d3b0d0379dmr293577195ad.22.1786976454878; 
 Mon, 17 Aug 2026 07:20:54 -0700 (PDT)
X-Received: by 2002:a17:902:f647:b0:2c2:be43:39bc with SMTP id
 d9443c01a7336-2d3b0d0379dmr293576675ad.22.1786976454206; 
 Mon, 17 Aug 2026 07:20:54 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:53 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v6 06/11] hw/misc/vmlaunchupdate: add api header
Date: Mon, 17 Aug 2026 19:50:01 +0530
Message-ID: <20260817142010.80693-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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


