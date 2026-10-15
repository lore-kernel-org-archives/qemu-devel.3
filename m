Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCB0CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBzG-0006c8-Ua; Wed, 14 Oct 2026 23:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBz7-0006Zr-4b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:25 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBz5-0006cd-Ka
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:24 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ac6971aaebso194159a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034302; x=1792639102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VmMMUAd6gA6U8M7wACz8JIPXiKmX69iwu/hMcHHU1HE=;
 b=RlwVUPvYt34eWSM57yKG29lg+jTWgbEPbQWEU5YbY1FGQCK8RXmlnEEwrG+X8/YbKf
 uEEBA7nNmWtR0OxeFrtAuTtmWtEjpT/sPASL/G7dr7RqOi4j92I4oABHXoKiqZOTjC1e
 85iyspILalPp64uPKitQrAlgQda21s9U7XcQwPM4bxUJeoyQqlLWq1EycNYRodvK2sy8
 lQ9rZB8BXEHhp4hgBMOPFNCBZNEENEirvy4QgsR/++FJ52iwzXvIaWNcoSLa6hQJp+rg
 FmWiklCatEyQRWkSxtI1uj9jyHpK1fx5A08p79HX6hpvJ2WrZhipDULjC7GIquFIeirW
 sfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034302; x=1792639102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VmMMUAd6gA6U8M7wACz8JIPXiKmX69iwu/hMcHHU1HE=;
 b=ZPmTwKRJYhbrxoARxRoWiq/N4PbMJah+SlpzQrK+ypRWWqcjiyaHNIpxaRSF1wloZh
 hHFKCGXEPGAlmfcUGjKncxDEIQFFKEgTHAhqKL5oIEcd7X7sqO/n0yjwwQWAdt+yb50D
 zpPNMGJoY47Q358izhNVhR2OJ5NGedyS/MtHG1Db5sbNSj9EFXHeQkrfQImgIXUeAYqa
 ThC8qNoedmvo8ilt0wLENPiOANuNe8W84Sp54Mzwqld0g0XHJDVw0FWqtRuILjnghAwp
 NUC6I2Pql7s4fobHgH5ExbFXDOct2UaQPmabS5XOA8WXmxQkJZmqecfxhcWVyfoYb//C
 kLvQ==
X-Gm-Message-State: AFq9FYIaMt451JVHXRKTDTr5pKPSG19Q1LkxIhQX/k6fwOmgnxUk3VqI
 CjCaCdfvtFlcezzdVWI1gFUqQe7/clso8fuWdrt53++Vcut8fyR4461mzi/UYadf7b0p894gbx8
 +UMFrC5Q=
X-Gm-Gg: AYBFou2t0cPhrE7EvCgTpwEO1EO1PNd9MJgWIALXbI3MrcKx/KPUc25cmGKIL8qjVGp
 ft3T9a5PmOEx6G9NgV8kWf7qNH32P1X1ux5+geGWe+nzZB072i/v+2aaBDYe5Qo3MKJL6DQjOWx
 HzgIe4trOrtgW878ZPIi02hxZwziMjJISIcoG+m7i3JtrVr/dyQydfHtXBlcA0XNJcHC2nvQ9nW
 6YdGPFxNH2/af5BdUbYDXMvyp1ssj0rRcNUI9LgY9n/iIo7P5wc+d64f/I0vSgKOJg47IJSU2P/
 tIFtTV8yWgRGqN7ahPPFzVqlkFYF846HlQJFLv4Y8Sdxmnsv2lBD+IehuZbVIGOltexL7bhZrfA
 I/aiUsvkWSsOQr+FAD04UcvPUVHwrzDexYBKpBY1s1gqEl2YIM894FkAao9mmES7AGSLAk9kyBU
 J5j2wj4Ao6W3IDgz6IgmzCJ0LL/4v6mUXgNRxSl+MM89D/S/z2N9sfq3NXJDI7CEfQQEfGn2REQ
 CBsp9xySeAw/U6mmjiQg8GEJ4rUQgyky3UP6C3QeOjAXxm2H+YdtKeKxhY=
X-Received: by 2002:a17:90a:c105:b0:3ac:e6a:1af5 with SMTP id
 98e67ed59e1d1-3ac0e6a4dccmr13978718a91.2.1792034302382; 
 Wed, 14 Oct 2026 20:18:22 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:18:22 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 01/12] hw/riscv/atlantis: Set valid_cpu_types for Atlantis
 machine
Date: Thu, 15 Oct 2026 13:17:53 +1000
Message-ID: <20261015031804.2406055-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

The Atlantis machine only supports setting the cpu_type to an Ascalon
CPU. Set the valid_cpu_types to reflect this.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 311de64eda..ec52faf17f 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -76,6 +76,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
+static const char *const tt_atlantis_valid_cpu_types[] = {
+    TYPE_RISCV_CPU_TT_ASCALON,
+    NULL
+};
+
 static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
 {
     assert(busnr < TT_ATL_NUM_I2C);
@@ -792,6 +797,7 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_cpus = 8;
     mc->default_ram_size = 4 * GiB;
     mc->default_cpu_type = TYPE_RISCV_CPU_TT_ASCALON;
+    mc->valid_cpu_types = tt_atlantis_valid_cpu_types;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->default_ram_id = "tt_atlantis.ram";
-- 
2.43.0


