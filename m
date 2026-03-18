Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A512310706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCy-0002Zm-88; Wed, 18 Mar 2026 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCg-00024D-CY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCd-0002UR-D0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so79030175e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829958; x=1774434758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r41gSn9IQzUi/B0YjBqSsas/EGTz5z1g/Cnn0SOFGP0=;
 b=k0aeAkX2TdTLuYkWSCYpoKBDL8LFT9BJ+tZ/WbRFTHC7x30N21o5rH9FZwmIbsbJUT
 SxU77ztn5AIXM2N/gEix+YHFiRiA73ikVauuf4nrx1HWHcQqj7nv6mYF28s1ZvIUxer2
 TB1MmeMKvzdPT81GEoBIPmNmo18CdBZ+PCO3uHqr9A/UerFt4BrOBEIpQxg/E7O3x/Ry
 aUbYS9lceQUq5+fxueO8f9BcQDtU7z0buRrPwTGqcaZUcJPFv9g/KceNb2Z4AGNdo7+F
 GS1hSt+iRSdiGY8wbof5HXCjFyaxHsJFRvrWjg/TNKQdWgPIDH0wh5QrIdhR1pFj9fy3
 4G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829958; x=1774434758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r41gSn9IQzUi/B0YjBqSsas/EGTz5z1g/Cnn0SOFGP0=;
 b=U+ytZ15FR4L9gDttpao8eV81UJQgD4zOb0KfVI3fLirhLE5u5jVGeXAygs9uEtUwyz
 JGD1FMlPTWfkJe9JohRtrCamizHi70VYyG3+rsfhOKvBeqn0btV73ucUYGv8gZgwjZIS
 st0qF/+/MgNnjan+ko2av9iEh3tJDFBhYAezdcga5Ii3gGWuCroFSK8VxrjRt1kqK1M+
 W7NiaVQvQ2pN48TPjh3dKo+Ntd3Fhb7Cx3spVmsNsBIQa2xbH0Vg6eSja43OH9mB5p7V
 ImiUttXCgEKFWZD+8UYGkgKpkt6rgoGnXIX1e9xxhwtDJRziUP5pEJ+CTnjsoW6yCibd
 hUsQ==
X-Gm-Message-State: AOJu0Yw/ds7GMRt9n4YSS7ahuF+tLHUR5bvE7UkojJP+yspHSkWSGkM0
 3mzwTeTF+bR34J3G2rZA977Y2Ezt2eQOeQMHbcz7gDZUHkERon3wsP7edVKTBuUyVavgNmfCRzw
 IrpiNjJg=
X-Gm-Gg: ATEYQzxBo20Jl4WbnHWr9wrWDDT49/skQEWrfarcyiTTJzlEkqmCzRiX8jtCm9ujhFl
 G7dTpAq5q8ZpfwNtA1buPvxlGIm3CWkp0wWwxmv+lPEuGbdke0EKwnmtWmW+ajhtSBndILDamDo
 2vy1sEWqys8pLGI5L8zEEW5WsgkphV4lqQPAkq9r/pnK9u0pJnMAPMh75tDRv6X+0U+A0Ihabk/
 1o1DJgsIMyt3LXt0MZ3WjynEFF1qJDu6/cj9zw8YooYKkhgYBZDpG7GSDo3fiONxqAIQqZUdS/l
 NNZm3bxDsBCoM63P8hBlh/w+vwqexa7YCNqBzSWU4mDIvlEyVsFnQ8NhXYuLnTwmJB4PFYKjUXg
 5X26LbjmPmIE9dEvQIHYTVogHaRsZdYlVxVVRnOLsIgfbhdIFd9E6pMzml6dFYxwf6TwIzF2Ixy
 yjlwYUCJM50NZFIp7bVEZ6DLZWPTFfcBghpNxCPj6ApHKbUCU2KONPkWqZVc9Aq/UlAmV5Vx6z8
 FBSg9l+z5Q=
X-Received: by 2002:a05:600c:8b09:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-486f420c141mr50647895e9.0.1773829957536; 
 Wed, 18 Mar 2026 03:32:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f421a6f2sm50883915e9.8.2026.03.18.03.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 10/16] target/riscv: Have gdbstub consider CPU
 endianness
Date: Wed, 18 Mar 2026 11:31:15 +0100
Message-ID: <20260318103122.97244-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Consider CPU endianness when accessing registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/gdbstub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index a5c12638782..2c6ccd4761c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -20,6 +20,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "cpu.h"
+#include "internals.h"
 
 struct TypeSize {
     const char *gdb_type;
@@ -49,7 +50,7 @@ static const struct TypeSize vec_lanes[] = {
 
 static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
 {
-    return ldn_p(mem_buf, regsz);
+    return (mo_endian_env(env) == MO_LE ? ldn_le_p : ldn_be_p)(mem_buf, regsz);
 }
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
-- 
2.53.0


