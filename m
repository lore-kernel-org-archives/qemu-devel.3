Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E71C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANa8-0008Db-WE; Sat, 26 Sep 2026 04:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANa6-0008C1-Qj
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:26 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANa5-0006oR-A6
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:26 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a156f4so871431eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410584; x=1791015384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dGcjkcxYt8eZEjWK6mpDvnDtPiferHjEtlr90RuU0eI=;
 b=GhY45SZTYPb0XGwu4MkKSEpJ6U16TBOjaJQeZx9N64CL20BoEpJ2x7330p4pP1SuyR
 kRFve7hnbZoW14xM8Ex3iVc/Cg22invFc1xgvrS5LAixlWsJmHlu0SqUSyZVRIRWoHHC
 gvAigC1Q4OnRbMHLH10I3pJJgSl/Old7O2yDZw5rnbNfadTndOy5TUw0rGjx6pkye3HQ
 m8mtpl3P4GXLSPcJ+A8UyLjUBwYC3M0Rd3XeoPxAzIyXkSaGvhg8DLtfEUI2mudpv3ny
 Pi/2TjdLYZHv3Ur7h4RKjUVNy1EIpqOKrf7d8FHknKbbUop/bvDEopM0YgjkJrE9AoqD
 5OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410584; x=1791015384;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dGcjkcxYt8eZEjWK6mpDvnDtPiferHjEtlr90RuU0eI=;
 b=w67bh5/+A3Y/Fy5q72MigBmunhdz4wSXOM3+4YYv9/i3X/pPRN30hFkYT/NwhsRn/T
 xPB1y59VqFLOKVp0a/ekeXoQLT+elfDCmnOV8QxJhq4H+rdh2e+bi3YbI20DQ2iYXMGg
 cMOEBGkpKmQ2FPnfME55rLw+D7uCBKn+rbU3XYei4nfH+YIrobbDk448kAiV3sfpkZkR
 btZLX7IcSoiwB229ROFiJKSq4DER1Ifyl3bgeQQ7QCJ5Z1Mk356bcjSC2TFWZ3IXtQo7
 p8xtyjkL3wTX05ouE7pYwzL5SoAj0rOFuzXEZxkn7Dm8w7BwC4hlOjXpW9U8xEwCdqoc
 8sJQ==
X-Gm-Message-State: AFuF++m2k2dT+AZqPjEJPnKyUuMDqVAJ5S5K8oSQoaTrOOz8td54GE16
 0aN48QCE4+fAYH23BfIr55Xyoaamr7GdQuj8S6sFBMfIfvzEUVdIVw1P2BFPQRQi
X-Gm-Gg: AYBFou1I39Mqy9/1dvY3RDfhF+EJ4F5tezgZ2o1xynwF2PTT0kagOwJY9AaAmLDH3qW
 53fsIE1gD7qDOhHLmYoprmYvG8fDe36fnu3YVNLPsYbO/nEI8+yAyKyZsVDSRyUhlbfYnNbtOz/
 zb1ATrUEvhgp8WDIjJIhWPFuICPkLQPVXBzaYVseVnqu+QwvjXRp7QqZiyogSSbmH0VT0alDgQF
 BndXGp5FRMJpB0PmsmH3q/dxjqJi18WAyeYJDqfX7LD3TtSIqkMC2Giej+2nhfo8QVfQyITU4CQ
 1kteC+DVKBvDYMlAzVxR4kkkIjDFePZYudI8PMukoGpdlNIo1CVzM38PX3eOCWf+EW7kRZwjA1Z
 /nK8NyNf1rDXXDsHMBfdmakhmfJMwluVMIUIjHpHvc4PKKbYPxVE18dVXwmMZ8RQ16i6DImKS1l
 H9YdC5FRQpFOxw9zlKpGfVM1z8AtiVRkIYzelXz1Z2wtSY42WExQi75Xz4TCBroDFDr+S9/ao4s
 CKjw1L9BJQfFEAXmN5jNPZ4v9sKlrZz
X-Received: by 2002:a05:7301:f10:b0:33b:c69b:7074 with SMTP id
 5a478bee46e88-342700be120mr2169607eec.4.1790410583789; 
 Sat, 26 Sep 2026 01:16:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 04/10] hw/or1k/virt: use unique QOM name
Date: Sat, 26 Sep 2026 16:15:44 +0800
Message-ID: <20260926081551.29-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
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

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("or1k-virt") so OpenRISC
virt no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/or1k/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 2ff5c084a2b..35884252379 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -34,7 +34,7 @@
 #define VIRT_CPUS_MAX 4
 #define VIRT_CLK_MHZ 20000000
 
-#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("or1k-virt")
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
 
@@ -548,6 +548,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "or1k virtual machine";
+    machine_class_set_name(mc, "virt");
     mc->init = openrisc_virt_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
-- 
2.52.0.windows.1


