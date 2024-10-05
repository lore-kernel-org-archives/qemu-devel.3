Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D546ECFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk7-0005LY-9r; Sat, 05 Oct 2024 15:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk4-0005J2-Er; Sat, 05 Oct 2024 15:47:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk2-0007e7-WF; Sat, 05 Oct 2024 15:47:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so31348055e9.3; 
 Sat, 05 Oct 2024 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157620; x=1728762420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Fp8HwTIonO2XomuIOPjS+r/ipl54dMPaCsUxMaTJz4=;
 b=Xxw1BwAtRNDTgdRzKkKG45a/DhiEOQdBX1/y549Z4yu98eEZw/CcgiY2ziBjr12HZi
 YxuF3dMyY3wnpK7nLDiAzoNynNOIfnSkI+BV4GagxzO/jx8FI8sgX8oYxvqOK6bEhLkA
 F5Bc26FVL/gbrw5kdDEs37htcAlGJQg2wjPAoOynmm5WFXyZUcanXnuU9f8zgoAzzmpE
 +NBH4IH4JD6DUGjRgb3sbTvZiSBgEltcEgmhOlKNe1m/FsKWscO0DInIlupC3gWYPPd0
 sH3q48rMWZGwptMBJ4JMP8r7W0p7BWlsZNPz4vfVbAPyWt773h47WYXvkhk3ndV+4yEx
 ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157620; x=1728762420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Fp8HwTIonO2XomuIOPjS+r/ipl54dMPaCsUxMaTJz4=;
 b=HUahKX80ojJWr52/9xduej0NaoKTRjCG+lz7OIb5k/76NCC5XrabmrwQFCUIfuIvB0
 pF8/XB7QfAipyGq2yGwpsu1LG8M60kZ7BCUIyCT+0jirpvwlYHh4vKRkv/kxcgjuCViu
 XWoOmUo3sF81vZnnbq1+BVVSa0y0uLqqyybjWZCtSX9ArtmlNhH6Dd/nVEXtaLIhEz+O
 79ZwrOq63CMhCfN7199Y85DKTo/9cG9iqDrfcW4wj3LqdMtVIkenkUx2xygnycLf1Hba
 OYia4Zr42yZDcNX0C/vQ9w5E4ZJqwbAC/ULU7DavmLci0T+SWwgZsr1KvbHXyHhgnvhN
 yKcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC7KgBC9/phY6DOOZHCjCTiohzFURPT4gL+BRnHfPlQgLXleRKGHDJLyW4hQ/zHp5WX0ShlhGAFP1p@nongnu.org,
 AJvYcCVS8nDE1Wd0HE9tBdaqGXxORpErG0xaU+5FKwa67Msesx5ux2A0ZKBzZUpkuPRgFCsrTUgAkXgwK4s=@nongnu.org
X-Gm-Message-State: AOJu0YwSDO8gC/ZQneMpG/+bLAoSoWXEa6XdAITZdLyq2gGCH2QQpLiw
 u4139ICtJ77jzVR4uCtQt2tpLiq+z3Na2N3GwDhtzZDhM0eZGIaTfC7nbw==
X-Google-Smtp-Source: AGHT+IEDxi7Jj6zagMzFN1e0/myWtE5IgAW2hv47W3MrPmBlC8GpjNNzpDKyypxcw3DFCZqEtTz4iw==
X-Received: by 2002:a05:600c:138b:b0:42c:b950:680b with SMTP id
 5b1f17b1804b1-42f8ddadbd3mr9167475e9.20.1728157619957; 
 Sat, 05 Oct 2024 12:46:59 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:59 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/23] hw/ppc/e500: Add missing device tree properties to
 i2c controller node
Date: Sat,  5 Oct 2024 21:45:45 +0200
Message-ID: <20241005194603.23139-6-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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

When compiling a decompiled device tree blob created with dumpdtb, dtc complains
with:

  /soc@e0000000/i2c@3000: incorrect #address-cells for I2C bus
  /soc@e0000000/i2c@3000: incorrect #size-cells for I2C bus

Fix this by adding the missing device tree properties.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 228287b457..e2a4f265a5 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -196,6 +196,8 @@ static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
     qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
     qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
     qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
+    qemu_fdt_setprop_cell(fdt, i2c, "#size-cells", 0);
+    qemu_fdt_setprop_cell(fdt, i2c, "#address-cells", 1);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
 
     g_free(i2c);
-- 
2.46.2


