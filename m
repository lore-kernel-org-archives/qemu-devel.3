Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B7AD58D4B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZjX-0002Ec-H8; Mon, 25 Nov 2024 09:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjU-00027K-QR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:32 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZjR-0006ZO-UC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:06:32 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so5025846e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543586; x=1733148386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc3WE7woH120Qpt/FsE+B5ZgZ3+8Guj7ZUtw6nH9Jhk=;
 b=A3hutD5V+CngEP3bawOcxYK/dWVwJqblTv+wuMLIPzoNkw+AzaInidV/x+IYN2EP4Q
 e/3dVTGYYXjRp4XpURmdUVNXJDy58JVTZASvQenttXlcPEl+kokCfJ5TyehHAg9IzA47
 asnJFNxu+sM0OVNEEeXZPlrvC11pD5zoHYUk8GUmBIawyBeuh6wfYyznLEBpSJcr9HW7
 a6KOPZ4QHjcTyWoKjlWIrTD1/TWf/8K4bvTpY71oBIxPbG1g78Y29zLIAbic4tQ5DK3Q
 bq3H/noLXoFPpixVDt4aNDGgOg2jy+p7RhIASZiIbz/vA8lwBAdrkf2mBFL/It908url
 W38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543586; x=1733148386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc3WE7woH120Qpt/FsE+B5ZgZ3+8Guj7ZUtw6nH9Jhk=;
 b=popmgo1A/8Cgl0/FOzvy7cQMcyK2qYhO15iRtnhlQv/vj+FkaQQVbYi1wbbKQzwMNl
 UnR9mX4aPPRL0cw3RMAmu9NdiDGJV8y36zIPzecaClS7eLQh34schMHx+XWwsL9Cq4jE
 oN4upzqYG6zyCN39cbFUoUNvjHq4m/NX6R3i02WZcJOax5sWHLO0seZX9YqNCWLfMgpD
 eKeIwRUQZ8h3a4k9/tsF1mNJND9H1MpaNPCcasMOynKr05JYgXwKrP7yGp2h3WSpzjqt
 mBTZIXQpotxBZt06Jt0WyADD+M3VpQt79UXAJwuFP/I2fqunX9PtUDIYVdxkHQx13m6H
 NHDA==
X-Gm-Message-State: AOJu0Yz/0tGJP0IHAb51Vg+cQJw66a7Q9fqBdO7m7LxIx8xmjyiQ9doU
 EHpK0XXgX2DKp1v/yoIydKLKOATthKjzuQarJD5MHFBbsbCYV43pTPNBBULxXjPjUZP9JP5Xz/0
 i
X-Gm-Gg: ASbGncsHV2MSlqPw4ELuDQ0F1zYT6FDT9MtT8yuab591Q/9L0O6UPfGq2gGXhiK1IFE
 OTbCJZ0B+zVLFc4nLKCQNhWBLyvLHo2t+hDkWHvZlC8I9FXFerbVbT2IOChHGv3Y6lm+2qS5VgE
 X8SVUjIeVnPhhWCJity+Leuyxtl/Q7cyXlMb7S/8ZywFoo8HC/OThehWNN2qgJv1APF/tRSSGMi
 8VwZXpy1RGdgqwdvQ9BpQLHtp6b+RBalarlh1E13p3ejpFhgtt35/JaiIZ66NP0hGTUXKPh
X-Google-Smtp-Source: AGHT+IF3Eb0kEpZLk8hYJftdJr2UNCk4U2dyWjYpUD/jYEo2tx3BdPGvwkdZgW4HDNn0yn6uHmA/QA==
X-Received: by 2002:a05:6512:10ce:b0:53d:df50:5a1b with SMTP id
 2adb3069b0e04-53ddf505b00mr2688365e87.7.1732543585672; 
 Mon, 25 Nov 2024 06:06:25 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde8fcdfsm128353385e9.32.2024.11.25.06.06.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:06:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 2/8] hw/ppc/spapr_pci: Set PCI_BUS_IO_ADDR0_ALLOWED
 flag in host bridge
Date: Mon, 25 Nov 2024 15:05:29 +0100
Message-ID: <20241125140535.4526-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
References: <20241125140535.4526-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

See commit e402463073 ("pci: allow 0 address for PCI IO/MEM
regions"), all sPAPR machines set this flag.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c     | 1 -
 hw/ppc/spapr_pci.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..8af56bd68a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4600,7 +4600,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
-    mc->pci_allow_0_address = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7e24084673..16f3a18d2e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1888,6 +1888,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
                                 TYPE_PCI_BUS);
 
+    bus->flags |= PCI_BUS_IO_ADDR0_ALLOWED;
     /*
      * Despite resembling a vanilla PCI bus in most ways, the PAPR
      * para-virtualized PCI bus *does* permit PCI-E extended config
-- 
2.45.2


