Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6BBECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo74S-00077k-Nc; Thu, 05 Feb 2026 16:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo74Q-00077S-LA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:39:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo74O-0003U4-Q9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:39:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so459535e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770327560; x=1770932360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4UGthzNFB3vNC7GAlY57Iu20J3KV0ME06Ss/wevElZE=;
 b=S53qLGAFp2PNKH27xDI6mVuR6dbN/2AudGfpoeFGQNUgrSsrt9D87DUu6r42dtA0W7
 cOjX+LuilYxI7ldEvOCufYwNHAssw5uPsdl9XNjdwNaiWOCdBMBrp4zyr7mAmAqfMiDO
 elUi0uhiwU7KrkaaBwb8+S+dnIiT/RmJyvEoTMsnK4JKGku+Chw4JiuwkU0eqBIPQyF1
 gyDyVvLd4XH9WCKyQwCDKyDscvtJonON6+a5gZjKAp2Hyx/ZlResRHhAHw7P/DLEJtsj
 0L42qdJpjOmoQdS9+2Yp/UKtmVMTpVP8bUKByHRQMkDrfpKU0sUe5v9z6at5XGiqnH8a
 +l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327560; x=1770932360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UGthzNFB3vNC7GAlY57Iu20J3KV0ME06Ss/wevElZE=;
 b=U6t8b/B2oVoMmQsxX7ldDzIK4tiv5ElXRG5Jgf6SawKv/f0CEwxNh6BPMfvCtZYAKi
 yGPrbFMqkMULcVDMchiZ5LXFT+HkVblzUvmDWcuFFplufFtfjUAHU8IaUdXVvboA0WlZ
 ZoGWspcCFBK9jYg6wT1ieTXJL49yF+Ag63iO4XtFxsmeJTGzy9OgWHgsNZXgVYphSFyZ
 d8yxHcHh0jITliGqP+2ZH880OTMmvSIsHZVKzvxEZ/4bSWdfsZJcd7qK1bIsaHy40mOv
 uh4UScpcbyHBEItRD9t3JL2jUvjNJKZdEjAFWInZiPrhubCWO/CYFam+vtNSDfTqNjlY
 0Ukw==
X-Gm-Message-State: AOJu0YxUuBy2gqpuqYHIlwu6t5yNUpSn+9hWsDv1z4OC3+wZcUOTLPSU
 PLcZQ/qH6gP7teejjQZqC4vzVeI9jjECOTyNjI/ZqkKjwa5oTHP1C2wsUx/jM66dBnZcQH4HQOI
 AX8s+i3I=
X-Gm-Gg: AZuq6aISlU4EN4Zht2WSRHSSNHtLEdwOBxsMqXu18X/nj4lcqq0Thy2Tm/bavWdKcu3
 wbtENFXRyeBNZ711kFkTugdhnHtioJ8/nxnqgCk9+v54zOjkwZUJkT51SESbsWi6jla+THyu/8t
 vYYh8IhtiI9qrw2uK3mKOGIizwUpYOWvBb1lfkSh6GuNTN9+1kWh32I/N3oNmKjkR8xDxTUJiLz
 qOTai00ExXdRVEs5MHt0gaiF6YdZ+6yLg65CwXgF2BngNYo6ufV8Ym/GveODm46UdfshsBpxEMa
 C+wB2z9sE3+hvw89zafQxyDm333Iv2v5v6ToNpQX3ctq1b16CPzR/udSF+qJeSeACFEBNrUh7ql
 bSarA4HXMFCrtIL04mbKhckzC3n5E6m1nq+ZICnoSjKlnA73lZe5wtHONm+4i9dEFv5cJwiJpn5
 eb5oaDwIKbl+qC4RhOhuHx89l0/qhCzdH8meaDyU3Xgs2hYudHU1Yt8qi6Yks7
X-Received: by 2002:a05:600c:3b03:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-483201e3b8cmr11416225e9.15.1770327560006; 
 Thu, 05 Feb 2026 13:39:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206cc7d3sm6994245e9.5.2026.02.05.13.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 13:39:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/s390x: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Thu,  5 Feb 2026 22:39:18 +0100
Message-ID: <20260205213918.10956-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The s390x target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Corrected $Subject
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4dabd49840f..203afe265bc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -217,9 +217,9 @@ void s390x_translate_init(void)
 
     for (i = 0; i < 16; i++) {
         snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
-        regs[i] = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUS390XState, regs[i]),
-                                     cpu_reg_names[i]);
+        regs[i] = tcg_global_mem_new_i64(tcg_env,
+                                         offsetof(CPUS390XState, regs[i]),
+                                         cpu_reg_names[i]);
     }
 }
 
-- 
2.52.0


