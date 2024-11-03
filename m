Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42637D11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7akv-0006Du-9V; Sun, 03 Nov 2024 08:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akl-00068k-O5; Sun, 03 Nov 2024 08:34:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akj-0001EC-GA; Sun, 03 Nov 2024 08:34:50 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9abe139088so506790566b.1; 
 Sun, 03 Nov 2024 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640887; x=1731245687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODth02XHk2l2sGfVJHhWS3UJ9E3eRYVl7bEr+6Us9LU=;
 b=TvKintYFNm2Kw2WXPnmSwuY8M00hiv1hQKrZYzVcyWhBPH99hzD4lXhrNUsBWCiEbL
 MCXl2ym5QT5RKNArlUeiVJ1OY0HmGtJd5vk7x5eOP8VH8Tsr1SmNTrKOXIMyB4Jtq+pn
 FVpgneSBZilCIrwXNRF/rYyhaOADuBI8AiQ2f/THR6xgkl+Sz9D+x18UH9SnPAJZgY9k
 U++8zGFOJcEPj4CvqrgSSaMNhIUd0Zzhh0o41IqzltqeWhRR2XDTCMuDPiNtEJ/61a0u
 nu1wUYo2Ek9u1ZUjmV+qZJI0SgXvU9dD2v2dlnQwbwnXS1KlgnIOcOiaKBDzIkNuPfCT
 ADBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640887; x=1731245687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODth02XHk2l2sGfVJHhWS3UJ9E3eRYVl7bEr+6Us9LU=;
 b=JF+DoFNbz352p7B1QgqJm2AZ7Vw3axDFq+GNKWWudPQO7gbcX1t4KW4Be+uEZmlITg
 R6/7XYuRjINfeaR9lvPDJAUhc5XUbhmKzQlP19S7Uim6lgVsPk561AofgcZGOCtg5s3M
 9rMs8clrPqb2ViQRMVaRSvnhc3LY+J99FfKYLD2fItvYlcWX8vleqPhGcdov8Ne2vKbR
 /6aGNQuRx3UYHyCZCA238ARsjJj06nRG0qilELSCH3m58AK/LyTpAw5vfmz0nxR2DHrh
 PTAGqX/JIBmNfzEQkH4Se2nAzQXrjK8tXgnO1a+Twn8HzOcA51PswCUN4tRm29dOg0pg
 J9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYsT2mJMzchkhjddyjNxCpw0IBQsg4ft2J6sXBWy8AkvqJc0oZUTcDWv6adAwErq1KsasLNQD84Ig=@nongnu.org,
 AJvYcCVxxYt6/j2x236c5A7tPX2Cy59/pD9MrsG4YRBsiI/g6DwObt898Dy34ZbtGfHB3qk0UcnXcSLJuiPH@nongnu.org
X-Gm-Message-State: AOJu0YxW9Y8+vxMHQxKNs9TWvCh59BH5tlRPtdUOBVJ0F+SN7i5ZtXaG
 00mpLfLenXOMSEcIsnGr0Y6k5BW5bcFMFlLWAu2xyFt81phJWql28fmrug==
X-Google-Smtp-Source: AGHT+IFF8/L/iRE8yf5AQZFoUl5px1enwfXfTk1acUptV6vJQG5DQ7oGj0T1IZutGdcS/wQaRdWHJQ==
X-Received: by 2002:a17:906:da89:b0:a99:43b2:417e with SMTP id
 a640c23a62f3a-a9de61a2e85mr2720945766b.62.1730640887051; 
 Sun, 03 Nov 2024 05:34:47 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:46 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 05/26] hw/ppc/e500: Add missing device tree properties to
 i2c controller node
Date: Sun,  3 Nov 2024 14:33:51 +0100
Message-ID: <20241103133412.73536-6-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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
index ecaaab1558..a0c856568b 100644
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
2.47.0


