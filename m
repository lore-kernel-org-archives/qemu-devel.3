Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB788C3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVW-0000tD-RG; Fri, 05 Jul 2024 04:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV9-000071-CG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:08 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV0-0003EF-4n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58be2b8b6b2so1738750a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168856; x=1720773656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+f3EYij6+onpkKsDKRY7Afx2un37tsZeTZMpH2ViH0=;
 b=H1Dbg14whFX++Vn4pAh2z11fejjgvvFKl2uJZ2JBLe5Pnw0gkE3p/k7VxE6dK0pj//
 bIA22s+1dAgFxTo34Jbb6tpvLjibmFbLRkIhNM0j5FuR1RLHYCsz3LApSK3w4i4qWc3x
 r3FzO1zWz6Y/AMSYuyIJSn4nilU2eUkUcw2Cbjg9xQCWzgUWv3sUu65d+KPL/sMuFEaa
 VM57haFcGvTdR04+ZzzCseYjsmWftnO8CyD11jNKWL5cY9+q1lzEJtvlWgSii4p9PZWl
 JxvrsVoIKcjOu9BaAu6H3wkOlnWBrfIKF7nxArwoNjAqbc1WK7pj9E8yObtLcR+48RQy
 +4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168856; x=1720773656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+f3EYij6+onpkKsDKRY7Afx2un37tsZeTZMpH2ViH0=;
 b=HeEajxzhVJSQuOVEedJNiHYNtgoxcqjrviCl3xKf6JSuhpDWFRfxiSKBBSTgyUcrr5
 qTLQv5xa099b7JTsmxZ9hSFIuJJeh3vxrhrrpBTesUSPubWNYJ1wPZEuW7iFlLjLsZK9
 f9IpiqPiJ2GfPCyjZixxqxkHuGUd9jxnnV4G4lYUxBjpIovhbEWLLlKn2oretJxZhHuI
 5bJ9e3qhIFAKV5vgmPGimdeKJfSVm9YDpYZRGjDRfYIm5efa+V/e0afuPDYihw9obgVb
 4C3fIGR7Np+UfTNUoZROB+Yzbrtl/Hn9kG41D91oKdcQgazW2fQ5FaBb78jHnPpM1xMi
 JtEg==
X-Gm-Message-State: AOJu0YyupQaOBo2uIABUvCtEI1UKtYV715ufTno1hqFB7px4x16z5J+4
 JKbQa76tIVXOPpjuBzu0r6WuNmAO5sfEsGT7ZyuvuS6+yzko8LEvF/axunvo3Ec=
X-Google-Smtp-Source: AGHT+IFFjNmFaugNxWOwuSCArBG9LB7ZbMUXuEfL91kuc3JNc8SuixThQ4T42u1OgfHwk5UBmJO7sQ==
X-Received: by 2002:a05:6402:13c8:b0:57a:3424:b36e with SMTP id
 4fb4d7f45d1cf-58e596549admr2550505a12.13.1720168856187; 
 Fri, 05 Jul 2024 01:40:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ffe0f88d0sm267919a12.85.2024.07.05.01.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A43DA620F2;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 10/40] tests/tcg/aarch64: Fix irg operand type
Date: Fri,  5 Jul 2024 09:40:17 +0100
Message-Id: <20240705084047.857176-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-tcg-v2-4-1690a813348e@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-6-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/mte-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617ad..146cad4a04 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);
-- 
2.39.2


