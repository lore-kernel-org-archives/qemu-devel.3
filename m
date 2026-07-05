Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07A0C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdt-0008O4-Ub; Sun, 05 Jul 2026 00:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcM-000582-Nl
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc2-0004I8-JF
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cad8076b01so24097735ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226269; x=1783831069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgdeNV+kSDtwWzzSUG7k6o21nzzJqi9iKyuHEyE17qI=;
 b=Nhnt3moBKGl9Biusc2l6zMQqGogOZDw681FOZ9fZxVu0svtf9RUyP5OkeWg842CM2Y
 AHqFubYUHM2uH79FmTO1PWQ2DV4uOmZpWpduZJiRcrd340RUZbQC7OKs51xoZOQ9lBC9
 +xJvqm/yHH3kAbqcvHu00fK0YnzLT4oKM8ROhXLtYk2DoUfZ5Mtj+Fiocc9nTrj8P0Q6
 yS17b/gCpYkWciqDVrx9g78jijPGbAYBG0haVgDdVgFOaKvxGksFYfLa8BpxPdtlmldd
 gwU70yOEp56AzYAG22lBe+hauNYruEPyDQRejXRykWcb8DdSWj6wyr14tNEY3aXl5bKe
 0KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226269; x=1783831069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FgdeNV+kSDtwWzzSUG7k6o21nzzJqi9iKyuHEyE17qI=;
 b=aqniHjqo2Ud6V+MMIDXUAEN2xt2c/38qeWKILOdZ1MChYbOT6nMlcxawJspKkB8wH8
 6TRo7MYWiBkd/SnHP9I2nebRtNJJRNlv/qDJqXPVDovsdI1ekyXOx5554mzppFwp0RVH
 F3ofkE7oM6sPV3qVo+OL6MwOwrCWOmizF4IGQyoYesrSOHxPsn+ZNXFCbw4SC1iawhXd
 uQ38BKoS2q74mPVs3UeraZBiXrhImoRrZTPG5VewNjFpNDfAqKyy7z7NPtxQdlALytrM
 AD62khIAK1o1decsfBBDSrxPSkF7WEr97xQ9bozDsOZNFJip2MB5wTvqkARr/pN6iUSo
 7KNw==
X-Gm-Message-State: AOJu0Yz8MExBXs4I7Mlc9xKq3PaZySfFsO6+tUpwaLB+Q2isK55XpPRN
 brEiPauaZTCGmRphp2KghNtp/QVwKPzlisnVJB4oS8IrT7NZQVpG4j8iUIRvCBXnm1C4gJUhIrj
 Z9kWc
X-Gm-Gg: AfdE7clmGxUpzI/GsHF5cqXuIyrBAY536izwiG3bqTdLTeoxpzz6lVQFpLjqRjhGiGU
 WRqaVcod9GmfNvttBj0CbZEMTFZ1Pe7gCuLVPzI52SPZgAtw0avb7a90c6G5g273/Ljpo92M9qj
 WJGQ6ryFjLE68UoScN6aU41I0VDdE6c674GoqKaAKkRIBeMBiVJi0VTq61Hkh9v50CKv16h5HMw
 vcWR+soEr6I9sB954y5pxn5QFpHpDNaoK4QuwmQ8UCcxEDIo0XjrCR9RYvUPsrX4bXTFh4/7cTv
 IYO1pD39M1as24Ug1JqJhECeWzOk4P27Z0PM+4lp1GAg3LjvbvlPak8Fe3klJAXOgo9ijnz79kZ
 LR7qmYXFdTpgQ2uGt9gvG0bNHZ6hLdnLI9Kg9KBADxVMtsieY96OtvvoF8clgdKtBPKWIRtlo0t
 3pTfcMfxHwEz9lk3MlJVGPC+16MxzR2++99poKHd2Zmnohc4s=
X-Received: by 2002:a17:903:3bcb:b0:2ca:e08e:9e70 with SMTP id
 d9443c01a7336-2cbb9f479a9mr54297515ad.46.1783226269175; 
 Sat, 04 Jul 2026 21:37:49 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 26/46] system: Validate flags in cpu_watchpoint_insert
Date: Sat,  4 Jul 2026 21:37:05 -0700
Message-ID: <20260705043725.1373137-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Flags must watch reads, writes, or both.
Flags must specify GDB or CPU but not both.
Flags must not contain extraneous bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/watchpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/watchpoint.c b/system/watchpoint.c
index 183b194403..fbaebba7cf 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -33,6 +33,9 @@ CPUWatchpoint *cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
 
     assert(len != 0);
     assert(last >= addr);
+    assert(flags & BP_MEM_ACCESS);
+    assert(ctpop32(flags & BP_ANY) == 1);
+    assert(!(flags & ~(BP_ANY | BP_MEM_ACCESS | BP_STOP_BEFORE_ACCESS)));
 
     wp = g_new0(CPUWatchpoint, 1);
 
-- 
2.43.0


