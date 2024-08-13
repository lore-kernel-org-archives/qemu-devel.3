Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741E6C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdula-0004s4-1r; Tue, 13 Aug 2024 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulY-0004lk-HX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:00 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulU-0001A0-KN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:00 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so7803293e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567975; x=1724172775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7A3MN73bYGjZFfhqDGwq3NUiDFR8CSYZavjpKOMJaE=;
 b=bBqn+fx3jQVEg8UUDXriMZGW8XSw786jFUWLD6BortEL8ThAi8r48V4kbtXMRU9iJh
 HjnnOQkHvwno54QxzxeXiXNOzP4LJFDcvW8vmhu14C9FQ20Q3ZJ6TtUZZ4cpFjuJh80u
 xHkoZkgS4KQRX3T0xmZfQzuRuUaDaOZyZvrIdbhezVU41Gfmlo0mmKK8VA7Ey7J8B+/4
 Ik0QtAvpq6xBLRBxtXBHj+V1TwoLo9P+qr8OWwvCA7nfDjAulxhxOEzWKEA7UJ6o1noD
 Sf3zfVoyCOuX8XQw4hW6c/FfMTnVzdo+Sa/Zjc2RdxEGKOvShNCgjUB6eDchUZrdo1Dp
 EO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567975; x=1724172775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7A3MN73bYGjZFfhqDGwq3NUiDFR8CSYZavjpKOMJaE=;
 b=BT6gmsdQrstNVacIHAoPz3GK12mwrdrZtFSXASPslS50b7vzF1Lbo+WSlF4F8Am5UY
 1tuCmVrLRldMlAjFARl5sw1Lt/QX/xo47d/dR4RDTaIbf7gqaFcAcoZbgxBGprwIQz29
 LTIlyBUtqs8xOnT77cVfsJ1BRYifoaMET1yfFGKg3SbjtSOMvo8DTxROXthWXzgVp0OS
 +6NZJToddka6q1xFeV5ZxnOf7mQQz0CwdnvDVkAMKqhpsjwUiwJOJa5Bw5m+3UPmXz7e
 0h1gmeecGHJifS95pNiF1vMrFzZF8bMI5h3I8SHOVHifjVvuY3muXbNPbJfDuglPLsjr
 MxcQ==
X-Gm-Message-State: AOJu0Ywvc8ASVAdVqHN1ugECU9wopvck1CJbedTsOcTzz2R8yCJW3ale
 qaBkP/9oieZQ79gY783PRdMai+HHWfNdq+uS5H2O7FaZM+jippDROIUCJ7LH+TUIKb+XuysEGK3
 i
X-Google-Smtp-Source: AGHT+IFvHD6ojIHhYZUCtX6k6//vt7oTFI+veoxJCxopKnlwN1Y6qvpIWZRwTNSLxMDF8AaLqQuELw==
X-Received: by 2002:a05:6512:282c:b0:530:c1fb:5192 with SMTP id
 2adb3069b0e04-532eda79a70mr3413e87.16.1723567974532; 
 Tue, 13 Aug 2024 09:52:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 03/10] hw: Remove device_class_set_parent_reset()
Date: Tue, 13 Aug 2024 17:52:43 +0100
Message-Id: <20240813165250.2717650-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

There are no callers of device_class_set_parent_reset() left in the tree,
as they've all been converted to use three-phase reset and the
corresponding resettable_class_set_parent_phases() function.
Remove device_class_set_parent_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h | 16 ----------------
 hw/core/qdev.c         |  8 --------
 2 files changed, 24 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 77bfcbdf732..18c7845ce9b 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -937,22 +937,6 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  */
 void device_class_set_props(DeviceClass *dc, Property *props);
 
-/**
- * device_class_set_parent_reset() - legacy set device reset handlers
- * @dc: device class
- * @dev_reset: function pointer to reset handler
- * @parent_reset: function pointer to parents reset handler
- *
- * Modern code should use the ResettableClass interface to
- * implement a multi-phase reset instead.
- *
- * TODO: remove the function when DeviceClass's reset method
- * is not used anymore.
- */
-void device_class_set_parent_reset(DeviceClass *dc,
-                                   DeviceReset dev_reset,
-                                   DeviceReset *parent_reset);
-
 /**
  * device_class_set_parent_realize() - set up for chaining realize fns
  * @dc: The device class
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57de..cf811580621 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -844,14 +844,6 @@ static void device_class_init(ObjectClass *class, void *data)
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
 
-void device_class_set_parent_reset(DeviceClass *dc,
-                                   DeviceReset dev_reset,
-                                   DeviceReset *parent_reset)
-{
-    *parent_reset = dc->reset;
-    dc->reset = dev_reset;
-}
-
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize)
-- 
2.34.1


