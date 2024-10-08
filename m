Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B919CEFC30
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMi-0003Bz-FM; Tue, 08 Oct 2024 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMg-0003A5-A7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMe-00038b-JS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37ccebd7f0dso3856820f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728406031; x=1729010831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPS8T9HM0r2iLvg9UzHQYZkqDBzvdQAydM+d7oCx2Rc=;
 b=DW6poaPawP9XGfEdw+yWlU4JdonBavdD+V32lvJfv1hdzj3zZU99I1Wqshey7BwNE6
 7jCuUL599tp4G2tZjh79kVuH8QRnvql3bgVROohFQMVXy2V95T9eEjWLpNRxq7zTiHTd
 EQOBdB/w4JZ/J8OE6COuzDnxW+ST1+kHa+KVlULZgH3ah8NGD1ORG1cJoWcbRYzF+Jxt
 BOOq8XxlA0SD/FFQlbX9IAQjWNBFNEn8X1XeHGKn3Jsz5rU3l4c2w5tR4iAT4NehPfud
 GMYKAjCiOtPPW6q/jHAJp/UfB1L+P7N4nYxha/UH/fafLtmVeyude5FccwJny/owm+e4
 HHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406031; x=1729010831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPS8T9HM0r2iLvg9UzHQYZkqDBzvdQAydM+d7oCx2Rc=;
 b=Ruiu9o9fk7dI7VQlSeXJbCI+riTe1oanj9rTSpcW4hWGZqQwp2ExShePLL8+tNxjqL
 JIS7meaPWyPC49LqIU7br/SuQIWdicMdrxkb99S5AeYeWrvea9Z8EvtH2fl91Szg59rO
 h6oGWGZ3XlrkCI5tRXhraD9F/2QMwE86GQYneTd1NNy1+S/93SqpGMz9oOHWCW0q8Qw0
 ProV3IYy2YndrA58IZDZsJB+pfKXlNtLl3DgWHCv1ZOa0GAX6Y7wX1ixUIN9DTNPmXej
 /802OOoNd1MW297MOKG3VtT/7asqKoJ4+cF3mT5uj4PnxIaVwKN6EdAXRVyPxx/exG1i
 ATiA==
X-Gm-Message-State: AOJu0YytHEkKSMb3FGGXsZoSK8kfnIAib21gVP8ZD+ogrmFUd6abt/U7
 mB26Dzr5Et9jetCMT0MUPuoRGBhDBj52qT+MZxeAKggaKMEY0gM9+e84XFVXo3tHFj16f1O1Tzi
 2
X-Google-Smtp-Source: AGHT+IH3aYA9+8nuwwsOYDJV8WUvzbUu20prkb3K2pCG0e3iYDNC9fJs/yjKpRXb0tzezfbu+6smCA==
X-Received: by 2002:adf:f005:0:b0:37d:377f:da50 with SMTP id
 ffacd0b85a97d-37d377fdb22mr958285f8f.35.1728406030884; 
 Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm1490936f8f.68.2024.10.08.09.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 2/4] block/ssh.c: Don't double-check that characters are
 hex digits
Date: Tue,  8 Oct 2024 17:47:06 +0100
Message-Id: <20241008164708.2966400-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008164708.2966400-1-peter.maydell@linaro.org>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In compare_fingerprint() we effectively check whether the characters
in the fingerprint are valid hex digits twice: first we do so with
qemu_isxdigit(), but then the hex2decimal() function also has a code
path where it effectively detects an invalid digit and returns -1.
This causes Coverity to complain because it thinks that we might use
that -1 value in an expression where it would be an integer overflow.

Avoid the double-check of hex digit validity by testing the return
values from hex2decimal() rather than doing separate calls to
qemu_isxdigit().

Since this means we now use the illegal-character return value
from hex2decimal(), rewrite it from "-1" to "UINT_MAX", which
has the same effect since the return type is "unsigned" but
looks less confusing at the callsites when we detect it with
"c0 > 0xf".

Resolves: Coverity CID 1547813
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
v1->v2: make hex2decimal() return UINT_MAX, not -1
---
 block/ssh.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 871e1d47534..9f8140bcb68 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -364,7 +364,7 @@ static unsigned hex2decimal(char ch)
         return 10 + (ch - 'A');
     }
 
-    return -1;
+    return UINT_MAX;
 }
 
 /* Compare the binary fingerprint (hash of host key) with the
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


