Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5178FD8FE4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfbv-0001td-61; Thu, 26 Feb 2026 12:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfbr-0001tH-Gu
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:57:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfbn-0001K5-Eh
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:57:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso21903695e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772128622; x=1772733422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VULc4I47qnB/aEbsYNXu0BHGq7e6dxcofayMYitg7Is=;
 b=gfBs2j5XkKUxUibonm+EpGUuV0dqepe6SE320l4jcpb0mnaVznexsTdj+K70n5l//1
 uO8c8otqPuWKZb5LKnoF/4OcDgBZDYig1UToDjYTL1vULt1ZJfBJGM1rAoQ91MijOEwy
 RniNhxeV0ySO7tMEJA5AGEE3YEfnxot59unwVA683VCpRWyhWMKAAJ6cQlad21lQQ1nx
 txwpwLLWrQZ5ER7UpE6BxNuO376r/7OBfi3P9WVQmN3U1dABRf8hfytGiUj9RcjKnTlz
 2BPkYYdaqYnVkRr1fc+jZtAy8KuagfZfTpp3RbsV3Fin+Ps9yh3LKGBBNUOvPwJVrDoy
 RaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772128622; x=1772733422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VULc4I47qnB/aEbsYNXu0BHGq7e6dxcofayMYitg7Is=;
 b=pxpeZIja+wcBS4hqfvCY7EbJp59DPF89yf0+k82AOdtdI77IrjPks9R/GwDkTwEH1u
 aWdTC0qDmdCiC0t4BevS+o3jzTm8Vlym4WOltp1HmPZey729X03lBiS0NHUc6Ap7PiMo
 14dWhP6WHaEq4Qcbd5eroLsc+WaFSuiZ0+PNg2s5H49ydvFH818x1hgVTiTCqbRFJQHR
 gaTXBhQiUV62kkCmoY4TbOLnQPTqQ4WWmvXjIzqrp6hM6+Kah10AqQz3/avnD/nnOuEH
 q0y6Q0HywY0KLIDgPQrSNfTldh0kW3aQTb/v1rdmSaQe7TpN2lGBTAYh1RJonnF+LZMG
 Fzrw==
X-Gm-Message-State: AOJu0Yy70EhwVpez+TId0D8ZJD32XoIMoXyWBwuOoSuXdcvYp8Ar3K8n
 CqLNPeNbb6etyQI+6Wi3wXQpOoEM3zwReb5CicY7CBQinULpuFoEX9H/NFtmouyf/q/71UV4g1r
 z0mYo
X-Gm-Gg: ATEYQzwMQsPECALa+o7jZpCdf4PPI68NvDoKNQTPkc/URgfHE8gWpX4/EiqwWIXOnb/
 PPjT1v4g+jl8NKR66gBzeNFUtGNK5pc+FRb555bmpDSjEOT8Hi2M1LGOFD+eSHQ2GBZfBay5N6u
 PiDAPYAi7ZDobSQcjRfsWbYBj1fFnoQ2tRfyUnG7hQgbDX/ptlb4GrR9hygLzjDhBI+3zJYCIEl
 JfjA+qvHfuaQLAGzgs5lppGxMl7i4GYhv+WZThc7Bfp/Ddr0jG9lis7v8YYBL4AxMsn1T0cro1M
 +LyfcGQNSnaQ3czdLBNnBmG2aFcNUY3ViAtDXGGwgVM8yeB4U68RsJwe+TGqWhviboNDfdAIzJX
 qdiyAftEh/U7bcVzZAgWzEzSGvBJ/hRedyatYB2bhJADH/NpbDO0VZ0C9YCqCYz9BFEjav0zCgX
 +nbiz6UYLpYCOD/6IiuupxhmI7ggOvcJmq/dsLpWjBdunngVOTSoIM1pS37gamfVfCZtEnGOiLz
 oavbhcP6tKRU78bY5HKWjcooraFJ8k=
X-Received: by 2002:a05:600c:8b71:b0:483:7ea3:3de3 with SMTP id
 5b1f17b1804b1-483c33c3606mr66284865e9.2.1772128622006; 
 Thu, 26 Feb 2026 09:57:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd702e7bsm179257525e9.5.2026.02.26.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 09:57:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] system/qtest: Support comments in input commands
Date: Thu, 26 Feb 2026 17:57:00 +0000
Message-ID: <20260226175700.1319767-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Allow the qtest input to include comment lines, which start with '#'.
This allows writing an input file for qtest which includes commentary,
like this:

  # set up TCR in bank 0
  write 0x1001000e 2 0
  # TCR TXEN
  write 0x10010000 2 1

which can make hand-writing or annotating reproduce cases a bit
more convenient.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/qtest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index e42b83ce67..cf90cd53ad 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -71,6 +71,7 @@ static void *qtest_server_send_opaque;
  *
  * Extra ASCII space characters in command inputs are permitted and ignored.
  * Lines containing only spaces are permitted and ignored.
+ * Lines that start with a '#' character (comments) are permitted and ignored.
  *
  * Valid requests
  * ^^^^^^^^^^^^^^
@@ -370,8 +371,8 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         fprintf(qtest_log_fp, "\n");
     }
 
-    if (!command) {
-        /* Input line was blank: ignore it */
+    if (!command || command[0] == '#') {
+        /* Input line was blank or a comment: ignore it */
         return;
     }
 
-- 
2.43.0


