Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQx-0007ko-Az; Tue, 12 Mar 2024 04:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQN-0006jY-NL
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQK-0001FF-Fc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e99b62e01so1297923f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231826; x=1710836626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JAXlhORARNjQs7nWpFZ95k476OBclGaSf7/Vye9/fo=;
 b=ju4fWBiwBCwdTJKt2t3qyXgaZuu2mXQl3zlgrIu3YujM3iU/2DI//l0ti3zOOEF70B
 jyt+55k2avdI3ryJ9hKaH2z4GsKlP6qyy/2lGI8zjWJp8B3BOHP4H3fldetCIKSVM5LK
 Vben6YEWfTJkRRXHaZoUM7wPgWMK5Cz8IAhkaRlVsGGiT1wsptefj51YO1g/wUXanPEV
 HKSTo4C+iokfn2CUF1IqNtUav9HAsXFw9YZ6p1ru4bL/g9jR+iMGjr7taiTqb9wk3Xkw
 JYNy8d+t0D1DLch8pvo2FOhTquuJRJ8UItfpWz7umFuTJXk1/U8w6BWzCHRKYcO+KSoQ
 PeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231826; x=1710836626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JAXlhORARNjQs7nWpFZ95k476OBclGaSf7/Vye9/fo=;
 b=EgZM0opZCa/1hkPPpq1DmFdBuzUHLFZSKjpYYfjmhnIlx1NC+esckZArAiEXsDjPIq
 T4yk5oXdJxFdcokSOV8Yv7EhrAowUgLaWee259Zlu6sh1RgotZ0YmCVItBprkcbP8B5w
 bpWs7oVlwD5gbO5704y417na+s3SDVlUEM8Ym0ghIzK4SQ0+AJlwfuIpjjJbvkKeOjPY
 ktOdR7d4hw8ZW25Oo2q1nMkWaGG707o1GaS3rNunn6rlpTO7ppDvcnG1PQbmSbKQFZGX
 TAPMKWvm41SVPMTz+vccqnzwsK4fwHkTqPfhumJbfvgIkQJNXFmyqedSzmB9Mj4JrSqp
 wErw==
X-Gm-Message-State: AOJu0YwB8K8tNadq1zpbFHtM6T4MhyeLyqui4r73wEedKsyFaZSZFaVK
 ZM9XleH8CDxkVTAYkIlSUivydeRnfcWyeUfBcc2d3BHSX2aLsQYI92YhqoNAhlNFabk9/DUCkhN
 d
X-Google-Smtp-Source: AGHT+IG7fv0aLTCNgJ2w/N49HLsFCBWvGTU5em0E+Dty5lVgQHQ773xt1o7j9QniVoBZxzgBJoLXKQ==
X-Received: by 2002:a5d:4650:0:b0:33e:3efc:ff93 with SMTP id
 j16-20020a5d4650000000b0033e3efcff93mr845742wrs.1.1710231826455; 
 Tue, 12 Mar 2024 01:23:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 bk5-20020a0560001d8500b0033e699fc6b4sm8505455wrb.69.2024.03.12.01.23.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 10/13] hw/core: Cleanup unused included headers in numa.c
Date: Tue, 12 Mar 2024 09:22:35 +0100
Message-ID: <20240312082239.69696-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove unused header in numa.c:
* qemu/bitmap.h
* migration/vmstate.h

Note: Though parse_numa_hmat_lb() has the variable named "bitmap_copy",
it doesn't use the normal bitmap ops so that it's safe to exclude
qemu/bitmap.h header.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240311075621.3224684-4-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/numa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0..81d2124349 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -28,7 +28,6 @@
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
-#include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
@@ -36,7 +35,6 @@
 #include "sysemu/qtest.h"
 #include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
-#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
-- 
2.41.0


