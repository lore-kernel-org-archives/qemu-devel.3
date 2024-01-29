Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F15C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadM-0005wG-Lg; Mon, 29 Jan 2024 18:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadF-0005uf-Fs
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:38 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadC-0008NU-Np
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:37 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ddb1115e82so2245937b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569293; x=1707174093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADBUc3fCETku7gSMiSslG1Ep+CbDq8k+uqgwv8Xr0vk=;
 b=RMgObZ+duwuBfwDffDR4r9TalTdjrZ0NbSqyMPUvSv9gqX+3ewKskilUw968Y+5AZg
 iJBz2uLa7ya/xMH1qXXDxaBIyTGEVqmFJETu0KgXCh2fKZMlzORrs+pROuObQ3XlaLj6
 9dDgfPmNjFZbbobYTJ+aa1elqQk/+xbHa253qUJwmcKTYGuvMwUgRayHncpA2+cbWPdB
 1VhbNzjo29mbhrHrVFQeJP7Nz+yYMF88TXvpFxjBERg0AXasUhmjLVqyXnPZWsZmNdXj
 HbpcaGhaOYgif4sL6+SsuuiSUE7+ZyARLGmq6J5YItZP5UOcIfYXRkv5ALSeDwhCpdf5
 InJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569293; x=1707174093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADBUc3fCETku7gSMiSslG1Ep+CbDq8k+uqgwv8Xr0vk=;
 b=ed9ONIywGT9jlM2RgYpbcRVPqxs7YGqY08UQk+W5giDaXtsNTFpPU4SqPQA1ZIjQz5
 qZT/eeelft6Vz+sMhlF0vzL2GORf950MEZSaVQXOl+bmcapRJ+OBdviaCOJM2auUh7nl
 VCzS3Z0FjtaT5cOo75mRCbFTWwsid5n+qeJXcfVIF8xmFrbUguucp6cKpbMY6B2Ep1b+
 M9Hg4n3QlOdhc/K1iutD3Qg8IqcJc9TNAGiQH251zfGjVESSGAcrk42i20QhjqCNa7kN
 pjoPerv9ekHe0ZJzVw14jt2IbBVeaCxdWDEVpxcZD4WyzVCU6FMOXoRUcMz21C2nEWoK
 LIWw==
X-Gm-Message-State: AOJu0YyzWeH3HJ2D+7rQ1MziiMcMkI2+t90NxNVu71Q100mwbDDcyXBk
 rKJmDj2lsC0hUvMKJqL9IlaAOiiUNIjysTU0yln0POpbvn2/Mbd+D4ta6HG9siClvhfADF18Vop
 XVLs=
X-Google-Smtp-Source: AGHT+IFptAI+2J+nBhbOdEYFzh067vlo7/8VVtRTRMDgkL3n7e9lb9P/13CRj/F7NerldqMJKkbE/g==
X-Received: by 2002:a05:6a00:c8e:b0:6dd:c35c:e7c5 with SMTP id
 a14-20020a056a000c8e00b006ddc35ce7c5mr7121237pfv.18.1706569293306; 
 Mon, 29 Jan 2024 15:01:33 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 03/31] hw/core: Include vaddr.h from cpu.h
Date: Tue, 30 Jan 2024 09:00:53 +1000
Message-Id: <20240129230121.8091-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

cpu-common.h is only needed for vaddr

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-8-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 238c02c05e..db58f12233 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -22,8 +22,8 @@
 
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
-#include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
+#include "exec/vaddr.h"
 #include "exec/memattrs.h"
 #include "exec/tlb-common.h"
 #include "qapi/qapi-types-run-state.h"
-- 
2.34.1


