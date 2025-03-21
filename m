Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE69C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVrS-0003pG-Gd; Fri, 21 Mar 2025 02:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVos-0008W1-Kf; Fri, 21 Mar 2025 02:25:29 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVob-0003GD-OP; Fri, 21 Mar 2025 02:25:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2243803b776so2747625ad.0; 
 Thu, 20 Mar 2025 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538306; x=1743143106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24gnmUrT5i08RUn4/4zRaCLV4SSfI5SdNAnq4FqL/eQ=;
 b=moTed/O+oE3pqiNy3tMzT36JQAamRraMgtQm+fDx11yzXfgrDZwRCnXoRQjcaRVaul
 rkCMFMvbva9uPJ2Uhg9YsKBZmSYLYemyGU3vbPh2SEjwsxkzM4gHE1JAGAxrlIQMmECK
 srGtOqr2+PIpG8b7MWyEml+sTXKEK2kDBtptP+X4mnbiXmqA2dCFeorKJxxi22+/3WO6
 BmHD92IxluASZQdlrfspQzO7ziJO3pgu4AkSH8xtZ97JCrtYQWk4BWsuUqVfazAQ3ogu
 t4RBNHsc6QObDbw0QGFKfvgo7z+iqZLaO4D7KunVaiTIJTw9QdJkIx2L6UvgHA5uVI7b
 sqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538306; x=1743143106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24gnmUrT5i08RUn4/4zRaCLV4SSfI5SdNAnq4FqL/eQ=;
 b=vvC8dzQoJLnzE/Z9av4zF8A7YkCJo6KLv42N40nYseWYU6yp1Jx+iXYNldF3w2EEX9
 qkbappzgEpps695Eqok4qMkPAdf5pF1o+3pEw4XFadR6IvIdfoFLCuL6nb97ejVcXKAa
 phbrwcDFN4HM3CjzbUn7+1gTjtiaBbRH82dksYewJSt+uSIacybev7OCgbZRxwiXtwOI
 QU9/WbP04t1982NoxCh/T4lpZBPAFwu7D1oBP71rqDqZ+LPQYWsU5Bai0aPPO9dEef2+
 9O6PLNJe6MS2vHMQErQhCA/SCncwZA5L3qxUed8Jf8+hBMScEllunuScbW8nTAqZTASs
 8CXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM+CU7yV5KiK5gEdR93Mi4ThQAIuODknNuTwSM9vPmba3tdrykrJwU0yjZ9VVOHIXY1G3hahWVnKSpsVo=@nongnu.org,
 AJvYcCVO/P9YOGykxmkCCFXGNJIWwBlTRKpJDqgD1eUsySgRD1OGglvEmEPzBG+5Xm8RX8DZbVFCL5POTg==@nongnu.org
X-Gm-Message-State: AOJu0YzLGeq+tO56QFPNCl0vaQWS2iZNN5o5kJ75F/AQXM0RW8I4fqV3
 LJrPuXZBo5aATD1zcjn/8/VZkXj2evL/u3HvIGq5srsfYcnkwKR9aCGb+Q==
X-Gm-Gg: ASbGncumqnP+7Ws/VNQ5ADwSzWWTczxfA7GO0z5k/ZPceI6A7q57wcOd8P1MY5b3vvH
 6r3dPYB7yn9SW3cciMjFPG+VNDhPmQ9tEwTRLTNv1G44IZIObwYTyW3+Uyvfwg4+oFdiAnkcb8R
 MTEy5dRzHXAFQZ31+TMxSY+zUFxMLbhyAZQmaFu3cg4xLQyHo0oDHxB51jKZydmGclLf814vGCw
 w6WdeGsezWT8iK4mRxxzODpvT7ObWcarMpQLqIKhHv2W9h8+HDPeG2F49ly/1li/d2t9ty5QE3i
 AH5dOAVURDrmaullYfSXo6WVJriFDeouU/GPpdYGNlgsphHAbw==
X-Google-Smtp-Source: AGHT+IFvphionuusYD9iRNTfrF/Xp32lZfLaPckWOPBQ/idE4kcPqk59rep4PJ4Gu/NB5/z7BO00EA==
X-Received: by 2002:a05:6a21:b90:b0:1ee:dded:e5b with SMTP id
 adf61e73a8af0-1fe42f9bb33mr4381619637.24.1742538305821; 
 Thu, 20 Mar 2025 23:25:05 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:25:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Roman Kapl <rka@sysgo.com>, qemu-stable@nongnu.org
Subject: [PULL 12/12] target/ppc: Fix e200 duplicate SPRs
Date: Fri, 21 Mar 2025 16:24:16 +1000
Message-ID: <20250321062421.116129-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

DSRR0/1 registers are in the BookE ISA not e200 specific, so
remove the duplicate e200 register definitions.

Cc: Roman Kapl <rka@sysgo.com>
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2768
Fixes: 0e3bf4890906 ("ppc: add DBCR based debugging")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17..7decc09aec 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2744,14 +2744,6 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000); /* TOFIX */
-    spr_register(env, SPR_BOOKE_DSRR0, "DSRR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-    spr_register(env, SPR_BOOKE_DSRR1, "DSRR1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
 
     init_tlbs_emb(env);
     init_excp_e200(env, 0xFFFF0000UL);
-- 
2.47.1


