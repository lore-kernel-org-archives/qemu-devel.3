Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE7410ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Dn-0001ZR-NA; Fri, 27 Mar 2026 07:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CT-0007Ra-Oz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CP-00007V-Hm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so17946355e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610276; x=1775215076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTUziQEVWjn9piO6EeGgVOTutbNf5BnV2m5899YvZ3g=;
 b=cUqSbO9nzmxo2VI53+LCOhe2gKgyOZbQ9yPwnM3zji3xYtwMQzJEuEMow91LFEcso2
 mQg48ncXcosnG0Zh4A43rU4AXd0qpQXvLouHAeqaUrE6fT/d210+Ng0rj48uFlhN97i+
 MOuqGhDPF7YioRkKl+/tXskvfe44Tv78nYjeV0MTCU6IB1tPXLKPUDkovEHEj69GikxO
 LLeM1qKRIDgQJcl59oAbvAZgRbMyGC1srOAUztlk8DKp7q1IHbX619aszGwhQYTEXAOb
 jy64Yv2v7GwlZ4O99PFQ+LJkJmRANxu4iHzsbcpe7z0Z+xdKoBqNpPXslnogeZqc2FqD
 QzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610276; x=1775215076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gTUziQEVWjn9piO6EeGgVOTutbNf5BnV2m5899YvZ3g=;
 b=g/P3xipJD4ByTDQjfmMFMXa/iZEdMpUg1j7dSSEBtUL2SH00aCW4QtEbZris3lu0gQ
 GRO4WHZ4C9n98RPL4+ukST/NsfTO+uU7mrj2KaH9u4YdpPxBmY8cpAJzMvngdN7xfcbL
 r7w7ay7X7j4eaUqyvqWzm8aWxGTtOzb/md6SqHe4THwm6cL7u/wfL+pauN3tJVFQcODy
 AvVEW87m09S0Hl8G8wWLMKfadVZCcWKXJToPa8YC5JLFpYdbQdOjCzAeQlHPQLnoyEMc
 SXapnfmNUfdjVH76C4eeGPxvynpYcMUB+l5F6nVYhaiF/pJmtLbd1GyuWUWjwFovpq48
 AUNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWSzEdz3NfFLjmryk/f2XayasPteOjEzQH3M3/itQ98P1QgDjhlmm0m60RQdboEV903Yw72DKftBXi@nongnu.org
X-Gm-Message-State: AOJu0Yxy9bKwYpv+D+x07UV1nFH2iW3TmzWlR+mLZzEdcv3oI4jiS8wr
 8LpkhsTYV/UohXegPD+l7AApFUQucll/kCNUP1B0qc6EACJ9q+dKzCicWnbyA7tkyR8=
X-Gm-Gg: ATEYQzxvzGCTQVtNIiOmleelCFH0zrui9TFcyptNX57v5mCcnpLteFbDF0Dd0n5fTVI
 Mxa4Sy8FZy3UqffQxRD0NsoKxNKc1AchrVO/08MEIhCrEvBuy7OUIs8XT5Wrf2mssWLZlzzFZvH
 eR9GMWJYfs35YEIq6HMj6W/n7LgfF5YagzOGbkJhc9tneIA3ifel3OAoUfSUzwiV/mNdXj/DdGn
 br1vkwnqmqkrYHYMZCacF4gpDLvmcc9MtSCQywudGVLuvizwhNGKdQmcgpYcyRxPuPnLAdrbpMq
 a4A1eTBYuxp+nO2VyAi/CNdixtevckDQkbYccb09eMEmN6he4I86Ope7KCHihdU0rqVl4PwSDVi
 NkNIctg5Et00BNQV3fNFZEzkF/vMHJ7MBKXO7viWNfE+i6ff8CYzwKGOJAVRAcuBa0dVuxLPRmt
 PPQe31sNDiVxIdbLw0bBOOJF9zHyqlOtaFAkD9t1VsZx2crMA9BwewB6AV97rVpMYkEkXoYkgrk
 Vnj+qqeDge5nJlA2uQgmLYuHLpMKpU=
X-Received: by 2002:a05:6000:2311:b0:43b:4d37:cd37 with SMTP id
 ffacd0b85a97d-43b9e9d9566mr3123740f8f.7.1774610275983; 
 Fri, 27 Mar 2026 04:17:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 57/65] hw/arm/virt: Move MSI controller creation out of
 create_gic()
Date: Fri, 27 Mar 2026 11:16:52 +0000
Message-ID: <20260327111700.795099-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The create_gic() function also creates the MSI controller; however
there isn't really a strong linkage here, and for the GICv5 it will
be more convenient to separate it out.  Move it to a new
create_msi_controller() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91097e25ec..544605244b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -958,11 +958,21 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     }
 
     fdt_add_gic_node(vms);
+}
 
-    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+static void create_msi_controller(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_ITS:
         create_its(vms);
-    } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
         create_v2m(vms);
+        break;
+    case VIRT_MSI_CTRL_NONE:
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2514,6 +2524,7 @@ static void machvirt_init(MachineState *machine)
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, sysmem);
+    create_msi_controller(vms);
 
     virt_post_cpus_gic_realized(vms, sysmem);
 
-- 
2.43.0


