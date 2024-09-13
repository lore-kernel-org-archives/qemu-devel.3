Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D834EEE27A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxFZ-0005e5-Jl; Thu, 12 Sep 2024 23:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFR-0005Om-La
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFQ-0008HH-7o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2053f6b8201so15879385ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199127; x=1726803927;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=a3z9NmkwgjQNd6UWeIQJQjF7jKLqgee81pM3xUEpsw9nI6Dzxh28nbZeS244G9fq6g
 bpgkiczwmgl/z8lmt87wD6GA9meVYR0AexYtmOXsZtNc1pMdbhMK6e59Pt06O+shKWli
 IjWsBrgcG2Euz6J1h5tpPn5KJ02X2GLAj7+QVvnPIkQriIg/6PFJATG+i6eTvayS0TeK
 FNwceFe0EmiQoVswudZFRg/aY0XAtZPyl8RbyfRu4LsYpKjw9ouz18Kz7etWBRNA8iAP
 LT0XA/LBMK/Z8p3appBb8knXwI9NAlILED6DIb4XQPNtgDpBz61h42Ej/rA01Esk72pZ
 movg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199127; x=1726803927;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CGZuhv54KbzzZfkN6AoDeKXUOhgbsQVkrQ/COnk478=;
 b=c8fT3ikbfcafN3cmzOGLzCaLyROHa/PiCgVZJCQZ8uHQNcZtId3r7QybeJVqdsG73U
 /hgJmYL8JRKCnkDL6cPsxHGE5UzKoQ8R1xIzXpj75MchY/o0teuKVtx3BiHxgKoO5ci9
 v4QyVjtSXIHy5jgZHFPLscpViob08rcMDQ8njWfBzqUtNkM5mNtLwi879LMVbyI5SMRn
 S6QohLn0doCkR5/UlkBluUmNjxp9TIvSTOXi1i/ox/D+DGE5w7m07KQMv6GFJKKsQY81
 SR4Ay2x8rdxx4WzRVPJotuOHHDqe1qJkUex5he1QEAgLRCnl3FACDAS8DZPwTfeXWt/4
 t5hw==
X-Gm-Message-State: AOJu0Yy59bL9BjclCCpeXD0hiPct+W+j81xYSHAA7KeVFDWmB72A+yhi
 dme4j9gtPjad+iiIoIaPSMv2CrXVYBdA681NacrkY1y0nd4wjLmJNprN5RiBo8g=
X-Google-Smtp-Source: AGHT+IGjrrNA0nL2820/s10UKHPTtjFnzBC05hnsy50HO4doE2IHFw545d5IOroRNUEIadJM0qQHCw==
X-Received: by 2002:a17:902:f910:b0:205:489d:628 with SMTP id
 d9443c01a7336-2076e33c6d8mr58066325ad.16.1726199126824; 
 Thu, 12 Sep 2024 20:45:26 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2076af25485sm20714945ad.47.2024.09.12.20.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:45:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:37 +0900
Subject: [PATCH v16 09/13] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-9-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 4bffe6c97f66..ac8c4013bc88 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -87,6 +87,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.46.0


