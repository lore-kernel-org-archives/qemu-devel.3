Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244D3C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpT-00008q-4c; Fri, 21 Mar 2025 02:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVo5-0007yS-M3; Fri, 21 Mar 2025 02:24:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVo4-0002zJ-6f; Fri, 21 Mar 2025 02:24:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2241053582dso39366895ad.1; 
 Thu, 20 Mar 2025 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538274; x=1743143074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=we644wfM+ubmYaOXPQgkcVl1QFMKHObsCG66v2LC+OY=;
 b=bO3uX7D6BkAow82ZbaeGZzyO3yPBzvOmtn7RISu1/OtVlZgclzOtFckQK3bco2mFVn
 t5jgEH+ifpAXtgwiGJCD5HZkgn+58/rEJqPUFj6fJwKeFXeOz8fpAfy6gG26irNWfdqK
 VUKYjktHmUL/351ddcdxSO4Ml4O9jvNlZkGU+9WJOfnGSfTLGnm5jj4lyWEOqlPrPu+R
 v5PaOEmoOSJIgwfNRwJ4exSK7U7CVFiaOLlbkzcLGcmKzmFQTg9mRNna0aLuIMoO1l2v
 BO5rs0B9aaKJmM0X6SsP3mVr7ik45LW2KmoaHNcl9rTbyNmZO9xtuCRqtb4geseVSkcm
 ladg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538274; x=1743143074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=we644wfM+ubmYaOXPQgkcVl1QFMKHObsCG66v2LC+OY=;
 b=sDw9rFagRuTbQ558d6aNBtfZvkK4rBGylm/GR8EPgDGMZ3ipr607fqt1MthDTODvYv
 jZ26o+bnPlqXeEGA7TONoOrkPR+7HWsz+NncyD/IYSKtnKuLaXgxd8fLKJeJAgVL/9qb
 EevtwDSMMS34RD9cTovAD6t0I9xTB62ziOKfdQhbgXwEHt/AvmyJJ0jNZSAqbluxTun7
 C/yj9TPzE9wpbNk+2sg2XOMAmyvV56EP/RonC7wrcnwDiObYvxNg85S8Hp3zu4ch4n74
 kqekyAKcUkJM5LwPvYxK9zTlh2kQaMJKId3iiATMLZUSj7BLXV1n6YiQDLbCq/Q8B4rj
 IOUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF9L1L+60rlBDROMP+OklDwSLrdPowIzE7WUUTiPmIXHlSOyV7BtwciNnV/tkzedsgKVvA0pJHuw==@nongnu.org
X-Gm-Message-State: AOJu0Yz7QcDQ19K66bcSuLJnQtAIEYFd8uMG85U0UZvpYOQVwllxj6Fy
 hH44jnj2Y8wNvUCniFbvnhMCnJjd73d/0jdUb+OEXe7DTjMDgJPKPW4yOQ==
X-Gm-Gg: ASbGncv3S5LPz/IcnfaVdt2LhazeIe0uJsMLyKaY5rwFlY/41mMabsXUhLCxfFyBz/r
 wH7EYCOLFaaZUmlWQbtowb396JaCxGQwWgFCEyupFBSD64tesaE0DTe9MNXjJ59PWlVGHk30+dC
 YHyvQStF2hQtqQ7Xq88uvSadYO9bziSjtgk2DB6pzkJsa8TFpdQhbD4aLJxEoE5vJ8E1J8lbwHC
 lD3ySPGAy2aJyqGU84LTRoPtxI+U8AvTW6is7Y7YZ8i0OBLIwEKpCeaUhtNbAAAMF4EJKuzvFqc
 7GFauUMLr2FCZDhk+jkBKNPSvwRNpqTTxqtDm2oYu+IA7ftt5A==
X-Google-Smtp-Source: AGHT+IGra9o/v0JuvnHMxWc/hMtROGCyFdm0hXo/easVMP1XHkFSGzOp6DHmX9NSi9n8K2LXJi/E/A==
X-Received: by 2002:a05:6a20:a10c:b0:1f5:5614:18d3 with SMTP id
 adf61e73a8af0-1fe42f07bb6mr4112698637.8.1742538273802; 
 Thu, 20 Mar 2025 23:24:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 02/12] ppc/xive: Fix typo in crowd block level calculation
Date: Fri, 21 Mar 2025 16:24:06 +1000
Message-ID: <20250321062421.116129-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
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

I introduced this bug when "tidying" the original patch, not Frederic.
Paper bag for me.

Fixes: 9cb7f6ebed60 ("ppc/xive2: Support group-matching when looking for target")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c77df2c1f8..e86f274932 100644
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


