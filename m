Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E84CC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xJ-0006fc-Am; Mon, 17 Mar 2025 01:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2x8-0006dV-Tx; Mon, 17 Mar 2025 01:23:56 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2x7-0007nF-FS; Mon, 17 Mar 2025 01:23:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2235189adaeso65380475ad.0; 
 Sun, 16 Mar 2025 22:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189031; x=1742793831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1MB5EMdjVFVxNgGF88Q0t4+APTkh4DaVr1Cd/A8YJY=;
 b=cfIHsIt9DpVP2iRKCK0Dcuc+KDA3OYstLGlSbfi9ZkrHIjcSAje5wMqwlSeYpq5vDL
 B5h//H1WgjFFCKKVOzHxEZtHlxzJJsGRzsMsdyczYGkP9rPPDzBscBtJVrLTCgTALk3f
 j9j22xeUvmk0euNFZ/YzBp0mZhrvu9ZOLoDW4BBuwvtGNhHrF2uAYg0G5UeHmzzfcSZZ
 cW+eTlJx42hEai6dZVTexFMJ31BlAX6hUsY8ctKdVN3lKQAPgDHsJMJzhvjojdpZiWKc
 VrkRCc4cwyYI2HPwUnjdvW3AqcJ94v6IdpFQSuPYoEzcWtL/xbGPfQbDuz9YCCqYJ64f
 AkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189031; x=1742793831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1MB5EMdjVFVxNgGF88Q0t4+APTkh4DaVr1Cd/A8YJY=;
 b=sgp5csP15CJ+Y0uPGcO5opvksY5RnD5PyLj0UZVRpIJNB4GhZRK0ko4fHsjNXwVBHW
 ezt2LMjMA/H7vL/iSj3jTa66tHBJgV4KsEQZretg6QhHVh+dAR9cDu5nxpnOXNqULYFg
 8KmvTCGf6th+2JQnEa1BNeGrObd10wN0aubJBW/JQ3G8uEpvrNWVwmr1h2OeX/lU8Nsd
 H7S6hzABM8N9wicKzvPFspZRqVSqZV3cBLaVxJzDz5nTzzkr62kq1tqQHAsJf+jyXOPm
 7ymX4mUQ+3NKrnRsYg+2UxJ4UL250swZvFoEqbwaJyKZ8pZAPU/BORF1K31AyGgC13pN
 BAOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3myxs9w8Qtfy6sk5SKkv19LHzd8GVArQNgVpzeYFiIjLkPhIl2qExbj1fhzSxd1vIdjS/PxCn+Q==@nongnu.org
X-Gm-Message-State: AOJu0YwApI8wJ3+i9xadS7hcREj/1MLWWJDthuEuO/mNEEGmlm4GJsGB
 l2ULEejQmOj5SabBnAdqQ5UQBAN06BrclsRUpkYBQkVsP+pRAPCk/XiQUw==
X-Gm-Gg: ASbGnctw+DdzeC3Kp5AgZlDXg/8364UabirBqz0y6kJWBWAnr7uDUirEwptz9+FSTHL
 LAvp8tz71OIyzvIWIVisN6rYApAErzEevSf5idbt/gn/jOz495ZvwL+UVhtnBCRqtbddvBxirk+
 r83ERIqgT0TMetqvXYfVrsa1bUx6ks9BLbodlwnMo7snGFLAfC3kFIuvOK3D7kOWw3Xq1T98aBE
 ts5tQ2qC2egWGbb5Wp+MfuKLnJ12RRgjcywvFAGdiwBYTCYMOvXoChuU1SfEe6dw9ul1h646rdc
 1c8WJevjNGpYw1VKzUjz8jcV1QLTKIVIMyXVKEK8yoQctzICLQ==
X-Google-Smtp-Source: AGHT+IG4wYuVxZVKituNR6Ctui3omdzLfCBiSov8cpksGDEFvtQJUxY67UE795CY4SHBvLn5bM1FRQ==
X-Received: by 2002:a17:902:f681:b0:21f:6f33:f96 with SMTP id
 d9443c01a7336-225c651f518mr179898465ad.6.1742189031357; 
 Sun, 16 Mar 2025 22:23:51 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:23:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 1/6] ppc/xive: Fix typo in crowd block level calculation
Date: Mon, 17 Mar 2025 15:23:33 +1000
Message-ID: <20250317052339.1108322-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

I introduced this bug when "tidying" the original patch, not Frederic.
Paper bag for me.

Fixes: 9cb7f6ebed60 ("ppc/xive2: Support group-matching when looking for target")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c77df2c1f8c..e86f2749328 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1686,7 +1686,7 @@ static uint8_t xive_get_group_level(bool crowd, bool ignore,
          * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
          * HW will encode level 4 as the value 3.  See xive2_pgofnext().
          */
-        switch (level) {
+        switch (blk) {
         case 1:
         case 2:
             break;
-- 
2.47.1


