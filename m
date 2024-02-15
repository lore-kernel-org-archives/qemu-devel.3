Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B17C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafer-0000Oa-2X; Thu, 15 Feb 2024 12:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeN-00082J-OV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeI-0003yp-3G
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:55 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33cda3dfa06so828312f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018548; x=1708623348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aGjNKILVOkz6T4RapcEJAgZAcxiKva6dOv/kPtf4wlc=;
 b=B+O0kX3x84M/OIOMm6NL4YKDsp5pr8XmX7nrnBobO3FSk6sfuVlJdLCy5E9R62cNAz
 KLOAgzA70l/xQowrpBuWWNO+oER4dGw+Zb8Uomx5tWSTpdfeZjhbel7vQlRcZYGVghLb
 NtrALyzrTZQ7I5D+qYbnEN1XBBF0zi/ajFswFEtqlqf1J11sNPkoadP4KbgCLWlvIGG+
 LwExEgMR0ZOl1xtMHEX7a0RXWJf543MLZ3pNl8eRAoKg6QLQ74kfpjojzQ5jHRDwrpq5
 RfYUmupy8nEP3zb1P46b9UVzBc2OZmT60xQJPzdR8igDOVbHwzgZa/895puQM7YUW3S2
 yhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018548; x=1708623348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGjNKILVOkz6T4RapcEJAgZAcxiKva6dOv/kPtf4wlc=;
 b=omncS17kb7dfmzW6o5s3DakESBom5DcqDeh5+9bVjMMPeDSt5tAIqPw39MZiwm/I9+
 jKxUJkyiVHqd0ah2++FHnxhShMnTkyJ++6CQF/XOSg9Sb4Wz0fR7wPyvXKYmnz1R7QFV
 7SlJ6yhrVjua2H4tl0b3p7CCvc7ULOzqaWz/yvMSy3MdSEoUkxv2/aYoDT+VQS8A8vPC
 byWLdxgMhsn/9753qvIwcWxkjLE3AFylgk5ZMDqkASlaHlwx7N6WO3/MTK+6tp56Lz0n
 CSmyOTstndkbJrLsVsp4mDnGSkwpkVNiblUra0Y7v6E6++FUwrt5SDSxwBFjQ/IYuNhs
 iNDw==
X-Gm-Message-State: AOJu0YxEHv5wWdnNjJt0seFH9fEbNdvP8pcUhgxCBV+S2sDWoHGSH4JU
 Rtjt1BuBdzxVkC/xjKGgPSV3d6Pobo+8PHuDUzfXUBENSs5fqPbDrTtbs/VDqtMtDB7bVxyJkh5
 f
X-Google-Smtp-Source: AGHT+IHp7ZA2m4b5U6KXXRMdpAHUr9UItU2EGsiomUfuB8yLmdPgDDZqKd0qRyBM5UN0Lalq31tUcg==
X-Received: by 2002:adf:e80c:0:b0:33b:49da:22e5 with SMTP id
 o12-20020adfe80c000000b0033b49da22e5mr1754741wrm.9.1708018548771; 
 Thu, 15 Feb 2024 09:35:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/35] hw/arm/stellaris: Add missing QOM 'machine' parent
Date: Thu, 15 Feb 2024 17:35:24 +0000
Message-Id: <20240215173538.2430599-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

This commit plug the devices which aren't part of the SoC;
they will be plugged into a SoC container in the next one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240213155214.13619-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d3a12fe51c5..d9884286b3f 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1271,10 +1271,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                                    &error_fatal);
 
             ssddev = qdev_new("ssd0323");
+            object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev));
             qdev_prop_set_uint8(ssddev, "cs", 1);
             qdev_realize_and_unref(ssddev, bus, &error_fatal);
 
             gpio_d_splitter = qdev_new(TYPE_SPLIT_IRQ);
+            object_property_add_child(OBJECT(ms), "splitter",
+                                      OBJECT(gpio_d_splitter));
             qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
             qdev_realize_and_unref(gpio_d_splitter, NULL, &error_fatal);
             qdev_connect_gpio_out(
@@ -1314,6 +1317,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         DeviceState *gpad;
 
         gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
+        object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
         for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
             qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
         }
-- 
2.34.1


