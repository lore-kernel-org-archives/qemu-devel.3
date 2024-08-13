Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15468C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl9o-00064s-NW; Tue, 13 Aug 2024 02:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9n-0005zu-FG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9l-0006PG-QO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ff3d5c6e9eso35745235ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531039; x=1724135839;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ctp9i8y5VUp0+JHaTY/1UxY+d2tZ1Ss90F+E/6J1VMQ=;
 b=Wzhz6iZjssghYPiyJ4ZhVXmnVhgP8sY457+y1xeLL/7Tc6MmJoh6VYO9GuLVdSLCei
 2JVSgXt05E9dmZUjIwaNVUz6Q54At1ks/yWxQbetL1PNoqb1w4Suyalq4HtQGmbI8bQ/
 tOqZw7W16UiEPECh8CcnlZ91bwAXYk9l1Go1lb18tb2CR9hXFQcEmIvNbyfzfAHaqrdN
 LtQZryTLCRDVePvOiADaG7WLc9OPa+j3bB2zF6UIa/Kg+KlXo+KB+ipjCXt6AUUol3sW
 atqzsDUbuoqs+47JHb+e7Wj3aRgvSzISQsMjvxiVkfTs52ygMzAVSxfqyhNDdvzR2izR
 TWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531039; x=1724135839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctp9i8y5VUp0+JHaTY/1UxY+d2tZ1Ss90F+E/6J1VMQ=;
 b=NKTOfbLbF5vwRVeEV1fnhILgUDWPIPd9bF6KRa4weXYxPqyv4LAU2QheBJFLdmsFFm
 rjgWryGPByQ5Xhc2Jc2CO30Y230EjufgyR3mJWfTHdHN+j5ZW2PsHdxXyJuMjS5lgvPc
 yXzrf7QiUxSA7oUFF32IdNq8gpDKueQY/TJfvwErnQUOeAL9LuGsX3pHxEZ4Jnj/bNBL
 j67xLurY3BWSnDBAfSCI4g+LA6OH9/QXk5jmJB+5gRFfBvAg8Bk50dLXTlp7sOrgEldM
 z2tU0R6HTP2G2r/NycV9B8JN048XoPXSeWgVtE6nlQ95OPkJZdWyXLMJGR/s+tiDnJ3v
 DnZA==
X-Gm-Message-State: AOJu0YwdavHpGZ66TLsFOaTHsBxWTBj1Lkfv9FIW+hXWcRGk5dcQvOk/
 exRsUvYFDig7mSpUzB4HrF4BmRrkafYIj5GCd8wdELTDdjfZh2IKucoSS7Wyhl4=
X-Google-Smtp-Source: AGHT+IFbOFZrNxeWJ/44GVzv5WgsMdOj+1HULObeS7AXl5nBKwLTlRdpoQAvVQ/0M4wN5Nwgm2bQrg==
X-Received: by 2002:a17:902:ec91:b0:1fd:9c2d:2f1b with SMTP id
 d9443c01a7336-201ca1cb0d8mr25991515ad.52.1723531039371; 
 Mon, 12 Aug 2024 23:37:19 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201cd1a9220sm6574955ad.124.2024.08.12.23.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:01 +0900
Subject: [PATCH for-9.2 v7 2/9] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-2-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 60b1747d60e6..0956fe5eb444 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1437,7 +1437,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);

-- 
2.46.0


