Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79923F47CD6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFjX-0003VX-C6; Thu, 05 Mar 2026 15:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjJ-0003Po-NS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:34 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjG-0006g1-VN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:33 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-829756f3ee9so2100168b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744128; x=1773348928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAo6ofbgTbHTQLqhku7tbhHK2r8k4onc7bjEitYzIus=;
 b=eEJ6lrqvaWDexAf+MkjdOpwWITxr9qGWvmFivvipYtWt8SlQAbKxpKPmYxF0a1Kvaf
 ru+gikDg21xnXPQ2J0996qqbYWnQTpJuprRLj89BBs7vjGl7GfXhE5gjZc+gx5enPbz1
 s1SoTdn5UXhn7nxmmwcVAoEHJEdYDMiv3z4Kpso8kkAM+tyUja0hrsTsyKvum2Mb+m5Q
 n1chEAF3zmhW7EWaGUXkmrHqrlc7yyDJC9UmO3WxWo2jkxjiVDg0s8Tv4p/meTBTGPf1
 MNZiGVaZZYAYAMgRMKYPA0xN+m1HJ9kCVkVTQa9cwgPI/pOO//vqTyF2eI+Cyz0qdljy
 9Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744128; x=1773348928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAo6ofbgTbHTQLqhku7tbhHK2r8k4onc7bjEitYzIus=;
 b=nQTHt+st9jyC6P/z6DYTE172hu5+RjKxhp9w/WRTGHAOc4y8+4JwRUepWGPnTPFO2i
 sSFLYUZWL0pqwMKn2KZk1XbHZLse9+ybnWflIesRvaGmIIC7bfqr6QeiQLSlt1ZPbNNg
 s0b/XpSmUmnB7AsJNp0v5Ac+oGg3OL+h1c6Eao/mCEx8Ezs4U9Uq+Z4M5w0aFHCqia0q
 vt7FQUizJlxK/V3Dm86UkGH1ze+ykPVcOSCYrP4Lm3OisiTOCujjWmA5GqAiRtML8v4S
 O6EfJ+o4G4gsVJabe2wNL+u4gbG43n5X6/DkT+loJB84fJwS9IVBZrh+nYYumeZIbeZo
 EkzA==
X-Gm-Message-State: AOJu0YxG8Qmbcr4529nQzW0c70ZgOlK+syCOivBBrJyBzOBguz1L6vMH
 ovxmcurgmEj1dqZyCvsOWIeP9CoJNtYGs7RwkqxV6EIIN1JHGVYHEmcp1q4Epba3XQuIXVhmaoe
 vcIqL
X-Gm-Gg: ATEYQzxO/GZG8tRfpluTslKgQFKjzsh3BvRYSo2HYwT+2vr99sAt/Z4P57OJ9Wtgk2T
 yJhSeQT2kdeP/0CNnmTZz6OXjZupf7SoFA0m0AVtEgUivMATVHRXZ3UPtO8xoz0JGWe1V54Q+CB
 yfzZQFnsHalhoA0Dpsu+anCEvLSS8VXgBfqaE0clcOy4mnaBIZqsMXwkag/m2XyrYYOJYV6hJe2
 QvUI64l3ZaxJGjxZd/sqxmCsTnPiGFjDjGBlIoL98tS3ICe60I8/PuYhFORau31HeDdcEXVLW8J
 BXZDCjBNakXFO+pjmJHUQ35qqbR45J/2pZuhT1NvvQShGCjMfHY7TNA/9FuB9HH7aZI/gAbicIY
 NJ75YjjZmcl0erHDoFZeKRl1KJSstUAMCTBhVV04R5qjleExGPm5LyBpOEsCCw42KbhVpwNS9nS
 5HJvAHlImt1eELDp8w7oUR3I2DwAlkFiMsq0WJYiUcMPN38X6qvf7RZM0FPG36kw48ilBE1/aBm
 Jqw
X-Received: by 2002:a05:6a00:2184:b0:827:2f06:87af with SMTP id
 d2e1a72fcca58-82972d4b197mr5770882b3a.64.1772744127836; 
 Thu, 05 Mar 2026 12:55:27 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e4fbbd4sm3847454b3a.53.2026.03.05.12.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:55:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/6] hw/virtio: Simplify virtio_access_is_big_endian()
Date: Thu,  5 Mar 2026 12:55:16 -0800
Message-ID: <20260305205520.2125218-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
References: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Thanks to previous refactoring, we can see more easily it is strictly
equivalent to always call virtio_vdev_is_big_endian.

static inline bool virtio_vdev_is_big_endian(VirtIODevice *vdev)
{
    if (virtio_vdev_is_legacy(vdev)) {
        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
    }
    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
    return false;
}

The key is to understand that vdev->device_endian is initialized as
expected. It always contains cpu endianness, and not
device endianness, ignoring if device is legacy or not.

By default, it's initialized to vdev->device_endian =
virtio_default_endian(), which matches target default endianness.
Then, on virtio_reset, it will be initialized with current_cpu
endianness (if there is one current_cpu).

void virtio_reset() {
    ...
    if (current_cpu) {
        /* Guest initiated reset */
        vdev->device_endian = virtio_current_cpu_endian();
    } else {
        /* System reset */
        vdev->device_endian = virtio_default_endian();
    }

Now, we can see how existing virtio_access_is_big_endian is equivalent
to virtio_vdev_is_big_endian. Let's break the existing function in its 3
variants, and compare that to virtio_vdev_is_big_endian.

static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
- #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
    return virtio_vdev_is_big_endian(vdev);
  This is the exact replacement we did, so equivalent.
- #elif TARGET_BIG_ENDIAN
    if (!virtio_vdev_is_legacy(vdev)) {
        return false;
    }
    return true;

  we know target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG.
  if (virtio_vdev_is_legacy(vdev)) {
      return VIRTIO_DEVICE_ENDIAN_BIG == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  It's written in opposite style compared to existing code (if legacy vs
  if modern), but it's strictly equivalent.
- #else
    return false;
  we know !target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE.
  if virtio_vdev_is_legacy(vdev) {
    return VIRTIO_DEVICE_ENDIAN_LITTLE == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  So it always return false, as expected.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-3-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index b8aa7a520f5..e3148c23881 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -21,23 +21,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_vdev_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (!virtio_vdev_is_legacy(vdev)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.47.3


