Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E323C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyKy-0004kj-Fj; Fri, 14 Mar 2025 02:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKL-0004QE-Oc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKC-0005Mn-7f
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223a7065ff8so47702875ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932914; x=1742537714;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oiba08HNvN6peWQHd81BixbQ6a0+XB6ZKumC/k2imsU=;
 b=c61kYKSvArYdhOlpWrcXOq0uHQplBV6asPLx8pVJkZ7kti5F7H3+uFl6/i24wnD9Z3
 rDGUEgyfk5KMYARjhZxrhUwgNJaFB/uhdwVut+zOZngljxtBPfdretqP1Meel+PZuDlr
 T9t2gXjRVb7g8yvHfLbrJPXIXbfdyzFnxoHfK4GH6XMhTr9AxNhZ1RH3fCt5dHAQff4l
 hlbddRSZaXbk/rK/FbBbXXH7zfwLSauPNinmDlY94NCTYVEls7aEyoRjbdEiHWhNCidk
 N4Kyr4W3DQZrFoKrxlxbzhnNOnhJnNCJ5ekAkwzeHIahnt4Sg7OhvifUj5yhQnBsFQ/A
 +BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932914; x=1742537714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oiba08HNvN6peWQHd81BixbQ6a0+XB6ZKumC/k2imsU=;
 b=Jo/srMaxydgy7OxH7Ia/NlJhtPxdcf9BD12GgSpxoOjFHp45nQ8t2TvljCNJXaFCJn
 31mgZcN9JIlxuY78Vlr6dTMNfxrsnOnsqxWch3nrJGPclCMHmUK+/usaZsDdOYF4PelU
 QCZeBM//jQfE546vHWsAUWFpffvJp383A8PJJS37MyRwAY1EbhiVJqgz01KaevyEcSrC
 klctsh1TsHz8W/CcUuPO5oyPvBgcsEWj32F1dpvhFiZJjq5bFwzuC9rEB/bk+5AF8BUP
 c1vlCBb/Lxp0N8Q20ZF3A2rODYV2D4TeWCuoZ5b0VTpBVU2dZ4090+g8dut/kn5lCmVr
 MWBA==
X-Gm-Message-State: AOJu0YywxD8IMeiQcSOzsteRm2JdqNRTPPiTY4XBK34aRS5zDahQiOoD
 yJF8aFM8EAwFApwCovueCc4FrN6lDJY+k2T/ecC0nP8+16v8sydGudnVyaQ6R0o=
X-Gm-Gg: ASbGnctSFB9XMcHXZN8ap3lDMoOULthV/MqFm0gHi5KNjinI5g0wFfVIOjPeEc3L7s4
 +X10f9jOOvttuxe6tGFQbno+99c6AUSRsn8Hqdal4OBYvlVNbsvgGB11zHmJzDPuTueOV8O4/Wd
 /2ZE+/bJA/0XL9ChbGTA9BJ8Oz+jIHoONhoy1sUT28jtOxLsGZBEPthyaos/vVPQpU4r8WXDGE+
 H5vAWgn+kb7nlWyoMEnsFau6daQ99KO8Oacawym8ArFX+KKZY51y+pt4rKfpvSJxWSlVBluj0cd
 Nl81k9c0J3xVdtOJvf/nRU/4fkbOmTUTSZkEmSBdYbPdYH5i
X-Google-Smtp-Source: AGHT+IGQquZn4Qr/FAdATfV9I/VNrS6WX53tcgcoRLZklhYOpSmp5tqUk8U/GIJVk5m3HVyRgvx8Mw==
X-Received: by 2002:a05:6a00:2e20:b0:736:34ff:be8 with SMTP id
 d2e1a72fcca58-73722412c0amr1534358b3a.19.1741932914298; 
 Thu, 13 Mar 2025 23:15:14 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7371167df0esm2408830b3a.93.2025.03.13.23.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:51 +0900
Subject: [PATCH for-10.1 v9 2/9] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-2-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 8460b6105338..2b1c7d487fc1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1594,7 +1594,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
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
2.48.1


