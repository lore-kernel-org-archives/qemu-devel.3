Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200E3C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6PK-0003vK-Uz; Tue, 25 Mar 2025 11:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PK-0003vC-7R
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PH-0004AH-Tg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43948021a45so50084295e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917294; x=1743522094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43G6xaQEasg9QNPZtMYOEGymQHF1cxnYCa0rqpPVw3M=;
 b=PCWXh4dewFoveyQZZ9VkhTZ4gUrbCUUk07sdvjHVh+oaM4hYDYrP9+TisISxd6/03g
 tau4gRUb4NsxNdJMPBJjidYcXxc29t/aqJefo8ay8ntFIj9isYC/BtQU6x2aocs0/L7M
 dJItqvfpvg9M2I00P+O3oEp87YRcwQwTVhrnw7oDYb4gKRtPJhUuiOBvwC+Yo2m/ICA+
 nD2Q/+0hQH969w3ZRfld66n8o2ZVOyZlt+WNmngBp1ckS95EtqXqIJ/p0dveNK3M2d6P
 YY0WoilNqo+B29wFICrXIijI8xC7LQ/ZEIQfTpgeL/h2aCaQ9HKohdP3UHmiFVDNqSVs
 rS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917294; x=1743522094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43G6xaQEasg9QNPZtMYOEGymQHF1cxnYCa0rqpPVw3M=;
 b=kR1z/M5H2HjmLZq2uyXgdYWIL+Sego884VKB+TOF6CIbPlHKDzHsLm8astUKbvLMV5
 Voi7siO4LqKObJOU/78CbSPsUdUgmdBs4ml7YXZ0vXW6sRfRYc81TbEzW/85xZ9XjNUi
 gF5VWfD0onKa2vAkloVTU6CwroUN2deAuSsjrkszxgPkZrvzueMSFm2xcruq4s/jypYY
 w3IQxL4CInVRRQlxq+JB4B5EqJidzH+N9gsViN1HeXmjf0qOuDpIkMGl3ZCoN2JZ873Y
 MWQaxjtdgBiWVdj9fj0EgRR6q5jVppkgZ9MpizyD9RpMBimyll5D++u0R2ppf8g1i4N9
 ESqw==
X-Gm-Message-State: AOJu0YzVDAoHjoEM58k85cyI0eymaJ5N+tlvI1bGULhLN1VqwYOiUaim
 yZ8qxUsP+84XR4cfWAqeS5pFGZY6/L5hgoUU2GfKZUsC1ra7M3GBpt3gQckNrJ/R5GZ4Nj8rjt8
 U
X-Gm-Gg: ASbGnctuY7YNoY+Auwey9RE399rHXeEjg67GrI/WDSdqAcD/ysckeZ4XlDHGjPQEpEI
 c1E9H1bi3f1pm8nFV2o2QtHc1OA7uONwpG8i5LX+BSn/lpFIdZafoipp9ccleiLFWXL50YQYl87
 MSSXzdiVZYKHSc1Ff76eLy/WslutCpSC65CYQLWqB7SNF7B8k2l9PuKycLUFnFytz91eCqkTXMC
 diyKiNdiW5yFoCgn5Vc09IBJNmVqRnCERtQRxElx9ugJH2rY7h2BGWCGzqoxF9HmKMbfeFta3Ji
 5O2UYmS3N8+O5pVcFPDyeZlFDKDe8+UHQwsheBy8UP7q67uNw20Xaip1oLWuGAI7bA+KNR4qsYD
 p/j59+BcZKE3wsavYO1U=
X-Google-Smtp-Source: AGHT+IEv/no7EQQ27qMSrJSowSSNlar+A0XV6+rr/4VRZfQHIVT3VCLUqd9YdVHs+1WLkyXEFMhw+g==
X-Received: by 2002:a05:6000:418a:b0:391:3fa7:bf77 with SMTP id
 ffacd0b85a97d-3997f9148eemr10819618f8f.31.1742917294073; 
 Tue, 25 Mar 2025 08:41:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc9bsm13813579f8f.87.2025.03.25.08.41.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 7/8] target/mips: Get CPU register size using
 mips_cpu_is_64bit()
Date: Tue, 25 Mar 2025 16:40:57 +0100
Message-ID: <20250325154058.92735-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

CPU registers size is static and depends on the type of CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/gdbstub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index b9fc667373e..84fd3de4137 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -75,11 +75,16 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     return 0;
 }
 
+static size_t mips_regsize(MIPSCPU *cpu)
+{
+    return mips_cpu_is_64bit(cpu) ? sizeof(uint64_t) : sizeof(uint32_t);
+}
+
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUMIPSState *env = cpu_env(cs);
     target_ulong tmp;
-    size_t regsize = sizeof(tmp);
+    size_t regsize = mips_regsize(MIPS_CPU(cs));
 
     tmp = ldn_p(mem_buf, regsize);
 
-- 
2.47.1


