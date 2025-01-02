Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTLDp-0006Km-Q0; Thu, 02 Jan 2025 08:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTLDj-0006Jp-C7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:26:41 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTLDa-0005Yn-Rp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:26:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so6269510f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735824386; x=1736429186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgI9e/39bBslkdJehrraLuA5jXNi3WzK26wG2QPQYMo=;
 b=y6hbv13op4Pf9SZ9iJBKz7Y3/OD5WSqmmmu3OH65U1R+NmCclOdBgqHf00Lu/haSgQ
 ozAjVxcCPl47nOh5DO2PLfXtso7PeURZEq0eXLNe0ecCjBquv62HSPT6f+qBkQqQcZ7F
 0SFk9b3yG8HsNj47Rf+El1/9glJgL/2AveQp2WeMeMMlGcVYz8CahJL45r/vJhouRdJf
 08bpdlVVtDWLYVQwbVYYf2Zk+gJCteZ9dooh16mu+o8qNXbiWRFmfVw/eQyCPb5vCPK0
 Lo5cf6hf8Ji5h4kG/cFKWPkZrmHHG1IwnaC3fsRFUg7vxUBkbX/YArG5P6gMVhfSQT7b
 ymKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735824386; x=1736429186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgI9e/39bBslkdJehrraLuA5jXNi3WzK26wG2QPQYMo=;
 b=eUiB/zVaT4Jmlwbqt10njkhcb63FdEtMoZRa4aGlNiFW5p1xLarRfgjjSZyljlTzGj
 oJn5P9XdDFgA7FvSfZoC7YP/fZjxAp9pdHwQyHHgO9fKvZDUTbYs4MD1gaOEUSUAhWWh
 xK9IB55G70OLbhQV61ZyBzZMQQBInKfajapCrRpKx/KUZIPwUHfuIQnV1vxGYXZxPdCz
 lL3zcHIBbK/xbbLhorobFQNp3dV3G/9JyjlNkIMY+dFnNtcVtqsgiNp5UQACgtx22TQA
 icU8kyKrFeY1w3lyDXGklPrtjJ9MNrAtTNMHv1EsmAbCfq5RiiAIUi5VjVstEUsAmO4i
 ozlQ==
X-Gm-Message-State: AOJu0YyNdcZLTFgkO5XTYm5yzkFyiEQM8wZkxTy0ct+1druvZBsMkrFP
 Zo4CpFIm5tIe/ZcfWhPUcAgbW7oseRKHeCi50XWurLJ1/vVQ7iekIbTml5cOhcXNmqQ/J/HrmFT
 54tBaXw==
X-Gm-Gg: ASbGncv1HEjRJ2Zx+f9qyZRpMzAkvFORTEADmpzY1NKkxBtpxUM3zTwv7JjNFrCyv5S
 XpGgbJ1JwjtdY+FzbeoK0989QEoIiJft7e0/56X3LR5oduoolYHqenMtiF7LB4ocufW2yQYmQBZ
 aR4418y2qEgMDmSRQAfIub4gQuX+bviKmX5MF0otUEw4dS4LUTsGHA6GbGNSFWjYkgUydHiKg94
 12KF87hcOwMjf7Ysfjyrf1bES7GvZKScDU5YEi9aJc9KmkO7D6HqB9zgtzI7/xJkTmYmc9hbHQh
 82laWhbb/8NnYhsEaslO902oxtVT4Ik=
X-Google-Smtp-Source: AGHT+IFFlHAAy48r7pdUk5SwGsHetX7vKOCnAuyWqjdP9Dinist6Yq2O+nabB/yaAkLImLCI520hGQ==
X-Received: by 2002:a05:6000:1867:b0:385:e105:d884 with SMTP id
 ffacd0b85a97d-38a223f5be7mr37602432f8f.46.1735824386309; 
 Thu, 02 Jan 2025 05:26:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm488181555e9.15.2025.01.02.05.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 05:26:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO
Date: Thu,  2 Jan 2025 14:26:24 +0100
Message-ID: <20250102132624.53443-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Follow the assumed QOM type definition style, prefixing with
'TYPE_', and dropping the '_DEVICE' suffix which doesn't add
any value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Supersedes: <20241219153857.57450-5-philmd@linaro.org>
Since v1:
- Drop '_DEVICE' suffix (danpb)
---
 include/hw/misc/vmcoreinfo.h | 7 +++----
 hw/misc/vmcoreinfo.c         | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 0b7b55d400a..1aa44771632 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -16,10 +16,9 @@
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
-#define VMCOREINFO_DEVICE "vmcoreinfo"
+#define TYPE_VMCOREINFO "vmcoreinfo"
 typedef struct VMCoreInfoState VMCoreInfoState;
-DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
-                         VMCOREINFO_DEVICE)
+DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO, TYPE_VMCOREINFO)
 
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
 
@@ -33,7 +32,7 @@ struct VMCoreInfoState {
 /* returns NULL unless there is exactly one device */
 static inline VMCoreInfoState *vmcoreinfo_find(void)
 {
-    Object *o = object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
+    Object *o = object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
 
     return o ? VMCOREINFO(o) : NULL;
 }
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index b1fcc22e92b..145f13a65cf 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -47,13 +47,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      */
     if (!vmcoreinfo_find()) {
         error_setg(errp, "at most one %s device is permitted",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO);
         return;
     }
 
     if (!fw_cfg || !fw_cfg->dma_enabled) {
         error_setg(errp, "%s device requires fw_cfg with DMA",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO);
         return;
     }
 
@@ -95,7 +95,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo vmcoreinfo_types[] = {
     {
-        .name           = VMCOREINFO_DEVICE,
+        .name           = TYPE_VMCOREINFO,
         .parent         = TYPE_DEVICE,
         .instance_size  = sizeof(VMCoreInfoState),
         .class_init     = vmcoreinfo_device_class_init,
-- 
2.47.1


