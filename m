Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC451C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xwE-0001Gk-Ae; Wed, 16 Apr 2025 04:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvm-00010V-Aj; Wed, 16 Apr 2025 04:15:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvk-0005d1-L6; Wed, 16 Apr 2025 04:15:37 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso8562126b3a.2; 
 Wed, 16 Apr 2025 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791334; x=1745396134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFdycMSzFipz9Zxr0ZH3h/HarCGC0DbvNHYJF0RN1dM=;
 b=SzMDKvvhj/1mdbuTHhao3NfMegrLrbY06gGATowELGB16UiyJDdBV76Da/BM5kOGkr
 qZaPp4ZwVuYVGFHXV6T4+8cCcXqsNDU9Ynb3zRWyyljg6GTxozm+lxXBAuCR4hh0G3Hr
 HRfUTsb/zTmMHUm5iKeePCPbnWoZ/JOD9TAAxDo/4+CU0JqQx7L2JtA95pVJZQfNYJdU
 +0k9kWz30fkeJR/WxnGhYhdwpReXDf15+0BIwAcZX3H44+IzbY7urQaLttBL6mUHtrS1
 ufUgRe1a9XOG3L/k25BkFsyqk/kSKfjKxY9qV3dKxqguXPAqAG+5SyhiSz1nq+jdVJNo
 DRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791334; x=1745396134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFdycMSzFipz9Zxr0ZH3h/HarCGC0DbvNHYJF0RN1dM=;
 b=kO3MGWKzBbqzgvEYJS/x4h9g/53hHmLQlXt4xqZnkESe/TDtNjbljYlO/YAxcYEA8l
 cBRpA9ku/p712fEMEEYg2jJjYPuSqJKUoD2xYHURQ6p1Y1M99RkUia4VDFciGYtpc8Gd
 gOcB10l38YJAruQk0vFTJrCdeiAMlNt9m4Wm0YBFEd1e/sX2lPavsQNug3+y6MC6XZGz
 HkSfnePvl5DXcgJCCcdQCzUf6JhXcdzlzgKW7MCXPtOROpykl2okIxFFOT7jvs8yZn33
 ZVD9Hg2bHmcBPPgCEm3RyjsrAUncSxGYka3rbjwLEcDWmVNmKykh/J7Vf7yzDlMF5/1+
 gCaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+RIKQYqvBukigMYamg8UlAYpT5fdYyQ9WVEqh0Wxq6rp8667XdfSWgMJM+6ArA8WSL5XpRpGxfZJfHQ==@nongnu.org,
 AJvYcCUYNzzT7ACanX56CdMY4GZStOQIZofSbpogT5ZmH/8UX0bY1O+K6PP98iikdw7dUp5rx4iBhFYqtQ==@nongnu.org,
 AJvYcCVrgv9H/Yb/SFRh/YKd1sisMJS0OzJLzaT5WPSmvy4A9oys2NTVdM8BiL7WykoHz0ptFI8gPpT7PV4=@nongnu.org,
 AJvYcCXW189ahhLfPJL+lmXfHVOUpl3w78xdfQMSMWB9KCuvhi2iE6kdCQ/+PKiey5+cgk3bUZJQeG46YwRTEg==@nongnu.org
X-Gm-Message-State: AOJu0YyN0IK0uka7hTVtS5NwJZ98AsRuOvuZwczcJCebWsvFeigZm5ld
 k4qhe7Y84Kz59vRxA4Bk2QWG23xQxDSWWkKcnwJC7I0TJ9EkwifUEkgLxrYF
X-Gm-Gg: ASbGncuR0+/vepwXkY3iWP6m8yzEiymLYVBE+74MHxN6Qtf0YFs/7CsvOnpI5lgZWqd
 BC8jA+Uc0oE2UXoQac78jWgPdUmKtxLq63T0uUMV8I7ZkbHBZHchicybVbjAvclskswaoFZ8kXJ
 oduIViX4eTp+BFdxlwMLkScx0osq1Z6I5SzmwJIH6lxv0kPgL0W9g+qxZ1LXPrZ7pmOOMT1nO3q
 fmlEeF7+UKLgiNdEdaWFV/1ErS+6lZOM7GJ4V0+M6dwPKARQSO07elT62Io6kF3xKrHlCvtEXJK
 Hwi/hi7Or392Vmq4zZCkMCEpH/2TN7OzhNYpbXiYyHQ/YjAsSB+MMWfbC2E5s/uVOnwZ
X-Google-Smtp-Source: AGHT+IFJGr+vW9xLmlInModOrpRdhxEYHBP65U5/zipWn3lToz5KEXtzcMWCVlmEzka/wjvIBdQPuw==
X-Received: by 2002:a05:6a00:896:b0:736:5664:53f3 with SMTP id
 d2e1a72fcca58-73c267d4f79mr1287060b3a.15.1744791333882; 
 Wed, 16 Apr 2025 01:15:33 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:33 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 04/19] target/arm/helper.c: Fix type conflict of GLib function
 pointers
Date: Wed, 16 Apr 2025 17:14:09 +0900
Message-Id: <ea53758b9300450908497f746af1e2b43d8f941b.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_list_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd..05793a6c97 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -220,7 +220,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
+static gint cpreg_key_compare(gconstpointer a, gconstpointer b, void *d)
 {
     uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
     uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
@@ -244,7 +244,7 @@ void init_cpreg_list(ARMCPU *cpu)
     int arraylen;
 
     keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort(keys, cpreg_key_compare);
+    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
 
     cpu->cpreg_array_len = 0;
 
-- 
2.25.1


