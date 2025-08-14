Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B57CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXhO-0000tw-LF; Thu, 14 Aug 2025 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhF-0000l8-F4
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXhB-0005xO-FT
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:08:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-244580591b0so6082835ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176914; x=1755781714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVlQwNjtMgvAbm23dBCZDYeq1xNwwku3Aggvwl5C6uU=;
 b=NTTT/aZnd7i0YwAaOmJbwE7As6j8BXQIgcJJDezrZp26ZhoT0wIuflMzmfitnf8ZEU
 1zPXeWByQ0V3vD3ydZil4DTuDkL6VbFqHkU2zyMWguSuYYLcQYQ/pzXScpz1PMU53S81
 wnwhw4bKDbtQvrfJt3n0Nh8pvrSpWN0JYyd4FbwUKH2gLdO/RRXd7Uaf5gwPh1LWUgPB
 Kq9I3BLDbxiskT4/icM7PaS6K5KKs1+/GMI2481yAY/yWNZKR5XhaPqyp7DYE4Ay0/8o
 Y61O0SmK+dqjCeX6u+wG2z5JqfJotv98kEq10L3QE2/3BK75DpnOzlAAeVHKLRT0OtwS
 iDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176914; x=1755781714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVlQwNjtMgvAbm23dBCZDYeq1xNwwku3Aggvwl5C6uU=;
 b=GmP/q/E2RC8P49dxoo/crCsDH/4aCLFlj1W55YMCCnlQUhEPIazPP0yZ0+JUVlLvMG
 LdiEyCLGkjzBMLn0ThJrbmUkMNZEAuPMB5xf3GcTfbajkZ/BuDsSU1V8cQiBOaAbhlfx
 wQRi7WZfu58Y4p+lVetxWZVTgwkiWdxoyIT3QfN3I5ooAM5ZkD7Oj+mmgO9I26nwt1XL
 P7lmuRkJ1jqX2bCn40QnYJ1d5VO4QOAD+uX57LereOJJxU0tQCLXgoDOYJ8vDLoUAmiO
 2xLMvkOc/11/FuXpDZEHznb9YxeYXurUkwfhW3QehlI47ZlPMIwTArq754Jn/Dhm6TuD
 82wA==
X-Gm-Message-State: AOJu0YxTwheGIM4Y5PYNxEwTbAixk+p6+MtyTV2H4CdgQtG5dJzgG9w9
 gJH2LapsrqL8ranpQNif87djW+6ifF2n3++4iHcDOrzxDYjivO55WqdjLAoyulXVrbVwavkMw+H
 b18wNqkM=
X-Gm-Gg: ASbGncvekYobIn6SYQ3tea7kwUijhKh7Aa2nXXdwzxKoG8n4AkG7JbLFYoy6Vhjn2Nh
 8cUOn90UbYPEF1ZObcpi0tYNRy84RrrJWiVIpIV7zPfJdagIT/ZJaLmzoEihFBhvRExI34bVynH
 gohhZ/JAy2W7Rj+me7s/frRX7GFbiu1uwtqKR+pZhUcD/NT84gOVtYqh2MA6OXJKvmaPVBUeX2A
 +uPT0hlkqZ3SguM4HTnI0hzhu4PHPXl/NzoNRLmcGwflEsj5PoF0YnjWxsef0QgNobAelx2wdYA
 UKsda4urNMEJDOFe3ZKqHnW2bRjhHoeKxTta8AiAzrJhlbvF3ZbNp5JARZ9xCVpnREjQmlMEnx4
 QbarnDq2+l6m8dxDiHZyjKYUwvMj+FG2iVQwP2G51CgGY0CI=
X-Google-Smtp-Source: AGHT+IHCYUly2xq/OiPBQ3pX2EGmQuu77FfAvzsezay08YhbrR/4DnKVfu4eiWMoh5O8fJ/8uRmUxQ==
X-Received: by 2002:a17:903:22c4:b0:234:986c:66bf with SMTP id
 d9443c01a7336-244584c2da5mr43248005ad.11.1755176914428; 
 Thu, 14 Aug 2025 06:08:34 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24304c2943asm64438335ad.30.2025.08.14.06.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:08:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 82/85] linux-user/aarch64: Enable GCS in HWCAP
Date: Thu, 14 Aug 2025 22:57:49 +1000
Message-ID: <20250814125752.164107-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d87d1a16e0..e71dcdec1b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -877,6 +877,7 @@ abi_ulong get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_dcpop, ARM_HWCAP_A64_DCPOP);
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
+    GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
 
     return hwcaps;
 }
-- 
2.43.0


