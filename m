Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61645D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kot-0007Cd-9g; Sun, 03 Nov 2024 19:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koq-0007Bc-O1; Sun, 03 Nov 2024 19:19:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kop-0002Hu-8H; Sun, 03 Nov 2024 19:19:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c70abba48so30758655ad.0; 
 Sun, 03 Nov 2024 16:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679581; x=1731284381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySL/GEMA+MP1Yc5YuF/O92O+3rYMxrud3tBnxWGFNSs=;
 b=I58PWUHvaX9fCGTtvsCR0/ZWikENWj6VqbYKTl+DIL52my7jQTwLq4LIy7Mpm+mwVt
 bwIOZnpq5C/bQDxqX5bGptmsshKkCFuXxJFr+MyR/KzNqDYDqQTJ3Oj1Xw1GHtPDXII3
 M/Wtt6f7qzyZsoo2PODQz3zq1jLiUCeun54is37A77gRP2juHQXjKOYBx5OxGXZu+hS1
 79mg0w87z8N8z9sJ6h0S5SUgfsZtRds2ZqW3tflSIfBHBuWxxre8PHbgvnOR3ch5Rr5q
 kv33r27whi2XsgU3aCsz+X1fYUNKCIYP5K6tE4LQqvqxpyhMDZnY53v24ohaLvOkAR9w
 idlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679581; x=1731284381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySL/GEMA+MP1Yc5YuF/O92O+3rYMxrud3tBnxWGFNSs=;
 b=vEG/8xBhXV7+WZ9nrvLmAWLi5BJaSKXf2e8xQ7sILPYjuyQLrM+/wvakBGlgDTUcpA
 HKBOhuccAjwqZUZ2zsVoQLzmLmoBq1M4QOHnTgpoIOLVKOni8xhgHPuEieIDmoJpjzhE
 9w3WHKeeyz+NnSPiZyvsidB2bc4XHuyw2QJt2fl3Kzz+B+UY7SOjGaPUo6cxDqFp0XN2
 VW9am6vtiyCX68uMfnzLagQHfm3USwZIjtCnPAbolXZFdKpFrvgpiuZlLKf6+KYmpfeu
 SMSP4V7tB642drDYTNIy+v8BQFNroYbKxgQ20CikjfLLmL18yqUiF4hxcN+vERvcUelp
 Znow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy7ZxHQqoM91+dPkkTAdogHabO3gsjUvFQzVmDc1xn3AmWZu1mQCbVTNzkDLc0UtQENr76MyCCZ7jNP4A=@nongnu.org,
 AJvYcCWfIInAqEv7Rjevm6kKIC43nLCzvJoMBtXkTeC4qPXUk2VueK8ybO6qE3FSCHVlSOfm4zYn8FYXYQ==@nongnu.org
X-Gm-Message-State: AOJu0YyvmLG1QP0XQYMMGdSnV/ALujCjq08PhQ6fuhnjc7O77RTUCRZX
 jVWM6Pxj/6lU7b03cy5ilUk0pmuqpgmCJrn7A3nCRHIlocB0t/sAHdaaFg==
X-Google-Smtp-Source: AGHT+IF4hphWS1zO/m1NDCH3FoiaVrS423NwVH0O4CwT3O33NhwFddjw26NzSmqzfmErcumezLnvDw==
X-Received: by 2002:a17:902:cec7:b0:20c:8763:b3f7 with SMTP id
 d9443c01a7336-2111af3bc88mr148502475ad.17.1730679580849; 
 Sun, 03 Nov 2024 16:19:40 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/67] target/ppc: Fix HFSCR facility checks
Date: Mon,  4 Nov 2024 10:17:57 +1000
Message-ID: <20241104001900.682660-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

The HFSCR defines were being encoded as bit masks, but the users
expect (and analogous FSCR defines are) bit numbers.

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bd32a1a5f8..f7a2da2bbe 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -635,8 +635,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define PSSCR_EC          PPC_BIT(43) /* Exit Criterion */
 
 /* HFSCR bits */
-#define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
-#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
+#define HFSCR_MSGP     PPC_BIT_NR(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT_NR(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
-- 
2.45.2


