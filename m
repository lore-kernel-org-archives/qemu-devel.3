Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5DDCEFC3F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJV-0007TX-Ub; Tue, 08 Oct 2024 14:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qu-RY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJK-0002Se-6d
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:56 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so4823303a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413511; x=1729018311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=280plYgj9pKDnH+V9HZdJ+ePLYDZqB5eIDcpDzTLK4I=;
 b=WzJpZiePA48mCqtODV3EfjoJNr1+0kxfGubz4xebTpCFJ4csGdcoHcvf48mYi58JlW
 4eCv6bs9CMm6gGDrnI3aXnGvf9yjnPhFa3y6N/BQ0Pkhguf6bZ8Q2uG9SGu/KVZ6jimJ
 fq6wt2uYHhr+EBSxJynMo9uFzkC82zgkl/7w1CrDwv6Tq6mXK0UI1iQPUHQ1S4FS9IaJ
 AIWcKgYtVtmFT9hGYxJ3vesdj5fRgaAaB7UE8bsUBIBOsJrBSB+wOczzkufM1pcfpACv
 L1MkcS1smDI8PA9Fb8AL0NZz/Ydvs68wopPohAap5A3Q1cCvhWoy6ve3UElpO4VGJBeY
 /ubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413511; x=1729018311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=280plYgj9pKDnH+V9HZdJ+ePLYDZqB5eIDcpDzTLK4I=;
 b=b0fdboDuKttxKSKb5MmsFtdEm6NJJisqsazFWGvES+FX84wu/vuMawT1xqA9UbKrqf
 aeYKSZBkd43QBak2xkkFDVuC5wRzayLMS9CRx0bdqC3/j5P0j6nJqvgLlYp/e/++orUH
 +BpvqIDoCaim8Oi5HiFTMufdESeiTKkg2phJUKfqyQHiAyI1Hz1A/cIopmnO9Imf/wr9
 iK5kr45mZEPMaKBwjdq4fLtNVAlMGagjYJ/9Kzsq8dZJym08LH0cLsW5WZ0FojDCuT6s
 xxgPMgNJP139RNfnAzoPNHaLCtnaGL2P3kv0Duc0lK2bJVghO7dUDIehFF+Zd+CChLxW
 0Pnw==
X-Gm-Message-State: AOJu0YwxjQXOvSGU/RTaF7aBdvhTtq8EnWzjva2vUI0epy72KSnpyu8o
 tG2LAKAH5fk0GbuAnD9pGESazlb9sBJZeYiuGoXAoqrvv8YXR1OCBeKvLTemIas3HR2sUKbW/6C
 T
X-Google-Smtp-Source: AGHT+IGUCTtSmbqHjUb1W4Pyd0j+H6qaQE/aoVvPuwe0Ko1qc6MWfotOgC1vRJ0bshhIMoCs1Rb4eg==
X-Received: by 2002:a05:6a20:c886:b0:1d5:a29:3173 with SMTP id
 adf61e73a8af0-1d6dfa42844mr25093834637.24.1728413511098; 
 Tue, 08 Oct 2024 11:51:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 08/14] linux-user: Factor print_buf_len() out
Date: Tue,  8 Oct 2024 11:51:35 -0700
Message-ID: <20241008185141.20057-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240807124306.52903-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b72fcd515f..245153c1ce 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1670,6 +1670,13 @@ print_buf(abi_long addr, abi_long len, int last)
     }
 }
 
+static void
+print_buf_len(abi_long addr, abi_long len, int last)
+{
+    print_buf(addr, len, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, len, last);
+}
+
 /*
  * Prints out raw parameter using given format.  Caller needs
  * to do byte swapping if needed.
@@ -2757,8 +2764,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 1);
     qemu_log(")");
 }
@@ -2776,8 +2782,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 0);
     print_sockaddr(addr, addrlen, 0);
     qemu_log(")");
-- 
2.43.0


