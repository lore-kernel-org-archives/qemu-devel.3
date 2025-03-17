Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D99C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2xK-0006gn-ME; Mon, 17 Mar 2025 01:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xF-0006fB-KI; Mon, 17 Mar 2025 01:24:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tu2xE-0007no-68; Mon, 17 Mar 2025 01:24:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2232aead377so86267215ad.0; 
 Sun, 16 Mar 2025 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742189038; x=1742793838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCQzO/RWV9mKGsPnnGRAGAxs7AhCxziXIi4niuyH6/o=;
 b=Mr9rRtd3EYa61+L8n01pdFg0rbBl9cYGPePNLYa7lJOpT+yVG58B4Ho5EySGmjgLbN
 OA2CLqc8bOur8TLn9v+88dpe8eIk9u+2pBPmURD7Z+ZO1o4o7bktae2dX8qXp887r9DF
 mZaYpY8+Oeoz4S3eOjOU6QrspiTUy5OvMgVMz6UcCCS8PDjBI1kA+mFz/MKgohSrXRWD
 Ying49Vg7ix7IjPE4BQIOsJNifQcnimg9gT6Fhq2dix6Oqarz2/LXO9MbPB5A9V8+PTN
 eZpcKzWUk5f/9PlZ4wIEUyPTL9xDfEs3aPV+TfK1vy+Rz4mo8PCf1+1AIp46KGz4fWmI
 B0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742189038; x=1742793838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCQzO/RWV9mKGsPnnGRAGAxs7AhCxziXIi4niuyH6/o=;
 b=Bw6LAJ/p+o0IcI/ySLQ5Gatkq8jjYqQQJ3Db7uo5J0TaMWQqiEtKIKHdL7GzhD3cB0
 cZwc3cR4BMDuor4sO5IjuNc+FjMFWA9zog1Hh0IAvrOGnvALLtkdTzuchw7mx2tX4v4e
 ++ok+lUQy3jEvsUQmCAQ6pgpICLCjxuCs198J2TPUB3WlaVNOt85kaC+LODsCBMcvqot
 XkOMF0pHSXDC0ejjQ7cnoD2KN5NCqTnV/X1KKnuq0oL1kIxbxYym9rThr2mslhos9FdV
 8Nldb8F/lrg8qd/2jylRUrLMUdD71TverPePqbfrTN7/XzPgSCTkAgsgSgfce2IPSR/v
 0LzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6VE9WdTp0/2T+chFK5kSRozL/U9hTzRcD3zQDmFB9MfLbv46nJCEpdu9/TdYE4xnn3tWs7ZfyIg==@nongnu.org
X-Gm-Message-State: AOJu0YzrjwcA6Rb8P2r2kD7CKpFUt5yQO/jVvi7pu2lh/s5GpIVwLEb/
 lOPfclosd1GqxFpTCeMnzVXROLHNnWptcStEL1f3VrbuTxfXRQc6NbwBsA==
X-Gm-Gg: ASbGnctTj0nTP37IKPUObEdUBEM4TrGI/mRtSNzLtCO1iVv7MOvACxQf5BqEWMjOA67
 HbU7UT5dBa6/PgqFhKOJayrkEl/SERYBEl135t0TUfYaMYVAQJq1t/Zxqa81rmEYvKceDbLuotB
 HY67ErqOJHgJr0eCdye4oui/MaoIOu0AkONZfCqcXL7cQrZdlNGJ+LnNQl3ZohSXoxvJHbLAg7e
 JDuoOA/mME/EyoZUoQIOelM1vWtTzI9lOL6f9Dei9zcCtYK2UjpuzuX/RvGi25917qJBcXe0afK
 shHRP4dLiat3HHJwiwcYTPDO3OoRmfAB/7smjK8BgEuyxvAZVn20HH3MNZBu
X-Google-Smtp-Source: AGHT+IF5qNYq1eMrY99ebl6tU0UfyeHKpZgx3juxDS6gerqVLJCtDB4d2kkvMa7Y9q3ZDxyjt8FSPw==
X-Received: by 2002:a05:6a20:d74d:b0:1f5:8eb1:d5d2 with SMTP id
 adf61e73a8af0-1f5c114b9a0mr14828867637.13.1742189038499; 
 Sun, 16 Mar 2025 22:23:58 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b6bsm6879495b3a.148.2025.03.16.22.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:23:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/6] ppc/xive2: Fix logical / bitwise comparison typo
Date: Mon, 17 Mar 2025 15:23:35 +1000
Message-ID: <20250317052339.1108322-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317052339.1108322-1-npiggin@gmail.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

The comparison as written is always false (perhaps confusingly, because
the functions/macros are not really booleans but return 0 or the tested
bit value). Change to use logical-and.

Resolves: Coverity CID 1593721
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 311b42e15d3..7d584dfafaf 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1344,7 +1344,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
-    if (xive2_end_is_crowd(&end) & !xive2_end_is_ignore(&end)) {
+    if (xive2_end_is_crowd(&end) && !xive2_end_is_ignore(&end)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "XIVE: invalid END, 'crowd' bit requires 'ignore' bit\n");
         return;
-- 
2.47.1


