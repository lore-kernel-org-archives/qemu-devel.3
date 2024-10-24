Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FC6D0E3FB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43jy-0006NO-4F; Thu, 24 Oct 2024 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jp-0006M4-6x
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:17 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jn-00080s-Ad
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:16 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so189569766b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729798993; x=1730403793;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULV6js8+Kl+ICVkJYfpF5H1/0wNopvSfTu+wRnziPlo=;
 b=BM/tuZ2zzH6ejmDpBkJjs8u4mY2wew7sCFk4DbdX59EBKVo3SFkoF0uq0JB+MTkIYT
 EJOrbl26VQdztepBJ5bV6fQ6jWBGa/3iykLyZcLfQ0TfdH8x6qZZ0KQKW121nLHb41AZ
 aTWzd55U3nS95C0xLtZh5oM/qDBZ7iUCdeOJd2QdBCtAbBeNQmdzMCEx8gjSJshkkIt5
 CiZyaOp+OXdi7B4o9K+hwrBaq4bEuAZS1KJ6cvFHpYHsFqRY2LvLFxoIvgvRboerxGg8
 aS0jR6p3u7VnLxQyyzfcGp1hi8fHrc5ba2ydOXUmMfkpJAXgdtoROHXxaOEfqcu1U9ZE
 +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729798993; x=1730403793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULV6js8+Kl+ICVkJYfpF5H1/0wNopvSfTu+wRnziPlo=;
 b=jlBl4Ci8Lklj7vjIqv1j8dD945A1useUofXmbGv3h0LVVUQrhjnbLZmEzXwodBsRNS
 LdaOPHWEjg94HasH7vIs5J8CaKw35S+/UAyAeDqpTRAPlZMQrbGARX69a8Trx3gSzzGC
 wLL+i7tkpUTh7H0dABke+DhM5h5dZDtkDmrkqLc0V1W4KXH4vgq7Y4Mu4cBDQgylqgRR
 KdbaJ2t9RK/2+qr/9yAiLLIOAyzvY+YczKM7HZMhi4buMu4vuEDyHLCd3954lboMHPaP
 Nqvjtb4N9XWRz+73lmAmPFjr7y7l9SUBNJSqVajB/u9J2HNunvrPMIRAZs5Ft7JueMtM
 YFcQ==
X-Gm-Message-State: AOJu0Ywmn4GJy9GY+j/9IzFMer32JHRgYiTUtzAfdkjjbgj/QiymSEEz
 ovJXMiBeES/nO6WRrRKjNB/XCXkO/vVNyVSXKFu/tSGP7gQO86K6mIT1I06oKQLAAj1wCqLQtj5
 pYA==
X-Google-Smtp-Source: AGHT+IEj5AGylXBG5arNrL973HtKj+0OGlzvBxsNQbMQsIzmhG1GYNPDl8FTZr2cY+/4PV+cHKiagA==
X-Received: by 2002:a17:907:7294:b0:a99:4d67:eac1 with SMTP id
 a640c23a62f3a-a9abf96eb78mr679419866b.52.1729798993426; 
 Thu, 24 Oct 2024 12:43:13 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6545sm652536866b.31.2024.10.24.12.43.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:43:13 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/4] i386/hvf: Fixes startup memory leak (vmcs caps)
Date: Thu, 24 Oct 2024 21:43:01 +0200
Message-Id: <20241024194303.32100-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024194303.32100-1-phil@philjordan.eu>
References: <20241024194303.32100-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62b;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62b.google.com
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


