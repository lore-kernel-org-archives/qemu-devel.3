Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C7AC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2cE-0003JN-QR; Wed, 02 Jul 2025 14:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2c8-0002pN-H1
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2c0-0002AV-QS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a528243636so4567077f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482515; x=1752087315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEXuTiZx4NBtgct91pluD9hB6GRxEbVAf5qByawcXe8=;
 b=jiHt5unROrHcP4rqicIJxknx2jsIaVzue/GyxE28bAtZSsYZGpo4aukl6h5Ov6TMYy
 4WB3x+nKc3Hyyj7AEqPsm0P32g4l+Eshq2kPeteu/7Dd8TWi807QCQXGTuK5BXQpGavq
 j3hPzBQv2zlKFximBcAhgoii4fp+jCIIWXlgh5Bbeye/ljnBIM7seqhftSdCVHHYZm1h
 qLZz2cWa3Nv3yBRnRXY0gZ/+nVRVL0XOcE8hG8eJsHgdrjZh7wVo58JzodECCpYFdcep
 GAygHdMemQ8lBcTFw6EcOERe4IROBg3gPviZNlypcu1l+JpQ2l88t7krUgjdStd1GvpA
 DZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482515; x=1752087315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEXuTiZx4NBtgct91pluD9hB6GRxEbVAf5qByawcXe8=;
 b=drjn+V4TxQF3GEMsX3Ox2IA9EAnpHAlGkU14l5FpfItMAk5TOlXMYcKl8gL/kaEmVT
 QdJivTR1eR0Uy0Di1tFKChvUwQ0lkQ+SIpMcyxZIHVhckfzmiL2Iupb2W24BQOx71HG7
 7EcY3+t2TK5WysOMo38gki2+DHT6wVcwRivqJcJYI2ysEzkBK866HWd5qiig35SGDI2I
 h26KodkXFwSyEChBQzZo49WJ21H55DyBEhm8w8Qh8ZFCXMPMgt9nTGvJf99Jfn1sCDUF
 8KzQHsP5hHWW1u06OlVQZPj6DhZgcr77mmDaOuAdEGZFbvH+R6PKD7TwEfpRfWzyvGa+
 TvLQ==
X-Gm-Message-State: AOJu0YxHe5DRHB0/SHRIE8EBpUnctMbXQCxnMHjzdjwGcLV6IIS65yye
 uHsdLMMtdmshDZFsDg8tp6pb/iI5pyl7aOekusK4n/Ep/bhrIZevlJ1qT8zQktXBDgDY3UrIHdh
 EtBcE
X-Gm-Gg: ASbGncvF+TRDtHmPK/gy6nNwSMBqPsqv1wWnwCUXF/pcuCG7o3PkJQBhihBF8aFG7Nc
 5qMZHs+e30wS9QTqnwUCqSjCP8P+WV8VXZdlq/yEEkY+IRe3lqafRtV3RLaaZjOqn6ltYAf5tq7
 /vKFokzgJFrP90O+qyRzj8eJy/TmJ3zhlv6s4Mtaxua9bn3skvOmVUwJlQFHxI0gRF+HQ8PnaFm
 qYU3XlhwiC0KgKooPeSxBB5nm+LtedD2S34dyHADPfeTJ96abfVdbnn0uVCCKl/DTUwPJ1CHymD
 u4XIWogKIJD5kqcFpuEl675HouegzYRfBpS73YPdcH/Z5FprhWPy9e/pRM6HoJREtQJuSv8HKae
 kmU2wQHzix881W8KOzX/w2+aoDTovKZ4GvKma
X-Google-Smtp-Source: AGHT+IGC/drp3yMryelqlsaojOmXUZ2K7xqD5U+6AbjKxisbXRDLHdj212ng2Dwl9BWxNzsTwldHpQ==
X-Received: by 2002:a05:6000:651:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3b32f383792mr212092f8f.45.1751482514898; 
 Wed, 02 Jul 2025 11:55:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c8esm16870330f8f.55.2025.07.02.11.55.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 14/65] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Date: Wed,  2 Jul 2025 20:52:36 +0200
Message-ID: <20250702185332.43650-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f641de34646..6f6f9ef69ba 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2470,13 +2470,10 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
-static int do_kvm_create_vm(MachineState *ms, int type)
+static int do_kvm_create_vm(KVMState *s, int type)
 {
-    KVMState *s;
     int ret;
 
-    s = KVM_STATE(ms->accelerator);
-
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
@@ -2646,7 +2643,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    ret = do_kvm_create_vm(ms, type);
+    ret = do_kvm_create_vm(s, type);
     if (ret < 0) {
         goto err;
     }
-- 
2.49.0


