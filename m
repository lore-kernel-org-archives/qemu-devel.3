Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJD-00005h-48; Thu, 28 Aug 2025 13:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWU-00089V-2F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWP-0008MA-6z
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:31 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b49db86cac4so650265a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383267; x=1756988067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5ZB4KmZVQ2PXnRTjB721lcPMBvmO4keQCU+w332d1U=;
 b=qWcJ0lYXdnsLk7XJiudsbQ8DPUp2imGhfzqr4LZQ2Cgc6kKBaHWL3C6QzzbDLna0vv
 uasjt02fZJm8B4HXx8xuvMifLgIxaK5xs48ipglcy8Nn/ldPOK42lvt4ctgywO9oZ1Io
 LrOhdUvA70iapMcDHGTKWFDYcy2c0hZUUVj3mxl4N2LdEK/WJHNLdOUu4zdZMdbCIQIi
 P8I8j0ZWvWBJi6+UyX4elzs41h0y7jz3qEDCJME6AjeMhjsrhSlnXaEZtB82JtsYksg2
 DHYbq2PKd424UVfAnPSXAaO+720w9tOcmKe0xswGmA1IOAALINFRGEj8JSR6r8MzUXVs
 33uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383267; x=1756988067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5ZB4KmZVQ2PXnRTjB721lcPMBvmO4keQCU+w332d1U=;
 b=DSv41h3Xqwrb2ef3kOvLeTdDamIbyetf7G+J8mifhGbIutnvzz5LCa3W6bRIBfM0Nm
 LJZBGg7otzLjnafm2ptoNjM50RxAYQ+/4ZvOPb90OGnuK4ObWeWZF7XmmN5REG+mAaY8
 x5b2PCMJSEItNTovgoOYHqkLk0WG4nRBMvg/BSWo+ykoynehm8+Lg6QbAmzdf9X/XH3u
 znOzZsXJ+MCRjsg/nXalKpb97xH+6uMcx3Z6DN3sa+kOy9pfFrmy01UyLcqJld+lOXSM
 UIUo9GGuSLoUQfZmMRbymSmScr4E6ivElMTV7n62gr+M4wstRidjCkg6QBRnApSDTT8g
 N7Sg==
X-Gm-Message-State: AOJu0YynmmlaV6NgsMk6w+10/YsqV9J23b49BHTOwj7WfvRmkPKOVjhc
 K4Aq6pvadjduhCrFuXoEZWHOWWrRXVHEUU19fkXQxg1uFa4ZM/FYrw9ErypstosuhgdYQR/BOo6
 +gVrHRsM=
X-Gm-Gg: ASbGncs1T6Mc+aKt+Y39xoE7R9bLq2A6wP+eRDlj3xzUnNF7AO3MvaSivbbTv3foeCw
 qSP1z3SsqkAINVGP3J4VNh6/yvHORUGmlz8jtfBCeZ/s2aqNcugbJxJE/bUjDs4rhUGUlsDl86H
 Rj5TAgQKGACHFM/NHkkJKtleEaAcZKlYu8ALpM6mYnkFMv9p1hsIhMNIcvCYcYMRkOD4Voe7Gxk
 9ZDhqSqzlMm8bBhXHz6V8f9Y4mmNWQbw29/UIpeZRG5UiafhnD5sw+3uWK21DIOlWLfj5E0DeM+
 J3ID31F6BTg7qnE3Q/KQiSUNFokYYivKEhsuMqCNFNvfyGuP/9ge9nqJs7HA5e1wxdexUuTUGmn
 TwKAY0jVM5UXQbgtWIng8rZVOoA==
X-Google-Smtp-Source: AGHT+IHiydx4F/Pal7RjFuCVgVCn7vpzSxxpU/U6vIO1+G7eOLWzAKWxqZHZAU1Ro7hU9db69P5wkw==
X-Received: by 2002:a17:902:da87:b0:248:c109:be14 with SMTP id
 d9443c01a7336-248c109bec2mr51335595ad.11.1756383267282; 
 Thu, 28 Aug 2025 05:14:27 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 60/87] linux-user: Replace init_guest_commpage macro with
 function
Date: Thu, 28 Aug 2025 22:08:09 +1000
Message-ID: <20250828120836.195358-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Turn the fallback macro into a function.  This will produce
a link error if the other macros are set up incorrectly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 25f29e60de..81bf05f581 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1115,7 +1115,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
 #define HI_COMMPAGE 0
 #define LO_COMMPAGE -1
 #ifndef HAVE_GUEST_COMMPAGE
-#define init_guest_commpage() true
+bool init_guest_commpage(void) { return true; }
 #endif
 #endif
 
-- 
2.43.0


