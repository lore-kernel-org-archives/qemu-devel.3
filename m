Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45BC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh9B-0006BB-12; Fri, 17 Jul 2026 07:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh99-00066B-Uy
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh98-0003Tx-K5
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAo6F/fuioQQPfDOiSnNumwlbG2FzGHqSpPCDaSqmRM=;
 b=T0GTAlthUQLBB9oRKJJ1ENZB3QEN6wI3KKtza0hk86+UhLRAYFnmgAicDlPYnmmyO0+LDg
 QKRYPo10QkDLWoam6NZrqPLrH7U0lxTz6/mmHT00suu31GZ9l4uLOvnJ+sgSCpCoP0A6X+
 zaUUNt//zDnpoZ+kDi69RtgQzxNvIHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-aT3Qfgv9OKGx6lE6QKZDzg-1; Fri,
 17 Jul 2026 07:54:24 -0400
X-MC-Unique: aT3Qfgv9OKGx6lE6QKZDzg-1
X-Mimecast-MFC-AGG-ID: aT3Qfgv9OKGx6lE6QKZDzg_1784289263
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D5841955EA8
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44E2A30040BF
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:54 +0400
Subject: [GIT PULL 15/15] hw/display/virtio-gpu: Check
 pixman_image_create_bits() results
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-15-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=enz7Zo2FBPkgzgFl5nDi/U/MFOUp3ORjwYijtlJHEe8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheaHN9zxTFKDiLpHvXoa/J60wNcYlO2SJOTE
 mUFoubCHOKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5euID/9cgM2R5/mgNYYvQit6uL1xiLpiwUe2pOs3CwLP2afkuRTTbPyHgamcoeij7NH+io77bE/
 KNV1NQt7h3vc7/Dv9auQOXBz7OkHjsDbUwfjUFcCcNKJwzldemqhLq7CvztoEiXVCUB+bQA44/N
 kGK8vwcs2SPLhGfjtRDYSMYPXk9ZWUXgppIQhwu8vrxOU/fyqmKyRaCnVOL1GnSghmtFdl76vam
 mZS9ktRNsgSD2h3NLgspJn9Qowm6FI8Gevw5OTFxRTniEvvpjbEcvkVlu/tsDycIqekzRcCcm8w
 7mSgHxmGsVHibtw2cCqIfsmuw/5wVhuZjt8dDzRY/lkvtL9Qje+IfA5JSGEfgGzamR8DJdbGcuW
 LEhlg8ndF/WSeXte27soPmJBaPlKOlPzbpB0ltkKDLAu35pxZ7XmVcB9cMgJ0Fd11Bwb9CqIy9g
 QHK+Qklr2qOjYj02UHU551Qm8BwFk9jv5iO4GlmHv/oaVIaa5W50Q4mvjo5NUPNKBaRwBmSmtcu
 Grrw0LvmOTRsqb97+natspBzW2YT4NhdlMwPnKxqsUuuCqcRl7RqjHgGS1OiHPiZnku9hhW08Io
 2Z4M6LElpmX4buIzEh9CFcF4Dzdr1KZn6U1fT+PygxxdDAqT97HIexVT0DedW+87vmivNHIp+SQ
 cKDCrt0g+slRQXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

pixman_image_create_bits() returns NULL for allocation failures and
unaligned strides, which may be supplied by the guest with
VIRTIO_GPU_CMD_SET_SCANOUT_BLOB, and virtio_gpu_do_set_scanout()
subsequently dereferences it.

Fixes: fa06e5cb7b10 ("virtio-gpu: fix scanout rectangles")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260717-pixman-v1-1-89ea33b50b75@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3090edf89a8..718ba303929 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -690,6 +690,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         void *ptr = data + fb->offset;
         rect = pixman_image_create_bits(fb->format, r->width, r->height,
                                         ptr, fb->stride);
+        if (!rect) {
+            *error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return false;
+        }
 
         if (res->image) {
             pixman_image_ref(res->image);

-- 
2.55.0


