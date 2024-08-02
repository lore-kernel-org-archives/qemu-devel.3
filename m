Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B47C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7V-000151-4V; Fri, 02 Aug 2024 02:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7T-0000wt-30
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7R-0000va-KG
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7b80afeb099so112230a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581428; x=1723186228;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jdptavMuPUq6FleoJPG4kUJogZ48lw2HQ6y5CWLpBPo=;
 b=KMw/ovx6msiTuF9Jfs6pZ34wt4s3Uc7b1k6ZCtHpiIOtTZ2OBW0z/P86MmLZGLjEWr
 r/X6F6/qMR89vaPfIRT15Q6t4Q8EzDwcGGHXunLq3JrC7Vtod3zxQxXZpEqB9ojD2e4i
 B+9JeMpLWtmlzfsl0hfN/gsh0uwVcJmlrSdaJV9xG6VmCaQYN2c8NPrmQrfsrE4Zg+IT
 XWr4P6p2+5e/AaUfTNLxvsutI9baN2BLMJrdLTDpj+pEAB2lM71Qu5HNFrKD4rnkHVjA
 DzscAWwAT+GSniqHM9VDvCo83KfImKypLE9JgEd5wQr3f0iuWEHeKYucFp+a87SnDpr0
 Rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581428; x=1723186228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdptavMuPUq6FleoJPG4kUJogZ48lw2HQ6y5CWLpBPo=;
 b=NxBhMUfUlbWVmIbfyVKbQEgNS1f3lX9nq81U2csjnM6qInPKf5Xw9YhrTQiqKvXmfK
 nDOC/8kzKR8qAfDlw171OwE7JO1MiH1gPxTMBM7NZw119ZFMGoaHSj9W8t6jXfV17Ro4
 8d0Lo8IC42908DED3EkU3+Oo7ObKYD47Zj3/NLT/S8SLvDM5XmNNRd7Cx1oXkNAZj1R9
 h1rRfKjzLyXCxvL3wAtpRl9kSi9nIta5GVMfJhj9nws5ScYo4AafN9C4zzseYw7BywPj
 8ZnO8FMdq/34BhcCEifLBRMvo3PRVi9k97SO9shCMrroHFjZ9IQqYxx8LUp/lQYunbpM
 Yf2A==
X-Gm-Message-State: AOJu0Yz6KsCU9S5iflktzXr7i+rbUVx4NOy3KSMXEtQffZv0WPR28fCS
 bKAMhpOSIE30Zdok8/8xvYmp1irHm5BGJHcIftPSF8bMYSac6WCIJnbj10l8M4A=
X-Google-Smtp-Source: AGHT+IHwTazeFrpe4MmMRbjQs8vkZe2vjW3S59VADjiRKuC2w5u1vhuDS4fWJ01+pLWG+m61RkX90Q==
X-Received: by 2002:a05:6a20:158a:b0:1c4:8da5:21a4 with SMTP id
 adf61e73a8af0-1c6995edd71mr3661359637.41.1722581428416; 
 Thu, 01 Aug 2024 23:50:28 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff59294e92sm9705605ad.240.2024.08.01.23.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:46 +0900
Subject: [PATCH for-9.2 v6 2/9] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-2-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
2.45.2


