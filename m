Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D60CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy8o-0003NZ-8V; Fri, 29 May 2026 10:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy8m-0003LJ-O0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:24:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy8l-0002HF-8A
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:24:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so61733965e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064685; x=1780669485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VZ/i6ZvNqvmU5zUZzrSJBDpAWD/Cx5iX+bh+R6LBuQ=;
 b=L9SlzBVX8aKnsFIlnFuQZVlCw3z9qTzXlRcJn1v+fWYxZgoqGikHAX02gpnqbgqHaj
 nlkeqL9I55IWTtLQkPvZZ2HjAT4WVEO0u4oRKTdrRMZYA7T75gBbUh2ndPEYiJze9TGR
 fqwF0W04z0hhuOxnmwcZH+zs/t5bgy74A5EAnigaxY23L/1mx0HNnXiSwkx3nHVDdepe
 NCBU60k1xBViVs4i523O3cBtE8QN01hvwq3BKfr7Z8qeb151smOmivvCiZwF9xVqYScN
 NuSZN5SuSzFms/JRfZBxe4Vg3McF+QWB2ZvJi1raK7GGpsbqR3eoQFSJZkTLf0G29LsI
 899g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064686; x=1780669486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6VZ/i6ZvNqvmU5zUZzrSJBDpAWD/Cx5iX+bh+R6LBuQ=;
 b=MlEauCRkYvKeuRLMwnf9qO+mx+8gmFtrCa18ZtsR+MCWJ6Ew63RH7nIUzIVUl1lr1Y
 3UM8GmHj0I/+ZDlTvoMmRVLgAt2oP+hW4czxXkI6a/Yb1dWg3x9RAaRMerLnP78UE0Jn
 aOK/uQX6Y+TgbG2LL3ZYThXiz2emtYxlTT/rEkLVShC4SHW2s696IYrSjVam6TLLQ+ac
 G0lqyogJRKMffJrhpE4sm4Z1z10seYumkj+UrI4nxxm4hYrhfoyYpvxV0b7jEaqkyU1/
 3Z9XimHR3X8lKYkA22MU2/10xQcpbjItTig2CzAPXgKS19fCKmMT6bVI2IX+Xpgt0EOF
 B6+g==
X-Gm-Message-State: AOJu0Yxs4qRV213Q474+DsL2g8vBw0I/iKFqCJdtXQ+EHzhHPbDiwDeC
 q3zMirNfcxX4zzSNN8wLbEDFJ0L2MV86JDDo5siYmEGXeYl76XlONbRPK5mwkEnIu0Ub4is9gtr
 G6xCHsOaziQ==
X-Gm-Gg: Acq92OEbb5N7J1BA/0cEuteixjWrnpx++0ThEZqntx97BOi2jD2OmuutP31B4d2J2A7
 GkVkBnC6iPD8DPLxRofDYSKLjzey7IWVb0R/AW9Tqi8NUgboK57xnlETZtjEuq87UfCTwsj2LbW
 xDya1Hk0ndBiQqnV//yhr7Nf9EaeEbBFbW3YCb3KnmYsEzBaxCj3d5D77j1oj8z0M5An3lK9f3j
 oOJuOj3Kd07j9xGQsnceQkbw6oguGSs9+vrX61s8v2XBwHZiaintZndGSFCzih7wrS1E6M6OeZS
 Z/Qp0dcmGNLRtKtYW226GdfJUllktolp8cIATTYecqoWSfiVc6uQ9YFVbeazG0kdb67Vni5hNgu
 Goy1idNR2xSfRQmC8a5taGwd1UtLLbeKzj1ehQP1C6m6NBwqqHprdklmYu4nO3haAKzSjBNd00F
 fd6/O3U8MJ/YLdJg44/R+EpCjyRRrA9lhs0za7v7QREnSpEsNKl0pvPgBOC1W4Uk9eIQ==
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-4909c0bb2e7mr47068875e9.27.1780064685579; 
 Fri, 29 May 2026 07:24:45 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909caa7e17sm52805175e9.9.2026.05.29.07.24.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:24:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/17] target/loongarch: Remove unused
 'accel/accel-cpu-target.h' header
Date: Fri, 29 May 2026 16:24:17 +0200
Message-ID: <20260529142434.87880-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

"accel/accel-cpu-target.h" is to register accelerator target
specific hooks via TypeInfo::ACCEL_CPU_NAME(), which LoongArch
TCG frontend does not. Remove as unused header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 31d3db6e8e1..2bb1feaa66f 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -9,7 +9,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/plugin.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
-- 
2.53.0


