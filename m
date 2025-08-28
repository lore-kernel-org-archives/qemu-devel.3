Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBCBCA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgCX-0003Gn-Jw; Thu, 28 Aug 2025 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXZ-00016e-Uq
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXX-0000Jj-1d
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2487104b9c6so7796965ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383338; x=1756988138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLhobKMRxEo0CbtdUR911qjNXLbwZnrIInwr1urPJ3M=;
 b=HxynPJqpHMMmr2I9bILLtlQxagfE58RYJTGAcaFqYCnVIu0A6WOeiGbZe+oG2EodIz
 adZgxfkmQdUT0oyJD1pDxUCFOb8AuEB1wasl+yQBzKTx3UJ6/X7+GfcngijWr/0JKWww
 yvS6OgcSgiHlupjwxJnMsWFEUC7Qz1uhOQAndWSzohSumm2C0F4F+/3U/HXUol+ny0Yq
 LaxWVvix+z0fy5EwGwjXDAARjKZlkSMbNx70u9KiTnkqgLMpqMbc06gVvEhN/Cljp1h/
 7Jkm5QdmjEUluJBqpSXBWWw8CPWG2RPMqL/H0hE/0gMPHtxe2eseD3Ng1WsBHAdXO9j0
 b2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383338; x=1756988138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLhobKMRxEo0CbtdUR911qjNXLbwZnrIInwr1urPJ3M=;
 b=KdzazeAX6JWPuIxPLSIQWv7Ye5OxI/RfVmBk0724Q/27h1r/wwbq1haI1uPYokXqRA
 +5LBIFI8pD6ImwnmHjUo+Rut5+q0lFmgifKCX3/TunAUmulyEulMTdcZhpxG4/WRAOwM
 6vjhFWAQAkqdySY7V10qaqLX6al51HfpUfQcBxtSsA+JDyRH0R5USx1DHWOz32pSCUtl
 2+zxT1N+6ZaY3eoC7GMLj7hBxMpkDgRCQH/jSW1aCO4HlYXchnbNY3H8KsDVOYP1yHTf
 RC9dycu+MQOpRNntT8c4HIpDEK3H9xmYGexbvuYttpAroIeF43w5iWuWJ06kVcl48NNt
 R5aA==
X-Gm-Message-State: AOJu0YyhURhfhUJlN9RwVFTJwQ6WdXltU/oBCnIdxCmjjwA2sCvQrh7s
 tD+tCxWXTht+BMRohyycCFveKdXMVmFGg03x5Au7CX+dwNnTYBpqLOC8pW3Ashn0Pd9WQO54vCI
 LhG3Ygvc=
X-Gm-Gg: ASbGnctzRWXAaCm0PR5umvIvtJKzIOfu8fhMXqHAObqr3Hnhuj4Yzg0FQL1DxS+uFIs
 VqOE+gtJ/9dF/HOeyjijHWr3FV8PAI49DavQfd8o8E2kpI2HbpJktfRHBXI6uIejkSEebYY0Z8i
 eZWYfZzDCtySl+W9JTFLDTlkPBGjuEt13b5DwTweSNHytXmrhNkpLUEHhV58bqKPbYqRJNdSE8z
 WNsqaVT58r4ai6LsxZJY3iXTdUsSvrX80ldDgtT+cYGju5LcdPStv6xp6GaUOmFG9ROqc7zN64X
 kzTRfeoUmn3jRF9MHYAQBPDDuJ7380EoDT7mKF2WJOrx8pSTBdOYGbTAHXjnOopsyPGmGqV5F1G
 cq+iJqWwgHhhrNqa2jVBUKAmi0g==
X-Google-Smtp-Source: AGHT+IHCbRZZpkh2uBjVQbUqFIYR2ExlR25rfYPkVetMhko3QBq1XsZIGVoHYQgnPwEo+jj8SPO3ng==
X-Received: by 2002:a17:903:24f:b0:242:9bc6:6bc0 with SMTP id
 d9443c01a7336-2462ef8e7c5mr301903625ad.55.1756383337487; 
 Thu, 28 Aug 2025 05:15:37 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 74/87] linux-user: Move elf parameters to alpha/target_elf.h
Date: Thu, 28 Aug 2025 22:08:23 +1000
Message-ID: <20250828120836.195358-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_elf.h | 3 +++
 linux-user/elfload.c          | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 52b68680ad..f9d6372c9f 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_ALPHA
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a3757c595e..aff800baff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ALPHA
-
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_ALPHA
-
-#endif /* TARGET_ALPHA */
-
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-- 
2.43.0


