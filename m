Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A173FE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz6N-0003cG-6T; Sat, 04 Jan 2025 03:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6L-0003bv-GO
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:41 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6J-0006gU-T5
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2164b1f05caso178248725ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977698; x=1736582498;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C4a4ZwwnrOLQXIqjgUnW4cDOfa379c3kqq/nLZmFVbU=;
 b=Tjxvc6VcR5CY1IIqTMQI6fl1yt+iRwwUllS/PMqMEvy48DsEr3rAGg04nrIKW038PH
 +ZrSmGHRaTKqsjWmQQhFXX3vDFhj9WeHSKE2czs7fsBDEff+yenFAn7bkvEiyDGSs186
 zJOZjT+gySSG6OyIoDdWCNl7ZYsZAAAufcr7OWxKdv4cxqfwjLdqyrf7ksWYhKiG+lmK
 Y2qRZwz0XfICwKCG2njUrcAy31osWfvkGJYDmiHuwrQqi1AQ9rb3DGCfFBwOuT0FfEmy
 qZ/+ofaleE5S5lRrZ4wY1E+DiMxj0sZb27BqpuCPEZ0wrmgmkUiF8atb8QKLU50QsKp0
 CkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977698; x=1736582498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4a4ZwwnrOLQXIqjgUnW4cDOfa379c3kqq/nLZmFVbU=;
 b=CNMaQxYndI3p4YECsn7jcBmaPZOXAXC0AGgyEca7DzshQ7YNxZIxnZCBv1/jel83nT
 CLWVzjhsC1F9pYwV7IvOlcJhbGgx87v7uYPpJr8Ll38kCdKOO84V1BVNgbeJdCJpQU5/
 fw1N8wXyRNF2rCGYvMR6fIsSzaFsyvXl2pO+7CK/ImDUOXlB0YYvknkHLEHECaDCm8pT
 EI9j8IdW/MYG5kTk9/uQx6bgaFyTA7cahRyp8SUXhBcBqTeHMBBBH4xNKmaD5mjx2WiQ
 d1U8RJSe34mPXapMB0/e2yDrcnb053K9AZvVO39NQXxCAvdowtx/gacn8Rkh7oTPTF8j
 oJgA==
X-Gm-Message-State: AOJu0YwpqTnsoisQJyXSKMRHRwx0bJRAtyQupg75LWVEu96ToaJLRWEL
 hVtjl0pfzyGdWTyqLBQaHz7RWJfzI1Qm/uZGVMfp1RvRCrfTzW2+1jYCDbZjd2A=
X-Gm-Gg: ASbGncu3oro+dSxSq9clux5zce0Nd8gBuv8ZqnQtNrEJiYGkRCi1DKkPleYfSSyIYJj
 0YOnu2eu8/CvcV3smVZk7VCYd4Tq9zKgFHVhS27X1OFFUPLMJsHiv4PwV1YcUyLKmXPglJ+WzzR
 LGuPa+SMvam3l7HbMNUoYX6PZccWbORfdNhSrFdj9D04KmOgRN9dTsU6RgJ1s4MaDSM20LUJyKi
 cfLIFsNEpjyG/OEsy+HkQ4ZKzqfCcriXRH5wyu5hJZizicQHGZfZ2Dz1IXR
X-Google-Smtp-Source: AGHT+IEfqUdidRKTk5Q6pQg1nqejmWKPyU9JGFXi9ZyeGK6qKQ/b8g6PCNBZ0E/7tbQtV9t2UyRqcQ==
X-Received: by 2002:a17:903:2344:b0:212:996:3536 with SMTP id
 d9443c01a7336-219e6e8c3b8mr702853145ad.10.1735977698666; 
 Sat, 04 Jan 2025 00:01:38 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f68a6sm255365025ad.212.2025.01.04.00.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:00:57 +0900
Subject: [PATCH v8 4/9] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-4-56144cfdc7d9@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 109b2ebcccba..a5b546abe8bb 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;

-- 
2.47.1


