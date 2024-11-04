Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431A4D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krI-00063M-7u; Sun, 03 Nov 2024 19:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqo-0005Dl-VC; Sun, 03 Nov 2024 19:21:50 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqn-0002im-Hc; Sun, 03 Nov 2024 19:21:46 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so3212237b3a.2; 
 Sun, 03 Nov 2024 16:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679703; x=1731284503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+D9sCF5q+vGfeImw5/3+VrFNLTqp9ngc0jqWCzNqrSM=;
 b=XABVTMU6nNhvX7c2NiUG/klQjD5cSOSOBUubO17xDwxe0bo5zkKaJ2hEb+/+gHxUmG
 tbPMsdM1TN1BIqlaybWTp/Erj++ESNLzNogfHKFiK51lpxKxxqpqo2Nc79yTQlmyUkyn
 LDsTT3GvtJ0eei5A8lhCpMktkjy2tr5Jfp8zob4LFpygNncW+tlZeH6QUBc7H6YVRKRV
 n9BQjb+R2MDO1hkP7URiCrsPSI0/zM749TB5Qff7OJ1WEZRzrHw+jaYuwPtIQCxvfDV+
 tBu6OnJ11EfLd1TdcMfPO6kDEOTt0Tvq4OnJb9kzhA5gFM+9dDbGh+h6q9yyX1KHxjF3
 2sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679703; x=1731284503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+D9sCF5q+vGfeImw5/3+VrFNLTqp9ngc0jqWCzNqrSM=;
 b=VUQigMZM+pIR4q5IqfWv/BU2RvfClXbiQNuQVRhsH5AOqqArlGTMYgSPOHS9ujbKx2
 XYtlGTYMENBIqZbtdf/316NR+QBQi+niUE1vOATDHBKsGbGJvlW6wSHJx5u6O4eD4g5Y
 MEEwgGpm5M+bkc1ZXo5KiM5G7ZCYabCQXzPuzp3xqmk7CMHfBZoIDHpjfue81exrJ3kh
 xzZNEKj7Sm07ZUYRSlfvDD0l47C6OvpIvyj2/+z7e9X0d2aaWs2tYWZwQr/HEeJh3tvo
 YhDhGvbpXpYSTLvu/OBLrfSgli83YSgtrFikvaAB1CKIS+oESGmXwInQOYD5ctXVuXXv
 is0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd+YHchAu8/d5hEgiMSRX3cVzehwtKT5hVE2+nONrjVDGAnBigWgGk4u2xFoFRIKVQ4bso+2YCcg==@nongnu.org
X-Gm-Message-State: AOJu0YydX1UUNJLbgaUTGkUNxqmFgrro+FFR5dmYT6KTW7EL7QchQy7H
 h8txVxiXIW868VIGGQpbluGWbBR1Xr4fguslRSQbrqiAwkBOmSjFRh/VdQ==
X-Google-Smtp-Source: AGHT+IGITqnLSZe5l+7etzvhzroQHna/M/HVzTNKdMHK/dXyTko/6BgWEkcunj8SSBiZwLXiTntYWQ==
X-Received: by 2002:a05:6a20:d501:b0:1d9:21fb:d31f with SMTP id
 adf61e73a8af0-1db91e8047bmr20758876637.45.1730679703426; 
 Sun, 03 Nov 2024 16:21:43 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 42/67] target/ppc: combine multiple ail checks into one
Date: Mon,  4 Nov 2024 10:18:31 +1000
Message-ID: <20241104001900.682660-43-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

ppc_excp_apply_ail has multiple if-checks for ail which is un-necessary.
Combine them as appropriate.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2806afd9bd..70daa5076a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -324,10 +324,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int excp, target_ulong msr,
         }
 
         ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
-        if (ail == 0) {
-            return;
-        }
-        if (ail == 1) {
+        if (ail == 0 || ail == 1) {
             /* AIL=1 is reserved, treat it like AIL=0 */
             return;
         }
@@ -351,10 +348,7 @@ static void ppc_excp_apply_ail(PowerPCCPU *cpu, int excp, target_ulong msr,
         } else {
             ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
         }
-        if (ail == 0) {
-            return;
-        }
-        if (ail == 1 || ail == 2) {
+        if (ail == 0 || ail == 1 || ail == 2) {
             /* AIL=1 and AIL=2 are reserved, treat them like AIL=0 */
             return;
         }
-- 
2.45.2


