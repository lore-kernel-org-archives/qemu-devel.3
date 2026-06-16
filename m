Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A42CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDc-0005ZK-9Y; Tue, 16 Jun 2026 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDa-0005Ws-Q9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:10 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDZ-0007Qf-Ej
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:10 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36babe2c4bdso3119243a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644868; x=1782249668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPRWJz2Yd8nPR/2Htwne+NUNAYYATFtXJ3ypu4WmcII=;
 b=ioPf/sgyvKPt2hcoPBtBmdCNj5qPkyvSUPn2GaGGSpz/XyjoA7Pr7SMaJoypnJY7DN
 mcO7GAd890Nnti/ceQPQbPhCA8U6CrbHSzw9SCiogpyIIjPapEhhgNteRxaf4IVmItyj
 kXqnLbTbg66kUwS32mbIVogPaYX5cY5/WlmwUwZSmm4nXtrMwsmFc0XZ0gItmnKI5Axm
 IK3SMI4COTQ8ejSIEcgh7psdNeGgyTXTyb/hjJSy3hU9E9EjUIXCtiL0PVEh12A9kBUv
 Igiv89JpJHXjLtlpVP7YuEFZVnBXqkv3t4nGOS7cOFg8y7cbgebfKioVu82zV0KKKbC5
 msfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644868; x=1782249668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPRWJz2Yd8nPR/2Htwne+NUNAYYATFtXJ3ypu4WmcII=;
 b=kZs3OHSvFhdcR6er0yWUN9K3EVfrkX8JgiuCV5Guh6EIdXxpxRnvKrrcNCuv8dM+ag
 hG2s2jRUXjWnAUmx2ZKSGgmBlqte7aOUtrOrFG51LaTSpxy/So5wmcRhfeEWga796BdT
 hxTbcBW8bVQ2AbSHE3OMIALcbN2/uVEb7HHksnUftzz3C/YdlyDuiTdViLVigQZOu0W9
 pv+reO0LwNDbbBn43K8Lv7+pLPP21sOMLVWZmw0H2m1n4/D9sQV//7MtFrgPz1fHiXce
 J/l5xsES5UeHw01w6aErTdwI5jmSDK7jikcGeg5pAm8uuwW+G8yCfi93d8wSi8Mt1vQq
 dJxA==
X-Gm-Message-State: AOJu0YyWjARIHH8ecMXgVDVyNbKkyS46nSco9RF75Ok1ScmSJum0pF37
 dsrU7ow+E6kzKMa4kcz781fImn0SmSVUpK0Ypj7wB6fYZn/IKI7+inzjCFZ7I/kwqgCA/7wOOgd
 gb0BR
X-Gm-Gg: Acq92OGi1TtLWrxn/mzaFQ66rS6ilURrSQyaq/zI3mflkKb2CLAODHhpkJDtTRX+KtG
 stBB1XFn+yyVrK04XfFdUK7vOHK67X/zUx7TkJFoVRmc36siprpmUwpCq6yXdZ72mjrFXbvFwAl
 3obiUh3r4+GGJb8NwXhW4C0Z/IQE+v+5fe2B6PWPVkp/7Znn6RugxHTDWYTd0kEVT1fLFFk30WN
 vMGD6+ea2dITTwdpnmYMqYbcqAG1++En05IY5IEHbR38eK/smqCryCC9npuctqc1YgmR7oyvsWN
 5zl9YOwFAPy834WoI8u3JnDkdfCsc71gJ54d+Ay6tAg0/bwljQjGSllK4XOK42w9uACUBGANdi4
 wefq5JJ4qMJrA60G/0Xa2EGUeSuPU7NYZfG3MPIjOov5XbuU/5IoYvB4y8jCcj7ZkBo0hcrhxMW
 eH39lo+TiESqv2dZw9TBMkhQOjoHy8s0yLxxjCMkV8/01kArd6Fv6gvY8kDwKW
X-Received: by 2002:a17:90b:3a05:b0:36d:649a:39f7 with SMTP id
 98e67ed59e1d1-37c936dc13bmr1011337a91.22.1781644868055; 
 Tue, 16 Jun 2026 14:21:08 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/13] include/user/guest-host: Include missing cpu.h
Date: Tue, 16 Jun 2026 14:20:49 -0700
Message-ID: <20260616212055.334466-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

This file dereferences CPUState without including the required header.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index ef83ad8a18..506efc097e 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -10,6 +10,7 @@
 
 #include "exec/vaddr.h"
 #include "user/guest-base.h"
+#include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 
 /*
-- 
2.43.0


