Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1C8FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBv-0007ss-2F; Wed, 25 Feb 2026 18:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBt-0007sJ-Hd
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:13 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBr-0004HP-3V
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:13 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso2467675e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061669; x=1772666469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUy747eLUsQzKmOZLXCMVSBXog85AzJ+ezaKKEhkr98=;
 b=IHRRz9grziJozDNN7Ya07cF2ujDl1199QW8yD9gQUon++OUB4QtwKP10VuiT0sLBqk
 Z27hF6aa51pC9Y7REMskZ4f2i+QXMusZeJ+2I2ZyJFYAAvOzFvZhqkmaDnJ8H5HFRE7d
 QXqhEHDpg0PV9p1gIkwMRFokCuE4W97r3YWpT5QZ4rmcwoe0xrBkthf1hOuK5bqWwmS5
 2P0Bo5WU7WHceLqby/8N/9QEtJUDhKnPa5stwwNrBhewEdjhAxPBkgWwTMCRgu5i7WKv
 GhlGdzHROUJQmUdnoujCr88rixHXe6vcuDpnRyb7bIsDjvdBUZkf9UiqSkP+6LLdGuAd
 JAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061669; x=1772666469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUy747eLUsQzKmOZLXCMVSBXog85AzJ+ezaKKEhkr98=;
 b=lRJuix+/qbFRXbQ2W0NDDcFV01S6cU5gr+9cGhZQKfHA31JMJ4g0mUJRyZqWxvKFto
 zxZxiKKcL4YhRmnG5O8EiEmyNgrkyHFV4SJLQne0p5TKEHQJueREMikLFioATa3b722L
 nSVJXY3T0+OGFZqVP/424sHtnI48rLl1ZQR2vdscKlHvMEuDVMygBPq40tSJDtfyr/qu
 E8WOIGNlXd99XIuMJLGZ363IJw6VtnSKgl4sT6PKHFWFYkSlhVfDeYcq9YDpotHhtVxw
 ReIkZSnDMjdIPXzpkJlSP6Hm2girqPQvNsp7YMX/J4U5fkm6AeMbqeo9TgWhLALQ9aJi
 SSDg==
X-Gm-Message-State: AOJu0YxzSsv69VDGzXOl71CiM2iBk61/WJBDfyMxNPi351vkOeTSePHM
 TnrJ/7p16ochSf2tSFxK26Uzmn6N4fKTfKUKfjLBaxhEjv6os3s0AT4D8aJ5bS/Ao6RUAZCQs9l
 qJ0QOzFU=
X-Gm-Gg: ATEYQzy5o+euqmmlqIpJATFQslFqA9SRihRUoEIlaIgWAvndcSTTYQr0WNRdezqsQzy
 09Q9uUiRyRwNctD+fpM/GE4+2qEc+Q4UGTzkIMYEqCuP+jsJv4iT2Goh0dbexjdodarplH31D//
 XgYsyyCFsG0KCB34NqM66WNPo4ZCMcs7UCT5KTvyMA3n8NTVbVgihlJnHZowhvyQAkDXBR1N7CS
 rlThPXZZvU/pqFtx/xKl4lBHVv6J9Z8n8MgfWMCyNKJ6qNVYOqP7RYfhZ8LYtd/ho20L/omzY/N
 ZbKWhwqn5j4rB0CNeO7XhlxOBM4bcvjCD2o70mYmzAnlX/4OsCtbEeEL4QJ4O0C/Vre/IQAmSft
 HHeSOi1zGx4em+hNm/5lSrMPYhX/BxpBfinOwngTLOe9phjgttTNtUW+TsD6eprAwowNYwCmXXE
 AbABIo+iWUU19xdUOTbrFkhT/KARxZZPMmhGBK/xCUFKDLHVqj70ouxg3/84o9N7X09/CSUyRdC
 L/mARTTUvs=
X-Received: by 2002:a05:600c:6094:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-483a962f0c5mr282797695e9.22.1772061668856; 
 Wed, 25 Feb 2026 15:21:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b346ccsm4329665e9.2.2026.02.25.15.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/70] hw/scsi/disk: Prefer target_s390x() over
 qemu_arch_available()
Date: Thu, 26 Feb 2026 00:14:01 +0100
Message-ID: <20260225231411.96482-62-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

qemu_arch_available() is used to check if a broadly available
feature should be exposed to a particular set of target
architectures. Here we only want to check something that is
specific to s390x: the target_s390x() helper is more adapted.
Besides, it will allow to reduce qemu_arch_available() scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260213175032.32121-4-philmd@linaro.org>
---
 hw/scsi/scsi-disk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 2f400f5b778..a5201855352 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -27,13 +27,13 @@
 #include "qemu/module.h"
 #include "qemu/hw-version.h"
 #include "qemu/memalign.h"
+#include "qemu/target-info.h"
 #include "hw/scsi/scsi.h"
 #include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
-#include "system/arch_init.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "hw/block/block.h"
@@ -3180,7 +3180,7 @@ static void scsi_property_add_specifics(DeviceClass *dc)
     ObjectClass *oc = OBJECT_CLASS(dc);
 
     /* The loadparm property is only supported on s390x */
-    if (qemu_arch_available(QEMU_ARCH_S390X)) {
+    if (target_s390x()) {
         object_class_property_add_str(oc, "loadparm",
                                       scsi_property_get_loadparm,
                                       scsi_property_set_loadparm);
-- 
2.52.0


