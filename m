Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530BC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJK-0006Ah-88; Fri, 04 Sep 2026 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-00067M-Ml
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ4-0006me-Td
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so7244615e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525967; x=1789130767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IUEaeTGNoZY11hlRxJYUly0+6nx1hoAKKSVuE4qdgRA=;
 b=W1YmmbH4Es7jYCcUwrjSHdietdTior98ZubU+AqMwa+D9E4O1zy3B6SpOi5PG39htn
 R7VpU3TDSaGtpU7gAiI17pE+XSJlvMVa5Q2whl80Z48MMiB/itw9CWXd8JVqEOeS5b1w
 BeBViPKvxgpT451P6l56bOJa037iog6SL6dKSJ6ajAirVIdKBSk3R3ur2z76QAGscoW8
 /s4W+JoRRxy3Ymu4Fyt+VAFn9cbjBcS1kCuP2d4QbNdcpQvRfUrNpqQa0JxYnJRGTpI2
 xWDXf2lkPc5bbB0xrK77Y3Vc/79IgIElWe6Y54gC2Gajr1uR4ckCJveP3dug0USs9R4X
 5dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525967; x=1789130767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUEaeTGNoZY11hlRxJYUly0+6nx1hoAKKSVuE4qdgRA=;
 b=FBt8PBA1huBDg2tJ1n0CL25obPSu8eFr+eUzac78EBCPcE38G//xZo3vbhRNYR7gCE
 HcN/vpBmkzHW8mh5ZRuvZxUQy6NvIFXrEUA63S3hdDPstE0EBq0AL/jtpb0Low87s1O3
 rsuUqgNMpVzD/UI4CHdbsOB9tN34zJQul1m8sZGYQckz04Emhk+CqxI0JeS/7qGM0ilU
 9pbxfpVcAGawHV9Xu96iYikkI0nFV094v2ULaj9V6sk/Z+xVIBr+q/7ZRL1XHoWCIOM0
 ss93cRQ1t697yXk40XgxgWfIxPbMg0Iq5G47cE1uDYS2bYwQA5KpVANqRMnR/nR1o+tl
 KBqA==
X-Gm-Message-State: AFuF++k/wxPIqCdFSM4TNvbg0FN2cFYzGJNS/wmxAyPi+3O3aAaFWJSf
 kXY0v3RIyTYTl4jsBH8VDowqPmgVe0VDSKXfKmquKenHJoRC/eLpiWBlP0Fjac5Kud4=
X-Gm-Gg: AYBFou3SoHqUYmovAnFV5YkcDVYPZS0aAD7iQ2Sqvzi+Y3td09uCjmT+LbWphCKfjGR
 Oi1Al05tYm349Lj8uNW/bOJDsI1zBr/yi9McrJPfAmfXz+rESbtY+qGp6khWOnqQ1kqS8k0sRYr
 0NL2ft394JpJmx8O+HWID2i1juSd7RDenQi2sg7cQu/GTW44Xul8anX3QKFEVug/lZgxuAftHMa
 ML3AMJ6aqk6bFacUj3ueu7QRovdHg5dPHBwitO6IA1HCeV3Vystt2ruNu4/bM45oLPzx6NVzynW
 KsNmpElkuhOhroq3Vj05xNLnn5rlUkypTTAx3QlrR6qLsIQ6Cabq7eq+x+C9Hc2Yr7F055TmOV4
 p3Gheq1DGX+gGMiKAWAV2rUKi6SH3jL3rLfA7fuHg1PPcnZA6lo6CvCbGSop9CSu75lfUB49Ut9
 GT5q4CECno0alE+DPBqX6wTuZmSuSJUM4iyDyopwvB0n9L4EXkuzo8PaBZP3m+
X-Received: by 2002:a05:600d:17:b0:49c:f2cf:ef8 with SMTP id
 5b1f17b1804b1-49cf2cf1126mr100214265e9.0.1788525966372; 
 Fri, 04 Sep 2026 05:46:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm997002f8f.9.2026.09.04.05.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B0D4F5FBD6;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 003/105] tests/tcg/multiarch/plugin: rename check-plugin-output
 to regex-compare
Date: Fri,  4 Sep 2026 13:44:17 +0100
Message-ID: <20260904124604.2207440-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-4-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 9bcbbb11286..35050acedc9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,7 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.47.3


