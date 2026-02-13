Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F17CEF99C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJl-0006OX-0r; Fri, 13 Feb 2026 12:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJj-0006Nd-Hi
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJi-0006QO-4f
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:50:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-481188b7760so10569925e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005056; x=1771609856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcZbPZ7aXNry3pyWmbw3A/aeb+iNzKBFCO2e4WrCYSc=;
 b=RTaO7rzJVW0QYiTBdaXLYno4VzP2DEOBYsva2LLpuCtwN17RaSZjtpRPwQfcbxFmgk
 EOKz0eqNBAuRg8+Q1l/4Xu8P4Bia8N978Nh3cwLmpwNPSws+fkIdCXAqxt9h76IQmJkd
 ee0PCBKiomQRAxf2M7jWiLD4WCmqWqpqiGaDM79YM3fZG1r/Kh3ybsNw0NfnQR4QyaOl
 t/2nfZbZkqDRnanMk8mcB5JxleqYmzNyGHfkDvjuCepJm4tcvoyzqYBq+WBD0YOKSvmY
 /UThDjmpuX+vN+0r6MhcTvEVbwo54nnQqo/2WT8FOO/EGwvOB7Nyn3Vhnd2deUHB6q7G
 34QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005056; x=1771609856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KcZbPZ7aXNry3pyWmbw3A/aeb+iNzKBFCO2e4WrCYSc=;
 b=e9XgkXeMXvylfL2CwgfvHY1Tt54F1EQiPK7H08a79Xf4MrlSTdr+0WyFMoVvaZubea
 WP0ZAPEZijeUVCywCLR5b5vjFN68yySjrjF0J7xAV6EMPw3tmzD2FVHe4MOp+DTI1nMT
 Y2/agvqoEoPCULi+w5w3o3Q4LLonAwc7NvZ5K2VMuwfAtTgF2anNl5iIyAnosHqgkgml
 VnhTCGuxap71ECe/FyikVCvjnlp4OxvYnztA8oIbt8z15MJYj3SET/Qm2oxTw0d52NqB
 QPq/l7vk3VdkDztbRVbdq25O60XJJE3wz6mEX8GBXMm+4x0LaunAD+0qOQ/yzsezUG3S
 HtZQ==
X-Gm-Message-State: AOJu0YxHZr3sOuep3NiPOjU65/GoZByGPyNwBksiQ3Y08mjhUq84aXO0
 XsA8gAqUn7hJXFJ9qjW7VLyrNZYHOFJhUTEdXlFyeQovmNMWiFZyidU3sfAE7h98r3r3Fm0rdSI
 PwrLaPVA=
X-Gm-Gg: AZuq6aIVHqspq007iKmBig7R+bUSoJlI48ymr957Xm6ffM1cfy7BNJLWrRNthRtqmo1
 UQbQDa5zihjLnI4pC2S7gLNEurI/e3/3f19j2qVRgk4jFrxlR55M62NKG7LMyo58nl3uX3pPk30
 4biTnazh9C++LsvJ7bA3iBA0sI3U0OWz+hT3cGuSSage251vIj9bqiO4IRoqSKq9aibnzS5r7Nn
 FkwZhHK8R2VTkvYK1xSulNQeYWKV+XtSNY9PQR4dxWNNfS8lu0rOYsANotxzoGu85Tuc+r3+2Xn
 dL9PF+CITqT4Bzr47reI19LbESEMJpriDQuB7SYDoAHxoH7EQW5oAcefUtihTyTlwvKCP1EZrEK
 hGdUrso23C1r1dQ7hWhwLxvdp8RPCnhkvnT72HLzGXrtJY4SCxV2tKvUVuGTX17Qxn6PYvEpGLL
 JogcjFQ74gjDC5Tz959YYJNDZL5SmIlUq/SekyPFPSx2ztKWXJNZYSR59KehtSOqCWqrHK+rWj
X-Received: by 2002:a05:600d:6413:20b0:483:79ad:f3b9 with SMTP id
 5b1f17b1804b1-48379adf60amr2241305e9.28.1771005056213; 
 Fri, 13 Feb 2026 09:50:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfafcdsm359920885e9.9.2026.02.13.09.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:50:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 3/5] hw/scsi/disk: Prefer target_s390x() over
 qemu_arch_available()
Date: Fri, 13 Feb 2026 18:50:30 +0100
Message-ID: <20260213175032.32121-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213175032.32121-1-philmd@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 hw/scsi/scsi-disk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 877ad21579f..68eb65fbf4a 100644
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


