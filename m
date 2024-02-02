Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA8AC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb4-0000L8-H2; Fri, 02 Feb 2024 10:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0000K8-KL
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaz-0004Tu-96
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so18559465e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888207; x=1707493007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EKrB2domJrpD/QjC1zd65Q0KKvruCC/azVIk/m6fgxM=;
 b=mJCr46VP4EZmKK7aeFN3DBN/ptheCsAv3c1dP6OGUw6ZOUbfZKauUYcq0W8XkjUtEz
 FJUH7zRV4UhS+OJvOtY8k8AXJOhptnREcKWtfuHcOmEJtm2HOvHeOuPEgu1RBpe/sxmR
 /pgeBfv2wM/vWikawAusjR0KwLPzZEbe8wpUp/C0vhRxVPMXrnzbwrXwcUUIzDjRkQSZ
 IupqhE0Bo9RhfUE6yRbNFXbqrNZmkSFTnj6COXutzY9be84NBkGBwmyUVqBJGH/4c2Hi
 XlfAaeLNhB7Vb0AIz3xSAbU16Wz+xaPR97w02UvDfrTwD61sfPVBwLmfI1vcDMX/F0TL
 4Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888207; x=1707493007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKrB2domJrpD/QjC1zd65Q0KKvruCC/azVIk/m6fgxM=;
 b=o1i4r7geRqNGwCsBIpXjsImbP3hVNikWRP/JySW3ZfFXuqGiQkBgi0eRPZjHM+QHuo
 M0jZsbfFvTetYdj6SFc/Rh0DXt3QNH8mF1JNmgInFuONGRsLgJE0amC7XrjZFDLUOv8p
 Vs4vQbW1mrar/BnV80FdPMU0m4QFKzhLob4r8/ypDIlFc+Yunh81xnDNvK8s/8b/Bi5O
 9J0r+ts2vdG889AAUF8i9AGG5vN71lMsaXsHtRbQCFImfKjEsgrtPHvuCA9c7zRIMFlO
 oFdKYwANZNRmU8RnvdFZTqimvSozYKpl8z/sEknC4HDWFOuLZ/v5iM9ydVU2bC8FW10b
 GMGg==
X-Gm-Message-State: AOJu0YwQlsxz1/+sTDn30YH4+fnlD6EZUtjTzvQZ4Ksm3W17m98UJLHb
 NCF0n22Ee8eKisMSbxn284Swi5T9bikDbyL5QD08VVRX9JKXkRVky/GxwAN0eayON0WXUtfCn40
 Q
X-Google-Smtp-Source: AGHT+IFP8/fGVpLiDR55y8J7sNKtTKDy+3CAaMD7nEbFOnrwAkwfuMTYH0A7yRG0SmxuwZe4FKXcfQ==
X-Received: by 2002:a05:600c:1c99:b0:40f:afb9:ca10 with SMTP id
 k25-20020a05600c1c9900b0040fafb9ca10mr4114894wms.1.1706888207623; 
 Fri, 02 Feb 2024 07:36:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] hw/arm/npcm7xx_boards: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Fri,  2 Feb 2024 15:36:20 +0000
Message-Id: <20240202153637.3710444-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The npcm7xx Soc is created with a Cortex-A9 core, see in
hw/arm/npcm7xx.c:

  static void npcm7xx_init(Object *obj)
  {
      NPCM7xxState *s = NPCM7XX(obj);

      for (int i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
          object_initialize_child(obj, "cpu[*]", &s->cpu[i],
                                  ARM_CPU_TYPE_NAME("cortex-a9"));
      }

The MachineClass::default_cpu_type field is ignored: delete it.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240129151828.59544-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx_boards.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 2999b8b96d0..e229efb4472 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -465,7 +465,6 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
     mc->default_ram_id = "ram";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-- 
2.34.1


