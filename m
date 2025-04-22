Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63866C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSl-0005BQ-V1; Tue, 22 Apr 2025 15:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS7-0003vz-Q9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS5-0007IO-Q2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2241053582dso78372485ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350719; x=1745955519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMTFwuyzTM5DV5D1Qj0NNV6OmW0mRELjIvfKoj8LUWY=;
 b=EYvNhVN8fugpqoaeWNsRn1EI7hciWnaSaf7qvCE3onk9pFJBp2Bhaa/Jrm2e7sO5OP
 x9rliRXU1AqW0WfltgkTGJsngFASzYPrID+ncv3hCgIR+xNJc3Dt/WB/yOGMlPcyCbXL
 ufY6VkrF5ajSyo1w/zlnrRO/fDctgr0hf/DJ/q1iwS1zVN05pOSJrVQ/5rqC5bTr7umf
 pNVqsa3FhTrODh+dem9iHJgPnE7/AW5wDtC1UIJgF6oU+/C6c/qeCmi04G0p3K7SV4r7
 EGlPiQgTgL+bGFWlF+nMVeTrCy21XOsoaFv6gGjdP8zVg/q+j1TrKkHQ+Zh3WAWGMSiA
 0lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350719; x=1745955519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMTFwuyzTM5DV5D1Qj0NNV6OmW0mRELjIvfKoj8LUWY=;
 b=Y2zZ8X0uAvsqBsI/Zxw4dUZ0YrIl65JB/jGXbzmreHNUZnA8aQGLYaF34eIPS0Iypz
 8Z2D8AQbTbFlf5Iw9phdreaovkWUuROKQEq3j35gQfShaodohC+Jb7wdQplVyB1e/t4L
 sgudFNpbITDCqNBnskHIKelurQHXfDzLl/sgFiuoUhRkOtRcDv7h3WIpK3uhnHJlIhoc
 95c5IXcjPlt75f2P9gl+qXhyM556vWzDX/FrBfhUXu96sOGUI+uUMzRkiupnnK3bphr+
 jLsiYya+FzUI4j8g6Vy5DPXs4B6k0HFs25rSXEoxQNw/0SxcRESzzX9SZvNK3noruNcR
 8k1A==
X-Gm-Message-State: AOJu0YxRZF7x5ry/Cddh4W3mf0qAkvCwmCJKYwy9bpWxWZVQTV8ExHaC
 zXeEafBcTJ4PkYrujrnq6ftF+ehZAb2wgTA3rK2DOw3Igpx0s7UryI39uC4Aypzd/rgCwlAdm6Q
 h
X-Gm-Gg: ASbGncv+w0daXq3Q4CDlNE5/CjOy1ywP7TFshiv5XlDwVV+2aQL4qyEhaepAzr/erSu
 TwFpnrOvnOg4KlR628hbTTfRMdBpBs5u3XRhuJB5LbkRDk6kEa4wxSvb3zjCuJkkUQQ81/dStfr
 yH09dRY76yXWYSNc4hRPCeXucjVnLi8Ai44auXPmAey6boFCy33jjLfkdAkqTzUGKzcFuolQNHI
 YfVWievsbb/bvW91aI42DqWCODDSNZwXNFfjMJz5lTv01MlRRS6p3DkvDVcTW6JLvJeRz3zUT2s
 s+VC3QrbEot22FB2c68u+6E0a0TLP371CMkCc4FQ2LhdbUIn0P+rphhgJcjgVIJ5yvgzR+9tyUE
 =
X-Google-Smtp-Source: AGHT+IGqiEYtNYiaV4khTuda/U5/nITNMgyGzCrm2Qum37sDNZY2jHDNpUflJdgSaAMSTJXEHjQObw==
X-Received: by 2002:a17:902:c40f:b0:21f:74ec:1ff0 with SMTP id
 d9443c01a7336-22c5360440emr247189425ad.32.1745350719556; 
 Tue, 22 Apr 2025 12:38:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 120/147] hw/arm/boot: make compilation unit hw common
Date: Tue, 22 Apr 2025 12:27:49 -0700
Message-ID: <20250422192819.302784-121-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now we eliminated poisoned identifiers from headers, this file can now
be compiled once for all arm targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-25-pierrick.bouvier@linaro.org>
---
 hw/arm/boot.c      | 1 +
 hw/arm/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d3811b896f..f94b940bc3 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,6 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
+#include "cpu.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cd..9e8c96059e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -75,4 +75,7 @@ system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(fdt, files('boot.c'))
+
 hw_arch += {'arm': arm_ss}
+hw_common_arch += {'arm': arm_common_ss}
-- 
2.43.0


