Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFA8E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimZ-0005Oc-Im; Tue, 31 Dec 2024 15:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimX-0005Av-9v
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimV-0000vv-K5
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:00 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3523092f8f.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676637; x=1736281437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFV9r81Ea/Fg1ZQ98Ka7pViQ6qvJe57bkPT4B6LFdHo=;
 b=rRJQ3mOvb9k+6p+Joh5Xec44VhFiRyuTPV3v+PFy7eW0Sk8WNHVrlBQ6eLiRSFrXzi
 u2lcCjCDaimXi44vlFWUXwvo8DX9ay9Vb6Vmx2e6kApStbQSJ8jJb3FMpJniZhZzyYSG
 tTA4M6NU6eIvfwAfHM2No+O/VyfM57TaZVg6a8kD3Lxx5HqUvfcToKlIjAfNvhNASEuW
 jkbahCHs5r3dZElmdxTj+r3JfNlycsCEzvYUerN7YIKSWla33ta1BcpcOWdbKSj6Tqjg
 e4q7OO8qrcD8zOVZUyw5Sh5VR7yBfyHk/9wLIn+hxmohK3CJnYu/XE11WUfqLg0QkfN0
 P8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676637; x=1736281437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFV9r81Ea/Fg1ZQ98Ka7pViQ6qvJe57bkPT4B6LFdHo=;
 b=mkz75J4o+w/qqnVuAchEZRtbAFI8+ZWgbuBgRvCx2JEsvCYLdiN44ftdYsQV5pK5t3
 xzE75n2OAW8TunTTWnQ6W4pF7HWbSVnBybq84CkdXVvtj4p7PaxdB4Z52FCe1lLuLPVj
 CEX8xUfGRmL7brHq/HpCV9OesRKMSZPbHERCRJh3meKLE7E0DdMCwtAyc7nLbZdLOWV3
 OLubkJpiAYB0XHjIIJrIkAwXwYCawBjTLIT9EU5UP9KqWUEOFpiilwAvwM9tn4WGXyAb
 1LTGkOyoZeQ6tRjvFILSrHMfX/Gox+WlV9RYHKLMS/wzikndSbWuT0y2ie7jMDLP3HKz
 xFkw==
X-Gm-Message-State: AOJu0YwIEkuMAr76WKlsQF3eszjj+pSsRpHBQGZEZoZbT/5DfAIFuUnj
 82c609So+DnbNmPgAwvH3kVQiUG37j1czgXhMs5gXg9XaNh/Ff5ve1L9xuFMZr+4ZN/DretaHlf
 7Qkw=
X-Gm-Gg: ASbGncuVsyI2k5vM2BJWfRiKeyWce951nrx/9p04HAp/rOpuCKyYgYgWq6dcXoiZypp
 sQwZlQxrC63+HknrrUj9lXh8tHWTwaOUoiOag/ZM+IDTtxAjqtEfess6OaczKkTyYbEt49pv6ix
 CLqC+pEpwe5RxyJLxK7ZbY7abq7nK83+5FN2IDbTBR66aWVtZFhxr4uP733unjnXUS9UBV+5ze6
 Tr2DtbujMwdA8mTz7mOB6mkJZtYbGbYCIzpOfD8LeWEMaY1Lxh4ykhP1KjTnUwyHQHUuR5nrnBM
 IYucsMRu8AKjDWx+wtJ2+CM5uw1OcFM=
X-Google-Smtp-Source: AGHT+IE6nGFZAJB2yLWv8kRcsjmAiFoXT8+Z8mzInlKQ6WRrErTvLDT7MF6BjhD+vIje1dkeNlLZ1A==
X-Received: by 2002:a5d:6da1:0:b0:386:4a0c:fe17 with SMTP id
 ffacd0b85a97d-38a2220039fmr33339788f8f.27.1735676637556; 
 Tue, 31 Dec 2024 12:23:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6ca5sm34389184f8f.86.2024.12.31.12.23.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 18/29] hw/misc/vmcoreinfo: Rename opaque pointer as 'opaque'
Date: Tue, 31 Dec 2024 21:22:17 +0100
Message-ID: <20241231202228.28819-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

Both QEMUResetHandler and FWCfgWriteCallback take an opaque
pointer argument, no need to cast.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241219153857.57450-3-philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 31073c8de2a..b1fcc22e92b 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -18,17 +18,17 @@
 #include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
 
-static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
+static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
 {
-    VMCoreInfoState *s = VMCOREINFO(dev);
+    VMCoreInfoState *s = opaque;
 
     s->has_vmcoreinfo = offset == 0 && len == sizeof(s->vmcoreinfo)
         && s->vmcoreinfo.guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
 }
 
-static void vmcoreinfo_reset(void *dev)
+static void vmcoreinfo_reset(void *opaque)
 {
-    VMCoreInfoState *s = VMCOREINFO(dev);
+    VMCoreInfoState *s = opaque;
 
     s->has_vmcoreinfo = false;
     memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
@@ -65,7 +65,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      * This device requires to register a global reset because it is
      * not plugged to a bus (which, as its QOM parent, would reset it).
      */
-    qemu_register_reset(vmcoreinfo_reset, dev);
+    qemu_register_reset(vmcoreinfo_reset, s);
     vmcoreinfo_state = s;
 }
 
-- 
2.47.1


