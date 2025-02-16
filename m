Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1ACC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyo-0000MU-JS; Sun, 16 Feb 2025 18:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwr-0004Xx-Qt
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:18 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwn-0006Ux-FM
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:17 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc3db58932so2316505a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748071; x=1740352871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aJrfU5A8CCjFfdkaUaey0M3HJmslqRD3E6MNE0jVAvg=;
 b=a5fFvi/q6VXzso3MxhStZWsDcnq+lkvIOK0BFwqv3ilCVMmhPL2SFfjNNZGeJ/jdjv
 E6Oko6PLPlLlmWhxx8wIqjJ3GYk9GemVSu7jqA89K8B3eXmULu7z3kJd8HDusNeM7OOS
 4E6vNuQ/cD1ov3JVCHwenkp13ftn84eJeHbLwXcPooiuHxIJ+h0U0cyvPfczaEkpNCar
 mIVFFQI7ZTkpr/G67Cre5VojCANEqb5mAnLLtcph2MGuRkqOUyGUbm+2QMiEtbKdy3hG
 y+Z3kEaUWmvi5po7NCya3x0ZnVvIWYH3ZIB4Jy2SATA2GdBmP1r9mrzYrbTpac7Hi12l
 kwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748071; x=1740352871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJrfU5A8CCjFfdkaUaey0M3HJmslqRD3E6MNE0jVAvg=;
 b=IO6715K0lbTSMVqQoY/4j9pxkCIetrKzK1jN4nM3xAxEl/eEO4r06yCPTdUjXMCvSk
 /8Lrv9coLW1siyeqV/H7kriwGMBtii3E+mx+3+WKW3mV1WH9leOizzbN+2lbq+jcNIAo
 052lp2LhpwtDttKsmoxsv9K8qINuRfI0Ln+YR2m/ufLhAt8KVGaD4y+eS39bJG9rzHCC
 oxbt9FfDzTkGoCX3M3vRTAuQNaAg2pbDE+fHVcgyktD9ZaGP6hB32Hj7HURrT1jQB+mo
 yimCTIiyDUEFPUBXuHMMRsVh8wSzPyloRYy6sZg7XBVcH8EB30+9Ry/OnSDeIwDfHlAD
 gs9w==
X-Gm-Message-State: AOJu0Yy73utaEmRQ7Zjm9PtZpo0ABVwZyCNonMY73Jn9hEWMJ/D2wPpk
 hVpXeaLh2X+vyFXz/Y8oob1fJGwCyPIKRrz15ADmT5lcK14D6vcLJfqqxbE/mG/uEf7Ail4jajC
 o
X-Gm-Gg: ASbGncuY5fNcysAJWt69cq3J6p7F4XXIE0+TX5MmB+sC5RRGGcY4QMc4cHb5Ra56z8m
 mBvv59AXbmO0Fn1P7cvjiQwGRbTof7/y49/aA+zKYh3ea64fBisxeRuabBTKTvwHBnoV8lw4kI0
 85pEPDin2D3nBH6EgjYuUjI2jWnGi9VJs8kmtLdnHDg7wym8dFI5DE5HKVtjyjL0xxmdGuoxMgu
 I1UGhxXFNUJqB22a8O3lNwExSYjRZXNeZ2O9uRB1EXRKFz1aQSKXpB0BMIFrdCCbFkgHdUyOGdo
 lwA9ENwUoiPEThTwwKLk6uNPJMWgfxyWsbJjtkwRAR5VWf0=
X-Google-Smtp-Source: AGHT+IEJK/4wegkQGscdcOvBXhL+o+uK+x3KtfgXCI7FY6zmBNgbjf+/A1oG25s11+OiYONlz3DkRQ==
X-Received: by 2002:a17:90b:38c6:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2fc40f10876mr13506885a91.12.1739748070902; 
 Sun, 16 Feb 2025 15:21:10 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 152/162] tcg: Assign TCGOP_TYPE in liveness_pass_2
Date: Sun, 16 Feb 2025 15:10:01 -0800
Message-ID: <20250216231012.2808572-153-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Here we cannot rely on the default copied from
tcg_op_insert_{after,before}, because the relevant
op could be typeless, such as INDEX_op_call.

Fixes: ...
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c66a262259..ff264d7c2e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4383,6 +4383,7 @@ liveness_pass_2(TCGContext *s)
                                   : INDEX_op_ld_i64);
                 TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
 
+                TCGOP_TYPE(lop) = arg_ts->type;
                 lop->args[0] = temp_arg(dir_ts);
                 lop->args[1] = temp_arg(arg_ts->mem_base);
                 lop->args[2] = arg_ts->mem_offset;
@@ -4455,6 +4456,7 @@ liveness_pass_2(TCGContext *s)
                         arg_ts->state = TS_MEM;
                     }
 
+                    TCGOP_TYPE(sop) = arg_ts->type;
                     sop->args[0] = temp_arg(out_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
@@ -4482,6 +4484,7 @@ liveness_pass_2(TCGContext *s)
                                       : INDEX_op_st_i64);
                     TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
 
+                    TCGOP_TYPE(sop) = arg_ts->type;
                     sop->args[0] = temp_arg(dir_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
-- 
2.43.0


