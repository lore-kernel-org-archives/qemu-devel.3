Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOwC-0001Qk-8n; Tue, 18 Mar 2025 00:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOva-0001Eg-4V
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0008Th-6X
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225d66a4839so63038515ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273499; x=1742878299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9rzsv10o1w5kRlHax2UvpGLKsY+tUQFsRxZLLJXZ6E=;
 b=T9LDWFP0m+waAvOvPnfYP7tda+Xc+aaB2kQol4e1g72X/wyZftJGxZKXhVc0cx7015
 w8p9J39E/M/Z3eF5CUG39Hc9+PWMdC4vbkuNQe/YlxkwVaaef9kzjyxTZ/KrHnTwoHXR
 tucZVKdFervPRHxd+63129XXWnvNWW3VgIQ2zKsSXs17iapNWizxxL2KGKUOcEyYZxF8
 Xo1GBtSlxIaOezwIT+NMP2nmA8lKNdlzPqNGodSfFhTQTfVOIaLyZDywUcdLm1VU7Ngv
 rMiBwzmGxz2qBM5Xf4DUplywv9yixQdWbljNvdN3GRE00QOTVwV2ESjIJFPtRRSe15A7
 0iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273499; x=1742878299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9rzsv10o1w5kRlHax2UvpGLKsY+tUQFsRxZLLJXZ6E=;
 b=Hz13L5mK8kxPyhpa+YFfPZ1YqIfpOsLngHJmxWbV4fwdYwiGVYNfLZzHy7Q/BwcaCi
 rrrQmih5C1277X3p0C4Runlb/UDjb9W9Gb+Gj9jsahAAUG3FyXhrpHBwl3bwb2PYI/xG
 it3zD37+cssK8n/v7IdzvFkeO26p5p4iJ9fk6aNLV2vBskO3v2tr3EoN2fpfQcrSPIcY
 H9HoGYyUIteSWz1NO/RC6rXD9yWfmuQJcrPfrZ/4+43WwazrGjkLSLYfR6dS1/hEc0jY
 gSiMizo2X7py/UYXla86SpNYJWZKzrC73DuIVuwbysN5P9W1Uwz95DJiEW3ZBIINqNJS
 xyrQ==
X-Gm-Message-State: AOJu0YxnJO8RrPZU9CUNmVBcEhEpIX3GkyPzCX4P79Qcx2pKfhjXFClL
 oDgosv7iJ6nQbJ8SvddA5fHQh7YGa589BBZ3QAlf0S8skzn/7VveZYGI20tv12XH7R7i1/q+1dV
 r
X-Gm-Gg: ASbGncvDa/uhK4H2wCahvjpNAkm/nyEwe1B3K17+HZTorescrHOwWzQJtYBXK9ruGeg
 YI6coxxNUMhv8csSO6hO3oKsjazoX0mI6x4GstGugXuh3eNcFX3r9yY3heNol3KnpSAhVNjPnyj
 ija0Hfzx7fLZvz7jDs14a4DeCsUhz9K0pMxXL3+hxomVp5WQTbLSMb2js5ArhVTrkxg666X6QKX
 v8oejQg7RRhBTtfJ6j95s46ZFzv783nyyRyAdTupUrHBhJOCve5KuhhJxHxCE2360XYUvms882s
 w467IFtFeO7ao9o7JbWylXDNJCrpyKuW4s+4xcLYR+tt
X-Google-Smtp-Source: AGHT+IE8qR7rvWy16B29zqVKeH+5Xs9FEHJRohxtlVk1ha0v5ACDqhpK4pBzwowgaOfPj90X8hPjJA==
X-Received: by 2002:a05:6a21:27aa:b0:1f3:1ba1:266a with SMTP id
 adf61e73a8af0-1fa4c6a1afemr2173708637.0.1742273499683; 
 Mon, 17 Mar 2025 21:51:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 07/13] target/arm/cpu: always define kvm related registers
Date: Mon, 17 Mar 2025 21:51:19 -0700
Message-Id: <20250318045125.759259-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

This does not hurt, even if they are not used.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 23c2293f7d1..96f7801a239 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,7 +971,6 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
-#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -984,7 +983,6 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
-#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.39.5


