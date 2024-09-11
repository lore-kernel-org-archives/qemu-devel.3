Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E20EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOkP-0000Jr-78; Wed, 11 Sep 2024 10:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhl-0007AC-09
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhe-0007Dm-T6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBqbG6UDFb2lXZqZscxyCV5To5/Zi8zm0XTznNZpuMA=;
 b=LZzR9+bLH/4pv3pqpi4CWl6IVdM5IGDOlldeBtnU7pekrvt8GhI3Mkrh2Q/vtCfUT1vt4F
 MyA+xjmRvT9020Q8m7SgCbMbvoAzHrEadMQyXdEwd7IbgMYa+81p8klYX3pHCV5ZxCDSEA
 4NFsILYEly/wMeEpJ8yMe30dQPGF29s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-InaZLajGMWCDvGbR7dM2kA-1; Wed, 11 Sep 2024 09:51:43 -0400
X-MC-Unique: InaZLajGMWCDvGbR7dM2kA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c3ea11cabcso3033020a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062702; x=1726667502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBqbG6UDFb2lXZqZscxyCV5To5/Zi8zm0XTznNZpuMA=;
 b=rL0E+1+KF94czu8X4phH5Pu3x3M2x1cLuCbS3rITki8ujKk+ekMXqXlVaXIfJs1cNs
 fqI3oUDWH+VptdLqA9ILCaF7h568aLOpdXoGzrDoTbZjZhx6QKSb5ZE0/aUwAZ/0FZ/+
 51Vv7wgZKJJv7+Ao0j4FzpJXp8aXJla1+yhR2x8KUVt7PGpwmZMzlP6HBnxbfYyatR65
 n6V2kQyOHdKL/m8KtuS2D6+ltzDwmwW8914LY10DLjRKcURFCSmZZGfpvHUjaiNVcGAm
 GwLHJ2qpmaKvfsfinZMPX0rFAUVZxIzkWkBn5fYG5pS42PNbVjMGgyR7wP7lKEkhsTR5
 DfKw==
X-Gm-Message-State: AOJu0YzX9gWocVnBxDaN50H+UiPmeQCY5eMAU5bFn+G4j5UEj6UCjZka
 BpH6NXft3pXDUpjkVx4udUS8LREQphyYF/e4A8HfzA+CHT5ZHEStmPjfxaQuG+C3odZTaugXLbU
 BlBxZFI0LmRAUYTVCiMUUDvPJjzxOLwMf3ydGAI2nCqMSU4lA3aChmyOjrUfh6Xn8lx/iWRnHhe
 6NEwILM6FF8yLlxz5ZE+X4lzQkG6bb8g==
X-Received: by 2002:a05:6402:13cc:b0:5c2:68e9:8cf with SMTP id
 4fb4d7f45d1cf-5c3dc7baefemr15736950a12.24.1726062702262; 
 Wed, 11 Sep 2024 06:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrVtn1ykVlfRoVI4AyHGxcVezidGX8RW5X7BjjPMETGEVnKYajuEHMepFWgmtWmq8iKQ2t9g==
X-Received: by 2002:a05:6402:13cc:b0:5c2:68e9:8cf with SMTP id
 4fb4d7f45d1cf-5c3dc7baefemr15736913a12.24.1726062701706; 
 Wed, 11 Sep 2024 06:51:41 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467desm5376296a12.40.2024.09.11.06.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:41 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Aswin Unnikrishnan <aswin.u.unnikrishnan@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/18] pci: don't skip function 0 occupancy verification for
 devfn auto assign
Message-ID: <e228d62b4af29bca698ec57efdceb46f392f5444.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Dongli Zhang <dongli.zhang@oracle.com>

When the devfn is already assigned in the command line, the
do_pci_register_device() may verify if the function 0 is already occupied.

However, when devfn < 0, the verification is skipped because it is part of
the last "else if".

For instance, suppose there is already a device at addr=00.00 of a port.

-device pcie-root-port,bus=pcie.0,chassis=115,id=port01,addr=0e.00 \
-device virtio-net-pci,bus=port01,id=vnet01,addr=00.00 \

When 'addr' is specified for the 2nd device, the hotplug is denied.

(qemu) device_add virtio-net-pci,bus=port01,id=vnet02,addr=01.00
Error: PCI: slot 0 function 0 already occupied by virtio-net-pci, new func virtio-net-pci cannot be exposed to guest.

When 'addr' is automatically assigned, the hotplug is not denied. This is
because the verification is skipped.

(qemu) device_add virtio-net-pci,bus=port01,id=vnet02
warning: PCI: slot 1 is not valid for virtio-net-pci, parent device only allows plugging into slot 0.

Fix the issue by moving the verification into an independent 'if'
statement.

Fixes: 3f1e1478db2d ("enable multi-function hot-add")
Reported-by: Aswin Unnikrishnan <aswin.u.unnikrishnan@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Message-Id: <20240708041056.54504-1-dongli.zhang@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d2caf3ee8b..87da35ca9b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1181,14 +1181,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } /*
-       * Populating function 0 triggers a scan from the guest that
-       * exposes other non-zero functions. Hence we need to ensure that
-       * function 0 wasn't added yet.
-       */
-    else if (dev->hotplugged &&
-             !pci_is_vf(pci_dev) &&
-             pci_get_function_0(pci_dev)) {
+    }
+
+    /*
+     * Populating function 0 triggers a scan from the guest that
+     * exposes other non-zero functions. Hence we need to ensure that
+     * function 0 wasn't added yet.
+     */
+    if (dev->hotplugged && !pci_is_vf(pci_dev) &&
+        pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
MST


