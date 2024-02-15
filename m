Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB84C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6k-0002Fe-49; Thu, 15 Feb 2024 01:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6i-0002FE-BE
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6g-0005KJ-Nv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so3822795ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978025; x=1708582825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4czMnwy4ONozXZRRucTuxGhHSF3+8ljKdOePhx3D1do=;
 b=cNoxOKojC4UzF4AI7na1FxJY3m+K4nHX7XgnBCbuMD6ROJIsL87b5JC5wJQHTVuTOu
 1vbHxKLb+Jx3fivdH/YzcnFTaNzLE6Q9HSIxEuLvhERzFCur+qqCJLo9rbuRhsUhmMZG
 akU7NT5PbdDenhOlQaDqhW0uINQuoJ9pmAKp2fZ9uMOqQj24w7M3UOlD8WLQLZU7j1u4
 YPcnRkst3Dh31yU2H07Mhn/Mk7v3S2p246opv5g6l2Av9V33ihg9CtSsViiozHwhioWc
 uIloU01jvGekARzCtVv5+CknWYl5v06ou7b5kICQCdd1JYHCnSLheKILsiLtBad2P05K
 rYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978025; x=1708582825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4czMnwy4ONozXZRRucTuxGhHSF3+8ljKdOePhx3D1do=;
 b=ZwLsXbXtiBjXYQrXDWUJzWVpYLh7ineZEglHxiRO+WNF0Evbnx3CurFN1rl4an4VFC
 4n7QJOx/fBlvD1vlMQsotYvypCvwgzydmA+/OO4rdFILNtNs7Mxr0Aon+kYHCcEoLII0
 TzZ+SgrMVihvTPHZMUf9aM8h/pgHY7sRqvKrI4Fh4ODmOXSnBk25Cg9I0YPgSCNANlmx
 0OxGGGdixqa1mYKduZ66HM3qi5JebUNe7Kg1zDIlnLlcb30hVnv0s4+K96Qd9RedORLL
 LKNUY/QJUOVz6Pd8p/Vr7CikxyBM0xTfnh22CThJiUUcafG+otlaqjjJrMFCfGTNa45p
 maDA==
X-Gm-Message-State: AOJu0YwoGFWgUq8iGS7DKboDwWFtsi+yz0uAIrgP9TnFRQZU/7trk5ug
 g/YUOFUgOEVkO7Jt8J6Hx6EaYzfIED4SVnTkUmN+PZBxDZUD9vD4OMxrq7lbiAnSonaff1+i5uk
 F
X-Google-Smtp-Source: AGHT+IEuFWdY2rlfZm1CLsQaVYHVLx7Vgf3y3H8w4YLdsvzH98Uo9ieGUP7F6z9EmfSVMJ5FkZuoPQ==
X-Received: by 2002:a17:903:183:b0:1d9:d300:a670 with SMTP id
 z3-20020a170903018300b001d9d300a670mr1083474plg.15.1707978025383; 
 Wed, 14 Feb 2024 22:20:25 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 03/36] linux-user: Remove qemu_host_page_{size,
 mask} in probe_guest_base
Date: Wed, 14 Feb 2024 20:19:45 -1000
Message-Id: <20240215062018.795056-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The host SHMLBA is by definition a multiple of the host page size.
Thus the remaining component of qemu_host_page_size is the
target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-4-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e918a13748..e84a201448 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2893,7 +2893,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
 
     /* Add any HI_COMMPAGE not covered by reserved_va. */
     if (reserved_va < HI_COMMPAGE) {
-        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
+        ga->bounds[n][0] = HI_COMMPAGE & qemu_real_host_page_mask();
         ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
         n++;
     }
@@ -3075,7 +3075,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
                       abi_ulong guest_hiaddr)
 {
     /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
     if (reserved_va) {
-- 
2.34.1


