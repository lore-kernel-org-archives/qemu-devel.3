Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CCC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8601-0003Dr-0d; Thu, 24 Apr 2025 19:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zo-0003BE-Ha
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zl-00086D-MD
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so1444442b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537320; x=1746142120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=lZeIZc6+kHYmU8428gdJsA8D0nhE4pQGAF3l+cijAYRQDoX79WgEPz1CGCMNcUgNSU
 XMFVOEzsBhyqoW8JooDhQIUwQQqqgTMuK3nnOwjWeefhwwxrE1AgiOLxWK4dQBDq8o3W
 5GUVxD+nF+wIYcM7x4zNssv2TCejckjc3R//x2bh9YqQnYfJdlnf4uE9e5JwMTFWG9IW
 rTvrps7cwdH9lxbcFeYt6GWBInmr5XoMjxinxtOIQEs5c7XbmaUjFszJvOZUEssMhYeC
 QmLMydycSMZO+SvQfkVAQvCOSQk0jO0OzHh3a7Tg0G+RkJSlIbr+nnHqOcDYfuhPhH1E
 LdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537320; x=1746142120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOjC5KI63SbLoAcab6C0ugB2QHtpLUMoBslKkCj8HHw=;
 b=tSjacoqyWpTObt7VNnr1A+Cw7KqrUi5MagoqSo5ahnKQO/6PriM3Ix6Xv5y1CMqjH8
 jviZSTkH326HjGZyibfAywnOVY5yfWxgaG5+hCjSXN1SMzKIEPsCW9s5QrEDAWbZt1Pi
 /I26JdoRjD2KOkrRrOcFebfxjbpnLgnxiS3xmEocgo+o+QHthUTylROvVVgvzkfVeX3+
 tEWWAdnnkMslojg3JGiCUMkrCHeeC5+g0vzS0bZxekkqVH5qccp1Q+b9Gbt3rqnOpOJZ
 9sc85Odp2lPoDdJZflbgxJ3yMw7lRwr3t1NDxXfnkzq+lI8wh0/JyjtnagPU4mtb2zla
 uRdQ==
X-Gm-Message-State: AOJu0Yxf1+uxqw/MvjyJzJpi25XiHkH/vqSdWzhuyUYEIsAD+SSZpYbE
 wIAAb0fLmu23u/6reT9xLSKOTRS2sPQqlxnL93pEP0Yv+X3bJybG+IY5UV82yMSzkcmh4PaxJz1
 BpHg=
X-Gm-Gg: ASbGnctkDhqvdPLHT1gr6PVoeE3hGV/GQ+ScPCDJu8+2WjWbi56AkCZ7tmqdS2uP8zk
 HEp6fsnlrtHaSeWC/qnCY7iWw2Co36TmIAIfsJTvBrBLD4dS6tyWytntc6bhazEZATf+zvKdUiI
 b9ywl5ty7JituoiH6mWhrIUpzMfA1UQdVgi/mYtMeHwFl0X9vC1aaBSa+Rjk/mS2xqDLVfjOY3V
 3qupY46N+GUMmDOzjfP2Tn1agx7fT1kelr91I+Hy8kckys4vQw5y/QzCBDDmWieTnqs2cXEopXQ
 Xy6vpKp6SWpQ3GpLcHQpjdelTzyuRAoOwpQl3FFg
X-Google-Smtp-Source: AGHT+IFPnpKAC5v02yvLHI0k01LSHqtveMDVKvXuJaN7IJsSzQTevCb+Ft+SlunLMTrDPlL/F0HptA==
X-Received: by 2002:a05:6a00:2da6:b0:736:a694:1a0c with SMTP id
 d2e1a72fcca58-73fd8e52315mr121872b3a.21.1745537320253; 
 Thu, 24 Apr 2025 16:28:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 2/8] hw/hyperv/hyperv.h: header cleanup
Date: Thu, 24 Apr 2025 16:28:23 -0700
Message-Id: <20250424232829.141163-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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


