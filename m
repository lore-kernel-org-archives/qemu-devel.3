Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2057C982D3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Ua-00042s-CA; Thu, 17 Sep 2026 05:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UY-00042J-DL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:18 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UW-00017k-U9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:18 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so423311a91.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637595; x=1790242395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BF4XwRzeDP5SQ+RV1EnEq7JGVUt3w5R2vIKPC0HLynw=;
 b=ffrc0UpwRuXmiB+eHTXg9f/Wcy64fUVZYzP+kcIM0N+6SJZv/Ont5ytKu//d+fUgmY
 uj/rJxTNPrPwAs7uqTQtLb0knMFGlxgvYF9o5vC0ZjTaZ2oYILt97C7xZC6nRhrA0YAV
 xoSlPb9PhYwUw+e5ILMLj8fqieRa5wuRKZwmzdxuI8lVTOX+9iz4qhRs6AaGEIS25GNA
 fmXd1S8x+IDgJxd+h5dsjhjKqw24Hkl4wIvHdFPo9Xx4V6o+H9rYpVjYfZNmbsTiFY2N
 a5ZaRlaNbrzRmG/9lE+fLRwb8njAsggZZUZLDgGIK217RA2AwdSLo1fPpq7u+ZgK94RC
 wKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637595; x=1790242395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BF4XwRzeDP5SQ+RV1EnEq7JGVUt3w5R2vIKPC0HLynw=;
 b=uFmGna544//nnOQ3NwHAoaFJPWmjeLUR5R7fQRsIpwHUyPKn/Rl+V1C0Hf5TqTYb06
 IkQCLbHI8um95Ih64IiOko8lU1xPaIYhpG36biV4ShRE21lDR8NlK6YrnqfVfuXH2guE
 Xsiy8TKP6AjKhOqCHSpsdsohxDYd40IDStRAt4zu/aeCmohtmEHmi5mz5aqurqxnmdYE
 dpvIVLIvEIUD98BmhClyOLnPGDYOfVbUf+9+L3btMUGe3hd9WR5I6VGjeiz2ZlOkidhZ
 yVDfLmaAxWrkQqtdWJiGmVgIZF/0v2QmjCW46FeDg1oVxliPkvLkkAe4klhVViVYGOa1
 TtFg==
X-Gm-Message-State: AFuF++mAO5O5mxz66WNosctoTLmSGaBCGKOFSU7qxRWEBwXhqyFRHWjd
 KsTdVdr884wqRvSuE2GtL6wRbXPvixncqrWGLb/JhmkPzFdZRZZKkNX4Dk8CJhqnRWEaZVB2hRU
 tqj3F
X-Gm-Gg: AYBFou0hKsqdp/ZaELTzyCqvjJQInBSxL8rqgPNEoj2dIKOX7Edr4yLns0JxYQyBdi/
 Uv5HYfHy1niISVWJ/QCRg5pNsGj+/wyG0n6gOavCTPzLYE7B9SBEriOAoyyVx7RzYAYh75G6zm2
 2UeFKw90IJl48gDlLSi+oSUs0j1JVcyppZduXqHyyfz5PRPTxLub1gH/lyahMRB7MFiswqN7uW9
 zcfexVkr8bmNruUgUb4T7ieomD1mHOx7KoWVS6p4Y+ZKSe3G4pTiyjlwqnJzzxiQ8GbuiH/YhGB
 iCjTNroOd0vVXrYw97W7E6f4KHbZ1ZkYImGQOG0sOMDk4pnhxTUcg8YnZyApWejdcKjexQBMPP1
 7023BGqP8qVRtt+mDruFfGFC2lRDUIHl9lrNtfh66GlUuwuAadyoPOrlTUwsiBSh88HcPRgCqm6
 qGcWqhIxyPN0BaiOlQ5htrNWBZXtU41uSHpTnrsxavKkNjFJK5/k3/b/melHKXwfVZ6G+PJYfv+
 G2IBHE=
X-Received: by 2002:a17:90b:384c:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39e1e48a0c5mr12745289a91.16.1789637595003; 
 Thu, 17 Sep 2026 02:33:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 04/13] target/ppc: Use tcg_gen_goto_jc_tl
Date: Wed, 16 Sep 2026 23:32:58 -1000
Message-ID: <20260917093307.1092084-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Matt Turner <mattst88@gmail.com>

The only instance of mid-tb flags change occurs with spr_write_40x_dbcr0,
which already uses DISAS_EXIT_UPDATE.  Therefore we can always use
tcg_gen_goto_jc_tl in preference to tcg_gen_lookup_and_goto_ptr.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4ec..a99ab018b80 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2649,7 +2649,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
     }
 }
 
@@ -5164,7 +5164,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             pmu_count_insns(ctx);
         }
 
-        tcg_gen_lookup_and_goto_ptr();
+        tcg_gen_goto_jc_tl(cpu_nip);
         break;
 
     case DISAS_EXIT_UPDATE:
-- 
2.53.0


