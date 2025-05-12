Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BAAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJa8-0007Mw-IZ; Sun, 11 May 2025 23:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJa6-0007L8-3J; Sun, 11 May 2025 23:11:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJa3-0006m8-R8; Sun, 11 May 2025 23:11:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7423fadbe77so2211259b3a.3; 
 Sun, 11 May 2025 20:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019510; x=1747624310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufxfyX82wxmlkRrtsHa/uskh1Et38MelMXdT7cJMY0s=;
 b=bbPwYd44kt6U0gHA08bmaBOb/O2B/+ZfIiwln6bL1KKwee96sNc18zrAE8XfWIt+ds
 mR0ESfB7Jd5FxK/NiEe18bkC2JN1DxkVuAzGHIPBa7SUJ7OKHMtkAQ7NzODWJOvwkJE7
 n+SWxYF9lELJTggho00CxSUs+mlk9V7w3CBoXSQwPuLuAqa76z8OZ2MG8I453OQ+y0nx
 bUSgaSRG6kn+G+gj9ADMcvRdNJ05rzRgge45Jndut4CRVoBBEo0DlzrEEVK4UdOtmKNz
 gosOg5cNx3c+nBPdvwmOZzraWGbUzKiP+ZOyonFGqvcZFL7d+isKMMPFkLsrR6DDWMGy
 0p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019510; x=1747624310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufxfyX82wxmlkRrtsHa/uskh1Et38MelMXdT7cJMY0s=;
 b=ZKlGqgCWzBhhPB1riDckYz+3etv/nlJxjEn2kNBBuLkeQDjbtoCPWn4V6y7ULPWvJe
 XEB6+HPq7yWdYwfNJsvAHUXdXqXizHNAoK/M2c6Kq8eeHBsF9SxOAgLw/lErxgETwi6h
 4MS0qY3HK87UZUnfU2eJwRVuhuv6eZLh4Nqg6WPgH7y9y9v4te4iMzck/dy1FxfohWzE
 spFv4QpIm+yH2IRhVSxygGJi6TWh1YTaALybuapxV7Df8zdATR3uoVOx+BsTSLZpPAtc
 osReQgkH+pqywmPels2fhCQACuaCfbrN5KfAuBeBk9PWjXgToKJZI2heODCtNKY1Ayiy
 BUjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMBLVTqpV8KlusNuhlwo94APjoDl7+apZOWhzZ+cS1iCq9B/48rwdRCnm54MgWNMSwFtqzgm1QotLD@nongnu.org
X-Gm-Message-State: AOJu0YxrxNaiUwlGivdsnXVWzExemOjFzmDBRG/uvguO1upM/D2L1/xZ
 UcJW94vfnQlMx7BHhOkZgtGkLTHieoJdAq9bJ48P2AkfDNVJrFlV+ImyVQ==
X-Gm-Gg: ASbGncvLW0T3IunPFSxWJwWZK9vJwu2OYEhcU7z6xeOCa6cdOb0mzFMF6a1gFND200a
 n+sdu7fFriHk4UDQXiuXi4pdmoXqSMOG1pTqmmgTavpQPSdMC2HFDUh17LG9WiQ0NEA6Kv0ncBx
 3IrcZv5lqrefFxOSceRGvukDMTTdrcQc4sNFy1az9QO6GgyN7iWlkCTc4mP9Jkevn8m9P9yiGPr
 HsrN+/ykTL/Q8GwrWSK/jsn8mEcSqFZHBJLGfgiL8XL8GpiXermcxjwe7cFXr9Yy0sPimBFlSPK
 qtRamXNVAq8RA3oxfLxsAVZHIyghKz2UhXh792DY8yA1NgJk3dmq0zz5DQ==
X-Google-Smtp-Source: AGHT+IGcZc9NgtPlOzW0OwXgsgxuzgjOgd881Kf6i/X0WG2954Z5gXBWws4jVXuE5HtL4jzaHnXWOA==
X-Received: by 2002:a05:6a20:6a03:b0:1f5:85f9:4ce6 with SMTP id
 adf61e73a8af0-215abb03a15mr16015411637.11.1747019509964; 
 Sun, 11 May 2025 20:11:49 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 11/50] ppc/xive2: Do not present group interrupt on OS-push if
 precluded by CPPR
Date: Mon, 12 May 2025 13:10:20 +1000
Message-ID: <20250512031100.439842-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
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

Group interrupts should not be taken from the backlog and presented
if they are precluded by CPPR.

Fixes: 855434b3b8 ("ppc/xive2: Process group backlog when pushing an OS context")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 1971c05fa1..8ede95b671 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -845,7 +845,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
         group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
                                                   first_group, &group_level);
         regs[TM_LSMFB] = group_prio;
-        if (regs[TM_LGS] && group_prio < backlog_prio) {
+        if (regs[TM_LGS] && group_prio < backlog_prio &&
+            group_prio < regs[TM_CPPR]) {
+
             /* VP can take a group interrupt */
             xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
                                          group_prio, group_level);
-- 
2.47.1


