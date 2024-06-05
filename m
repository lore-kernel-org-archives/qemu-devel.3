Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58192C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMA-000691-AE; Wed, 05 Jun 2024 13:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM8-00068f-GR
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM6-0003uA-OY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:24 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c2200dbdf7so50980a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608201; x=1718213001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN0j7e1me7x0GvT1xeBTZ2/XK/b6BIC/ILFNYHI7Gqk=;
 b=f5hx9cHuRvatt+frM5JB6oij9K642zZuOQSeq7zOQv1SfEC6lE92uFyJX5OMy2kC3L
 jcSBLM+u3b7KCYb+RpU9iacj1KEz+lD5GCUBp9jAgRM7DBJnelwqCODkVs6Yj2hDAsOs
 KSHfA1DcbhA4kYRec3EzbqSBl2F9Uqqp5iJR8BCkrZrJm74RHsAMCdkzNYZrmSmVX5Hp
 xjAL306i1rPN30FMfJyhLRekR1Mkczepin14d7PHbKvj/7BAp3bfaiskT/pYqiVoT2+T
 YGyi7zXQkiRdolX7yqSwCu1MU1XmKk5k12D135PYYL9qVc77m50+qydgpd+WAMUZxAXi
 3rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608201; x=1718213001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JN0j7e1me7x0GvT1xeBTZ2/XK/b6BIC/ILFNYHI7Gqk=;
 b=SspfBMd82abG6A+Y5PRp7Z/bX9hIJ81+CCWC3l8acbe3BzkTIRI+z4iXT4GHn1JrM+
 yKH246e4YeENlY1eNmXUVf3kkOIWk8ELKD9AByejZOarLOSwmuQKD8MGOVzZkleZ9MED
 7frWxmacIaQkhdy0FwDJrPG2eivELJI7SQVuSKbHntsWEyixhCYgxygOr+9Shz7a2vSh
 tKRV3oH7rJgx7Z6wia2jZvlvu0cNrdknVXb4PyfFi4oCYlHUUmnzbGCKbGpd1v1LC8rt
 sCwqE5FaqOM++c8MQgYy8CcBLb6YB56xKo2YaKFlsW3QqfjXI7IQkUPNsnliFxMFDLPE
 ndBQ==
X-Gm-Message-State: AOJu0YwNbg4qtuEJF/06xixijXVHVi8+7knJ8ZjmhlsUtCkc9R0lzjYN
 bS3zSAxV8EPwW4ubPZsMXVxOFacnEo+W8GEWq622TxqYsIfPTHyQUKtkFz+s2KjJpWG+Yu9Z7I0
 A
X-Google-Smtp-Source: AGHT+IGIb7bNH9TKMy6YBXFHgGHNp6qrDlPAGV1fZVvdD+IwO7VAvsc1gyl/PJ+mWvaaC5Xs6KxNjA==
X-Received: by 2002:a17:90a:e289:b0:2c2:3f34:e4eb with SMTP id
 98e67ed59e1d1-2c27db5a583mr3748186a91.36.1717608201265; 
 Wed, 05 Jun 2024 10:23:21 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/38] target/sparc: Enable VIS3 feature bit
Date: Wed,  5 Jun 2024 10:22:43 -0700
Message-Id: <20240605172253.356302-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 target/sparc/cpu.c   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6a1457346a..cb79580431 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1004,6 +1004,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ed9238a69d..8ea977b49f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -550,6 +550,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
+    [CPU_FEATURE_BIT_VIS3] = "vis3",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -880,6 +881,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS2, false),
     DEFINE_PROP_BIT("fmaf",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FMAF, false),
+    DEFINE_PROP_BIT("vis3",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS3, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1


