Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6001C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cB-00065a-Kl; Thu, 22 Feb 2024 07:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8c4-000629-LC
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bz-0004nf-U0
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:44 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4128cfb6b6fso2076755e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606538; x=1709211338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JspwhcdtiFe4E7MZg2XJDqNEWrT6NpNFHrvazz9D4TA=;
 b=yUMu3a29L2vgv4cUyyDs9KmC/hBnfCS2Orsr7vpoVMyk9pczuoIhTsB3ZePCykc7nD
 EDCjcL/ITudmpgV76u700Xl6m+kWhddLiJB9Pu168pDtWf8ZVmjsqY77sjplnzpp+AEW
 xjBz0AuFf5sgKw/HO2UMLSfdplJZRgVnawpI8fZetghiwDs5Xo3PZxi5ntJn2/GlE9EG
 MqXzRQjGI5SDaEvk6AzGqmak0mTEQLBWmVw9I7cUJnLv+NZSO4shL/xkniedc6cGJdry
 Ank2sA5Jcfp08O0+sANAkoLGZPYlOQBzpjdGeUDaKSQohugsokYEBHTfLZV2V4DROzLR
 rp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606538; x=1709211338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JspwhcdtiFe4E7MZg2XJDqNEWrT6NpNFHrvazz9D4TA=;
 b=c4e68F5rpYeunf/84BL92ura2ou/lVtcXO0ArXa6DiCwagrpbx9QsujzpxtF8PZlEl
 U8Ot2Ku8jzFP8cE4eOE1yVRM9s+0sbTCbTPSXxuq1AfUxhPiUpfusdZmdWjUD66dcJdW
 feoqNuhtlS+XLwPmchk9TY7S7rJdbbJ3Fc4QooIROI81fpuprZCA4RYwOFeSAJ/uEinW
 NSOFVAEeqJC1CLtIS+eht95yPpghakcGIzTxvfSlsbJeGwQNp4RyAAShJzvrW5pqoQbp
 g0HMQQBlinQZ5g0WsDkBsnK5Ttgee3hLP80y1pcl4ab6xS0RJcR+khjEbpoZV2fmLYFb
 Q1BA==
X-Gm-Message-State: AOJu0Yx1JdUGY2g9eBbk7SP71BufRyz5KzT79p6EDBWQdlqh/4I2+utZ
 OC2cFNjFX1sfta+kE1G1Glz2s6yc9zwfhBVEp9/B1zmWky/9OjEFvmJHFdw+9LRrjS9dqizeDTn
 RExE=
X-Google-Smtp-Source: AGHT+IEKlM4zI2IURRXtXlj0Y48h/pfzwUaTW6uAQaT/I5DyRF0ruB386TS1c3+NW7E8U3NCGDZi3w==
X-Received: by 2002:a05:600c:1c0d:b0:412:64cb:eff3 with SMTP id
 j13-20020a05600c1c0d00b0041264cbeff3mr8722712wms.3.1708606538147; 
 Thu, 22 Feb 2024 04:55:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033d873f08d4sm3626621wrb.98.2024.02.22.04.55.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 09/32] hw/tricore/testboard: Use qdev_new() instead of QOM
 basic API
Date: Thu, 22 Feb 2024 13:55:11 +0100
Message-ID: <20240222125517.67131-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20240216110313.17039-5-philmd@linaro.org>
---
 include/hw/tricore/tricore_testdevice.h | 3 ---
 hw/tricore/tricore_testboard.c          | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/hw/tricore/tricore_testdevice.h b/include/hw/tricore/tricore_testdevice.h
index 8b4fe15f24..2c57b62f22 100644
--- a/include/hw/tricore/tricore_testdevice.h
+++ b/include/hw/tricore/tricore_testdevice.h
@@ -25,12 +25,9 @@
     OBJECT_CHECK(TriCoreTestDeviceState, (obj), TYPE_TRICORE_TESTDEVICE)
 
 typedef struct {
-    /* <private> */
     SysBusDevice parent_obj;
 
-    /* <public> */
     MemoryRegion iomem;
-
 } TriCoreTestDeviceState;
 
 #endif
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index b6810e3be0..c29db8b451 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -89,9 +89,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     memory_region_add_subregion(sysmem, 0xf0050000, pcp_data);
     memory_region_add_subregion(sysmem, 0xf0060000, pcp_text);
 
-    test_dev = g_new(TriCoreTestDeviceState, 1);
-    object_initialize(test_dev, sizeof(TriCoreTestDeviceState),
-                      TYPE_TRICORE_TESTDEVICE);
+    test_dev = TRICORE_TESTDEVICE(qdev_new(TYPE_TRICORE_TESTDEVICE));
     memory_region_add_subregion(sysmem, 0xf0000000, &test_dev->iomem);
 
 
-- 
2.41.0


