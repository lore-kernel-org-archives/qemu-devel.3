Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E1C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIJ-0000vx-MO; Fri, 07 Mar 2025 10:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZII-0000vk-CI
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIG-0008E7-Ow
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:22 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so1104530f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360039; x=1741964839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VbVylxx7Oy35uID6Gb8pD3yEbXq+7FDTy6cITNgisqM=;
 b=dx8rS4Hie8Ieaf7bk68NreSj6UMSJPvsnftjQRweLEqIAX/OhJHzL6ll9uy7fE93SM
 i15PNENIFT/BrYdC0ke9XtE9WF8Wr0wgoUF7P4rhwK8cGlYiQ1/pyJIvI86rxHZgzkCV
 MQdWH0cU4jlqOYwpFidnX3y5b/Y/fSoRe9OcaO/Kq0r/nv66S4u2m8AGKrg95ThxStBP
 bR8AG46CV2kEfvl7nM3ANrwpjCBnDa2gFiGwzjwtUdQ4hjNYRRmBr26TV2DpaHcy7q8h
 m6JO6Lzun7h2+28WrNxDMIvYT5XViPOPZIxY0uT9L1Lkmd4YDgNS23bBTWdBBm07J3Ih
 +m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360039; x=1741964839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbVylxx7Oy35uID6Gb8pD3yEbXq+7FDTy6cITNgisqM=;
 b=qHMEIBuxjMepsGJ+cegNQsgJV4UBsQmyBjbiWC4vfHQm4NW7DU5GaVhiE7Y2ZPT5Fz
 MZNfwjrkyQ/R6VRMywODpZOx4k/pZUjiKKXmxbcqSvpEnhQOQQ3iMwyryxaKBOSqLQuX
 2v8UTEL5MMPlHPSZyjoT8dIlRx428Zi9aPxWwInCgB8Q2QGE+g+OFDBudnYrb1n69YEo
 gkxGKVh7ZwIZeONjYpg5sXFYF7mOq49XR8v+IwhRYL+Q9fVf5sYJt4+OOZjI6TWe34HW
 YZKLAe1qMrUBnxRAWVqvI6KleBv7HaYvrTEo0c3ZBEAFPmZ5b472A5FXr6Y5KjZq7JfE
 o0CA==
X-Gm-Message-State: AOJu0YySm1R77czk0qbj7s/sTvlXcg0g+YHwwV71lQUmRWYZqNT2M5+M
 psL/DKeCkkCdRJkUXCT8XoaQYYdHaJd8GrJqKICnezq2OuNjsL0XdehRdoWvDeNCMZiNyeW8EC9
 U
X-Gm-Gg: ASbGncutfU0T2NeFzo8gk9Tb+GAJoXZEvYiRST4jdbiStYuEEYCHw+SALaupsp17A+/
 vELILVZlacfzmld+pCVoHlaRDwfnR95o7tWg/LuyLaahdwX/FrGn9mTKzTZDU89y+mMc9WSTft8
 ZXF33Ryfxp9dBSO9K8bnly7yoimOS69TSSPJ0Mocz1CdThuf/LRpmUJ06e4E0Kxr29JYjd0ixZR
 HS681b12X9KGepIaaOfpoxZ2UD9Fe2g0MSKcQsxYXq8CxgDmbx6RK9Y/FHop0XGeCk0Zw+Yo7eJ
 nJtSk4GP5Tz98+1DvY59VPalqCS3W1NEx4OgTgTLr9PI0vN4bVo=
X-Google-Smtp-Source: AGHT+IHyKFXOQgw16Y0nXzYfusGTTKpDgwYshyR4GFm4+pfeoxiLVq4bsjiVSoxLMqbNVZmgq4qzkA==
X-Received: by 2002:a05:6000:2ac:b0:390:eb6f:46bf with SMTP id
 ffacd0b85a97d-39132d08dc1mr3154867f8f.5.1741360039128; 
 Fri, 07 Mar 2025 07:07:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] target/arm: Make CNTPS_* UNDEF from Secure EL1 when
 Secure EL2 is enabled
Date: Fri,  7 Mar 2025 15:06:53 +0000
Message-ID: <20250307150708.3222813-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

When we added Secure EL2 support, we missed that this needs an update
to the access code for the EL3 physical timer registers.  These are
supposed to UNDEF from Secure EL1 when Secure EL2 is enabled.

(Note for stable backporting: for backports to branches where
CP_ACCESS_UNDEFINED is not defined, the old name to use instead
is CP_ACCESS_TRAP_UNCATEGORIZED.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5729b313f84..5b6de446ace 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2387,6 +2387,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         if (!arm_is_secure(env)) {
             return CP_ACCESS_UNDEFINED;
         }
+        if (arm_is_el2_enabled(env)) {
+            return CP_ACCESS_UNDEFINED;
+        }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
         }
-- 
2.43.0


