Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F9DCEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJK-0001Nu-RI; Wed, 09 Oct 2024 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJH-0001Kv-3r
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJE-0007ws-9O
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71df04d3cd1so4245717b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486542; x=1729091342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Do0SdIOifT89XnNeUtN7RO/VbTA/vHCZ7rZBpNO2/jQ=;
 b=TSTTmRmPpvbPrBUDejy3Cc71GkMZ2c4lz1OkebDb/diZcqFO5BQFseHkYGXSQ2VXyX
 40SpDN7W7u+egi8UH/CA9IUM4Fns2XkFViDAmRrPAp/LMiA7jVaAGXyrdP8HdCECwYNy
 4/pIAADPVZXtBlsVoedNm2GWyuAtUYx7P+zPYdBxxje/PtItrWdqMdIgr1wMNKcqk8Ce
 JWXUWRURMbOAk4NupPWsKq0QueZfEXaM3/qlVw9Xk0NIS5S7w94ecIbtU+O0ZxW7BlRn
 nRfNO3RV0VuOjF2RYy8R+e9iGbFJx8NxwIdPnACblcPU97Rj6KIYrn+IFjEYK2+m6uhn
 vEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486542; x=1729091342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Do0SdIOifT89XnNeUtN7RO/VbTA/vHCZ7rZBpNO2/jQ=;
 b=nCBUDiZigu4pQjf55ZQGxQJW8HMebB6lwm/IYwfVdbZfb9stdYWXZ3vrxfTDKgQcAr
 hxDMZ7UjC1MTL7EpWRnZR75gTXabpDWSehKjSLv+E72k49+vmAKDLO5CE0wbQa+/y6VW
 l+dDw3JFwPwgQ4VrLVtCgh7VC7wWO0Mrs84PT5BNC0jiNuiGypLst0Ijo0uDknZiGAp+
 RsFfFTFRrQ0XWZjPke86Cx2SW6zaNU7Z2hW4Kl4Nx+1J5GGH5eij3k3NAEmZFreHk9SG
 /4RAVI7qj00Qdj0layTKqctgFjVXhWxfbPsrnAV16tmXIgWVAh84mCMf4OP/rn4mReDm
 Ox2A==
X-Gm-Message-State: AOJu0YwWVMHDFMWSGMuUQxqUQ7z5JIR8lg/R7Iu9t5CUL6wrkQckZjiu
 GqfXKEc99v0gsmBr/X1X3wTxH92ljktD8UWH09oBHABVt21QlmecBTcV7Sl3Xd8hIBB4PQRQABV
 a
X-Google-Smtp-Source: AGHT+IEvZePKT7NROK5/oy+CQcERPtsns76/3R4ossBGDuriA6ygSiVN5gHJfVk+Y9UYuW4s8tdpig==
X-Received: by 2002:a05:6a00:4614:b0:71e:10ed:6f3 with SMTP id
 d2e1a72fcca58-71e1dab3e86mr5337972b3a.0.1728486542559; 
 Wed, 09 Oct 2024 08:09:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/23] accel/tcg: Early exit for zero length in
 tlb_flush_range_by_mmuidx*
Date: Wed,  9 Oct 2024 08:08:38 -0700
Message-ID: <20241009150855.804605-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Probably never happens, but next patches will assume non-zero length.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd8da8586f..93b42d18ee 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -801,6 +801,9 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
+    if (len == 0) {
+        return;
+    }
     if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
@@ -839,6 +842,9 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
+    if (len == 0) {
+        return;
+    }
     if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
-- 
2.43.0


