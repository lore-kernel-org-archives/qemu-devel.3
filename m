Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7116DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKz-0001tM-LG; Wed, 18 Dec 2024 08:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKg-0001QH-AD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKd-0005hk-V5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:21 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eba347aa6fso3483028b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529399; x=1735134199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3IR2BqpFJt9aWmYFdrw1drrXTVRXnm5WkItRBYentE=;
 b=rX0GlPMoqa+NUnZGJhUamwsKRuKb4p9IAskQfsVyucmTTN8rDSs1O2+hCZPp+jcHBi
 +oQlE2s+Qd+k5ZA+3ekluHu5fxovEyKPMN0YtQnzWYSGbwR4MmCcXIRWIYPzA5nayANA
 NswZa5ItpCuuqMVfyu1L2qZ6efh6qkjVsoGfPlyuzHb4bPipQpVRr7INBc6PiXN6Gt5A
 kQy3CxLsrc55rG2UEaGbG9MaRYjijdS6QXy2+qljtTf7fBiIaStGaLw66uibfCpx/EYO
 uUhmkAyx49dyxqjy5mnvQhmFaI0Ux71I8/kH+IJXm8VSmTN5CpGgnpFlI/EMtKGkYuLq
 IwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529399; x=1735134199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3IR2BqpFJt9aWmYFdrw1drrXTVRXnm5WkItRBYentE=;
 b=NO0FpzGAJGwNbKNPzZPxWoKpkGhpc+RkeQMZIkyCuMRUtX1V7wkteiqJ00GOvTtDNC
 7dTCCM/5IrJ9lv7dFFM6ozSeXwMkX8ZbX47zPgAoB+sq9w2s/uYfD+m5wGo35kKe6JGd
 Cr9VzrIaafjUDrbjgrDldMaPk+eoneXvet9/f/5ZOxcA8FquKFIVw/DU3JDxhkYDxQKk
 tXXM6MySxF6GMzjT+x5rRe1OE8Ak1kuHDM+9RP1x7R1lekpTqA9wPEMH7d66vZ306MkO
 aLXHPhB5FOflxtvpzAXbpfvZ4xWSMZ3itjpf6XImGBVT9t0fsDRkhUyy/RSlrawN1/tA
 RvlQ==
X-Gm-Message-State: AOJu0YzoQuNrIDzrFJoIxhzzsPzAOCE24uJ/KtsP98pJp63slqbgieYU
 AOdgqrBi+JImxPTPEMa0Hk1kdK+UJMfH2bOVAI+l+03huD+t6ULs/8xXA4Cq27CrRSQ+WElR6F7
 KdeL8S4wN
X-Gm-Gg: ASbGnctQWt1zP5j5L4v44x+XB0K8QFeA6NLqotTLwSs8KFM9s1edGw6HgA8vENgzqwl
 5ioLJrv6VyZdvgj6y94oE5rt6K256VLfMrOH5f7q96ug4Q3/Mu2JIEomBUpuYWAF501l0+Rhggq
 Yan9aSyjSP5+6te5Se6kYEQ5ftsDvUpHNSZkK0+HQ78x02/bw06N5fP9b7gPXt9iP2O0ohos/Mi
 s04NJKgd9m4u7xhA8jz570VhMkNfqMY0smnp8FLg642iG1NA0fV8fAxgia2k9n8
X-Google-Smtp-Source: AGHT+IHYuSQ6mfZcE4QD9IXpiiu0UyT6xaxrze2ZXBBYMQSsDHBThrT57oWPQw9eCEKIZW1gmYMTPw==
X-Received: by 2002:a05:6808:1a02:b0:3ea:66c3:d066 with SMTP id
 5614622812f47-3eccbf2e273mr1678231b6e.7.1734529398744; 
 Wed, 18 Dec 2024 05:43:18 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 18/24] hw/core: Remove device_class_set_props function
Date: Wed, 18 Dec 2024 07:42:45 -0600
Message-ID: <20241218134251.4724-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

All uses of device_class_set_props() are now using arrays.
Validate this compile-time in the device_class_set_props macro and
call device_class_set_props_n using the known size of the array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h    | 16 ++++++----------
 hw/core/qdev-properties.c | 16 ----------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e9b4891f55..fc13623d43 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -948,22 +948,18 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  * To modify an inherited property you need to use????
  *
  * Validate that @props has at least one Property plus the terminator.
+ * Validate that @props is an array via ARRAY_SIZE.
  * Validate that the array is terminated at compile-time (with -O2),
  * which requires the array to be const.
  */
-void device_class_set_props(DeviceClass *dc, const Property *props);
-
 #define device_class_set_props(dc, props) \
     do {                                                                \
-        QEMU_BUILD_BUG_ON(sizeof(props) != sizeof(const Property *) &&  \
-                          sizeof(props) < 2 * sizeof(Property));        \
-        if (sizeof(props) != sizeof(const Property *)) {                \
-            size_t props_count_ = sizeof(props) / sizeof(Property) - 1; \
-            if ((props)[props_count_].name != NULL) {                   \
-                qemu_build_not_reached();                               \
-            }                                                           \
+        QEMU_BUILD_BUG_ON(sizeof(props) == 0);                          \
+        size_t props_count_ = ARRAY_SIZE(props) - 1;                    \
+        if ((props)[props_count_].name != NULL) {                       \
+            qemu_build_not_reached();                                   \
         }                                                               \
-        (device_class_set_props)((dc), (props));                        \
+        device_class_set_props_n((dc), (props), props_count_);          \
     } while (0)
 
 /**
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 31e3072b55..a3d49e2020 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1058,22 +1058,6 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
         NULL, NULL, (Property *)prop);
 }
 
-void (device_class_set_props)(DeviceClass *dc, const Property *props)
-{
-    const Property *prop;
-    size_t n;
-
-    dc->props_ = props;
-    for (prop = props, n = 0; prop && prop->name; prop++, n++) {
-        qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop->name, prop);
-    }
-
-    /* We used a hole in DeviceClass because that's still a lot. */
-    assert(n <= UINT16_MAX);
-    dc->props_count_ = n;
-}
-
 void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
 {
     /* We used a hole in DeviceClass because that's still a lot. */
-- 
2.43.0


