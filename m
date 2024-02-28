Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5A2C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICN-0000my-G2; Wed, 28 Feb 2024 06:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICM-0000mH-4e
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:06 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICK-0007DA-M5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:05 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so4948949a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120043; x=1709724843;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hp/9hxQDBtPEY0OINim6FUiDAX4NmkB4mD/jfDe7uLw=;
 b=tselFCSb7c9lCXfg8ryWxvCSozoqShwu9nESNdD42yWqS18B3Jan26R2uvqJ77oJJS
 fkcVFZCefE27jnC/0s3ksAK1G0rHaMZaNtDFX3il0q5561VUesTqhWmAcAnqzIquzPJT
 KCHoIm/aNyqX74yHi+6dpW8JCK8LOAowZnAsIydpZKtArQGMHMQyYR9mFZCXZAa68tBr
 oFYiP96Zc7ily49qvJFKYQxfQRU5m1xMCyVPhACZ27T5wpKhkaNvyIpQGU5L+IaNkq5F
 xXIkG+CyoAkqshiZ85ovBiQTxjnS7luEtevoDVojalcKwRQERkyeEp0wUH3N9gzltbfd
 dEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120043; x=1709724843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp/9hxQDBtPEY0OINim6FUiDAX4NmkB4mD/jfDe7uLw=;
 b=Cf7zbYAk8jFrD29BUUqgiAKS/sE/FhRicD9kq6+wnjorUXkSnhH7VdoXN7TLX749zn
 iMEypZ0UGWmnmPe9V/WgnSj4hS5+GvjVDQyLZI0HpMB4OfGUhYb/qNbyY4Nql1k/8ybG
 0iB0g4GzR2ct/m5qYhm64ET0QlRCMdcvK7M9Rvn2zO/QD05XqvzMkOUC/HJOwSSzJtVd
 kOoE1aQ1RTWA4NEerHzUSuWEnJBmLRSRTKCr2HlrLaSY3N3NbL2swvdLUJj839RrNXUm
 EqZ+3eyDogFkl7nUwnNeckMYO1JDRqeJO7rksuqZLKANVJ0hCyONc9or8L0aM/vTBMDp
 3dHg==
X-Gm-Message-State: AOJu0YxHoFYXUnuXgs3E/NARyfTH54atYW68jf1OjI/ckPP23sT5pPtj
 VVpVY2wqcpc43GhlIsZ8FlnVTEvd6xj3VlYUB6B3tFCZfltBlDtl2sx9Tb+c8NI=
X-Google-Smtp-Source: AGHT+IHlaoZemaOyDcT+bGEhmIXzIEUc6wR35siPff0S9uv4XJ3Ky0SdskY74qS5ErqKh7CUEyGXNA==
X-Received: by 2002:a05:6a21:920b:b0:1a0:adbc:7a96 with SMTP id
 tl11-20020a056a21920b00b001a0adbc7a96mr5093298pzb.36.1709120043259; 
 Wed, 28 Feb 2024 03:34:03 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 s7-20020a170902a50700b001dcc2951c02sm1862556plq.286.2024.02.28.03.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:18 +0900
Subject: [PATCH v8 07/15] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-7-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..8b1fd2a89ad7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -17,7 +17,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "qapi/error.h"
 #include "trace.h"
 
 static PCIDevice *register_vf(PCIDevice *pf, int devfn,
@@ -204,11 +203,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.43.2


