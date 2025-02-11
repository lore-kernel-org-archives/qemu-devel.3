Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8431BC021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrTl-00080i-UZ; Tue, 11 Feb 2025 09:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thrTj-00080Y-HS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thrTf-000514-JQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iLkKusfjzzxxrZTcbLwIvVw1ebfi7UpNZpZRbIN4u9I=;
 b=gVrBkRZrViC9fs87iaW6XlsaiAFrossEISc2994e+3xqPIJoovkMS/RQRbNFxNhOHf9jVW
 fxLNN8BfipiMR59FGgTxxc9RV2E8g2tOediZF3Tgd+rXMmKWpviB0N8Ofe5Gks6nw3DlTi
 ugP0pe8bLkW8XcsxoOSqz/EHmVKPnx0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-7dsMo_Y-NoGRi23oi3IBPQ-1; Tue, 11 Feb 2025 09:43:04 -0500
X-MC-Unique: 7dsMo_Y-NoGRi23oi3IBPQ-1
X-Mimecast-MFC-AGG-ID: 7dsMo_Y-NoGRi23oi3IBPQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dc88ed9c0so1756956f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 06:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739284983; x=1739889783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLkKusfjzzxxrZTcbLwIvVw1ebfi7UpNZpZRbIN4u9I=;
 b=Gpfi7wtU5Jb2Cy8z3YOTTiT5MfGBjeTZyoXC6VpgVDrlcLel7vQZRcrxAWgjIruKCJ
 IUrQBKkOdqxDCZ1cQ7l/KcqHaWdIQg5B4dI9gY5rXSUfMz2do3+6SMdFM03kUofCiVOX
 EpMz51bWz2D2z4uoWRToX3gP76EdonQAFfXS/6mEBW1fwu3oKDQaod5Fp6hK3+JE4PYe
 ri3SwfvQLNt+1pck98NcC8uaHKgK/3xa2ToMOuIaGIBqoncoI93tn++V7Geeaa9dXRrx
 rY5GT3ljoSIOLGkHclJTjYsrQGQUIq/lWMy8pVL0zNzuTvkKZbUVdkwX9YcDgxFBaBka
 umPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Mmmm2zTbcHMVYnPS2M5FmUwx0LOgeEzr6zdInrsGgzRKFy2u4O0RfZ5UMxHeBwNuAfpxzgAGZV/t@nongnu.org
X-Gm-Message-State: AOJu0Ywv+aNPxO/fDo4Ue9dPB2nEMoGfumaGlqTqD0y+8Q9yw88QvcUg
 0293+VAC9wpJNYWqoi9OyXlvH8vA0qpYydLQF/HctJRwX27bQttcEdbhAsCR8e8Jr02zlMa9Onh
 N2VxuS4pqlxDFDfVqREjVYCPsnr7dyAg7biamPwadCc62xaQ4LXKQ
X-Gm-Gg: ASbGncuSv0Jp186p+i/7LFLpv9uZjcFF8Xm+mZ1YrCq8PFUHSZkytn4KUUtUC/QsZFd
 HSERFyqgyWmiEod+CEFxkn5nz7NfXzqTbXzXSJ1wImi+PsHJFjfqYqYmiCCxdGdyPX+8a8awm5j
 t7UuDO6GFo4tCixwa9tLfVeZL7DDF8pkaD9P88Tcfj8nRJ4wlK9NSMlmyCk/tervRE0DJwOYNP4
 rZWoFT2dccc91i/LZkLib5eF7S+fwuHIE9S4/NxM4Gh8Rc5vd4MKGJUGn8qm82Xr4f79uCnPApD
 uzBXNXwCkexSsiDsig4RnpqBkNKmmHJCQdRKdMDyXF3pv5nF44XW1qE=
X-Received: by 2002:a5d:64c4:0:b0:38d:dcc4:1dcb with SMTP id
 ffacd0b85a97d-38de416d704mr3735738f8f.2.1739284983160; 
 Tue, 11 Feb 2025 06:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF044mlgmfdXCzahgywX8cOO1u5fMiMHnioarIK0MqKOTIZLofs8/sVp2loa8ZxvqKUhN/KsQ==
X-Received: by 2002:a5d:64c4:0:b0:38d:dcc4:1dcb with SMTP id
 ffacd0b85a97d-38de416d704mr3735698f8f.2.1739284982554; 
 Tue, 11 Feb 2025 06:43:02 -0800 (PST)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcae5c7sm177587125e9.18.2025.02.11.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:43:01 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] MAINTAINERS: add more files to `vhost`
Date: Tue, 11 Feb 2025 15:42:57 +0100
Message-ID: <20250211144259.117910-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

While sending a patch for backends/cryptodev-vhost.c I noticed that
Michael wasn`t in CC so I took a look at the files listed under `vhost`
and tried to fix it increasing the coverage by adding new files.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 842bac8a7f..7a0b493dee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2219,12 +2219,16 @@ M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
-F: docs/interop/vhost-user.json
-F: docs/interop/vhost-user.rst
+F: docs/interop/vhost-user*
+F: docs/system/devices/vhost-user*
 F: contrib/vhost-user-*/
-F: backends/vhost-user.c
+F: backends/*vhost*
 F: include/system/vhost-user-backend.h
+F: include/hw/virtio/vhost*
+F: include/*/vhost*
 F: subprojects/libvhost-user/
+F: block/export/vhost-user*
+F: util/vhost-user-server.c
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
-- 
2.48.1


