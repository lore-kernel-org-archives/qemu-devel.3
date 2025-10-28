Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10447CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd1i-0008D8-Sw; Tue, 28 Oct 2025 02:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd1f-000880-GT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:17:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDd1c-0007Pm-6T
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:17:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dd559b0bso39457375e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761632259; x=1762237059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=luFp37YGOIX3Bw5w3vTIfwbAV4aZTiynW7gF+RlUsGEcF6PtCTgU8SHcGxcMqEEIbj
 nVysFtktHLt13cXoaex2ahz2NzTkGQZ7f+zxe3BkOYkj3MDTQwHWMTBeaE0L1KTEHWVD
 V5EzF4RMSDeV3dA6h/XxYSHvDe1O3DYian6VNJpec2yW1uEBXc4VVgkDryY/e02/Vrnd
 VWLqgiD+uNr58PQJrwTiWlB8zSYRaRxU0/yXltiqQRPYOXksksXtyDu0rRs/ui1RXtxH
 iEPlyq7D1xEd34XGdzOuFTWtLsd2lxjYAk//4ZCJga37qxZPzhnMR3V5NJKMo354ojXG
 lo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761632259; x=1762237059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMDbgyBSsHgV3ZURAPo979wxtIvTEY+Ozps1vZGgi5k=;
 b=iIw02AP6ts43sdR0Cl5seIRCV9FNJP4Zu1BKnDwiqHuyqUbCHq0p3XiMOpyx3kMsCD
 7afxNRtsyqJgO+sXiRD5acOc64lJ2StwgxdZMLuy9LiigfhqB+rxfDKzARmIf4y2kMbC
 hslOS5daFGXVrJ6KuBJLWILaqGQWjcWU4RnvSAJwBBBC3AdgdD+wFe0u/rDlTVVea62E
 4iHYaapN2Rje5/Et1rWfsoZEeVK8iEzYhGyRJQlpVAllNY1I5ej6cPOSGSQhLqFgMuyX
 Wv5j1qPliG8jhKLe5p3RKmf7jpkZx/nMypNAXulHeKI5Z+Taow5YojsoNt9MuCDS95fv
 55+g==
X-Gm-Message-State: AOJu0YwJPdjFqbsQpV6oIOWv+6LK3Eb7HlGWclrelQL0ryLuE4SrZdKk
 rE/zVr13tG0K7ZVAf5rGNWvHOyFU7ObUwsDHtiOg7OMW6rGBxJTDGXHqIGSMoEf0V7REeWZzhU7
 bdAoxK2c=
X-Gm-Gg: ASbGncu40TFLWXzc52LQF2M42Gga3hGBWRSa0u3XCDAzIxcR7s78jSAAvcizTNpRn9x
 KAURIini8GW2ciEOgfunVM0ql5Xy4+n1xKBFIsmLq8YncjkxoOz5OEbTxzvKkQUFD/IfzAVtN6r
 YUeY0ulNnC7SJsVGr0H716KzliHJhEBnP9ocNHFyj3i4iOmNywVYLzxxKg+0CxY4g6H4G8w68sq
 LGYfO09uSNxT1G672aUtC5R7J498cFFDejo4N009ZxUcHsfrxP0mClvDHZ5QPANZ0bCgTMIPzd5
 vpgArjwTudPvEze5CueAgtNp7arge7XGznLwlezjy7g/KIG3SYosQVw3mJjpQIlA8pvhuvK55W8
 9+qqB48EAWNNQfi9i6aejfRmtc43Swp7ar/elREmtjjdmmct3OE2GSZoghT23josqTVv2cLQwyT
 XMce1vvf2JRS7OSwratLxSEwU9m+iMw0xLnO/sKI7SnIjYN4NzbR7tVEw=
X-Google-Smtp-Source: AGHT+IHFECdAcgICkOM03nPICzPy3sqpxv0NcVT45a6B84vKnBiT0HWcTNsWo1qMOIGI9Ucb2UUU/w==
X-Received: by 2002:a05:600d:434f:b0:477:19ad:82b with SMTP id
 5b1f17b1804b1-47719ad0cd7mr4564955e9.25.1761632259374; 
 Mon, 27 Oct 2025 23:17:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771843eabfsm12929205e9.2.2025.10.27.23.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:17:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 49/59] target/arm: Only allow disabling NEON when using TCG
Date: Tue, 28 Oct 2025 06:42:25 +0100
Message-ID: <20251028054238.14949-50-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
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

Only allow disabling NEON when using TCG.

This avoids confusing user experience:

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither

  $ qemu-system-aarch64 -M virt -accel hvf \
                        -cpu host,neon=off,vfp=off,vfp-d32=off
  qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=off: Property 'host-arm-cpu.vfp-d32' not found

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b392374df98..eaf76532eca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1460,7 +1460,7 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
         cpu->has_neon = true;
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || qtest_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property);
         }
     }
-- 
2.51.0


