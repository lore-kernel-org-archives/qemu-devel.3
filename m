Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A2BCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jQE-00054J-8Z; Fri, 03 Oct 2025 13:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLw-0007zj-3D
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKE-0007rn-Qi
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7811a02316bso1885202b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511520; x=1760116320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrZwksIyS9womuNg1WIqxqIe6QDKycTf62pUXwQ2GGs=;
 b=vcTv8842a+s18eIvLuu7+7QtSoy2205ysOXvq1oCvleWTtSnHrS6vcV8zYNJa+BAh1
 +TFKWM9C/AfNBravYGZv6lh2IFjKnkT/NIZXGFkgoDSCjDUJTqhPdSlmFpTz69xnBtlv
 OwP49vJ6cNZeS63onp9E0C4OShMNK2fwOWQo99m1sq4F+kbIvhCSOcNia8KosOYUfkbj
 WoADd9Yk+DzilLQBIHlBC4wysz7WSnIRpWV7CDlgMfe3vcZ4U5ZpwHdEHKutU8slHUZ1
 VNBa4V/19k0pKcNvWz3KDqWi1asjJjev363oA6ilF134NvLSrRid4yMifJatj9iHLFOn
 wKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511520; x=1760116320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrZwksIyS9womuNg1WIqxqIe6QDKycTf62pUXwQ2GGs=;
 b=UWoOhA8SJtMJQXRObVgpiJFitRhcguas1tuDveH06iZjyz3FR+sJwE+9xqu/oqpN0u
 9XrBq0bToSh5xqiVx0xrC85bdRRK2Y9AFKTOPXo3RCT9qFpvhyOclQCEuwMGBnB/m+I+
 P5eDX22ZHfYzIka8ZN5H6fehPbRZVjxv3wWOioC2bBXwRJIsBnBE6sqUoDAjVkhWntjt
 c8ZSHmPYz6ckOQTxH7vrAnxNhedkpzJHTpoynd4w93iZVKzz+Wmq0NSTlMpQScVgnWJO
 xqgaawZ2jJyaIWY2lZoImPcQ/qIJcFvCGYs3CdHimi2yCkIElJbC641NNb4yYwBK37vw
 nHeQ==
X-Gm-Message-State: AOJu0YxonIKVgZn7355xMQm251jntMP0B4Qyxsaw+qw9Fp+Bc4dfYndk
 F8mD7zloWBOT3bBFobelzHOhaFzazF2bxnvWtO5PKxLGx2fiukBqiUZqmDGhf7m7E8M7Qduv0xz
 n8B0/eJs=
X-Gm-Gg: ASbGncvo2TO49BZFFb/Sm9rYk7sjC8wC7GNn0QW/E2B6zf4erKYl4gaKnYzszwvgFVZ
 QB7d61+09EljhstCdVH7j53uVZ0IIAhw/OCFHWyzDyAKxfJwMkFdRZbk9lXSkmuT/fesUgHFDtP
 9fS5oGV7s4maS8NlFVr7+v8sYrbBEvRAx7vMEbYY8dGb3k/bWGHdKplR8xLu1OtKbHumlM6RDpJ
 R7Pve7YH9dMMoNAAN+/eLjxFKkiaAl8ZMYWvQOrHdtqBvDcYoyBDie5l9x5B+sn0tX/9VESew/L
 l2djtmG+xdBK956DxN/gAtLe6Gb8yRzZNvOgd/om4EOj3xHr8rA1JS6geZ8s28nBBN7a3MN1xSs
 bE69OskGM0I2VsKUm1vkkLizdzx+lMBWO5uHXPd3JjDYaSW/BcihoZxGp
X-Google-Smtp-Source: AGHT+IHi1Eavz7/nY5mRQSjvvwiivGo/BRTUGOEqsH1vXC9cSCmAny9S+QtO7kft5DdfbiLWesovtw==
X-Received: by 2002:a05:6a00:8c6:b0:781:2538:bfb4 with SMTP id
 d2e1a72fcca58-78c98d5cb4cmr4121329b3a.10.1759511520177; 
 Fri, 03 Oct 2025 10:12:00 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 65/73] linux-user/aarch64: Release gcs stack on thread exit
Date: Fri,  3 Oct 2025 10:07:52 -0700
Message-ID: <20251003170800.997167-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b09ea4b0ff..39b139b0bf 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9340,6 +9340,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0


