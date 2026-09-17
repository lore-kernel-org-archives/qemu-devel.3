Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35FC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JW-0002hy-7J; Thu, 17 Sep 2026 04:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JE-0002f1-9H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:34 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JC-0001ua-FE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:31 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so529078fac.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633048; x=1790237848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+FJ8ECzFNYuHt/JBtyS79GidxuE+FcDdJ/qumjqcd9Q=;
 b=kux5ZKnguiQAFXifUbM1ACCneRRj9JcPAIHGg9aSuLAM6PVLZO4DxsW5iqWFtuuDNz
 pf2AscXxWm29QKMcCkYImWgQpeJqLljoZNOgAtHtWY11L1mEbn9Hl+SBL4b0DPVyCoSD
 eGI72qVMJ38ZUjCwrF7jMTvBs+7pzi/lLT7pkhsZAoTzaOwd5NWAWoBmOYoPFO/DBV80
 J/M8+QEQW+MZ0k0/+2lWENGVebhDZTzMPrquR6CFdJmyVNIYNYlH2Jc2KU4ZPfmpkp9H
 vrTSlFdEYphrsyQeCXzFzHDJyH1/E2tsGu0+VytG+roil/dGdCYo36GrRxk0ktv72lp2
 LjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633048; x=1790237848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+FJ8ECzFNYuHt/JBtyS79GidxuE+FcDdJ/qumjqcd9Q=;
 b=NTpkdr1yofQgbU0/hK3tTulyKALglNgbkNHRzGZhhkFhTED+v30n12jPp676kO1zNM
 biibLy9zyNn8c8HozzotkWiHzRicqlBKsrk2Fc3prr1QvQTZiWNJozkDM/ljI6xEZwI6
 h8Pf+el8utGHH2t1OUOeF0t0Boc+ex671vxbzPPT9UYU7Jyp10A/EY9yDlq8JObBpWa/
 pAcopktmN0p1fqD0Ag2M32XWLcF6C+fvlxeb+v+5FWtLUSMYRrHzocrXw1adOFVStvKz
 EkMpiQ24rWLecSlfPbMCRA72TQsglfqp+UU+pfZwjmHLUjtF4B9DiYXIdeDz3szlAgz/
 ehAg==
X-Gm-Message-State: AFuF++lL5ZWHbGoAK2LsNIf+i+LmlDZ3s0+25wkesHna4qGWRRBEF60k
 bxLAJKeKYiAUqb/FhXCo7d6wgktU6+BmE1iLxwZLlJ7EmjkYjyJuMKWXA39GikE3vKoZeU3Axkc
 HvR41apU=
X-Gm-Gg: AYBFou2zN42BF6OgrB+ujofPjEZPqaAEQGOpJFhvlpx2pYWNVtZS16TDfNSH/mHvl26
 XPRJ2UPbAehanV1IpqeXSLdQ/Gzs33sRzWPZe7k4rQrsN5UP+Tnr8CIKXoGA7WV9tRH8rnBRZfQ
 ZcWRvFqix155DDEpDyIPBwUYn9Y9tVNTfs4TNe17UMmrLo1hpaHzZf/A2EoUiK0gqH0lazmUtk9
 K3hjLLm1QDiJDNvcj1s3zfHTNp5VLe0jLg4cl+EZ3B9+s1yJ7TL3+WDDeLJexOahdxcYQJD1zwf
 LLeBnhYAEvN6EmzwAzLtcL7oZNRidXGWgGQCgm+kGIirkEG9TPf8wuk6MXD4ZZv+42XJNLgLEfK
 m/YrXG36ZDCWVO9BqWEc4wgbEBCOBL4hfRWs/AZGu7+5sNgp2SijcCknz7oKvuic9+Rm/bn+tr+
 xQ5QFM+qrxkRCNq4EaZR4WqmXm5t12tzxVNv2N1JzVv8KW69iHNIHJpImqa6/eM8P8FycHD1gpF
 QAtarGm
X-Received: by 2002:a05:6820:4b94:b0:6a1:7790:258e with SMTP id
 006d021491bc7-6c7d1fcb286mr5613099eaf.18.1789633047786; 
 Thu, 17 Sep 2026 01:17:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/16] target/s390x: Use tcg_gen_lea_i64 in get_address
Date: Wed, 16 Sep 2026 22:17:08 -1000
Message-ID: <20260917081716.946668-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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

While there's no actual shift, use the compound function
to add two registers and an immediate in one step.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1b6023168bb..4eb2eba5e45 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -460,8 +460,8 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
      * displacements early we create larger immediate addends.
      */
     if (b2 && x2) {
-        tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
-        gen_addi_and_wrap_i64(s, tmp, tmp, d2);
+        tcg_gen_lea_i64(tmp, regs[b2], regs[x2], 0, d2);
+        gen_addi_and_wrap_i64(s, tmp, tmp, 0);
     } else if (b2) {
         gen_addi_and_wrap_i64(s, tmp, regs[b2], d2);
     } else if (x2) {
-- 
2.53.0


