Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBC7C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRNN-0003v1-92; Thu, 16 Jan 2025 10:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMc-0002kN-Ui
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:01:00 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMa-0000HI-ME
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so899862f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039651; x=1737644451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cYzGP6d4KrcAWacK9hFHH1x2EKu15pc5aRijUf74uhE=;
 b=Ac2Ww1De0YGjaLkOp0L9zXwnF7lG4qwaTuxb1kfIIb/CvDu1/vQQCyv0vG062zCL00
 vhqgWs0itcuShnW+TAN/HXi4nWQQ77wJaOd++Bt1OzROgNkSlCGmqAP9/pzawUkww9Mt
 eUbNrAAPTe8scAI/kEdPWgBoN+AxpZ4H5Jo3nA9kmIX+zFOABN4brXrsfCtG22wd3LLp
 JDsSdjMhg/I1NafS+drBz2sxDylzSD9H+P5gQV1ITzhtsWAA65U+FjduJjtT051kGCPx
 qzKHYxSr+3bhcYHpcKyqXxh40/N34yXU9WRYXuozUl1EGKziyZcJPzzd6zGU8yMnfCol
 8Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039651; x=1737644451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYzGP6d4KrcAWacK9hFHH1x2EKu15pc5aRijUf74uhE=;
 b=ZoCrYLg3vJnJrwcXIphbDQm7xmrbLJjHd2vpxqeYLyMNTTeTutxlwGksPmJJJC4vya
 IVAru2aiaqtPYuep1ZhcyPDMQfcyXbEoBrpxmzGqlvwWtdmpEjUmb8ajWW9TsqbPIENj
 02YuCUhiGJoJAm3Z1h7nkaKJKIhTbUolSL8JltQBsod/9FwH14ueDTU4wyCktohnbUCH
 pjubZiFJHrdMGV/n4e6zwAmFNeR6Is3j43fKNniI72PqFw0OyArk1Wq+D6UjrVgjIxT3
 Enodbqn9ak8EUycHI6ZEAJq8BeS5H80+O1UOQEA2Z+3OawJv3FDoOhe5B/2c18RvA4QQ
 Ftdw==
X-Gm-Message-State: AOJu0Ywq+DBZvD+dbAD+a9ACvfIS7f5K+2ZlCFEysGfQFRmP7qJOUM3l
 kNm5sz22vdSsVsm1Z3XPfP/KDRJikRNbpsMfSA/r6zYr3gzGcrd56SaNrh9/pga7P3r3du/DgLq
 UpIQ=
X-Gm-Gg: ASbGnctpet55pAaHde6NikZ3EB7tqBpQdQQ9QIetoI2ibD5ZsHBHh9OS0drxkEKiV1W
 2tArhmh2wZZ76ha9X9B9muBGSlAnvICie6YR7WUF2vGU9vb7pmLjszRr5jBhtAFOxp1i2cDCPNZ
 OcNNsRM+g3a4P9+gI8oQtZlqVrV62JzRkkFFkgp+OTlcugdjIWusZlr0eKAEm2/gwMXWvNSjiOB
 +Krhm3/chQdOf7OaLMJnwRzPjbVyONxmfoi1VmZoKgXr66PWbX0hyeGAiBDGevGtHtgCZD1Kbnv
 ILQ9EhqAsBjEBRhMWAb6HSZFqv4G3Rc=
X-Google-Smtp-Source: AGHT+IFnNouZVfmSrEl1WM7MP75dPQsAxjhyUBBw3x05zPxsrZeRXQxfvSB9lMJe3qHxbexTOplyTw==
X-Received: by 2002:a05:6000:18a6:b0:38b:d8e0:a862 with SMTP id
 ffacd0b85a97d-38bd8e0aa1emr16675777f8f.43.1737039649256; 
 Thu, 16 Jan 2025 07:00:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275622sm69834f8f.69.2025.01.16.07.00.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 13/13] hw/arm/virt: Remove
 VirtMachineClass::no_highmem_ecam field
Date: Thu, 16 Jan 2025 15:59:44 +0100
Message-ID: <20250116145944.38028-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The VirtMachineClass::no_highmem_ecam field was only
used by virt-2.12 machine, which got removed. Remove it
and simplify virt_instance_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b2cc012a402..9a1b0f53d21 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -119,7 +119,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d22b445fe99..8c5ca6b59d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3283,7 +3283,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_compact = !vmc->no_highmem_compact;
     vms->gic_version = VIRT_GIC_VERSION_NOSEL;
 
-    vms->highmem_ecam = !vmc->no_highmem_ecam;
+    vms->highmem_ecam = true;
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-- 
2.47.1


