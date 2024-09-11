Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A2EE49B9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOKA-0000Ao-KU; Wed, 11 Sep 2024 10:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJR-00079c-S1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJN-0003NL-9A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DB9NGbeaAbvfzy7mNKPYp8OuO5yV58WQSC8D88JNFOQ=;
 b=eotXh7+4MPPvOD4EKTyVDdEgp3MYOHNK2m+0SbRwXUQ+wueZGqOPfF3aOwYbmC2PsQg5MB
 E2s+TT/SCsH+A4N3+AsB01uSd2U9KjACa051zXub8k9FhkNnbZKMmSPesrLKbup3hhgtoz
 t8qFZpe2tmK4G9a+4AjkY0x/Bzw7Yeg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-UrGgz0SqPeKAk9b-vi0G1A-1; Wed, 11 Sep 2024 09:52:21 -0400
X-MC-Unique: UrGgz0SqPeKAk9b-vi0G1A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8d2e6a6989so251058666b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062738; x=1726667538;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DB9NGbeaAbvfzy7mNKPYp8OuO5yV58WQSC8D88JNFOQ=;
 b=hhD829JtsUSXq5Z2l1GvS/8MAJIFgm0/nuSyp8uK1MpsrxoGE7yhGnOl+kCw5UPeuo
 dU8Gcjnq4Xja1xKm5YaLc8xcvKQbtucGpkY6RD/x0NYfDI8/17G21mEqE9ndqruX5FNA
 fg4aWy894wXgpB1dL6PbfLFLSVJ3tRhMA37FB0RGCQ7iwvtFhaVBjVGCGMZH2ksqgUd8
 qHjyWF7/xK2UKPLV2gJNjQzovRiSRIkZediTlE4Fg582N+GXJD+YOl3Hi+j6c+03jeTU
 hL6a6km7kKN4mP2NfNSPVZQcbNMn5/Jy6JLqsCajb9q6cCxCCA6KkAkPCpF5KQymtx4b
 65ew==
X-Gm-Message-State: AOJu0YxkbOexp//ys0yxBwvU8DbO9SqjqwRZUkYpQvMCIhBQM3nunXX0
 Zyd5Zt+ruTbdb7jENW+9Iaz2OufPV6LX5Dvgeue45C4pZy2UDoxwPsefSZiEp39AKV2+50T2Pci
 eNr1MnOiW1laCY5o0OhCcatwuEClZ7Dw3S0XVnAqR3o3k/uTEbhTNQjVu5n7LFnWwvWi0orPnoa
 ec0O2SpKe9KGki2SEFp+Q5sp79xba2bw==
X-Received: by 2002:a17:907:60ca:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a8ffab771b9mr459881066b.37.1726062738367; 
 Wed, 11 Sep 2024 06:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyRf5v+DYP/9JUh8QHbJzGLb2wgjxLVIaqhTZr6pP7FjtSjnlbJet8bU6YApEOMBOSO/qlgQ==
X-Received: by 2002:a17:907:60ca:b0:a8d:3e29:a82d with SMTP id
 a640c23a62f3a-a8ffab771b9mr459877466b.37.1726062737792; 
 Wed, 11 Sep 2024 06:52:17 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c727e4sm614180366b.126.2024.09.11.06.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:17 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 16/18] hw/audio/virtio-sound: fix heap buffer overflow
Message-ID: <7fc6611cad3e9627b23ce83e550b668abba6c886.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Currently, the guest may write to the device configuration space,
whereas the virtio sound device specification in chapter 5.14.4
clearly states that the fields in the device configuration space
are driver-read-only.

Remove the set_config function from the virtio_snd class.

This also prevents a heap buffer overflow. See QEMU issue #2296.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20240901130112.8242-1-vr_qemu@t-online.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 24 ------------------------
 hw/audio/trace-events |  1 -
 2 files changed, 25 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index d1cf5eb445..69838181dd 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -107,29 +107,6 @@ virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
 
 }
 
-static void
-virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
-{
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    const virtio_snd_config *sndconfig =
-        (const virtio_snd_config *)config;
-
-
-   trace_virtio_snd_set_config(vdev,
-                               s->snd_conf.jacks,
-                               sndconfig->jacks,
-                               s->snd_conf.streams,
-                               sndconfig->streams,
-                               s->snd_conf.chmaps,
-                               sndconfig->chmaps);
-
-    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
-    le32_to_cpus(&s->snd_conf.jacks);
-    le32_to_cpus(&s->snd_conf.streams);
-    le32_to_cpus(&s->snd_conf.chmaps);
-
-}
-
 static void
 virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
 {
@@ -1400,7 +1377,6 @@ static void virtio_snd_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
-    vdc->set_config = virtio_snd_set_config;
     vdc->get_features = get_features;
     vdc->reset = virtio_snd_reset;
     vdc->legacy_features = 0;
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b1870ff224..b8ef572767 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -41,7 +41,6 @@ asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
 
 #virtio-snd.c
 virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
-virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
 virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
 virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
-- 
MST


