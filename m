Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB7EC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvG-0007RX-Ao; Thu, 22 Feb 2024 15:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvA-0007Ji-UE
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFv9-0002i0-A2
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso2134855ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634634; x=1709239434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=RsyXnn73y57gyDkwUIBbtfDXsXCLbEgFRPqiHqLp6amJH+kLAIDmwi8MJjINWCFoME
 wXouhiMID6n8fYRH+kj1g3K1NL3wb6l98oacuiUY/q/8MPRteHv5kQNTlMNuu0H6sTFb
 GtPfSiTspdPDWlxXHtp7McSJvGQQK+hJ+yR/OCmIOIRNJi+4fUGzAOLMoVyNHTascPZR
 EgKDdgXYBU1suo1HRRPEuUh2HCnGyYzbgS8V8jCWFnjmofnhxAmLOdvsMQmWgA51qmIO
 PpEoAH7LMG8cDXGeMc1CbZ4UPJsuHAYw4VP6HP6hayayhybTDipNufgR2Zl+wIrjeqXH
 /xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634634; x=1709239434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJwI7j8qAfDRGrC+KBy3NdL40EXjR4qHacqKh2GDQwg=;
 b=TT0DvIduE7/opdyHNJQvtK6Aqjp3VOTXbnJM9rZ8FZcuepVxEC05wGvwasrjf7enjJ
 fCrqr0P/ofnr/8jOBEjDBTeIkexHnWpp8ftnyj+ouV+zrwmxVsdhTSFeKvDeasDyUeKw
 aSeF8Nt4KD7g14AXv32QfB4bXafb5QZVdcDBrbHbMTqDxxyL9RwSQLawPMzWEh8XqLfP
 QqfXwP6f+znxmixs7q8EWeWyTUFpcgVO0hFBoyxxTDUoKGNre36WWP0GZPbFtcBPewOj
 91gNcUWQoBhiT76/cKvYg9HUOH+khqDZGzx03pTavveLGkOH8Qdl602KbAzGA0yLLjaW
 3qNg==
X-Gm-Message-State: AOJu0YwjMxuokF7tlpMdosFfi0SNwNzcrw0+zP3bO0wbh4VmgCZXO7Q9
 leZFyupzyJmp3dGGYjzVGBXq3raZygnBRBI+JoajwzXPlSxN7hgAOjwTKFCvchMn19NmrncQ26X
 L
X-Google-Smtp-Source: AGHT+IF1Hzlxd2DbvHsKIwLQSpwa+5XE8Z79DClSdlRPbx+SPNUadnHfWBWfTGFtWORSGe1uLxHsjg==
X-Received: by 2002:a17:902:ecc1:b0:1dc:43d:964 with SMTP id
 a1-20020a170902ecc100b001dc043d0964mr12783669plh.48.1708634633879; 
 Thu, 22 Feb 2024 12:43:53 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 18/39] linux-user: Remove qemu_host_page_size from main
Date: Thu, 22 Feb 2024 10:43:02 -1000
Message-Id: <20240222204323.268539-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


