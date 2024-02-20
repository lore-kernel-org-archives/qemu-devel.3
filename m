Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F654C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBw-00055g-Qq; Tue, 20 Feb 2024 07:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBJ-0004iC-Ic
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:07 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPB7-0005qm-6P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:04 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so3991911a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431891; x=1709036691;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E/Otirits4N/P66fEjvcSSTgES/jWUIXlIMqWKsiQLI=;
 b=GdafWnyM60VUZLJjHvJTWWCkyPtb/agTZn9/KBZTTT6JM5/XwhTx/pTYhLDUAGHgL0
 WFDwx6lzxidB0uJlj0aPRLcZY76rWzH2G2RMlz6GWgYhoF+L6bcH/2h4HWARbi48AKmc
 Hx+JetEcGnrEcyMxLdXlfeBH2gyK+GS6v2Z+UKZa6vu9b+1XemvAcLECb4HONkoqRt+K
 4YsMT3yVg1lwDen/kc4LwtyhzQaGru9qG2qwbWssTZzuXz/KlsQ8gdRRjlmTJbEWEfUO
 J2LeVPx7l6n27lR4M9qSXpujici6i8YMCRv9OCj05hOtY8iAFipoSvBFPJNlTyM1Stg2
 FFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431891; x=1709036691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/Otirits4N/P66fEjvcSSTgES/jWUIXlIMqWKsiQLI=;
 b=e4YosGLHpucRwj+rVmW29L8EPmE7AdMrHmFlqxAhoDMqmSfysRSD2jUOiH/BaWtyRf
 qkLwzAaY35DRh1nOoAQpKu+t1ITzD5QiQcs5BGWbxu3w4RjXayroZGNugsmA6Y+fOKLT
 veK0MD14A/rPZBdambIEDiraCDntswT8F1XXgT/DE0Nm7hARMsYgq2+dTWrwKzM4QJpA
 DcRZhgHn4GI8fwN6dt74O0520Qf2Tm7TfRqpjiPFvY9yVNpYt9B4QAdkTeRKBv0uF9nY
 sma8Vs4xkck6oB381OL3zGvQSszqdP8whget6adUsm5AOSYH0R6XRlaCgkztGF/M7Pug
 1ZBA==
X-Gm-Message-State: AOJu0Yw2gTFUqXDHW/JTR+U3A5ROzBETV8M4nLmyrW5bg1BzI+mdVATw
 tnS/DU9kfDf5pZTq2kirzI8k2NOTpQkLjxj7b/973LjLINxl6ZmQTuCd461UO6I=
X-Google-Smtp-Source: AGHT+IHaKSjeKuE61R6DRpvPmK9GfuEv4lA0oGIBCEJStj0KvTNNLUHe1QAjECOstHB89AgjUeYe5Q==
X-Received: by 2002:a17:90a:5ae6:b0:299:879a:7da2 with SMTP id
 n93-20020a17090a5ae600b00299879a7da2mr5107821pji.11.1708431891112; 
 Tue, 20 Feb 2024 04:24:51 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 h11-20020a63530b000000b005dc3fc53f19sm6391874pgb.7.2024.02.20.04.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:24:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:37 +0900
Subject: [PATCH v6 02/15] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-2-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26327
Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d801..da209b7f47fd 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
 

-- 
2.43.1


