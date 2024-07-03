Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA0C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8jD-0002h1-86; Wed, 03 Jul 2024 18:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j7-0002Tq-Su
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8j4-0001BE-BW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=HLmfV3g+rCYDj+IWEqh/9Gn1oP+VKHi4LoGYkNbwOIW47r16qZWJZXuxFsQ6XWtyQWugc9
 aqc6ALAgiV6EL/SI3YH5d5bWdaFEhzuoMlwQbgfSol9SI7XI5/uvytd6FGZ5DaBe4UE/DF
 MDo8LVjrXh6geHxoU46AZ23IP1g16d4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-96zP0JrcPkurDFmtphKVSw-1; Wed, 03 Jul 2024 18:45:16 -0400
X-MC-Unique: 96zP0JrcPkurDFmtphKVSw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e9345073aso2058484e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046714; x=1720651514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=uSenhd6Q/YMwquno5u2UR2mQIW/ZPvoB0vUpr0iyrliXl7po0GqrgmaAZ495qL9WC1
 IW/KlWI1ZkYhuo7PyFrWyJg6oY7jpLVZfL1YQR19spw4GnnkcO6Xr9t+A2QI0Vv3hUDd
 0N5uWTxiLCp6taNQ6Ds5O6NLWpq9jsPUOA+Rqhx3iaSNh8czquwNjQUkMkYlxNG3E3Cm
 iN5+uOpWxO+uChE+y6woa+wEqb6yyjVwEp1zcJQ/zY2oUxgEnMFBAgal/4VEz1Z6kRA9
 L3XuRXp50tUuO+CqaJDxZg3jCFcGmt9QtUVZEAFPejNxa521fmTaBZgDpqcamgVDQrTR
 YTjg==
X-Gm-Message-State: AOJu0Yytv9Fp4MGu60VnKIGINe5rreQk2FDDm64A6r8BNMZ5YNwnEVIu
 ymAR52LV5AlqW39IgtMUm6cubMSbFroKoGFGxyMLiYswyQ6OAt3f0YJ6baePaYgRRCbo+axMIVg
 EPw1hmIDmQfMNyp179lOQbXGK6RdU/LXWA66bwWtc4OVcXstbcKSTfad06/VhcJuI9jFkW/Wf7M
 y+JvnnLKNUTlmDsaprTanL83IBgjChHw==
X-Received: by 2002:a05:6512:ac6:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-52e8268610dmr9713164e87.40.1720046714062; 
 Wed, 03 Jul 2024 15:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHrvjPWmo5M6Bp+qHr04U+rRanKmzSCIePRqp3sDFPBo4fLdOJq6O/XpBKNb0gvoO83XdZRw==
X-Received: by 2002:a05:6512:ac6:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-52e8268610dmr9713142e87.40.1720046713325; 
 Wed, 03 Jul 2024 15:45:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58cf5bdeda0sm1333015a12.73.2024.07.03.15.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:45:12 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL v3 12/85] virtio-pci: only reset pm state during resetting
Message-ID: <84b58169e40f5c7428db6f0b229e01213068aa21.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
After this change, observe that QEMU may erroneously clear the power status of the device,
or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Message-Id: <20240515073526.17297-2-Jiqian.Chen@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cffc7efcae..7d62e92365 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2306,10 +2306,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            pci_word_test_and_clear_mask(
+                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                PCI_PM_CTRL_STATE_MASK);
+        }
     }
 }
 
-- 
MST


