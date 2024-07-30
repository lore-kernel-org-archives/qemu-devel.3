Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A9BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLN-0003lZ-A5; Tue, 30 Jul 2024 05:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0003dq-8a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLI-0000YY-HA
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3687f91af40so2217187f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332427; x=1722937227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jnq1VIda5vt4YzdNGFFqZt+A/PPj1CEI6DvJT2Yvga0=;
 b=MNys9gH9FeJdiAPthkLKpsm/+OuU9+kQgFJsPDGRo3bPi4Avf57S4CVJx87e4KiU2a
 4V7Iep1zNquD/y6umhxlsqI2/9y2SBA7ZPLfEZWoi3JuYt3+zMLOr24biJp1XwkYCobK
 /0QTtJj6MR7nBZFXz/OLq4fmQI96kiicktvLupQ/h0Gs7zEVTUOXDZUtepiWSP3pXToM
 2JL5zmASlUK/p995oavsSULUQVYx2OMHomQYPF5qXjkLIuUMzjBJPe3PuP9PUUWUJmHp
 0w75ATpnLJOdAtzr2mtRdt/lwr8K9HTPbVmSd9UFd9F0bhm2ccV8kuYBpRi3I9PuOm70
 WF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332427; x=1722937227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnq1VIda5vt4YzdNGFFqZt+A/PPj1CEI6DvJT2Yvga0=;
 b=Eq7iF6bGMBTr7VqCgxCMCg7jWio/R0ecu6ooDooviPposcShrnlqN+oWxKdkacJtyJ
 9f96hMhZ3IA/5ePr/L+v67Ip+hYvJwlo5d0v7bg2tHHQcBVPNXdr64tmN5lG0EVGt9R/
 ykE1SjFUmV2ikUVLsWZyd+ufu390zzqRmdZ2IAfe9tS3/wsRu+nrKZp5N9YD98K5l+l1
 /+3/HGKq+hYO3dgzPP4MAvd/sPHlKIh9NoShnNemaQNtwEp432Inje5JIOeAtHZmAmuC
 44y5S0zz6Ij6KRlXfwuNFbFrysX0tfk+aNwA/L2Xyi9E/Zb4qtIbXowgmCkHTSovTWLs
 vrQQ==
X-Gm-Message-State: AOJu0Yy+aP0NJgvVmc2V7o5KhMUzhCRkvoM/Y9KO9jghUXW3CUvZvO5+
 Tpa5RToK6PuK4nf6IjUDMOktXuHG4sreoVaXa3G3oQqfVsGSGzBQp43a3O+KjUWqdpm3EX1QL+I
 2
X-Google-Smtp-Source: AGHT+IEbatzJoLEHwPWAJMfqLoVakWUxs9c2O1RZ7HyfrkbJPjkeaZxK99v2Q4qXbMru5ZACUlpsVQ==
X-Received: by 2002:a05:6000:196b:b0:368:4ee0:3c65 with SMTP id
 ffacd0b85a97d-36b5cf1e6bamr6509864f8f.37.1722332426866; 
 Tue, 30 Jul 2024 02:40:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] hvf: arm: Do not advance PC when raising an exception
Date: Tue, 30 Jul 2024 10:40:06 +0100
Message-Id: <20240730094020.2758637-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This is identical with commit 30a1690f2402 ("hvf: arm: Do not advance
PC when raising an exception") but for writes instead of reads.

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index adcdfae0b17..c1496ad5be9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1586,10 +1586,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (!hvf_sysreg_write_cp(cpu, reg, val)) {
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+        if (hvf_sysreg_write_cp(cpu, reg, val)) {
+            return 0;
         }
-        return 0;
+        break;
     case SYSREG_MDSCR_EL1:
         env->cp15.mdscr_el1 = val;
         return 0;
-- 
2.34.1


