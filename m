Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80646CA0FFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34z-00057l-DH; Fri, 30 Aug 2024 10:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34x-00051e-PI
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34v-0004bW-NV
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374ba78f192so152651f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029900; x=1725634700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02NYsaWjTE0HD7Iy06E7IV0uEshqvGP6CcKE1OqfJzs=;
 b=EJXsW5/fLNetpNqj0+rMIlPI1egMHZnAk/VUId8qQ0QjQ3ij7RBc8NWocKyBl3KJJf
 2ZLLLgRQSj9hj4GvoO6wpJi1FxCleMSkuuRC/XHmejF0RaXWjGyW5YwdXvD25gq01Ae2
 olDcBagR1ftLqVQycQMsniN6s1CMAZXdQFxFE1O/8H1wSv89tQ8pIYsepUJEmS8P+XfX
 kWktSu0ABM1T9S7WlKupDK3+hQnmCDUVhArn2b0kLvcLiN3HgPsLareCUZ7h4kwhPwom
 oZ20TpQ7X85oLcJhEYh6BJnR5lUjFerbl7LFKg0aukUhnHW6XDakhNZh1ZyvuJrGLCql
 LRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029900; x=1725634700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02NYsaWjTE0HD7Iy06E7IV0uEshqvGP6CcKE1OqfJzs=;
 b=KmNxWZ33na2MG7IRMNXg5rv3cBzjQQBkgEWmiKZNyhqvsCMZ7bMyh89ipZlM76chFd
 6WeD8B2a7pNqyyJq9uxBjQs9jRN1wzFssoLGSG/bGPJ4Z7L5uQHzhAK7fQqV8rmtYVHs
 Z7uYREXyAeJ2URJCNzB4c4m18HFBxxHuIOF9YRPRi/K2EK2zOtSORPhKicavOxareqkH
 8/nFNEXY9ZBncyHuhM18TzJApsyYXE+urnQdlZxNy0MWYyDM7OPLaN8B2PJ6OhlNdWUS
 WPeQaR+bo6wAnLkYkvuMxqhc7NWfSS6XncOVOu1SX/uO+S/ovQfrhqIv/vmYPP4xnFEw
 I+5w==
X-Gm-Message-State: AOJu0Yx1fu/D0NVYK8uAG2Zjg474RPFd1L2iB7uXYFIT3xzkRtwGWNkF
 9B/rpfhKu40V0cZnPx4Dc0PwxmjgOE7P8wk+TQVDWkHxwLBkUKyuZN/zX8DPUPrxgtI9jFUK7a0
 i
X-Google-Smtp-Source: AGHT+IH0nm6p4nYOTJ1Cegezssc0WjyQBaMUmun6HN1gj5OdeANZe57pxhhFhX8GQvc0utCY+bl7EQ==
X-Received: by 2002:a05:6000:402a:b0:368:37d5:3f2e with SMTP id
 ffacd0b85a97d-3749b54d465mr5537966f8f.32.1725029900053; 
 Fri, 30 Aug 2024 07:58:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 08/11] hw: Rename DeviceClass::reset field to legacy_reset
Date: Fri, 30 Aug 2024 15:58:09 +0100
Message-Id: <20240830145812.1967042-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Rename the DeviceClass::reset field to legacy_reset; this is helpful
both in flagging up that it's best not used in new code and in
making it easy to search for where it's being used still.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


