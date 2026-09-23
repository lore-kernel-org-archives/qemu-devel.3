Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28FEC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mxv-0001aF-Ob; Wed, 23 Sep 2026 09:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mu1-00027p-5H
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:20:57 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mty-0007Qm-3J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:20:48 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-3396cec93b6so974312eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169642; x=1790774442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F3AfQfrqvQe4UOX8IvAjiJQ3WGlTiTKTbcrqm5A18SE=;
 b=B173eR+Hp7JKa1Q+OFMwg+IK02VOp4eeSmM+IrbkRsypVf/lADy81PqlodI02v+SvY
 F+90RaKCRhdFQc62JSP3cS0AQ8MQX+8Cw72lmYR/d8og/lX8AHPFXVNtg3/aq9tHRzo0
 3WG6UxlxQoqhWU1Y090nKTtP9MMAHEAhGHojxA8DUroszximtArEGofjtbqtde+52Wdu
 D+YUhhUBLrKD6xK98332ts6UyLZeME8Eoxho0bWfjpQEWHCVzN7Yi4nSD0EkKdYH24AX
 Tgm9sdHc/lCbm7/p68NALeofjbmD+zPR0tPXM7XAW35VQ6iMJOj0uKcSCEDcF2swhV+a
 yDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169642; x=1790774442;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F3AfQfrqvQe4UOX8IvAjiJQ3WGlTiTKTbcrqm5A18SE=;
 b=pvbJoHYNuQw5NNq+2TukI+P2XvttxoiyRou7vf4rE2ugKzGeGFq5LZgrN/dCd/w6wO
 1Ba6XB3kz+zTAdq2Ue8iltA52DJqVtWQNXxxupApqhpu9aJhTli22KE4g7NxtMKzykb4
 YMB15f7nJ0zw8JNMvyhDq+OiBDh+QfOMHfhhuR4huzUxTJpXwqedc7PLBR6HGg1EST4w
 RlD//7l3GoAp/KvsKq1zTp9C83IN+7ugYnG4QVBLghd/73DGBRgolRsH/eH7WpWVJDg0
 IskeNy0+oHm2h/Be/WLX1ayRSthvDpRqz2jnFQAUQhDv9tYhkIxY71QOo3BiK5II8c0z
 MPpA==
X-Gm-Message-State: AFuF++lIRONntpbcoobQ1uwWCXa23AdTH4rq21mdiUSwe6uZqF1AyhLs
 VSKzFPmJ/vv1Fg5fnEO25XFwWMjpjYgoV/G7U2I4WcuNQDlXADXvllUGLaGUgkvkgOE=
X-Gm-Gg: AYBFou385T/oQK4GwGRnlR+OuvW5jy4+FOCS3HR1wB4TRDE7Ua48dTTG9MydR8DfcJg
 rQXNPvPPCSM7s1SvJZyrZI4BcYPjPnZlQz22eOgNlOzDAc+Y1NMquVNQ9rRNgjNy19YUhgxfg4f
 9FY7AOxgClK/j7/IY1qlMlnR2TAR7KIwaQrk78xQdwL8Idjy7wfGhZfa/iJtB6/GG0Vjl9ZidZV
 nAzfQSKy62for0DfWwy8yj7m0NdJfY9hkvPnEU5Kk8zHsBy9dCIbRPgnkrJiha7aVWDxarXPbjc
 rs6aGqgcLDsKA675uFe2FgNbmuRbCM5fj4uhc4Xss+3uDbaCMf4R1WAy9RrWhwb2hhVc3y0tsHr
 QD6U/QiSdpzwgbVoMh79PfrTo5VbC/MSPTeRZGOSGg3xV5O45dAd4mmqVUyKKj/BPeTYdrzy0jb
 yV0luTj9azw+JDwIOBvq9QQltaP8AFERUNctbnCL9/Z2WhZZn/H8+pvDsIGMZ7VKlVJ1c293Xn+
 0FkY6nWGjmO9IG+0xidxitVhTQ9tR2jX0QaCjYVYA==
X-Received: by 2002:a05:693c:638c:20b0:339:7da3:a4f8 with SMTP id
 5a478bee46e88-33e8d6d1242mr2659932eec.19.1790169641572; 
 Wed, 23 Sep 2026 06:20:41 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:20:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 022/114] hw/riscv/virt: prefix ACPI helpers with riscv_virt_
Date: Wed, 23 Sep 2026 21:14:56 +0800
Message-ID: <20260923131635.1894-23-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8e516ec1148..de47631852f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 686222fa0da..0edf75fefc3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -706,8 +706,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     virt_build_smbios(s);
 
-    if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+    if (riscv_virt_is_acpi_enabled(s)) {
+        riscv_virt_acpi_setup(s);
     }
 }
 
@@ -1067,7 +1067,7 @@ static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
 }
 
-bool virt_is_acpi_enabled(RISCVVirtState *s)
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi != ON_OFF_AUTO_OFF;
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 969aa5866ee..1cdc5840b7a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,9 +121,9 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
-bool virt_is_acpi_enabled(RISCVVirtState *s);
+bool riscv_virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.52.0.windows.1


