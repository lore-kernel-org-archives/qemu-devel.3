Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ABDC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr274-0003Jf-M1; Sat, 08 Mar 2025 16:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr273-0003Io-A4
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr271-0000x2-9w
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:40 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so2554226f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470818; x=1742075618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kS62xgfs4yo8HShma26k5M+Ftf9GvqKCsRAE0pxnfGo=;
 b=KpKO5ub92GLK3qYbm2zNLeCITmh/a5c+7gB8er488gP+pwVZFkyCUTOYa2s78BfHSV
 FAnWGGTgIeS6or6KYhertnRS4Amox3hfVEmuxB3/lGlCgn6fkR9RL3vS/IB7QwQyapIJ
 OgvTDLvI6sIacpPkPj9K8JGheQvb6MQ2UiG1BG2jLpa+i1Cvo3ha4lxtdhNeRmPUgpgT
 RN2Q1zl8Rfv/3WQf+mlRpGHXkJXzR3mi7X2C41ZSszW8L6HyCPt08xMgLYS+cO2VfXA7
 8Ko8U6gOvgTCpJEN9mf+0+P1O0gzqk24JsUBsH9UogmCz4JviCQMEq8yi7KXII4fd90p
 YboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470818; x=1742075618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kS62xgfs4yo8HShma26k5M+Ftf9GvqKCsRAE0pxnfGo=;
 b=djGe3jj60xCtxru7XjSf3zJuQ7G0zRq+58bynmHwea1qZ7K8zKL2PTm0rJQYR0Nqfl
 CGi8Np/4evurp+V8OAOB5ft/6fgziMFt2MBhsvGRkcWRmm1njhcX2LqHUC/aOCN1xkvB
 aHUv+OS1IwVdRQG+2liAZ1ykohm7FsY0ZkZoWnDWe5Lrh/nB8HDUWJlFMf4DLDQ+eB/0
 XIreXSc69TcM++2/eoOwi3IFle1ZROKOqyEezUX5Wl4yXbZ5IZbC1hou+B4jyr5lVA7S
 OT8DPx2h6kNBCBPbN/n4yRSvzSL+McPfXuAkXv8DcyxxuCfPzikxD7pO0KSOlBxTV/EL
 vPnA==
X-Gm-Message-State: AOJu0YwYoKCauZKSKwxv3U434vdKPxr6gC14b86IezDuc/Fn9XfWykBc
 5PzBpoloUJmYtz6udWPAyemRzSLntu8ErVTr7d5/A5GVAUokL4esUQSZ2DBJi7oDlnRwjs3h6PU
 N
X-Gm-Gg: ASbGncu8eBO/+CYM4OicLzXb+P9VE41uCaUOVQ5idGJa+rF6CZsWVq3DTs1/aXt0R5u
 fvzufZrsGponYqtzmuwB/o4S5Pd7cJ0nPGXTKYiFAxKy8ZEILcQk9f3eQe7DbnqsFmt3YfH5Eou
 A0szr/YbkF7KvQsbjrhY1VkF8AC60lSNUjcOPyqdtpoeIEt1g7ON0XWNACRUSULlLOFR3uxaaCw
 6oDFDoW7pZeJRXrl3CLat7lH7xr/9QMCcILFsFHmJaa6baiKff0d5aUFBQck+pxGEU+aquLjUJ/
 YPyHNYwCM0yoNJDb3rveRU4McOM6tKACc86W68cI8PH1ezY=
X-Google-Smtp-Source: AGHT+IGQfDphKx/UKpRAuwBvv68Y9Jm2s/k5IWmNxN2exjzPvWjmtnz7v+vrmevbqiEhB/RF0WOS7Q==
X-Received: by 2002:a5d:584a:0:b0:390:d990:823 with SMTP id
 ffacd0b85a97d-39132d4783fmr4395281f8f.13.1741470817657; 
 Sat, 08 Mar 2025 13:53:37 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103290sm9740850f8f.87.2025.03.08.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0975760507;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 15/31] tests/tcg: fix constraints in test-i386-adcox
Date: Sat,  8 Mar 2025 21:53:10 +0000
Message-Id: <20250308215326.2907828-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Clang complains:

  clang -O2 -m64 -mcx16 /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o test-i386-adcox -static
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
          : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
                           ^
  2 errors generated.

Pointing out a numbered input constraint can't point to a read/write
output [1]. Convert to a read-only input constraint to allow this.

[1] https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-16-alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/test-i386-adcox.c b/tests/tcg/i386/test-i386-adcox.c
index 16169efff8..a717064adb 100644
--- a/tests/tcg/i386/test-i386-adcox.c
+++ b/tests/tcg/i386/test-i386-adcox.c
@@ -29,7 +29,7 @@ void test_adox_adcx(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
         "adcx %3, %1;"
         "pushf; pop %0"
         : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
-        : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
+        : "r" ((REG) - 1), "0" (flags), "1" (out_adcx), "2" (out_adox));
 
     assert(out_adcx == in_c + adcx_operand - 1);
     assert(out_adox == in_o + adox_operand - 1);
@@ -53,8 +53,8 @@ void test_adcx_adox(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
         "adcx %3, %1;"
         "adox %3, %2;"
         "pushf; pop %0"
-        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
-        : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
+        : "+r"(flags), "+r"(out_adcx), "+r"(out_adox)
+        : "r" ((REG)-1));
 
     assert(out_adcx == in_c + adcx_operand - 1);
     assert(out_adox == in_o + adox_operand - 1);
-- 
2.39.5


