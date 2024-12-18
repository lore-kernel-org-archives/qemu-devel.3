Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA7E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKx-0001l5-K9; Wed, 18 Dec 2024 08:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKS-0001IZ-UI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:09 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKR-0005f2-Cs
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:08 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb8559b6b0so3467247b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529386; x=1735134186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8juOusyYDwgDek08M8B/UbOOdf1Iwz3qnbDYJf9UoPA=;
 b=FUZJNOLz1yK89kwwZ2S9V0ATVLDJfuHtlK7HoI/GPVZTUxT5vmf2T6uLRPCeh5LHlz
 8ppi/iPeQSVESQOIovVh25iX5MSAZCoHT/1q4ewEkYV7ZGVG1h8q9m3wDP5uoBACKXIt
 MI5QJMpnXyELBi3lMeSBJb2vSRbS8WcURd1ddKLgcOXSx/JQz6RBJ3CAdc0q0OyQ7YUZ
 0Ag0H7u8t8bbfoIy3OzZEpWeWgOy5MZ+M5Ob2T6BiypVGs4zDBDo6Gx7nQ1qM6aAvotJ
 TK9NEJw0yzY5Rc0ObDmWEOEQxhfxKdj88D+poV2qC3Tk2xlljojNvGwAbJbK0L+t1tPN
 8Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529386; x=1735134186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8juOusyYDwgDek08M8B/UbOOdf1Iwz3qnbDYJf9UoPA=;
 b=jGkc1E3vEnpiGH5OSiCshjUDOENjyP4XQjgyqOLc5iy4DxLEezYugKvJuR78tCxUQf
 /74qFJPm/v+yUkvJUfplQsneE+eoi0iOj0sdEZZl1jnF5YX/+ajbdOsiYPR/Wi6/H8yz
 OAWabo97oBjUnZbWDGX0GeoIqDU5jUA+bqTiSu/0zNO+t4BnTprlok+ZRLtGPEJRILxS
 P8zEy25J9qohHo/lnFpYbAY0La4iSLrxsRT6TCTtgOU7pYWtIDxChQq0bVU/yUC0wXQb
 kGoQBz4GZeYIhi5t4p8nRptErD24OQG1ZyUgLohwpoyD1G/rzmdPNsQCQKxk6Qrm42v5
 0sSA==
X-Gm-Message-State: AOJu0Yz70iDZdxmm9b1T7auKCI5rkQcqqbtsdD2CV62NB1GvxoJ9HObG
 spABTTn3who9uJLfku0/RAmLluNuEsJlooSAOHrZcpfg+pkSsmw7HXiAaOIOS3RK6j1r5CnMMdg
 zAIdtMc/J
X-Gm-Gg: ASbGncu369TIxoeW9pQeqiSH0CGwVaJr4kofMt7FiRgRjqsausrSAGhuwu63whP1f1L
 y79PnWu1ZCKUkRmNWA5wCkmz0+QIdH/+CCUkub78C+ecGC7sI31iUbivBN8ZHy2zvjZ7i4HNkIk
 Go6YVNDVEGShvPiNytoajmAEphokU+m/kbNVCP5uo4JKxzWef8yjz/CWZ4+tCQP3KhRMRavu1wX
 iS6MxBNlbNpHIFzHo3nkndLvHjFVp1xgEdOz6GVjRT+byWxy2DzEYuJMOJzAzxG
X-Google-Smtp-Source: AGHT+IE2mPW4A1nkNSPHwZ91fcCDPeJU1rLR3To0171pF5lI8bk7ApjCaG1zJYrv5SI9NcgQjyfTcA==
X-Received: by 2002:a05:6808:bc4:b0:3ea:aa8a:c115 with SMTP id
 5614622812f47-3eccbf93f8emr1818768b6e.21.1734529386361; 
 Wed, 18 Dec 2024 05:43:06 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 09/24] hw/xen: Remove empty Property lists
Date: Wed, 18 Dec 2024 07:42:36 -0600
Message-ID: <20241218134251.4724-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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


