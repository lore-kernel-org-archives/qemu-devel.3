Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20596C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3X-0004Zx-Rg; Fri, 21 Feb 2025 07:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3W-0004ZT-3g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3U-00071T-EY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26tq86svg637C07OX8DshZCvDsSMROWAQUan5uH5kpM=;
 b=iFBHcpU4qhxcYCAyZHw1bUD9TzxxHbvKcDhZHVcuo7S8q6Bme9zlBCW261NUuV5QQfqmqA
 2wTHc7AYATeZzKaOYv8ZHLdVtOSAvNEoHygUrSyhp10eMRpcIQUB6ZJKsX8lUuzh0th/ix
 d0Ger6J9b5TSfJil5zOPlJ9NmP4NM2c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-TEUdQM_FP3aFZ0GvvxykhQ-1; Fri, 21 Feb 2025 07:22:53 -0500
X-MC-Unique: TEUdQM_FP3aFZ0GvvxykhQ-1
X-Mimecast-MFC-AGG-ID: TEUdQM_FP3aFZ0GvvxykhQ_1740140572
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f443b4949so1040449f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140571; x=1740745371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26tq86svg637C07OX8DshZCvDsSMROWAQUan5uH5kpM=;
 b=lAVWwkArapSZFaMuLGOuGFTpBxWd7ysTjn2/5xdDVcjrs3aRTzLPcWFICtaEn7xwH5
 PEGKncplqPKTIOpaMifhaHu1WRtKCKF81lRRqA2zrebIaA3lNsAp+1DG13B7lXwSN247
 kuPyGL09zmVC1Si/jolnRUOHuMFarROjnb2MpD+oLgXgCYhFi/vNdeSz67OyM9mYrKqO
 RAbjknfwRe+g79CQp5n3bbPA2ovIX/9L0h3mO7Jn7JSBpmSwQ3L3ZQHKoaZuC+z8R/H6
 K/mErsNmM74R3HlRNdMk1fwHEBqSNf74FGUHWoQgIzO8Td5/eQuFyWFdjOW4aUcBIf9F
 Tnfw==
X-Gm-Message-State: AOJu0Yymq+Fra+rwbuX6wpWFcsfJftJFhag9FdbnpMQLlzo9zbmXuCCL
 OmnMLx7mYIHI/jMB5NQiqkqL6vivzqJlux6rclkNCm4rKA0QJ+fofMLpQ99Fig3PYtRzdPgLL1D
 bqIgdFA9gtk17NX7M2PAuTmngewP4eIVHOuLyVdaCaLkxfJwDHD9azFw6xoXwqH/E6LEhWvpODD
 Fw1TxjUA8nNWF1472jvLLK0fJ/Q/wMDg==
X-Gm-Gg: ASbGncttrrjZwBOHnyg07+UZViIcudsul+Re6eozLl+z6n67CZufctNLgxuCgvAqTcs
 dCl3PyvxqvcGg56IVbk/xTsHkN+c1X7hHJutBdQSHFKbrBN1urSzYENimEbMPIhqtFW1e0ox2Jh
 oMjKrnsO5/Ykaf/s0C6hN4u0hRRPxJhF1Kax4EFOIbYoXbVIT3U94l39/bn5PVC6WAfU8NCCjxh
 3zRoM9rAQ1CkX9IlipNG9Mq3Hn8vGvh1Ib1Lf7nZ3qYgT+usE5HI0m53pOWpyHneDg0qvfXHkIT
 2MBGpg==
X-Received: by 2002:a05:6000:154b:b0:38f:4c30:7cdd with SMTP id
 ffacd0b85a97d-38f6f09789fmr2233275f8f.37.1740140571472; 
 Fri, 21 Feb 2025 04:22:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHazsbrA/wnDsUbmCsibfGvMWDzQxt4IYp8gV9JJtD7VKvDc2uEmnEZYtqK5JhJs5uksfSEEA==
X-Received: by 2002:a05:6000:154b:b0:38f:4c30:7cdd with SMTP id
 ffacd0b85a97d-38f6f09789fmr2233245f8f.37.1740140571003; 
 Fri, 21 Feb 2025 04:22:51 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02f3e26sm15800895e9.23.2025.02.21.04.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:50 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PULL 06/41] s390x/pci: Allow plugging SR-IOV devices
Message-ID: <d966250e93c1194c0a4c775e08a8e23f2ef66cf8.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The guest cannot use VFs due to the lack of multifunction support but
can use PFs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-4-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 8c5eb69f7d..c396d55c72 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -974,7 +974,14 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Multifunction is not supported due to the lack of CLP. However,
+         * do not check for multifunction capability for SR-IOV devices because
+         * SR-IOV devices automatically add the multifunction capability whether
+         * the user intends to use the functions other than the PF.
+         */
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
+            !pdev->exp.sriov_cap) {
             error_setg(errp, "multifunction not supported in s390");
             return;
         }
-- 
MST


