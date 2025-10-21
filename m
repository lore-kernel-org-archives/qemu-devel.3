Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D3ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7z3-0000Ek-Om; Tue, 21 Oct 2025 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yf-000075-VI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7ye-0000wi-10
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso62624295e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036257; x=1761641057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EulFVp0cdEgXrWVzzt34/e5jn6jKRx8ym0Wu/90Pz4Y=;
 b=C9iOamV3vhlh+RaVQDj5izBwGePnPpLChwsDXKdZE8jiKJ9J1MCgokgP/YstfKkwhl
 ++PX3eocOEcMwL6HhBG9nF4Gkc+EhfsUfugl5vzmdC1UWVzTOLITCn0y+DsSXF6gcLOH
 VoCR4WL063w8vShLjgtBhtJf2di7XCa5rNrp7ooyuLJWGXUzjYWhrc5Pf5vE3pTV8+PT
 B2CHBV/Pd/aKy0jJCaIVgoKrTn8xVZ6CwP4/OzjQWquBrBxp9pCSKV/sEWdB4mTOnGCm
 92OZ+KivqrscFENJ87zq1pYDiIBT9YjRa0PfUONCiA8g3piq/a2JYsaD5GldfAXbR4MJ
 Dc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036257; x=1761641057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EulFVp0cdEgXrWVzzt34/e5jn6jKRx8ym0Wu/90Pz4Y=;
 b=c0Htl2hoqSt4cXbm7FyVliT5gnwHCbxo/0t1yNCoBHNix9nvpplsw6aYY4Yq2Pg1JI
 3G9dMDIqE0+zm4yq3PcZXcE+rvwetnGpTpllAiz6LMONnZ1PXxpguG3y7yMEgrVNYGse
 MZHgVYRsAZFfiUltCtKxSKjFlEArR34v98FvSDFWAWqMlOjHNgC3RFyW8oAS90k3o41g
 z1JYV8em4d+zVBegt/JSWFqrzJX1nGYv8c65XRHNqAriTyayLoPDsVDDJINlJ+ULzdP9
 7qxEQunkCfsiNt6ICyJdIPtQ8qUHysL/TCFy65530B+0UTPxw8zLoWxfqPLmZlfL6k0F
 zYhQ==
X-Gm-Message-State: AOJu0Yw4sbnbDknrsACAvfeFc0gxEXKpxImre96kC9mlFN99HA/uwyr7
 3pIdkO4Mm/o3Y+/jkP6CxYd52eEi3VpouUkQ4Y6Vhd0z3OZPxcq84Ppeus3ErWDQB8VVkeOLxKk
 Pf9LdSoY=
X-Gm-Gg: ASbGnct07g2C/ZKdj5IF1RQ4lDCddZD/Nsd2+H0ujhAWh6eSQgNtYuC517cLNobJM5k
 N2N0xaD2ekubnSxlThtN5dSPQyS+n2jaG/Zxu+M+FFFhImlboxqREwsZXSh+Xf2RP57wvTXOsyV
 39XXUf5aMKMgCp7pjTYcY2vKQ9EktEBAMWhcL1cSY8llnwzzl/UiBOom44M0rkHIHC5BkJ8hWrN
 dYs7h17jW3nhswEL7G0ykAyXVEslnrlR62BFxRwGbw8XfwSNEjdCr9tZEGfdf1zuUlLJaK8rXY6
 3zL/LP5vgZQSEDAdip3vlOb+Jc/sAqk56XIMlnry/3fxU1IuvAgjWDuIDgjXpQVRATGnUfuzNiF
 jqsD86PVwbHYrAYxE1UAW/oeifRIkIdlOoTOTbc3STX+8Cs+3qMpVTpd/pXiVJ+kNSzAehyxbKR
 WG+awjVPQZktijD0Lf8wGcaYyYSDOAiuRB3KQ7rhiIjuk6qGUP4TqZ9fLJG4XWG5y43M4ce8Q=
X-Google-Smtp-Source: AGHT+IEmd4GV6INTu4mcg5KDt0989nKH2jp2JP8h3QAR44T4Pq2UxoFRyjRrLBth8F3WNX4zMhdfAA==
X-Received: by 2002:a05:600c:5296:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-47117879898mr121510145e9.9.1761036257489; 
 Tue, 21 Oct 2025 01:44:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47152959b55sm189711035e9.6.2025.10.21.01.44.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/11] target/ppc/kvm: Remove kvmppc_get_host_serial() as
 unused
Date: Tue, 21 Oct 2025 10:43:40 +0200
Message-ID: <20251021084346.73671-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


