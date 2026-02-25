Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FAAF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5pk-0005tY-Nn; Tue, 24 Feb 2026 22:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5pb-0005n9-L1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:45:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv5pa-0007Tn-4A
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:44:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48374014a77so64540085e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991094; x=1772595894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2UPbqmBwrljXKbelPv/ODOM3kOiQmDw3F4/3zO5SvZM=;
 b=g5pPvF5AcG2Bc152D1+AXmteOpCP3t4j6aOmn6RDR9j4u1YIrNLIMPHG7gbKD8y9AU
 PMfMwz3aHIzv9dCQjtHBhy4k497dwxJmEdtpxiZtle8jIC4oqGabumx38lDWJVMFEQXJ
 +IOdgFIViWJ6JxMCkUkfNAEoXy4Eev+FZUNuw5nEVgNOBabwLOVhzI8oK3LfPm40DA3j
 ScC+qq4dG0KT05tVFaQSC3eVXP+8r+P4KQSbICL3bJ3Qo67R2maflxo0euO/4GbHV7EW
 zLbr3GsgzqoHbBHi+uk+udeyyleq+1au611qc4fXbH/dq8Yy1mdJ+cwllQS7SbOeAfBZ
 4rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991094; x=1772595894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UPbqmBwrljXKbelPv/ODOM3kOiQmDw3F4/3zO5SvZM=;
 b=JKwp7jIZ7LeKm9fO5Q0y6+BAnwfOoeez3BKEk5iUzUdqiugZ+HpYlJfMDOtbZwwWNp
 2yaoFvxJGe0NSg20lwhx88h6QfaE9KaL2OJKBH28pFG8q+e2mAYAD0IokmYcDU8tec3m
 pn7FLI+htq8OsJB/+xz/RraOvP3l47Tjjp2cdIRa5298JItxnnDVIjFTuPB7rlnS2zYn
 28+MMIhidGWzHctXrYeLBE9WrClUbh8jvVE9RkwNrOZAcTr6WkgcTJa7Vn6JnyIlEwSb
 6VXldKLQa5BmwOeG+968wJ1k9DuW63ff16pkimSz2c8ineVuixT26pA4ADg9RKqyqYOc
 AsJg==
X-Gm-Message-State: AOJu0YzqXzkp6/+jk80cpwPJX1niOyJ00X8w5Svb1aACaUMHLW9eU5SH
 fkVw/JfrT2UFQcPKGvg+3K81G2EgMdzjvCqNUmFcDE0XO40OI+9oflFat7Z8vXOb7jsCBFYUdVc
 OQrPm0TM=
X-Gm-Gg: ATEYQzySy9M/1g/9r9QNlb7jrCEJXNiwG/a5JFjQqJo0Bb/RkXIM6ljNr7uFPQL+MkJ
 h5/8h5unyIGq7QiUQhZLQbNHUGgqbVZH7W8XYjsnpCB6Uk72tWoqv+VajrbVUBUYkEDw08f2AcZ
 3ObJrJpjGg7p8dYvsBOXt597LwDnZb2ZyremVHWeffr6gRQIagkMPrkk1qPDt35MyRMe109VW9j
 jW6IvDYyE0uyPo8O4qBn91AZsBTlxHrUX7/99u5ZmfWmqNEjYOUQo2T00/ZjnMIEsZKv1hYSyo/
 u4YgvZ3wGQDHbHn+ZE862VK9cY74OKrXu/neh3SIBdqW9RPKyJLeR4vQUko3Z6ZhNjNspM23/m5
 8L6/F9Bhz3dR8zZcuZcK6w5Nx0tCotc5f/XWuQCLfhWySV91U4PAiRC2el1q29iUWyf7p2d2oNC
 8mxqm/M0h/XfcilDYM7f2WgYl9UOreK9zUHMx0cV0xTR7nHCuLGYDZVkzeW3eLvYA68K0XELj5
X-Received: by 2002:a05:600c:620c:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-483a95f8988mr228616375e9.28.1771991094515; 
 Tue, 24 Feb 2026 19:44:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm96888525e9.1.2026.02.24.19.44.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:44:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/cpu: Build a15mpcore.c once as common object
Date: Wed, 25 Feb 2026 04:44:51 +0100
Message-ID: <20260225034451.41338-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

a15mpcore.c doesn't need to include the target-specific 'kvm_arm.h'
header, it only lacks the qemu_get_cpu() declaration which comes
from 'hw/core/cpu.h'. Include the latter and build as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a15mpcore.c | 2 +-
 hw/cpu/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 28cc4b3a4bd..28cda55ccf8 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -22,10 +22,10 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
+#include "hw/core/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
-#include "kvm_arm.h"
 #include "target/arm/gtimer.h"
 
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 9d36bf8ae2c..9c1535ca325 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -4,4 +4,4 @@ system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
 system_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
-specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
+system_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
-- 
2.52.0


