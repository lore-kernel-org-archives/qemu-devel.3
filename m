Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3776C8303A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZyH-0001je-H3; Tue, 01 Jul 2025 08:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxq-0001VB-Tg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxh-000606-3Y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QJsVs3Is6GlFkBo5r07F7vLVP+L5LvCuHy0CEmKF3s=;
 b=D2htQj5LAOL56L7Pu9yrw+RRq3U84CMLXW29HGlVXyeqd/8XIsBEFS438iu8XifoeSbzaw
 c+MKDM1CFNbdG02vbBbmUdmVEqtHKn6tfkIkJeeGEBiN99P5mPJ+imDEEaGRK9kWTvMgGG
 QRuXhOgGsheKjr8dnBn7W6yUOhHS7Ng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-x_IODVQeNWuV6XbZeVWerg-1; Tue,
 01 Jul 2025 08:18:30 -0400
X-MC-Unique: x_IODVQeNWuV6XbZeVWerg-1
X-Mimecast-MFC-AGG-ID: x_IODVQeNWuV6XbZeVWerg_1751372307
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6AB31944A8C; Tue,  1 Jul 2025 12:18:26 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.251])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEB3319560AB; Tue,  1 Jul 2025 12:18:22 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [RFC 1/2] hw/uefi: Add hardware-info ID for virtio mmio devices for
 SVSM
Date: Tue,  1 Jul 2025 14:18:14 +0200
Message-ID: <20250701121815.523896-2-osteffen@redhat.com>
In-Reply-To: <20250701121815.523896-1-osteffen@redhat.com>
References: <20250701121815.523896-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a hardware-info device ID for virtio mmio devices intended for use by an SVSM.
The ID has already been reserved in edk2, see edk2 commit f25e3d0d2c55.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 include/hw/uefi/hardware-info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/uefi/hardware-info.h b/include/hw/uefi/hardware-info.h
index 94c38cff20..d688af0e8a 100644
--- a/include/hw/uefi/hardware-info.h
+++ b/include/hw/uefi/hardware-info.h
@@ -14,6 +14,7 @@ typedef enum {
     HardwareInfoTypeUndefined  = 0,
     HardwareInfoTypeHostBridge = 1,
     HardwareInfoQemuUefiVars   = 2,
+    HardwareInfoVirtioMmioSvsm = 0x1000,
 } HARDWARE_INFO_TYPE;
 
 typedef struct {
-- 
2.50.0


