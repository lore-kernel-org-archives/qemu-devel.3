Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EE9C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTgT-0001bw-K7; Wed, 13 Mar 2024 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgK-0001aQ-G9
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgH-0004DB-S2
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412e784060cso8085975e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710355824; x=1710960624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2tKyqNq18mnQFUnvgOLAQJ9bujVYus/vlpKAdDFa/k=;
 b=qXOIyT2NKkSKe4DIfdACtVnqJ9uMMjDKOuPwOwBCK75YZBCWhnlFxr3hsHAepZv97I
 gaPb2S/eFRwgNbh1b0TRphUSbb3ZxkWDbxDO/3w+E+ZkmdASXsA8HWeSXtfN3MopESp9
 EndtKzXCMQdS+bBcQv2+iMIJyrzyZriDBaFsg888c/SbYI7kdA5pcuTxcgdC7QrLmLDV
 2GAaupfrujvMiC25THscTIZmIna/wt/0hQfztgweGmPN5BZylAgpzbBgZFm7TN+CXosR
 b3jg+72+SFlpauidtZFhnNdH4/84wA2iUS4aQMMMF0WNndHhYYU+hd30NyRD+R7Yjj5p
 0gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710355824; x=1710960624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2tKyqNq18mnQFUnvgOLAQJ9bujVYus/vlpKAdDFa/k=;
 b=exSVyeSDjh/uQ3DIvXEvE5c7OjmW9CxFQasT5xOxiXK7kUS9CP4qx1PZCoWHIUVrkc
 ov15aESfzWFpBfajkrPx+Fh0+nMA7jhj82ZoGIl2a/HZbLcwrIFj4VFtQtYP4x22Tkct
 WMjb42VTObjyLVKARL9AVBbb0HVIJGrAk5TMYGXM9GsfMYerrnKUPsAsVmAp92BjY3jG
 tGEPTJkEw29qNJQlBruxYTpfLDtaVDtD43DdNxpCaQKCXhm6PdevcGNOiVidvW9H9UcA
 g2Aghi+Ee15JznCHwquWwl9FqJ2pjV2UR5DpIUsVDDaNi7W8W9Zm0pu2t5aniMcV3Rh3
 J3FQ==
X-Gm-Message-State: AOJu0YwvYfh5ns8H3jDVNv2SgQTb4jf4jT8w6NXDe/lPWaIQmjV7kmaX
 ZlauNnJeM6NJ9ShE7n9Y0yHE4pfYeKBZqCb0GCetVdFInH+KmrrtFnWw7PiPDeXGZOVp39ZpUVO
 q
X-Google-Smtp-Source: AGHT+IGRjNXSm6URsefntlBe5NG/XXhkPOjK0qhUt5MTYFzxGv/n1fZSwckPI1B9i5sIM+IUbgCmGg==
X-Received: by 2002:adf:cd10:0:b0:33e:b787:5beb with SMTP id
 w16-20020adfcd10000000b0033eb7875bebmr2237803wrm.0.1710355823908; 
 Wed, 13 Mar 2024 11:50:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 a17-20020adffad1000000b0033dc7e50488sm12209454wrs.96.2024.03.13.11.50.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 11:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 2/4] accel/hvf: Un-inline
 hvf_arch_supports_guest_debug()
Date: Wed, 13 Mar 2024 19:49:52 +0100
Message-ID: <20240313184954.42513-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313184954.42513-1-philmd@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
functions with external linkage") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 +-
 target/i386/hvf/hvf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e5f0f60093..65a5601804 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2246,7 +2246,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
     hvf_arch_set_traps();
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return true;
 }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 11ffdd4c69..1ed8ed5154 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -708,7 +708,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
 {
 }
 
-inline bool hvf_arch_supports_guest_debug(void)
+bool hvf_arch_supports_guest_debug(void)
 {
     return false;
 }
-- 
2.41.0


