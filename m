Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B8D1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjk-0000Pf-2r; Tue, 15 Oct 2024 11:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjh-0000Jl-MP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjf-0000jQ-SR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:25 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so3457605a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007122; x=1729611922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKnzIyfB55jcDJiuOhbkwT1go1+QVX88i2HpqTUCIA8=;
 b=xhVdIf+nz21MyhAwPReP3N7C+ruQfpA0aw0y/6tWfVTaULFQNuSyKq20b5PX2xJKDh
 xBa6n8eQoy03NIIDOswLmT8gL8LST2lVDcHghrK/579a3cKLE+EKsOKQGL+k4UyhRpv8
 2EH2s07pgsYHpT9VksPBBsTgaIrFzwhd6SFjPO5IxFrOchU25Bd5hoIyP6oYDCM5Ypks
 3E2zwvEy62zihuCUmvBYnf/6bvV8BTkbvA0kXEW+rGtp6mIQPD6enhm5an3fawF3/Fq3
 NJh4+vujelWYr0bZkXqLpevh5FjtwBTbRkOUEA74oXShJpXV7mSG0/52si3qsVoCnizh
 AkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007122; x=1729611922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKnzIyfB55jcDJiuOhbkwT1go1+QVX88i2HpqTUCIA8=;
 b=fZkOZJXtUHIx3AIH5VSw6aX6E0yq00DJXlBBjL/2y3t7dvrA93VCIrH2/0w2jFTZ9a
 ZMgmpp74MijUDJWPbOdn6MekBBGXXyJqK+YklI0phGZsmnTpkpbntnoGVxASIIBAkwvm
 MNs2ewpa9TWL0pm2rGfXJG1lp20fieSK01AixcPh8GWYTiyU2PebBArxYLkgkod30s9K
 kv88bEGxzl4Z2XG4zTYIZ7bO+PiJbB8T1LutbwuCs722BkyAZFBqGXaUo97YuDbPZ9jG
 5PjpOt0KVKsLfb0myD7z59upxSVm00I24gSjGP9k0W39ykEHlpOShw0/Naxs4T4/vPdg
 N5Gg==
X-Gm-Message-State: AOJu0Yz7ftu1mtU5oqsdinU2DZ4Sqra3sP65gxhu67j4dt6dqoWenasp
 1i4F3J3f663sGeWSly4kr6EAG6VYQJxI92egNIib+1BCfVvRV8QGyEVBtx3OxgpeGXykWWvCNdl
 w
X-Google-Smtp-Source: AGHT+IGXlXTobLjjFWgdi6VRhIDkgkA7Psdgd5HHHIfzpXR/cCIx/+Em5ScixYF3lJpVVNM0HPsNVw==
X-Received: by 2002:a17:90a:3041:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e2f0af2eaamr22888742a91.12.1729007122017; 
 Tue, 15 Oct 2024 08:45:22 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f5f7f7sm1941754a91.37.2024.10.15.08.45.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/33] target/alpha: Replace ldtul_p() -> ldq_p()
Date: Tue, 15 Oct 2024 12:44:14 -0300
Message-ID: <20241015154443.71763-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Alpha target is only built for 64-bit.
Using ldtul_p() is pointless, replace by ldq_p().

Mechanical change doing:

  $ sed -i -e 's/ldtul_p/ldq_p/' $(git grep -wl ldtul_p target/alpha/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-4-philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 13694fd321e..bf5091c2a6e 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldtul_p(mem_buf);
+    target_ulong tmp = ldq_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.45.2


