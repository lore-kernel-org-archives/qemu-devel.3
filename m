Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61774E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjf-0006sr-E7; Fri, 20 Dec 2024 11:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjZ-0006K5-Al
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjX-00006S-Hg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1633349f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711609; x=1735316409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26di7DaWtmPDXYxMPM19+KQ0TF1cDrCICXH3PHxzoEg=;
 b=SwUUC83fjsYHYRLKBWIN98Uk6w3JsyTwR+9a1V122iYsBTU19t3R3rV1yD6vFpUBpC
 MRG2mUgZggNj8gtQGuhoWuY9i90H61ykh3bclVgYAyabXcIEv+bkF43Hws1DN7o6g3RI
 +f+mYmmX9+/sA+jjEvznzdzfiXsuOqtUN/LC9UuetZr2VjBXVP4U8dvV+hiq20UQMPrg
 KuVKRr9v4Sl1NLr8mI3FDs3IzTe8tSFTmP/iDLPVJ+QO4qwLhZDSuf42lG2OBdXvTdNN
 FsQEfgCMZkEu7aS1Kw4lWFcUA/JbsatP/R2tIMsJtj3a4cyjuYznqpeWqKF42+1Qos0p
 W3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711609; x=1735316409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26di7DaWtmPDXYxMPM19+KQ0TF1cDrCICXH3PHxzoEg=;
 b=F2IeqkLeTt7Gu1TTytL/0DHmbQvXBN7+ZhEVZJNJ6Ikk+443P9mYpMSIw++O1NVLl2
 4xmDf0ZvT4LuAlfLDsL3rJqCUB03siblIVKUQCgG00nGT+LyqI/zvP/8jezT0Xzmp78Z
 9Eux+Mpct85JGfcd/AgwENixx5maQ/pBQO5D5uGCf1JweLdIXsCXZA+O4s+Rcba7g4zA
 wLHIN2XrEgtflba1WDXbkVI+Mtv/kATcb7n/LqvTcBeVzKqIaCEYpaUU3xDHcpUQ3n+u
 R155kGrsRSPxi9Lxn+deTHuVtRK4F40a9+TndZu2SqdqXXruycHavIR1OjnkhfxpI1eQ
 bGiA==
X-Gm-Message-State: AOJu0YyCpouuZu2Uz2w9AOYfiESMTJ/rSCEL+nG1pEUO0IJnOy74V3Lu
 fkwe32vyRJIvW4XmgOFtGwVoH4kucTCaEzf1VSCJhExWJxe8UqanJ+Dbab+cvLtyoi5Dso9K9+V
 R
X-Gm-Gg: ASbGncva/UmHLNtz/mhtyvmZdHKmaxN/Ot8BybfEMkZqNeJxTlIw/boAMN56uRydt4a
 TT0YRYVuSbKqibx1X9Fe0Nz6nJB4aqvxYLi7Tue0p0hnEpFyXoXQRUw7sn8Zr0lmAoUXC+fSgh1
 x4iJmajRrBDkTRG4rFntiRsGjvwJVgnKH+B99IuZeedP8dMujF7h//QDXJPgkGm1g1Ivmc0xNzI
 oCmeri1p1jPYeQ91RgIG1SScSjytQ9q1VwIWzGSiQtNI3VmK9erT7YgJLpiQBEp1aquQgQnLYg=
X-Google-Smtp-Source: AGHT+IHwO1tQmV3DVFycsq7AtPrZmiJDftYjIohq3F0DaNj8O2jcyJ5l/Js4VtK5qCs1VOYqLMEeIw==
X-Received: by 2002:a05:6000:70a:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-38a221eca99mr3629315f8f.9.1734711609138; 
 Fri, 20 Dec 2024 08:20:09 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6cb1sm4499987f8f.89.2024.12.20.08.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:20:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 56/59] system/numa: Remove unnecessary 'exec/cpu-common.h'
 header
Date: Fri, 20 Dec 2024 17:15:47 +0100
Message-ID: <20241220161551.89317-57-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Nothing requires definitions from "exec/cpu-common.h",
do not include this header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20241217151305.29196-3-philmd@linaro.org>
---
 include/system/numa.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/system/numa.h b/include/system/numa.h
index 96d4ff9b85a..1044b0eb6e9 100644
--- a/include/system/numa.h
+++ b/include/system/numa.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bitmap.h"
 #include "qapi/qapi-types-machine.h"
-#include "exec/cpu-common.h"
 
 struct CPUArchId;
 
-- 
2.47.1


