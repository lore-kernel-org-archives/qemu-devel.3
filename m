Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF2BC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdu-0005zG-5Q; Tue, 21 Jan 2025 06:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdr-0005sI-Cr
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdk-0003Su-5S
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso39753585e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459709; x=1738064509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKO/X1IO97t8jG/iIr5dS6mXwUKP9YiNx8QxL9MbrbA=;
 b=mv7Ew0+1zn6sgpGDe8hH7tsfmrArrw8vfYhUwUt9G9tbBQccn+h3bZnIlnGWMUdp8N
 tbL9a3CRJXhFKE7o9vtsiGIjxIyur32sEe/vpoa9C10lRzSZ2fyTf4q6l3+T21hRommT
 xOQbsy53MiICeuAmxepsmm5xn/Ghqr4ySXrqLYMtp2j/ce/igmxdsbIz6FaTqiRT3gei
 ya8PRkY987XkIyQdjPa5W/be64Yej/1m7ahaeANEmPlDaoDxIWwp4UnStVvbg+aa+DZH
 cqUHvh+dxlaCegVq1/KoIlNcR00RVZbUQZz7bZMkmeu2k+U5/otl7Pptpa6CqdaAHI5A
 FVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459709; x=1738064509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKO/X1IO97t8jG/iIr5dS6mXwUKP9YiNx8QxL9MbrbA=;
 b=l13eeCtixFMbx7zsrL9QOKPeNuRBnRH6dBwtIhaVdxUNupvGahkkg+lZDBssBIzDVw
 s5R9pnjyctRySzp39SlvtfsGJNV8uXm/+3dw+kkrO5B06wQedw+h6OHpFQCVQlB+JShr
 TF2eLFmihyTGaBNzQ38+2UKmbC1doPQPMR/nxhxYhKNR3AXTisiPhN/9xON95K2WRKi7
 tvtOtD5v01Qz2NDJ2/K3wuMz8rR4HEO2+wXgNFDgfVdKJ1xo5N+1cXgze18uMgWO3lbW
 S5FRg1S4dLWjZRCbEDN8nU+3SXb0o64abOtqab8WUcT01YoDPVc1uQ2BXMXqzoG+yhm7
 UXUg==
X-Gm-Message-State: AOJu0YzQig0wXWBgrv9F8ZUsywyFBAxeCLNjOU/T8LiZNS68+NXksqzm
 hEpSkxHqC45Y8kgeVynGRP6UD18XVc1prZjQZSjAKuj3oMcotQOcwDof7kHXFwWHOnHq7k1p+/x
 dcHA=
X-Gm-Gg: ASbGncuQ8vPzqLc0jOPiYyDhteIzefnjcM2NtNZYwpA4xxXGpwV3jwtGNwK+1pSHz4S
 IjqzFIW/yUBAGZyEFJQ6t5+1KIhfftajMzy73mGAuQuMStrYoxA7rqZQpy8sNhSEizKQWnpRbxg
 rUjM3tq51V8pnjXVQMoUxKcbfY3wcn+aC6V0FoZq8OOfnsXPnmq8j3t2PshcLiNDXy3mCiD4vmF
 04a9ewXmfqUCug7oTQk2mDw2lVhcT2KXe2g4P0RGZA6+x5GXkx3lIEBIaW69SIUy4upyB51KkSW
 BwsdzfwvIQ9oy3su03kD8c6XdRfSr1YnVptvdGj6jpoU
X-Google-Smtp-Source: AGHT+IEF6r/BOM15SlwCgbDLBO7CnzXyrWtA2PXkV9Mzb5yTQDnNfIiv2ZYAH4Cn6iQ5ZwFQlubQ1A==
X-Received: by 2002:a5d:64a3:0:b0:38a:624b:d55e with SMTP id
 ffacd0b85a97d-38bf57a684fmr18798886f8f.41.1737459708732; 
 Tue, 21 Jan 2025 03:41:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a859sm12903513f8f.43.2025.01.21.03.41.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/11] target/openrisc: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:56 +0100
Message-ID: <20250121114056.53949-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/gdbstub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index c2a77d5d4d5..7b6a31fc97d 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -47,11 +47,10 @@ int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int openrisc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUOpenRISCState *env = cpu_env(cs);
     uint32_t tmp;
 
-    if (n > cc->gdb_num_core_regs) {
+    if (n > cs->cc->gdb_num_core_regs) {
         return 0;
     }
 
-- 
2.47.1


