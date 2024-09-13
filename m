Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C386AFA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80B-0002BZ-Dt; Fri, 13 Sep 2024 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp806-0001pg-Ah
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0007lw-CZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so13890125e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240457; x=1726845257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5LtIFwb4EJjl6i5CXZHnT4w36zG3BOUmf4n1MupDgOM=;
 b=c8ayvrHrS4mi/7tzbQl+KSw+8W/t8e4Rrpp7+UpWJvSneAN1p9cFdrMqCIvrxC3sFw
 Dx9TQcvj0Kp8BwhZBOR7XZWeklp7kq70mXH5BGT3U9BTL8gNFW3rLVqEM3hIyMIYpmva
 drufzTwrCLMJnGBjhbeAOnPP/nzhmYSrQhQJ52emkk+zgvEo3IpGqYYvFpp8oDGO1JmH
 JRDKRuoCDIWq8Gk6UTiy5f+rxO7UehT1nmbEVj1Fp7w6VKIC9sa537ZUEOpTu7lEy4/O
 XDhbIAFyVCyTMG2kpjB9uak76TNLP/NyHq009VsMtK+GOYDUmzs9e/VBxJqGg/p3OEGh
 /p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240457; x=1726845257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LtIFwb4EJjl6i5CXZHnT4w36zG3BOUmf4n1MupDgOM=;
 b=e2FrOkfN2FQ2bEus4PDJfEiae8bqfZpldSRFKlBxzGN97wkL3Kd7Nl8fBTX8RaDb6j
 HbqPIs7jA+0YHlXLHggjcwVucMnIDjZlLW1AqQXBwfUNKotXBJKMx9zvvH9JnEA0RwNy
 ybn7U7aHpXY/HXGag+xGyeUe2+AtyBchNHGSbXdFDdIKQLnZVe5s0FXJxCwyET74bjyo
 HtesdJnRlZ4cnIcBnF6ocqryg8UUfVQxDQZUjMsSASb8M1i+nn5v4sbmj8+61V7YgOai
 +8LPI5E4Phyi4XfRWxC7EDibOtckdJfT++sq7q2Hz1EaVbUCVpIAW1tniqZYmFH6pqXt
 0kZg==
X-Gm-Message-State: AOJu0YybAl2Gl68zPBmSy8wnMbnawKt1HzIy1so9OVWISupfsiPGLFdr
 jVdayCjZNIJY1U7qoADQxxw7cEPOqxezjXsySsK8kSybL+CdJL+ed2fGJ0F0hBKxhkuvro26gp4
 m
X-Google-Smtp-Source: AGHT+IH53Qc+EcykCXe8p4ZyJ8gqAJUGZOJuGzwg9AgqMzQ2L9gkGgdTXNM/lc+KkVdC+Lbrqmt12w==
X-Received: by 2002:a05:600c:548f:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42d9072054fmr30083245e9.8.1726240457488; 
 Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/27] hw: Rename DeviceClass::reset field to legacy_reset
Date: Fri, 13 Sep 2024 16:13:52 +0100
Message-Id: <20240913151411.2167922-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Rename the DeviceClass::reset field to legacy_reset; this is helpful
both in flagging up that it's best not used in new code and in
making it easy to search for where it's being used still.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240830145812.1967042-9-peter.maydell@linaro.org
---
 include/hw/qdev-core.h | 4 ++--
 hw/core/qdev.c         | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ade85c31e05..aa97c34a4be 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -152,14 +152,14 @@ struct DeviceClass {
 
     /* callbacks */
     /**
-     * @reset: deprecated device reset method pointer
+     * @legacy_reset: deprecated device reset method pointer
      *
      * Modern code should use the ResettableClass interface to
      * implement a multi-phase reset.
      *
      * TODO: remove once every reset callback is unused
      */
-    DeviceReset reset;
+    DeviceReset legacy_reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 17423a9f573..460114609b0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -776,8 +776,8 @@ static void device_transitional_reset(Object *obj)
      * devices) or a device's specific method for not-yet transitioned devices.
      * In both case, it does not reset children.
      */
-    if (dc->reset) {
-        dc->reset(DEVICE(obj));
+    if (dc->legacy_reset) {
+        dc->legacy_reset(DEVICE(obj));
     }
 }
 
@@ -788,7 +788,7 @@ static void device_transitional_reset(Object *obj)
 static ResettableTrFunction device_get_transitional_reset(Object *obj)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(obj);
-    if (dc->reset != device_phases_reset) {
+    if (dc->legacy_reset != device_phases_reset) {
         /*
          * dc->reset has been overridden by a subclass,
          * the device is not ready for multi phase yet.
@@ -846,7 +846,7 @@ static void device_class_init(ObjectClass *class, void *data)
 
 void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
 {
-    dc->reset = dev_reset;
+    dc->legacy_reset = dev_reset;
 }
 
 void device_class_set_parent_realize(DeviceClass *dc,
-- 
2.34.1


