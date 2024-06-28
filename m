Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CD8C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB56-0002lI-Pa; Fri, 28 Jun 2024 08:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB55-0002k7-6p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:59 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB51-0007iI-D5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:58 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a729d9d7086so302960166b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719579114; x=1720183914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7j8q068F+/YM+zRjDrDncqLYLrDba9m1UpS3/LlFks=;
 b=NAzBslSEdyIdKgahTOdpSBSsNjh3TS354Dif6k43+W2aTTK8NPpkZqHNztSdfLFEsU
 rDwcXx1mV79ktZ5Bju2Z9S8mdOZoV9Az8YJSTlDyTzNTFE2JFGJoUF4GMFHnwaG5k+Dt
 4t6pcFkWwFZK5O/8Vb5i5dbnA1UC1EY8S98UmQaHyLZTXXIWBO9qcraNoPo70ReqDp9P
 FG8wU8YTGkOWb6VaRPDu62HxV9ixdwL5L54z9mDghwGVHRySs5lgjuQE+2ZenupTfWof
 XzWxpOdTjCt4b5LSW6zIv9dcAuc+vxk77ONF13S8vldhTsaGLdJSv04DcTBeDnceRsHS
 08tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719579114; x=1720183914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7j8q068F+/YM+zRjDrDncqLYLrDba9m1UpS3/LlFks=;
 b=V2J2RHBrCxDGQxs+YUSC5+fls022OUbKDxnwdB51TJJ9/a2qNnqdXh2livyCVyQWf+
 eqtjV/p02VqmED6N/p1GSBg+WZhXh9kl6X1JHlM+yfeqU+qE6yfw+r+FfLncvOsbtxbd
 /DjwVbNgiNj93NYAUpRfedemwby+WEGJUD6nnfFIeA4I0oeRzk/LlzgXBfOF0AqoKuc/
 1Vkgeb8X97dVM0f2exNyM/WjTIkoqdkF2uXAfMBvZGQ5WEoFEWwgTbpOhLfiuEO+2vZ8
 RNvwfLECpe8YVZNSnGhP9PvbzGRVWVT/VVxSTVUpurTWx1hVzlSFWde8rnQ7PxdzoCMu
 vMTQ==
X-Gm-Message-State: AOJu0YwZCKLKUq6S7i8g/rz5BRlLiH2fgwngWJjMFa/cGim/YBJNm24A
 0LY+v6oTIAf8kbJwWxD8+D3wt/CGdcsNgb1Ni5n0W3ay3C/39abrirBxNi/PhtM=
X-Google-Smtp-Source: AGHT+IFGC+e7plvD10robakGGvwWeiAffjysjrX3dtoYdRs7FI+vwojxi0N6vXogyJSbTS9mIXRY9A==
X-Received: by 2002:a17:907:2688:b0:a6f:1d4e:734f with SMTP id
 a640c23a62f3a-a72aef685e2mr147980166b.36.1719579113643; 
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18c83sm77927866b.4.2024.06.28.05.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8697C5FA3D;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 16/23] target/arm: Fix exception case in
 allocation_tag_mem_probe
Date: Fri, 28 Jun 2024 13:42:51 +0100
Message-Id: <20240628124258.832466-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

If page in 'ptr_access' is inaccessible and probe is 'true'
allocation_tag_mem_probe should not throw an exception, but currently it
does, so fix it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240628050850.536447-5-gustavo.romero@linaro.org>
---
 target/arm/tcg/mte_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 037ac6dd60..a50d576294 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -96,6 +96,9 @@ static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(probe && ra));
 
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
-- 
2.39.2


