Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FE7C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtOV-00010p-9O; Tue, 30 Jan 2024 14:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOS-0000zK-MN
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:36 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtOR-0008VY-31
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:03:36 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f15762840so2382353a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641412; x=1707246212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWlZLNkviQ6+EOhMX+hVeP6Y5TmUtDE6y8FSkM9wd24=;
 b=XwsZiYGSpdGQn9pUfD+zXgF9ymC2HRfxDUPXrvPdqFEXNbeuDoMqmR7zkw132UCT8T
 KMbAFvt8EFNbC3Ab2oxc6TwHsnGkwwwvVp13TbFR3Sxl74TbTN79K1rZQZycJUjS8gfv
 /HWe5lnn4jMriSx11ePe5QZCoSvATpdIpOEzWl1IwIAT25/HLkkWIdLl5Z7bSR8YxTPo
 mkBmtjYxmK8elLWKErTDUSxpwnceRo5msABV7101+FmGBcW4zPNaESFb8PYIc7n1rFxK
 bjL7HYHSxpcCyx0SoWKjE1SYXW7n1lPhkkIKCkBBe23JnODniCKGAFBwKi5V83K1fvds
 kJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641412; x=1707246212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWlZLNkviQ6+EOhMX+hVeP6Y5TmUtDE6y8FSkM9wd24=;
 b=o9kdJtXTItJiR321Zj1fmmzIB4P3S2/d0p8q86toVx+4jQS9gsroXxpr8ZZRUdx+xA
 GrHgKiecptSUxTIVlo4AwKHrQXQmC8IN0wsKW6RbXQJCA2vxOxT1jZX3bEn8ep3crJ2Y
 UeJV4GIBXMfvvBfAO0ZIgyqseD3/+LoDle5UWf+MHWjvGDoNkYg5kFcCGkQxOk5dJegR
 irPElaGuUsMMOyunk32Nc1lhYclrscS5zwOso3ZM2w3fRUjpVIcia/vW6w/rH+bUd8Kz
 Ob4MB2Qc0IirRsTjhrBzTITv8otFikfKaCiFTfV24H5bxnsJ8fPv+d1Xm0dsWCgZlwRM
 2TKg==
X-Gm-Message-State: AOJu0YzV8WK1+cUShC6kpnvUVj1x/6OPxloEam6AEEcXLw+Z5cZUP+Ah
 gfO1VLgl7qrta0uM2R7ADwgiSqySBujjyRDi541QqmhcCShG5zQ27W3JhmrTgaRKseCq7dkJWyz
 i
X-Google-Smtp-Source: AGHT+IE91C5XwVSrofmU0p7Nh4M1BfcbKXSyQSIFzQ+z+mwTTgA5tWdbww5/p9vF6bwxOiZUC4x42Q==
X-Received: by 2002:a05:6402:348c:b0:55e:f37f:7fc5 with SMTP id
 v12-20020a056402348c00b0055ef37f7fc5mr5533517edc.14.1706641412509; 
 Tue, 30 Jan 2024 11:03:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a056402428900b0055d333a0584sm5111597edc.72.2024.01.30.11.03.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 11:03:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/arm/stellaris: Convert I2C controller to Resettable
 interface
Date: Tue, 30 Jan 2024 20:03:15 +0100
Message-ID: <20240130190317.25692-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240130190317.25692-1-philmd@linaro.org>
References: <20240130190317.25692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/arm/stellaris.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index afbc83f1e6..284b95005f 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -607,8 +607,11 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
     stellaris_i2c_update(s);
 }
 
-static void stellaris_i2c_reset(stellaris_i2c_state *s)
+static void stellaris_i2c_reset_exit(Object *obj)
 {
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
+
+    /* ??? For now we only implement the master interface.  */
     if (s->mcs & STELLARIS_I2C_MCS_BUSBSY)
         i2c_end_transfer(s->bus);
 
@@ -658,8 +661,6 @@ static void stellaris_i2c_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_i2c_ops, s,
                           "i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    /* ??? For now we only implement the master interface.  */
-    stellaris_i2c_reset(s);
 }
 
 /* Analogue to Digital Converter.  This is only partially implemented,
@@ -1382,7 +1383,9 @@ type_init(stellaris_machine_init)
 static void stellaris_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.exit = stellaris_i2c_reset_exit;
     dc->vmsd = &vmstate_stellaris_i2c;
 }
 
-- 
2.41.0


