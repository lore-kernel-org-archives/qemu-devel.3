Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFA5CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYh-0002bW-5i; Thu, 14 Aug 2025 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYc-0002TO-QS
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYY-0004Pp-0K
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:50 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-323267b98a4so865259a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176382; x=1755781182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=mheFYxyBDRZLrY5TvamzybUb9rNG2GBM/BwFcgfEOSB6n9KISQY5yWuj0qq9mwBiB7
 O06qj9XcVDcl0o3b0DkBqN7Gkiz08QUZs/JXGmND7j/uzUe09woedkGRUTg1xKZAP4Kq
 GhAPOf2dwsz0sQ9trLCi9mlWoTsLBzdNsrFSG0ad6BTlYLcQ3IDzzH6ReqFJO8LXdavU
 AwJlvPKCtm28gCjT68h2yqNM5E49p4ZOvcTxf/I9NRZxrGg6T9r6wIUTqNJJkSFH4BzL
 c+zMy7rQH6vpJUSjiUARkFWJslU3GI2VAi4iFjgAlrtPPi2P4GbRVgmCSYwP9QgTxhBB
 5raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176382; x=1755781182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+ER0bRwaWJSVZXuKMTaNBSXf4hbZ3aeU4lFfN33xP8=;
 b=Ljxv4XIVneCccq84Dm4KpBRUY9Qv8MEXsZfWs+0J0mFQcTPeWB36ve4xYYPi3EIazZ
 Eqa8ASghY/87rlZqzvruS+a0Q8XOkulEyfJPfdQPsOLnTN6aDWG3jAKumIrjJwSgPqo9
 cxObp5mgVBN38gYFMrQ2M7eIrOo0Xwp5uIdnkn+YRvy6fVsd+DjiraRBOfrReV+VQ5P+
 yHFq3JbETZgNwSa7VAAzjNjrE9ZgXSSPSYbhloCVPOeyLT3ShS5fnzV6uWIUVm4CfbEp
 kP+9z/cf2J8kv8nyNNnsZivAc/e4SljNv8EogQr+e8D3n55qK6wEqqHpInUFd92gDlOk
 aXgA==
X-Gm-Message-State: AOJu0YyM5F9hu97oDZ+FGAsH3MLV6cf45YykazaYp973aMbkufr8zDjs
 RG8f6tQAjQxEjZtihbIt7Ikf1IZxjJledPereAUG6FpLwQ88dUk5/iO1gV8D3wIU1WEhd4gRJ6x
 /S4VdI4g=
X-Gm-Gg: ASbGncvfQjz47p2eNa2VGPXpeqksACse1UDInf6NMrFtwpmiJhzIuSyaF11zV6ALuGh
 PtunMbFU0AbAodVjv6zlO1RYUyaGyHGiCRpWueyWzZlilkpdxohRVDnINGwVKyaxXKHgqsonZIz
 0JhOMlBkZM2drW7NKrEhDOe94dnpWRqnmnGZQzBZoEq9qDP7q6S3OliXzcEOQ4Fom19t0BNe2CQ
 oFp/WqSX5rQgTUKdNbB5SjPJzmTip9+AYJ4eoTvAWj3TGUlVNSS2q04boJ36nCNwTsWfdHQin22
 1nUVEArG3RqyG1aPWLlsXcLFXgRKkSgskADF/MA7X7QsvyU13XtulylOFoQQ8HVprBdCjD3z3gY
 wuEHootAP7CqvdhuY4tbV4MYnbTRr0LKSI4EFo/mCCPoqJHOIT9bORUwEFw==
X-Google-Smtp-Source: AGHT+IF/5OGQwj2P8DxePsEitnkzCqjvCoXizhVH7dHkrv1QXC2y7F1jR7qp/b7jGKXt8vkKzwQ6Aw==
X-Received: by 2002:a17:90b:35d2:b0:321:b7ed:75f2 with SMTP id
 98e67ed59e1d1-32327accd91mr3983378a91.32.1755176382027; 
 Thu, 14 Aug 2025 05:59:42 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 31/85] include/hw/core/cpu: Widen MMUIdxMap
Date: Thu, 14 Aug 2025 22:56:58 +1000
Message-ID: <20250814125752.164107-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23eb849a9b..fc9a2291d5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..416aaa1040 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,9 +89,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0


