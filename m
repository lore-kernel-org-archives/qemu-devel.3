Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0580FC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9V7F-0007R4-J2; Wed, 23 Sep 2026 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7E-0007Ql-As
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:00 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9V7C-0005n4-Re
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:07:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso821112a91.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790201217; x=1790806017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=efWz7OdQaqAQdK5HW4y/FLS8uU0/npBVJT/aN6EFP1U=;
 b=u/kXTPd9wprhSWsacJeianNaa8RE+fYkIJIHnN9NwANOYPrVZjUpINwPbmUYMNq8KT
 Ydjz91LrFsgMy9GuGwIno+HrGpNfBBvM2OkqcFsi9skM1AUz7fsOQPIE+DTSp1yqHsZe
 F5enpZMIE2RnkQxKSkAo4OpEUMw9FI7k1XcL5BvQVvtcUzAsgUCm+hhXAb3UxifHXbxm
 3jG2qmPb+5v8WjLkCWrzh6Ogr9SB4E0z6n0l3k8yzFMFFZlSemvZ7xGs6afALSmih1Nr
 QQcHw7U4jiQYR/XrJyQ+ln6SYmGaSuObhEywLHlj5NxDb4u5sCZgP7gAkWbmgwLzPSCq
 hFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790201217; x=1790806017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=efWz7OdQaqAQdK5HW4y/FLS8uU0/npBVJT/aN6EFP1U=;
 b=mHe5UXy2BQ5kO5vwbicXC6JyvtN3/cCrHXz7ZH+jf4HR5DvlSeyrcSqw0WfFwbY/PW
 YP8bAVKltWSE0KURC/qyEC6NBSqJINxackorQvT85onzwk9vvltqc3j/G8YO6VulVOy1
 I2gqwjHqp3QWLmNFyWuOHLeI42mVgHVL+FWrEPhdkC96Y6PpbXdABOEUR4vNl/oZnF2G
 rSbkdz2sKiG/rY1pguIv5oTCyQqyOPzdVdXSfekcbGa+tHYKWgnITmfMYuDGtA3JRI8T
 j0P8VJYF0ytyq6Vox+Dy3Aeyn3OBcHbfFlQEfFDiEuhj4h+ZtZeLbB39jLH3g5dRCBfC
 iAqA==
X-Gm-Message-State: AFuF++lmpMw3O6FX64KPLHfvQCvBHvgAn/qzQLqha+FUqpy8XpUAO6/o
 KNc6Els8cRyw/9TDS9eCq9zFSXifajJSyD7gVdNQ2mqS8cB+beQkYIM5N1IPizLWWckQZjRBhXo
 8YrtQ
X-Gm-Gg: AYBFou0oMo+cIe4srj7ACXr8PVrrYsEQXTCfWP0VLwAobFx3y06ScuuoNRYkAX1pen4
 11vSNxJWd70TuWYBzBbuKOafX9u/Sn68JZXE7pqarUK0f6EH9DQhT7XPBUCbIk5oS7XnjdSvNAg
 d0hek+7Gz/sh+tcqvMKq7Rx88LY/7/ikjV3A4y3tOaQ1VfVkqkBLrzGNs6AwfzHoiNxRQs48dz9
 C8PuH1ARC149OwdYF3z/9TTdTl2uIzoASmJjS1fKGRoFOozMVXsOsrR7tUFDjefbamcuVK04irh
 34JacGxBVtnl7WvPSVTg8/8lKAXfkcKOJstK9zbJt2519wy+Pj/qmUxEQd5c4SParEt3E+pyFRV
 KzjwlSU76FrJTz350zijDaosGS7dpgEo9ohs9qoiujhcfeMbiEUPOLLguELbgHla5cMFjnsucet
 mluK+ZQ8rYbYJJAved2VCPLQuv0MTcY3EArzOglkwEkj14CD1A3chjmx4AX7IpZnrmAn+zHf8p1
 piAxFGnYEKCBc3LFOvyDSPhCbdYkQLYgE8JwZPr
X-Received: by 2002:a17:90b:52d0:b0:3a0:903b:f254 with SMTP id
 98e67ed59e1d1-3a0985e68a2mr385262a91.15.1790201217324; 
 Wed, 23 Sep 2026 15:06:57 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm998322a91.14.2026.09.23.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:06:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mpatocka@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH v4 1/3] accel/tcg: Set CF_NOIRQ during cpu_exec_step_atomic
Date: Wed, 23 Sep 2026 15:06:52 -0700
Message-ID: <20260923220654.127167-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923220654.127167-1-richard.henderson@linaro.org>
References: <20260923220654.127167-1-richard.henderson@linaro.org>
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

Do not go through the effort of grabbing the exclusive lock
only to check for interrupts and exit without making progress.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5226cfb7650..f4428e9f7b7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -566,7 +566,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
         /* Execute in a serial context. */
         s.cflags &= ~CF_PARALLEL;
         /* After 1 insn, return and release the exclusive lock. */
-        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | 1;
+        s.cflags |= CF_NO_GOTO_TB | CF_NO_GOTO_PTR | CF_NOIRQ | 1;
+
         /*
          * No need to check_for_breakpoints here.
          * We only arrive in cpu_exec_step_atomic after beginning execution
-- 
2.53.0


