Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD3FCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUyv-0001Zf-RX; Fri, 05 Sep 2025 07:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyr-0001X6-9V
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyd-0003YJ-Q0
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso8746335e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073090; x=1757677890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBFgDZ+KFYIfRuUAnB7MMFYJ1NFGAOxLls8M4S/0WOc=;
 b=teqy8vXf1EkoNnL28HdyxRDkoWntJ3X22m8xAq+f2+EKObiSMQLUNuzXrzynVs3zZr
 th0zZduaGaJyUSuUpr/x8FD3SbwzmEaTAxNvFxSOf/KXdMcnuj9yMo80x3rdGf2z5geN
 HXM0JRdxOsbthQJBBeHICJX/MkbAqAdaOfOWuJSeKTRkExH6STIw1NAD6DpL2gpQ9ETV
 11BLTl8nIQ2seDMDvSRWr2mwOSLGctvw7Oj6p5TVVA2plz1DiMWXDIiw+P4mNmbUbJDI
 ZpfFp85ZLw59h9yf8VFgY6Krl5waSjEeuwMb1tq5GISuNMhdYL6EO0md38Nn34tF34La
 9pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073090; x=1757677890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBFgDZ+KFYIfRuUAnB7MMFYJ1NFGAOxLls8M4S/0WOc=;
 b=MB6XpmPudaStThWO7ipG2kPJlSZB84VsFnzN5CmiX+NK0jaBvfnm7netHrB1BxFPKX
 KWjr7eHDk1WvFZyRVIe/HIr4a27oZokRiNWHt6dNV1mfUI+sbSWPicvUk2T9NFoLJ1qi
 ehcLDjHtJ4ufHJPhHh6dpKi8U4Dpx4NZezYpWGMCl9k9uTYUoOm7PvOZtb12mTWqUwdI
 aY7WiQ7PA+pT8WHw5tubVqfVN35daA0hl26Q26wDO9jmPt4ay0RwXQciTnrc0jL/ApQy
 eOkq7rE45nnSUVlcrjUHA6n9XCoIJt9ViR7Ms6NJAzPoqlfa41ysJg5q3QJBs/m/T+R+
 63Sg==
X-Gm-Message-State: AOJu0YwQD39S73YvMU9l90Z5+qEh82ECFfboU78xwwPAAS8d+Kk0ZpPe
 WRYrHFGY3TBxzo8CqFqjKvWMfvcJgU5zD55qIpHzDI2AGxkJlTVuOjmJ2fm1wDIt9fGSzBLIBXn
 x5iXQ0Ho=
X-Gm-Gg: ASbGnctnNi5EBPKAuqE2zlLoM39qYftfki0gKWWaA8tKdPrp+IkHsIZqIKmsfjZpeSL
 coDmbu9098DKxtcwUwHyX27GdEOXrZKEa6ly6GpFsHSkLsw6SOpgTv/MgktO0yuE0/k4MHqhyTd
 RC8tfNIOh8j+1pHYXgGqMvFHeSzjUWIQq6e0AqEGOW5g/0+DWERoJvr08ZYUqrr+js+0cnHz4p0
 29QE2BPXG/WA29Kx2y4Agiu6onyeN5AaPDbXIlA//+tjtiL5vUgQqeKcpJDw+yqM/hG1OWyagyb
 JsA2uqAb6NvwI17/Fu0OtaY27WMmVsE+s6s6LUxTLoNVbTKgH7im2Hum7Dc5qkwLKJTySCk1D2A
 cq8ZghVZc3fgHJHhmMSsu1unbyTQhZOl2yyMKITbqEGdRhHoYyhhiac4M
X-Google-Smtp-Source: AGHT+IFIkiQeKl4Z5CZeAy1gvzjXpMMW5mlt/KfS0LwjJfqmMiFNs95iYEM4bUyBPj2lSX9/BtLfEg==
X-Received: by 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id
 5b1f17b1804b1-45b8559bd2fmr186286995e9.35.1757073090388; 
 Fri, 05 Sep 2025 04:51:30 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 1/7] target/sparc: Allow TRANS macro with no extra arguments
Date: Fri,  5 Sep 2025 13:51:22 +0200
Message-ID: <20250905115128.376295-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Use ## to drop the preceding comma if __VA_ARGS__ is empty.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..336583beab 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2487,7 +2487,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 
 #define TRANS(NAME, AVAIL, FUNC, ...) \
     static bool trans_##NAME(DisasContext *dc, arg_##NAME *a) \
-    { return avail_##AVAIL(dc) && FUNC(dc, __VA_ARGS__); }
+    { return avail_##AVAIL(dc) && FUNC(dc, ## __VA_ARGS__); }
 
 #define avail_ALL(C)      true
 #ifdef TARGET_SPARC64
-- 
2.43.0


