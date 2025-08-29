Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA9ACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmr-0001KM-IN; Sat, 30 Aug 2025 11:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fa-00060V-Kt
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fY-0004nH-N2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2664227b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506843; x=1757111643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/6x1HXP1N+S4ifQMLcnaTaBv3fLHAqVhSKu6p0/+oM=;
 b=VQrkHT2ZvN6qtDCbFP/FQrAr3NQDsRVUJ4q0FJhZCapj8kiqBtNvMxQdM+OmEJRZFe
 o7rO7KchBdDshmRrpwUE8mN98m6TuNTF+HJb9mgWj3UBYR1R5nJ/WKN0xFWBt8Km8YAS
 +JJwG+jBAh3VEPheKJUJgm9//WWxwr0XJnE7B4QIcelnkZFXgbBCaQydf91lCE73Mjv5
 N5XbXYLJrIKF+T73aI8AChs2m3Yj+pnJBL/TPoR3/O+lwo3ooUyuiGUogn9cxCnc2Q8c
 al/ocdODKmj65d4S9s3kl9CkEos4fVK4Skiw9SiI6r7SSFLP5qTcZSvv3aFpj07Mra4D
 tSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506843; x=1757111643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/6x1HXP1N+S4ifQMLcnaTaBv3fLHAqVhSKu6p0/+oM=;
 b=rg7ajxbLPVYqlqG2tsiKWUKBDqKKOrb5hPxlZvOJ+0peCuYzfPpRWmXTXFl9nVtQ4K
 1XSt54wh7Hu04OyneGntyDPY5N7Ld4zIhaT/pPFY6/RYU2juDYOTlc+uhl7Mj04dj6Im
 OxBobm5QTypdCpMiJDe8z8KXfQMcMJvkh8/x3PZD2DCk5jxFU+iAMYaOPYPJg9CQVf1V
 uaH7+WcV8QRQ3Ceawo8o05/HuFK1uTOAQsWbRZJgvbDIg/jM/RSs2dKGDCzbkP+pbkGa
 9+QFLdDrxnprC29Ce7ERdz4lVrc9Nk0jfNS0p/lXAa6THyE3d0u77cncdw7wBLPne3CZ
 BwuA==
X-Gm-Message-State: AOJu0YzdzXkKdAqrR8J5hmQ0nkN6ztFu0+I85NsNDOekUGOOdnPWrPA/
 9FRPUEbh6fwWQaUgDfMNbS/WCc7Vh83fH6z439YJI26URVm4BrSLN+Lh/RfT4Ehu3kR3UjbW69b
 2CaaIFw8=
X-Gm-Gg: ASbGncsDc9Qa/hIzJun8/Yj/9wD3NKZkJ4XvZSoVADIig/kk5TWcJTaUQUsza143WYt
 0qYrSKAJk1UlQ/Pa6xe8ltifygZuw/1k5GC6ZROyeCRaztFHfMnvnlhuq3iNQfgVYlqoiOUBHbh
 hEzBEqeaVTqUPmReq+pEKxo47PKvYqmY7IEK1UW0t5b+jLjU5ErBN917KL34a7UgOWxc2ZkDwx4
 5w3yNBjA+K/9Jd+KdrrEZ6qvXIYcU7azWBNIb79NJnagvwZu7+INYwR8mVeUtDz+ka0CBlEaXdr
 kqCQSBn+D0VWevGKtUlKyJvvtnfQCry/vjlsqg4M83kMtodaSFrp2gCGuO5cxbUAIV16X6GEibU
 aQtvy8m35h9QW8qlAhewmCdRZIEgjU+6X1zFDZnzJf7DN8Rk9OHjxknZuyrzr
X-Google-Smtp-Source: AGHT+IGHUnjIPp/Y7vIP1XlmJkCKJ7eaakme0CSKZSUwUCZGEiC4bG0p7372ZXhRfkfns+zWpdjTeA==
X-Received: by 2002:a05:6a00:1825:b0:771:e8be:8390 with SMTP id
 d2e1a72fcca58-7723e2769dcmr323335b3a.14.1756506843315; 
 Fri, 29 Aug 2025 15:34:03 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 86/91] linux-user: Remove ELIBBAD from elfload.c
Date: Sat, 30 Aug 2025 08:24:22 +1000
Message-ID: <20250829222427.289668-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The last use of this fallback was removed in 8e62a71738bc.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aa0eed6dea..c0326928d4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -110,11 +110,6 @@ int info_is_fdpic(struct image_info *info)
 #define MAP_DENYWRITE 0
 #endif
 
-/* should probably go in elf.h */
-#ifndef ELIBBAD
-#define ELIBBAD 80
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


