Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8085CE77197
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz6G-0003am-Vi; Sat, 04 Jan 2025 03:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6F-0003aE-JA
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:35 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz69-0006eq-JD
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso176418715ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977688; x=1736582488;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yuQhf5BHhf8srsz41f2lJ2BM75ujVVRrcc9sOO738qc=;
 b=YokNk015F4degeUc0zm9lx4y9g1lZbKXb7DmknR6QnOrKKpg7nUTKOuy0sZ3nLwxgb
 NmtRrGpQzg5npt5LcD/rMgQzu0O1diyDKnsVZm9YeSSVX8f9lfGFdjkkn07PYhZNb6NM
 rTYYGbI8MokuZ99rjjN4fIbQDfJ9lnTPDeGsYBaruP9zY6g4x+Gq0oqQHEau0GZQtW7C
 7mlUCw3emBHuAxou7CU3B3ARX/dk92di9SHK09pljTX4ILUgEWWoP+4a94j+D8ffqSSl
 s/bSRTYQ6mwknx8JAFJ7RMNJVcnhsnVDJ3odvIJuYmL9O+dqclb5WONnQxA6lXPzqZpW
 XzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977688; x=1736582488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuQhf5BHhf8srsz41f2lJ2BM75ujVVRrcc9sOO738qc=;
 b=f4bWPHhWxDw96sIsCZfCnBOxurQTvfZt1IAYLUfufeiMPq/hb+O6INSoos9OH58D7X
 KkoPoq8HZ1yP5aMb37Z8s7LBmeVUPjEcWiO9vVBme83I+YdIj8tvNaFBO0NfbO1beui/
 kY8yng/c6eNXCpz68rvMixLnW2fQ4/NhlS01Ghvbgiw2IZkWxTuwnUl0MWu/xlUkousg
 b6GS7jSO6Hxv3xLz0ccd/RhZTIZSk0RejQmXzsZMNPeXkWwvA0kYmvUxjRFcu1coNYh2
 EdPeNxF9VknTf8Lo6pJkSfb1PF1RzRCdz/sFqa4wTqdpUjOqt4jhuAwwA+MsYEXJ9bfS
 U0pA==
X-Gm-Message-State: AOJu0Yym3Wifqc/f97BOyyfQ0VBV9o0GK0Hp+27q4RiXPYpuu4HdjIDy
 +CffMs64yZBQVci776JwakEluSAZfuDDy7tBw/2ED/mBFrJkx9YIfGnIIPs3qjA=
X-Gm-Gg: ASbGncsVPA5P1q6yb0GT0Dw+oYNmpvjCNJS8iXgDu59kxNoioDFsM+a48catSh1GUF3
 s5QtrY5PoNHPg8dx3G5tfj+M27htNFSSCiGPZUBilJlB/198Mx8u9G+w036tuxd5hR+61OUSPsx
 D/4Kxmd3CsyWS4MkpCOeUn9W7m+KgeKLbNWPlGp82scUgXYo7M+a5Kh8gSX7bRztdL1Ks4p+26m
 laphUVjH3holW2rdqq5RsgqMcSCzV0nZEzkwCR4XxShFOWvYS93015FfIii
X-Google-Smtp-Source: AGHT+IFNQh9GAy/axAg5p8Rn/JzAAhQKp7IWKta0a52Lq6QMfYGSpm+9dCZctLjTCC8Szz3UUoxRXQ==
X-Received: by 2002:a17:902:c951:b0:216:5e6e:68b4 with SMTP id
 d9443c01a7336-219e6f10987mr764309565ad.46.1735977688151; 
 Sat, 04 Jan 2025 00:01:28 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842b31ef0c0sm21460545a12.28.2025.01.04.00.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:00:55 +0900
Subject: [PATCH v8 2/9] hw/pci: Fix SR-IOV VF number calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-2-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
index c4fa32dc987a..ba53302ecc5f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1510,7 +1510,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
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
2.47.1


