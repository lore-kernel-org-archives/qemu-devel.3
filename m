Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C70CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnK-0007sz-JU; Wed, 24 Sep 2025 15:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ult-0006ut-Ru
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujr-0007nr-W4
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77dedf198d4so243797b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740471; x=1759345271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sVOgytoa7Rgm1zLxtei1J/KNHixNy8iKKKriI6vpRg=;
 b=HYXQ9sOiJ3HOjEpbKygd7SJeTrFBTm4jEBRMS34lLPmvl/El1DcTWhiGtCZbtP27iz
 BkUvTWXcB45AjIca/QzO5CVWiaktx3worELqF3MEwajp5LcLjMbPC6LVnZfBaPYJhwHD
 +6GHQ57sPPHH1ROa5BauYXtIjWHVrRxILTM9iJ42dmioz++7RHBLdIBi1siBCcsMOFTe
 BLUOU+dB05D5sXPjJOEigmKSjSTfQhPF4dAdRZFUOvCFRk1Rf81l06amUJwMnNmpQtGG
 38/coicfMshJlG8zWl4xA+F6zmTBye7FdgL7Bn9fok/LbLhuYg/Z+LfVBMRekfLpO1h1
 xQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740471; x=1759345271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sVOgytoa7Rgm1zLxtei1J/KNHixNy8iKKKriI6vpRg=;
 b=P7rG9GgO2WqP9PfPV2ovwMklajtCW8CBZFzz0MT9qIG7fzZSioBE/RRtbINcuq2155
 t4B1mzdJabgtcIlWVOdpHgcKIge1Ej/RuU4KAsAplI9pM7nRWIE9xG0ikWOIApHptCyX
 yzch4RrM5EwbpSTB1SdDQIVajProz9Eeq3kTwkCtnvGRMbAXRzWgNhkMB4eGWXWr4MzN
 l7zh3kDOw/hu2tnMETrvsWTeFwRyH4UtuPSleHYpCWQlmAo6k3iE0Y8n+ipoMJaIrvbh
 LhpT8JH5evsPemCVC388X2vCLC/AKJyUTmPBw8GVF6+Vky9Tymtyja3aUPGTOYw0BL2Z
 8SMQ==
X-Gm-Message-State: AOJu0YzM8jXTznS4SlUOewRX6pJ8PRqLDUFKGwcLcGLqJmypYW753DXo
 p//GD3u0bYsr3UXDtI4apklj2J37koHIASin/Y+0Mc2xsUlCnNKTgbfWx4SKTIplW7i0qFoFH6/
 cjm+e
X-Gm-Gg: ASbGncuVZCbSf6pdjM46ctDbHGgwBBWCiKYXOTYLJwAu+/sbbAzNMsCQaW2WK/NV4tQ
 YUbMdpVOipFCh9wEfNtSDAKIl4jDeRff+1hhotGEfQAryKfZ4Sy3TgrWi9WAl3vlTGqZFP6jLra
 JfDjzbQ5JxIDZQwskRIzpLDyB8GS32720ecggMX49fPsqM7AZ/AFDByGuUQ4PjGDjYIz5sdNILN
 KrPQAh5z0EqgjRWw7Me0TMlS7dSOICbTpkkm70mEilGjn6NKTWNrUyxFILWk0pEpZ7uGsQMzBB4
 1X2TgRXkJKaEvioh+atDh7x+AJZWNUOrBiWZhnmRwTLG73G1f/EcsRRNlX8z4DhAsGOjIHIB6iX
 1imQmkiq29WgkkejmpYEAq0GkOj8mwuhrlXkEh2c=
X-Google-Smtp-Source: AGHT+IHkTtADfpDj192DFR85ALfv8TRlTc4V0tyv17yl2NVZt1JQzIp60Fsy5DKrVt3XVtGUW+1xJg==
X-Received: by 2002:a17:90b:3846:b0:32e:6156:3571 with SMTP id
 98e67ed59e1d1-3342a2d9b93mr640800a91.18.1758740469409; 
 Wed, 24 Sep 2025 12:01:09 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] linux-user: Populate vdso_sigreturn_region_{start,
 end} from sigtramp page
Date: Wed, 24 Sep 2025 12:00:36 -0700
Message-ID: <20250924190106.7089-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

When a target does not support a vdso, we generate a sigtramp page.
The only thing on this page is a (set of) signal return syscalls.
We do not need to narrowly restrict the vdso_sigreturn_region;
simply record the entire page for all such targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 28f0909d1a..1370ec59be 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1974,6 +1974,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 
         setup_sigtramp(tramp_page);
         target_mprotect(tramp_page, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC);
+        vdso_sigreturn_region_start = tramp_page;
+        vdso_sigreturn_region_end = tramp_page + TARGET_PAGE_SIZE;
     }
 
     bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &ehdr, info,
-- 
2.43.0


