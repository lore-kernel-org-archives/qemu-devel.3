Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C799E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFf-0001qg-5N; Thu, 19 Dec 2024 11:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcM-0004WT-17
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:14 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcJ-0004QG-Hb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:13 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso9311835e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622747; x=1735227547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVQZDG1ZHCW9mRIskC0RqnL4zCyCfhO/N0NweSAMjGE=;
 b=Y4ZfcXTetdNH6WatVKekB018rKG+7CF0Yjj4uL1UgXEDHITsm6D2a8LWPvCbpOQmBu
 1R33jTnjMuQLhA1p1YTRKjVmjs6Q9XoTUBTTRA0/3JfjloBubh0ivwENj0gnZTjbK9aN
 KePPgQXMACpcGRN7ARK4COwUo344wyl708ete5ftQRhxEsrqx4hRNBIou8cDjHRMNuRH
 X4uF1TTnGbETe944Q3doBjg1OXKGtflOocIuLnS8K0OzPJCXnwfH+wLrtt/0m64Anajq
 qFIM5t/Bg1HH6jbC7K+Nyo4MG0P8p/HDQ56MOBcjo7qtB1zKhigjbdXlfcQjU1t0oJFn
 vebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622747; x=1735227547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVQZDG1ZHCW9mRIskC0RqnL4zCyCfhO/N0NweSAMjGE=;
 b=LlLzjsv1QpgziADdkHoeZaHpH/8+WPXblaAmtHrQVdwOBrmrx+xB+YW1GyEdbkzj3m
 JTdUuxgfYC0+e7MlyrHTuFj3SK8rkYnImTVjgOC9fipfh++yfo3ypQn4WW5ELCAZdRAP
 S/HW+qMj77LGYgehdFj9J15zEtrR2adT76MMtV/Y/bLLG2OopZVWxQtjhuCOSq6I5vj2
 8jqAg2RVLxAmFKG9nKUnA28Rcy7EksKhcflFH4mig2baMVNzexdhHGO7NhqsQc7yJIuw
 DP7kJbMU1UsqHUfVXaR61tUNRKcYm3OjS4Bl7Wcu0rgHDzHJlXsjzeNn/Nj9c1FtEbcO
 vhBw==
X-Gm-Message-State: AOJu0YyR4tbT4j3XOd9z+dpaZya2O0pcA52xTPdPchMriDP7ncUw25ep
 ly/CuK11ct2yAcIPc3OduZslUi0hnekpy4COKgB4XCDGuY2ZpRkEaeWIgqkzhc3bs1nYedkYLRw
 5
X-Gm-Gg: ASbGncuULhf6/If4gseNm7eyBZ15ZG8JKjFGIxWZ/OjUs4geDH4Ch/a2mbLugcHeM2a
 GDEqmZrMQdIIV6kpuQJqDrcFBvY+ed9VgWvdXtC6s3k/saslA2w72Mf8wy+gyyQKRTF2IJlZ3IO
 AiM/fMYjEF8ziujYXrPI8SoGzE7YMmPBW+s9qnCZo2Rk8wP5XT+x1JDwBlu6NB3SjAA70mqVlf5
 LbcVzLdKUBxbF1DThzfuwY3jvMmUTapukmiTLCXI6HIWZLumIMn1I5/m6BrxZ2qx7b+Yuvkke5Z
 Hyfl
X-Google-Smtp-Source: AGHT+IE0ik88WSPrybKNxmPFssnUymLVzqFaMef4QHNfzZMSCJWXCCcqZjlj8Xe8OiJCq3TvE9ux7Q==
X-Received: by 2002:a05:600c:4587:b0:435:fa90:f19f with SMTP id
 5b1f17b1804b1-4365535b6eemr72094315e9.12.1734622747207; 
 Thu, 19 Dec 2024 07:39:07 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4471bsm55020455e9.44.2024.12.19.07.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 01/10] hw/misc/vmcoreinfo: Declare QOM type using
 DEFINE_TYPES macro
Date: Thu, 19 Dec 2024 16:38:48 +0100
Message-ID: <20241219153857.57450-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 833773ade52..84b211e9117 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -93,16 +93,13 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static const TypeInfo vmcoreinfo_device_info = {
-    .name          = VMCOREINFO_DEVICE,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(VMCoreInfoState),
-    .class_init    = vmcoreinfo_device_class_init,
+static const TypeInfo vmcoreinfo_types[] = {
+    {
+        .name           = VMCOREINFO_DEVICE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(VMCoreInfoState),
+        .class_init     = vmcoreinfo_device_class_init,
+    }
 };
 
-static void vmcoreinfo_register_types(void)
-{
-    type_register_static(&vmcoreinfo_device_info);
-}
-
-type_init(vmcoreinfo_register_types)
+DEFINE_TYPES(vmcoreinfo_types)
-- 
2.47.1


