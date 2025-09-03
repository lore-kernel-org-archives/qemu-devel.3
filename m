Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9244CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkS9-0006gB-Hr; Wed, 03 Sep 2025 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRT-0006FH-R9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkRR-00009c-P8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:10:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b84367affso36722235e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894210; x=1757499010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpXbEQrpDK50SMvtUWoxzqhUJ4k4wz+AbgMYLSbErPw=;
 b=my2rq/M1EI4TW5A6prlqirdmwy+G1K8sQEOi+svI0PDo73XvHc6msaq0uk30HQkbY0
 MGBVV6PDhs3/87RbGnEYM7spOYGkReTRNtRqSvaO0pyObs1E1NiguMphv8bppggI6Mi7
 ldWFLYoHv7T8d4MDxeOdV9H/ygXM5CaQk/eLW8mSc5mjWW5alqmhFTCGHteULmupcLW6
 H/L0cOFR8GbOltC6w02WMnEufYQTgW+QIg8VeShpTwWDtfYlcD26vhsS1UwKcL6qd7nB
 xkkkhachywE1LoiGr3YSkONbe078OqStXZ9Y/SpiWe9+E5MXZi5SsDk5LcVoVlKkHXIK
 opwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894210; x=1757499010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BpXbEQrpDK50SMvtUWoxzqhUJ4k4wz+AbgMYLSbErPw=;
 b=N9VKEWj5wG/629Smak81zQQjR5a7k5aYfYJjSHB47IB28YL5AhsPkg7OoQFlx2ya4F
 /xvaCrjspBnut6199Cm8dIwH+9MsN8N7UVAkPfZCGOGR+ZDuqB+hXKPMYR5rxueBK6fa
 geNz/oA2KaltMtMYLwx9IWzRO7j5QEf/6G012ZctyDojI9XuJPR5CjQyqS/DqeRi3hvf
 UIo8Kg/kA1dJ4gprm8axXC7n3hQp1jU1OpUniEgQpVLXiIHYh7Xp+NnI77wZ0OVe0B6N
 iGxRFLV8s2PDG+gHTSdUsIJa/H8X6f9qSTleJTEOZ+v42/Tn/nuwZJd2DmtxoZRouLq1
 4F8Q==
X-Gm-Message-State: AOJu0YzcKIpIESYThyel7wHukHjS+SbySjljJ3259CqYUvD85F+3kVb3
 0jq6jLowKxEqx1KBQVKtrC6spPoW7gz5WlyuHt5nSJ60XXFDhZMRj1qj73UpWvwA+6unmPbCon1
 SOxEptgRg7Q==
X-Gm-Gg: ASbGncuIgaA/D/KvA+L4QpWEDjj0xfhYZOMZkItMOXE8usPHP6i6oODwt7DwiH03uD7
 8ITsfa7Ddff6+yfsozds4if5zAbAu3OrAN2cJJo4wjoQRsHEn2pRr7GKawq8HTcv3cZDCS19DTH
 1L7VyB6N6U9nmB54BFeHPxloNnPg535auDEWAfRotHN2fG67i0PBseziir6E9OIWxJQNZPo0you
 tDqH4+YMUSI+u4TVhFAAGgNI26cbIqG6k7dbSAZygLeFa8hXAn7XM4sXoluQqQp8g3hkGMnFBp8
 ruYvjjIDVBXBgzC/WMxOYRogOAsDNDYsXY+E/79PS/QRqykI7NJTghlps4P3CNDzFxsNxNMKDDe
 lC7P4V1Jc+dZA6j1plFLiogKcZGxWlS5TTVrnxaZdzcYQAJ+C5Jd21VHuf+ekPcvF9smimtMHCV
 Wr1BU3Mw==
X-Google-Smtp-Source: AGHT+IH9fcHFERGeULzOi6U7b9bTjsQMBq100wAXosiiqaMXG+O1tRl2V9v2vrhTxaNa/exK/C6c3Q==
X-Received: by 2002:a05:600c:1d07:b0:45b:6b57:5308 with SMTP id
 5b1f17b1804b1-45b855508e0mr126523875e9.7.1756894209562; 
 Wed, 03 Sep 2025 03:10:09 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a1f807f9sm22217368f8f.38.2025.09.03.03.10.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:10:09 -0700 (PDT)
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
Subject: [PATCH 22/24] accel/hvf: Restrict ARM specific fields of AccelCPUState
Date: Wed,  3 Sep 2025 12:06:58 +0200
Message-ID: <20250903100702.16726-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Do not expose ARM specific fields to X86 implementation,
allowing to use the proper 'hv_vcpu_exit_t' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 195d64dcf18..3d2be4092ef 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -59,10 +59,12 @@ extern HVFState *hvf_state;
 
 struct AccelCPUState {
     hvf_vcpuid fd;
-    void *exit;
+#ifdef __aarch64__
+    hv_vcpu_exit_t *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
+#endif
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
-- 
2.51.0


