Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B2BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8607-0003Eo-TF; Thu, 24 Apr 2025 19:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zo-0003BD-HN
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zm-00086P-Fs
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1551405b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537321; x=1746142121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zd7Ad6nHa6u9MOK7rdz/XNTrIxsns40yasfIIp2oAZ0=;
 b=W9Rl5C+33cjrUcSOrHx0gOcyRKJLCi2pCI/Lowh8eu+77yXqvZC1eazh3hz1W+97uV
 ngHy3ZBnpMlrENZ3CkGdL/eNnOxp+Oa9vE3z49H9iBe3oQqquAnDa3wXdUVvLIrNAty3
 tRAbzaKRnd60Dbv7pL2rK0mOjodB1tjdn57j+sgnuFtGnY9dMCDKzMgYPuEmBvd8zlGZ
 1Hn/U70enxuaPE6MJP/FpjSBkq0IP6KR7Emz8gA/BZBU5xn2I12IMH1JUxTL/tXTLt8I
 lfzXP3HALvSD7m1jOQpoAu8LznIVXDsEkFx5EY3RT90+ByWYJ4w0WLB+bIpIQIunZ3ak
 VulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537321; x=1746142121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zd7Ad6nHa6u9MOK7rdz/XNTrIxsns40yasfIIp2oAZ0=;
 b=XYK7qwoTrKBOAvBGna8yCAlzQNs1jdsreiH9j7gr5OYEEGxjo6Eh2okLFLuaGrL6zg
 pD+HP7jF4CM+TV2CBcwXY5QnqaZp51EdZC1Dq8i2ftCSgfokVbdLc5teK5E6BS7OYfXs
 mm+OLmLc2rUQGTXFnxYRrKLur5oMAos8HN18AoRxo4o6gIFWndrHwlEOVOnSryzvfHBl
 RguBgWmBXbmDUOzMaPFmirDMxpE75IlDTJWPwJQ2WtRiPO9ASxnbBN6QqQJD9kSfdxPF
 5fbrjXbo3Jqe3t8Ya9vxsLa87dQ8Dwbj8a79M8Ww1OZEfRK1vAtmFwk6sBKzm0wHIoFS
 KDzQ==
X-Gm-Message-State: AOJu0YzM1IhLe5yAafR30Lk0zGrT79UpjkI9ewMVOAIcGIY8wxlqh7OO
 wJ1IopbTmLrZOWt9hMpekYlxSGQZiHeFnuEMCv8sCsS/HqQNyyMj/ALMno6K1j07tpZSN5XVhz9
 pGGI=
X-Gm-Gg: ASbGnctDXUmTJxm0Jj8cZ55hHLiW7xIBfk3oZqBzdFSAOqFHXvMylDlcGD2tH7wTa96
 EtHmmrwm2Yh55itZXoKtaQsgOFkYTsUHZRIqQtOq17oJPfb6OIdA4LeTcDBb8HLOtxUNsqqTjOs
 gleV3hIyatiQmKAWvcGR/w80AVLL4cYIuMGtaqs0J4vcfxIGRsYXmDEzATVUZfJGncSlblDkZbW
 Q/hBkgLLiLgOpQRSITZfJTT85n7jTbSiYB2UAJbybA5TlW5sJRaudPaVWwIN6IIorEqel0KiF4y
 J1u1NeowNSmNPhJt2ujZICSCoKf08cJ8DVCpPU/S
X-Google-Smtp-Source: AGHT+IG77ILEn1SteN+u98VgUPSejRzmZLJ/QaWfPoCnjigSzfBeH4GposY6XKN6Ovxr7oBdOgy2lA==
X-Received: by 2002:a05:6a00:3e0f:b0:736:3c2f:acdd with SMTP id
 d2e1a72fcca58-73fd74c1c8emr120672b3a.14.1745537321143; 
 Thu, 24 Apr 2025 16:28:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 3/8] hw/hyperv/vmbus: common compilation unit
Date: Thu, 24 Apr 2025 16:28:24 -0700
Message-Id: <20250424232829.141163-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
 hw/hyperv/vmbus.c     | 2 +-
 hw/hyperv/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 98ea968e515..b4f3e12fe1a 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -19,7 +19,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/sysbus.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index f4aa0a5ada9..c855fdcf04c 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
-specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
+system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


