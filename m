Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA38E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxn-0006PO-UM; Sat, 27 Dec 2025 04:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxk-000681-5y
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxi-0007XV-Pl
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=jWdqjHuD66y0vmuKcu66HuLB20pD9UCaB1yIjq3fVphebvfAZuojrAf4Vd0LZime0OeQ/n
 lMKSGFr6MBLvl8CZXw4i2OgpO58ccrXo52oImkZzDC2W68Yhyiusop8gA3MF4KdHjU1DMN
 C5/0+QR55/sOFC/N9tfsbJTKmyixKbI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-K5hvCHM3MNWgTVV_V5LFyw-1; Sat, 27 Dec 2025 04:51:49 -0500
X-MC-Unique: K5hvCHM3MNWgTVV_V5LFyw-1
X-Mimecast-MFC-AGG-ID: K5hvCHM3MNWgTVV_V5LFyw_1766829108
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d40e8a588so11337675e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829107; x=1767433907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=IkegWEKn8RAwzGphAWFTnN9U3XMuhwc0adjRJ8z9H10bzdHb1KkG6SPEw75NU7vIom
 xHRaoiSHNgxdheKPGppPHFP7BnTTFtPTfRfdaPfwSeJlEfQBe4EE/2FqUUqJ+WIsQdlF
 zN77U6k/rao7mfJ+FhH4f3xEAimeOEBg9qAr0oB1wPZAAlup83IV1fitA+tWy2MaXEfb
 9Zh9t/qC5pO8/jylkXGX8brkhg6CTUl2Ouig0VMRLF8+/1BTZzhaoYcppGaqZPkruzGT
 zc5vyKiLYNXldx+Dfen5o+jfDolBx+z7QFXrAFzKQXPs9GiyqNngy6CroyBLY/FSOF9m
 Pulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829107; x=1767433907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cXebI6NrLoDz4RV0wSCSw2yTB6kyWf9EWw7Kp6QRaIY=;
 b=rTsIR5vPCW0GWqrjqGOBYES8LJ9aFH3OI3cxSM36z3cIe3EU+6Oe/TGxzihsr6wK8M
 jtJUCQ92fNjzl4ocGqkluhHayO3yvyTg2lTKt2yTRit0gaTlXSxAOIzNrrZucRZN/GBu
 CAn/jhza3Sztq5v9rmZYZv3KaYzbX+MnMmSKTID7ef/5/ZsQGaJUls6s+CclkF/CApIJ
 RuLtvZcEslIEaX56u0fYHziUp8B8f6k9JgqmARtwNn2Sz4CyyhhwQomb61ZjTtegVusP
 eHPSHkBVktDIjYeIMOpWXrI3NaOPJqM3qvLIKcQIpTeDAJDS0epc7S+Fy+p6kBuZLYl1
 upBQ==
X-Gm-Message-State: AOJu0YwYIZYdNnkeqjoBdfhVFPiRgPCiEDy9tBEF8BVpDXIfim4K4ne+
 zr8ocpKhVLulxE8KtkFJ7kHMxzEQpP6YUqXqfIrj6Jn3Zf/rc6rLjCfA1tN8qRhf8l8vve4c/b4
 eAHKrhgMXs3tQjJEcwpVWeQktGb8+oMB3ZQc5qYXRLxoNRzo1jzxywYTq+O6OAVasqlHRcsNheZ
 CZWM88cH2N8Alu922Q5qs5C20IAb4qic3X18C3PyJ7
X-Gm-Gg: AY/fxX7bQ4N4Sb42txbnlBV1gqPiRVGniT8UjQEytTmpYNFjRwpwCbRvAaZ4oBl7YNw
 sWVylAkSEJgpUMdoLthJxju65VB9ftiZfW4KrIBXsOMOr9iWzXONtuBokmwFV942gUheczjGvWp
 UchnS6ff4RHOp1j3cBkuhJa3xBwKSda9L58wQCviWRqr5Yt4BrNHHU/ncCQ1g8h0706TfNwuHF7
 GeXoW05gQd2x2sCoCiyQGy9ReNsXmp+jA+UbSj6eG5z7DOXdyOr9Du+T0Ma6RZ2SuC4IyetDT39
 /p4sMXkoXLktCN3rOOYNibRLaSH7N7de1xjVNkBFAf8GWRqVupqpGw5Kum9Q05XBDGeJ/O5eVZm
 5VipWhHMttQCZ+ZIeSedngKSNIPFepc2Gqdg3/Bm2Kbrewd9K2N8gu4N/lkY9zw2JDN74PqaG51
 NfqmtVmhtY0I2Aep4=
X-Received: by 2002:a05:600c:a11a:b0:47d:3690:7387 with SMTP id
 5b1f17b1804b1-47d3690750amr139924355e9.23.1766829107497; 
 Sat, 27 Dec 2025 01:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMb+iGpuAlpkaUDyqOUTvXcqoXSKg6Cu9edJtGxxJuIwI6PHONS1LUGZphqlsSdTcJKGCwqQ==
X-Received: by 2002:a05:600c:a11a:b0:47d:3690:7387 with SMTP id
 5b1f17b1804b1-47d3690750amr139924165e9.23.1766829107128; 
 Sat, 27 Dec 2025 01:51:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm49528254f8f.39.2025.12.27.01.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 149/153] hw: add missing includes hidden by block/aio.h
Date: Sat, 27 Dec 2025 10:47:54 +0100
Message-ID: <20251227094759.35658-75-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


