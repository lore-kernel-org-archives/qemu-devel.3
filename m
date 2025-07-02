Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B9C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bW-0001VE-3f; Wed, 02 Jul 2025 14:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bG-0001Dj-Ug
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bF-0001gs-5b
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so138849f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482467; x=1752087267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=MU3/H1Ou2TCRoxdz6bC7/BnLIZBJMoNxDm7KSU+aPbjA+uqnZ67KEA5cPxvB/Vi+e2
 pxoANmtOovahphLClSEMXnhJlEUw+qE5k1pzq7ki0fUOc6xnRbzTxT1Qy/WpkhZ9GFji
 nKtf+A0K17OaK8FIZbejWCXprNYDv0v05qqCFy/6OgtL5/rbFCWRrSwTEJX0KRlaoDEu
 KrU+L7Ica1ZGJWjVEnWaOoe+MHpaK6E7WuVhjfps6R4L68PGabS9Hh6MRVUXssseUhSK
 boMtdFfsOvTZlGiJZw7g5TdC975DnYewnjd1F9UK++4bVkQ6XKKq3NbS7rrAxV0jRaP+
 ZTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482467; x=1752087267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAzT+CGbAi3kvmYQ13E5MHk/eJNqjsj98Rjqkr8WsQ8=;
 b=sopxn1oXlR5XwOkp7lkg0zwlr9+kKjBQE92agNHirDU28LxtwPACKQzd0sMwP9bu8u
 kFdovaXzSTIO6bO2zxCfIlEH399xSJVqDi8RtTENIpoVZKa/bBOILylyZaLXCzdUoM3w
 tlnFGdBtCF7BsI2QqjjYtB9M/GHwuLUFSFEEWauD9eGrIRIKWH5dk0PaiSETOrWmbbTB
 4pfzZmxwn4MvzoWbST9VBpK7xLRgRCbKNgOtNmUj63tcPT47Tfl3mUsCYjQLGWvOy1Az
 Bk/Ojp4JITjB7HGC9l/nuASYOJm9sZPFdGHDx7TQIATnpznu/Ntni5t2t2f6/ZE+9BYy
 5I/Q==
X-Gm-Message-State: AOJu0YyrDVZA7TRp4DRNZ8SX7GPqh4r0r/VXo/kAt25S3gZq13UZ4h5v
 dD5L0QYCzN/Bl9WdnEr7KcHiiaSxY8B4FUvklzkUmEjuOUBSfN6fMiw8g+tLqeRr53bNHrACehT
 DzgWB
X-Gm-Gg: ASbGncsRx1/Cwj/OVV/ifkPhoQG6773vpuXEymIxSw9q86UeB991RIjnelX08dd3Ldj
 L6suW/WOHv6tlDQBhEgFkm2JD5LJRIMczIfJQLay8FLAh1DtaDiw1HovXWPBqPBB0RZwWlmJNQL
 g66AIZ/BfAPGmLDjq2+fDUTM5vl6OAp9olc7AxQHxKcxk23XoWGj7YL5Nrfv8QHl5j6JF+X9C8K
 oEQihEiqd2jI5UQK+FZitCeNO+8V72Gbfi5ej8G86+6yQZB4rrocz4Rqv5G490Nz4bTmARqrQ9V
 J5T+9awDcMCBK4HSJuYGgzqE/3hz2JUDEI0Ac/pArCWTCG2uDgPmzApWZGVIOt97LiZFfva9WTO
 EViiyGu845nKjv1sMgXNIzTGnAFGmVQSth5xc
X-Google-Smtp-Source: AGHT+IGSKjhsY9WI+hU2cySKNu1KrdU/ewxeUTc3VHcwvz5y1+FZQKQjtqw1T9mRm+ZdNPKinWfA5w==
X-Received: by 2002:a05:6000:26d3:b0:3a4:f7ae:77c9 with SMTP id
 ffacd0b85a97d-3b34281c504mr29220f8f.5.1751482466958; 
 Wed, 02 Jul 2025 11:54:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8absm16997747f8f.95.2025.07.02.11.54.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 07/65] accel/kvm: Remove kvm_init_cpu_signals() stub
Date: Wed,  2 Jul 2025 20:52:29 +0200
Message-ID: <20250702185332.43650-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ecfd7636f5f..b9b4427c919 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,11 +105,6 @@ unsigned int kvm_get_free_memslots(void)
     return 0;
 }
 
-void kvm_init_cpu_signals(CPUState *cpu)
-{
-    abort();
-}
-
 bool kvm_arm_supports_user_irq(void)
 {
     return false;
-- 
2.49.0


