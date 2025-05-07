Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D85C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClfb-0007So-1q; Wed, 07 May 2025 16:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfR-0007OS-Vz
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:02 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfL-00037p-QN
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:01 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c769da02b0so314375fac.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650814; x=1747255614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub+oD40WAPydF2GdZl0ptFBPrvXnH1JqhWmWJzcddoI=;
 b=e8/mSVF9+A6wqmpQ+f4UaBfwu1fLgh2K7kfLF9puEq5aA6uU8W+v6WvDqqCxVIQU9E
 2eKt4ORcMPUd57yI7+W+FSAijFG4LvGTvb8Ee79bKZW86wynpyGjKBvEHaRuHsxu5PRR
 9XX9daedTqAE/dd1qwZsAlBU24CaCZMqYSipUjqbp/ZiMF0CWGlueNcbde+raoVN17Bm
 CaOTax8M+n/Efk3zFw1uXcImOFBQ5hrLIqJJ27L00mgOLiB2k2RShLHjWlYk62ByaVzR
 MhXpP154uz1zQDaNdh3BId+9kgKC1pksGgftMXaiFIIzQeXESgOefpXyK/WoszDWrTGt
 0F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650814; x=1747255614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub+oD40WAPydF2GdZl0ptFBPrvXnH1JqhWmWJzcddoI=;
 b=Xb+MugU9hguzB0y4hO1ehvH4f0pubjyti9xHbwLnVDNhKS9SAh3pm8sUOzM4zypUCI
 +I1KZVLJ5nNimfNPnDiISnjj05Nx4zqLNcfglD4B6rzeCXy70E7ZLm5xpeQrXrdeAhWA
 cpyWQyGNszWWMdEVHRq9+PKr9jWGel9Fd7v/zIHVzcdy6SoBaI2dWgDvpOcGR2EJquWM
 wrLU+vY0Np0T97n8bIdaDpm+zprsqmnb3Bl+UzXhoBx1ci9/WRtcwNY3BriPx8rIhyZk
 /HEOUM3sJbVIBEm/n1NxLeAQlfHIMMR81u1HvCOFcNtmz1EuOTLqlc5dqshVN3UOa8/h
 ItLw==
X-Gm-Message-State: AOJu0YyDVqGF6qvYpLBF8kjvwY20amlPpw3k3D2WmiO0/i6kmt3lKcKp
 +F/0+htysXyCw+S9NPggTbxGYvJtSexc29S6YEEqCoRxntKnj1xN9stnCRXzmCQWWdq/oaNAeXk
 j7RE=
X-Gm-Gg: ASbGncsfGu+CgOr/SvnTBvl6fOMDkJBnrm+q72hUnYyqvWQCgBSrvAlE8MZL+w+7NZD
 fbGG/YBE7xmCEm1mhx1/VdJ9Via/TS4MOmBgHPUkqJtrRGdZACuKajoy1tpTAEYtr1V9TjjtSSf
 4l6h/nY0jyjqdOJNwiOi4RkpCeDNWWZNnTr1AWxnHtjC+SMlPuZdVMT9pKoN84dx3/nztz+Qj4A
 DskI9QCGk0l/toi9/Ge7jNMd8WBhsOrjcEHE+7f+BV1p6HnxxAgnY03Lp9ZCwHMWuBuWGbxnuR6
 c5+cRjdGdijQpySTc/mjwqHNpNtjUyXQrjGiRQf7JYyE3Dpf
X-Google-Smtp-Source: AGHT+IFc0VU0cXn+LODppNE4D0mvR3Cn71Aqv1XwI4RBdk+TxcW3ZHpqblag3/GGMH0TyqyVWq8ZLA==
X-Received: by 2002:a05:6870:7308:b0:2c1:4090:9263 with SMTP id
 586e51a60fabf-2db819c5a58mr639531fac.35.1746650814007; 
 Wed, 07 May 2025 13:46:54 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbc7d1fsm920933fac.11.2025.05.07.13.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 13:46:53 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 1/3] linux-user: Fix typo in comment
Date: Wed,  7 May 2025 20:46:24 +0000
Message-Id: <20250507204626.139507-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507204626.139507-1-gustavo.romero@linaro.org>
References: <20250507204626.139507-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x32.google.com
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

Fix the duplicate "of" preposition in a comment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f88a80c31e..002e1e668e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -645,7 +645,7 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
  *
  * However, this case is rather common with executable images,
  * so the workaround is important for even trivial tests, whereas
- * the mmap of of a file being extended is less common.
+ * the mmap of a file being extended is less common.
  */
 static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
                             int mmap_flags, int page_flags, int fd,
-- 
2.34.1


