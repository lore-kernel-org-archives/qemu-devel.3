Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A936AC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTmX-0003IO-Lb; Tue, 05 Mar 2024 07:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTl2-0008P4-Ai
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:58 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTkv-0003Ej-1s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:18:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412e993a82eso5096315e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641127; x=1710245927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcGhMUUI29octnVG5H2YHZPrevHON91YqWS8nudtIe0=;
 b=LCHDsld4djC4wq+RTNvwesUkZSXs1h7mLOWZx3jawgZAq0kxl60KOvysQgcAWGQKEc
 3jpBJ2tw5BXjxmdWA9wCE/daTLW23Mvb+v8Gy5dPzGgXd6szo9RgMbGRQy2DODMsOd48
 UJLVS0OQeMssYaHSxsGlrMrxUujpm7F9Grp+oFG0bDeb07SCoxbz+0V6hinnYpkr+Sby
 0gE8CWkorM+bzxz8v65o+jbB1iIzQTNHPoOZ4kwbVyJu/RLba86hueS3ddzHIGoRo/F1
 bLk8r4ctN4UjGzyWwK6t8ftjuVaSWjMutlJpBXHln5CU3sM4bs0zHDKrvtMvkZ5B7FY+
 4+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641127; x=1710245927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcGhMUUI29octnVG5H2YHZPrevHON91YqWS8nudtIe0=;
 b=rtLIlnaHuixDrr5PiGsMGPsDIJRWI6AGl3Gcz0kaUGpnsZLzd2WVT6UzbXalnFpX8z
 U+18koM/egJ2ZiVOc4FH4xTtTfSH2kIcP46jvJvcrrRQj4Hk9wDEP25gAoFQObJtYAyk
 L6RM8WFqYC3c1JkQTWJBf6k3orfNxh63MHTx1Rk/EyWu/7v1PEW+Srzv++ceCXvlC9UX
 A7HwukMdzve1y58DHAW+TQw5GhAgdrvp/bOTl+RGzxBtIsId7/TiFrwmIjf8OFbPvW2h
 7pTqppWSn1aq0nT7TYA0IBfMArgc8JCDP3TJDFC+TLX/or+ZKE2DL2jpPaQdnnHHduWy
 Hvhg==
X-Gm-Message-State: AOJu0YxWbn8kh7IEGsfCDofrI3vSUCjxIqQu/Ed6SGTm+LLXIYvaCtAh
 RUdcnP3uw/5HiJBkzwwzlTcoFHWbiF1jr2B5Va5IV8bwIanUMB/ehOB5VY39i/4=
X-Google-Smtp-Source: AGHT+IHCs/ghXyQJVPqZj0z2XFAwPBjrv76lPlvMp4lOf5ox0BmEwTP7SW0AzruVtBk1uNWhaGDeRw==
X-Received: by 2002:adf:a153:0:b0:33d:9d46:c16c with SMTP id
 r19-20020adfa153000000b0033d9d46c16cmr8850175wrr.44.1709641127111; 
 Tue, 05 Mar 2024 04:18:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r12-20020adfe68c000000b0033df5710fabsm14790096wrm.44.2024.03.05.04.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1054F5FA01;
 Tue,  5 Mar 2024 12:10:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 28/29] target/loongarch: honour show_opcodes when disassembling
Date: Tue,  5 Mar 2024 12:10:04 +0000
Message-Id: <20240305121005.3528075-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This makes the output suitable when used for plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/loongarch/disas.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2040f3e44db..63989a6282d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -120,10 +120,15 @@ static const char *get_csr_name(unsigned num)
            csr_names[num] : "Undefined CSR";
 }
 
-#define output(C, INSN, FMT, ...)                                   \
-{                                                                   \
-    (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT, \
-                            (C)->insn, INSN, ##__VA_ARGS__);        \
+#define output(C, INSN, FMT, ...)                                      \
+ {                                                                     \
+    if ((C)->info->show_opcodes) {                                     \
+        (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT,\
+                            (C)->insn, INSN, ##__VA_ARGS__);           \
+    } else {                                                           \
+        (C)->info->fprintf_func((C)->info->stream, "%-9s\t" FMT,       \
+                            INSN, ##__VA_ARGS__);                      \
+    }                                                                  \
 }
 
 #include "decode-insns.c.inc"
-- 
2.39.2


