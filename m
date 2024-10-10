Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BCDD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz14F-0000EH-Lg; Thu, 10 Oct 2024 17:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14C-0008PF-Is
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:28 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14A-0004i7-QA
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:28 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2bd347124so1018785a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597084; x=1729201884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9gVyerFHlckzuRl3H+RuhCKQrN6TIh8DTxwuTlJ5co=;
 b=h+v/uVwCc8355FfVuWZ2VPsaZmWX4dMZ9YWLxcejN93jWbG99s56gP0iRc7zud0Kyi
 fB/ZVVcqDPnfkaqCZtnYQRQih3gYPaUEN6gMYMrwf5Me1Qr1D+kHDal+jykP+QCFTaf/
 qwkG2yzXO+kmGxD9MXGqlQkpKXqEuPMxl/DiS2deOpcdTeU/Rg01FqUEMFTV6gPfT4aX
 GoqGj4EoBDrJm5RQO+aY+i9euCdw/zbv29BJatynCp76Z0fjtS1EYhh1KYsSknKhgx5L
 0nNTGaFxHtn8oI5peYXhoCi1Ulw87x8qVY9vofXqZknvQRKaE32nkLdVtjUV7CNT5yB2
 GpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597084; x=1729201884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9gVyerFHlckzuRl3H+RuhCKQrN6TIh8DTxwuTlJ5co=;
 b=UYi5AWAcCVLFwYBIO2cVUiAzg0wvCwBTKzCZa1eJmNLtWY6kDnQxj2d90fWBe8PZ72
 djpHN0p+QyLvFsZpjfZPodFxbf86YbUyPjAw/JDFI3YaQYrlQHHVC6NQdiBkR7ywOvlt
 Q11F+GJRFsowYFZ0fJgvE03RpJVzA63x6HdGvNBR8J72iNWanutAuS86UQP/GH57QGel
 e4uNc+ZMlsTmip78Y0ui/BkMhMng0ZpEz/viRL5+BEFeRVTjlrDtw9DYynU/zRO3Bbrd
 RDzZiMt62a+oP1EkZmdpUtdpTg5mqm1/apoKlFQCq5i9Tby05WEDROW0tXZ6lg9uysMF
 07yQ==
X-Gm-Message-State: AOJu0YxgBqwKgEytjWWdph2H28YerByK9bhKmHA1zmbQiO/0bwg/Z6g4
 mKKdqiEwfqroVRfMnFBNyJDz0nrb5YtSudxobVrxbzF4UgOzyF/3J3eM6Z0hFjidKwQce8cjffY
 Q
X-Google-Smtp-Source: AGHT+IEvCS7ZlPsMRjF6vk0huDHxLJB2VUnMb1CuGH4V7wej8NzuV/7LpB/xKQMW2jabEVrgMs1mcQ==
X-Received: by 2002:a17:90a:d382:b0:2e2:b513:fdca with SMTP id
 98e67ed59e1d1-2e2f0af1e79mr846194a91.20.1728597084116; 
 Thu, 10 Oct 2024 14:51:24 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a571a2ecsm4138205a91.33.2024.10.10.14.51.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 08/16] target/mips: Rename unused sysemu argument of
 OP_LD_ATOMIC()
Date: Thu, 10 Oct 2024 18:50:06 -0300
Message-ID: <20241010215015.44326-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1034.google.com
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

In commit 6d0cad12594 ("target/mips: Finish conversion to
tcg_gen_qemu_{ld,st}_*") we renamed the argument of the user
definition. Rename the system part for coherency. Since the
argument is ignored, prefix with 'ignored_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c776c0fede9..ebaefe39ed3 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1957,7 +1957,7 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
 }
 #else
-#define OP_LD_ATOMIC(insn, fname)                                          \
+#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-- 
2.45.2


