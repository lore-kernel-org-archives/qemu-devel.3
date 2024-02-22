Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520A6C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvN-0007ep-Rq; Thu, 22 Feb 2024 15:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvM-0007dQ-2W
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:08 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvK-0002jz-Dc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:07 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso33295b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634643; x=1709239443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5K1zjw+5Oj4rrjx8HADPxYdAwsCVv3T9uofL+YVvOaU=;
 b=ltjVkg6ZCBwum9isc65AA08IAdjByq17DfWWHgS+EoYnEo/zPiA+cGN95RBzLRugjC
 nxkdixDaVsDY2mNl9/tPoEU/U+T8TS0I+rVdRyqqvcaKzr2aGEkf41qgMUHB6yZCtUKt
 GojdiES3m9byY9BTrBPD1I7yhC6mCdvfcpFpB6nqgtGzxn2tDfueKMFrd4o38v8EWuFL
 cEcaQuWx7mjynmemFDRQuM3it6LAL7KRe6bsVgAJ7RwO9OgoIv4nyNXrY83FSmox88x+
 baZXUu96SZDZhlB3PN3tuTTnru+U0CW+lr/pCaQdqUweBSxpg6D1j+KR0/9kSwxM48bk
 HLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634643; x=1709239443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K1zjw+5Oj4rrjx8HADPxYdAwsCVv3T9uofL+YVvOaU=;
 b=GNlwLoPOHPA+cSup2DMl2UpOd2ZS51LY5Sq+5CKM6cDT8VkZCQ30MBJ9n0bQY04uzQ
 2Scp3rXnbXcwul9fpOMYy4S3HHtJZ3T+FR3PtbgZKTX7Xs1i1Opc2MeNE0mPQHbIVrkG
 qZnb7Mdcewhr6X86VyVpPDHt+qQLT1tWNIDvkknLMi5QIA0ki0RcYnfwrSJPJ3TolZyN
 5mZC8m6cG97IDXYWRuTlM5ZeyI1GcKWK4acFqE1mTDcSanklwmHuggzY6im7QGWYETkG
 QYRP4cOMRptF5bSEZ2G7aCBkLyvrZpyHXmp/ktn9xBgaxDE9rTlLAMg0LLvTz99SDKfn
 5rnQ==
X-Gm-Message-State: AOJu0YxRI8Coa3defe6N8W9J23VYlpcpN2sa3ObECRi14EH5Dt32NNH/
 j46kmamSvqh/lBBPmw9AesSGtsFxOg+5wllmTBjhcVldRqFkuL4ELjqzOanVq0PPZtMh7lLuRCF
 c
X-Google-Smtp-Source: AGHT+IFrHlkwexOK0vx8DQG+hs+3FnEgJusKWw+l9An1A48F1MSa43PjNFkrB79bTUfu9AdF0WcSCw==
X-Received: by 2002:a17:902:9006:b0:1db:717e:d8ff with SMTP id
 a6-20020a170902900600b001db717ed8ffmr23933279plp.69.1708634643141; 
 Thu, 22 Feb 2024 12:44:03 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/39] linux-user: Split out do_munmap
Date: Thu, 22 Feb 2024 10:43:08 -1000
Message-Id: <20240222204323.268539-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 1bbfeb25b1..8ebcca4444 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -267,6 +267,21 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     return ret;
 }
 
+/*
+ * Perform munmap on behalf of the target, with host parameters.
+ * If reserved_va, we must replace the memory reservation.
+ */
+static int do_munmap(void *addr, size_t len)
+{
+    if (reserved_va) {
+        void *ptr = mmap(addr, len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        return ptr == addr ? 0 : -1;
+    }
+    return munmap(addr, len);
+}
+
 /* map an incomplete host page */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
@@ -854,13 +869,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    if (reserved_va) {
-        void *ptr = mmap(host_start, real_len, PROT_NONE,
-                         MAP_FIXED | MAP_ANONYMOUS
-                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-        return ptr == host_start ? 0 : -1;
-    }
-    return munmap(host_start, real_len);
+    return do_munmap(host_start, real_len);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


