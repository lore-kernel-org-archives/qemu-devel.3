Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E1C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tat-0007qB-UO; Fri, 04 Sep 2026 09:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaD-0006Ww-Ph
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta1-0003AR-Ax
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so12967905e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527019; x=1789131819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpGA00LHAx7mqshzCYu/5IuI4ycciE8GHRdYr4paHDg=;
 b=sPS4v43IkTaiXIe/+1+9yIa9YN2JVd1zsVe9peJMN1W+FqbQmmm2uODMW59EdcDp35
 RKLc17zI+8bKCqFM4950h0XdEIYFwqJ4OEtdO8NTDqHfAOr3ESaUDEpODJrx90gekFcn
 b8PgieknOAC71sm+F8AaPH2q8rRM93ctk6hcHZdHmij7tVxUgV26GCHxbj80CgN7riIk
 ytWRvtMqYvAStU4oyF4OukPX4dlnxrQJP+VTZcST6bIRtF1RIQAPlqMNa/a5jbetvobV
 KFprNEvGlJ6j2sOrxQX2A8mOTgZA40MYkDN1BOQbpAqT3IdvcqQxhHReRa8+ANyT+KVc
 76XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527019; x=1789131819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpGA00LHAx7mqshzCYu/5IuI4ycciE8GHRdYr4paHDg=;
 b=SVOIFDeOGKE+oFY6r2NO0yp6ZhPAGGjhCHAQQ5wkwPHFm8bADL+4ocNWdAHyLIExEj
 G8dEgt++QwpNkTzU3/RPUghJiPbHnoKv3IQC/znkPeRqQCggvBSFn07OOgTrjEgzICwB
 hQJx1skCYfIEB+po/i84UBJMDakOuknXjdj1UCZkFABbenimPekT/aM7rCA6LgbDqhF3
 8cb7GEXhsHbaxPAvUKu+T1AWUVOSp6SPFOX5SHY08/6qoatTQhTz+SuZkPKBiJFr8rTx
 5FCEbzcp87uEUrLqroIvzvo+BFQLQtH1irU7JoZ114Xh9G8rPlyUxkSFTzQhgfWaBO3t
 lqog==
X-Gm-Message-State: AFuF++nsy58a/knbsKN7QxJd9WM6CTXf7GmZCdXzRk5IPZsMkC2f+HOq
 JKHvvRk1TBjy9xKjjz6IA08yrlulBUml3FuvxXQS892zz+Hme2jXIT/TlvU5Vn0HCR8=
X-Gm-Gg: AYBFou0nRYo2hqAYekwSYHphJU6QvtQMXD3+kF7ZhM9KY5S0i8/9CNXYA8paPX6yTX2
 JJ1h55a/WAfOuLtRQqh59iGYxsjol900x/EhuBhkiaiZqOoveO7ryIuRcFT9diXS3SKkjGRtoJJ
 PBUmXdkDgwyfD7mMBwZ+g8SlGQ8KYkGWY8DojV88dsk2AqhhojWj24JePrDy72LG5ojd3RNLp/M
 NZ/OSATdkImjrk8fRYuhKkBeoCOTlnK8kCvW7pAvezLmudZ/GfRBDQ3LZRY53YICfe46jrf5Gqe
 0+Jr4vyU/Fw6uA2nEtqtkTxQBnL5DV4InRGSzCK8uJDvuib+U/9RzDA/bv327GwDi6dHgDjdjKf
 /n5HpO/+Jov1uoSAos0C9TvTY3AVdWaGBo43Ds4+xFS35BLeP03CibzCHHnawNquLDuw3T6gBG+
 4R3cXDQF16cRt+ErVL8SBryt9IJjwcQiLXmIcD0MIqtzxk9Ril9EjtlJ0egNlF
X-Received: by 2002:a05:600c:3511:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49cfa211cd7mr41666185e9.27.1788527017598; 
 Fri, 04 Sep 2026 06:03:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm94700535e9.5.2026.09.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBDD86170E;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 026/105] tests/docker/docker.py: return error code if probe
 fails
Date: Fri,  4 Sep 2026 13:44:40 +0100
Message-ID: <20260904124604.2207440-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We are not necessarily interested to know which engine is available.
However, parsing "no" as an answer is not intuitive, compared to
read an exit code.

Thus, exit with 1 if no engine is available.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-27-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d2f39b5645b..fea6d0f85af 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -604,6 +604,7 @@ def run(self, args, argv):
             print(" ".join(docker._command))
         except Exception:
             print("no")
+            return 1
 
         return
 
-- 
2.47.3


