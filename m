Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3430E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0z-0003F7-FX; Sat, 02 Nov 2024 09:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0m-00036v-8E; Sat, 02 Nov 2024 09:17:54 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0k-0001zJ-5Q; Sat, 02 Nov 2024 09:17:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso334153366b.2; 
 Sat, 02 Nov 2024 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553467; x=1731158267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ER63OFaSbqJru3HFylC612MYJYy6isDGIUx/mkHzX+E=;
 b=gjw6ILCPtPJLkayXIC8yMhiG7RaPcMp5DD79EccVp5mrv/5er75rWIqs/frS4trcU4
 781tJtCwGjQcBVr4sDsrsOqN4NtSNzpiROMrxRkvJ35tTzGK98hNO4rpiErPC3gX/9E0
 dqxZR8DVECHcJnp64WrVI6zntXPtKu7wkFQXWm1AD6XLMFFSyG6uLvKBLMYdk6C80jsl
 l2tOET1OktNQpMAuO+ixNo23nPUFFI1b6ldGSGpdPqMXMzuSBq0lBKhJuolzWySQdQM/
 n3ai+72oX0C/zrrCasMPa2n49qN2Ygp3Co5aS/x3HZKjy75iQutweIM0b14Ec3vrFca0
 ZbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553467; x=1731158267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER63OFaSbqJru3HFylC612MYJYy6isDGIUx/mkHzX+E=;
 b=LQUEtulvuwL6RAxgHD1qYeq3aUoDHfOZKUFQ/u4DTXQh/NSWEL4ag3XpsqB+3rlAY0
 apxibnfd8mdOVDiNRv8QqYEnTUd5HnbfCMO9Gd7Dg9U92vFaTwvq3CtJ5rwR8TMw0FIH
 CfDPniddH9WxMMbwmFi4/5iAbFikuTo3ks6M4P3LhNDKfP25+kV3bNF7s3+t3OZ0QQJG
 3BkbB4G1ri2RXoD72SBUl1jg1zab7gS2wrkb+1qSbYpmpqlB4v+IUxS0UBpX3z4wQFDM
 EGVTPeOOeRPjAYUumbEsYIljbCe6SQEALJ49AscHOrykVuO6iGQ3Xy1eD2J8LT78HQbp
 X3Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVviFqcbukapbyHSWU8F84ppkMJeMfdNd/p4w93ij7efnq/VtltQB3c+H1tqYWdl1AtZXeXz8u/T7w=@nongnu.org,
 AJvYcCXUUWMYUFBDGOKkdiKpNFuqQ/JNkuDRkIWD7WdY7oKp4xciIErASaEhE9V2VQULu51bnB+DcV2FW35m@nongnu.org
X-Gm-Message-State: AOJu0Yz/TZAGHBi8KM4RNJFnmGxRs/r7jbxNMMKbFYdWhtiXeoG2kSnC
 ZodNAVwl06sbBDlNuyUIYmyLNvSGFCp94yNVWfHiO3Yy7Anmo8hL/K3oLg==
X-Google-Smtp-Source: AGHT+IFH3oFSU6oJ/SmEK/L9bQyBHPh3p++0+orlfBFNKHJLlmGm32gOWC51mBxm3bfeTgUV1J4Cdg==
X-Received: by 2002:a17:906:dc95:b0:a99:f28f:687 with SMTP id
 a640c23a62f3a-a9de61d1a52mr2507519366b.40.1730553466792; 
 Sat, 02 Nov 2024 06:17:46 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 13/26] hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE
 define
Date: Sat,  2 Nov 2024 14:17:02 +0100
Message-ID: <20241102131715.548849-14-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Prefer a macro rather than a string literal when instantiaging device models.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 97e5d47cec..d7ff2ba778 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -475,7 +475,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, &ppce500_iommu_ops, s);
 
-    pci_create_simple(b, 0, "e500-host-bridge");
+    pci_create_simple(b, 0, TYPE_PPC_E500_PCI_BRIDGE);
 
     memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
-- 
2.47.0


