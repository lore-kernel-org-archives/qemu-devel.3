Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F2CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeY6-00080X-ED; Tue, 28 Oct 2025 03:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeXo-0007y7-8F
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeXi-0007rc-Bw
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:55:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so4997590f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638095; x=1762242895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oO7sLokKX2QCnssZFO5WFHuq3Y1NfJEe4m2IyupwL7s=;
 b=AKtN13lIduOpOWUP7/q05hSNzlD1XTQ6iMZbl2/L2bYLK/ljpjJJAxX24GfbTVeK7u
 5+524V7RgHt1Ev8sUMAGgRwyl4mi+eQ6A6/3GzxomXGxsq7vq1J6mdpvAi7lO5omKLC2
 GWhXZhFKKyoURT9lhF+yU+QX6qTmSUW+a0OKMUFvbHE8mUO/DObV/0M4ktW7kS/WcuhA
 5wH7It6Mj4lW6yGPUjLqNipvU8Lwqnpvi30Z7qkvEM2yLceuRJeIfdwaiZ87HfF0I5Va
 8LgzYYaPDzy9USgWmH8GQAL0JM3nJ8YMERd0PfpGy7tWNUKuRHwb+99XL+WKpoih1YhA
 abAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638095; x=1762242895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO7sLokKX2QCnssZFO5WFHuq3Y1NfJEe4m2IyupwL7s=;
 b=DovZgaf1LHqd5mPMLWBkfHJJdMPpHTHVhqPowlgN4quPxeH0jOihhBsyP00Hs1tmn1
 Ee2/QDuz0T6t4uHUHxIaHUs3BfLFYt288oHEFmyaE/vniVWbAt+TSkJ4c7Ud4GaZORb3
 Gg0XNqgV0HBZg8c8DtlkGk3wUfDXjSxUSQSZLJJ1Nd76okLfFqH0znpDx3/wUP7x/Xjh
 cDeJOAjtXQn7WkHMKO5BN6zeCPsDvCV3j4/xvsfexM3jU51hIUebotE/++cl4svRlrup
 NQ7ilDj2eunna2TTDazg07BSQ9h4la5kEiLdQ+Ie/hWbsEkrDaPukXURpqbBHrc4R9Ds
 1H7A==
X-Gm-Message-State: AOJu0YwFOSR1UyzsyWf4tpUuxWI5hBTYDP0sZ3Y5VfXfIwKK3kph/eHE
 uLCk5h4JAzunih7y4IHUwfld9vLdPhODquHeUPBeJkoQ2+uASaRDz7GB8tSlcYGNlEB4xIx8Mhi
 gU+cFdvc=
X-Gm-Gg: ASbGncun7HSSURVxLhowZhKYDUCebW0OdurmI595e20oryBNSo566UBAn9q/xuL/lSa
 dwZPhsvEbuaNS0DPjgHKceLDn+tJdDEZTiRodRU5KiOPzkJM5Mo8yW7tsBwkguEM8FGmS9/nKht
 P0boaWNqd48C+rAIYulvnCe/SagqDqrMcl4AL+5haDlHA46JCdEawdTu9Rc3kbiM+I/AEJ7u0Rz
 prBpNG7PTmCshElRrcS4rgOgjpdG7xDbELPVtkZqKY2BGpw6FTsLK2VC2HK1gDuMCtljJSBJCOr
 CsRAt5dV91M/juW0TDyrosJY51VwtKgQDdLvHd69EEhhUg6RGhe6j665bP409GZyljQ2QEaYH6L
 ShFiJ9Fr6JCfcwXPdp7BTuzCs3mZjYjG0u/pnSrilMsPsavcm2cVY6zCRG9EtVkr8DfYlkf+Zle
 aNxpxTv4Y2CRtoukRNQAXp1kg03cXcEloywfE47DlIDQoDkUBvKLhLdK8=
X-Google-Smtp-Source: AGHT+IEAC5rkPk/V/A7gAkhFq3w97Ons4XCs+XrkDcHwrhePrTQQpdcnfmFDHVI2pHC4C+SQVWnT5w==
X-Received: by 2002:a05:6000:2f86:b0:426:d51c:4d71 with SMTP id
 ffacd0b85a97d-429a7e4d2ddmr1776777f8f.8.1761638095013; 
 Tue, 28 Oct 2025 00:54:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477c92sm179297925e9.2.2025.10.28.00.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:54:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 16/23] hw/core/loader: improve error handling in image loading
 functions
Date: Tue, 28 Oct 2025 08:48:52 +0100
Message-ID: <20251028074901.22062-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Add error checking for lseek() failure and provide better error
messages when image loading fails, including filenames and addresses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251024130556.1942835-8-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 7aca4989ef0..d7c11c18f11 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error **errp)
     if (fd < 0)
         return -1;
     size = lseek(fd, 0, SEEK_END);
+    if (size < 0) {
+        error_setg_errno(errp, errno, "lseek failure: %s", filename);
+        return -1;
+    }
     close(fd);
     return size;
 }
@@ -132,11 +136,20 @@ ssize_t load_image_targphys_as(const char *filename,
     ssize_t size;
 
     size = get_image_size(filename, errp);
-    if (size < 0 || size > max_sz) {
+    if (size < 0) {
         return -1;
     }
+
+    if (size > max_sz) {
+        error_setg(errp, "%s exceeds maximum image size (%s)",
+                   filename, size_to_str(max_sz));
+        return -1;
+    }
+
     if (size > 0) {
         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
+            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
+                       filename, addr);
             return -1;
         }
     }
-- 
2.51.0


