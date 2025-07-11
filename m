Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C6DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSn-0001ol-F0; Fri, 11 Jul 2025 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSk-0001mP-7g
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:06 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSi-00031N-Du
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:05 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73a44512c8aso677069a34.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254583; x=1752859383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlf4WqrmYk0iCutXq0TkvLl72vNt4ux4AtRsxMUkqTg=;
 b=ASZz3eeiOYoY+11LeIOuO867wMPc7v1Wm+pEyIyy0zqfR3PLDrzB31k1NaVKy78Zs8
 PypMSDQ8aAEiWdZeVhiXlw2yeYK9l4JbExj0ZqCesgjjS9hIUA0k92XE4pg/SjhYcyOt
 4nPgAE7DqGt2S+DFUafB+szR1jnbIALvQsyeuE3UC/qdbsFIJ04/c2aX7b05CrcNrSdo
 TQXUcd9N7JB6lbyfpDuGmFwpayIlIUYt8ILg8/c92lV2Odt4pCN5dg44O/709Z/WIEBo
 hKY+5mVQ+9y1YspdtytL30UModzR7DY/PHTZHMA0aQUkGUV1yL5/WaukfHyhJd0ScN9b
 xKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254583; x=1752859383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlf4WqrmYk0iCutXq0TkvLl72vNt4ux4AtRsxMUkqTg=;
 b=mXAdOcCr4b8ENGhWYyUDGW/n0CSZY1TCvwKXAum+o/f9UEXrA4wBd0tfhyDXIDKhwE
 P6xL6ifA7IwGYzDI9+zOks96GLpLhHV+3y3m2CllGw6uVS7YyM0MSBOFGCkcHlrw7CkM
 Dasj2zaMlRNM/CBjpgKoVDt7iMKpTdPN3jVu/cMYOMh6zg7RdKyQ/LBnYVBN/3dPh7Tf
 sx6DTlRTd5uhwbsvmYNuYrcuDomaYrso3vCdsu8mSSGRGwLDkzbRu15tWIh+xyvQ5q5Y
 8B1XoJAWFk+JrOJheD+84vwSbk277h9apFnMEk3CtfPiJwjRBi9m0mZfSnG6a21VrRaf
 3J8Q==
X-Gm-Message-State: AOJu0Yxu20t8ZcLjFki06Dgx7/jZMguGCEDqev5rN1btFx4aL/7CXeBS
 g8LV3otZrnUOPyi60DHD9KyIy572Z8GfkiXaPGvctnEvIwAPJ5U+CPV/OLtfja4m/pgsl+bLct1
 p/K9yMXI=
X-Gm-Gg: ASbGncsb39JjCpbNG5Rd0iuNIFRWUmwTGAjaE91+sDABouYBHrJhGrLerjSiS+AC0C8
 w1ZeS/AeaqPOSQtFs5m/7ydrRGrz1n3MOACadvFbZhHclMFubbzSY01hEP1hTxo+iwKwYfdw7X3
 9vOx/yQa7+t+6CylAmn9Fu7BZntIteDgbmF8CJjFIrqQ5MJI6t2gP30Oc7I6MShymGelMSppE5D
 3ptGEsiu9QZr9ynbM5RbQOm1kCb9qatIIjaUUmTGyAJcmaiAwLkFtVjWxv9h1EzGseoEh2NggRf
 846NOYwfjBc6YnV+vmXfciPbVjxRUJR1CEU8vZez6T5NW68vk1E9OvjXfiP+o9mA0+nEtYIgHRn
 1/lyfir6ujFq62LEGFgF/pqZ4MdG7e61Aede0na1JUJ35ZCgwrpWOAA+In/FHJd+kVuUTEUUgtl
 HK0LtgFL2K
X-Google-Smtp-Source: AGHT+IHinaVlHBSnhuzSQBIYX+I8Tsa/P14/idsXjyRrvI+ADN4ne3fKTQh9+rWSsYubFfSzm7iyew==
X-Received: by 2002:a05:6808:3505:b0:40b:3390:397a with SMTP id
 5614622812f47-4150d746c38mr3089082b6e.7.1752254582985; 
 Fri, 11 Jul 2025 10:23:02 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/9] linux-user/gen-vdso: Don't read off the end of buf[]
Date: Fri, 11 Jul 2025 11:22:50 -0600
Message-ID: <20250711172254.229201-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In gen-vdso we load in a file and assume it's a valid ELF file.  In
particular we assume it's big enough to be able to read the ELF
information in e_ident in the ELF header.

Add a check that the total file length is at least big enough for all
the e_ident bytes, which is good enough for the code in gen-vdso.c.
This will catch the most obvious possible bad input file (truncated)
and allow us to run the sanity checks like "not actually an ELF file"
without potentially crashing.

The code in elf32_process() and elf64_process() still makes
assumptions about the file being well-formed, but this is OK because
we only run it on the vdso binaries that we create ourselves in the
build process by running the compiler.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250710170707.1299926-3-peter.maydell@linaro.org>
---
 linux-user/gen-vdso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 1c406d1b10..aeaa927db8 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -124,6 +124,11 @@ int main(int argc, char **argv)
         goto perror_inf;
     }
 
+    if (total_len < EI_NIDENT) {
+        fprintf(stderr, "%s: file too small (truncated?)\n", inf_name);
+        return EXIT_FAILURE;
+    }
+
     buf = malloc(total_len);
     if (buf == NULL) {
         goto perror_inf;
-- 
2.43.0


