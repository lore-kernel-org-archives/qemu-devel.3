Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BADC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kml-0005DB-5Y; Wed, 23 Apr 2025 20:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmh-0005BA-G8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmb-0004Ic-7u
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso365220b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455780; x=1746060580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Xpt+c4uiLvgJ+aGohvTC4gUHZh3/iFralC/z/ZOSEk=;
 b=tfZQw/TiyFA+PjtEDairz4yQfTXkWeKEswaodMhcAc6O46OwHIPqVVW4gRxUC2dk7r
 OO+nJw9oBG5L9aLqp2s9V6EDY10mrShRTcdJYNhttfp4vYsdSHoiej8LTbVnPZ62eyar
 bArlyUWAp8sS2bpo518/G0kglciEHaJG5hrX9IhrC/SgSldFH+p047YOQ7dpXiu/qhHm
 1/FcVFfT3IpgB72FcJkVUVvREE5uAltU2F3C74gP/f/4F23rvqdkQDMTZNQw9qulWCdj
 IpHGFkfd67JiBkpf/Cf8dlOm8fifhwJBeUfu2BkfX5z1mP4aEXbGoEj1E6fE2pt+Fe8L
 YdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455780; x=1746060580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Xpt+c4uiLvgJ+aGohvTC4gUHZh3/iFralC/z/ZOSEk=;
 b=ixJydogkqxZJv26YvGsHyWQkd/duwAe6n7+uc9mMugzdq4BvR1mo23p+oN+R96myyO
 gZ0Uny5+OxMH4w80zZClMkrPx+uqcQO91DDAwPxIKEX0YyFi8qRWuap4xmpBY+pBx4cT
 HSchCmxAqWj64aXf/8bV5qBM+y60EBIH1tU178h+6Nyhcppx2wpa7+rg7ghVh3hPxxat
 g40qyQWoa83eU/h+XELD9L8Fbbe6vzqkK3B/JyZLQ6lNc3Hae7adI6aqoxQ7CNscOTqi
 BUxoXQY1zX8TtnxsF8yvJUajinED3MXmAC6NaDIyAiBTn+p/738BOVhbndcKRv8RBxKl
 Ibfg==
X-Gm-Message-State: AOJu0YziGYw7UrTIecai6mwS/S6TQ40NhX5VQB/85LFFTBHNTBZZ3UnQ
 FnCPeeNApuOUhXdPhKKfl4TYrpHWWhJORo2fFWizemY+jrEw0j86/1Aghihyki8UJI6PHa8MhtJ
 J
X-Gm-Gg: ASbGncs8D0zaAPMrK/CEU/pLBkJjIY0yUatj9DGlh4lZcEhU5Mp0xQ22M8S7rIF9qA3
 F185nJm/UUY4rqpaX9vhyYrzkAiR8pwzMSfCaKGlxl08/0jCjn1xed8keUjeJqinBK6cJFNY0Ul
 uHLvLwHjf3eAG4RbHqRIS7nvxsgnBvq6Bc1LV6DXkdL8PUJnF60EcdJhOw2TBcXxODJWlDG2iz5
 ToknvoMgIHkMTbrQQLxuQ+TrUzJ+r8ju1DPAT1heDw57vksGyjBAdoFpKRgDhX3iYZ7yDV+TU8k
 wU3okQXDdRp/9TBPQc+vSOcEzHQs9Qd4+JumCFxSaOHQhEVqT6STGCfsE3HS3vrhzq/qq0KOdHg
 =
X-Google-Smtp-Source: AGHT+IFkAkg4vYb8gDKYD8A3GOq/2qi9wC6v3Ha57E4QE5K0YzUN5vKYI93yDE0cTmtykdDj/4ClBA==
X-Received: by 2002:a05:6a21:1706:b0:1f3:345e:4054 with SMTP id
 adf61e73a8af0-20444e9389fmr838334637.14.1745455780013; 
 Wed, 23 Apr 2025 17:49:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 007/148] exec/exec-all: remove dependency on cpu.h
Date: Wed, 23 Apr 2025 17:47:12 -0700
Message-ID: <20250424004934.598783-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Previous commit changed files relying transitively on it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-8-pierrick.bouvier@linaro.org>
---
 include/exec/exec-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index dd5c40f223..19b0eda44a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,7 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
-- 
2.43.0


