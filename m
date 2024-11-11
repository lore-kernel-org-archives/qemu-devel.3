Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A886D2E9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVk2-0002Cq-JF; Mon, 11 Nov 2024 09:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVk0-0002Bu-II
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:50:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVjy-0001wr-GF
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:50:08 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso42173345ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731336604; x=1731941404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2M/3qA8mMKz7DvBymSN5QuTvN/Xyu5smd+SKwoEDOq0=;
 b=OouI765aM7lkx+/k56qqY7OLSHXtyl2wSePhdbc8iarcrbL4RmihUCybYuqUWiqc7x
 XXm73OxnCuL0ZEgdcrMh+qZROS5o9PNYeMOJE2AO6NH7Gc9F+429p1CsLaQnAl4HnggT
 PDdaAEFJRHxbLgMB7EOYpmMHwDYynMDxngYEwY9Ejf5jUzG0ZKjYZLxgItnoijAhB06C
 IRmdgqb4KCRHSrGo35fY/6QIvDv29/CMxdr2MjEXHe829gmAIHDmb9N4ED4sKMnbNUh1
 Ib2cS/cKg8mcCzKvG+PFBarlHb4LVQl0o6swRJNEDf+I87gadaobjfX5drkQEeV8qzE4
 TIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731336604; x=1731941404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2M/3qA8mMKz7DvBymSN5QuTvN/Xyu5smd+SKwoEDOq0=;
 b=X5XQoAnbyyrsBF9KkydIjvwrZ1eI8TiQei4yyUTPBSmoN4PmX60NYvNtdE5gQhI/VW
 lSZP7o89no3RBvj7h7Ndk/VXhBFuFvFV/DwAyRTe9R76osEEAX5VxxC8YtSgWXlWNsDc
 zYPBbtF24zegVJVd4GMZOevj0o3N+q8WyvNxl4dLHEjf3IqZAlLu+Vc3FR3iX+h/6mv7
 z8oBVR9TkXLa1JEp+8Oc/bbByCmZzS2Z4jdnWA4hn96DEVOiA6f63sB1GcqGpGAwL16N
 OllETxqQVpPDi/H/ny7tLfSexK8G+A/voGwdgfO47v+g2VlM3dTwK5FzX5NwJdW+rCDU
 ZgxA==
X-Gm-Message-State: AOJu0Yx8nIJRvbhIntCuv/L49JZLT1/bnYjBKA/ID3/Otzl73WMESElg
 GpVNtUaIh23JPFkhuiXaAWCKOS/zTRyXsSqeGy7+ZjKwfJ3S8rVZcP2ekoGehcOkjoBMWQtkj08
 K
X-Google-Smtp-Source: AGHT+IEVvIf2X0eekEoWokJQUG03DUGUs5QXh6JoFPk6M7rHtK9dfRhcgX3T7NpQL9DDOaOGJqEp6w==
X-Received: by 2002:a17:902:ea12:b0:20c:ccb7:df84 with SMTP id
 d9443c01a7336-21183e0dd1cmr183698405ad.42.1731336604557; 
 Mon, 11 Nov 2024 06:50:04 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e68cb0sm76213705ad.224.2024.11.11.06.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 06:50:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH for-9.2] accel/tcg: Fix user-only probe_access_internal plugin
 check
Date: Mon, 11 Nov 2024 06:50:02 -0800
Message-ID: <20241111145002.144995-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The acc_flag check for write should have been against PAGE_WRITE_ORG,
not PAGE_WRITE.  But it is better to combine two acc_flag checks
to a single check against access_type.  This matches the system code
in cputlb.c.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2647
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index aa8af52cc3..06016eb030 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -800,7 +800,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     if (guest_addr_valid_untagged(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
-            if ((acc_flag == PAGE_READ || acc_flag == PAGE_WRITE)
+            if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
                 return TLB_MMIO;
             }
-- 
2.43.0


