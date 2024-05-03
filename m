Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDC5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s8n-0007c1-0u; Fri, 03 May 2024 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8A-0007EO-Fn
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s83-0002nO-WE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso11334825e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739706; x=1715344506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJ2+DminAMBhR7ne1mJVPzDapawzOzMCaGznDAzlaXg=;
 b=MNlJxYBB3woYKpnxO0ejtIrc1pAtUGax1j8olkw2ANawuy3nLCuMnWb2gnwJahhf5m
 vOpsooRhQzBYyqHO0DUkAC5wJLJukH+jevtvCeD01bqR2a6Ff8GFySyTBfAePoRHG62O
 SIz9pV/FjxZyi35shxmlmjVZJ+9AyPjs7NhhAvUHlT30Et1KTopnZHP7z8vypwFaQOCS
 wxu9beaJc+O0TWhzMtvxJRNqwOpb5EqiyJV9VDHn88QapXxlfZW1Xr6tC9Rv7PxXBXE8
 Ks4CE4Z/zJEhfYGZXFQJcal5YzEwD+k5QOR4stf4sZHAmeEBebUTDq3OAe+ZiiLq7OSI
 wY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739706; x=1715344506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJ2+DminAMBhR7ne1mJVPzDapawzOzMCaGznDAzlaXg=;
 b=n4aQ8dtU4GvZ9prPGadNvktwOEkGTKPtDuM7b8qxfiemvtaWEGpP3es0x9SyHb2lNw
 E4MiM3WZFKapYbQXcoHFt6Dz4rqPrLmz1my+lIsVIesaDyVJwQcCZE7C+koVN/qS4HDD
 hsl7nzmHiQ26R0TXh2VcB4PqlroyymkMlqTEOPhDcqvaXD8F2GdwEknSGcHoLK64xrN+
 Xg78uW0TGLZjaaNMxCl8GBCK0m7y/SAJWmT29alyeOTp9WbIMU4Qy41u5xIQx898otoc
 zOpOKy8oWuhhcGogefMsUN0byvI9yR2DvPOkCcohvoRpKZxMD/vaFTiJdFtkANvVmomD
 EyvQ==
X-Gm-Message-State: AOJu0YyC6Jck7JlytYEQa25+Xh1+ZaNcWquQPq1f70nMoa4NraNjjxs+
 7ODMyvU46IrzyLIVeN5uTTVJy+VUBqwsj67Zp8kZCA004kg29i58aKWGvVrpUYSL83b7j9Q7Zbe
 W
X-Google-Smtp-Source: AGHT+IFeu0CbcdYSV7wYAgXyLrH/jcr1cw1T7GxCvYWl5IqcPzaXLZd9FKC5ooZGhpXE9MU4RWH4Jg==
X-Received: by 2002:a05:600c:4f16:b0:41c:66:18c2 with SMTP id
 l22-20020a05600c4f1600b0041c006618c2mr5073169wmq.4.1714739706095; 
 Fri, 03 May 2024 05:35:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0041ac4aafd3dsm5500179wmo.12.2024.05.03.05.35.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:35:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] accel/tcg: Move SoftMMU specific units to
 softmmu_specific_ss[]
Date: Fri,  3 May 2024 14:34:52 +0200
Message-ID: <20240503123456.28866-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
References: <20240503123456.28866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Currently these files are only used in system emulation,
but could eventually be used by user emulation. Use the
"softmmu_specific_ss" to express they are related to
SoftMMU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index aef80de967..84826f043a 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -16,12 +16,13 @@ tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.
 if get_option('plugins')
   tcg_specific_ss.add(files('plugin-gen.c'))
 endif
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+softmmu_specific_ss = ss.source_set()
+softmmu_specific_ss.add(files(
   'cputlb.c',
   'watchpoint.c',
 ))
+tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: softmmu_specific_ss)
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
@@ -34,3 +35,5 @@ tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'tcg-accel-ops-icount.c',
   'tcg-accel-ops-rr.c',
 ))
+
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
-- 
2.41.0


