Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC146C36001
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy5B-0001lN-Tb; Wed, 19 Mar 2025 14:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4M-0000GS-57
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4E-0006OH-7x
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso47006305e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408580; x=1743013380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyVkWcStElmcOAyhJPPo6WY44XP+lPqsn8y0KwtraUw=;
 b=tQarzvsl1Y5wvwEIx6hVN/k1w1rpQyn0tSaIEaGVNFW3j4S3dcgeV0K9YNtoh4UtPU
 6I+J2V6HVteGuk7o742dLhIz1gcEtsDzk8LigyHvV4jG9DlOyOIs9pZmbA8DN/DPvdod
 fzl0lRHcp253KOcwdE99r8PQ65bCmXHeaPnWgGsOvW0LiMH7p7+FAaW6bFQMZQBvL9li
 CxnS8jODfOGHFsuZ5FiQS/Iys0x0XmmsWsMt3qWjC7MmN0AbIh0303eOa7ps/HgdSvc8
 9ph4CE8ZgX5P8Ds2KHJn938Q46VISHC3LlU74OSllrV8IyPp1owhkwItnILMLHKMF1sb
 qW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408580; x=1743013380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyVkWcStElmcOAyhJPPo6WY44XP+lPqsn8y0KwtraUw=;
 b=kSZtjqsQjnuToZUUYQSyjAcZ+pMubmCEGjJtQO+sx0dM/d6jvGIUJ9xWHHxn6w1lyp
 IblA6/sMG8H56F6QY6YAvRH85Uwno7uljZHHjjlhiMs/IOsY6gIQcCKWer6Hlzx5CxGT
 WnOQYL9bzmQ7njx8pDwPwZq6bX7PhmVKxbPyzv75dmdqyQSv52fvnJB0tGW2ssdu2Mfw
 4+280xzgl7NJsYoM7l0hAMEu+21dQhYXpXBv36PKycEEbMwD+I99A7ZYmuqCOAUOJqlt
 5VyUXk2VOrCbRUaCZKySrJATouDiM/xG3uyUwYGHGH8PE6LJuUf8hmKnNO8Xq1wuYivp
 TUWA==
X-Gm-Message-State: AOJu0YzXcq7+U+kitZ3aesSHoZWVZzRncwtU4+/h7SWuWxRswtc1ivin
 doDn9T7fCGHZ2nEyhw3IMvJeuTKzA357Xxs5h77CQSu5Vbu5nqJ9iMTOKyiw9Gk=
X-Gm-Gg: ASbGncvIPc8ygUpJh9Mg7+uI+1JtXa8Q6qP1Pu5TsymANKwRu9JTPPYsEndGtf0iUrL
 GKvwQUQYu0UQF9dKLTccgi0hiJOB2lju6LWiN0qXYSPaMB3cWqhT+bMsOuZrL661xmxZsUvg6nC
 WnId5ecRG1Z7M5Eob2rnaazIBTdZhO7/qK9zCxiWLcLX7fSKM/wR7vadDuOBWOVAJW+YIRXSPvQ
 LucdMOh+o+kM6ew5msxfha0lZJX5fDHxPyuL35Dr7qHrhdOZbT6aCho92y5w1znQKZ6Y6E917eL
 88pOSnn2vD/7acVaVQj2XQ0acY71S/M6px7mNoBAERN0LVM=
X-Google-Smtp-Source: AGHT+IEz1AsKvESOwPI5fkoezWwZ16cP+wQHCxg1sqYwM6oChmVmAn76vphAWgrCuFq1C7S+WYsMHg==
X-Received: by 2002:a05:600c:4e49:b0:43c:ebc4:36a5 with SMTP id
 5b1f17b1804b1-43d4953b186mr1867405e9.7.1742408580365; 
 Wed, 19 Mar 2025 11:23:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d48f60cc5sm3790175e9.36.2025.03.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C860603EA;
 Wed, 19 Mar 2025 18:22:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 09/10] include/exec: fix assert in size_memop
Date: Wed, 19 Mar 2025 18:22:54 +0000
Message-Id: <20250319182255.3096731-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

We can handle larger sized memops now, expand the range of the assert.

Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/memop.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 407a47d82c..faed3ff902 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
 static inline MemOp size_memop(unsigned size)
 {
 #ifdef CONFIG_DEBUG_TCG
-    /* Power of 2 up to 8.  */
-    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+    /* Power of 2 up to 128.  */
+    assert((size & (size - 1)) == 0 && size >= 1 && size <= 128);
 #endif
     return (MemOp)ctz32(size);
 }
-- 
2.39.5


