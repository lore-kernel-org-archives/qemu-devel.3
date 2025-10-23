Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3FECCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwMM-0004Jl-3N; Thu, 23 Oct 2025 10:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLu-0003XJ-PL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLs-0001yN-IS
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-427084a641aso655962f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229898; x=1761834698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y25iYUJ6/iyXKTCTBsNk+6avJFehWayKoJUbzLs9o+M=;
 b=EfWX83uJquqDhJRr5SrQO47izZ76X5ek5wspiMBZxnQnv/y77MfRbKSPvTFmscUcTo
 qR6ANg5d8/MMYukMed9OBf/D4vN+Z7fDX+mujDimlanWoOaHeW+9Y5fZaldVAgIGFUXQ
 604o25xKUn1WfREIfjZ0nZ3d3Gbm5atOwiwxMM6IDNAQkurb+RjSCbLom4XrZHWYb/d6
 nGeZLwEMUqrSTh83mmbzi2C13yPa+VENZe9HkhkQFyOWiziR2USUxLZSdhM06vuxaQdC
 mU+dCssqGN21/ODdNi0QN/1Tu1nNb1ShSLKh0QWxYcCCTS5Nc5R2KlCPefAb+vATk81a
 kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229898; x=1761834698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y25iYUJ6/iyXKTCTBsNk+6avJFehWayKoJUbzLs9o+M=;
 b=fG1SYfE10cSzObhKOfQFUA2A9zcmrb5kerQkcBB5SpqZ3WhDnWWiONIP8fsJ59cXZB
 oejwe/m+3osBjKNR9xm9yMTmvWQy6Ur1BoW4V5ptz5q8sCGHYyeHBlzeX1lCZxwRG4Dr
 t+dJVD5KLIVJBqHfMSO1TM4z1ud9NTB058mqsp5Nr+JuJMClGJAAi1dVybMCgPywxAwX
 ZBZLdH3oHZmV+RwAyhJY+DaRyPksgcOvn9qi80QU9M+EDE5q7UVIQbjlgDyBjubA1c5z
 e093B7wnn7KQ3Zx8ULHAkZv1MhFJDOrA8HTZwXT6ZEXeNYz6az9SfDMqfyZS6J9Q/0Ud
 8gKg==
X-Gm-Message-State: AOJu0YzjMI9PDE1sCC5Y0RzJw8OS3GbX60+vnZIN3gc15K8cTTZSHmjo
 D/GnCAnls2cj9NO06O/M6qjyQYhTi/Ry01+PqZustZHXJjbuD5CpWuNI2bgA1wLE7jDGuGNW2N8
 UpBrBiIY=
X-Gm-Gg: ASbGncvtd+gMs2BlD+WmxNe+t+OOyq4ovIFtL/Stxh7ToMzIkD2k+XiEY+SQVdIqsrF
 F1364WfxBXfJTgCZf2RI+SPtra4NQOhZIXOaIIdzj3AcIBN8HggqXqsmuzHByk4ZisDx/O7dbvr
 xND0hgA3atrNPCrYaRd5KAFDg1efaAvUrOtqCGZNdCvXLV76jQXA2b0zNBAaSzaotRy70uTX65e
 QoVIIydr+7xXcnSaygUU/njecqUkv5fZJNPEzqUbG6YvJTvAK2un0KLWq6sutMT4TNxuYHpdq/Y
 tW7oVFXxlgJs9UNVYrF3O2Cqps50z9EU1Y3dia+PrXQUqx8RKjCIP7xF68gbtp2Pni3Os/4OZ5Q
 qKjUpaJj0x4G8KS+td+TFvE3mpMrHRBEFTgtQLZkATOzvaU9+q1pq1wDwtW/LBMzjIFAL0Hv8b4
 4imjLF0wFi6pTSpVntdE4X2tMJbPzbZOBgZca9LoA4ZWGb+9Wnbk1Yhh2+SgdL
X-Google-Smtp-Source: AGHT+IEqqBDXThZqURPuuI0fB68PXXmmwPJNSvl6KtIlYTuzwmIFWn7M+haWwaLGYiiJZsnpUFFlmQ==
X-Received: by 2002:a05:6000:4285:b0:3ea:80ec:855d with SMTP id
 ffacd0b85a97d-42704d6c57amr16021787f8f.19.1761229897491; 
 Thu, 23 Oct 2025 07:31:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f5696sm4542822f8f.14.2025.10.23.07.31.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 29/58] target/arm/hvf: Emulate Monitor Debug registers
Date: Thu, 23 Oct 2025 16:30:50 +0200
Message-ID: <20251023143051.11195-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
TODO: audit it is safe
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 4fc92760934..67130ce27d2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1596,6 +1596,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         }
         break;
     case SYSREG_MDSCR_EL1:
+        if (hvf_sysreg_write_cp(cpu, "Monitor Debug", reg, val)) {
+            return 0;
+        }
         env->cp15.mdscr_el1 = val;
         return 0;
     case SYSREG_DBGBVR0_EL1:
-- 
2.51.0


