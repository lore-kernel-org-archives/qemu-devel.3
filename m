Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46446D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2B-0008Jk-Hu; Thu, 02 Apr 2026 17:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q28-0008IL-O3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:00 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q27-00075p-C9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:00 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b941762394aso180963366b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167018; x=1775771818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX6XlP9jfOn4IIWrQN3XN3SqDJFysVZcAsWU0gp3e3g=;
 b=jn8lYkDEGpQVjb4BhDOQk1BEykjYE0b0IpAv2Eb9GfyckDy+EbYGzFUmMEnhgMj+lf
 Bk3YfQYKd2k7W/QCsg6IxTAVGXE9fsZp1mNk34iG5F/GNvQcdkzPuH1X+4MpZfF9nJd0
 HJGjjTnMq3dfP3Jv8P5Q67he/qQThfjFCJG6KeEi/H+rgEmrc1Nim7Ej5Q0kD0UcsVls
 Z7UAg3S8ZucjfDY+4e0FcKGg8IzqjlAh/k4l29hfeH6MaM3TkNX2rBTRnX/bbHEBtEuS
 XkgYQNzQQwCaE/VSZOLOa68XG3k37FqNeI+rK53421MLR1rn8WlOFFWnDQE0ciB+39q0
 V/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167018; x=1775771818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QX6XlP9jfOn4IIWrQN3XN3SqDJFysVZcAsWU0gp3e3g=;
 b=m9EQ+x/pnDeIy0F0B47UIk/xFG2S2FWs5W6NWJ8tjBt16fKUV5n4zbK3EmNmJf5xvY
 iJt2s33KTvS19BMIAPFwKO4hZeal2AuLBxlfM0XBgISAhVfKPd4LiWcxsi7zxk3x/egx
 VNVsOsJY1jwxqjpPZEMKK9bUcasA6ZsQpjuTYKEVTfndBoRAkKakAUiMQKiyhnLvEbjD
 BMnpxTflkKoDeKgoXEicrAgMmEt4fY9ttOg3ZpWfF57g3FKadfullVqD19c4dDEfSDCU
 z6NOeA9/qKVXCk0g1y85HL/0EcO3WjvSbCx7eUVMsKDaCYS1NGj0lfShfH6EHG1QTIdy
 Caxg==
X-Gm-Message-State: AOJu0YxPbHd+8TOlxlciRZ96/NC71cCkX9CCi7PFqVP3QUM/vgbJkzXl
 5A/N53Jsp6f3J2t11Qbbihzq4ItQK+rdXEJoY8eGFUNB84PU3XReJyLh6cfl7bxz
X-Gm-Gg: ATEYQzzfvmrv4A6SX8LFjaZ6nXlfZ+ZEtUmsAAeI8F/xkG33k28RCrQW6kR3GJpjAr1
 alIqNQ26gdlBTbGjUgRzEtgKuMqF4v7gAchjUggozDWCLi0oJfCpbAVTDMV3xhtDIQXOxOph9b4
 n55B0GrYEHlOsfHeUh2U6xH1RnluAINx03n8Bi4b1V1D3/80f3YxPEUaPSvvgsXnxjLLvc2Ujrd
 l0tiVZ0x/C28Rn0mmi43fRKdROTXdTLzkaVi0ePntGgu4c/Y4svHjBBeaU4QHHKhjcqIWVGSjJg
 O4z1y+LVbekiAX5Znw1+/GmDed2zu7b4HegvtmpX8JwVln3k0rr4x3TOWeHM62UuOHzx/nMTDjJ
 tGKBixPTEi49TwNUBuNJX33WLlCrlCyBp55V2CnUpHZ/xVLDGHHWAovUcVGOmqs73vKpt5DQc2x
 CiNh39+YDfzf4Jgj7TM8M2M39WMYS/j1iYZFc9pR8cQFBxjMliamIyzvJYjDKMN+6F0ncwzQ==
X-Received: by 2002:a17:907:989:b0:b9b:fa57:d5ab with SMTP id
 a640c23a62f3a-b9c679de26bmr24941666b.43.1775167017509; 
 Thu, 02 Apr 2026 14:56:57 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:56 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/33] qdev: Add qdev_prop_get_array_elem_type() helper
Date: Thu,  2 Apr 2026 23:55:54 +0200
Message-ID: <20260402215629.745866-10-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add a helper function to retrieve the element type of a qdev
array property.

This is required to initialize objects from a HW device tree,
as neither device tree properties nor object's property array
reveal underlying property type.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/qdev-properties.c         | 12 ++++++++++++
 include/hw/core/qdev-properties.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a4..f92ccc35d8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -950,6 +950,18 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
     qobject_unref(values);
 }
 
+const char *qdev_prop_get_array_elem_type(DeviceState *dev, const char *name)
+{
+    const Property *prop;
+
+    prop = qdev_prop_find(dev, name);
+    if (!prop || prop->info != &qdev_prop_array) {
+        return NULL;
+    }
+
+    return prop->arrayinfo->type;
+}
+
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65..19fed85248 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -218,6 +218,7 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
+const char *qdev_prop_get_array_elem_type(DeviceState *dev, const char *name);
 
 void *object_field_prop_ptr(Object *obj, const Property *prop);
 
-- 
2.43.0


