Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4138FC61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIbQ-0001sB-4q; Wed, 26 Aug 2026 14:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIbP-0001jM-4g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIbL-0002Z8-1O
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:58 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1c8d4a959so740797a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769834; x=1788374634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MAgTvhPJuUZv8l3S0IaG46RWM0hrZ4KFv/YgJfLhx0k=;
 b=PHyEWXnTHY/UmOr13InFzmO4sun6gwFjjrr3JoHA4Jp8O1cGvkqiCjfqYlZtqcSjng
 DlLjWn2Tac04Yaf2QkYNG/1iwB/nCFfZQOzMXJGLIvtRmz44Z2l3ZVlX1PUqxRdTnP1o
 SRiebGRMYdkpIcuiyfO5AmJdCefE5ABiftaCUO4tBZIg+ONf++m6U9Jwz8eXJar4CzsZ
 PdtyczIRrMsJin7sJY6S5DWwy+cLSHeaHeR4Ks+5dts7TooWeyeU1nq0gOk8kmLYSMYw
 pL2FP1BVzNJwPIxezYU6XlxSN4K/PBaCFa4Eqe9cBbWkcJ9VDK0LbqWP168WYBR7o7Vq
 pnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769834; x=1788374634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MAgTvhPJuUZv8l3S0IaG46RWM0hrZ4KFv/YgJfLhx0k=;
 b=ZOUgJZrBdIcqKWuIQ/BYnokaixx8kYPQAdZTiWKrySXDkSuQcCb0C7q7B4uGmVICP4
 IXr4a+uWqRxb+U8T1nTyWWbdHtLQiSRUFeYWGnS8Ux9MYrZvizA4WaJ6UZGM17BvqiB6
 5t0Eo6kokW+OAKidsrzF1VkEm3rFRr2kSZr4YTqgfdWR49VaFbZH9eYijQAw6Dh8+hRF
 F04ovaNSMdGowgIphvbs+93e6T3aNO1Ea6r2EN7Tx7foWWtZWXnxWvtD5uzU+Z3x76Vd
 2FkhTxetlT1vkR9Dq3ZXs6f4dxL2zw79Qyyc6typ1x9Ps4EqEGCBupaad2niVz1k6Ehz
 Xa8g==
X-Gm-Message-State: AFuF++njUUEldjDc/Mm5jYsNwGGXp+26BthAOtp9QJZJgpGtDb1RZJ71
 vGyQ/w7K82eogz5kn9gjx4HIa2t1A7rcJa9qRQ09ebxXW52cwviiNKSg1rvt+HSrers=
X-Gm-Gg: AR+sD1098z2UxoV/9NEDlrEvw+w2cxTBHPVG2QGf/NP0mQH5Oqiub6wiSjMfC+5V08v
 vf45UrX5cNuQSQgQ8A9Uq3hvAADNWnLDYF8NhR7R0UT6YwG6dwhrZ2VDghUsDt/jtRNwOJXCQMp
 GbailneZRuGTWgXOZ8HwRoGVc2coOJWyjqGE5WPNtq78hhgBthGruzqZJSh34t5RQfVVdvdtxzG
 fe7XtCvMWolq36w3YWrq0/5wun6ieEfwp+qVaComt5IWN/rvInS7DlY10dg3dNkVgcqDcdKnLiL
 AqpD484FAYYZZ3N2sQVtclOxHORiS6pr2y/WTgBGYiOM13wE/KaUcxQscSnqCzwvss3Ioua2PwO
 oWGLjo0se2WpKOvAeliugdZqwugMXUs3ZomAQYsW2FZ2QqYQjlxriKt8LLF37c8d5/dFj0efOkX
 cG+jrouYrg3jGnF4WUYyaYXucKX8P0scf4dYSwFvUKy60puIanN4R5TV3FdixndDhaCWTyqsczz
 EJm4E7XysR9aAEtRLdc8rXJ3WgDsReU
X-Received: by 2002:a05:6a21:3a83:b0:3cc:841d:bb26 with SMTP id
 adf61e73a8af0-3cf8485c070mr16100519637.15.1787769833619; 
 Wed, 26 Aug 2026 11:43:53 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:43:52 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 08/13] hw/riscv/virt: prefix ACPI helpers with riscv_virt_
Date: Thu, 27 Aug 2026 02:42:22 +0800
Message-ID: <20260826184229.1145-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- virt_acpi_setup and virt_is_acpi_enabled collide with ARM virt when
  both architectures are linked into one qemu-system binary.
- Rename the RISC-V helpers to riscv_virt_acpi_setup and
  riscv_virt_is_acpi_enabled. Leave file-local virt_acpi_build* names
  unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 6 +++---
 include/hw/riscv/virt.h    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 59c454f4f94..832261391d5 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1017,7 +1017,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9019a0a04d6..c53370a35f5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1293,8 +1293,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     virt_build_smbios(s);
 
-    if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+    if (riscv_virt_is_acpi_enabled(s)) {
+        riscv_virt_acpi_setup(s);
     }
 }
 
@@ -1652,7 +1652,7 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 5559783aebb..38ad8b0097e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -133,9 +133,9 @@ enum {
 #define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
                                  1 + FDT_APLIC_INT_CELLS)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.52.0.windows.1


