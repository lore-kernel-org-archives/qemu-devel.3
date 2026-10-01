Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78129CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsZ-0008QL-0h; Thu, 01 Oct 2026 09:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrc-0007e5-MP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrb-0006IT-7W
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWEzyTtziHOLEh9QjJ+cJOSJFGAj0GMSIb02VCXNztU=;
 b=G34c5wyOeb6kPcsIglflbUJInGzBAbQoZmxHq+ny3XvjHvUaWtEezRLkOxRSZPapaC++X8
 o740CDggETa516Ah/TwD5mmFEgoljHsixTgh+NgCc8GEDcik35fQBchpz1sLxjkk6a+H+N
 DnqS76UpKkm+nV8d+70sN2Bq8wcEY5I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-08ifCF5RML2yNL0G5NWgbA-1; Thu,
 01 Oct 2026 09:30:14 -0400
X-MC-Unique: 08ifCF5RML2yNL0G5NWgbA-1
X-Mimecast-MFC-AGG-ID: 08ifCF5RML2yNL0G5NWgbA_1790861413
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26D3B19056B3; Thu,  1 Oct 2026 13:30:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D92C754; Thu,  1 Oct 2026 13:30:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:46 +0400
Subject: [GIT PULL 07/27] hw/usb/dev-smartcard-reader: block migration with
 pending queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-7-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EfS595qdVS9FMShSxwqJrIEBbIMzucm9U1uL91PHu/8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHI34vTMfpqF9JrAYzoLUyBG7/ZUDU/83Qs
 PyAFVgBzGKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5eCAEACVD3Putj8jMxUpCcQF4LYCGCqQTduLQd2CIibNDDOJC0e7jUloSBmSWfcm64PH5cB0xq8
 wdj3POKj7ONcEwbqG5b6sPUs4tJzOpjcZGeoe2YxGScHq9WXYnsquCB0ieScPS/IaClXtxcrBKK
 1eWWVZrGRECNHA08fAcpPjX94eu2D7iS25lKxpMCEekM+NyCmzhMwGhwsV0wayGE4GLeiQfsCdC
 cz836M1G6f6fO4uYJxUshTsUyzgsE4HswfhvGmDQSf1KAk4miXaWwoz0g03Sz9XeyPCLeGTuN7g
 uWy1ACc5QiObjPUtB9fzkmfd4vQ6FPHQyICslXejAdmkRgFLy1ESxdez4Ilu3AXecbFnsntDs9b
 NGkmutO2BsAJB7o2kYtQJBD3bZ7UKXRS6/x+j9rU1IHZa2FeN+sH1obKJpeFJtLTKUiTGeaEmrX
 AOL0Krv6v2qve7FGKaJ7xdKYaL5JUhWp0K5CHvvh59OH4cfqVvjw4rRueyb2nb/wb/TbG+KkJJd
 2emW7Fn/Bt9YHpXtEo2hTIivsI841jDVyjzO+GN0rkapJ6isZNvw1Jf7bLepVWUuGoLhohQ+ifq
 i3DNX6DB6pbxqjoa1ZZTq7jCEWlxX6SAq65/RXp4KNb+wL4SJ2VXNr7hTeLvQTxmUSoN3MEOsNb
 NsJd4MnTEQCaYPA==
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

Several queue state fields are not included in the vmstate:
bulk_in_pending_num, pending_answers_start, and pending_answers_end.
Also if current_bulk_in != NULL (ongoing transfer). Migrating while any
of these are non-zero produces inconsistent state on the destination.

Rather than extending the vmstate (which would require a version bump
and migration compat machinery), block migration when the queues are
non-empty. In practice this window is very short since the CMD_SLOT_BUSY
enforcement limits pending_answers to at most one entry.

Convert pre_save to the pre_save_errp form so it can report the error
cleanly. Follow up patches will add migration blocker and new migration
version.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index b05f4a85666d..786d5217a95a 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1381,13 +1381,20 @@ static int ccid_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static int ccid_pre_save(void *opaque)
+static bool ccid_pre_save(void *opaque, Error **errp)
 {
     USBCCIDState *s = opaque;
 
+    if (s->pending_answers_num || s->bulk_in_pending_num ||
+        s->current_bulk_in) {
+        error_setg(errp, "usb-ccid has pending queue state which cannot be "
+                   "migrated safely");
+        return false;
+    }
+
     s->state_vmstate = s->dev.state;
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription bulk_in_vmstate = {
@@ -1430,7 +1437,7 @@ static const VMStateDescription ccid_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ccid_post_load,
-    .pre_save = ccid_pre_save,
+    .pre_save_errp = ccid_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(dev, USBCCIDState, 1, usb_device_vmstate, USBDevice),
         VMSTATE_UINT8(debug, USBCCIDState),

-- 
2.56.0.rc0.29.g47ce80527c56


