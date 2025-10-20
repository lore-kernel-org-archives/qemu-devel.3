Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB11CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnIH-0000rj-Uj; Mon, 20 Oct 2025 06:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnI2-0000l7-Dd
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHz-0000G5-HK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47109187c32so19655395e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956732; x=1761561532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EulFVp0cdEgXrWVzzt34/e5jn6jKRx8ym0Wu/90Pz4Y=;
 b=ux2JWx8Q3s149sGupJTQZvdgH2xzZQbf7pSBw0vrxj6Edz696xDsJvRX4oC7N1FTRg
 Qs7Oz+BIN5vzKFAsWOSNbfPe2G0TvOvuYsZpV/YtxPth6NnAxqiuOU9Auc53x8EHtDyN
 uNSTfhZIO51A3+nRUAAEIpLlRs7RXG+JHaz6Y1P1rjRh/HQxyLBWD+A7f9bK9ZHAz7Fa
 xobLMAyXzPDS+AUWnwvjCiL5WdpPMNiTGzoWhWH7gNrj4Fkz3Ke8iUn7YacuKMRvr1Yr
 fdX8OhzziZIjc0+ayd/Ma9LS+sBk+E9GC5K4/mVei4bvxS4AgqKKOqqPEHEhQA4FnE5O
 75TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956732; x=1761561532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EulFVp0cdEgXrWVzzt34/e5jn6jKRx8ym0Wu/90Pz4Y=;
 b=MtRcoCAA2jnNd2crCSeH0yfs3YxjIplmrdn+xjqEH4n6E3u9ifQSs0vCY7XO+jhMo4
 I7kmLyqS4ZEGHs6oLMrKXFjoS0u4Q/tJQ+8nAxjzkj9m7SL/pj1XhxfFpFBK3u+WuBCf
 mkUmgwMqa6dPEx0IUtV5RQOhBJx0ZOGBSQQDwdkqoSkbdTGdz+8pFTEeYXokNc8Z7vPA
 VwgbZI/2F6IW2INpeX2PeudAfnGnmrXYkSnrCFvFAIofDSUA/BskpE6/CpZPPRIjT7Vg
 lhxeaJuqY7cPlr/LV2RYiDbO5Zs28AferbPDCp7Pf/aa5jdBDGBu+G1cOL0Ij+fRWm5h
 tJZQ==
X-Gm-Message-State: AOJu0YxQCZES4W995dcmE4PBX2vKXs97GFOSeEoNL3ZBaak/HXJqXPU9
 9UgL36jbd4MDhVoNYnmaKccAjbbauHRS+lBdKNnfmDMaZy+NHndiK2p3o2IKwQiLsR2Eha5DUf6
 61VYyg5c=
X-Gm-Gg: ASbGncvBG9CxR94U2xXVzVY/NEEcnHDtoFDpBjqMA7b2UhKO7RpXGC9HevsaLfTR8BF
 pybEA+ka1lTM+JrbuziKj+NwwbI4sE+jP8Vz0V3k5gDlFGzQ3DpSkldxL3Isa/JWTKk1JfGRAkm
 6ZKRKd64g3y9QMxm0r5rk8uux7mxZX58QmThOEbHhpRpqLU3cB9QiT3etDYcSuLcsRdO3sGHDeZ
 xpNjfJWmtJst1XciZYp5uhOJ4iqVie+GyRBzVWCPkmvVY7OWSOIiWT4yvV18jusI5+D6EZLb2EY
 FWfy+zRj/h2k2qp0w+uGRXMtnjmmiQ0ma5X8Hh6tar7UsTqoDQCQ3c8cknlbHvicSg7TYrj/DRt
 RVwLyZLdzKQpRMobGKeru06UaRCN/d+ebxueBa1nFiBnKPVtbvQkIkzM/IvcHbN+v+4ZjELtP9O
 QhgbX3KdP2FXmbqmxY7V9gLubcF02cLbzZoMKpyaBYSLYcI82eFg==
X-Google-Smtp-Source: AGHT+IHpRuvJt+vq6kMbYDeKVQiSVG3/mEBkDhXe9vJ1QjRj/WkWk4DI1OronxDF+lp7sfbpdSzGPw==
X-Received: by 2002:a05:600c:3e86:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-471178a3a94mr89203075e9.10.1760956731887; 
 Mon, 20 Oct 2025 03:38:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d3ddsm220057205e9.5.2025.10.20.03.38.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/18] target/ppc/kvm: Remove kvmppc_get_host_serial() as
 unused
Date: Mon, 20 Oct 2025 12:38:03 +0200
Message-ID: <20251020103815.78415-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm_ppc.h | 6 ------
 target/ppc/kvm.c     | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a1d9ce9f9aa..f24cc4de3c2 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -22,7 +22,6 @@
 uint32_t kvmppc_get_tbfreq(void);
 uint64_t kvmppc_get_clockfreq(void);
 bool kvmppc_get_host_model(char **buf);
-bool kvmppc_get_host_serial(char **buf);
 int kvmppc_get_hasidle(CPUPPCState *env);
 int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
 int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -134,11 +133,6 @@ static inline bool kvmppc_get_host_model(char **buf)
     return false;
 }
 
-static inline bool kvmppc_get_host_serial(char **buf)
-{
-    return false;
-}
-
 static inline uint64_t kvmppc_get_clockfreq(void)
 {
     return 0;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cd60893a17d..cb61e99f9d4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,12 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
     return cached_tbfreq;
 }
 
-bool kvmppc_get_host_serial(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/system-id", value, NULL,
-                               NULL);
-}
-
 bool kvmppc_get_host_model(char **value)
 {
     return g_file_get_contents("/proc/device-tree/model", value, NULL, NULL);
-- 
2.51.0


