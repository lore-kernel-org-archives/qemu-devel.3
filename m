Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD226C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIN-0002Th-En; Tue, 22 Apr 2025 15:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JID-0002O4-P1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:29 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIB-00069s-FL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-309d2e8c20cso1361841a91.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350106; x=1745954906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C24thF1lHDac0cqqp26h4qdOGOfLrlU2eZE0vToxCKw=;
 b=UzJoxDmu/i9sUpB6AG/z20Kp0WSz9x+M29B3ZafSM9AVswbXOKrnwIVWaOt1P2CW1P
 F+SvjRQQzzvkvk0Of62qZLm4ts5xjDzPmYzvRA4WHn7Be0i5KlQpUI2hpj4JwYq9K6uX
 JX0bl5u7TJuWMayFMjfBPE2xxtXvFndrW2B/eE2AZh5GPBPsaYEpd/SIe0LbLsEiRZNN
 XRe3Dkf6ak2FOaIHlrmtWBLsrUrTw83LNEvPrEY/9vX8pD3JCJii/+f/af9WkQgbI2Z2
 0kWChvr/8Gu+YDeJPyUagrgg3hPJ+GtuleITv/5GJJH0A8KpyMS8MLgruuxZCoMtcTut
 uG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350106; x=1745954906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C24thF1lHDac0cqqp26h4qdOGOfLrlU2eZE0vToxCKw=;
 b=NZK0SxO7d4SnW0yd+cbSde5lbK7hF64RQbfLYuOkeW7pYGR1UuMutKhZPZeCo87N2U
 cqo4hzYA4c2uDZXlM1lnucczToVf5StjwPOEwv0/Be9MKmCe9BRvLDI2xd3Da031matm
 J9KOdxE3Hg+CFcsUsNHh+XJJwmNydCrm9yW67R2zI7CLj5xpwofu6o4MOz11WgD96tLL
 nXe30f+vsIRJpX7L0DrlYyzQg/aFyH76bmN/3E5rgM5N6xS5AGaYONzlWsH+vLdNVdXz
 zUAMmHv2pmTKwDjHcT3h7ey89BVYSbO1zaJqLIHLvb0j0Lzl61Cr8R+PCsIJGFbzwdZg
 SjWg==
X-Gm-Message-State: AOJu0YzRVBvUDL2eeJqwg/kIeCdU8G916sz9VIsoOQhOfikuXiVOPRjY
 Xwfs8w1AJoIZ0O+sA/nCHrCRjdqZjEPiGklOLhOOWvOfMcSYysAO471p1x1i6MjQPCyaeXp4ZgL
 y
X-Gm-Gg: ASbGnctHag7RIF7yPspz3y2T+Sdtl1jtrp5QRGMzrMXLmQ9gNJC2BL4aj8AHrqQXroQ
 f1vGKph1T5DJ2JUKDb+5jjqTlg+3tHqQQnT+RK+NgAPmoX1xliB3R+giv7KvYEXKhyj8uHcKFNs
 OstSPW/QXczvGGIovBnSSUNGzawUqLZXuOiZ7et/KkpuesgClGzq/lf49JkK1Y5rBQy7dAoyhb9
 DH8naHaJybax+YNjqS77cpv+lURUGgyXrjRpc3Rz6cEVcgjWqa/9YcV1c8jLwXwZhtA2hrblo8T
 N1Q5/AAqLsqOKZADAkQvIrdnCU3ZH3DGKPZMDmaXD5ou0lw/IUlTey9XJ5/lVokbMvNixdTvTr8
 =
X-Google-Smtp-Source: AGHT+IEj13CjKIbt2L7GJQmDk0HrsQeSD+dCh0zbHycu7epvjHyOyq1rRDTBdSsfwsm8njCgz8+zgQ==
X-Received: by 2002:a17:90b:5444:b0:2fe:b735:87da with SMTP id
 98e67ed59e1d1-3087ba5d6f9mr28732542a91.0.1745350105815; 
 Tue, 22 Apr 2025 12:28:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 008/147] exec/memory-internal: remove dependency on cpu.h
Date: Tue, 22 Apr 2025 12:25:57 -0700
Message-ID: <20250422192819.302784-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-9-pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac..b729f3b25a 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.43.0


