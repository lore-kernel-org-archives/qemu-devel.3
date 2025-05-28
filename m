Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46177C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwv-0000II-28; Wed, 28 May 2025 04:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvj-0007w6-IC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvh-0005FR-VS
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so39615345e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420068; x=1749024868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpLbuX6w3ui4OqkcJtXbZ2uIaATf5Ym/Qv+poSMA20U=;
 b=FDl5QbRJANd50sGwPMyzSQYkQDA4d3oiWA+jNSzXyt3ZXl9vfG4/BpbPi0oqdfOeMv
 SnV7rWG8cf2GeobDwqb/NbCk4/LmxcIltXkmvvBB7gIUabwZLR/3vvkt1Ve6Xo3VZ34n
 xTn2CAQoO40BRmp6e+6WftO5CtUn433+Vcnc4QF7rsED0xzk9y0HAYCRss2iBjB+12/X
 e6BEksHrAyXQjSNttg2A8YnF+8WYOhR+qCjDf/Bxpij5exVMgiSRz5X6pV8Lz62equi5
 GmXFKMvqAUjh6qK4HSK5d78apnHGyPgDKMludiu8haa43BjnJkVgqYyIrfj0Gn+nIKDO
 dErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420068; x=1749024868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpLbuX6w3ui4OqkcJtXbZ2uIaATf5Ym/Qv+poSMA20U=;
 b=pKb7CZ/3oNS7NM7t0Lkhrftxbn3YCRviSH2K+Tz7A0dEfIS+/8yjOIFS4EL7K0g7Ze
 LTnGI3XxrWr1v54UHllMeovgTauXgqJNCRlzWMNtE/0i84/0z2VqLBfXRlKnqXODKo/7
 1FboAKVcX27xm8GNVsw/mJ3oxfEnjjH2TIxWMGZNvKnb3glLXJ2tnLQEB+Up64l5lcnY
 SOsA5Sfpt4ypbPtdvO7j5q0jbiz7jM6Pv08AO/uwIngbnq57ilObeYh/7aPxCGcrrK+v
 /fQ1shg9Uwb3SOf5KkL9mweZVEgZm0VO7TrTsW25SnOacMxbtWRYHF0Mmf4y/7CdPN9e
 tppw==
X-Gm-Message-State: AOJu0YwQIMcvzRO76ZCDBHekFCFflWGWtlEmSV5+4wE8cYrFcU29By4f
 rW6qyXSDtSiSig15RyMywMvQXc0RMrSgE74cIYcB69ExzzRMbvNHas1L/roYwHYu8pL347nhmpE
 s0hgCjq5U0Q==
X-Gm-Gg: ASbGncu2YPZ3Fd7v/xnCuEYGl1GQOnU7hy3e4nr9SrQQq16HPFxDhFDrb8HNMRYodI9
 3YE5qflmqbuI+LZPB2AUPRTXY+gddNTcSE9FUvNepXK8ldkpyyVWbA2WPvcCKQGsEIxxgW6cJ1I
 2dyH6lYWxM621dZ3lsjYk4Rldb1dL9p4MMn4Nj7yF9bxhuVGSP7drKEVCzdrsWRY4qexeoFdmjN
 sItFaOWgVALgaWOhmpOdi9fDI3LHJcJihXFYYHXJqRtHQ6HUAlaytE9S7RgLabauAoaFXRpyK1i
 YhAdMj56WrwTVTo8kRYeul0AgKMAkzre2A3vTZcDCAO6U+GwYsDrAsH/vbEgwNxgptU=
X-Google-Smtp-Source: AGHT+IF7FAN6iJHUetgK8qAjC4cGoCe7dEZfTyttsPJvzYDJOKHvbgUYes7BdxzKGvNkasjDqnzZsg==
X-Received: by 2002:a05:600c:c0c1:b0:450:c9e3:995c with SMTP id
 5b1f17b1804b1-450c9e39ce5mr5302325e9.12.1748420068503; 
 Wed, 28 May 2025 01:14:28 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 11/28] target/microblaze: Use TARGET_LONG_BITS == 32 for system
 mode
Date: Wed, 28 May 2025 09:13:53 +0100
Message-ID: <20250528081410.157251-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that the extended address instructions are handled separately
from virtual addresses, we can narrow the emulation to 32-bit.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/microblaze-softmmu.mak   | 4 +---
 configs/targets/microblazeel-softmmu.mak | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index 23457d0ae6..bab7b498c2 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -3,6 +3,4 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index c82c509623..8aee7ebc5c 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -2,6 +2,4 @@ TARGET_ARCH=microblaze
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
-- 
2.43.0


