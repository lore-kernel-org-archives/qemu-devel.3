Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2CDC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewi-0002tG-Me; Mon, 24 Mar 2025 06:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewI-0002iP-RM
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewE-0006yQ-7f
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:50 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so6578542a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811704; x=1743416504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0frMJFHURFqzSvkfeW8iN6QG7CZAG19LBjdMEoqvJI=;
 b=GPFox9bzWoeTiJS4c8LoAW3c2q685oWYl1sYHDZ+FzQvLXv4KXuNQ/DX/W0xY2ARPt
 LtNfpHIXXnapMn+UU+CBwSrexYPHP2R9E8pV8sigHhpujaNIeL1EUeccH2/8PUYPfXRN
 KSt8cbCLPwzN+E5q+FsnwXQ9PIMOOJizyGGLzDVqb+QWMbsJTU5SChNSpWF8MnPw/rEO
 N9HnNEv3nA8VNMV5qsh8ooiExCclhnGnzCRPJoKRLkAXcY0C3ghUxMgUB1zvc42VeCkI
 pqWjEz8taAxbrgabR90NW6VBA2zlRNKJS+v8ivzJQtDVboC7rKMYNGQC1F6zU6kzTTBn
 EK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811704; x=1743416504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0frMJFHURFqzSvkfeW8iN6QG7CZAG19LBjdMEoqvJI=;
 b=I1JfvP2f+hL0nNll/u/onh0VEkwUeL+DMSVBYpjHr0FhBzGJDU4YYnKmvhgzqqG4fH
 2Gvod71iqSK8wbEcz6sRoFZeNaBtQgiiTb19v7PzUzUMWDkdXLRpi/v9wh7+poG8anbR
 yBrUP49L/r9oFpIu/16djUIlKT6umeJgBLg2eGY56mvtucVizyROrmfmk0u0idBCdWU7
 JHEh/WH9qsIznLf5UkHQ9Hgr+C3m2DZXAKpof7AVNv/WGwo9WIZV/pM/8COEOV/Quxm8
 0s6Bx++xLtSGwYPVUNfsdK0eGDSxjK0otoKL0L5qztPjTvnfnVFqj0biQJSqwoW5mWZy
 3diA==
X-Gm-Message-State: AOJu0YwrCQ+zSGapGnU5a0gNOhgifvf2KERwKl9UDnEz96ouB9aR1en2
 8QYLltYCClQjPJVCKr3uQpLw1Ggt4yjuMYHNt4nphLX3UNAR2nC/kjcd8aNuHIw=
X-Gm-Gg: ASbGncvFiNNc/qUpbg9T+Az3V0mDgC3IvMASjttIpgsKhy0+SS1vQft9wwrk7b/ICll
 5MblVSp8G/3CWpASzdDBk/mToaAPRqKtvIeFaiimKc+yewk1rCs4oMNJ+/JFAGn9jhB5T2cLzIi
 UcTebjb4TwaI1LSUezQhdTqH/0iZC4cVWMiycqvVuLQ/CErlmy/5SHOT/+l0+RggzAIZ7nchKi7
 iix86dJTF9E1n1/NndbFeuDTlDDWUfR+AlruLZCoNk5SaejGhJTDFlMcH6SPDU7VByNBl0NB5fl
 IUylVsxNE4rCVh1jTs53vMPm9MTwYGYMeCJtwrsXunhf6G0=
X-Google-Smtp-Source: AGHT+IHwSd6NzIfqKhQkug04WTcI9nAnPTul+n/Wo/urhoWHkFNugeCcE4XD5W1Ewaqi1uZ+cJjuwg==
X-Received: by 2002:a05:6402:27cd:b0:5e6:6407:3b23 with SMTP id
 4fb4d7f45d1cf-5ebcd4ef41emr9266584a12.21.1742811704252; 
 Mon, 24 Mar 2025 03:21:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccfae189sm5784268a12.37.2025.03.24.03.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ACFDA5F90B;
 Mon, 24 Mar 2025 10:21:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 01/11] include/exec: fix assert in size_memop
Date: Mon, 24 Mar 2025 10:21:32 +0000
Message-Id: <20250324102142.67022-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

---
v2
  - instead of 128 use 1 << MO_SIZE for future proofing
---
 include/exec/memop.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 407a47d82c..6afe50a7d0 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
 static inline MemOp size_memop(unsigned size)
 {
 #ifdef CONFIG_DEBUG_TCG
-    /* Power of 2 up to 8.  */
-    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+    /* Power of 2 up to 128.  */
+    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << MO_SIZE));
 #endif
     return (MemOp)ctz32(size);
 }
-- 
2.39.5


