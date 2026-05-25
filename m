Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD40CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2q-00066U-Ln; Mon, 25 May 2026 11:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2j-0005yY-4k
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRX2h-0007Sw-1o
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZoRrPKKW9ueGQMCwPYgUoUbXyUbtgzf4g7LYHgH0Uk=;
 b=Y9HTld/915Qa0ib82t/3e5ymxBVAwOSFH6iMPW96sxJcGBqJBxg/wuIZZWdSZnfQFx9Nhr
 noJwZzCsh+V36B4D75OLDJhA6kKUwiGP5p7SMlY9BVw0kFtww4QR0+4XSpsJzx+qyJ05yg
 HinDh5oybPQVWJ2n5PZPXlDCwo63HN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-KQpcS2SWMlWPnTUogwfyKw-1; Mon, 25 May 2026 11:16:28 -0400
X-MC-Unique: KQpcS2SWMlWPnTUogwfyKw-1
X-Mimecast-MFC-AGG-ID: KQpcS2SWMlWPnTUogwfyKw_1779722187
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4903dcb32f8so31594345e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722187; x=1780326987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZoRrPKKW9ueGQMCwPYgUoUbXyUbtgzf4g7LYHgH0Uk=;
 b=TR4qHsaY9dzavh8aTIL6JcsW3o8suyslhwWRtC+7TiKp+S9eHuEfbgWleHFWzjjnSl
 nZSbiKsAv4V1Pqk5ZjfOb3p9MFGhMXz4Yrm4wkoNn8odj85X0KVx/Dt5lyf+WiIOv7HN
 uvsRcZE3d3G+qx9+X9I9wb1l7Qma3J9/MQskkiGThE4PeHJUoM1WXEdc979jcoCYNqkg
 J2A7hPIqxltvJDsrnJZhSt8PaXBjPTD1yGNuBsUAfCBduycD7zKn0n/RzV+PsP9JeBJA
 rOMI2+hW55B9gRbdvxsKCkUsLfxaATVvFRKiVurrgEWGX2I0GqRQR5FcNsfo8VdFZSNJ
 HOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722187; x=1780326987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZoRrPKKW9ueGQMCwPYgUoUbXyUbtgzf4g7LYHgH0Uk=;
 b=gvLCGATjQgyyfMhmxzzGpKaoI1QAnsW5EZQjjnqTwm69QIpPpxjNQ3dxXVAc4iDM9f
 gzUaYsmi7GiaeOA5U4V3ApzKDxNprlMpb27+wJIaOMSGn8e5jZ20284+EVfTkElY6PH3
 OZw1Kr5werqAMJUW4dUoV+v4tx9SPwzCaGjReR4+oJ2Vfx/+dvTEQSI/l/irfkLTAiRt
 m1rBT6nyQzURmGTOFUqtmlXmYDWt4n5ArUD8ZP/Rq+UaijsK5JAjpltRCXB7EBVg/5TJ
 vphGmyE8/jynK62mwW2j5OsYfdzKyNzAe5Bh85T58ZroV6Ro+YIC0uRnQm6y20bthgXD
 eAAw==
X-Gm-Message-State: AOJu0Yz/Zv4OpyP97PnEpt2qkc1nFYgjm+44TYpnXX+PBeWI9i8sO03M
 Ai6B81xW9A4z/ufrCScv+GuafaFm5mcju/Pyqx3YfLHOHA2CKtAfYPhO5mXejBKCPU5I+my/jeV
 D7LhEcxz5IpNx80ONb3P5oW/htAN67i+YLrwzEAxN/gckPBlHWjT9OAQOB5iWK4W/XjXF6b59SZ
 HDQaAQjuNai9MbK/+6bZvB7TwZfYwJaFjk4XufjioD
X-Gm-Gg: Acq92OFEXQT8OYMY4tjXumQjrOcwMCu0qYIx5gYYQt6Iv/qgA0GyktV4FTE0eYSuXdl
 /0TDeRr8V7I/I9BJQ9/F0EoPyUU9DBo0jyuHDPWb44RCNgdWHE7i2Z+c+HLLN4Bd3rmR1qGV3oq
 n9Mf+ysuDwsHV43g/BWNmy7PirJn9VqIaBdWzJmLzRRtQtc7ckC/PE7hLHDGNl6FGzfab/xNzus
 jM5eL5iFn4qByEgvjiQrGfR5lmizlYyT19DWqWYdx77klWpE5MvPVdRbeNo2b/36bxPINi6mny9
 ZJYF2zpGUJUEbTx68FJbMvs8JISBzLX5Migr57CECMVBENGUBCUqqm4whocu+cj+FlUKBEyXuJH
 89EpGr6vyjp/2HLcMmU74+H1zwmAqyKMgcUAYREZlINyDQc8sSalkDpJPCr1v1uj4Ii7lgU9yuJ
 vOrKNM6QbO1cufMztB9I93s4nyTLgy
X-Received: by 2002:a05:6000:2889:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45eb38c522bmr25297111f8f.20.1779722187267; 
 Mon, 25 May 2026 08:16:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2889:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45eb38c522bmr25297067f8f.20.1779722186753; 
 Mon, 25 May 2026 08:16:26 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d493dfsm28160673f8f.23.2026.05.25.08.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:16:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 2/6] lsi53c895a: clear tag byte when processing messages
Date: Mon, 25 May 2026 17:16:17 +0200
Message-ID: <20260525151621.395954-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151621.395954-1-pbonzini@redhat.com>
References: <20260525151621.395954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of simply ORing the message byte, clear what
was there before.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 0843d325ab1..1b7f02fc7c9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1041,16 +1041,19 @@ static void lsi_do_msgout(LSIState *s)
             }
             break;
         case 0x20: /* SIMPLE queue */
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             trace_lsi_do_msgout_simplequeue(s->select_tag & 0xff);
             break;
         case 0x21: /* HEAD of queue */
             qemu_log_mask(LOG_UNIMP, "lsi_scsi: HEAD queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x22: /* ORDERED queue */
             qemu_log_mask(LOG_UNIMP,
                           "lsi_scsi: ORDERED queue not implemented\n");
+            s->select_tag &= ~0xff;
             s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:
-- 
2.54.0


