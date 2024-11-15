Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55ECD68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PR-0007df-7c; Fri, 15 Nov 2024 15:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PG-0007Yi-Cd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PE-0004Or-HB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:06 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-723db2798caso1979683b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704343; x=1732309143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbNlBnAW9PFPyjzSTtQpE4/aMbCM3Oh1YovDgszQh+4=;
 b=JD9dYxu4kxlxuJuTH7dV3v/Sg6JFZkQBW3UjV6ce6GQ2SyJ4kHhwjxUyirBPQbH6om
 FNq6gCsuZB9zr7rLndOglQf2qYmVNshm3aU0qJm6fJ78KH/YB9C37r7iIw1IZ5kersWb
 lvsOgTi0JJjxXXwRUEx0ZkjaQlWQ/8C5q/g4h+UEtH8Bn/Qx7LRfoBomZs5unMkmrDx1
 r03QXmzYlc3YdPbD/2RcLzdy3axRyuce312boYvCnCYd5yNIqjv/sMhVPPKYm6cjXULn
 AItr3V9DQah/+BUvJfeHh79pcA1B8PcrbHyf6RNFMbx5Js22gyfypgG8snNxUpl8/tBo
 eOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704343; x=1732309143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QbNlBnAW9PFPyjzSTtQpE4/aMbCM3Oh1YovDgszQh+4=;
 b=pSvCuxqmxQIk5OD5aGJ+txW7iRJvA1VlQ5lg053q0RQu54X7drkCPTMskNf1gXueqK
 tVgsJHX4hHvbMpV7CQSAaV2hZ8gIkTRijbGMyvB8+4ujJUM+pIzrsgCmnLbLMcHCOyKZ
 AloaU3ELqJ3akXsBmeJWYhOSli2IYbZ8lgsiUE+xhOEwNU1QVJjPx0S/M1yvvuEGjgzE
 yuTDrkx8wcyVfIMtCbEk0q6O+pCJqpFBf3h9+qlde2kHjHwclQwXCzwKItnxN8gXnXqc
 EGqIA0iRJO8gj786BixRotyFdBoKI5VwMO9UpR/JgcBUjiaIrwohBIczGePRPjrZDNM1
 4ecA==
X-Gm-Message-State: AOJu0Yy1KXz47yelbqtBYpneVeQ7S6Eu3TXEsT3Ir6rxgybgyj7ThM6r
 i25U9o3Zmpg40+/TWZGRGy4GaOOB/Q6EaExuTZQRUWkWAJgj82D+s2AjSFjPlny3I62Aa1TXZde
 V
X-Google-Smtp-Source: AGHT+IEHflNjOXJmqNqSND4ahkJKnmki5uh3a7CXYL2304G9kCkJ8zTlZvi/ZhqZLtKg3Gclgutjvg==
X-Received: by 2002:a17:90b:1e0d:b0:2ea:122c:ea18 with SMTP id
 98e67ed59e1d1-2ea15528912mr4277796a91.21.1731704343140; 
 Fri, 15 Nov 2024 12:59:03 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:59:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/14] linux-user/ppc: Reduce vdso alignment to 4k
Date: Fri, 15 Nov 2024 12:58:47 -0800
Message-ID: <20241115205849.266094-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reduce vdso alignment to minimum page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/Makefile.vdso |   6 ++++--
 linux-user/ppc/vdso-32.so    | Bin 3020 -> 3020 bytes
 linux-user/ppc/vdso-64.so    | Bin 3896 -> 3896 bytes
 linux-user/ppc/vdso-64le.so  | Bin 3896 -> 3896 bytes
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
index 3ca3c6b83e..e2b8facbb5 100644
--- a/linux-user/ppc/Makefile.vdso
+++ b/linux-user/ppc/Makefile.vdso
@@ -6,9 +6,11 @@ VPATH += $(SUBDIR)
 all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so $(SUBDIR)/vdso-64le.so
 
 LDFLAGS32 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-32.ld \
-            -Wl,-h,linux-vdso32.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+            -Wl,-h,linux-vdso32.so.1 -Wl,--hash-style=both \
+	    -Wl,--build-id=sha1 -Wl,-z,max-page-size=4096
 LDFLAGS64 = -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-64.ld \
-            -Wl,-h,linux-vdso64.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+            -Wl,-h,linux-vdso64.so.1 -Wl,--hash-style=both \
+	    -Wl,--build-id=sha1 -Wl,-z,max-page-size=4096
 
 $(SUBDIR)/vdso-32.so: vdso.S vdso-32.ld vdso-asmoffset.h
 	$(CC) -o $@ $(LDFLAGS32) -m32 $<
diff --git a/linux-user/ppc/vdso-32.so b/linux-user/ppc/vdso-32.so
index b19baafb0d38e15b4a24def5c44a6d684714be45..0dc55e0dddff618b954dbb939335e99956daf64a 100755
GIT binary patch
delta 42
zcmV+_0M-A@7t9xsCINtvCrSbU5Rr3n6lq1YQP%3b&XBjV4sl%JXqmbIL$UbO3Tx34
A(f|Me

delta 42
xcmX>jenxzP8Y9C*buT6$SzIX6c=(tjbAN``v6&a|RP{JtzgDQRW#f-4TmVmR5>WsE

diff --git a/linux-user/ppc/vdso-64.so b/linux-user/ppc/vdso-64.so
index 913c831b3819fc09912b9b31f7fbe9ee311ae12f..ac1ab2582e4675979ffca3ce90dce17df579ab2a 100755
GIT binary patch
delta 38
wcmV+>0NMYz9=INmtpWfLk*~QFqejR%tq=sGFts+qF9Cf{%e>^#vwQ)(4KYR#WB>pF

delta 38
wcmV+>0NMYz9=INmtpWi6k*~QF<@TF=qRS8+wHM`Qf0n_&>m=ZivwQ)(4PLhrs{jB1

diff --git a/linux-user/ppc/vdso-64le.so b/linux-user/ppc/vdso-64le.so
index 258a03b807c4eca23547d978c16d1ad5ebd08bc5..424abb4290b7d3100e9dede2f3059483608ba703 100755
GIT binary patch
delta 38
wcmV+>0NMYz9=INmsR9rHk*mEFj|Vri9^_Z(nV0Nw;)4VN>*aZovwQ)(4Mvj@kpKVy

delta 38
wcmV+>0NMYz9=INmsR952k*mEF`$9%&`;)~jB!C2C?=itIoQ(CfvwQ)(4MbHDMgRZ+

-- 
2.43.0


