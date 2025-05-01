Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44E8C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb8k-0005dI-6f; Thu, 01 May 2025 17:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb83-00041f-9l
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:35 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb80-0006rO-Fg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:34 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so164499739f.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133650; x=1746738450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzLE2lKYGYuJ3IoUvDO5W4ZXh+AwpN8VPQtHB7fCw5w=;
 b=LjPtNiwUTXlEwqq5gFaPJ+bGimccjIWzgjGAQcbZ5O1kItHlcGp161yX/ic4BJlxDJ
 9s7TuGUzNq1kSsGDJHMuoyF4ay4wsDTqOvmggxouVQG+Ytelz9ZFZFY/Og+4YjIwPt6S
 QCK+geQiWn/IeN2OGVLfi+WbYNJ1FiSFmMQn/+FCj5+GRyi0tqjJ9Hyt6zgiDmXoK8Z9
 jCrt6U7K0duJslxLo7HYhs/uOADkOLsrmQmRU5sYiwR9w7D9cc9LdPtCEYqVgE0dM5TB
 m/EcPigztFqH16CWLCL6jm/vKAF61FrM4usXfYm9Tyfu/KnmRRT90zR6C1+zQhI3SwZl
 nATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133650; x=1746738450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzLE2lKYGYuJ3IoUvDO5W4ZXh+AwpN8VPQtHB7fCw5w=;
 b=P6ka7alY4YWfSAvP9XXhfUskYHYaRt6SywHlu1mqs2FnkdjGAfpztADlqUMmJ6kBSF
 A97CPKKFwqWgoG2iZVN+IIIBmHy0MyuVLWMwoioWVhBf6GyACMiawzKqFNydpiOjjcJh
 0cqxx2escVoqoKCd/r1Lv7aBW3QXpkzNMVMgjmAZomF8M2kQT5SmU8dFnw53nN40uIgp
 u88YgNNeH46M1eRLYwXgHmu1zJwR6Su+DOK83CC2r+2EIGtBA+D4yl9FZEdkjwuV1Kt7
 gYH+XU2PiG23cJZNQef/AKj+6+l5RZifPG0j28Hl78dQwkLvd7pww157j1utML/23bov
 tbtg==
X-Gm-Message-State: AOJu0YxA2MeU/6Tskjaztge0jDHrqo8JqMk1sANPNsulpvPwhac544Ut
 EsxRcFmWIzm7av2vUGzU5AYzEIC4+3Z4JU3z9oGjaF0OAHVpbxWC+2Ul9ZUHKu36h9ldUlm6fe2
 E
X-Gm-Gg: ASbGnctBN3j8aZ4yxmFJoSboyDLVEPKphfOz7+xUuunrHQI4ykazsYMaI3eRFdavzVE
 wVpWW6hs7xDt6eBSablz0IolVF4InCMS9lgLfR4uAj0s4UH5FJVr+N4uZaIU7+H8CuqQNw4qsr9
 jzZtqRxlCnVM1dOeo3VI/rNkYqgPupGwYP1ADEq0MgUeWJCAAj8dr+UJOz4QJZYuS6CDk6uVlQO
 rk/PXPBUw+e2gHx8Cn79BAYcxUbuDzv+OevzGQOPBdkktOa+ehKecr7OLNrhOqGbFnWmSgxIrxD
 te4btijoCV2pHnAmLxNGTo7/Meadruuh4ouqN5oPe4kERVd1I769dvEi0A1EvXzMOQxXxKfrb+a
 5XWeEfQ103+8qfjk=
X-Google-Smtp-Source: AGHT+IEnxBq1ThHL+mZWJMXZMQb0WMT3kYAky685C7sB7D2ferkDcLHO5nZpr0r6mThfuRqkUbLWpw==
X-Received: by 2002:a05:6e02:87:b0:3d9:5d50:e3b1 with SMTP id
 e9e14a558f8ab-3d97c295980mr6542775ab.18.1746133650032; 
 Thu, 01 May 2025 14:07:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a915f23sm49076173.39.2025.05.01.14.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:07:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 17/18] hw/pci-bridge/gen_pcie_rp: Remove
 GenPCIERootPort::migrate_msix field
Date: Thu,  1 May 2025 23:04:55 +0200
Message-ID: <20250501210456.89071-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The GenPCIERootPort::migrate_msix boolean was only set in
the hw_compat_2_9[] array, via the 'x-migrate-msix=false'
property. We removed all machines using that array, lets
remove that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-bridge/gen_pcie_root_port.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf..831d21225e9 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -35,8 +35,6 @@ struct GenPCIERootPort {
     PCIESlot parent_obj;
     /*< public >*/
 
-    bool migrate_msix;
-
     /* additional resources to reserve */
     PCIResReserve res_reserve;
 };
@@ -66,13 +64,6 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
     msix_uninit_exclusive_bar(d);
 }
 
-static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
-{
-    GenPCIERootPort *rp = opaque;
-
-    return rp->migrate_msix;
-}
-
 static void gen_rp_realize(DeviceState *dev, Error **errp)
 {
     PCIDevice *d = PCI_DEVICE(dev);
@@ -121,16 +112,13 @@ static const VMStateDescription vmstate_rp_dev = {
         VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
         VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
                        PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
-        VMSTATE_MSIX_TEST(parent_obj.parent_obj.parent_obj.parent_obj,
-                          GenPCIERootPort,
-                          gen_rp_test_migrate_msix),
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,
+                     GenPCIERootPort),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const Property gen_rp_props[] = {
-    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort,
-                     migrate_msix, true),
     DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
                        res_reserve.bus, -1),
     DEFINE_PROP_SIZE("io-reserve", GenPCIERootPort,
-- 
2.47.1


