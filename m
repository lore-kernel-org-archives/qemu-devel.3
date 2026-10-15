Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6838FCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ6b-0006zi-12; Thu, 15 Oct 2026 06:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6Z-0006tb-DD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6X-00080T-Ld
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNQIM553HblX0RjcBNbRHiKZc77ue8B1S/rjP1vEA/s=;
 b=PCIZx7Bu7ZwyW9wgTmoFMMX0J4V3Utd1h3gSLZLDScRlxrMpxM6IZ2UaRXOw+B7YRipm+z
 4oszvjHXtROhFS4QuRIOT/sWV55ndIpZxKjMWZJDP97C6+QxTi/wyfJcb58xU/Nu0C8dlJ
 wGh+4GReSAer9dhDc3RfGTjh4TmSWR0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-mS_0QZNpOwa_1fNjvZTJnw-1; Thu, 15 Oct 2026 10:54:31 +0000
X-MC-Unique: mS_0QZNpOwa_1fNjvZTJnw-1
X-Mimecast-MFC-AGG-ID: mS_0QZNpOwa_1fNjvZTJnw_1792061670
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so3258900f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061670; x=1792666470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CNQIM553HblX0RjcBNbRHiKZc77ue8B1S/rjP1vEA/s=;
 b=SoSB1uwKFF+HcBjlde6IwfxaE6ITQ5jSpxgo13ct5B/bwCtkQBZ+Kzwy7ji28ewZUv
 xytfMFvmvYumat+EoDE2i+Y7gXi80UrzHV85CyzuGPiw7Ldy0ld7Q9/hws1FAkj1YDZf
 Fd9jU/CmXfMC3e+O9dimsasrI4EKH1C9uIMpzKKxKX4n52n+1qPabwjUG42xAQutl0mo
 4U930rQMNW3RdyVUgFdJgOD2GwZZwl8o7PkWlAI4u7il+r+yW8KJwH4tbl7RLJBIcRcZ
 CKcNdNtosBPt3buy/BWytI46axO/53dtWUHMoDWqgKirrJg1M485kUnRoJAcTq4onIgV
 drog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061670; x=1792666470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CNQIM553HblX0RjcBNbRHiKZc77ue8B1S/rjP1vEA/s=;
 b=LfOVeiHQ0XAIbMa4w69aVARofQCGjELqO2++gdxUgcTZkF3Rq7fmN0sGe/4sqcmetO
 fYW43kh5WClnoj2YXGQW7XlWkpdTRYi505mXgauMV4g6n8bS0zWyOjisCUMZ+Xim7kMq
 PY+kL23jTW9jfS8FVNM3AbLwUBvnFi0DqY08y43iwtAaRn17baSI9Pyn+bXIjCBKi+jX
 0NgqW8Xu7NoEZnvISel2AuMMnpu9Sj6AFMdNz946+5c75T0vzpMFn9MffDMX1P72Atah
 peu33jrQIeO3dwtIoCOy2n0R+K0m8qAg/GlMEOGtAw/67wUdcgPzFhQFGPhjVnbnHOyN
 nKeg==
X-Gm-Message-State: AFq9FYJeMuJ+X3LIMD5pt3RaK7NXNAOJoh5iKS70sn5UqbRd990qAb5u
 d6pNvOKN0v/Mi7xBvFaiIo7JMfZlNfGAoHAS7e46Krrf5uBbTUjVLy+uQd/hZu7atqOmNYkgILZ
 ZE6G3bFV/zH52+Df2wR8NuxjShuqa4EEwGy9iEyVtWjFe4mHyzOa3vG9Ituy2R7XEryRVY4pVwR
 PwM8Lo/X4rju8LfXyUyNhW/bGPhcU1/2y2ERrvqFtS
X-Gm-Gg: AYBFou0V82ztD0YDI3FZ0E3Y5liKxpjJE/XPxhGUDpyzny8Y/JMSn9O4g1o5T5TPHFh
 5FNmL2hjJlV0j20M5+qf0xxKfp96Y4lEqvewbdfNNJDHHqBdQjWqP9jliC2qiP2pYmPpKp54Eq9
 IoT1o+5gsYVBfMiJ6mhlJ5wUbam82dS5KSNDbXOwluM/hsvKxEScCAyRkQNrdDRFmSXcGmoQWPJ
 wzLSzHuwMB21fHEUr1ySFBwATEC0aXs6og2p2kBg463cSf/mluCEfOQNS8esb8XqCzEu6NCyZEn
 0AOvFw0eP3fvJXY4pZZ7O9bSEL8EooQYuZpOl/SWnJFB7txKj8BeiGe56KppGx2D9LZbJt3S3Nf
 fbRsof3Tf+WUF4jFwu+H9Dk5Q8aACbIp3vPpt+VvSj2AjIXxMcVqgU1XLOtVmfZT0ap5Mh+aNHL
 FiNG1K
X-Received: by 2002:a05:600c:8184:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a18e4d854cmr348939245e9.31.1792061669954; 
 Thu, 15 Oct 2026 03:54:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a18e4d854cmr348938885e9.31.1792061669524; 
 Thu, 15 Oct 2026 03:54:29 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd99febesm71189935e9.15.2026.10.15.03.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 06/13] scsi: increase sense buffer size in scsi_SG_IO()
Date: Thu, 15 Oct 2026 12:53:40 +0200
Message-ID: <20261015105347.827029-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

There are different SCSI sense formats. Increase the size so we can get
more detailed sense data.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-3-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8999f3b7200..153a5275567 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -923,7 +923,7 @@ int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
                uint32_t timeout, Error **errp)
 {
     sg_io_hdr_t io_header;
-    uint8_t sensebuf[8] = {};
+    uint8_t sensebuf[SCSI_SENSE_LEN] = {};
     int ret;
 
     memset(&io_header, 0, sizeof(io_header));
@@ -947,15 +947,18 @@ int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
             error_setg_errno(errp, -ret, "SG_IO ioctl failed");
         } else {
             g_autofree char *sensebuf_hex =
-                g_strdup_printf("%02x%02x%02x%02x%02x%02x%02x%02x",
-                                sensebuf[0],
-                                sensebuf[1],
-                                sensebuf[2],
-                                sensebuf[3],
-                                sensebuf[4],
-                                sensebuf[5],
-                                sensebuf[6],
-                                sensebuf[7]);
+                g_strdup_printf("%02x%02x%02x%02x%02x%02x%02x%02x"
+                                "%02x%02x%02x%02x%02x%02x%02x%02x"
+                                "%02x%02x",
+                                sensebuf[0], sensebuf[1],
+                                sensebuf[2], sensebuf[3],
+                                sensebuf[4], sensebuf[5],
+                                sensebuf[6], sensebuf[7],
+                                sensebuf[8], sensebuf[9],
+                                sensebuf[10], sensebuf[11],
+                                sensebuf[12], sensebuf[13],
+                                sensebuf[14], sensebuf[15],
+                                sensebuf[16], sensebuf[17]);
 
             error_setg(errp, "SG_IO SCSI command failed with status=0x%x "
                     "driver_status=0x%x host_status=0x%x sensebuf=%s "
-- 
2.56.0


