Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4109C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVqj-0002YM-44; Thu, 15 May 2025 06:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnh-0005VU-4y
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0008HI-J3
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so6076625e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304808; x=1747909608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jw/rhXzTJkD4qjTI9+CXYnTXfSZ81oHFEWVxFDqeKqA=;
 b=wmmiv0ttPIWJTZCoZ1kVHiqu7aC8eyrzou7pnio1zlJZwwC8U+nI2JjWm+atMtuopj
 Gxn5A1LTngdCpN0ROG/VVTvk6va2Q/pAtUz519uwdGnRnPrI11KMhlsciS9J0Ja5bKdF
 obvlsGAaFafu1k6kYmqK/R+efCZJ3VESd2FsNAYXHNDNTa9mdhpnq52wHmxUw8tp3Ze7
 Im5fR8NyI0424iqiwmQaAi2OBE19FjFpWbDgUxjPWN7a9Rb5iC/b9glRaQZukrdCDVN+
 oDPZCRiuzsZaGG6Gw7dbgBEHIwOp8crj2cCFM5N3E9DI9Ws6fGneVXDothjpz3f2QDUF
 2sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304808; x=1747909608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jw/rhXzTJkD4qjTI9+CXYnTXfSZ81oHFEWVxFDqeKqA=;
 b=K0pj8dnKFR6bHOqajtl8VCbFcMADg5Sx/w3L0XdTo+Z9xWgAelRZBXSSyvqhQa1H4G
 NtG6UIRmo08aNx/1Mhg3bBcddJspoBfOm8NeMRWA9aJT0sAZd+LMXNEx1vCqmCoNdPjR
 ZWnmrMQDc3lgMp4oTUex0L8w+tHNuOhAAKfsRjbIKzz63pfjTUBmwVyZeeM06umrnVo/
 7JtrzqimXhtAZNWx5Po0sKk+4yXEGJ1B//Drv5YC6L7eeKqyZCZjpbtZBzmOIQrnbMEl
 8YVjs0ZCMLAAp3TNgeibgBh7tMfTOMv0BtygapKYmS4tyx71NB27JX8qP6TJudaYLuTQ
 pyIw==
X-Gm-Message-State: AOJu0YxJpEwHQ5XqdSP+s/YINVO9/svh+zY4OHsKxPsSqeJ3XjQQALwV
 7Y/C9ZiCpnizrQY1A+QTAdqAjxGhErvYUn61mia/rifS7wA3s1sJ0pksC1QlAeQv8XNi9YRaHhP
 UsVA=
X-Gm-Gg: ASbGncs59WddTrSnn+IFcV3lIuIAGXwrVqoXVbVQ7z+/+i8wkq6uXi9/0wQbauCZYqb
 LYODvw6jNMe+ZKPsFC+ats2/l5LJM9dirlB5SN52eb5Do7QsUDIeToyrmqMcJ/XNYnXa43lv0mw
 DLggkv+H0gt4MzXXk30lsmllSwQwZ7hP5sa9xgwHohKJGIkSWWeWaRt9m9FdCd0/xsLx0l5DyvP
 bmrMLbsOcfFRvbFc35zpLF3FdqtncA/uBYwI3+m15oVC4vlKjlZF676up6D6SlVUHSbIGQgTg+K
 RBLa/9wzGeDYPQinPsQl/YZ4U/l7DlWi2SQDGIaBOvuLgPTH/NHfilZn3Gx1lRZt8RTr
X-Google-Smtp-Source: AGHT+IGF8KwPfCXKKf1isGOXrm8MrG3m6F3y5y0OcLt5RJL2ojiJ+b8reF7d3bNIk+WGEFLARp1/eA==
X-Received: by 2002:a05:600c:154a:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-442f96e671dmr15109755e9.8.1747304808611; 
 Thu, 15 May 2025 03:26:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/58] target/arm/tcg/vec_internal: use forward declaration for
 CPUARMState
Date: Thu, 15 May 2025 11:25:37 +0100
Message-ID: <20250515102546.2149601-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Needed so this header can be included without requiring cpu.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-40-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 6b93b5aeb94..c02f9c37f83 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -22,6 +22,8 @@
 
 #include "fpu/softfloat.h"
 
+typedef struct CPUArchState CPUARMState;
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
-- 
2.43.0


