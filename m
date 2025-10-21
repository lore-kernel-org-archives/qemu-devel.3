Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52CDCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8IK-0001Ug-JJ; Tue, 21 Oct 2025 05:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8IJ-0001UO-2s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8IH-0003xp-9T
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJHhV44xA2yV6Pwkj+xG4UfO7EkjL4EsvWC4IiZRDKY=;
 b=RdSQAl+ob4jqYub54yfscubGBzpFlxpNbFvRcI77EGFrFAQEFPrMkUbBNRPqIVB3mX70HP
 Cdwf96gV/Du5DTI5UEIuCMXWPNn0BYnNhHKJUBmF+bbY8cU/o4i8SqSEpsex34aZuPK7C8
 Anx0MEYJBf53KIZZRTiznz6jDwEkq5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-YmMuRcaaOJG_zpFk1KfFtw-1; Tue,
 21 Oct 2025 05:04:31 -0400
X-MC-Unique: YmMuRcaaOJG_zpFk1KfFtw-1
X-Mimecast-MFC-AGG-ID: YmMuRcaaOJG_zpFk1KfFtw_1761037470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17AAE1800C32; Tue, 21 Oct 2025 09:04:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E8ED180035A; Tue, 21 Oct 2025 09:04:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 12/43] hw/audio/virtio-snd-pci: remove custom model callback
Date: Tue, 21 Oct 2025 13:02:43 +0400
Message-ID: <20251021090317.425409-13-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virtio-snd can rely on the default code to instantiate the device and
set the audiodev.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/virtio-snd-pci.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index 613538e46f..b78eaff851 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -71,24 +71,10 @@ static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info = {
     .class_init    = virtio_snd_pci_class_init,
 };
 
-/* Create a Virtio Sound PCI device, so '-audio driver,model=virtio' works. */
-static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
-{
-    DeviceState *vdev = NULL;
-    VirtIOSoundPCI *dev = NULL;
-
-    vdev = qdev_new(TYPE_VIRTIO_SND_PCI);
-    assert(vdev);
-    dev = VIRTIO_SND_PCI(vdev);
-    qdev_prop_set_string(DEVICE(&dev->vdev), "audiodev", audiodev);
-    qdev_realize_and_unref(vdev, BUS(bus), &error_fatal);
-    return 0;
-}
-
 static void virtio_snd_pci_register(void)
 {
     virtio_pci_types_register(&virtio_snd_pci_info);
-    audio_register_model_with_cb("virtio", "Virtio Sound", virtio_snd_pci_init);
+    audio_register_model("virtio", "Virtio Sound", 0, TYPE_VIRTIO_SND_PCI);
 }
 
 type_init(virtio_snd_pci_register);
-- 
2.51.0


