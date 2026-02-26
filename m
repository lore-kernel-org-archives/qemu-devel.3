Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0781EFD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdiT-0005O8-GK; Thu, 26 Feb 2026 10:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiP-0005Lk-DL
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiN-0003l3-Ba
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:49 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4398ebdf520so1371610f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121346; x=1772726146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=82Brr0YvOlbheI6QWvURVsHrUoU94tjkyWs7+ZtfLW8=;
 b=pG226ybjs1uVn+BC+QdATAQg6qLgN6MtiE97Fzuj35rdsm2dauNTShgopKKSrYlpL4
 48lK4dvRXHb1f7JsDGhqMb6U3KpG29WB0XpFosEQu6A7BkYqqMbS5HktHEXjHPUF4r4m
 l471V+oiDVQnEjENoH7jHdBoUuZzDfagIWSGZhoe54sd1C54Bef//h6katOlmRSI6E35
 JIxXzzKlRs/siwZqbhHp0ehqcy3KeoN5ALJkTPL1zGUHL4RhalDkoi5bRHtagHE1VI2t
 n26k7zFFonuNNLb0VSc6CqcHowfHbuREOPh/RqFHPaTWIyYYTUx/80R8WX1C6SczdknE
 byAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121346; x=1772726146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=82Brr0YvOlbheI6QWvURVsHrUoU94tjkyWs7+ZtfLW8=;
 b=GnB+DUsLQTla6pa2clZyN7wGDWWlbfqY7wS6f59dGgoBd7UFSNznq31gkcLfszyGXl
 AkL3aBwO8I7dKafc9MVoERScGCz49R6nib8xEFF2m2n20dH5nBvLAOT+4+OgzDfTaLuD
 gNH7ZKrOIoYSEdDe/lf4eVyl3+np08I7EdfyooVTmDbhEzX6tk7zrO5iVO/rdMSozUer
 mvCaKDeq2YZnv5mPqAfXMh9cRPPWmgGLXDpcUuXcqkGJAuXPNmNiEX7EAG02xNkNIAwj
 d2nOtJkRwB1qmjyJItFsUYnXy51gn6L+a9iQdhtwfIL48cRAwx+ImHab+p5hF1+jwAas
 MbHQ==
X-Gm-Message-State: AOJu0YzRpAnGeQWpB1+1aQPfMgRL9Vpanc1JUyyhKyg8odbVcoXgEu/G
 gbefu5yy+3Mcwg1w3qQa8FrkX4jSRK8n+fRmSn8R/DVX6Q667zItxSwyvqwXNg+VsItZW5T8jSP
 LS6Zy
X-Gm-Gg: ATEYQzwpQvpFvG8HNGuGihPK0gbXP5ULpmNGmMoxC4DJe48ENURk4z1iR8Cgnyp5Oqo
 8Oa3kgqR+IYUT3xw9qK/TbYVlMGyj0+Q+Njnk2YnfP/f/kwRpKbVqGab3tD9w6XV/fCflghpYaN
 UMDH6kKxfSv/Dlh+AB5X1DI5hfTZ+PtUuZ2KIX+0ZGyGZgk+8JQoLnVCd0ReG/5ni0ojciboDWF
 IwRw/Ha0CKn2TQZEEzN0t9lK6JI2eu8cuVDDo7Ex5itJWGkhGT4PgLi2OhZccJRcBsVyGQ+xxUu
 SwyAG4fMo+EeQ/Wnw7rC8lGfSttZ10H+4y2biTi0HJwlT5d79BVfMKFU5VgrtxKQHPxwCR/G+pC
 lJLoxiTDF4ZjuPwjgtvUXotw1/ONPEPPKnmkw4tpyRIjCabSGncjtgu/v/bPEoTWv+EWaAeS9NY
 MCun7QpIgD8nvv9CkCHVUfzOfvne0ItHm7zZ5lohoYuHzNc6kpVXvz02WkMoWORbQ6vXgvCQm+X
 hIuX6YonPfEN13ZP5hGskK8LMVfgYo=
X-Received: by 2002:a05:6000:2f83:b0:439:9572:529c with SMTP id
 ffacd0b85a97d-439971d2b3cmr5801814f8f.27.1772121345889; 
 Thu, 26 Feb 2026 07:55:45 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] hw/cpu: Build a15mpcore.c once as common object
Date: Thu, 26 Feb 2026 15:55:23 +0000
Message-ID: <20260226155535.1171290-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

a15mpcore.c doesn't need to include the target-specific 'kvm_arm.h'
header, it only lacks the qemu_get_cpu() declaration which comes
from 'hw/core/cpu.h'. Include the latter and build as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260225034451.41338-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a15mpcore.c | 2 +-
 hw/cpu/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 28cc4b3a4b..28cda55ccf 100644
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
index 9d36bf8ae2..9c1535ca32 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -4,4 +4,4 @@ system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
 system_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
-specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
+system_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
-- 
2.43.0


