Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D6BC982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Mik-0000uD-LZ; Thu, 17 Sep 2026 20:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MiY-00006L-7X
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:42 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7MiW-0001qN-Cm
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:44:41 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so190332a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789692279; x=1790297079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WqsYbKwuWANAjvJHGnMo0sqUN7MJ3VlFgzOX3qOpmk0=;
 b=JnAMSlVa566o/O5e9SHOnNguwYu0BCgAKAbGEkE/5Hc39b5bUzmldw5rt+kOYyTxs5
 P9a+9uL42olC2uSseZH4hBkJsS2zVG6NpfYCWh5P4r/HpH04ZQcHF2Fvz2s64GbGtZvg
 pSV9ULzgrIiqbIjy6uPVJf3dLRQw1rykLn6V1jDOqMDIOudkkUnr9C+gjOrLx3A4xgkb
 p32wuvjPAP5iJsEb15h20Q8Mpb4BqMEuVmNSlQBfxrqBugJfZztQ2S/ETC4A6j4ouM1M
 Sz8R6QgQ+yLGJmIhJhw7mb/6oNMN55s6bvEAaHitR5XrK4W1D2hEY6ymLkMMYttMP6SO
 iqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789692279; x=1790297079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WqsYbKwuWANAjvJHGnMo0sqUN7MJ3VlFgzOX3qOpmk0=;
 b=Il9CbEqV5530O6/F3iUD5AwJlgpdM125DA71xg4pAKOEInArYK0m9iiLFrQspOeKm5
 WXnlHxQS7thd77E/v+dyZA0WsU0piT1/FfbZ2GSg5FpGiPdLME0hFmESGJ9t/Sjs5i7J
 wO20XFLXAJEikNJCbUgoFNrgge+w4dkH7XaOSsUo0oEchYZdRc+05GkciHu8Q/EZQZV2
 5kqp/8SzqUINb0W0cwgP6wBOa7HJ3+w1Rk3BINT6IlWcVgIMGi9+dEPkR9tuV3gxUp9U
 oLpBwl3ukh9Q4X1jXwtBGeJP5EVvfcZ8ajcylbhl+AeuXnTraMWoyYwmqa6PDFVv4T5G
 fbbg==
X-Gm-Message-State: AFuF++lypQgAoVxQhDxEMt31CvjFFWCP1RinZhTK8c4eItHdCVQnEyKc
 0vnAN8GKXpAbvdu8jW0nyCux0sMIAc8c8SY7e/jyflVTZhcIa8cBU+4JyQClsdpgZY8=
X-Gm-Gg: AYBFou0dq0eujQ37Sm25qTr0crcDbsrTSBEP6S69PGIwRKvfZkaLx8THV+7670vaixr
 UELdSSHNcfnvsTiFdpF4b9/4qPvdiUECM1vknUZ4+wvTk0Z/O1f3p1UHstYoV+Py7wuVqSaryHl
 W8p2laB+qIZLUjS4nqvEiqvhJ8xJqsYVCjXGW4xSPYu2YoRe1zXT2GRlySuvf1cvTxEkQEBT/ql
 Fe8cSPpiZpjXaz1UPht2dSpBPv3xm6WGzNAoMUdm7Sj4Ob7nKlCm2iVqO4C0PdEqbcBz53aeOwq
 z04SJfhJbw37O0T7VaGYQymAqLnsrkCL7R8RRVaEVwMa5QBQT/IDedRUYtUfwfePlk87C2nCV1P
 SbEbhVdM+j62T4kwimslMoK8XWQ4fAyFivVcrqy4MuDlHO/0awVXpyQQNCy8l+DEPo+2g43ANdI
 v5rNErb2ZgIBf/MmJZge1jKD9KxrG6VDx3gi5vvJXIYTyVljSbjpG76BE/udGUpBPpM6UNTKJje
 flNXA22MB4HX6PGD7OcJy4/RVYYnt7o
X-Received: by 2002:a17:90b:48c5:b0:39d:f247:bb3 with SMTP id
 98e67ed59e1d1-39e54e7c1camr1813280a91.21.1789692278875; 
 Thu, 17 Sep 2026 17:44:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144cdfc3df2sm600286c88.5.2026.09.17.17.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:44:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 14/21] target/s390x: convert exception to raise_excp
Date: Fri, 18 Sep 2026 08:42:16 +0800
Message-ID: <20260918004225.827-15-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918004225.827-1-luoyonggang@gmail.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Drop TCG exception and call gen_helper_raise_excp with restore 0.
Keep data_exception. Route leftover C SVC execute through
cpu_loop_exit_excp.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/s390x/helper.h          |  1 -
 target/s390x/tcg/mem_helper.c  |  2 +-
 target/s390x/tcg/misc_helper.c | 10 ----------
 target/s390x/tcg/translate.c   |  2 +-
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6a7426fdac7..ec27ef104f2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -1,4 +1,3 @@
-DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_2(data_exception, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(nc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
 DEF_HELPER_FLAGS_4(oc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 414e6838c87..3f754dac00f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2488,7 +2488,7 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
     } else if (opc == 0x0a) {
         env->int_svc_code = extract64(insn, 48, 8);
         env->int_svc_ilen = ilen;
-        helper_exception(env, EXCP_SVC);
+        cpu_loop_exit_excp(env_cpu(env), EXCP_SVC, 0);
         g_assert_not_reached();
     }
 
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f1c8563af00..f5e31419268 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -56,16 +56,6 @@
 #define HELPER_LOG(x...)
 #endif
 
-/* Raise an exception statically from a TB.  */
-void HELPER(exception)(CPUS390XState *env, uint32_t excp)
-{
-    CPUState *cs = env_cpu(env);
-
-    HELPER_LOG("%s: exception %d\n", __func__, excp);
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
-
 /* Store CPU Timer (also used for EXTRACT CPU TIME) */
 uint64_t HELPER(stpt)(CPUS390XState *env)
 {
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1b6023168bb..2107ecfbdc9 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -400,7 +400,7 @@ static int get_mem_index(DisasContext *s)
 
 static void gen_exception(int excp)
 {
-    gen_helper_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_raise_excp(tcg_env, tcg_constant_i32(excp), tcg_constant_i32(0));
 }
 
 static void gen_program_exception(DisasContext *s, int code)
-- 
2.52.0.windows.1


