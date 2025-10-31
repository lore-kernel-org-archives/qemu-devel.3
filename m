Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E0CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vErVt-0006ii-2E; Fri, 31 Oct 2025 11:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vErVq-0006iT-KH
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:58:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vErVd-0005uS-9o
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761926260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aBPx8hI36oJpAZyZQnbxHNy40N6396sldFZirY6Xg1E=;
 b=J83aeq7xe4Jt1UOgNV9N4lUCi6lcgVzmUhu9Qm5PCHgYUSbbzyxZ7W40s3els2wfoOTt6V
 iMQhI7vXHtVZZyBz+0TejKAWnMjHzZeing4GDOWbRDWt8R5Xg8zhrZO4Z+R+IhRyow3mQ5
 q7eKlXVZUntAi4kJ77eGrU2yEJGP94Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cP-G0cAEP6uylJl8OubLog-1; Fri, 31 Oct 2025 11:56:21 -0400
X-MC-Unique: cP-G0cAEP6uylJl8OubLog-1
X-Mimecast-MFC-AGG-ID: cP-G0cAEP6uylJl8OubLog_1761926181
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88022ad6ea3so44299526d6.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761926180; x=1762530980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBPx8hI36oJpAZyZQnbxHNy40N6396sldFZirY6Xg1E=;
 b=rUnucAG1wlMo9nrP8M/xHlq/+SlL6eVeZc5kJogglBLh+wMCbz/eXNTpS4i4QFJ2La
 qp2Hpy53IKRBqIo2x+DG3fkDrApqblmDaB5vtrWsXiJoeUwTGz+UMR+fAJbpijDfuh6Z
 wvW4O4GWv1M49J5xcF8wmit74MMyuY/UZEWVQc9+iDRWSs3/EGUZ5tj+jjNAfVScNBsy
 +uQutC9ZH74s73iFwJiCpGdYJFpBPgJtMdsfvGKU0ifOq5EL1o/6RmKjH3xsPxnyA1yg
 AL2sJB8JsoXFaMqDUYtENeDenW9RnsNYgdvRZdsdlv45AAAFf7z3ym7WfJkyMvSYGvYb
 BxNw==
X-Gm-Message-State: AOJu0YyoxDwoSfLvdFQ6cA3Gu02dIV89VBlqUWRE1wOHihXMtahXxlDZ
 988M/cSt2qf9z8wsMa0F1JMC62y2nE1yxDdSNHYd30kpH9J9qZFEnYIsY9+ZfzwU5gML2HE1AFG
 YRQ8QZZ2FQ2C1knDYiAqkFEityHTaX5i5Qa65qM/s0qQZI6RANsJii9kzEQi18o4enAdLEuX8yA
 VqAsEbFXBLbOU/B5QqwYaWH4EcbWB9ADc1BXK8QaFW1YY=
X-Gm-Gg: ASbGncsjHYPPHGT1hB7qOMaIFnub4wTB3lACAqmbjPmT0doMe/r/M7hazzBMIVWYZlH
 x1uiydR+29d3LTS57kDNePWv+be7QGWmU8T+F93maqDizDc34hFrXJV4mQUVLm4hsp3A6XVAGup
 YQnCsD25W+HNVXcClTfyb8NF41TcE+Eu1eVVrnmB3QOcymD4aS6qHpxc3clPSIzP4go07tTFTf7
 KcNQebohNYa5eweaY9CP2dGu+iJifxH64EzdhBCD6AJnMaXc9NZv+Uk/5+nMDo9NE18QKbnanFF
 80eR8nukfxBELQqj062dhxMgttMePt1jRUFHXDGwtUi3vwHtYAnTxVleCKC7DxXHZ47qjcjLufJ
 wdYfbFdfC9ORmDyv+OYIF0YuTk9iRLqvFSh7AI2X4
X-Received: by 2002:a05:6214:27e7:b0:880:1eb4:110d with SMTP id
 6a1803df08f44-8802f4db5efmr54084186d6.51.1761926180642; 
 Fri, 31 Oct 2025 08:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtvKJTBW3Xuf4BCMa8AiONYool/fNRESQ5it0qoabSE5o9JgQgprKEr3s09mN3PwLqvIt0kQ==
X-Received: by 2002:a05:6214:27e7:b0:880:1eb4:110d with SMTP id
 6a1803df08f44-8802f4db5efmr54083806d6.51.1761926180260; 
 Fri, 31 Oct 2025 08:56:20 -0700 (PDT)
Received: from localhost (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880362d3c69sm13601386d6.29.2025.10.31.08.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:56:19 -0700 (PDT)
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [RFC 1/2] linux-headers: add virtio_can.h
Date: Fri, 31 Oct 2025 16:56:16 +0100
Message-ID: <20251031155617.1223248-1-mvaralar@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
Note that virtio_can.h is not merged yet and it is part of the series
https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/
---
 include/standard-headers/linux/virtio_can.h | 78 +++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_can.h

diff --git a/include/standard-headers/linux/virtio_can.h b/include/standard-headers/linux/virtio_can.h
new file mode 100644
index 0000000000..6380ef7bce
--- /dev/null
+++ b/include/standard-headers/linux/virtio_can.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ * Copyright Red Hat, Inc. 2025
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
+#define _LINUX_VIRTIO_VIRTIO_CAN_H
+
+#include <standard-headers/linux/types.h>
+#include <standard-headers/linux/virtio_types.h>
+#include <standard-headers/linux/virtio_ids.h>
+#include <standard-headers/linux/virtio_config.h>
+
+/* Feature bit numbers */
+#define VIRTIO_CAN_F_CAN_CLASSIC        0
+#define VIRTIO_CAN_F_CAN_FD             1
+#define VIRTIO_CAN_F_RTR_FRAMES         2
+#define VIRTIO_CAN_F_LATE_TX_ACK        3
+
+/* CAN Result Types */
+#define VIRTIO_CAN_RESULT_OK            0
+#define VIRTIO_CAN_RESULT_NOT_OK        1
+
+/* CAN flags to determine type of CAN Id */
+#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
+#define VIRTIO_CAN_FLAGS_FD             0x4000
+#define VIRTIO_CAN_FLAGS_RTR            0x2000
+
+#define VIRTIO_CAN_MAX_DLEN    64 // this is like CANFD_MAX_DLEN
+
+struct virtio_can_config {
+#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
+	/* CAN controller status */
+	__le16 status;
+};
+
+/* TX queue message types */
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX                   0x0001
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[] __counted_by(length);
+};
+
+struct virtio_can_tx_in {
+	__u8 result;
+};
+
+/* RX queue message types */
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX                   0x0101
+	__le16 msg_type;
+	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	__u8 padding;
+	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
+	__le32 flags;
+	__le32 can_id;
+	__u8 sdu[] __counted_by(length);
+};
+
+/* Control queue message types */
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
+	__le16 msg_type;
+};
+
+struct virtio_can_control_in {
+	__u8 result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
-- 
2.42.0


