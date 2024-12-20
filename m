Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3144DE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfid-0002iz-5M; Fri, 20 Dec 2024 11:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiR-0001tr-Fw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:03 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfiQ-0008Ds-17
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1333843f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711540; x=1735316340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbzYiRlcz/dvJTCmvfG6T6ZqIFZDB9nvnEc2KqmD5q4=;
 b=bVYzKsacwbQGHIHUX9yDkN0DJrUa6jQGSNXiy2RcbPSYgUK+W9R2epu1SqUD1VQbhO
 U433GViqHkJP3EpRw6UWYtyR4YUcr/FZquEuG1FUbjKgtENryICsTf/QLqFGqUzGLViL
 FJcA8iFaiAs7Cq5aWiN3x7iNQTsm1VGzX8Fw2kDFo9g8IfA41sW1P3kaXJskK54ZHUzV
 9+cUVUpsR+JkmdIuyRshElRcXkZ4b5hXHpvhLM2zD0wOM/tWUPqsDcs4JGDapGqugC9e
 gj1OgvS4rAzvipUT0tIH3ncFof/oW7HjYbKJ9m1Xf/Wgg+NIjjMA8lMgOo55vDLWvb6W
 11QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711540; x=1735316340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbzYiRlcz/dvJTCmvfG6T6ZqIFZDB9nvnEc2KqmD5q4=;
 b=ePgZzRXFb+Lh28gaiiFll82910qEcYj6VqWlvxmBlZ5ypNTy61BHoE0owsfQa5yd/z
 h0T4JipXWj3QrVNsQM3Xd5ajrDueRrnTJR/BobrXz3B/ftebYCLlYkLYdT4KsQyBzgo1
 kTRrOWUchl/0qoUh0bNhHxAYHagozThhgYFJfIcQCrWTHfRHGisjQo1jV2oHNgnxGn3t
 5cPsJA5iYO6gYutwsigDVEU/L1ogG3VNdpMmSnGXsNVXS6AwebAgSGcHjjeb7v1YQO0o
 4erjCcpq14zKh4LjaRK+C3udDRBqvbhqRT6/N7DcNNaVcs+aaig4Kn5VzeIJ+0xxXh1U
 jwcA==
X-Gm-Message-State: AOJu0Ywkt4LKG/8yRqofyxI8rymL+WdKuCqewulSogWDp6Bzu56KjMdb
 BNs8apAi3rj24nqkBgasWCbYSz9xTlQHcLGVUMSDWc5MNJ/NIVzMtu632EPg8KtXdgbjnfHloZx
 e
X-Gm-Gg: ASbGncuitK7fv8iTcGtbPOujVWzT52AfdFRGbVaAT85j21xu6RlOU0NFalHsRILg7b1
 9PLSiIFMEkWxBHGH38jkt64o4zOkmYmmHa3+GgsqqtSUdRWHkH9T4m/cqIKEDZCg/KAWP6IKiCn
 vJbFQJcziML5vhKqy22ZjMrfVoZpv0TiR2j/QjPBTynItpRluDbQKgNNTAHvggydWLuTyVks2Dq
 jt/GDBMMcNihzkokyvSoLP5kifx8YmggpxkPMFiuNYZjgziJEiFsP70usCJY/SM6+gHXeml4cs=
X-Google-Smtp-Source: AGHT+IEQxUSCQy2C6GF2Z5wAmpEmVAtNgSy7nfyV499ktDEQtelRdXQUkH/fhAfePzurPMJbRNeqRw==
X-Received: by 2002:a05:6000:2c5:b0:385:f195:27f with SMTP id
 ffacd0b85a97d-38a221f339emr3518322f8f.5.1734711540410; 
 Fri, 20 Dec 2024 08:19:00 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm49729575e9.14.2024.12.20.08.18.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/59] target/loongarch: Declare loongarch_cpu_dump_state()
 locally
Date: Fri, 20 Dec 2024 17:15:32 +0100
Message-ID: <20241220161551.89317-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

loongarch_cpu_dump_state() is not used outside of cpu.c,
no need to expose its prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241115152053.66442-3-philmd@linaro.org>
---
 target/loongarch/internals.h | 2 --
 target/loongarch/cpu.c       | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1a02427627d..0655ac948b1 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -18,8 +18,6 @@
 
 void loongarch_translate_init(void);
 
-void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 078766feafc..fa838dce2e4 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -742,7 +742,7 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     CPULoongArchState *env = cpu_env(cs);
     int i;
-- 
2.47.1


