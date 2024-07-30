Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248DEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcRb-00078H-EF; Mon, 29 Jul 2024 22:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcRZ-00077d-OM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:18:29 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcRY-0005zx-8X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:18:29 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-44fded90c41so22050061cf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305907; x=1722910707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdOOXlcI2pXCHd0E8nwCuiMDshNmFFas8R7dthZK29c=;
 b=Hp7qOB5ktSXtjnD9sAfQL7RU+ERmZ/Ugbqnrqg1WrTHnQSUiP97H/FrAszL37LzP3m
 pX9cDHoJ3CY+ePiU5AuX7sYYKdS9Rho7pKaMKMF8vh50iMkFiEBLYpjxKgyA168x0ocC
 sGQ7xy2g4Ry+SRSpaCiQGSTjQq/o2iygbfsrVl5T4TD3S86jZUGf7kldrtTCpkZjA/cB
 AERP6miH09vC3ulOgGA+n5uyqs+MW4Uh084CMk2RhsgeSPsVBMFW65IW3wD5+33oZ8u5
 ExebmW97LhR8ZfiH04CwamDoKo6b7gO/EYe1Z+uf1cO5gez/qV1LlpzImVWxs95EZEOQ
 CVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305907; x=1722910707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdOOXlcI2pXCHd0E8nwCuiMDshNmFFas8R7dthZK29c=;
 b=kWguF16IST25mYBj1rGgjwDmAbPsD/y9x99seqdObWwXRikxQU7iUOYP74l9KswTeI
 WzQBLJ4S6lNiH/11cKGw7iAOMDQ31n9n99c/Mt1qcZYkLudcIkmzxvml7GlLgQgCIPVw
 EfXxUy5hGuatgTT7J13haUCmAA3X6v+f9gK2OVu0cOTCMbs9A1vjINbE5F7bMj2XJsjm
 rX+Huf1yZi/6b0Wd8QA//sa8/qqraOjbQeyGqsk905R1U13vL+T35YODz2IbPwO4waQI
 1yDl5kDQMuGNU3IofmC/3g2nLHjrxPnqPHtn8Jhai/6O6Xgpq+TUibkoDMuBb+IW8FQM
 13XQ==
X-Gm-Message-State: AOJu0Yzm260h2QfW7fK/UdyQewHzw2U+rUHRoYdDlM20BqbuNoaGZJ0d
 sekhW15hXgzZULGSClNMU8A4FAG8Q2AdFk3ovUqPfeYKzNECwQkxhnTzGBLGBuATB1hS2j1cKzf
 OwvA=
X-Google-Smtp-Source: AGHT+IH2iXsYm2M5romUtYcoXgvTBkWmSW/JTgHtEI8rGHEeN391KwT6ykEpR8zLdR228Gs51+03UA==
X-Received: by 2002:a05:6e02:178d:b0:397:3045:9dc2 with SMTP id
 e9e14a558f8ab-39aec4236a0mr123455735ab.27.1722301937280; 
 Mon, 29 Jul 2024 18:12:17 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vivian Wang <uwu@dram.page>
Subject: [PULL 3/5] linux-user/main: Check errno when getting AT_EXECFD
Date: Tue, 30 Jul 2024 11:12:00 +1000
Message-ID: <20240730011202.480829-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

From: Vivian Wang <uwu@dram.page>

It's possible for AT_EXECFD to end up with a valid value of 0. Check
errno when using qemu_getauxval instead of return value to handle this
case.

Not handling this case leads to a confusing condition where the
executable ends up as fd 0, i.e. stdin.

Signed-off-by: Vivian Wang <uwu@dram.page>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 0b959cf5e4cc ("linux-user: Use qemu_getauxval for AT_EXECFD")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2448
Message-ID: <20240723100545.405476-3-uwu@dram.page>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7d3cf45fa9..8143a0d4b0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -755,8 +755,9 @@ int main(int argc, char **argv, char **envp)
     /*
      * Manage binfmt-misc open-binary flag
      */
+    errno = 0;
     execfd = qemu_getauxval(AT_EXECFD);
-    if (execfd == 0) {
+    if (errno != 0) {
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
-- 
2.43.0


