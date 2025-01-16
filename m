Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDFC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLlh-0000WL-Hh; Thu, 16 Jan 2025 04:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLld-0000MH-Sv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:22 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlc-00017L-1m
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:21 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so1027524a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018138; x=1737622938;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=lNkGHJmKsYJgES6zaU9YruSxjfiqJ8H6remqAPyjvlfMuFrlCoYd6hpHezN/jRxedU
 QPaOAcNeVYlcEObQApIcRdM70wsbCmSbvs2YW/S++5zDDkMrlJjqVMrmlKBgwzq+g6Q8
 jBNZ+oNEtkeVjeyxf1bSpWz6NpuybAWlun38eGPeqVGzxetaj7he+No668nV7UgOQFUc
 Zv1Zg5WP7QHNAr7FgeqDGozyjReo4aJ1Yg8vrNbbVNtpo4K6xvw94bgneSNwMVzpzZiE
 v9oezpfxwdZ55sJXrbzax7/7KM1dJ8D1GvYyeDxwq7RygDYVJwOBrdRYexT6r2awvftn
 6h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018138; x=1737622938;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=P9VJ0SmK3TDneTFFrm28/NYj9a6RUpm6jHf3mzI1Lz5Tam/w0q5X+3MaYwu40oYoUu
 OCbPS2Z0jeKKazWmSWRSnEbtL3jeE2L+KnpKVauFl4szbnklwVHat4jyq0ZVSu9FLj2L
 h54dvKHT6PWfZ4oVB5I1WaB0/GGdWlns36OvqoGOt/tnqAhInYqAXcyyxBMC5ouLUPZ9
 PSw0L/soWk/b271gQ6A0xUJy+xBv0LUvL/n010E4ouYfZ1ONvyBtlyb7wJNEC6a17xqM
 hAttdQPvl2GnxrFEvQaJ4iH7DSjTf6Ueef+KihQ8c9aflnVwu9Q0/ZEk+n6+SWn53DOx
 MhUA==
X-Gm-Message-State: AOJu0YxO4usHgxqvdlxkBzrwFa2JUvfBDxetwM13Id+YRQ4D5IfAk6wT
 fcuXAmj4UiDb5XCxVk35AWaedeLTu+Wnyci87r9joFTqQvDzm3ybxDIa7ciJkNg=
X-Gm-Gg: ASbGncv0p/5HLdQI2pwSiCuYIVye/x6nUwTS3JpWHofieuHe1W8ZQW6Ya9Jnro4h03A
 LE3wWDS8lKWX+hJYTxlBRg8ih6aco3SKVpajHhUGZPNoCyDozzzCGIM2ZkZqXvmLFNvmmiuLOCw
 VKyWbcl3zhyQsWgFDRdPL6BgLJYkBpyoy38PG17rAFL7Svt6bHakeqcF6srRgCrXlMCpcQpz8zf
 kHthn4ayffuaHM0xHpEQzHA+3Ad98BOHg2sU7i8GSp0xtLkmJUMfwpjzbg=
X-Google-Smtp-Source: AGHT+IGulaxjyfV8FzG/ZaJuxqNAQ5c6SJemzeOxbd1SzJZgzlUns518FtHTjsPbJKBa5Fr53bCAVw==
X-Received: by 2002:a17:90b:524d:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2f5490bd071mr45404527a91.28.1737018138434; 
 Thu, 16 Jan 2025 01:02:18 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f72c20abc4sm2788963a91.34.2025.01.16.01.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:02:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:01:00 +0900
Subject: [PATCH v20 09/11] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-9-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index f1993bc553c0..db087bb9330c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -93,6 +93,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.47.1


