Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C1DE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28y-0007Iz-N0; Sun, 15 Dec 2024 22:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28v-0007HP-Nz
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:37 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28u-0005zU-CF
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:37 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f31b3db5ecso1532965eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321095; x=1734925895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8juOusyYDwgDek08M8B/UbOOdf1Iwz3qnbDYJf9UoPA=;
 b=VJaf/xXNFHr7k2QGBNV+42aadxN+xl5cHOSDCt937ivDWPXZ01/waivFBfIYz0wA1a
 1y0eGj1nIA/e55itQdi799zrIngrgTOaTDQYyZ9KKZJnJUNJNlOQEjFtgD/KKG/3fWNA
 0VUqQEYgdEFDFBkVSzAtDAHZ410x7NPEFsuMCEcYd5O2zkH7scBCuUgaOPpY8UcZdbhu
 fhuPoodIERZPSlWuLIBUpCqeNIGxOLfAouX85u4dSjIAEI98/BVvcMs3fxHUhHkuKjPc
 zQPWcD86hxizFhKxUR0vOSQ4xFit4abM7AuhX8Mm4XsRM3iuPSwjT5qds0/rdJayb3KD
 asOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321095; x=1734925895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8juOusyYDwgDek08M8B/UbOOdf1Iwz3qnbDYJf9UoPA=;
 b=MA6KdZo9noCZIPLbFwyy19R3s5laROtjJRPWFVNX5kWAzcoPbNsw4zchpDy60YlC0m
 CE12wvhueF3obS+RRTg1mcf60vzYLBl/Un13Dm80obOdT50pS8CaxNhG5F+o81UXiN6W
 5CG1rctQYjdO6uJq+TqqUTNm3Pt/eYg9uFWnsD7gyid9GAEh+pOIZcqNklgHMsM1qfxL
 AZsgnOsoAGKinj7EqD27XFf641FfD4jxuKcHBR5XUxKTMHXzi9h6B/UpmzeRH4X3SD4T
 TgDFuqm95cufmOyoE9R3eW/4k60WCHyOI4TdXZ1LYmQbuNCcJz8HNH0bHGrcEig9twrM
 HZJw==
X-Gm-Message-State: AOJu0YwZCDm+PB4DUuC8wJvta9DBfxxvgunyaY7e4kV6wDhQ4YNdSps+
 UWgdhxYGXvqJjKAky6FZFoRFLJtG77RrVnbhz/T8EHzCDbjr4nmzLx669CcqZbykfxNJmbWRZRQ
 7P96gAh1h
X-Gm-Gg: ASbGncsOE/IDlaVbkvNhHUjkwuEu8IrI3PMGqa0rOLVrIUQSrt2YNW+ElmdJSdmwN+z
 KX206eBfjBU2415MSJtFNJ3nQblCk1s8qZIn05vL8RUhhVa0VoJthn9XZ7jOOWjMwS/jBe2ND3r
 StJRc2/k4VATlsAJFCOKwG0VnRfwIoRaCSguKJvD45sxxUNuZrLRXeJHAWGvxgXdBreKqiM+X3k
 gR47t6+5GLV28BGqiwAFNfAJ3fkE5XsSk2GV5l62kiEX1xFVD6wSIFn0EX6iSwdRnVChhRUZHfS
 +B6RyqIswQ6hSYViT0WmlAL/ZD2ATUTisStOYd9B+FQ=
X-Google-Smtp-Source: AGHT+IF/wjW46Il+03hdrFjzx/y3XttmJXmPuZlplnEEMWjDbeVNk1fjMH0XI4hQp06ncMQST7uLkg==
X-Received: by 2002:a05:6820:1b93:b0:5f2:e72c:ce55 with SMTP id
 006d021491bc7-5f3292b4282mr6102219eaf.1.1734321095295; 
 Sun, 15 Dec 2024 19:51:35 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/24] hw/xen: Remove empty Property lists
Date: Sun, 15 Dec 2024 21:50:54 -0600
Message-ID: <20241216035109.3486070-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

There is no point in registering no properties.
Remove xen_sysdev_class_init entirely, as it did nothing else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/xen/xen-legacy-backend.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index e8e1ee4f7d..118c571b3a 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -635,15 +635,10 @@ int xen_be_bind_evtchn(struct XenLegacyDevice *xendev)
 }
 
 
-static Property xendev_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void xendev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, xendev_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     /* xen-backend devices can be plugged/unplugged dynamically */
     dc->user_creatable = true;
@@ -674,22 +669,10 @@ static const TypeInfo xensysbus_info = {
     }
 };
 
-static Property xen_sysdev_properties[] = {
-    {/* end of property list */},
-};
-
-static void xen_sysdev_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    device_class_set_props(dc, xen_sysdev_properties);
-}
-
 static const TypeInfo xensysdev_info = {
     .name          = TYPE_XENSYSDEV,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SysBusDevice),
-    .class_init    = xen_sysdev_class_init,
 };
 
 static void xenbe_register_types(void)
-- 
2.43.0


