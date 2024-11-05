Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477C7D2B956
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8LzM-0006j6-9G; Tue, 05 Nov 2024 11:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzI-0006hC-PD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:00 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LzH-0007OR-0k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:01:00 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so2457159a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 08:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730822457; x=1731427257;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULV6js8+Kl+ICVkJYfpF5H1/0wNopvSfTu+wRnziPlo=;
 b=Sa2Ap5SrILV86YGcDEz124rmfRbnp+h2RWWfkomzJfBEwXC+Dfxlp4PZNeoIkoJAUb
 3wQ7nZPAhrZDGjn23EpvEjlSpbGOyJvvONXDQH7oJFQctAUy0/yoLKBCYoD9k1xUGV6j
 eE0fepTAKYsxFJl0j+j98SS87991iVzMbvf1gfQ0TmREeTWwcITYk5+KVfX/KBQKadGz
 0xPZDuM/0eDLaJ1mWkcZ0CGfwtwVEDqDUjVPr75pSmB46tQrdIbEwGGlP/zWLJgt13Dq
 ++8pI9VnqOJit/AEzP/QQ6W6Gc6ucvkJWGg7Zr8gMt7mUxpp3DWSV7BhqoLYRM2kqUI+
 litQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822457; x=1731427257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULV6js8+Kl+ICVkJYfpF5H1/0wNopvSfTu+wRnziPlo=;
 b=ttUhXSQl0aHs/k3yPhBSs7A0IJjVrKqGntyFF3nKtqa+EzDCXGwKaP56GxNO+gXHbi
 B9XaGJoqQvb/gBLQchCkhsxmT4b2M3CkIhPZ7xJ2DsvNcAu6ZTczGyXNoqf0QNXpo6hC
 CZv9YHSKivnQpRLvwJ3kVZ/1vyH4t9fFMynrpjvUzXFUef0btUKnnJuNXzRPoV/PAIh3
 vPwj/4F0lt1mM81UVJZzSfjiXeUriOkJc+3oN8h7cqSPEbiKTzdDSSoTuJD78vnRmA/l
 DwVijSIbkmOSxwOPNgyj11Hr3dCX0/0jqcMcAKzPfUnzBD7WCD/1mtwDiMWSN2w1WMyj
 LJ3w==
X-Gm-Message-State: AOJu0YxtNXJxqjupxyG3+itTxBi4ZEKl1AcjZbit4lLtwz2Rnmi9ASJK
 qTF4h2tQ86uCG0vucCqGvPfTXE2CnQfoEVS40WykAjmJdqjbIvHHuc+inJ/sZ6atEIi4RytGCsy
 IMQ==
X-Google-Smtp-Source: AGHT+IF0I962jVv//zYvrqp12V/bHhVuDuGOk3Ch/xohzHRVWmFkfNO6iaUpeA3ISojmbyMxKOWhMQ==
X-Received: by 2002:a05:6402:3491:b0:5c9:1d7f:4fd9 with SMTP id
 4fb4d7f45d1cf-5ceb9263cacmr13559835a12.8.1730822456465; 
 Tue, 05 Nov 2024 08:00:56 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a41bsm1467773a12.14.2024.11.05.08.00.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 08:00:56 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, pbonzini@redhat.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/5] i386/hvf: Fixes startup memory leak (vmcs caps)
Date: Tue,  5 Nov 2024 16:57:58 +0100
Message-Id: <20241105155800.5461-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105155800.5461-1-phil@philjordan.eu>
References: <20241105155800.5461-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The hvf_caps data structure only exists once as part of the hvf accelerator
state, but it is initialised during vCPU initialisation. This change therefore
adds a check to ensure memory for it is only allocated once.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 68dc5d9cf75..8527bce6eef 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -239,7 +239,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     init_emu();
     init_decoder();
 
-    hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    if (hvf_state->hvf_caps == NULL) {
+        hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    }
     env->hvf_mmio_buf = g_new(char, 4096);
 
     if (x86cpu->vmware_cpuid_freq) {
-- 
2.39.3 (Apple Git-145)


