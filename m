Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB9D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kpK-0007fx-Vn; Sun, 03 Nov 2024 19:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpJ-0007fZ-HV; Sun, 03 Nov 2024 19:20:13 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpI-0002ZD-3a; Sun, 03 Nov 2024 19:20:13 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a6af694220so9881845ab.1; 
 Sun, 03 Nov 2024 16:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679610; x=1731284410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTPOuJL+gEDvzg99HYFtkObHP58qYB3o1L++xvixkVI=;
 b=akslZIp5P2K3gctEg5ZurbB5cBSIOfDzEtMUXZM0ZtuuswacZO6rKzkSiy3ETt/0Fz
 f+b7Az8LpG+WKENYWqVmViQo+7NDldnSDaf3o5CbdUbPyiImk2I/fYtD6OqQsFUemIoh
 ZdOynUbMOcGb26UKDFnbhsHCDUClYpGwM+30JnzyRR6bIIv13HbGUtsDRy1MlJ2d+3ih
 fgZsj9w90LUFN2A2bJJdSD+yElrrfAWYCSDl8HBL0lSAcQpGGIRrD9x3q7ilKj2mpE1x
 CctRbH/2LCnuDakDP2SkqEO/BsrGeg468gFsYCHNVim2D0lNrpbNaxzC2Scjbj0hoFNY
 n7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679610; x=1731284410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTPOuJL+gEDvzg99HYFtkObHP58qYB3o1L++xvixkVI=;
 b=D1WWb9TihzLjLIuqhE4JZiZoXbKl9/14N0WyFX7fG+YtPl3zm8tlBtcT0kz7ahxrbq
 nm8eGuZhlbI4zPAuT6wziSnAHJwRwTrndte2PV/2vjcStQGlWh1oWof9+3oaPMdtsS38
 olI/AYQ2NuvSdOaAegZj2u49k30ScnDA+CRfGw8O8432PjoDTFJ5yXzCfZftKU5KoP3e
 aznWnWQwEwPE9vwSMoozMpKuyoA+4sTU01S0Al370b6HY0Em9RFTIH/Og7ibcxTLMeqq
 m+R6fDQQVR2Sr0BoyLIDERdeH5D+e51o+9eDcW+gGAFYp4m9eJFW3NeOI6Ua/KBE60vn
 PHeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUaeG3YfyfvTTGbfBKq09RKBqHjg2n014aFaXTNml/6iim+S0hHLCKoAomhoOY0evjwfFOws+N5g==@nongnu.org
X-Gm-Message-State: AOJu0Yy2t2TkwqWqj1knW13jHYzLCFATvIPsww9CMKBF4s/msfb6nglI
 yXptOZRJaMK+F4VxjQ81rcgSy2y5ugxr3W/v9gaKSvb2F0U8oaymQ2oD4A==
X-Google-Smtp-Source: AGHT+IEateCgHg4ilbu4YSkbnBLgK+EbtZ3L33Np7kbIZG6OAfQu3BBu4eeNV/ij7rzWNp1yeOjAAg==
X-Received: by 2002:a92:ca4a:0:b0:3a0:9c20:8070 with SMTP id
 e9e14a558f8ab-3a6b03b0c7emr101783335ab.20.1730679610129; 
 Sun, 03 Nov 2024 16:20:10 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/67] hw/ppc: fix decrementer with BookE timers
Date: Mon,  4 Nov 2024 10:18:05 +1000
Message-ID: <20241104001900.682660-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12a.google.com
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

From: Clément Chigot <chigot@adacore.com>

The BookE decrementer stops at 0, meaning that it won't decremented
towards "negative" values. However, the current logic is inverted: decr
is updated solely when the resulting value would be negative.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Fixes: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fde4619412..b86b5847de 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -728,7 +728,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
     int64_t decr;
 
     n = ns_to_tb(tb_env->decr_freq, now);
-    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
+
+    /* BookE timers stop when reaching 0.  */
+    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
     } else {
         decr = next - n;
-- 
2.45.2


