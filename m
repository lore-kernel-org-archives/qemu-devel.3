Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CABC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8K8-0006sQ-2W; Thu, 25 Jul 2024 19:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8K5-0006XI-1j; Thu, 25 Jul 2024 19:56:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8K2-00019e-Nx; Thu, 25 Jul 2024 19:56:36 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7a23fbb372dso322008a12.0; 
 Thu, 25 Jul 2024 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951791; x=1722556591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fI6myQkPldi0ecXVAXq4jfcRUn3dp32W2BGdaiuZlA=;
 b=IzXA+Bp0YO9MAgOJJmBmYM9LNcpmhhRgQSxvUJG7xZitQ0GIjQWr89Z+nWDc1pklCC
 CZHQ9ytgxp5Mfg7pcY25aiT1jdzZuG02+goPkuJXHqJkseL9YCVJwtmDaozaC/7Kb2l4
 UezgSYWmkzhb6x6O5mfu1/VzSMtYZhD49FuEoz9SEpGRb7ZQgXUnCY3b24lXYAWFMvkD
 QVAiV56tynJlQbZ8poedMCMbpuGl7HSVe1Zl4S6nvf9ZxvzBFT9XuUo70UEjoNQ3ujNh
 egV5hFsm414XkebQLLdmDKoqmaQujupjw5T96iunWjF0ym6Ajjoe1IAgtVyByMGRVySZ
 T3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951791; x=1722556591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fI6myQkPldi0ecXVAXq4jfcRUn3dp32W2BGdaiuZlA=;
 b=GzDuArORiKslblek7CuQNkwvVMRLTw7GHBxdKAZqQ7aSf7xK87napj+0+l8GW+U7xc
 m8WSkazz1hOlbWNpDG7p8VmefUjU/ZdTu9TOwr1sXe3/1lL+lvOGQlLsrUI17BoMMyMM
 8XYxuujcc+o1pa6GeHts1rfZrehQaUYomNaDfw5PYahVnQBy3xd2FP+WEmS6LYATY5OF
 iol5M9qpTDp6rGz++D5dLIo61ZfmWyBPXt7FTk2mXCJ4F92fijdJongzWW9WrzCtca/K
 TbuqT+lEl2y5diXWdV6e2d2+/Ta0vrotGYzEKbf3wxtCiuSOXgURHmhnTods2+44J+Bk
 7UBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXerfklXwTnMy7K4+A5znJnyvAXYSomhRGXKIBRP8MahB34JNlRezdczC2ZElcruzTikSeOowBg1Ta4UBBblUuAoe0V
X-Gm-Message-State: AOJu0YwlgBEef6HFWpJS0yFeJFUXoMm2LuV4BFOy8p/WVR8X5adkYrGS
 jU/p4RfZFqQbKoL7booar96JJhMNBQJJiM/PYpqfx71wItC0TXhTmQmeXQ==
X-Google-Smtp-Source: AGHT+IElC4AwdROIHkknOp8/K3VzBVB8OxuY4PI+nxDNmZ9bkTr/whqwDdSDnYtkZZJnRuZCnLHzgg==
X-Received: by 2002:a17:90b:390f:b0:2c9:999d:a22d with SMTP id
 98e67ed59e1d1-2cf238ebb99mr4785900a91.30.1721951791057; 
 Thu, 25 Jul 2024 16:56:31 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PULL 36/96] ppc/pnv: Remove ppc target dependency from pnv_xscom.h
Date: Fri, 26 Jul 2024 09:53:09 +1000
Message-ID: <20240725235410.451624-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

In this commit target specific dependency from include/hw/ppc/pnv_xscom.h
has been removed so that pnv_xscom.h can be included outside hw/ppc.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_xscom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index e93d310e79..764b324a00 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -21,9 +21,9 @@
 #define PPC_PNV_XSCOM_H
 
 #include "exec/memory.h"
-#include "hw/ppc/pnv.h"
 
 typedef struct PnvXScomInterface PnvXScomInterface;
+typedef struct PnvChip PnvChip;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
 #define PNV_XSCOM_INTERFACE(obj) \
-- 
2.45.2


