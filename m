Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67A8CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrYE-0004KS-Vq; Mon, 03 Nov 2025 05:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrYC-0004I5-Nx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:12:36 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrY7-0002mp-O5
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:12:36 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so2161995f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164746; x=1762769546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vM9mNF6BeM3+aPg+3EGb1A8W564ICSX9mM1UAAGdK8=;
 b=Z36y27vVmPQydFEaIti7AYV8MqgdjHqDhBQrCLBJB7hRneD+tZZ0tB5oRySRUGWJzJ
 M5Wwryl5PEszBFSHI0RRYjlqtwfiKoseiBk/0mBOHQzyIvfH7D6iMsDN32pRhHElmMg5
 1hi1TIBFrZc4stqgyl93/rZ9k/JxYj6b0AlX/VM4CnHbdPnQ9TUVt9DWrefboYv8rb9E
 5+3nvxBF+bL18EARNWiFt2bXuBPojewn6cllPQ1CpYxW5/3FW9OyINmAK7c1p/PVLe0u
 xB1BqM17GCRWqzlySOrfReGRbGx7OXVq5IsQgj+6mJJpNb//4CIrtqUbM2/2uzbMEakc
 iaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164746; x=1762769546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vM9mNF6BeM3+aPg+3EGb1A8W564ICSX9mM1UAAGdK8=;
 b=TCPP2+f5bAGDw+v01GD9bnZXpe3qnEGpkrT3qQkapIyFnYPOht+vZvII7sr98ivTNb
 9YldNiRj9JNT8c8uZLHO5WUCoDIxpWPEfO6VCLce7m2Bm89tYdtyCW2mKHc1O5J/+MSZ
 LsVX3KRgNgx0BcsapFcWMOft09E+dDaUmGpkDruE6ZoneXFk1sXJes0Kj9Db2aZTpdhz
 orvfv9BMQ6X1hktPm1JNCA+OyxfUxosIYBMWfsZPJU7t7X5PMUM9HvKX6DcZEtZvBBRX
 kjO1PFlRCYbExAPY5Weg2bie4CuD/CJcT9/iwKewb3wFyPxkNCdlMPXWy022Io/ihJi9
 A+Cg==
X-Gm-Message-State: AOJu0YwAULRDLIzILLc2GjvGLFdSNWsJS/4jiFYAPSJ7U9rP3zYiQsSU
 ufZV0tsm0K8RGQWHHfdjejhzK6K3J1RBow7238f0854fKcC284eMrSgOgNA68Y7AIBM/DcYj0Ky
 No3OTQf4=
X-Gm-Gg: ASbGncstT5HPGJ4PKQJmeVNmCwLfBrwupPTSJ63jz485wELVgVSqG0/p8Ap3y/WzeGn
 MDfc8GVGREHMS69/S2vCCLhxwfsCVuT+9pAUay+p2XDX48FgWmrptkrGlzjuoThYCscMLpn6HQL
 /SaQ/O67xSF4PRU636y5db8L10JOTlVeMPOUUoEpmkpz+SoSIwDYq6AByknFMoZn3RBTN6+MfHM
 gmzKnpbQcTJyVszPo+nJCD/qg+SJRCW9pbjAXXRNXM8B4dswyDX+s2ZGtkYpYWFcmSzmpIBEHDj
 f17OGfZTI12DAOGMfQlL82s8DDpRBHkQa9OQNx+TURTH60e3Mq2UEnLUzusUaAV+rTvn6SeBKRx
 Ois8dn57pixnpEsrLwEoHd6wWJt8ZIvSMl5bzGxwd62jbPFIP5TEhuyG60DCP5fssNTwHrEr3+0
 5xERoKGMbHHQb5n7Z9LmWE2wM3mpE6JrrOmGXl3jvhNrWW2J2x+E3I9JHXfn4=
X-Google-Smtp-Source: AGHT+IFqEE0AjlJKWmovmNuUbDchPT2JpzkrZvJo/FxdLCLy8kLvHUjaJtrdjEbML2bXg5UJJPsz/w==
X-Received: by 2002:a05:6000:3110:b0:429:cacf:1064 with SMTP id
 ffacd0b85a97d-429cacf13b8mr4709120f8f.29.1762164745540; 
 Mon, 03 Nov 2025 02:12:25 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c140629dsm19493055f8f.46.2025.11.03.02.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:12:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 04/23] target/i386/hvf: Use hvf_unprotect_dirty_range
Date: Mon,  3 Nov 2025 11:10:13 +0100
Message-ID: <20251103101034.59039-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9a1bf026a4a..de06ec6125f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -142,8 +142,7 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
             uint64_t dirty_page_start = gpa & page_mask;
 
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, page_size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+            hvf_unprotect_dirty_range(dirty_page_start, page_size);
         }
     }
 
-- 
2.51.0


