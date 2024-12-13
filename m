Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7CCE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bm-0001nK-E8; Fri, 13 Dec 2024 11:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BV-0001hM-N0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:35 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BS-0006fQ-V4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:32 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa6a3c42400so326860366b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105989; x=1734710789;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2w4i3aj6eKVqpqsdiYKqEe8MFNmhXhqYUKlcsHv298=;
 b=X9FWKWUB8Zm+jtvk+iahKuYIBwSkX/37CVKhD2RQns9eqMyx6CUi5xhe08Kr99mrZF
 FKDrLTXcdc5qjsehpydE9fGoh2MWxp+9y7VCopUOTG5fqKt6v6sTKT3Rr46pUlw/aCH0
 FNZiaykroaKqd8JtVpz2RpgWVGv/9PeMLsi0TR6hBBdooDN7enTiGLQiKEUzFBFJFW6f
 UWwNAjn6ip1GejKY3YJ3Q/E7mTmTba8c/ER99i1uY8BeVma8v8JrIhLfdv2R6wvSD/nI
 EwwP5PRvKUo6fO4w7yAc9v2EMkAD85KpCP9BXnk2skAeUbgmK2CcMHyvW/Y8rLQDwt3J
 gMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105989; x=1734710789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2w4i3aj6eKVqpqsdiYKqEe8MFNmhXhqYUKlcsHv298=;
 b=XCUXjfb6xZeokQGDBzsIAPD5aPDZWnZU1b5hp3xX4p5FAHJepY7hs1EmL3uXVbxBLe
 CgHW1lNDpKdPdQgG3pPfVOgPEe+l+j2R+LqNKFiZTvV8D+rAl3JTEHpq4LX7liEMogbv
 /095inxAmu5OJN3TfJOtltvP02RyRpyef4j2V2aT8Qq/qe8IIgzOercQNP+yHUAvW8H1
 AZdegbSXnLccXgudD1tYmbvmBHHXk8HcVP57s2b+MtgSnJVOwYHk1cRTHvwfCe5NzdES
 5D+XYXS2nO/kaAynNOYLBMC34SupXDhsE7WidG9zdPMBNcYGENuHDexk0jAd+zzHw1T9
 nrqA==
X-Gm-Message-State: AOJu0Yxkc8k3kO1dMVWXL7Dpcm5auP2nLnWxNngdeW7fkl8VRX/mzsq5
 cRs7h5URYqa70V5qmndCmWdOFaeM4+tD1mqiQ9/DDC9QKgftZMXM/Jqmop8hkKRWPa0iLTlsvrx
 cTQ==
X-Gm-Gg: ASbGncu17IcAtUgozd/BXfnWZdlK3i397tOkxc9CCTuC2+ozO+QEZjClGLwxdGF89PO
 Zsui3fhw6qYD2Ljx3negNtR8Wt4yYx+JQbgufi1J42Ex9OexQJTUGwywhkZULlNR0G4KJqOgmZr
 Op5N0pnlqoFuNyBYiub64kvTh/TNyChrFrc50FsS+qBhFl1/cDDDXugh7rx/7YwQYOYrKDYgwpu
 Ut3kM/n49j7YHRd5qyyn24B6oG0a7OJTftL0PQwdFOH8w3ELIvoVqfJfqc1U7b9nazi1OnU1KNH
 y/GrrzkfgjTb96t6MB/1gnP0asj/nw9v
X-Google-Smtp-Source: AGHT+IEn28kXYjHsxKaPpfWIgBim38t5ITEIG5MMFosEpQleX5BVsdl2Y9BI/UB34FWqk10ze7DULw==
X-Received: by 2002:a17:907:d92:b0:aa6:ade8:2d8c with SMTP id
 a640c23a62f3a-aa6c40ba702mr883586066b.5.1734105988956; 
 Fri, 13 Dec 2024 08:06:28 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:28 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 5/6] hw/usb/hcd-xhci-pci: Indentation fix
Date: Fri, 13 Dec 2024 17:06:18 +0100
Message-Id: <20241213160619.66509-6-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62c;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Fixes number of spaces used for indentation on one line.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 6027eed2d26..2ac0fd0bf1a 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -110,7 +110,7 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
     PCIDevice *pci_dev = PCI_DEVICE(s);
     int intr;
 
-   for (intr = 0; intr < s->xhci.numintrs; intr++) {
+    for (intr = 0; intr < s->xhci.numintrs; intr++) {
         if (s->xhci.intr[intr].msix_used) {
             msix_vector_use(pci_dev, intr);
         } else {
-- 
2.39.5 (Apple Git-154)


