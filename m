Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F5EE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyyj-0002HH-6P; Sat, 04 Jan 2025 02:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyP-0001oX-Gi
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:30 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyN-00035j-DY
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso176370705ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977198; x=1736581998;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=oqNEkIlkDqe9xJZLsZZMk2xeD310d4Dv+6+YPhN8a/2QDNwx6lPQ+HaUkU6it+A63W
 WBDwcbWS5X0q1M8hCCQIUbH933Kn8SgLHHWgzrb7zcU92ITtDZ4aZoycwkajYhZyK+6v
 pteDagFgJ7DiRStscVgj7H7h94OB5D7gowgEtKBBJE/d0I8MtR4ZxTaSk8T7qEBnxwFz
 IShLDuwU8xLqofEfCqGkKOWH/EiJmMv2wYYhhrUU8otKwbtfZTZbcsQiHq0ojtpfjIGr
 OUDb5tXW52ElL8b1LyeXETb/S7geSi1ZTd8tfgqRD9SZ/CTAoocZBY33A2i+IIZ0zRLa
 H3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977198; x=1736581998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hv2QfKl+6DpBVBsf1lBiBYw2dBxJGAO5vrLmLAhJfjM=;
 b=L+wvPValKQi+4USdU590zPmnIYqEH1LF8DhhxI80PshH4aGPHhLCkE2SX6TIjKk8bn
 f82KlxArFpfMOHpsJkL9MqSy+YiWDeCKANbR5EZciHXyxoue0iKjVp8JvhxwjlUTieft
 z/7lSsZpMof4OHepl+C6nFmY0fKVFzvpGel+Mm08HmjH/InaqAdeQTVs/D0K/IPmSjGm
 uEfp7Wl8mZh8wu70jqX8DWt+n7TkLrytFcdfRM+ZVfQ7YMaNyb/liIoWtEV493RzOyPI
 /x5bU9Ur66+WUTOlvrgbzoreLs4ViDjVIM+yUOWShrBTKe1aH5RVH73b2UN2dSj+ReHz
 sNiA==
X-Gm-Message-State: AOJu0Yy//7YDFTZtNMNFL3UdZyLkY5ZhnLmZBQluHPn+tHVhQtcxTz1Y
 RQDoClrVYj625JKufGi81rn7X6mtveEVZxJ8K6p4O9eNak5lmAlm6G5gnwi+qKU=
X-Gm-Gg: ASbGnctyOXXDWvkFG7mTi3yCQIFfe7VIH4DvLIODaXanyea1RqGDaOOFuDY/Qc/MqE0
 SFq35Dw6BlX3znSWxXR++1SLft5uECKy1jP8t2nw00omxtvsuFoVdJ6XJZYiLjkL8l8YK9ao2GQ
 Hebiwn4HgDQ3VFwrrdETn88oukZxdVS9WbAps/DpiFc0NsIV9hZh9B22j4GWwdq9g8cp0EB7q8u
 Cd+7RhNWJxAHmeXj8a/mxjsz/Y4FAJXK2uQczM5XudGV+FCxTUHF/1c0Dco
X-Google-Smtp-Source: AGHT+IHOPDnneLjYCpwDBiPJLUVuIi4azUvarxq9rxPGcaV6XcgH7kwXlXbVy8QtGKA0djL7yI79Pg==
X-Received: by 2002:a17:903:2345:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-219e6e9dee3mr768037195ad.22.1735977198221; 
 Fri, 03 Jan 2025 23:53:18 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f6156sm247884315ad.209.2025.01.03.23.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:27 +0900
Subject: [PATCH v18 07/14] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-7-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
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
2.47.1


