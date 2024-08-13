Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05498C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdule-0005CH-UU; Tue, 13 Aug 2024 12:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulc-00052y-NC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:04 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulZ-0001DH-Bc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:04 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso5031696e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567979; x=1724172779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbuGjkgyehrKRg++JJDPnnhdoejStX1mjTrcCdzw1x4=;
 b=qTeV2jV8jiP7ntyDorq4QFFGVBL5aFr74PkY87nKrquUY/LMZvGCP5k6da2N+6CPBH
 6YFO2wpry4OeSTjDbo74Y1cBZDuER/GxfNtipNCNbVIg2IIm9d76SUmH866R3/cOvNNK
 unBDw/dtW65VtS6V1P7w/Z0RpkTMfGM8dFn/vWcEAXpWjjPbJzq+x6uZw8kDj4cqTY8j
 1fcj8F5ptFozQ9J/onoHJ655mf+BMZv7/d/j/TL9cxtvv3bkEnek7rvMFqI/b94TJmcS
 xHHpEcX/52/kmf/ojo4T861PYfjKlsutI2doWCBQeofc92DAmQTAXQ4g/4SmKXeUxuad
 B9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567979; x=1724172779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbuGjkgyehrKRg++JJDPnnhdoejStX1mjTrcCdzw1x4=;
 b=fdzGKVzMFXcGtdBhQu6fOlJSmA9vnkzDnGVEDad7A3TCF0Tku3/wZ1RJxWhqta3jgG
 JDBRhnqLogVUIebOVLCr0RQps9y7O1raFIaCz4yfAfWG9Ew+oVy/7yd3mwZZrYbiXPfp
 aedL1Afddyqp5jVt3h8XEqC3Gxor269AW8KV8T+wI8O4G1g6IBe703NooyE7EC1AICt3
 NIpMs2AbsK+n3qpPff5VbtrauJtnVNnOz3aZLceSfCW5v0wTlLmeA8Locr6oSEjprYX8
 JDumTLeV153cTLE60/RnQMJjr5r/hFXKHe6JSQj9ZGGLGrFJX132Nu+R+evjAqvE656G
 vMBQ==
X-Gm-Message-State: AOJu0YwutuUso/4KO4FVoXN2ngD1+gIpHmt4RtBZakbcxd8p+jM1h0Iv
 6BiuG3fJacTXwEmfsm3UTX3vQS3ueLXnoicngieRfHM8bpAzNlVstOnZruw1pqDi+Jb/djC6al5
 X
X-Google-Smtp-Source: AGHT+IFsfWtNR1vB0SxrWCcPVCOu60AM0w0d9sBe1tF7RnnPWUyc+hqoaEmZBcnFPbvc70odGS+5FA==
X-Received: by 2002:a05:6512:acd:b0:52e:6d71:e8f1 with SMTP id
 2adb3069b0e04-53213694541mr2713673e87.53.1723567979282; 
 Tue, 13 Aug 2024 09:52:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 09/10] hw: Rename DeviceClass::reset field to
 legacy_reset
Date: Tue, 13 Aug 2024 17:52:49 +0100
Message-Id: <20240813165250.2717650-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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


