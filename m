Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1794AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjc-0006ef-QW; Fri, 20 Dec 2024 11:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjU-0005zj-Nq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjS-0008WJ-IQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso14735525e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711605; x=1735316405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJTjio8+pXQAHERezjDiK/6t+nq1maFyCp7d1MeiRF0=;
 b=U5lyFh3JbehTz/7/p1hL5WHNvBif7rwYpmKRfmgxCRGIU7ryHUzarYuAcytyDzG6MF
 pUyqKwnbImMn+G/21/j397hnLYktROhYf1O9tkCp4WqjsdQrda5w4lGYXPqcTeB9gMfm
 xEDyWWtg48OY+IoVt60HLcO7UWSkPr1g2TDG8HFQgZ0Aut78dsnjhpKDpss+TKDt3UGi
 Jz46b6XJTlyUiTwOBXb3Xt8qm8sHBKvId4VeeRcXagnt0S1UhEV2wqP7Wxt3L7Wxu7oq
 kXbI/MUzfIB3ZKY2K9/40P+KQ3FQkxNoBtZ/CzRYUzvx1mTKd0OhueeR2+jzheyB44fA
 VznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711605; x=1735316405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJTjio8+pXQAHERezjDiK/6t+nq1maFyCp7d1MeiRF0=;
 b=gZ0sUHeanKPytrGHufpGwMXOCVL9qZeKdavjWnbm063suPXbjw4VriOXRnX5sNklSh
 2NpEiEIkTXPFzLUZs+y007iyJNFaso41zFwU0mWdDyorB9L5a8lrxdeF9ZtCxnh9mT9Q
 Ep8OjY+iFv2TEUswGj4ZDvvqqYpqrDF3vNaGnOT+r3TdC9k89yMVJQLf2UvN3c+40AOJ
 5uXSMp6MZk862WrpqS1S32cGz4X9vX8feOAP3WtcHVxUMDm8rkqZYh4sXmjDbYHDgI5e
 HHA7buFY+1HCsjgprGoCnPHyK4Q/VoeyMU/YMfsUTuzS6ZmVTwheyYJv/xCdhtDlMgxU
 heiA==
X-Gm-Message-State: AOJu0YyFKpBoqw14jRa//NntbH6xIEiwmiLaQjyDjX0eV5x9oWnErBM6
 Gvkf5LNWcvbYRRmDnobH3+UPSZFRnOL7nFSY0a6EiPwCttty+lJ8ejooxYjE4uVRH9x5muTLYU0
 l
X-Gm-Gg: ASbGncvQrpFn2A5pOpE2Bi0xYSS1DIpXXiGQHercmbYwslo1hRB362WRwa+SNTx7x8Q
 LgvY1KhhyudQUHJEKu0401rKFRoFX9ns7rFJa7IzJ1RnhcCr1YKvxK5x/1DQgGAuNswO7D5Trx5
 sR5mQiuoT3V4Pn8K/j823t8ynqFNAK+X4nAB6IjqqSKGFJqZwfvNXOZ8xnGVnUdh8oizbxdqBh6
 xTIZQ8N7JYzbS9Uct2mjLJUwhMuJLB6ongA7y2tlG/Du9rMSznUvG/fUv1JyZwYF12yQFvZjU8=
X-Google-Smtp-Source: AGHT+IF64Ba9LUb/m7gFvn1NJJHIcz4XN4bYMSy34/vn5lWzCOTleCUUVN4QBBqvwrQmPidaBkIigw==
X-Received: by 2002:a05:600c:470a:b0:434:feb1:adae with SMTP id
 5b1f17b1804b1-43668547fdcmr34034565e9.3.1734711604718; 
 Fri, 20 Dec 2024 08:20:04 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm83874735e9.15.2024.12.20.08.20.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:20:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 55/59] hw/xen: Remove unnecessary 'exec/cpu-common.h' header
Date: Fri, 20 Dec 2024 17:15:46 +0100
Message-ID: <20241220161551.89317-56-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Message-Id: <20241217151305.29196-2-philmd@linaro.org>
---
 include/hw/xen/xen.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index ecb89ecfc14..e94c6e5a318 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -24,8 +24,6 @@
 #define __XEN_INTERFACE_VERSION__ 0x00040e00
 #endif
 
-#include "exec/cpu-common.h"
-
 /* xen-machine.c */
 enum xen_mode {
     XEN_DISABLED = 0, /* xen support disabled (default) */
-- 
2.47.1


