Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A75AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVl-0004uU-KM; Thu, 06 Mar 2025 10:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUJ-0003bs-FL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUH-0006gE-Sq
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:19 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so5732075e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276216; x=1741881016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SnfT7DORVv/itpA6HOJTnRR+mH0KMqcNOFRFeDG2Dgs=;
 b=Yj7K6hgrmwS8yc+mDL3njIWiaOEuCfidpJUdYVFZOLSPQSDkkTRA5AuAfXVPqKbd1R
 6wtKWRne6bb4PxTlKtMdFAzI2wk8lWTTmMAqgjg0YVaZiIT5k8r0H1hJKAHNBfJIkHrP
 xxAWPh0cj8/ZCdO5kAPasXMivgiV3cYxi/ydvsu+/BftXh9DiZSAyCqIRCAZWM3906pL
 +OhV/nEHTUtHqNygBBTdb35yonDKUUG+Id+MqvShiAAG/+3ryaPcW87O2EBrZmeClhhm
 jQ31gyipbrQaTccUdKarwS4a2l4A1OtQLN9gTSniLYuXuq5Qf2Wdy89qA+BNb2zOR/on
 BbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276216; x=1741881016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnfT7DORVv/itpA6HOJTnRR+mH0KMqcNOFRFeDG2Dgs=;
 b=Y8Un+bguR8Taa0lTi2MBDu4C/Gh4b7sbVT6DGIL7myXe+BHpTxRm84D6k3r3H+SmK/
 L0vjCBDBiq853whTUH8Vea7dkq0WMpS4iC6ZSsZfENga5oa9RML4CycGDWkKyQGJH9PF
 onF2XUEu+eT5I1FwrmbrEo6ho/eTU7NZ0Q0ZR0/8hGLIexC3epXO+AD/DLn0gh+7MsSC
 gDJWmocg011socxrk+1AqxB3E2Ifm6kPRScS+6l4E3Nhh45E2VgTJIWV77xahqKcd9lA
 hZTQZzkp9u2vMpr1f0ihf7Xf60wIsHqyF1M3rMystTVPn6OlsVersD31vW66rS3SwOw9
 rDEg==
X-Gm-Message-State: AOJu0YzZeQoLaPjn3bMJINmV3wbF6kKWBhrJWNjtLZwWKa8J/H4ggDrH
 D4Nq8K86Nc5wla+SHLWPYT3DO/nlG/6MCUTICUcWXxa7W83IlJLH7Y/dO76DzhG9h4bRZDnKjAt
 kbrk=
X-Gm-Gg: ASbGnctCMe0wnUOHODKu3DILNDfxIG7rvgXCgQfXkd8haoL0SmkqWmXXxDbOhP0PoAs
 9G7SKaBTK7hUQR3KsImxBfJT9a21arcz+1bsY/LJznn/M4wUp+ALfQ9fpowNRg61u12eSHXYQHx
 gEoI2Hjn0l24gmj7D1CioC1EiDjE7CoL1qOLrr1zOCAkad1NxrEVoAJahEoIwodGrL6ppUPpEag
 BgSxn//3Byurnhq90ehlVLJVTgQdgf3z7lQ9gaGmF67UImH2a246FWffMhTEPHM7oMtJthPKkNi
 j3uTPgeqMwZiARwF4ZFGF0WmIo000TRvnWaC7pgyPqkztQHXA1flbiRxt0DHrAw6434oeNF4bzf
 z5S6qGNfZKIXo3uMILio=
X-Google-Smtp-Source: AGHT+IH/mA76cIl2YsHlsMIktLuqn5LkW/+5ivwAUhK+ukO1uoiPNruTKAEfU24hN2sjoGmA0MkXZw==
X-Received: by 2002:a05:600c:458f:b0:439:91c7:895a with SMTP id
 5b1f17b1804b1-43bdb38dd94mr30596655e9.7.1741276215897; 
 Thu, 06 Mar 2025 07:50:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8db6c7sm23249105e9.22.2025.03.06.07.50.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/54] target/mips: Fix possible MSA int overflow
Date: Thu,  6 Mar 2025 16:47:17 +0100
Message-ID: <20250306154737.70886-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Denis Rastyogin <gerben@altlinux.org>

Fix possible overflow in 1 << (DF_BITS(df) - 2) when DF_BITS(df)
is 64 by using a 64-bit integer for the shift operation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Dmitriy Fedin <d.fedin@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20250124122707.54264-1-gerben@altlinux.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index ec38d9fde5e..74fb80cc256 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -5577,7 +5577,7 @@ static inline int64_t msa_mulr_q_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     int64_t q_min = DF_MIN_INT(df);
     int64_t q_max = DF_MAX_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     if (arg1 == q_min && arg2 == q_min) {
         return q_max;
@@ -5685,7 +5685,7 @@ static inline int64_t msa_maddr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 
     int64_t q_max = DF_MAX_INT(df);
     int64_t q_min = DF_MIN_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     q_prod = arg1 * arg2;
     q_ret = ((dest << (DF_BITS(df) - 1)) + q_prod + r_bit) >> (DF_BITS(df) - 1);
@@ -5700,7 +5700,7 @@ static inline int64_t msa_msubr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 
     int64_t q_max = DF_MAX_INT(df);
     int64_t q_min = DF_MIN_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     q_prod = arg1 * arg2;
     q_ret = ((dest << (DF_BITS(df) - 1)) - q_prod + r_bit) >> (DF_BITS(df) - 1);
-- 
2.47.1


