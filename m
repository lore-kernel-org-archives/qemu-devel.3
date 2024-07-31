Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARP-0004nr-Oo; Wed, 31 Jul 2024 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARJ-0004Vc-17
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:29 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARE-0002ek-Ki
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:27 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so75761411fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436583; x=1723041383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6N+m3/t8IvmE5Sgkmkq6gGUNm/dDeZpi/vHzdYBag3E=;
 b=Wl1onWjwY1bhrprcnf3qQgIF5Wr4/hlPrBlS09soj9EG5HOgZBZJ15024cIlmuSAK5
 zb1qy/v/iIhgjdgiIKJ6IPu9k6VzLfLa9Nq/lmpzdOHwtP6fbzFop/sQfHZiyIu14bjm
 uZ9WQ3zeTtQ7xibONY+ii5s2mvHk9mLPUBZ/pTYPJsiLsAcEhnIRb25ctuDvTbXEhU2u
 ArZ2C3AaSOng9fQHhMzPSXOtv9h67c3KGB/yBEDoQI8BxsIIk1tVPdIfAcElRPWbUja/
 4NrLd/SEB/83CTpOoozwc0ZM2icRQcv+nq9AnkIB2JSLhB+QfkFptRe41j1ITuKv4SJO
 hW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436583; x=1723041383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6N+m3/t8IvmE5Sgkmkq6gGUNm/dDeZpi/vHzdYBag3E=;
 b=SlxxCpoYcBLikr+lFMq+EWk3ArDQ9V5r+q1Fb9iaQa3Eh2aqVUuT9Pu+AGv79ByByC
 /VciCaLozbcuVBfAzMprkH1z9GSkqnja6HyCGPnZVcxTy0tCSbNx4aZJ5PC0dtJHhO+t
 3vpp/SiKo3IBMfWkqrdHPv/K1KU2aRcQcZswsb9+oKKAg38apB9I9GC3CjhSzXIXCaEJ
 pM0dQzwGdu4jRSLGY3Ax14MggvLUDg48Aduc6WjC3L1biJD/yIi2MSaNXfTfjQi0N4QI
 ENqYwu6sqRVmrl/MbDdii5efUR3tkC9U2ZNYBdKXooCARryffgjK/Ik7cEWwcPDtFf3y
 Yrqw==
X-Gm-Message-State: AOJu0Yxid0YtCvroYZnbERCVOGlMwDxudkRVEeTgVSWh7dEU+STtD5Pl
 NbcaMEQp4eB2Ig56P3qriBVAjztLuc9Z5KhoLMI8WjDFSWDCx7jKzZGLGSrRdyWFyNPwgww8ADH
 N
X-Google-Smtp-Source: AGHT+IF9r4V6T2a2m+mgsn3GI7Y2U5gf/aG2t4Zry+80JI0bMJ9IWysDmCtxx6a+j5H0q0Gi3BY1aA==
X-Received: by 2002:a2e:9dc6:0:b0:2ef:2b06:b686 with SMTP id
 38308e7fff4ca-2f12ecd2d3fmr109026131fa.17.1722436583009; 
 Wed, 31 Jul 2024 07:36:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 7/7] block/ssh.c: Don't double-check that characters are hex
 digits
Date: Wed, 31 Jul 2024 15:36:17 +0100
Message-Id: <20240731143617.3391947-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

In compare_fingerprint() we effectively check whether the characters
in the fingerprint are valid hex digits twice: first we do so with
qemu_isxdigit(), but then the hex2decimal() function also has a code
path where it effectively detects an invalid digit and returns -1.
This causes Coverity to complain because it thinks that we might use
that -1 value in an expression where it would be an integer overflow.

Avoid the double-check of hex digit validity by testing the return
values from hex2decimal() rather than doing separate calls to
qemu_isxdigit().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Could alternatively have put a g_assert_non_reached() in
hex2decimal(), but this seemed better to me.
---
 block/ssh.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 27d582e0e3d..510dd208aba 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -376,13 +376,15 @@ static int compare_fingerprint(const unsigned char *fingerprint, size_t len,
     unsigned c;
 
     while (len > 0) {
+        unsigned c0, c1;
         while (*host_key_check == ':')
             host_key_check++;
-        if (!qemu_isxdigit(host_key_check[0]) ||
-            !qemu_isxdigit(host_key_check[1]))
+        c0 = hex2decimal(host_key_check[0]);
+        c1 = hex2decimal(host_key_check[1]);
+        if (c0 > 0xf || c1 > 0xf) {
             return 1;
-        c = hex2decimal(host_key_check[0]) * 16 +
-            hex2decimal(host_key_check[1]);
+        }
+        c = c0 * 16 + c1;
         if (c - *fingerprint != 0)
             return c - *fingerprint;
         fingerprint++;
-- 
2.34.1


