Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA06FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ub-00043G-1B; Thu, 17 Sep 2026 05:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UZ-00042W-5b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:19 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UX-00017w-G3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:18 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so552300a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637596; x=1790242396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bqCdJvgeIWNnZfrY0qhjs7VrVH1S30UPAc73TjHZ5dU=;
 b=E8aL7BYYMN+TEBqgdoNRvc3p3BEsqresPCKlhLzuvmSHpy71C/ByFxPxyUJgBh+Q3f
 sjTZscEZREzE5O8XSUuI0XVTlE0YhBB1bpV3rRD/5zhu9+3Hrm/aZ63j7WAU0XXFKNEa
 zbC1xqvMEmT6aESvjqIe03Q9gIgqqFl/4HLBjmgnk5q+jKiKE22L0kXRNFtugXMu0F8r
 CkVCHtVESunmQmtKRFaXHFqqFUgO4EtlDp7HsO18zqcl69kxygbmJ1//iVzoldwwC5TS
 gpZjBvpDCneMmf2pt6UGGWrJ7wR8GtiwpgTC/VmSl4WIDJwfOdgAcqS9ONca69bqZfLy
 TAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637596; x=1790242396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqCdJvgeIWNnZfrY0qhjs7VrVH1S30UPAc73TjHZ5dU=;
 b=Ln7gYmU+CeKQ9IycYFbh7dAEi4pnhvZYaHKlGxD1RNMO+jU/myDgR+HABsdOJD1nng
 i4k4VJI9PHYOR33k1Kh+Je1H77hkMZebjkfoiQYjMCfMKHbuDW3q36tNGGCGQ8g+bGX8
 JNpo3kJw5Q//xj9qvlqZI6OO2AWHSjG+5nettSXCCzHRQCP4/Lp3Mjvkfs451v608u9q
 TyLZFF4p+3C2iqoy78WZzCmv9sj1tbAbOlzftykgkfh0227+HFni4NF7yiYINz9m4xgD
 oQYuqmHEwGM5HsCrn/Jv1a34ofygwSWO6uwylmDt/utd0Sr9BeVJMz7TPhxqw5A3jWRT
 2Z0A==
X-Gm-Message-State: AFuF++k6h5mTBDL99t6dQboyxuwRxAWo4PZms/m3Yv3sLhuFFbUqUd1O
 my1hgDCcpPmG/iMoC2pgAwgMDYuwKcuK8BIpzTojnCbHoFiujG4UfvxHQ8wSUk4x98UHRKw5S+5
 mdlXpXA4=
X-Gm-Gg: AYBFou0tdwsZvTbLw6A1N/2EJD5WmaCuGy7r9w6GMVXjbK/OQxPxtXSWs9tmDWBTN2A
 uoqrAiDVsdyxHYyNQ7vkKs0Y4YBj5LibQkz3sLjIky3QPS9pLIyXAf9zbB974lEpzfzmR0EibiW
 WGxnTAdyxIr0GM4kBGSfl1coX5xn90Uq4+4qwy54yKNocTZrEC7rbdXEYUHX9WiYCOu1uwmASBc
 gTkUYe+/rv9Zw2RxNXLzlQY75ziav+sAZfQ/MELlUlI61w7ZpzA1NHyVSwtYyFMQwb0MZJbUgqW
 BN/dm7rUdGGIyRw2Q5aI3XHPVemK7ZZmWF0sTAiX+hJOAtewYzrLjlnyYUJQHU5nHOQPqtjPNRJ
 wgjaJLLu0f8V3Qt+HokAjYfPbIL6P/tPs40cs9eqGP6N0ZLMcCXYvk8/N6/+MDmclBFPD5pazj1
 afqLC2g8UyLosaJAcFoe2HXjm50u1nW4C5/qzKroGJVdKY4IprYncfSDtV9GXyTrQnCzZOr60rT
 xgzF+Q=
X-Received: by 2002:a17:90b:54cb:b0:39d:f024:c7e2 with SMTP id
 98e67ed59e1d1-39e1e269219mr13396295a91.4.1789637595967; 
 Thu, 17 Sep 2026 02:33:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 05/13] target/s390x/tcg: Remove DISAS_PC_UPDATED
Date: Wed, 16 Sep 2026 23:32:59 -1000
Message-ID: <20260917093307.1092084-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
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

This value is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4eb2eba5e45..991df67a419 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1025,11 +1025,6 @@ typedef struct {
 
 /* Return values from translate_one, indicating the state of the TB.  */
 
-/* We are not using a goto_tb (for whatever reason), but have updated
-   the PC (for whatever reason), so there's no need to do it again on
-   exiting the TB.  */
-#define DISAS_PC_UPDATED        DISAS_TARGET_0
-
 /* We have updated the PC and CC values.  */
 #define DISAS_PC_CC_UPDATED     DISAS_TARGET_2
 
@@ -6466,10 +6461,6 @@ static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         break;
     case DISAS_TOO_MANY:
         update_psw_addr(dc);
-        /* FALLTHRU */
-    case DISAS_PC_UPDATED:
-        /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
-           cc op type is in env */
         update_cc_op(dc);
         /* FALLTHRU */
     case DISAS_PC_CC_UPDATED:
-- 
2.53.0


