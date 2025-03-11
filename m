Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B84C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvRB-00060a-2L; Tue, 11 Mar 2025 04:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvR8-0005zp-O3
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvR7-0001Ic-1b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso24581635e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683483; x=1742288283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vxZRHayu1xEJ1WB6kICe41Fz92U83djkt7AFBjTU44=;
 b=pYvX8vVeTzh7oDUXuE9lFzYwBagCcrvKmMM/gbapeP3F06xUcOdkeoKDckbIWsiFgx
 5UySapbPXOD3UmCzklohRGr77mMPdobL+ctzYAxmhrGhgz3Pbk4r3zceQ+qNTDtpTWso
 c6dk0Lv1W2EBBrbQ6m5moD+jSLVjAEvex7tODdYJh0Qd6CyQJJ4UfrTDVFedwQl4eaxM
 xAF3PWusueBXDFFjaKo4fUgKNd2ZQ23QEuGRB+wvvAIHmTJ/fjXj9yUe/1Q0QfVXXWgX
 /WHxw7Mv7v8j3Q1rhNqvkUNJGk+xeNJT5Ts9s2xSZY7+5UTUGWCNUHzsOZQydJDfmw2A
 Cx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683483; x=1742288283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vxZRHayu1xEJ1WB6kICe41Fz92U83djkt7AFBjTU44=;
 b=agzTe08bUcrbHtj7jcXI9Xc6xlVaQg7vXcnTC7sIf6c0jYJTQ47nxyNoXwM65+9iBG
 WoVKaekPE2NVGDLRvF9Er5pwhxXcPfGNpTd3ltNhEAyBLPDSSeWcgUnqxRvvTTMPqyae
 wqbnVZDkGtMQyznwcujeEtGoYW1EUUr8X1sU5ukJX8aTJNftQC6wVA6GwMSFyMlhFVGX
 aO2vVJA0T/lBqjVSLzmx6D6nZgNVkkrkayJL4FV5QUULwgLF9NoKhP11jJawNjS8p6No
 VqzMF+jlRgqIFgsHRj/7KLWxotGGlmv45cmlH+Uvb/1SeFlnTvodYtvp9yrLRawNea4W
 A1DQ==
X-Gm-Message-State: AOJu0YyQ+l4rCAVWFpAmvGL+2HbVqYWURbOwO70Z0u61CAh9jZAK7nQD
 wTH1AaUQlPMoT8ItVfO+rTlwx3701cPsJXTUCl6uq93XVZW4+V9cjOA41InyNDhHI2cJuUUqKsg
 mWZA=
X-Gm-Gg: ASbGncvu6vi9OsPehwfEQLhsmbmoQFUiiaeG9rXCQq0L5dvbLRDAmxH5cYDaP26m3gm
 mcdAW2APQEBqPjkL0464K4J1TxXss4pswYg25BisFBnvM4Fqhe5xCwQjULgNmN7Q/iIUCc99sz9
 tinwS0e8xaP6UYhT+liJqCsiq8OgDfuJB0dKlDlcTbO60fVMmi3BYDUu99GgrxORe0rh2D6ySqU
 C2R1gkSkIkB7UMuE+3SlPnShiSYPo62gTDYMmWhvsakmiCSQj7mtFTHOJqeNtZbne8uo+Txv27j
 4UBVvFW/sQjbUVT3OiXlGHLbDFiAqpPnaTYMUZuelCrOL/Yzvx3zeOFN0KoN+91ayJCJLxliaIB
 68maQRNu127yQpBLYeZMZYiSkEX8vVQ==
X-Google-Smtp-Source: AGHT+IHV2MgBhJ6/1RulXXBlp13Jn3jYWbOwrtuXF6UMbt91IIB9XmCaKcfMow4BiFesWdhVWXWeYw==
X-Received: by 2002:a05:600c:548f:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-43cf87c265bmr69463795e9.21.1741683482741; 
 Tue, 11 Mar 2025 01:58:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf85f2359sm63439755e9.27.2025.03.11.01.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:58:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 3/8] hw/vfio/common: Include missing
 'system/tcg.h' header
Date: Tue, 11 Mar 2025 09:57:38 +0100
Message-ID: <20250311085743.21724-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
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

Always include necessary headers explicitly, to avoid
when refactoring unrelated ones:

  hw/vfio/common.c:1176:45: error: implicit declaration of function ‘tcg_enabled’;
   1176 |                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
        |                                             ^~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250307180337.14811-2-philmd@linaro.org>
---
 hw/vfio/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7a4010ef4ee..b1596b6bf64 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -42,6 +42,7 @@
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "system/tcg.h"
 #include "system/tpm.h"
 
 VFIODeviceList vfio_device_list =
-- 
2.47.1


