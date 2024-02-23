Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E25C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXy4-0006S6-Pi; Fri, 23 Feb 2024 11:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkY-0007pA-On; Fri, 23 Feb 2024 10:46:10 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXkX-0006kC-Af; Fri, 23 Feb 2024 10:46:10 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d911c2103aso2962035ad.0; 
 Fri, 23 Feb 2024 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703167; x=1709307967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riaL4bBi2Km9JTxExie0v3jTFoU1wbNnTnAEl0s+MTk=;
 b=VxLXarSMExff3YfzO3gJuzbH9i9qhUuCdPusr5tb5UU9XgqU6GXlrak30p7Jy9lMoV
 oU6F95nByauv8Q3+ufjFBRc9QHeDEud+ZM6lVW7VsQND2s3EWpYNmwSpmIEwn6VY7tX5
 3p6uDIBpX1yvtNKmyR9XH8aLkexFt4++mhNXFRIdBZ+r4SnkiecLePfo11taxXcvzggF
 MSBXXZ1cL+cnWirYNozffNnp32cqbZh4l53WF9OcYVGYfbm2XWllj2pMusi1s2CPSYcW
 xf8Xe5t0WGl2yk84E/Wnq8tZTqrLM12EkF9RJu0rmenlDGyvgsWTBXtHyQuhh1rZChx+
 dCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703167; x=1709307967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riaL4bBi2Km9JTxExie0v3jTFoU1wbNnTnAEl0s+MTk=;
 b=DN/VlphrB3Zo1WlWeG44XhMt3e4WK1Q8G6hqoX8KpP+Yu+dZ86LsmBenHlv3KN89FD
 fY3mcXOMlflrRoa7mE2CXaUZnJ/qvsSCqBeGXzizDuDzVtcFG3BSVxQHj3Yw/8CrwVvy
 wTOGEB4Hu/KaD3Dwl8/qNAnva4f5UeOfDFVQmqBE4Bl7ySH3TlpSukHwEsNZgcnn4Je9
 4KWwtiG7Ne/FZTZm2u+HLUWj+or7NdcEouHWCIyiTkrRVNE18Fz3QlAW6T8LlMu5oV8b
 bf/yMf8xYgP04pjp/XEQZgvyDL9tQcD50brDysuTgHnPf7DM7qm8mJt/o1Dd3ePlyMgh
 SCaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX79u0HZwTcX/qFwbkoed6x/x8rpIox0eaheHvSyOQ02i5UqMMVwBwW5kUjC/O53bgbJ6BGBp4tdV900pCFULUEFhag
X-Gm-Message-State: AOJu0YxjjFO7gbTFNfJDDSNBsw4oKZrfacsAa/5pNAPEuPqjUzZn2Ex9
 ME7TJL59MxVjWc4mLwwDGQuMOiuHZFzWipCwj8Gb4DJOd6VanFfuo/+U+WXx
X-Google-Smtp-Source: AGHT+IEDj+BWWAHuHAx8scE99T4ca0Xhtj3nVnkd95VePsyP56fvmAwydnuRgEksIfmBIPRjr4PyGA==
X-Received: by 2002:a17:902:e887:b0:1db:efef:f912 with SMTP id
 w7-20020a170902e88700b001dbefeff912mr321281plg.2.1708703167306; 
 Fri, 23 Feb 2024 07:46:07 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:46:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 46/47] target/ppc: 440 optimise tlbwe TLB flushing
Date: Sat, 24 Feb 2024 01:42:05 +1000
Message-ID: <20240223154211.1001692-47-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Have 440 tlbwe flush only the range corresponding to the addresses
covered by the software TLB entry being modified rather than the
entire TLB. This matches what 4xx does.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 923779d052..ba965f1779 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -864,7 +864,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
 
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        tlb_flush(env_cpu(env));
+        ppcemb_tlb_flush(env_cpu(env), tlb);
     }
 
     switch (word) {
-- 
2.42.0


