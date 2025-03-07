Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A81C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdW7-0000z2-8i; Fri, 07 Mar 2025 14:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVf-0000ub-EA
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVd-0007WJ-Pa
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:27 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so4086974a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376244; x=1741981044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=u4kjQyIYTJNjeitrXjD0na+FPwm4plbTtxj3NvjyH89efL2eYEAaLYMmrkzHBtrF/x
 DKh2BZvIabuEdHOjP88eXvajzYzWGInO2FgxxaRN16SwS3U0aFLzT0aoZerVP8f/PhLs
 kaM+BTdleJ3/doeZbX88Ei0ChngvMbQo+FVOy+f0cM7Fu1ivU40dZMfy+uX4dlZsPXwC
 5guwKtRLkidMHo9q4l4k/3PX32doXxazJGYBX+7jhrWXRLF4/qXEsFro6AAxmOgCzGRg
 kM3WC+BjB6KOr0JgZ5n9TdR/V+KL7LuL44Pm+PqfHDf8utjP4LeOt1JSXaaOXzMVyGJA
 6eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376244; x=1741981044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=hG17kfzz8aqtEjqor/93q6cvwXv+oUWXtUcceriRG73/uZrMoKgniX/du7CqnV8Hhb
 kaZv7BsGFpwH3CO5XVzntmjzF6DQ+UsdvTAOIZxkkpgAzCAaAX5rgmEzrICRWujUrw0f
 NSPpeUjERAdHuh0D6AxZKPPrNETau+ZN4Ck2f12bZwyXSRcg3bOZalwttnrNlGxfapc4
 mhJR3Fqe4gGJQuDBi9kP8EZp9qQu+CJO6QSYAK3AzzV0WvxVpNcHdL+hVIG1w5ckiyzg
 KbK6YQ+zL9HKrkmVB5+fEOaz1FtvLJdPlsjEDTZtDTITkqysisHz29g9993UyofmH8fB
 hx+g==
X-Gm-Message-State: AOJu0Yx6W7e+wroDWaAIB21fgmw0HhZUpzOaq15fyJFVuRGw5XxKfV6F
 DEE6BkzaoGqTxed65Ok+ia0Q63QLJvqF9Z4gseurEhi0nezvR0HUEcpl7QuSf4ZhNznYZGbQjAu
 d
X-Gm-Gg: ASbGncvd5CpnvjFtiTAiutpqyoqkn0MGoYujlshFKrf0TLvU3ssnUAVBuORHdwaP583
 eeFcLVCcQJ3paB4p2OCQcArUY0Xh13xVcss0U+xW8iw4tpyNeze8dDwPn8XzYasgeYuNCu22jPw
 hpKqmIf1NqfR1OGPlVdZP7BngB9H/z89mRbI1Wqot0gLBCEbBAEtoZdtfZGX8D9rGVks+yOafyx
 NhJHJRF0bxHFwYtq4BTBjX3J92VQtHMpyBWnKLW/qPprqSeSKxWt1Ru54jUsR8vaZx3k9QyF8Gi
 IRNKUXLKEQXeQQh4osg0R2ZzX5/c/5xyhchdErr4ZDwl
X-Google-Smtp-Source: AGHT+IFe9wgvnMzXQ/WyHuAR6wnkRDLj0hwLlEiJ0+W5nV2Ia4eswq2QZ++4R3SESqN9I8JkPgpKMA==
X-Received: by 2002:a17:90b:3d0e:b0:2fe:afbc:cd53 with SMTP id
 98e67ed59e1d1-2ff7cef7345mr7076283a91.28.1741376244365; 
 Fri, 07 Mar 2025 11:37:24 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 2/7] hw/hyperv/hyperv.h: header cleanup
Date: Fri,  7 Mar 2025 11:37:07 -0800
Message-Id: <20250307193712.261415-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index d717b4e13d4..63a8b65278f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -10,7 +10,8 @@
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
-#include "cpu-qom.h"
+#include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 #include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-- 
2.39.5


