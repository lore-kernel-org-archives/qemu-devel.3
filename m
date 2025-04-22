Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7878FC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JOS-0003sp-5k; Tue, 22 Apr 2025 15:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLm-0000q8-68
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLh-0006eX-7U
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2243803b776so87046905ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350323; x=1745955123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IIU1fG3v2ti6ddjpGI+Ep7ZP7ka1a1iDtVAhhJuSr6o=;
 b=Pgct6mzGy7n4/vNCtUPaLEVVsX6V3iTGvIzoYfiXmX+6/oTiNA+skT4ev0KMOW6YdO
 EppwNM8uxz9fdQ/dz24Y2ydDIPf9CBrICjkgcv+tmYHk9jXbXMvTpJtGt3hwtOa/bMfc
 5onf8PRWT6SZTfo/5pFmPC5cWXDygTgzl8f9eUcdwPuLwThIt/ehFYMRZawibGN40yMF
 rQuliQojlxvVIkJyFij7fnlZweFi+bQXMGU4IkCeED3+J+DViZnrT5et5Sq7qhGYQp8E
 IyzdSRKrkUAcmvEqP/4+4SZdRR/hTUludh8p7W89tRvhAegqCQRqreGlIOS6sscgVLhr
 /HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350323; x=1745955123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIU1fG3v2ti6ddjpGI+Ep7ZP7ka1a1iDtVAhhJuSr6o=;
 b=m5xqeda00oa+fKRylUoSUmLX0NNv3W1kYzW95vtZscvxz+Kqm29FdNwGGdqGh7apKE
 vqO55xe+6HmPni5yprVBYYwnoMaBrRFS/+LkN/voMRFXZ7mIfU9eZPvVrCkPPJ3Tphce
 sJSi3st1EapHBtQRNdRijPmuKEID7OnFOuqpZDm+EQYGus4Bkt0jvnrAB0QRAVIA2HUm
 Vqamubvm3yJGHAdJS7YtkksNyc5seBldqI8CIyinzxujoKEstdd69BwQlyY3NE63au7H
 y5hDig2VyASPx4QUZ77zRHwJTjAjVUtoH/BOUpLqT1jNUO5MQHmgXdkIiIXIPoTTbLRD
 ARWA==
X-Gm-Message-State: AOJu0YwUA73xk9Yf3sH6Vqkq8Nm3EcCiUe+S1w72q9X+6EyxIIhwaBrY
 mnbSVcyhX6PQcCWxiMRHjfw4rJLpMdgMxHfOdFNJwupYxZiRLpMYuC21eZ3cVVKzkDWXDyuWKrv
 x
X-Gm-Gg: ASbGnctyHP6VLfElPivrqkFDYAm90jpeIK7EtgaOdOVWiZhBkoVnW+TKiO2wQxqjsDW
 VJGepzndqflvv0ZvZlOvfZxkEEq+kGAsDk8zrzSxm+ZTlapGgwPmPgPLU20csXpVIG8O9iBjZo1
 oSuFXzsht1C2ARWXPB5cl7n8a0FTdxzW/2EXJ7swqUklWdyStK9qcRIBusnDS8gXL/S6OsOAFrb
 M/74+5drk75TQDf7Q8Q9nTre/FjKiqcWjBY1GQl40IXg8brBcKMJgT324lj6ZNxBSh5PcpAwFTK
 6gSuxAMcBfWFwBk3R9Y5t820E4BA3pD3UTDechl69Zy4LBHttAX+FwvLoYPr+CarOtx0wXDBGws
 =
X-Google-Smtp-Source: AGHT+IEXIjwxRcCLel6K3nCgtqqDsI4237rjSZpO9q0mzhlkMkRcFQYLY4l+WROpKm3Xtf9dO5MZ2A==
X-Received: by 2002:a17:902:d4cd:b0:224:910:23f0 with SMTP id
 d9443c01a7336-22c53642323mr214658235ad.49.1745350323431; 
 Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 065/147] accel/tcg: Rebuild full flags in
 tlb_reset_dirty_range_locked
Date: Tue, 22 Apr 2025 12:26:54 -0700
Message-ID: <20250422192819.302784-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Undo the split between inline and slow flags before masking.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5df98d93d0..28c47d4872 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -886,9 +886,10 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent
                                          uintptr_t start, uintptr_t length)
 {
     const uintptr_t addr = ent->addr_write;
+    int flags = addr | full->slow_flags[MMU_DATA_STORE];
 
-    if ((addr & (TLB_INVALID_MASK | TLB_MMIO |
-                 TLB_DISCARD_WRITE | TLB_NOTDIRTY)) == 0) {
+    flags &= TLB_INVALID_MASK | TLB_MMIO | TLB_DISCARD_WRITE | TLB_NOTDIRTY;
+    if (flags == 0) {
         uintptr_t host = (addr & TARGET_PAGE_MASK) + ent->addend;
         if ((host - start) < length) {
             qatomic_set(&ent->addr_write, addr | TLB_NOTDIRTY);
-- 
2.43.0


