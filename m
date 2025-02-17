Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E771C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxQK-0001mr-Hu; Mon, 17 Feb 2025 04:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQJ-0001mY-3B; Mon, 17 Feb 2025 04:28:19 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tjxQH-0000tk-GD; Mon, 17 Feb 2025 04:28:18 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220d398bea9so56899335ad.3; 
 Mon, 17 Feb 2025 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739784495; x=1740389295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SlIFB3WP82RVd1Q14vVuPTlJIZYz7Qf7AIBQ3NxgnE=;
 b=bARneLpDgxP/JmqYD9gQd3iOEDOer+uPVUmw9yZdus/E06JWAn0DATWlJsYAuk0f5q
 txi1lrhlNC0Y0xvagYQr8orTEFZcbqBltlu+RdEvWXoUVShX0VkkvglF7aHv2v+MY0LE
 2fzI5nGNYqeGuaidGzsD0T3y9ZaqCR24C+janCqyTEISOHtbKxtHuy0sF56g85v37fkr
 Fp2fES+xwJYz7ArDVPWVUDsqqdI7saRdzUKbwn87sftN3yXMdmKd4kmWaDJLvCzM6k4s
 KdKHAvUJKi12RW5SxAkfjdBQ/oz36Juh0fJWgF7z49hb9zKfRe1UjIOOFDZ4Y3+GITL3
 5WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739784495; x=1740389295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SlIFB3WP82RVd1Q14vVuPTlJIZYz7Qf7AIBQ3NxgnE=;
 b=rgGCxOflhEj9hmWdkglxMoCR+bo3WbSCyCS9bKmVVjeAEj2lID14dP5p7rBr83YnUn
 hgxzUvJsLpIzsGWyxm9YuFBxAp7MSmF8yxtG+kIp2qxrwliBuFp5Hsy4SDXVaW5fnMDo
 So1ajAUDGo5rrDxCglhA0H/uOxAglgC8MyyuKgi7RiUhxEuaAvSBRaHw5rwZ/HEnLIU2
 b7xDVLlz6Tlv8RmIs4pC1qvUS4uxYkcDthTdGJQU0qf1ork/fXwluP6TbK7NPz7y2KnA
 Cwc2Y0b2pJKCcp12vdfasmW2An7hRqjtBpyLUyvQxcHgCa8dPCqGnVNpBl9EKUDArftv
 GurQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL34j0Khwwg1JQo913WYKlxks3j3Sm2luRwkLSzTh79gqNVqlnYqXx/A/BsajtJq3tue8h4b+3DT3c@nongnu.org
X-Gm-Message-State: AOJu0Yw+1FD4lOzs6RaNlZU+vwH2BnPvn9SaA6Pn/AuCcr5Fok4NMCEe
 NCLEhPrXbVOQGBzZbRuWBi062C4ZxB0lGQrhsfDMoIo6M+OG7llY36yceQ==
X-Gm-Gg: ASbGncttVOn4wyqh9sUZClCxA95yoTiCa3QxV48yxtR22Jsrb6Z9CQeufLP6RbqGXxA
 +22rYeYecrDm8vFhg+WHvNTv9ddbeGfPUDAMEeV5MP2qW2t2GlxKpKVyDFTLLmjoUttOMxXJ7Ft
 UL2jTRoPRm+1fMo76bLBuMtXGpgCRefBt9/EhF1CmgQbWp8GR6gL04RqRisMSstwzjTfmrjGr7+
 oIihsORXkCwSOiLhn8n/ZI4yEgcx5gScdQhga6lRT4cgM4+OgJqQQTpqzbO8v4EE01LVekDP1AG
 V3EynTjkuzwiM4CMHEo=
X-Google-Smtp-Source: AGHT+IFHaKIC3YYS2r/5HUqVvmRkIPObMqPxoYJ6S36c96Pb9vacEx1vAf9qfzprU6lB8/s3Omu1Bw==
X-Received: by 2002:a05:6a21:7899:b0:1ee:73bc:5f2 with SMTP id
 adf61e73a8af0-1ee8cac56cemr15268689637.2.1739784494712; 
 Mon, 17 Feb 2025 01:28:14 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73265f98e18sm4152940b3a.106.2025.02.17.01.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 01:28:14 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, farosas@suse.de, lvivier@redhat.com,
 Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 1/4] hw/ufs: Fix legacy single doorbell support bit
Date: Mon, 17 Feb 2025 18:27:52 +0900
Message-ID: <f8af22afec5092ce641fb5e5305f2bb9b232f206.1739784105.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739784105.git.jeuk20.kim@samsung.com>
References: <cover.1739784105.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62c.google.com
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

QEMU UFS has supported both legacy single doorbell and MCQ,
but the LSDBS value was incorrectly set. This change corrects
the LSDBS value to 0.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 428fe927ad..1ccd6f88b6 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1635,7 +1635,7 @@ static void ufs_init_hc(UfsHc *u)
     cap = FIELD_DP32(cap, CAP, OODDS, 0);
     cap = FIELD_DP32(cap, CAP, UICDMETMS, 0);
     cap = FIELD_DP32(cap, CAP, CS, 0);
-    cap = FIELD_DP32(cap, CAP, LSDBS, 1);
+    cap = FIELD_DP32(cap, CAP, LSDBS, 0);
     cap = FIELD_DP32(cap, CAP, MCQS, u->params.mcq);
     u->reg.cap = cap;
 
-- 
2.43.0


