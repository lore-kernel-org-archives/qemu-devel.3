Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665A8C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VT-0006X5-UJ; Tue, 27 Feb 2024 13:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VS-0006WP-BW
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:46 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VQ-0001TX-VG
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:46 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e445b4f80bso2587881a34.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059723; x=1709664523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IQWSjcLXc40VTcQlmdhU2o876C5B7NqB15Y8LB3+3A=;
 b=SaZFfP9rtg11C3ruHczOU9+wbj+9BQi/geWUqoL1W6ZJZT3Eupta3nxSXayim1Krpb
 roRxh8n9iUjlGiOyebxG24VzxjYYOlYJDPcqI2es0tLJsXcvT8+VOLkCT36B1LNt8lIX
 rjVRl24JRgigYlB4OMCP4WWoUHE0nVkX59Bvb0C4wCclav+99mw6Ea+jCl8GQL+/KR3g
 BFJ8lNZ1TccAGeefkyRLbieLTmd5EHvcqCnRbeNCS7z9mb2K1TzLdHPi0dsKJP+OWKjz
 USGbef61hRO0JDczE43pUYcg0W2EBROWpCmsijtreHA+CLMiAuJgm/VVrLQ8FOqhUUAw
 O67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059723; x=1709664523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IQWSjcLXc40VTcQlmdhU2o876C5B7NqB15Y8LB3+3A=;
 b=QNFg/Ky1TSVyzeNJ311HFDv1cfkz8+6GgL0T6VUTGetcA8AX58k1Yh0gzbzdwSIm4e
 vUZWSJKiWciP+xkr11Mv38Gi/tgu9AGOMhhSsAUuEUbuxuEG8xOB79I/nbs8cZrmGx2k
 j3pEC8Rsj5qvkKJaE8ukmk9vlXjA21+19MV7gbqSPYKIzMU8cs8NyolbPxqxKCcMgq1Y
 PW8p5HsS+qAObwephQ0Cuo27WUudr2wQRPE42vK6pRT6b3ChxpQg59QOaKHZLdQvTSkG
 f1ZjS8jF7RI79UnzHOP13e8P7Mkf+eNyICwLrXK5AxZWk3Bt2ghPqeyO596zN6eYBSiB
 C2MA==
X-Gm-Message-State: AOJu0Yxi5KmwInBn8Iz06HjdZcPpOe58cJ/JU2EDcihNkB78AYTpyVyL
 U8sKQ7xiu21lz8yH/3tpbznHAEQ0RgxaFnXwPskIixbSVz20WaTmdF5Q5N8CA+P1Pl2n/4scl39
 y
X-Google-Smtp-Source: AGHT+IEyLVLD8uA5G6PJo6Aq97EcdNVif9Qz06281L7bF3lKNKunHKBbpGUimCpxu1FmLRAAzy88VA==
X-Received: by 2002:a05:6870:700e:b0:21f:c705:7d8c with SMTP id
 u14-20020a056870700e00b0021fc7057d8cmr13325878oae.26.1709059723679; 
 Tue, 27 Feb 2024 10:48:43 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 05/14] linux-user/elfload: Latch errno before cleanup in
 elf_core_dump
Date: Tue, 27 Feb 2024 08:48:24 -1000
Message-Id: <20240227184833.193836-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On the off-chance that one of the cleanup functions changes
errno, latch the errno that we want to return beforehand.

Flush errno to 0 upon success, rather than at the beginning.
No need to avoid negation of 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 98b82b1a49..39d9ef9acc 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4634,8 +4634,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     off_t offset = 0, data_offset = 0;
     int segs = 0;
     int fd = -1;
-
-    errno = 0;
+    int ret;
 
     if (prctl(PR_GET_DUMPABLE) == 0) {
         return 0;
@@ -4755,15 +4754,14 @@ static int elf_core_dump(int signr, const CPUArchState *env)
                 goto out;
         }
     }
+    errno = 0;
 
  out:
+    ret = -errno;
     free_note_info(&info);
     vma_delete(&mm);
-    (void) close(fd);
-
-    if (errno != 0)
-        return (-errno);
-    return (0);
+    close(fd);
+    return ret;
 }
 #endif /* USE_ELF_CORE_DUMP */
 
-- 
2.34.1


