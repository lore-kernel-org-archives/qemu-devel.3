Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaGy-0002WZ-4G; Thu, 15 Aug 2024 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGx-0002Ve-Cd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:11 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGv-0001Iz-NI
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:11 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef7fef3ccfso10591791fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723727528; x=1724332328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLB7mJfkqSlFxiYgEnzw0Isby/ZPn7qIXDefx+aMhHg=;
 b=La885RhCR/dPLyR19c6+fw05pSwC+LuEJBqaietJTAd+8BALawektZCrnh+oi9rQrk
 LrIElFRJlnxHAt2rMMivaSgyGlNE+6IxP2zqOkdqLbjzO3vVIOj8uZr4ANLBYXif5jf5
 rl1p3NFals6fVOnEjZS3H1kfWcqjwljTsyzP+APz0M8Q942SgslkYiFZvRT21jXU0orM
 Q+5p/cQmh92FIeHrtGLpGywzJeFJhpf6OXatPkqd41JhY86tLpnwkvsK1xtTrBoFytl0
 2LL77uYLjGfSk+iatkTxWiNNNlvn0wnjgPFpYls7a8pp2IO5iwIC1dJ9qFrcNJebGydb
 hesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723727528; x=1724332328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLB7mJfkqSlFxiYgEnzw0Isby/ZPn7qIXDefx+aMhHg=;
 b=ZgE1vLpiOQOkN/TLORqs5vALZokH9qkiy58jiNFsLXusdgLjP4ln1IP/bni7G4FPhf
 ncu2CbhO+KrThfu4uDmUDpnuw5YyZzy0zyZujtEBfgIn4jQg0xkpx41sRKbIWK+WGK2B
 UfZSiWhnRKC5jLQ4B20zMf6ljNiAtY9yrTvCXuZGAuw2YGt9vTOSuKQ0JgHii4zisIIC
 hQAMnkSIQJhGKSrNDpGF16PupvTLIxxiJ+9ShiLl+HCfxP5uf7EmROskf4ShxfTkd8Qe
 Ptv1uEx66M8ovVyIcAnK7RB4/jzIhcQCWXZgeOmK8vd2baaTPCT1wE25rcFE+MaKkLyF
 ZalA==
X-Gm-Message-State: AOJu0YwbRMKDSUoHitQ5B4ogo1c0bTGkuvU0zf0NpE0KKF0z3YbrnC5J
 8hVm8DWKxqOc3JKrCwePvBN9K505ZqXY/R08muNtUwUrh8aDc+mwT+aAdj2mq3z4O/tpXF4HqUs
 1
X-Google-Smtp-Source: AGHT+IHiva5yut0dbIZZj7522nyyeyZkCoYlPKhnvW3NyU6er4vgmQ92hGcpY2H+O73mEPOr8NwHiw==
X-Received: by 2002:a05:651c:544:b0:2ef:392e:e45 with SMTP id
 38308e7fff4ca-2f3aa1f923dmr47729241fa.33.1723727527871; 
 Thu, 15 Aug 2024 06:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded19627sm48269935e9.5.2024.08.15.06.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-9.2 1/2] kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(),
 do_kvm_destroy_vcpu()
Date: Thu, 15 Aug 2024 14:12:05 +0100
Message-Id: <20240815131206.3231819-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815131206.3231819-1-peter.maydell@linaro.org>
References: <20240815131206.3231819-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In kvm_init_vcpu()and do_kvm_destroy_vcpu(), the return value from
  kvm_ioctl(..., KVM_GET_VCPU_MMAP_SIZE, ...)
is an 'int', but we put it into a 'long' logal variable mmap_size.
Coverity then complains that there might be a truncation when we copy
that value into the 'int ret' which we use for returning a value in
an error-exit codepath. This can't ever actually overflow because
the value was in an 'int' to start with, but it makes more sense
to use 'int' for mmap_size so we don't do the widen-then-narrow
sequence in the first place.

Resolves: Coverity CID 1547515
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Borderline whether this was worth changing, but I came down on
the side of "yes".
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index beb1988d12c..6c4cb263ba3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -414,7 +414,7 @@ int kvm_create_and_park_vcpu(CPUState *cpu)
 static int do_kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
+    int mmap_size;
     int ret = 0;
 
     trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
@@ -459,7 +459,7 @@ void kvm_destroy_vcpu(CPUState *cpu)
 int kvm_init_vcpu(CPUState *cpu, Error **errp)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
+    int mmap_size;
     int ret;
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
-- 
2.34.1


