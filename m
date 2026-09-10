Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821EAC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nVu-0002Dq-OC; Thu, 10 Sep 2026 18:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUq-0006E4-Es
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUW-0003hV-Rf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=RFZFWM2IKt4dkFX/B6kIfF0ym7YD/7NWEH/VE2GLpeOleuvq+HPEHmubRNTnDYUXdyg7TD
 F2T0WGy7nP78GN1PHJqJ9nVi2+ZFQrmBAQjgDzm1v84OYOVsE9aoEoSOWw4uGWyL1F1VOo
 NGMIAW9ncP41S2354yrq9CTIl4E4CMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-nmrH8T2WMSCzUTrO3V0j2A-1; Thu, 10 Sep 2026 16:14:25 -0400
X-MC-Unique: nmrH8T2WMSCzUTrO3V0j2A-1
X-Mimecast-MFC-AGG-ID: nmrH8T2WMSCzUTrO3V0j2A_1789071264
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so2211575e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071264; x=1789676064; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=boPC0RElixK4fuLmychIWaPdtfIe6YnHnlrUGZLBIgYZy5Z0yckoN9PazxI7hq/Gsp
 f0KSPxVdDoQT4ten7WLkq4EaqP1LLqmOquuKzilvXfOq+I9tg/HeAbduA5vW7FAa5/ot
 EgLeRtSsUj+2v4PLM1pjJNc5BoWIVcX3NcCK6Tx+AokKkmLOukccQEFa9CmVpknMum2g
 o6wG3URbVqEfbEQjhH+z+It3y8V7Jy6fnk0mpwq4yQwL7VrdczXFmFnzGglFmRUwF1E0
 XANw9ugzbjKVEjNQ1abY4jeEr5A5NeyKlEVKhrw91008ecpY/vxyXQaBCFpC88/pgDVG
 /CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071264; x=1789676064;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zlpYQy/1MbjiL1NkAZwSro3mr5gaZVYlMNIrEIu3Rs4=;
 b=poZNGHuiI2CG1DhFi35ISeMmwhhZSSoyxCHK0E186ZEcsPcaHlALhwl/jsAUPU1FVh
 XxNbFfqtAyfA4jNwkPubOYa4g/6/U022Nfaf1BcgLFoL4XymEZJBO+Z04NvOma57PMK8
 seHlAxnTZODzxSDnCq9G8t9spgTJvpBK4/flP+YXxl0CDKlMQKV0Q1Ju+DUC7Sed56vz
 v94yW0WsNneJNpI8lD1RCANjOlsBf5F4Amp8IDNbOPYy+1uauZKTC5pQ5EROcOjs5s8w
 xSm9yNeugDmHll8baZm8ovrV3TIEoe6FD0enr0uM9fWHkB2oLJFva5N3hWDIQym7yvhh
 IMtw==
X-Gm-Message-State: AFuF++mrPpkU/vo2fZBklioG5gkopButhysD51OEzRjjZZUB4QAuxMnx
 uSZ9sIcE4udgOgGM1Sf6BdFYHVo3hv2SErwKXl+wMV7QEyZkiax8mBqEjI1/z4LOzP7beEHTHjE
 iGJ6C6LPGdlsI9Uq0ell/+gm6sPGkmQ920au8Zzhs/iqXqNziRIL1RTl3CE9aPppq+B+vPaPvVw
 FNogj0q1TFlbUCP1r77XMfhXfmh4DB+BwyOQ==
X-Gm-Gg: AYBFou06ZjQluZZfEHHIlH9DF73U/2P1blRTJ5FD67bUCIQeA6eTO0GCAwpwHIJTfNi
 CI+yeWKflLqeLHUIqvg60n9Q3e/V1MFoMX1bW11n0Wn2+/9dvh7q5ECwbrZ7tauzO09U8jF6pcH
 Jmnp78450M+eVCWJ3TtY2/eUzHCoHkzdWLVtGPpwntB073A0M6ffHxh5se/8nEBHzuaTwxasFTj
 E2z0NZCvrrN1ZHJgO1blmQcWqiiyYpmbtzzeU1ghzp0P9p8ZVzHg5FnlIebE57vdvY59/nhq1En
 a/Ccgq5hRtPh0O89uD8aG9oLbKiGP0OpyauL1aWBdhi8zTTge7H5hUSSP57soMauGRY+BN88nHI
 n0T2uHRxPwI8QKDLdkQFwl10=
X-Received: by 2002:a05:600c:c4a8:b0:49c:fa21:1c7d with SMTP id
 5b1f17b1804b1-49e619d6713mr7109785e9.18.1789071263576; 
 Thu, 10 Sep 2026 13:14:23 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a8:b0:49c:fa21:1c7d with SMTP id
 5b1f17b1804b1-49e619d6713mr7109375e9.18.1789071263053; 
 Thu, 10 Sep 2026 13:14:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm74674895e9.13.2026.09.10.13.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:22 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 69/90] virtio-scsi: set dataplane_started to false upon failure
Message-ID: <752fec0995accf1570d54183c680143bc8a3a415.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit e24a47c5b73e ("virtio-scsi: do not use vring in dataplane") set
dataplane_started to true when virtio_scsi_dataplane_start() fails. This
is likely a typo since dataplane is not functional after failure.

The non-ioeventfd fallback is broken because dataplane_started is true
after virtio_scsi_dataplane_start() failure. As a result, the following
assertion failure occurs when a virtio-scsi device exceeds the open file
descriptor ulimit when setting up notifiers (eventfds):

  $ ulimit -n 104 # exact number can vary based on QEMU version
  $ qemu-system-x86_64 -M q35,accel=kvm -m 1G -cpu host -smp 14 \
         --blockdev file,node-name=drive0,filename=test.img,cache.direct=on,aio=native \
         --blockdev file,node-name=drive1,filename=data01.img,cache.direct=on,aio=native \
         --device virtio-scsi-pci,id=virtio-scsi-pci0 \
         --device scsi-hd,drive=drive0,bus=virtio-scsi-pci0.0 \
         --device virtio-scsi-pci,id=virtio-scsi-pci1 \
         --device scsi-hd,drive=drive1,bus=virtio-scsi-pci1.0
  qemu: virtio-scsi: Failed to set guest notifiers (-24), ensure -accel kvm is set.
  qemu: virtio_bus_start_ioeventfd: failed. Fallback to userspace (slower).
  qemu-system-x86_64: ../hw/scsi/virtio-scsi.c:1017: virtio_scsi_reset: Assertion `!s->dataplane_started' failed.
  Aborted                    (core dumped)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: e24a47c5b73e ("virtio-scsi: do not use vring in dataplane")
Buglink: https://redhat.atlassian.net/browse/RHEL-193328
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260825154854.263819-1-stefanha@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c2..bcb6e44133 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -230,7 +230,7 @@ fail_host_notifiers:
 fail_guest_notifiers:
     s->dataplane_fenced = true;
     s->dataplane_starting = false;
-    s->dataplane_started = true;
+    s->dataplane_started = false;
     return -ENOSYS;
 }
 
-- 
MST


