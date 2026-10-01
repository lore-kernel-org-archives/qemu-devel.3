Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ACFCA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGs7-0007va-EC; Thu, 01 Oct 2026 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrj-0007eT-Ao
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrh-0006KZ-Ut
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQkvoJscCc6aDW9GWSIoJ4FtHTQmqSYkVmc7PFwItO4=;
 b=AxazRTsL1TBRtryY+RqceBJCjyPiyp4eIBxCriNOkpKlZktHJ5ueQZJnk6XiVBcEsW4IPd
 itiNOwKo2vMNeN07c34rl51a1zK40M8BRgFdyo6S6AxliXVNV1NVuFwTs6IwbOQBdHUBSr
 CiIdkO9Fo9qVfmzSPTGEUfGzzZEwvhM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-VIdVdvYBOBSxH-H65MQrQg-1; Thu,
 01 Oct 2026 09:30:21 -0400
X-MC-Unique: VIdVdvYBOBSxH-H65MQrQg-1
X-Mimecast-MFC-AGG-ID: VIdVdvYBOBSxH-H65MQrQg_1790861419
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978771977032; Thu,  1 Oct 2026 13:30:19 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEA5546E; Thu,  1 Oct 2026 13:30:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:48 +0400
Subject: [GIT PULL 09/27] hw/usb/dev-smartcard-reader: validate migrated
 fields in post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-9-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b8IBtxChvbvmJQ3hfxAOtHgud/sBAEaYO5UFt/xsmfk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBH2k8XDBy/lG0XS8KMY4WwzGJJeSbiJqpqD
 AmpDbBk+JiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5byDD/9o3MGLvdcR+k0PLB/aS+PkyEVdXuvu3RBFliBZ5DL0ia2Ob511rlMmPXM9lhlF6FNM4WD
 2KUDzfsQ/99LAZ3nSd3YlxVQYybkZeIF6TwHhuqAQs+wNSgcf9vvNvBDu5LyOQaCAF1aZ7DSMVa
 R+VT3qlsGMFsxXiOL6mlE+log8XzyZABQyWO30UXgRgUm9mbeoqS9ldOO1Ii7XbXQhDbOpvxBWe
 q+e1Cr1sNjamyLPyiThnxJGwM7/yL1EgYqb45YUZloXQohaNaOwpu9i8qEPOE2+bBh+mOPDu7hS
 y5A30hRiFtuDIrxazKfnPuO5IZL5sLc81yl6UC1UwHy54TEOE+HOvmpNKd6RxVmla/VWIPXjkEO
 UNTk0lflHMihAm/LA3rdKOtkuA7RUd4dyjn8dwRXZDT1t1G3FG6C5fh7ht6zVDy9QD46eKG6wLa
 LCeN/LQr/cL/eUePQkUaZWhFamoFkGCcizNdz0v6vlf53B1saGksLfcBBNmS8xenfgFETzrWqAt
 JFWCSU1DlJmGtgdByNVlH3E6m8cLgNqkK5IFhRGdlDkwRQNsDDFARzEF6lU6C8gllwBAB9m1R1G
 oi5rYfAg3nKVdwDzNPyrBKEu2Dn/xUgDmxMIB/8atbguySz+OONoLKgo7edv+dlm1glXGhaqhit
 Y9TKtSwSr6XIbvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Validate fields loaded from the migration stream to reject crafted or
corrupt data before it can cause harm.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 0201b994f9c2..52d6f7e8d4de 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1368,6 +1368,26 @@ static void ccid_realize(USBDevice *dev, Error **errp)
 static int ccid_post_load(void *opaque, int version_id)
 {
     USBCCIDState *s = opaque;
+    int i;
+
+    if (s->bulk_in_pending_end - s->bulk_in_pending_start > BULK_IN_PENDING_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->pending_answers_num > PENDING_ANSWERS_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < BULK_IN_PENDING_NUM; i++) {
+        if (s->bulk_in_pending[i].len > BULK_IN_BUF_SIZE ||
+            s->bulk_in_pending[i].pos > s->bulk_in_pending[i].len) {
+            return -EINVAL;
+        }
+    }
 
     /*
      * This must be done after usb_device_attach, which sets state to ATTACHED,

-- 
2.56.0.rc0.29.g47ce80527c56


