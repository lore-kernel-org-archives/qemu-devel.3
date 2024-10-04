Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8C8CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJO-0006Lt-LA; Fri, 04 Oct 2024 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHT-00018l-Cv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:52 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlHR-0006ZT-Ck
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:51 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5398d171fa2so2884789e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059746; x=1728664546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBcEgRLUs4YPVNfRAPRCJw9z4l7rdD9SQBWLJrOyEBM=;
 b=NAqeAgM5WLkAgc+qIO89u+x0Eky4qIE0QJ1oxky0egZsOUqSXFBRjbuXdPzf+TBHyL
 83tgZOf9PKkSB3t4u0DT8AfsBd004WqiyLXKMYaqbn4bQOAjLRAWrBeDyntIYvYtqeJ3
 u8fS5ZmaJGScSTxSUjYfPYqRqd7LN0e2QX0LLXZI9sMgYGqLcpJHgvz62sSDCLzHmnEO
 0PtGaBB46KiVbegrp68sFIs3uHTO7LDOwLalDTahsYzfw7oeJQJgTecliN+nyj69WO9n
 tIpA5Mn09flysF+YGVs/HaRw3WB0e2V8P20S8eac6dAjUBP+jYfp6gsrglR7phLbmbZ2
 WuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059746; x=1728664546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBcEgRLUs4YPVNfRAPRCJw9z4l7rdD9SQBWLJrOyEBM=;
 b=IRNQ+MW48CFmJ6fZwxaIXqZ22LSk52icr79Qm7BKLklG8RnUGpA6jSOdM56Ia7si/8
 5msNdNbLlx7pOQKCyOI3zrlhrC579gCSECwgyvdFmL57B8/upnsqE7xBcx1+IJrWJaX1
 K8i7+sZsZ5235jgYV0I48ZO5mOvFjOuGC3qbYvjBZNi1ItaaYnjDvDyxvRfuwWRo2JWF
 vlAv3RQMCuhcKd3tS67n4h6sriwGKIwFDfeRPSgwpE7yRdhCisQxVLQ8EIamE4uUM1w1
 kC6JMOVugaV5J7Yh2YBgqbXqKQM5egIkF0qwP33WKGyQdggb5qQ/dModELMG9ks4QF9j
 HCrw==
X-Gm-Message-State: AOJu0Yxh2aNdjj52VMx2wDrkTx0wYPMOYeokgTPSW0Z49e43+BLGOhjC
 DCdVpL+Vfd/6eLd/8PfVBDGpg4sW5vvKwJEkpDe+U5LI3HwnS/18fTl45tFcaH2/VTWreqDgD/u
 IUYgHIg==
X-Google-Smtp-Source: AGHT+IHucy4PeMuJnAv+0a/4zi8dryHCmTMpG9TGBmqNAHiRNScZqBASIFheRPXmNdzuhNdKH+WYmA==
X-Received: by 2002:a05:6512:3d87:b0:52e:9b9e:a6cb with SMTP id
 2adb3069b0e04-539ab876cedmr2107733e87.15.1728059746062; 
 Fri, 04 Oct 2024 09:35:46 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff23588sm1192e87.196.2024.10.04.09.35.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:35:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/25] target/sparc: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:36 -0300
Message-ID: <20241004163042.85922-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SPARC architectures use big endianness. Directly use
the big-endian LD/ST API.

Mechanical change using:

  $ end=be; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/sparc/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/gdbstub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ec0036e9ef6..6c82b7db8cf 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -110,11 +110,11 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #if defined(TARGET_ABI32)
     uint32_t tmp;
 
-    tmp = ldl_p(mem_buf);
+    tmp = ldl_be_p(mem_buf);
 #else
     target_ulong tmp;
 
-    tmp = ldtul_p(mem_buf);
+    tmp = ldtul_be_p(mem_buf);
 #endif
 
     if (n < 8) {
@@ -165,7 +165,7 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #else
     else if (n < 64) {
         /* f0-f31 */
-        tmp = ldl_p(mem_buf);
+        tmp = ldl_be_p(mem_buf);
         if (n & 1) {
             env->fpr[(n - 32) / 2].l.lower = tmp;
         } else {
-- 
2.45.2


