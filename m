Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D3FD11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al4-0006Ur-Un; Sun, 03 Nov 2024 08:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akx-0006GM-16; Sun, 03 Nov 2024 08:35:03 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akv-0001H2-Gk; Sun, 03 Nov 2024 08:35:02 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso590133666b.2; 
 Sun, 03 Nov 2024 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640898; x=1731245698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewKz4XWNmQIqUkyxTbXCUQmadauWdqAWF9aPgS8rmA8=;
 b=YmjqKjDjVYZ2nof3T68N+GUulIKE5u9JVbyO7lQ8Ba3BY7AbfJejjezgMyiCA/568H
 PyWeGxx45SIYizKbLoSeonMYx+zGIbgy01yYo5yuv7OMowHyedPYMBHnBwdOh+ZD3/V5
 EfKeQ1eBWqnnKftpW9xfK+sQtTXelrvqxqKr0z3+9yioO880TfgeEMpfsgbhPmH89/eH
 Zh8FxTeWCx2NszI9O6cKm22AMMEurdE4SLH+jraQg63GxePo9w3Kk1Jj1aJLyE86p3KT
 1RH1N4eWd41b+2r+9KMDD2XJ7h1MtVvN7b8TnzcHEmv/VcMbFzBU6K9PfwIrnChD/vUg
 YQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640898; x=1731245698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewKz4XWNmQIqUkyxTbXCUQmadauWdqAWF9aPgS8rmA8=;
 b=kF9YDQ47hE0Kn2DQ5UQRtyfMRScbpf3BQCg6TVYLUs1zDWez6280y/LwgTZP3387FR
 g+T8sa6ddCqkBvPqTsqbeeIdO7UEfmq0fY5EFa1LK5ibUiZYo5f6Kfft6ND8topky5D2
 vQbHYvFh2N9fF7e1KT4PQDqNyj8QNwjkqUjYkW26J0PM9cjkMNWbsM1W4azyVXIWJPDj
 SLJkiABXaqIo6QtTH+p+7EoSoi0yTaViA4GOAyCahK2Y8xPeXmVyXwcqOdVi1XdTMYQC
 t35lX+Lml6eDAOepzs6u02XK6JV9+bg2v1kwPIWmmN5310gK3BVKLg51m0Xml3VoJmYs
 vrnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwCR/WSg0hm/Yoissi0EYJEeuZWAq9mq9DP5Qia0wQNJEYYsmTdssHjQFu/ni1VUGsEbtsQSF/bLg=@nongnu.org,
 AJvYcCXTLU3Cm070atJ+6q+B/HVcC0XbQC39lWBkehqhXm6/vrJqLfZnyxpRqKlA36dPOV3xdbavRd/F6IDk@nongnu.org
X-Gm-Message-State: AOJu0YwL60C+nzJJVaTh8hDkWGNoZYx13tAUCDKVcroqDWWUmu6Vb65i
 IIJsGSUMpY3XHm0SpDcXcJuj+fl8cEYZCdt5ib/FAyhCeP3YfDnDWrS51w==
X-Google-Smtp-Source: AGHT+IHBZYbIlmSk/W+Ev6sJI8xKi/KLvDdhEKIfo4tDQ9a1dh6S5fFew5CHRITwGbgXcfA/2ht3jw==
X-Received: by 2002:a17:906:730f:b0:a9a:1565:1051 with SMTP id
 a640c23a62f3a-a9de5d6e1fdmr2942272466b.10.1730640898202; 
 Sun, 03 Nov 2024 05:34:58 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:57 -0800 (PST)
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
Subject: [PATCH v4 12/26] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:33:58 +0100
Message-ID: <20241103133412.73536-13-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/mpc_i2c.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 3d79c15653..913d044ac1 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
-#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
@@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
     dc->desc = "MPC I2C Controller";
 }
 
-static const TypeInfo mpc_i2c_type_info = {
-    .name          = TYPE_MPC_I2C,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPCI2CState),
-    .class_init    = mpc_i2c_class_init,
+static const TypeInfo mpc_i2c_types[] = {
+    {
+        .name          = TYPE_MPC_I2C,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPCI2CState),
+        .class_init    = mpc_i2c_class_init,
+    },
 };
 
-static void mpc_i2c_register_types(void)
-{
-    type_register_static(&mpc_i2c_type_info);
-}
-
-type_init(mpc_i2c_register_types)
+DEFINE_TYPES(mpc_i2c_types)
-- 
2.47.0


