Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E86F8D778
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSxq-0008Nz-It; Thu, 16 Apr 2026 16:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxk-0008MB-SZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSxi-0008Fu-GZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so11483645e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369916; x=1776974716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iIDvrYkfkxlNfLo5huZXzJCtpw+6DRe3OveamPggIQA=;
 b=Tn8ONED8HJJxTPZCSEPX4JgIPCjEHeYYfIHr5t2PZZy0DvClEtm2e0/JXXEqEM0ips
 fOH1OpaAGyaCbLwPaXUwhVMep7bVw1ZV8bT+WYyvxkiUSaFd3bIn18zJZj5sfQFzVhA1
 olXvwwW9pbTncx6ikBZHKzibE40ldfzTsI4F3em8eu3ZvpubYWNsziOaQABWKXUDBuSQ
 OuVKbEelKlkP/KW54nTMcrJHYcUVk7M0yzmiHYR2HDqpYSW5KpM+xBhBS2QeQf4AyswN
 5qqhMsLtKs8wQhNwgIiRPvAABAbyWwb57P3pLFpxE1E/uLZDNVcM0ZerIGjK4POFzsDt
 9dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369916; x=1776974716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIDvrYkfkxlNfLo5huZXzJCtpw+6DRe3OveamPggIQA=;
 b=OSmjnh4fzxfZYxC25VJN7/H1UTwMrt/35iSndxEtns4VOPpSokxgczcWGdr14PlGq6
 Qgm74hRZISCrV+aRmhb06c9iwHijptlhq05Z8BHjuQzA9arl+vtEKFH0apa37aN/+1KT
 1+GRJpYkLJ5EoknwXV5o+PhebP14xW0w05QrgrAroocsBn0sLeWha8ZWIrAld0qK4oqR
 ifYcxJ1QaAo+oU31SqkonVUt6vKmxZ7cVW++CXy6UfXinT97fuR6ivE4QqKW7CPpFrI4
 Rxnol7SZmNFnPcIQXsfgMGKrBcnZplPtEyeAk8alvSWGePdkyPo+V1CHElMvCgDNk0m5
 VyIA==
X-Gm-Message-State: AOJu0YzjQmzY6FJcOBzCUUSTG+KkK3NA4kpssrd8T8XWrOU+3xxUE2YB
 wjMhj+so8Y3OeSJDzdHHApO5/l1p4HeoN/5U0+st+pJNU9qgLgNn6tiFl6rNLui+YGPs/K4dnNK
 VqbTXsXk=
X-Gm-Gg: AeBDievd9CaGvAUxTGUz8/2SdDQuQZSDdql6koE0wpTOjj23NYcrNW715ZMaO9dLKQc
 JtE4BO36Xg2VWtCxbYoWFH0p07+b1NJvHpS0XaLbJGVf8xLL3KOkzUBWZit2ZfDycnz8sMhM0N/
 xgtqV/vvL6ILpbfZCpFUTA6+Nz1P+dhSCoSJt4/MgBTp38apXoXcEBK8iK3v20tVUWfCEaWQViB
 LMI4jkxXBoFSY5cVKSsCMSqANdkqmRqMEDWDMLmCB1bNqMC4gB1+nF9LSYtCVw/B0GmMQlg7mJ5
 EHpNIteLuITWSolTZ89Awph1od3nIHdbVgOtwOJpauesR+TNgMR6q3wrgPcvHFDKoxuR/W6sGR9
 QZ+qiEwR7jYSRGB7qiX4v9NVSF3/QdnEMmLcLOCiORqOSqmJERmf9SYd23YvLsrH/ZSqG5UO1uK
 sgobJkCNQB2OgytyF1/7ISl0P/H1ntfjpJVBW6SSiS5nj4vrbj56HQnyj3qX77a4TrrIDQ8g9Vv
 NSupRcXmC0=
X-Received: by 2002:a05:600c:4ecc:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-488fa7e5272mr7492475e9.7.1776369916173; 
 Thu, 16 Apr 2026 13:05:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6e0b15sm581365e9.0.2026.04.16.13.05.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 13:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v5 0/2] target/mips: Use probe_access_full() in Atomic
 Load/Store helpers
Date: Thu, 16 Apr 2026 22:05:11 +0200
Message-ID: <20260416200513.27100-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Since v4:
- Moved MO_ALIGN change

Following Richard suggestion in [*], use probe_access_full()
and replace legacy cpu_ld*_mmuidx_ra() by cpu_ld*_mmu() in Atomic
Load/Store helpers.

[*] https://lore.kernel.org/qemu-devel/ee4ebd4e-b475-4d76-8fd2-8b04c30b183c@linaro.org/

Philippe Mathieu-Daudé (2):
  target/mips: Pass MemOpIdx argument to Linked Load/Store helpers
  target/mips: Use probe_access_full() in Atomic Load/Store helpers

 target/mips/helper.h          |  4 ++--
 target/mips/tcg/ldst_helper.c | 22 +++++++++++++++++-----
 target/mips/tcg/translate.c   |  7 ++++---
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.53.0


