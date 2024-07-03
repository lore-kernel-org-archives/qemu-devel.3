Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18882C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nn-0002kl-Hl; Wed, 03 Jul 2024 18:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nf-0002FF-Am
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nd-0007LH-DL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=c7zSluSRuDpWrqfgi2GQhy643W65ujq3kS73qkE5rZYT/EhLXEulmae2M+eo8MaUG8PAho
 H1zxDtFMQ/HfoE45MJvqdf+ho53b62wEZHvmOUAQ8P5/DS55Zi1uq7mBgpInnZeYAViu2W
 b5bXxtYuCrkcOWtMusvwKLC1jpE2KZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-PMnSLp06PZSIy1j1SIF9sw-1; Wed, 03 Jul 2024 18:50:03 -0400
X-MC-Unique: PMnSLp06PZSIy1j1SIF9sw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-366e0a4c965so37448f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047002; x=1720651802;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=MmM7uTND3+QmlHSDAcRwE6iGfxXqV56LAgca8MnrhxahSyYUD9Mu3FfbHEhCwCZEG2
 8jx+WVXl/rYe478MItgHIgMKEpdWcjJX37xTxebr/k12QFJovDYZTDJ9obxsVA3ncKuC
 vc8LinWjFtS8dHrcV2P8CqM/OKG9gRLEGKwEtuk0t9oIYAW7RKYOOEVHnzUYaReq0YcV
 IuFSji6qPqGla+0tq1no9zchMyn6Mwj1/SSCZ/gr17VMO1bIJHQpZwXkoCdbUVWcPsY5
 ZX5tvnKE0k81wlBD0l6wMf+253M+jdJjmWnjYoPcfecr2IiHjl1IwQQO6lsIVY4YHhlb
 Bofg==
X-Gm-Message-State: AOJu0Yzr+fpNG7es4wwDi0mbxLxDqR/5um+JmQgvTlaXBwGNPtd0vIEv
 qM0K0dC7mtF8JxAbRdeCtJroMRiqFYAYMfuUkI+hQ1oR5zqYUv8F5QKgSkaat5VdAaNKam3o+/C
 ArFX0c4+qwYFotGLczLuJlsRizWr5An8yyffxAwH8VWa/QEJuD6aykC/eAqWbjhbSLGllWGUT74
 /RsrRGQVm872R/UPOZ5JHpP9uGq3dd1A==
X-Received: by 2002:adf:e50d:0:b0:367:900c:c0a4 with SMTP id
 ffacd0b85a97d-3679dd15a36mr10220f8f.11.1720047002061; 
 Wed, 03 Jul 2024 15:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYFHxYAFZf4yivxY1Cn3du2bgc6ZWiPpVzv+mVZHEU0YZRJVuCNQ1CVifNwbnyrzrSvJlq5Q==
X-Received: by 2002:adf:e50d:0:b0:367:900c:c0a4 with SMTP id
 ffacd0b85a97d-3679dd15a36mr10205f8f.11.1720047001138; 
 Wed, 03 Jul 2024 15:50:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a648dd3sm4937131f8f.89.2024.07.03.15.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:00 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 qemu-stable@nongnu.org, Xoykie <xoykie@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v3 74/85] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Message-ID: <7aa6492401e95fb296dec7cda81e67d91f6037d7.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
switched using of address_space_read_cached() to virito_lduw_phys_cached()
to access packed descriptor event.

When we used address_space_read_cached(), we needed to call
virtio_tswap16s() to handle the endianess of the field, but
virito_lduw_phys_cached() already handles it internally, so we no longer
need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
but forgot for `flags`).

Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
Cc: jasowang@redhat.com
Cc: qemu-stable@nongnu.org
Reported-by: Xoykie <xoykie@gmail.com>
Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240701075208.19634-1-sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3678ec2f88..583a224163 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
     /* Make sure flags is seen before off_wrap */
     smp_rmb();
     e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
-    virtio_tswap16s(vdev, &e->flags);
 }
 
 static void vring_packed_off_wrap_write(VirtIODevice *vdev,
-- 
MST


