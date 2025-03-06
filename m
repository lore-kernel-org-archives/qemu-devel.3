Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DF9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTx-0002D0-6o; Thu, 06 Mar 2025 10:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTD-0000FI-QC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:15 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTC-0006Mb-8X
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso5186625e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276148; x=1741880948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d6J+LsLjSWQlqsq7ooik8ElyF+HqmtBS26XCNLHBy/I=;
 b=UisdJWTc45CYTx52tq33X5ZMEvuDDFISV2ZNy8F6sJQ+GbkhX5Cy9cLJXOcCo4jokU
 pIIasSG7ViKHEXHQ2g70PtoxhXBBEY+3EXhfsFIhM6V2FlOzLDmqtkTSo+QpjoDHKOZw
 8LLgY7ds04U3aPqJf2BUc+KfyIVWheVt2IS67YlFN1xz+Lo4BPsvxpfbohJj5t9uIEzZ
 I17K5yoFpsBd6JM9Zprrr6Hv5FOSqWeOZwSMdO7ePq9tJtGmz5dZ47J149286EJZa3J7
 km4tB5PNrcYPFicEl94/KDj+6aaAZONA9UIzI8cm3QV/ubxfkUdbk94PdksuWd4Pv/h+
 fJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276148; x=1741880948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6J+LsLjSWQlqsq7ooik8ElyF+HqmtBS26XCNLHBy/I=;
 b=pqPKCKQwuqAyXYR4Qgsh2nOSuf/qCtV0U3JqrLBFlREg+KYX3mNVK+lx35lR976rl7
 ezraFHpBo4RJsY3kcVzF4CDUlMw0mjaADBRnNqB5HAHF05Ogsn1BsSOH0IQKJegk6qpm
 VRXQeFIvH5FuIWc6XYD5UkBZuBvDH64vqhVT8GHPl4q+lW154gqkBIyDmttlpewVapmU
 u/j0LRDZdACMHpkWci0w7ZGp5JfPMTnOIhBlWmGXzlWoNa/dgJiHVWHPAy/01ulFd6GJ
 aXI/oaJDbQsvmxM7zeHVpTDn7tvMw6Zz/TO+nyZCRepA1zjVYVsBKVVMJY1CcxKfq92r
 IwmA==
X-Gm-Message-State: AOJu0YzAqtNMD+aGPygnhqud+xbP+QUqwIbW1G9jUjEd2suYE11Jui0m
 8WpkEj9fcOtNaoq2N6Ui/pI0Lyr+h4DU75sIDofB0B/XtMiZkQ6w+GoiDddaEWmqTFhzM+R7Z+a
 O/RE=
X-Gm-Gg: ASbGnctMn2bqhkmzuXdMGblBRP0uL1U/+UvJLSxKIHuYo/EsrSiida1xaI2m/7v2pUn
 3NNTWhiu1axnqvdDsOY7Nwt/UylHx3FmTSEAQygWHTFXzklWikj0NfxHGMZP6edu2hxiuninOHc
 9RDzVO253LhHyNY6ZRZye9J2AnQEt9M4o49VFgX3+jFe5aaGLfF3ScSlg+0f7TlvCkZqtPWw6JU
 h9muGksU1PO0HPVm3OxpzaDz4DcacsWK63fazyCnlXw2BbecCruAgTzsIJgZVQjslFvhDKtUhgm
 jUoZk1bKxBo1cOYBC/eFc4XhfnwBu7oZWGAhZC2PvF2YrBW2XIQ6LDyfFty+UOAmQXLHE6r8cXL
 2c00kSQ7wx5y2xKNYJDw=
X-Google-Smtp-Source: AGHT+IHfVhKDA2lTidrgMbFCl5h9q6UnpHASeVb0hhW1+/aJpfm0jJEVWE+O1wSXS+4U6uyAbJmNPw==
X-Received: by 2002:a05:600c:45c6:b0:439:98ef:5d6 with SMTP id
 5b1f17b1804b1-43bd2aed717mr51793495e9.22.1741276148454; 
 Thu, 06 Mar 2025 07:49:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd41c7cc7sm56999535e9.0.2025.03.06.07.49.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/54] cpus: Fix style in cpu-target.c
Date: Thu,  6 Mar 2025 16:47:02 +0100
Message-ID: <20250306154737.70886-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Fix style on code we are going to modify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-16-philmd@linaro.org>
---
 cpu-target.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 83688f1d508..b925b9391e8 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -48,12 +48,15 @@ static int cpu_common_post_load(void *opaque, int version_id)
 {
     CPUState *cpu = opaque;
 
-    /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-       version_id is increased. */
+    /*
+     * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+     * version_id is increased.
+     */
     cpu->interrupt_request &= ~0x01;
     tlb_flush(cpu);
 
-    /* loadvm has just updated the content of RAM, bypassing the
+    /*
+     * loadvm has just updated the content of RAM, bypassing the
      * usual mechanisms that ensure we flush TBs for writes to
      * memory we've translated code from. So we must flush all TBs,
      * which will now be stale.
-- 
2.47.1


