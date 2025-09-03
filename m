Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3E1CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkQN-00024V-2q; Wed, 03 Sep 2025 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQL-00020l-EN
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkQJ-0008Jj-OP
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:09:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3d3f46e231fso2153645f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894142; x=1757498942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1utAIvfVfs8L6dutO06Y5T3knPnxj7CnsEJ7M337wQ=;
 b=yt02F2Y0FLaje5O/+gtCSxsBmelC3SCdQZ9rULxg+GLpWSGn2swvTr5+zBZIDA7sFy
 7xMMPhBUjWSuOD9TtYvnmAaNhpdd8zU9/C5Kv9lBuwLcUP3YDg8fJwJtVxZBNSxsA80I
 yvDp6iS+5XondE+U4F79r34e67XDie7LIma6lgq0fPcemRBen0KPFZW9NvU5+Gdnh1zA
 lfXHXS7N8ZdfJ02w/irwQ/L7E1W/s6jDKq0J1xgXc2B2ueWG7xlG/yWPtjGkdHFTbxkS
 r7a05N8gUfpaFjfB7d2F/EOG/TNgcfd0FNYax+rone14og2SfraQkDJvDKWI7sxXMBXD
 0Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894142; x=1757498942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1utAIvfVfs8L6dutO06Y5T3knPnxj7CnsEJ7M337wQ=;
 b=aA9c7RIC+pjGdIgDrO9yOMY9i7YLAIP1XjT4wWrLyQajptX/KZSmC/tEHFyXUCm9ZC
 V7ydXq+DCUsBDGPTQIYMgicb3X3Uhxw9SqNvHoZOKjOvAWIph7HlTNgG1lHqKUUHe6Vf
 /Ia5Yvo99q0hkd4vuw9SBXLb+qlhAiq22XqQcLHwmOl0OAPown4zJ4ajpugi7/2a2AIm
 l+Ub2m5T14wG7gr8s+y/7d+AG6EPfp6HO1mIW5bTnLaNqTBJRh31fPg9KJ6wfuDfWKM4
 SML1r3PqoDoyJJJ4/rIJGhR1AHT6BQqZOFlL7+h91rOVtaStdOi0moMRi1N1Xzs3CD5o
 ZKsA==
X-Gm-Message-State: AOJu0Yz5qO3pvtv+3MjxxJ3GcsJnQpVErHdZDAV8d4iltcX1WfRnKnI8
 rEpDqwYpC/49FQMDtcw0Ts2qc9giHS47Rme+eBicjbE0nFLhJywM+2V9OSmt21hvoza1sfIroyA
 SL2x2StcUQg==
X-Gm-Gg: ASbGnct9UVP8vvoD3IkUj6EeakCOP1zp+W/VvpS9rBOXvSpMSA3aeK3T77M9KilqV/n
 sfGKa+u24/8dDPlWn6cvxcXsPzzp7BU2b32wVlvkzN5h7vD8l+Z63zwT0wI5ogvwMvlxpnywUEq
 QAwTUH3gmYxGt0ZHcMnIqPVQfsveCdOc6qPHJ+4w9oTXSMgkUnZmGnd0ISUUvOwJN9nthDp2+jd
 9szElxvDNBr94ZV0PckMOWFMPJ4QAYoo2+NmyEcXRpNTjsaLsSmyOMLOT1xu71Aa76DX7/VOInE
 nbIL4wiKvlZTbjC2m2qXVD7Hmn9FA4/vU+J7xfeCXG+BB1qZINLaf+DUeb1a54ZmiTbD953EPIO
 /2NVjmELmD59JFHINfEEtK7jtn6DFNYgBk3pn3Q840ynGgg3fHRiuEp/2AueMJT42RGjYv1/F/T
 CkB1LOFQ==
X-Google-Smtp-Source: AGHT+IGoftb1nGXPvfDYSp6o6GD/O8juWmGb7TE1EIXEQ2F0ztvvmCDO/+cEWuTz/83cOP2yiw1n4Q==
X-Received: by 2002:a05:6000:25ca:b0:3b7:9629:ac9e with SMTP id
 ffacd0b85a97d-3d1df34d63dmr8950774f8f.50.1756894141649; 
 Wed, 03 Sep 2025 03:09:01 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0f85c287fsm21106877f8f.52.2025.09.03.03.08.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:09:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 12/24] target/arm/hvf: Mention hvf_inject_interrupts() must
 run on vCPU thread
Date: Wed,  3 Sep 2025 12:06:48 +0200
Message-ID: <20250903100702.16726-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Since hvf_inject_interrupts() calls hv_vcpu_set_pending_interrupt(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a9793060579..4a535d65b7e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1788,6 +1788,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     return 1;
 }
 
+/* Must be called by the owning thread */
 static int hvf_inject_interrupts(CPUState *cpu)
 {
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
-- 
2.51.0


