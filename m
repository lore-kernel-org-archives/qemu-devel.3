Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F05CA0FFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 15:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34w-0004xF-JO; Fri, 30 Aug 2024 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34u-0004qP-OE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34s-0004aE-K5
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-371b015572cso1542096f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029897; x=1725634697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EESAaw4Z2DDsWl+A+cySiG9CVy8SPP53rBykihg+Up8=;
 b=nMEkKSk33uoIKtgZnUYSjSp6QVwBvPL/knyGH+KFLqSIbrG99Pfz1FCAmVrU1LZVEI
 6yGDhPYRwgVkq+CKYKv0ypU9petHq/6fXXmsO0Hy1hhqr3++yGhFyF/qV77p3EJI4k2a
 2pR33UAWxEizNJn3kuzE7zB09+21diamWOl1vj1IACx2NMY3nexEvOj4+AodLnbT12rF
 gJ/JvBQE4dvXfi7TOB8RLAsUFmxUERW7CW35258JOsP/1Hazx7N6ETrrd75VkbmXzTrh
 hhl5TpQZE8qk7L3oZOiFM8rVhsGXeeHZF7MOMiQ98usZdP4uaADk8lHwrcZnzfQiMV8c
 pVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029897; x=1725634697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EESAaw4Z2DDsWl+A+cySiG9CVy8SPP53rBykihg+Up8=;
 b=NjXX4eK4OrCnE2gDjnQ95IuIGhGZ3hg1AFiBsXAsq5tbVjXSqDmdeTY36+xn7tO0TQ
 A+uMBeVMfBUSbd3q2ApOUUwokO5dII5LLsLDdvkkmKxZYyS4ad6mK4KM0LiTFgcAkPg0
 To7gs1D4HFhqvQcEgte0jZw1NnMbJiQfG/OrLCuB1BQrKZ/If4XaR6QmHQ2Im41c7lb1
 Mjk68q6a5+HUpANfd7g29oeK/dOnRmYfPc/ACgdo34gVc++zuyxKUlgrlhRuZM3Y7JHb
 aC64S4whwy+qQBw2Q2P14+Jom2WT1VKzVpJFaaF8vaCZyWnAhHNgosZTicQtHMP+ReZT
 z4VA==
X-Gm-Message-State: AOJu0Yw8zonIEa0LLU5BWQCq3HSkz3/QKHOLgFHRVq0BBijH3GN5THtH
 RPoZmw/BUN1/ZzOLA6+mTRldAfMJ4Ybj2suCaaDaqDthQGR5229N8JcvqzSTzQfBPmxLvHEnZ0d
 P
X-Google-Smtp-Source: AGHT+IG1xb2apcHbzEjPNRetRZXGBVSS68T9aXjoVN+7ttz34KoIc3y5Bu4XDBIT/Pu3AhoTnul3Fw==
X-Received: by 2002:a5d:6a09:0:b0:371:8685:84e with SMTP id
 ffacd0b85a97d-3749b544d97mr6037584f8f.22.1725029896658; 
 Fri, 30 Aug 2024 07:58:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 04/11] hw: Remove device_class_set_parent_reset()
Date: Fri, 30 Aug 2024 15:58:05 +0100
Message-Id: <20240830145812.1967042-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

There are no callers of device_class_set_parent_reset() left in the tree,
as they've all been converted to use three-phase reset and the
corresponding resettable_class_set_parent_phases() function.
Remove device_class_set_parent_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


