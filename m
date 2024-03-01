Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A523C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByV-0006Aa-7m; Fri, 01 Mar 2024 18:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByC-0005ZP-2L
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:12 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByA-0004L5-Ke
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d944e8f367so20482885ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334429; x=1709939229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=ya5qaDan/hzcEgpsytylYs8ciE4to310wI8aeCp65LDnbsv0vdSJBSA/e21XZxVRNO
 R4B35v6x/m6YlWfqSWVOgUORewCM2MLH9sMH0FbiZ+6khp41Cazbg9JlHYSIvC60qc1r
 y6ug2xy9U2Heoljesuo/VTGuhEqSzHFSgFgRaEoR+CrRNwz2HFZfb7dx4lqygCuWHmgh
 GlYPHOOZXpE/y2Igsk/nBEpfSDShWYB5R8NNCsmnRa8Lm/smgXlsgUnF+wJRapp/Cfsh
 uFZk1RhVDtSz0d1ghZVWPCFBeI3jlvbZvtbNXHcO9zWf/o/KrxRuaCmaiUDqEIauzfde
 bHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334429; x=1709939229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=Yh+veHN60ciofydIRp/3veAjJdQ8htkN/4YiAiQbMlN3RYOxYfgQ/ItBV3/kWhR5gs
 diwDID5Tj442p2yzQ2cXNCFMROmf8QL5DQM2SAapQ3TZeyV7UaOWCMVNH/qU/49U1Zdf
 lQGJQOCPrS3PYBJVuDrchG43TxHzthK3+PGs/wTq4xz0rEIxtvDOhJ8dSvMdSyPojeS7
 iQ3JsKLvcPGlAfn92w353BEZATnWEd/yKW/i9XWp1vStLPpCfw0R2VDaLreoT5AjM6QQ
 lXjW6EmfFzYzfrB76qx4MvC36d+MQezFlqtz1JrvjoXM2n8g/VRqEu2cNYvDcXz+2qMS
 g0dQ==
X-Gm-Message-State: AOJu0Yyn7a/g+Nx820Le60qBBKDDoXfKQaKoPlcP6P2jEsaBf4PAbIAS
 tejksMiJHwlOLJT6HYazHP6u4VPwdEULQrdDutDcZNyNrY2DNRSfjkijY9Ca8MqLUx4PRHEnXUW
 A
X-Google-Smtp-Source: AGHT+IFlPmwz1bfvm8y8yEceEr8nSyzJKU8cdALhmxvJlMbPOfJWq285FAm6pe8VEwAcogJhXpRXKA==
X-Received: by 2002:a17:902:9a07:b0:1dc:7890:cb27 with SMTP id
 v7-20020a1709029a0700b001dc7890cb27mr3006831plp.48.1709334429464; 
 Fri, 01 Mar 2024 15:07:09 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 33/60] linux-user: Remove qemu_host_page_size from main
Date: Fri,  1 Mar 2024 13:05:52 -1000
Message-Id: <20240301230619.661008-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-16-richard.henderson@linaro.org>
---
 linux-user/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 74b2fbb393..e540acb84a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -781,7 +781,7 @@ int main(int argc, char **argv, char **envp)
     }
     cpu_type = parse_cpu_option(cpu_model);
 
-    /* init tcg before creating CPUs and to get qemu_host_page_size */
+    /* init tcg before creating CPUs */
     {
         AccelState *accel = current_accel();
         AccelClass *ac = ACCEL_GET_CLASS(accel);
@@ -804,8 +804,10 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        if ((reserved_va + 1) % qemu_host_page_size) {
-            char *s = size_to_str(qemu_host_page_size);
+        int host_page_size = qemu_real_host_page_size();
+
+        if ((reserved_va + 1) % host_page_size) {
+            char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
             g_free(s);
             exit(EXIT_FAILURE);
@@ -902,7 +904,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_host_page_size;
+        mmap_min_addr = qemu_real_host_page_size();
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


