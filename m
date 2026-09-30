Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D898CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSc-0001H4-G2; Wed, 30 Sep 2026 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSN-0001B8-17
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSJ-00032G-D1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:58 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso19250015e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786814; x=1791391614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CEFp7XX1dfXwIuTHCKy/MJbItswATiq1wqpkbYK/vlI=;
 b=ptDy/5ER2dVqbbS/l3qSI0k3VOWEfq2I9Vf7McuCvHM5menX6kmJaoXmGlGYhQIaLY
 t88qAJL11PyTPUvEmlt2Z9A0OtmGyO1h+OydoLpi4aFkw3stHwvhHbIRqKStDB6d+ond
 lE2m8GeAjPYd52rNHopfQq37KOYlMUmg1VIWU1vj7vrdKwzDr2DlPo0kk7HBghUlHLJO
 e+hbAGVLOeWCPSeAvZxU13BXtQ0Fr0LsBt80J6d6dfoKGpVHfHZHdMHcWEPq64/R2Wdx
 jJ6LwRrYLmipdrBjO0/rH8iO4Hyof2KaqKfd8XY2P/SGXONZWVKKSSaboHcWfVaCOAqd
 uznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786814; x=1791391614;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CEFp7XX1dfXwIuTHCKy/MJbItswATiq1wqpkbYK/vlI=;
 b=o5332a6fHnTnuR9Zed2WovGEmzBALC1i66mKKKA3XxWKPZ9NY9wB9aNsaf36sIck0e
 tFGG6a7YrxXPee7k6e8lQxr90gemXM+6kD7K3M2e1RXBRqNv60KphGiDUBqiGcHGdvZB
 TDRnxI//XZnvR32ptI0Fo/1EwtN5GjHkYZYAxuipHAF6pzS3wY2TU1VEW3Ovbi8oco8/
 vJ714F7no1mZ29vfGRSQCjkm0jZ1L8HiarWJ6ue4jPZzrDFc2OrekPp/5WeEcBU90BP+
 VJNiQkAt/PYyo2yHLwhrbFKsap3Igiv0u1Ey+63f5kTU3MljlBILyBRFByD9qE14T9sX
 7TmQ==
X-Gm-Message-State: AFuF++nRjLDITUlxRyg/48srQegBnlHIlWF03mY+ypWoPDb4dXvAqo0Y
 FtoPQFK0k4C4Vf1SCBRAKmcDSMZxKDBrq0Zy/Uh9BTKHZYJLQbBr1VNUu8x0RlI03Js=
X-Gm-Gg: AYBFou3If+XEnpUNX+0VW/Z5yxrdutTozHwEfBmj0xKhyPHEtly3uzudiRRDVH3d3fr
 hSrJCWx47PgY/6VHeiisF2Xo8Je5t9LKQwnSTLGwOEln800a94Bbe9sifG2TqFdCfW79Gbf4HJh
 cGzRInT1fnvnV5q9W9of2yf6RTV8Bx5CLV1BZ5Z1j3mmxuVrLK16qNSzpCFq94gT6GhygBqB9rn
 10RgXYNooFEM63YLFBDiBoPe8XwQl5/mlSMNUQ+WkgXvkZGrjoB2QOnip6ia3kWFLS3M402RYjW
 lvtHM2hJOgZjB9ZP9PTJiEaR30cmOMGegazcopr6u48MCjSETPQjf3jszG5OoFtFKOnj4iWRShK
 u8Zpsx59kJ9xHg3ETvMYBLz23l/oZ8iBGA9XyLv5E5K4RuRrue+uSSgYH4OluhgYHvHcH/XbLTT
 NPItut0Pm3m7x2vofNf0tnd/R3R8ceLb3b0kNn3Ci8QvoxlxfseuSsePxNnZqMUaXsYFHtlQ==
X-Received: by 2002:a05:600c:4e41:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-4a01ad901d4mr36480965e9.2.1790786813951; 
 Wed, 30 Sep 2026 09:46:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb834e6sm2972965e9.13.2026.09.30.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 090F85F91F;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/13] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
Date: Wed, 30 Sep 2026 17:46:39 +0100
Message-ID: <20260930164649.433573-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

From: Max Filippov <jcmvbkbc@gmail.com>

Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
which matches the way it's used to store `argc + 2` pointers.

This fixes the test for me, which otherwise fails on xtensa with the
following message

  linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 6f58b090328 ("tests/tcg: Add SIGRTMIN/SIGRTMAX test")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
index a7059aacd9c..b5ea65f3d39 100644
--- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
+++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
@@ -39,7 +39,7 @@ int main(int argc, char **argv)
     assert(qemu);
 
     if (!getenv("QEMU_RTSIG_MAP")) {
-        char **new_argv = malloc((argc + 2) + sizeof(char *));
+        char **new_argv = malloc((argc + 2) * sizeof(char *));
         int tsig1, hsig1, count1, tsig2, hsig2, count2;
         char rt_sigmap[64];
 
-- 
2.47.3


