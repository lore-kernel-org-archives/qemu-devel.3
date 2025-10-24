Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2EECCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNb3-0004Ub-6r; Fri, 24 Oct 2025 15:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNaq-0004PV-1L
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:36:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNam-0002Ok-TW
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:36:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so257095e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334611; x=1761939411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuKy0g+dMDyAMbvGqcOb5ITf53v59XT0OsM1YVfVPZ4=;
 b=oTB9ZWbnToMek/5JTYuyZOT3utcvQtljJi74RjFO+RaG+Na9TgygppO7BvydGvhk5W
 8blVYsJksBDkeCW8742MayzOAlHYStofRm1ELZMBjo+0KnyoL5iObTHrRiWjadMHerDD
 LmmSZuBKucZLx7/fct60MdPkI3S0Sp7nre7G5idwqQgOSplRLDX2AafM7JcuIuMyP9Cx
 4p+WVrgXFW64oUn0mV66IpSwcqc+N5TG5s6yfDL0nY7YOZqRcOHoyjzyJQ+ZRoBDxOCG
 qtSXqDjr/1nhK+dFuheGSbGM/9UTZBG4PQ8tUp2479G75X2JIdb2I2mgxuY5U8y/mEGi
 Q5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334611; x=1761939411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iuKy0g+dMDyAMbvGqcOb5ITf53v59XT0OsM1YVfVPZ4=;
 b=JAfX2twTJjcAD4PvPQJ7C/YHNUlbcXNPMPw+D9phU+/OmKjSc5om7yc3jFCydYZ7xj
 OM5Md8sgsWE8htBl5BzAizI97Y2ng7k9n6r8OdRPHLzA1u7Sys+wYir6z0Sslonim9tj
 +eZK9BQdFRXmpOGFv8Cf8j9glYH/drOn1/Sw1HMNBgjXI6GuuatNOGzgMz8nmjv0tnRX
 ncNVXwzLVgfZICTdE2x7kf/1v53U0ybUYzKLMYn7Q5XTHa5ywrSwpyXOQpkXliooRdno
 YrRe9I+LUaFRf7wwiJYj2QqzJmmaVgkeGjtEnFG7lG6qqcao+xdbNLlBULFzVoKyNx1I
 J1QQ==
X-Gm-Message-State: AOJu0YxGhZtyM6GyGNyGI7kP7yYVPUnFsUvWAV5IDo2HLbu+EeRcIHKK
 S30zvuWMrbL+IqFMd5MHF7TTpHMbLzY/1M7WraQ/aHYScRLlw3eD22ExCe9Bbuh6Ol0z68mS8pE
 2YEMeI+8=
X-Gm-Gg: ASbGncsl1GD+yjULIEWDibhJTeSHKiunNrjgXJAzfcY/3sXZDedvh9oDiFaA6+3goEW
 qHEQ3DJvItjpX4DYwVGTWDGbfyiVlsCEqm+4u68nkQm25BWQyZow+aL5xsVzckXJ71JmVg12o35
 xN2iva6iFsgTF97Q4Wf5aU2J+aibWhN/SV92XQxIAnWB/JRN6LMeu0WFiAw4ARRJRC4UQwbi83s
 pHLJ4vzw9jv/OLyfwO0Cmb/TPH/fQzTcUSaMwLclwk73mDF3KlXhWKa7XHs0rXhDWnnem3X0Czq
 CCFp+AUiCqpwtuM2sEH49TQllNrLkvEO63hst+iNr+RVB+ImmkxzJdeNSM4A4vYhwyPpyyCL8L+
 L/NbtKlwk7agShcIVNdm1YkNHObzITJsHRmVrjAG0WShTo0a6kMqw362Q82/UExQVzqS3Jbezwo
 NOwoQ2XC11HGGyAxg4HSQ/vI5fZ42dscqHpHBibHtiaB5VttgcS2sfdSS0Uqx9
X-Google-Smtp-Source: AGHT+IHYynbuB5rRGbqbFy5ojmEbJmXDvxXJmiYAbYABkcHYoo++O7Xy/oS3GB0YuzDkIoX7m/FWNg==
X-Received: by 2002:a05:600c:64c4:b0:471:60c:1501 with SMTP id
 5b1f17b1804b1-475d2ecaedemr37411605e9.28.1761334610566; 
 Fri, 24 Oct 2025 12:36:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b33sm162574345e9.14.2025.10.24.12.36.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:36:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/27] hw/rtc/m48t59: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:08 +0200
Message-ID: <20251024190416.8803-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/rtc/m48t59.c:41:
  ../../hw/rtc/m48t59-internal.h:44:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     44 |     MemoryRegion iomem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/m48t59-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
index cd648241e98..791c15b7184 100644
--- a/hw/rtc/m48t59-internal.h
+++ b/hw/rtc/m48t59-internal.h
@@ -26,6 +26,8 @@
 #ifndef HW_M48T59_INTERNAL_H
 #define HW_M48T59_INTERNAL_H
 
+#include "system/memory.h"
+
 /*
  * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 has
  * alarm and a watchdog timer and related control registers. In the
-- 
2.51.0


