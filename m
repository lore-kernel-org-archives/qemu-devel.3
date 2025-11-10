Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66FACCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUYx-0004Xx-Li; Mon, 10 Nov 2025 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vIUYj-0004ML-1K
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:16:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1vIUYh-0005tf-Cp
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:16:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so22149035e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762791357; x=1763396157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aaPNn73pbEdflHGM8HmHoemHacg8sp31WzN6ccaG+uA=;
 b=LzQxCAgRq1Bqx/1Cu9VCzixJNnmNQhntc/rKm6XPYto3dobZzKVOgOtJzC0qU75tgU
 09KPn1BTr3nnVU10IauzGPB7rFnnMnLiX2zt7fQrbw4Y6zB91itzXgB4vBn1sgUHje2T
 qNJM3aj/4/WcmVSJzIZ0SmquHSyKF26JKChpGXwJcyCeR90CqgSTSzYm6EMjzCifaYeB
 aHeu8xMjPHXzzYQgtL4wrT9oOAckfK73ypq0v69hJXsBzwIb508kjMO5UdnMiWnhq8XW
 lm7fIBUuGdZkVNLPPaen9GNFmuDe3VQ3KmHc3NlmQRKEGBOdG8w+rbqYUoMfwHnX+kmN
 qmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762791357; x=1763396157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaPNn73pbEdflHGM8HmHoemHacg8sp31WzN6ccaG+uA=;
 b=h4GaqOnZG4K4DNvcPaaLlscQvpy320c/pDniIh37Rdx6h+SQ2eDXCWN347ny56Xo5K
 KOMDCYr80KY6VMI1dWGlYpps80lRNeb+fbzelN6+JAia4+MfCnh+fRJ3a+pvMoVXNHJY
 k0Sc1PqoxWcDNVMnLLQGctL67KcCHCvhoqrF4rBUYItO49SafMaelo1vfNpCwLei8o9N
 OduVKvkweU+yuCBnyoX4ZW0Neq1NlK6fynQHAS2QjeqyM/WZxclwrJksbVKI67YUO0Kf
 wEp1okexlDwWfOnjQaiQJp4IUkcknoSjEUGmSYxnS/ey+qRQOxjYlUHCwGsDx2yX172L
 mmuQ==
X-Gm-Message-State: AOJu0Yy+xEguBHey0ba8WnZv6EHaXUWOm/r9HqDDniXtcCLOJIWBvBTz
 OmVEJJE8e3r89A3XNanzpb1ziae7EHNhPs8Qo9JZGjn/y2k9Zmgr0PpofdpVmw==
X-Gm-Gg: ASbGncuDLNPHgHbJjwQmg0HpP6KuCGKt8GQiKRj3sRL3mcr6/o9usNp1A9Ukq5bOUxT
 9YOE5z8eRYEjO/V2YDU2m+8TObO+Nlohidti1zCg7MvEmfRtuQ8pE4UO02kFBJSUP2LdjwEnQTT
 2jR7kgBcAbfv+O0yplPg8oV3AdejyTZf+gCvc7wrkEA/7CdVUWMszDCfpQYGHaUds/QoFJEix9t
 3uKe3SwEtvOno2GBqHLYQoIYpcPCJcFN1En0IgcHwDgoUiHRQi/AI0r/BcWkUqW/1CQzuc2GLUo
 8wuM510Q20tfAiRTNXhHBnzQgIEg8oAYmIcHYuKGkXVJCxMBgGmXLtxl1X/C5s9erOKFzbGp6S2
 OxE00YDgJwyvg7W3mvmgfkVSw2PJJrGdUCNcvGu4Nskf8ihSFdM8CatO/DttKLM1W9Gu9f5TpwR
 13Bq9cMtzc/uJC4Sc=
X-Google-Smtp-Source: AGHT+IF6dlFM0/AOIsZHI+3HuQ4dwrjp2zU391gk+VRpTe9Zgbfsd9jAxiQul6j3FN2LZIPuSQK50w==
X-Received: by 2002:a05:600c:3b8e:b0:477:25c0:798c with SMTP id
 5b1f17b1804b1-47772e04759mr84466235e9.20.1762791356736; 
 Mon, 10 Nov 2025 08:15:56 -0800 (PST)
Received: from osama.. ([156.223.120.220]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b35ad7c16sm10175670f8f.15.2025.11.10.08.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:15:56 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] target/arm/cpu64: remove duplicate include
Date: Mon, 10 Nov 2025 18:15:52 +0200
Message-ID: <20251110161552.700333-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

cpregs.h is included twice.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 target/arm/cpu64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f81cfd0113..ae84d8e420 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -34,7 +34,6 @@
 #include "hw/qdev-properties.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "cpregs.h"
 
 /* convert between <register>_IDX and SYS_<register> */
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
-- 
2.43.0


