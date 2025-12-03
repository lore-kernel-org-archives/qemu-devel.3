Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A16D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrx2-0007Xo-St; Wed, 03 Dec 2025 13:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx1-0007XR-Sp
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx0-00011s-Dg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764787901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=bcoA+net0SX+E7o+2eNPDT9tOiqS8FYvbWlTyyzuOQj6bWyez/sQQT8ZPa8sgT0wzTpc/k
 3xuGkDZVRL/wHpQ+ZBA6zkf3nvn8IzqKPedH5xKqDhR2w+NrCCILRo+8nFrDYP3xVMljxW
 LV6JOLYv7fOuBupx7YV477/DLxVcrnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Zyk0TPxwM_ybnCxj9CCmEA-1; Wed, 03 Dec 2025 13:51:40 -0500
X-MC-Unique: Zyk0TPxwM_ybnCxj9CCmEA-1
X-Mimecast-MFC-AGG-ID: Zyk0TPxwM_ybnCxj9CCmEA_1764787899
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso558925e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764787898; x=1765392698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=TDkQPvx0HMoTRxgr3W8PqxTCS2Q5qDrpKfCLaTIB24oLaWBoVljHY7w69kNF+Lzrk8
 eRLvzrqQFXSf0UBwez3dabjnMT3I3GWUad/mTscAJVIzpGXP5HLzDtNiXjQNSRlJNvmn
 2DAVlM+nvUBLC0QpNJQrPwfcnk0czaS9SZY4//kN+WLT5OJVbsgMZHBStdzeIrBsdQGY
 Nj0WttyLcAVy8hIISpnyjuv7yEc0ZmjgMnnqCCJXlT58iHXWtDPOT90XOkgR6MMRRumD
 P6jocHemyVNaE+Z/LiicdPhYfDgS46d6DOHvjLatxuCROz1kRL3rekHKfctWnVfFh+82
 aGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764787898; x=1765392698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=nnqYPX+bMZSoxRur8ft9+82M7yRPMd1oYJff9ZssWcIGHRpSuPoq55aJVCuH471dsq
 CJsrvJ/TeD/i3bbA7kD0i21vBUZBqRzc0zZ44GttB4MnQT0M0iOg2Ucc7FgxOb1g1LOa
 2Gsev6eBOw9KHCqdO7IEw1Nbc0SnBXIRw83ZyxRLFYq7UH5LUi1yR+GbfrkJrFwAq4S+
 yOfjT9Rpyod7C9g2qwB8fWIBkKmLkive3cvmNu10afOyYH8sAdTcUzurmWCik5K9/wVj
 7qNTJFO7JBDF0uZNDm8xJAat91E/mMV6Ycl5NeRG+YEliO2UKxpMP/ggzhKSZ/JK+f8O
 jpEg==
X-Gm-Message-State: AOJu0YwERUkE9cp6D3+7fPztJYhvdI2riYhqEHFVtu4TfyhM0/RUchiI
 fyrRTc0XrmqzqXpJPFHGbb+kVJkrkcOLCa78qA+vGN/HEHD84xzym0dqUVlR6RPiysV8B9eK1IJ
 5g1z81QvL4IXEvzPKbOcEPCZmOzc3ZBUfD0SxoGcpHhxM+RGP+JNifg6iQHuGca2q4nDaOVMVcJ
 SP53hl/Y1ZJwPAj7VK2LVXWB2A6YJv47yMoHymB0+R
X-Gm-Gg: ASbGncss6XDqsaw7qJGSCik1u0jTlyuGe7nZZPb7ny0OQBDwX0L3F56ehsdnEPLutpy
 ihVo9fsVcym8Iq51Ql3NqrhmSb6OcSUu4pYK0PPByqeZSXPnF1WD3zk44OhFV53PDiVwCY2GMVV
 VRskbtbZac0CzGrKuerCcjrflR2DSvm9My0q0xQ9joWxSKepexH9ATFh3nQDiFMxZknJVUi+BOn
 LhZQ48v6Jv2iWbhfdDcS9fDsVMljvL57U92JyMAN3V4jGpWWyI6p8c4uYuIZ4fqzzRdzUXLKIhp
 Oc/yLuyNirhcYmECsLMmW5bXnF1yEdZp1TcH3VFSF9msXdYqaI94aOY9kOip06PnuM5jbNnvvKr
 t1FtltlwcPGkFatdX3mEYFjA4SVB1NQAC7ljyGLVRs3LvSzUlwH8yA0p6x0PC99kSW09/vkwawH
 CGlQSYlG/YWhPeX9A=
X-Received: by 2002:a05:600c:1f8e:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-4792f23c727mr1729045e9.1.1764787898449; 
 Wed, 03 Dec 2025 10:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe54FHEkEyp3HQgbdF1ffHa/PvsyBnrdOiVzgbhK/wjfNO0B5rJ1dCrcQMg2XyF/IpvpudCg==
X-Received: by 2002:a05:600c:1f8e:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-4792f23c727mr1728725e9.1.1764787898018; 
 Wed, 03 Dec 2025 10:51:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3016sm40403411f8f.1.2025.12.03.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:51:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.omc
Subject: [PATCH 1/5] hw: add missing includes hidden by block/aio.h
Date: Wed,  3 Dec 2025 19:51:29 +0100
Message-ID: <20251203185133.2458207-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203185133.2458207-1-pbonzini@redhat.com>
References: <20251203185133.2458207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hw/qdev/core.h being included by core headers means that it was quite
easy to forget including it, or anything that hw/qdev/core.h included.
Add the missing inclusions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/char/serial.h        | 1 +
 hw/virtio/iothread-vq-mapping.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index b804e225886..ea82ffac476 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -26,6 +26,7 @@
 #ifndef HW_SERIAL_H
 #define HW_SERIAL_H
 
+#include "hw/core/qdev.h"
 #include "chardev/char-fe.h"
 #include "system/memory.h"
 #include "qemu/fifo8.h"
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 15909eb9332..55ce62986c7 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "system/iothread.h"
+#include "qemu/bitmap.h"
 #include "hw/virtio/iothread-vq-mapping.h"
 
 static bool
-- 
2.52.0


