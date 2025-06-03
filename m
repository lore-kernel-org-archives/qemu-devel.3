Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAF8C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPQ4-0008OP-RE; Tue, 03 Jun 2025 07:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPP-00083y-Vk
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPM-0002DJ-AX
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-606bbe60c01so921154a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948535; x=1749553335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9JTCX3puxR1p4q1IiR4N2zLiSIfw5jzEn0qqN/+AEs=;
 b=dCGoEMmeaSR6Q8XxNe1g3csJOTTN16gJZXKjH11DtI18BcjGjTtgCidqCMXA8yRt3q
 dK7G6xuRoDK9d1MrI45bB/dOJV56b5kqvJ6Y078yFlDdGUN5/smQp+/YmwcgyzbqwcQv
 uvo4jXpqBfflYasC+MhFS35wHJfU6EDUBvy4XLdx1vP002DwzDlJv4QStBP+L6BCcT/l
 QOCC02GCZ+C9XMxjOVhU2NRpc68menxOOO9jPxV9jy2vVAL/fP0wNnbwaZHvl659PPAg
 FIPigmqp2e4pk+irqp/OcuHTTAqZ4iiFzJ2H/O5bL3tj58BFgsza/U5O6qXf8p82kQ9M
 Wr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948535; x=1749553335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9JTCX3puxR1p4q1IiR4N2zLiSIfw5jzEn0qqN/+AEs=;
 b=DYOfTkua1wQSmUQgL3/2T1ZScJcZeKasOHwiw4U9JlBdq6CU9PAaCe/q1XXUbqcwtw
 IbRn42gLk6qukOqx5VRlYBY1VCcpGjWBVPEX3E0P9e9hvMOvJr/YnLrXC3L416JDyUJO
 Fxsalr271ikKChW6bgCcchwX5rXfFQIwFegz1VlNHQgkcmT8y53xtfZN6SuFH+ZzNlLC
 vEkdtHxs7RUu/siGsB2hMYN6/2d6zGBCeu48KCKw+ikhQEl+mVhG+aoXbFZzlmLPdued
 gi2VUadJ/gR+Uw1CNbrBN7K9dC8/SQm3J0kk71qAiUQqI8290I5gyQ37w8Y8qYsYP1Kc
 EsDg==
X-Gm-Message-State: AOJu0YyVj5MHIzLr7r7Xz/SoazzB9piNCi8nI1xg6Q4kdc6fYS5I7Zz3
 d/f5fpbE/4ujhQ1VS+yFDgN+38ZEccWJmpJP79MxfEZTaqeI1xqu2L+rK/Qyit5YyFg=
X-Gm-Gg: ASbGncu6JBMsZp922vjbFOp6NGywocHgLieR7x/WnHzoqlVnp/StuQoBntyiw9kWnUQ
 ypDwWpPf3/DM1pZpZa6te7MIX727dcQYvHaN68rEts2nUG7IxD4lbJVYyjoNGfhjgHQjpAQgsPZ
 tRFc7hccnKu8UZ10428yTYfjDSPphv9fDnUIjG26kkFNE0rlfs6WOOURY0fFowFQ8mjHPkuUWUn
 JApmKMNzqcsas/2XQS85EaDQb3zOdXmajkPXyQIOl5VPF2pRRArdepSlqMHYM1wkl7EdTgxebRI
 uydrIsmwbBoLIStyxIGa5NnBpP08ReqGPX+DdKE1ZN70U7zeSgmZhJi3PTRbw8I=
X-Google-Smtp-Source: AGHT+IEGMMxY0fCQBCWRtAAjOH1Q+SiYDZbg+lIdPzUwtByuSCGd3ISz3YYKt9ptYwgweZ29o9o05Q==
X-Received: by 2002:a05:6402:1e90:b0:601:ad95:ca6d with SMTP id
 4fb4d7f45d1cf-605b7735753mr11046273a12.8.1748948534576; 
 Tue, 03 Jun 2025 04:02:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2b301sm7537548a12.15.2025.06.03.04.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20A075F9EC;
 Tue, 03 Jun 2025 12:02:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 13/17] include/exec: fix assert in size_memop
Date: Tue,  3 Jun 2025 12:02:00 +0100
Message-ID: <20250603110204.838117-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We can handle larger sized memops now, expand the range of the assert.

Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - instead of 128 use 1 << MO_SIZE for future proofing
v3
  - fix comment, 1 << MO_SIZE goes to 1024
v4
  - assert is_power_of_2()
---
 include/exec/memop.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 407a47d82c..cf7da3362e 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
 static inline MemOp size_memop(unsigned size)
 {
 #ifdef CONFIG_DEBUG_TCG
-    /* Power of 2 up to 8.  */
-    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+    /* Power of 2 up to 1024 */
+    assert(is_power_of_2(size) && size >= 1 && size <= (1 << MO_SIZE));
 #endif
     return (MemOp)ctz32(size);
 }
-- 
2.47.2


