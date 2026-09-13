Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8569AC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a3c-0007ac-2u; Sat, 12 Sep 2026 22:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a3Z-0007Zy-Hd
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:35:01 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a3Y-0000JI-01
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:35:01 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso11389855ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789266898; x=1789871698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NZ2+79fhfMG37eo2JAfboLrsaQGwKctXSIU9Yh3TyVc=;
 b=fvXu8/LElaDQGLdC5VTcfKNBprvdKK9WOnrG7mo6IxBiyKFREWIzrZNwN5LW/mOMFG
 so+oXtNOVHDkRblpT05Ncpf+SzxxMhRqo90Ml+cJ9qRU2GZbfVcaEEhOrWOBsOq0IYfh
 oFwALhGKx0qvqYTU1JTDj5npoiGcyCv6aVuv7hSvpfYLnck4eqf7LXZyZT/xp1uPbB9x
 B26yJh/iVRQXVMTlGWbUQb46r7BpD/bmJt0c6/cj+fSqtWoUi7Cb/7LgzRURAHJ3g+a8
 +yGYYhNGihnffSAMEh3O5mAkg7Rt3W3tzONG0bwJqfY/N8U05oamECy3C80HR3UHRenP
 lgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789266898; x=1789871698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NZ2+79fhfMG37eo2JAfboLrsaQGwKctXSIU9Yh3TyVc=;
 b=Mapts6jGmXEZP5yTOzQe175IMcVzNIjhiwFS6sVIFg0WcTWFbZK9GGh45Fjl8HO3PC
 a4RqG8qxBhlLeCTEm10eEip5Fd8hGHvJqgrFok5sRIXbhIMXpsdCmctjh0s8D/aUZg+j
 9bKQIAt3cHzFSlgzd/4bI38x8uVr1Jr/gOb3v0+tlZLTTUYUKX4vBqm4/0dkMsX1AlHh
 TpAUyAfy41xNonBo04dskS9GrKoJa8TDpmGh+9yxVwDhU/bjm6pPW/vUs9PzYQgEmRh8
 tHCybi0/jRUt0ajRVn+i7DRxLumQkd9FpLVxLjJkUk8hBThfSZJ3z1PUBPhYSfk8PvHq
 zmeg==
X-Gm-Message-State: AFuF++kmR/6asxc3L0XuufAjtm5n0TX51hwvg4CFACAjX0OTiAtYMzNM
 BeAjRB7p50m8xA+x0NR23ZFYkj3Acyn/hXkgU+tlylZJl8KtiT5mo+gNFI0RXaO1VzWqLvhwkRL
 1B1F1Ets=
X-Gm-Gg: AYBFou2KjVIv/VnH8RJoCrcbSqYA3CoBiFLJzEE66aWet9SE15GpZt+L2UV410esQQZ
 SrMzHrcU9RahXGndKACN4BT25wrXwp0+tIOlSqBAJvnMUKBAv6ZHvkbhXO6no7/EpP2EeS0iYCD
 93UdL6uEYPEQ2tktk9tBmR7E7dRq2hmexcD4PTenHnUyJfHqlVr9owFZr+xLYP9knlvgxV4v8q2
 t4V3bLXHcbJn4hgn4QY5IWVxv4DTN7+QFkO4H0tY77FV95++cCmG5mKKxyr8wuwBrH9m+mVZR5Z
 mpJKRs3PZZcUsVrJHjTcGxzgwBfyU4fYNfM0HJ2q5nJxA0610Zx+Dg2tcrwv0G424tg7c3NTAbg
 bwd7Am0kSawxfJUO4YD8gCKUqBO9EGJAcQpB0gm5u/C25VN4N0aBwEguQlfeClshqP4c6pwNFpk
 MuNJreAGH5NiR8rxGQ4pYXaGyjjQ/2tItPUKJuxS36a/+p+dGyXqAk8pGKvgSW4ZAGR9hM536np
 7dvOArz
X-Received: by 2002:a17:902:cf4b:b0:2d6:fee6:65ae with SMTP id
 d9443c01a7336-2dd2a1c9c3bmr208687765ad.4.1789266897891; 
 Sat, 12 Sep 2026 19:34:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm18647153eec.28.2026.09.12.19.34.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:34:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/sparc: Enable variable page size for user-only
Date: Sat, 12 Sep 2026 16:34:55 -1000
Message-ID: <20260913023455.741626-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu-param.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 7ec4ac84dbb..96b46d41164 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -7,15 +7,17 @@
 #ifndef SPARC_CPU_PARAM_H
 #define SPARC_CPU_PARAM_H
 
-#ifdef TARGET_SPARC64
+#ifdef CONFIG_USER_ONLY
+# define TARGET_PAGE_BITS_VARY
+#elif defined(ifdef TARGET_SPARC64)
 # define TARGET_PAGE_BITS 13 /* 8k */
-# ifdef TARGET_ABI32
-#  define TARGET_VIRT_ADDR_SPACE_BITS 32
-# else
-#  define TARGET_VIRT_ADDR_SPACE_BITS 44
-# endif
 #else
 # define TARGET_PAGE_BITS 12 /* 4k */
+#endif
+
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+# define TARGET_VIRT_ADDR_SPACE_BITS 44
+#else
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-- 
2.53.0


