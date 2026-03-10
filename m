Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2C8FD88CE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06ON-0000sc-Bc; Tue, 10 Mar 2026 19:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OK-0000s2-Mi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OJ-0008IR-9O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439c4bde55cso5244650f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184889; x=1773789689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1V9tdOVdLqFK1/bFtKcjJ3YN5b5xAdHA5bYLzSjTysU=;
 b=lL1zzXIMISyzMr9vPDtPJ2IczfeDdo9WtTRSX9X31p99j+39gTzFVWSJsqoH/wP78v
 FJgbKWzJJ7lAxP4/nvqNDjQbr4oOtBOh9NACakHgPuTtyiDPyU6FJR2bN7K0BJqpo+5y
 l4gnHF5Vc2+P95iiCsWGZMPLeLm6gohh8WFHQFsTQerm0JS97zKUbc/UMepUfL19YohS
 H+yOBZ6X4t2tAoQVPI5503YWNTVRnakjIMV20PIuaYMZFhzVhyDokDMV5QJYu9gMn3Su
 ACPlkBwaWeGwtvidfhwK6qz4MsmIr6wk025hbb7hjC8E/JKv5GDsCeRa7VCmnKyLoZ0b
 o/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184889; x=1773789689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1V9tdOVdLqFK1/bFtKcjJ3YN5b5xAdHA5bYLzSjTysU=;
 b=FUIh6dGIGk2XznAY1nPt9x3JGjWKCqu9uMRQ4QVsMFvTZaLJB+gV4Mew88he6Bndz4
 JCchnu3REF6O2dqb8czwnI5J/E52iRcCnfZg2C/O2FWbLw5Pt1dEaEREtHvP6WUhYQom
 prG98aG2q4uQmMAuyc1YmUS6hSp8n+Vr1oKu0VluVrgJPYpHEOaRQEpliv1pph82fFA3
 ygSBjUauwB5o0jHvFwinoRfVQqyfZFl1o4+JjolVvIxkbSG6S1e6SMLGXsfwwJA9dT3p
 EOVh1JrmmPizFiPdcDkaXG7049EnlBlzxkpNkWzPfQ0TK8U8wOmWklio76sBFUDut590
 7N4g==
X-Gm-Message-State: AOJu0YwrUQ38Dl/QKn7yJTGyUQuNJlTBZJY05cVUTxqTfXQZpNLWr1uo
 kIx4m3ZEWfLzAD62sLx2e5QCyPoJtTFYBB0mVkR0i5kjhO6ic1h9naWdVDcB//Yo3iMoljyy/LQ
 cOAvUX/g=
X-Gm-Gg: ATEYQzxvVtuFYOVTmY2ITRVzwZy06mBmWzuGAogfaqjnBiKs17UQvFYiCCRQ+Hrm5RL
 E6iXB+ecqIPiEBiLrrjigV4QTpGT2OiaQBzOnNZryk+X1ic1vKSDQWW+Z9l71H2TUjfdcCfjKRn
 rQtFKbmQ0/6YCrjxcjh4T2ucDDW0e+DDfMxnP7BaKhYOADDLm1LuLrh677huSRg5WcpAAWuGmrx
 +l2jL4M9XSleB8cDbASoxNGH3ii4JdvHpn9OJuMd7rMewOZ6xMiioJ0hwLsOkFmUHFxQwkuNv2U
 ItYu819jAW4EGZFz3O2VM34Lw+3OjKuCLC9EIW5/yM1kI/KNsN/ftnSg3cUmNyJ3DeXy/beJuve
 DwsTn635aEk/zB8Gt20oq6jeJRUImwgGekA3XpJUY/e1Ar5YwPd4trIMYiXoQu476HZlOG/sbIE
 Qg7yoAkm4WNMt+DsVTwlDd+EXXdNhi0qat/zVzxBZrNkW0mE2ZT/jmYn1gD/Y1WWb3uobh2ia/
X-Received: by 2002:a05:6000:220c:b0:439:f605:b006 with SMTP id
 ffacd0b85a97d-439f8438e9emr1117481f8f.39.1773184889544; 
 Tue, 10 Mar 2026 16:21:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a0480sm1670194f8f.12.2026.03.10.16.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 06/16] gdbstub: Simplify gdb_init_cpu() logic
Date: Wed, 11 Mar 2026 00:20:34 +0100
Message-ID: <20260310232045.58440-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ensure we either set gdb_num_core_regs or have a XML file.
We shouldn't modify CPUClass content, so mark it const.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 gdbstub/gdbstub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 90f4b95135b..221951c22b0 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -582,22 +582,20 @@ static const char *gdb_get_core_xml_file(CPUState *cpu)
 
 void gdb_init_cpu(CPUState *cpu)
 {
-    CPUClass *cc = cpu->cc;
+    const CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
     const char *xmlfile = gdb_get_core_xml_file(cpu);
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
 
     if (xmlfile) {
+        assert(!cc->gdb_num_core_regs);
         feature = gdb_find_static_feature(xmlfile);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
-        assert(!cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
-    }
-
-    if (cc->gdb_num_core_regs) {
+    } else {
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
 }
-- 
2.53.0


