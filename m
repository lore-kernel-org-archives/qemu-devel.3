Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB96C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Cw-0006Ic-E3; Thu, 23 Jan 2025 16:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CN-00059Y-9M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5CL-0002sl-Pr
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:57:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso10466985e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669432; x=1738274232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgByrMylZY256tTsI6R1dbeQexynJICQtGDxrv9XG/o=;
 b=tlIglBuXQLVek3lkFg/zcllYypQFQQ2M3sDaEaEcFow4qpkIWYLXbreBoFqig9IOzG
 lOcMVAEoVG16xB+GlO4vVpyzziTAVBPk4PeuavTubO1VaZRMnU7Ksdbuj7JUTrJnGypI
 6FnMc76zGiyaiJeSMOQsLsvnY62odrz+0s1HOLeZcHSAfyYIopy3sf3HhknUaj2udmFh
 j4OwqAoP3774S9SdM2BJfuo+A8gq1KdO7g7c4zEu3oVWxto7fbeAUxM/4Ybj7yJttmmA
 BV4yMpAU21xDdAXS1Gk+Zu2Eq8ffwWswWWjMYMaJwcuai/UOPLGOBpRjfWBpad2klF5H
 RA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669432; x=1738274232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgByrMylZY256tTsI6R1dbeQexynJICQtGDxrv9XG/o=;
 b=vwh916pYZBRYs5+sIEzeMQyrMimxJ/s09DN/hPiAdL4ZpMyJ3EOheOUXyLJuavomvX
 FLfGyfozsGqkgMTN+Chr6Ct0zmlTOZEZPXEORRdYESsDRTUVvpJDw61cFsOOQvmtqt1K
 PmPPI0CVfDNGdmmSUSpbyN5I/iytumRFyXVm1H2UpkzxAnzdbSeDRWBHpZVN2xyEDgiY
 HEtJID+YbnGkLMfSx6VWh/P8urrBTW+TM2hwzubGqQ4sGoYdbM3KCy9p7Hcjf76wwhMf
 yITKH5dZQs2YedOZxfz0EBrZZbq6tZH6ax27ttIfwqOVsmElYu+LocaLSgADgemvYE3F
 9B6A==
X-Gm-Message-State: AOJu0Yw3dkHpQF30WOQRqpmAfBVPjvKB8WBkdmlq7emnrqEedTa/5HFs
 eJiI6AOfWWVvJWqb27+QVq9OIj/6xio+uOe+QqRtlR5Dv2cUfIcBGWxH6MDYg6qiXGUZ/hFkyxR
 yhcU=
X-Gm-Gg: ASbGncs/fU9Hp/zBVoi8VpwzfoEXzEtPzRnUqJ9EiSht/61iEXFMb9l7YUjh0GTIQQj
 tWlIxap7yjBMYSZdDYrk3Tt1L82eS6zSdofG74PlEAP2dXUoe9Qi9s7Mne6nTRjvdugbamJhs6c
 ogUN0KU3Cog7y+zENjIw2aWl7lW6a8kDxgpmHk2OBbZsiyeVtg3eLrCqDpjnNNHElnVe/7PHpAH
 KXLZvCt6YrS5CTG8Fd078GeQTCJqiL22Xv1UsQ8A40Vwn3amEqS7QTF+WN+wDRGcNEP26XBl9JA
 +9j3sS3hTxkWcihJnW7qtJqmCQfi0wv9PSTMyXu1xqgnYQ1OUvb9lAo=
X-Google-Smtp-Source: AGHT+IEXYVUhxvMV3v4ralVdPOnXVAfWJT07F57AqixKSNpLH98uhHOtv/W4UYD5IgBQHDil2m9rKw==
X-Received: by 2002:adf:ef8d:0:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-38bf5674b55mr24331438f8f.25.1737669432092; 
 Thu, 23 Jan 2025 13:57:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm767716f8f.89.2025.01.23.13.57.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:57:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/15] target/ppc: Fix style in excp_helper.c
Date: Thu, 23 Jan 2025 22:56:06 +0100
Message-ID: <20250123215609.30432-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Fix style in do_rfi() before moving the code around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 48e08d65bd7..661d9650d9f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2481,8 +2481,9 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     msr &= ~(1ULL << MSR_POW);
 
     /* MSR:TGPR cannot be set by any form of rfi */
-    if (env->flags & POWERPC_FLAG_TGPR)
+    if (env->flags & POWERPC_FLAG_TGPR) {
         msr &= ~(1ULL << MSR_TGPR);
+    }
 
 #ifdef TARGET_PPC64
     /* Switching to 32-bit ? Crop the nip */
-- 
2.47.1


