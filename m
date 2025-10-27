Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06995CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL1w-0000xr-F9; Mon, 27 Oct 2025 07:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1I-0000bR-FX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:13 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL10-0005aj-JS
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso1078003966b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563027; x=1762167827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4UpD3Wo2Ur7M84EaEhFIxTHg7WVr9t7D/2QA+hHtQc=;
 b=Jsb6+Lm9YVYCAX/wiG0OBQKCDBNVj+MWKGjlwOZd12iDvjEL1Fg94vg+5/SU17nkrm
 i6C4P7m/r1ApS1Qgox880Mpzw2fxFrWickAVP5uF0XWS1eoE63xumRlGk9qLDmLyJkk6
 KMrixgNDHO04LS4Plk8pZn3qXvze43xRh3T1annVmExBcrH9rBCbZgsiH7YnRgLW8MnT
 vUtBfwUKf3JtHlSTaS8kRzj32AXHEfFPHS7CQAUyDADwH0GReZf3McJ/rbAuqJuLskH1
 6hm2BpJuowWTxwwHPuuYva1wcYkdyTopPZjBJT8xHTvaXxA4826kjTvvlJD/i5CkIMfq
 4nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563027; x=1762167827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4UpD3Wo2Ur7M84EaEhFIxTHg7WVr9t7D/2QA+hHtQc=;
 b=JvwIVX8nG+HXrrNSOhKYnOz7RaAK2JQgX6aXJ4EbGmX5y5XmdmGNjmGBujsfUqBu+4
 ATPue6lA5U8p/cVZ/rrqcHMWkfzD/zY73rOV8vf1v+/Ju43r7iFhG+OHH4WLMsc5L806
 OH0dZm6tXaJrvybktGQkDy9MSjACRY3HnRTEOpJlRI4IOjrKhZaJ+Zr+0of8PUPu0+rh
 wyCvEfxGhjZY3by9u7uuM2KluLrlLluTyRWnHOy8wYF4cXicLvn4V3W2VCE2MK496QIT
 O/vFddWiyvinGjCdYuFJw+T3ggnN9bTZtLfOemHwN9SLL/kYXOswcbHfI+q9yo0GKTVy
 XnCQ==
X-Gm-Message-State: AOJu0YxiCcz+qtg7WHngjCHRLDiSV77nkvAwnSDn7AxlHGBYp5zryjsJ
 d5y1lUveVahOcUi9YHPI6BQxsylWesCVGiITZjSUEpbBi5FqjCRGdIaILe9GccKkxjo=
X-Gm-Gg: ASbGncse0X3mQxUvG0djKIPtLEEiwvuBnPX8a6onSFviNwLb/W6zLY1Ku7E/7gaZLIL
 fokqDMCg2SZ2EmdNvIIonop2iXZdah7L4mtZmEv+Qp9cKw0TeW8FXPe/JVwUfEtXrE1K6VbnFnm
 ltMW0lfpLFKpbmowOUWCg6Jfb0AXnUxdWt0uaDu7iNtRYMui4eiElZ/IEn9rvILdrcMg+GrluXS
 83VtIEvZJxbvAl+TBi2jDzDB+Dy642rBix4AETmu+ArN9CHsJcRK3u6YwA3g3fo3QPDUR2KOZTW
 biEtV4TwvFo1ZBGjw+eHgVpmNS1AgjKWWFGB/QzYLAWNL/hNww31m+VWr8pKWMYFsRKM2lJf6wB
 0+j84POfohLrVyhy7fMF0yJXioypVoQVkLyJPe//S8Z1jh+vHLs/9U4dcNP2WENOSfOsSMbQnPD
 T+
X-Google-Smtp-Source: AGHT+IFHXajRGliwqiHEwYdL2aJj2b+PeBhziVLBXnoreP9Hmb+AiOshglShS2ou+B7Jx8sOWn94hQ==
X-Received: by 2002:a17:907:7f1b:b0:b0b:20e5:89f6 with SMTP id
 a640c23a62f3a-b6475609da0mr3904032966b.60.1761563027151; 
 Mon, 27 Oct 2025 04:03:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8ceeaffasm657968666b.45.2025.10.27.04.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E7D25F929;
 Mon, 27 Oct 2025 11:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 02/35] scripts/ci/setup: regenerate yaml
Date: Mon, 27 Oct 2025 11:03:09 +0000
Message-ID: <20251027110344.2289945-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

We inadvertently updated the base libvirt-ci project which has
resulted in changes. Make sure the output matches what we generate.

Fixes: 0d4fb8f746d (configure: set the bindgen cross target)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml | 4 ++--
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index ce632d97108..70063db198e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index f45f75c9602..4f1a49be34a 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
-- 
2.47.3


