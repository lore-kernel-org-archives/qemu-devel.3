Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6472DE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6JP-0002cj-4r; Sun, 12 Jan 2025 17:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ir-0001X6-O1
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6In-0006XI-SL
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so38321715e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720363; x=1737325163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6BLB98QOhYB9SJnN/K59or+VrLw70OVqLIYKmEsPfE=;
 b=owbPDE08GxOZ3tqY3dP+Pb4+H//y8mWP2LNCoxvEznFamSagDvHWAyUXxYD7z/NBgj
 s2nORXU/S/4J/ZyeYYUtTvnl8GlghqA6rGY3KA8rZYjBFpS3DOAraY89+T7sT6EOz0j6
 t6Yo8/yq1y/81U/9AhjALjkBKNB+VlNZ0BwW1c/ABOo16qgu288HWZb+yDdUcommWSoH
 lvDGRvf2EI6wsoq0+G/KN37sp8zlYpgVjHZ9IWt0KMDk53fdc3KxvB2v/IrtqrKc+qd4
 KaVrpKNwLpEaFHawq6pedKTXk1jabT+87qNR+iS4z1W5a7ztaU83M8a9UMwjgWIZkkE0
 kWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720363; x=1737325163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6BLB98QOhYB9SJnN/K59or+VrLw70OVqLIYKmEsPfE=;
 b=TyF6zDwOgyH9Gn9AS+409h/0vFhkqYNtN5xiHuCuiE8p/jvJg8rApLuPvAfB83NIBC
 qkH7PavTcEuErZr3A+bDlSKa2akqLSJB0soN18XEUkheqt7aRw/Vz4CoPV3vJQNCZFb+
 WG1+51sO8wTh1uLvXmFyBgJPEUkcHJ4rZnTgJSVAlymSlEq9pXBbjmHDjj1zRVhr7RAz
 1eabTkqUdAkbPAk0w319XflV2GWqw7iCEStZ8yka3+RoEKO73d1yURShW+MH8/o/hZ46
 37cd29iZaYI/h/gxRM11agt3hB5WTcZ/g/svgeyIGnGPt4Vcm1yWw7G5KbDfY0o4psn4
 oseg==
X-Gm-Message-State: AOJu0YymsuOwfrjNh6icZYT2OodhUx2tf3Ar78eMJMLlVXvDHvxCgR7M
 ToZLiGeMWpGE1/3uGOG36czMei6JoHWsyutnvOpK3L+oM4WAUfIJAJyr5QM9p3uNuyHC9AFVhvU
 BzYo=
X-Gm-Gg: ASbGnctQNQHTfIuN5aD8CFZYBt1ss/Q3Qbsww7lsOpBea5Nj12So7jhTvi7osQRlF1N
 y21w7TKuX4O14kbwBXqdX7+QT/9tSDZGvRWJxYrBfFcSi9HIbpy9DIIiWd30ZQg+6Th8E/gNdW3
 fteNA5bfusoVXGFxfWjE5PKwoQ3lmQeZ3qYXfp7WE2dp+5W39prE6Gvix6YXdQGK5glE33O5mY8
 dqiXZasgWu9xR6ANuvhhlIQUggU5joMDb/xREdMUTBlr7H9JotJumfm8KEMwlowyFXI/iNVOJLJ
 ab3TSht9ZCs9ZdnlQRgz3jp8HI74AAg=
X-Google-Smtp-Source: AGHT+IEBgLJOxMeJC8yw9St/ahnn6IsrC5Dv1YXOHYwmAEnSbHOgxZbAY6J/PLBU+TPWCQW8bGNxUg==
X-Received: by 2002:a05:600c:198c:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-436e26f2a30mr139775635e9.28.1736720362777; 
 Sun, 12 Jan 2025 14:19:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcceb374sm151415725e9.0.2025.01.12.14.19.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 23/49] hw/misc/vmcoreinfo: Convert to three-phase reset
 interface
Date: Sun, 12 Jan 2025 23:16:59 +0100
Message-ID: <20250112221726.30206-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241219153857.57450-6-philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 145f13a65cf..b0145fa5044 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -26,9 +26,9 @@ static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
         && s->vmcoreinfo.guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
 }
 
-static void vmcoreinfo_reset(void *opaque)
+static void vmcoreinfo_reset_hold(Object *obj, ResetType type)
 {
-    VMCoreInfoState *s = opaque;
+    VMCoreInfoState *s = VMCOREINFO(obj);
 
     s->has_vmcoreinfo = false;
     memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
@@ -65,7 +65,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      * This device requires to register a global reset because it is
      * not plugged to a bus (which, as its QOM parent, would reset it).
      */
-    qemu_register_reset(vmcoreinfo_reset, s);
+    qemu_register_resettable(OBJECT(s));
     vmcoreinfo_state = s;
 }
 
@@ -86,11 +86,13 @@ static const VMStateDescription vmstate_vmcoreinfo = {
 static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_vmcoreinfo;
     dc->realize = vmcoreinfo_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    rc->phases.hold = vmcoreinfo_reset_hold;
 }
 
 static const TypeInfo vmcoreinfo_types[] = {
-- 
2.47.1


