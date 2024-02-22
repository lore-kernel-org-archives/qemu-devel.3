Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB7DC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFv1-00075S-T4; Thu, 22 Feb 2024 15:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFux-00070f-P8
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:44 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuv-0002cm-4b
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:42 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so400895ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634620; x=1709239420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on46I2b8riCprdxQ1GrqNDsO17YyckywkPgL9RszReM=;
 b=VsdgqmSn3KN7WNHhYg2ADbbWpZJ5QJzlpqs7sfR5UM3qZs/EyhvCXQXmt0BSu0oDoZ
 +0+t2nQyP3XSBX+Xh652ycNLFFoUuK/DTOjRMZyoCgAEI7i2yzQ6ZaO8E4odky4kU08a
 IZr43tmNNwSrYBIWQKtyLigYMoHSICKvzkQyG12AoF3wTTTCO7dorh4tjQml2RxiT2By
 HpV5Ws3334Ig+53Q6LH1U+BKWdaH0u53WQoUjk589Yn4rVwFxlCuYplQ1CwjP0ZPjQwR
 /zqLCNCH/wP2JaAJMrT2o02jZMmYuAUSG0TtkJCHDCcpXQzExj2hqDcVUz/ZQOpxBZIN
 M4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634620; x=1709239420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on46I2b8riCprdxQ1GrqNDsO17YyckywkPgL9RszReM=;
 b=w4HNIt8j12czhnS7NIZ8447ZmaEijK73armHAK59iW4DrGgG8bJzJC22Kq/ZdDPt5Z
 9o+j+EXO7V3BGzyrvQfszTjNGUBjrzmBOr2OGcAOPHQ44KuymvhHNWD8EWOPEvng3pfz
 MvKet0Rsy41gwIUGm9kTDOdmIxFrEby2lerZypl5GMDAVR6CTt41TYLnq5g/LghMH/G9
 tlfO101DA4h1kWBqEVxrNQUs4EKaIO2bIuVB3LveHancwTs/NJ3ycYud1aF2zkatc3Aa
 L5/1O9VyA84+Dj4Wt+OTADVKn8toTGL+lyhyhj1Glm0gTl9xjr9r5YyLoqQyi46qsKNp
 E3gw==
X-Gm-Message-State: AOJu0YxbhpO7/mjGwOJHsq8Wew1GA6/l05KxrkLPHsBZ4skfcXNFHvHc
 FD3OJzD54EjbezjH4gnjeY/oY9U+Mh2vxSFPl+JFmQrvj+wVUKvdvYfmIYbQV1s02i7KVkgJzVs
 J
X-Google-Smtp-Source: AGHT+IGFSz5KPcJYr2c4+rE8XHTN5WltgBYqhZTzmSsYXJRi2R6o+nCFd5HmCdadzd0RMNyVtlNFsw==
X-Received: by 2002:a17:902:e551:b0:1db:be69:d037 with SMTP id
 n17-20020a170902e55100b001dbbe69d037mr22021957plf.46.1708634619854; 
 Thu, 22 Feb 2024 12:43:39 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 09/39] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Thu, 22 Feb 2024 10:42:53 -1000
Message-Id: <20240222204323.268539-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Use qemu_real_host_page_size.
If !reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-7-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1893b3c192..a9f1077861 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1532,10 +1532,14 @@ static bool init_guest_commpage(void)
                  0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
     };
 
-    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    int host_page_size = qemu_real_host_page_size();
+    void *want, *addr;
 
+    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
         exit(EXIT_FAILURE);
@@ -1544,9 +1548,9 @@ static bool init_guest_commpage(void)
         return false;
     }
 
-    memcpy(addr, kuser_page, sizeof(kuser_page));
+    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


