Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E0DC02197
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdr-0008Kr-PX; Tue, 04 Feb 2025 23:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdn-0008Ie-Oo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:56 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdm-0007Fh-BO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2165cb60719so115322215ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728232; x=1739333032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sM8wEzZqivRSntSpPQLp9Bl8dcy72JUL2xbQoUbrJ+I=;
 b=CiLjHy61YTYTW8V81LwtbpBdbfMp3B28p4u1FmiGxP4UnPSD7ACv6/7vkaha802R1m
 1g+NrAEoGPIteQ/02j90s3YwLVBp6mmMketZlpNqiF1zMJ7YLlLZU+fp2NKW7kpxcOkS
 g6dyLZqj6WNpQkMWFHYooquIfa60ws9GV/5qSmtuvr4W4oIjqZGyb7tIDQj6izplI2lY
 TOIznOMoCxnMuzLlNvQrRAFQjj98VHJ90k/JAC/3AAvhw16xHD8q4ivWlhbgn4VsAO1X
 AiST8eGTieqU1n8TVoKJaWWUdKidT1rsD/0ZSf4oGhNJ6ga5cx0DDxu12wZppWCZ+dvd
 t/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728232; x=1739333032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM8wEzZqivRSntSpPQLp9Bl8dcy72JUL2xbQoUbrJ+I=;
 b=e+HCJ1dbi0/biYq+nfO6j9ld4v1iulFyFU9l6jsopwgexHvMkn05CFRb2h4sD1kocO
 sXgBnatfJl1TMJ3Ug2jFqqE+hTBFjDJDYEG0cUqGhb9mO4aLZqIhGs7KsnGrhuZ6Jqce
 /QJuWpwUBaxIksXoIuCxUA2YfqpjiXC4jgK0RNAyHswYZ9QNnL0Vlr0L/ei75WFgX+OO
 fWCxUiSBAC2GN9wICwVOiNAiBjoByEYwU0rnXaqFpCKOtZGM6Nf2M+m0V21yv15FBWIh
 SUUp1j1Hk+jREmjmoc8DuhObM2PzughT8cWQ34O+wmSRPqi/Pfh2xjrFRdINl/8Y+TG6
 XPmQ==
X-Gm-Message-State: AOJu0YxTWR+/XGAZEVlqrcGDvtgC8qcxiw9cV/b7a3gbMY+35V90Gkcs
 e2+gcxWh24Ph08oc43BY+NlSxz3ZQs/6YbWamVCXkZvLNG39o8/zS5pQWhJBorOkoZ5LqF3OYRE
 7
X-Gm-Gg: ASbGnct0bpevA819ty0k2gsYDm5GVlsMqtxXpkoCF3IMlK6FDB7AXvXVkn0plTI2sSA
 6hOsrb7VwPam6pF6DLZXmKE+EWmaTZdLzYgnD1/bYly2RtiapZxoeF6huxnBiQWT1M5+YjlMSaW
 m8FKkNi6gzKQnKnDVu9xKvVRq/Gi0Qmq3RnJD5Eas4L89MW8/rj8AWSOKdcq1vBNRD3CtvUTDDs
 hS4tfMq/lf2HiPiMxD5HvQKJAPmt1G1fL4UkQZEBeUD87b7nLf5DxDGdaXcp/a/MiWeJrSYiqro
 Z16YDQcZBWTmpY74TZTYbPWDtDvPs8wSOeFJ1l1SIQ3sRMY=
X-Google-Smtp-Source: AGHT+IG75Ck87qxpgZ23DMSG5XfD4jAPTo7LWadRmbN9v0hjB7yMCfQlDzcsmzivR3GpE4TKpXhP8w==
X-Received: by 2002:a17:902:cf12:b0:215:9894:5679 with SMTP id
 d9443c01a7336-21f17d12180mr27422825ad.0.1738728232512; 
 Tue, 04 Feb 2025 20:03:52 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/11] include/exec: Change vaddr to uintptr_t
Date: Tue,  4 Feb 2025 20:03:40 -0800
Message-ID: <20250205040341.2056361-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Since we no longer support 64-bit guests on 32-bit hosts,
we can use a 32-bit type on a 32-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/vaddr.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
index b9844afc77..28bec632fb 100644
--- a/include/exec/vaddr.h
+++ b/include/exec/vaddr.h
@@ -6,13 +6,15 @@
 /**
  * vaddr:
  * Type wide enough to contain any #target_ulong virtual address.
+ * We do not support 64-bit guest on 32-host and detect at configure time.
+ * Therefore, a host pointer width will always fit a guest pointer.
  */
-typedef uint64_t vaddr;
-#define VADDR_PRId PRId64
-#define VADDR_PRIu PRIu64
-#define VADDR_PRIo PRIo64
-#define VADDR_PRIx PRIx64
-#define VADDR_PRIX PRIX64
-#define VADDR_MAX UINT64_MAX
+typedef uintptr_t vaddr;
+#define VADDR_PRId PRIdPTR
+#define VADDR_PRIu PRIuPTR
+#define VADDR_PRIo PRIoPTR
+#define VADDR_PRIx PRIxPTR
+#define VADDR_PRIX PRIXPTR
+#define VADDR_MAX UINTPTR_MAX
 
 #endif
-- 
2.43.0


