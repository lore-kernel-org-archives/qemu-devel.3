Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C4FD15D9D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 11:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Cgu-00076c-F8; Tue, 22 Oct 2024 07:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Cgo-00072D-LZ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:04:38 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Cgh-00035h-59
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 07:04:35 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f84907caso6181014e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729595035; x=1730199835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yP4SNsaEappmzZc/gnms0PRD/uAmEAQCRgu6RQMiI8=;
 b=RBuwLTTfBoDy2tgBI+oVY11RuQeRF3xUZT1TVevJ11C2dA2aIj02N1b0qy1cqz2B6U
 V3mI/G1bKm3S+/P8drX95tSwmQFsT2IZfOwl/gyGRPPNOYmx4KCBk6dfGykmJTbWY0by
 p2S3aqYa5mn47g2mF/N1C+RDRwDSIO6CS55J+XUHpz9jxob4GpFns3xmkanuygEMDV/R
 zTFHss718oiHzMEoqCzPtcDtJA85kVYOgNOUPGggf75kkDWT0vpKFXr9/lBWzIBLnunp
 pAz+zlQoGkXAGaxI9xaauQtw2sDQP9XbAe7ArQ6QlG3i5uIqunDPFPRQXTqcX7erKQzG
 1N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729595035; x=1730199835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yP4SNsaEappmzZc/gnms0PRD/uAmEAQCRgu6RQMiI8=;
 b=hpMoDPw9UWuFUzuVoUl7eG9Ksc+Ox7K3zzJbwZXUt3H2v8T03Az1bo2TUQOeGBPCLM
 JfCCAmTPYqwhglVKIbuTapUKGJ+i1pCugLqWHkp4/y+csKykHrY2An2o+HKaHtUcnUM7
 J5URaD5THJP9yqx90QeHyoa9v3pRuvhjMfuEP4B8Thx8fayhnvxl33+oKQpvOXhlK9Ll
 6PJQcDxo4HnMAzs55BIXLZPE9LrpteI4spdNurWa/PALLcQCFZACa96F9troKxoDBJ6f
 pDBjxAT512pb1TzM6UDvXt2S/UoWLgHaV79AmTRkZXt9E+v7pFbpsyTLWuqW2kn65Wvk
 zDWw==
X-Gm-Message-State: AOJu0YzSdB9oy32RBHDmWlA73G1WOwPB2X3Eld+9G8r+YZ91H2hW84XM
 wu2swDnuPgjJY51SlhjcRMHtSq6cAuNSQ8sQ6MybYDdGBsToCNiKIFYWcKvTK8s=
X-Google-Smtp-Source: AGHT+IEerx6lkR1+H7tItyS3VilRAHodTVWStIRDZTkyjhuKwUz1Vl6o1rNVP7ypMvtICJM1uC4+EA==
X-Received: by 2002:a05:6512:3185:b0:539:f65b:3d1 with SMTP id
 2adb3069b0e04-53a152198c9mr7757327e87.21.1729595035308; 
 Tue, 22 Oct 2024 04:03:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c6b120sm3010139a12.59.2024.10.22.04.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 04:03:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62F045FC48;
 Tue, 22 Oct 2024 11:56:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH v2 20/20] plugins: fix qemu_plugin_reset
Date: Tue, 22 Oct 2024 11:56:14 +0100
Message-Id: <20241022105614.839199-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

34e5e1 refactored the plugin context initialization. After this change,
tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
one plugin at least is active.

When uninstalling the last plugin active, we stopped reinitializing
tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
This results in an error as they don't appear in a plugin op sequence as
expected.

The correct fix is to make sure we reset plugin translation variables
after current block translation ends. This way, we can catch any
potential misuse of those after a given block, in more than fixing the
current bug.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Robbin Ehn <rehn@rivosinc.com>
Message-Id: <20241015003819.984601-1-pierrick.bouvier@linaro.org>
[AJB: trim patch version details from commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2ee4c22bef..0f47bfbb48 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -467,4 +467,8 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 
     /* inject the instrumentation at the appropriate places */
     plugin_gen_inject(ptb);
+
+    /* reset plugin translation state (plugin_tb is reused between blocks) */
+    tcg_ctx->plugin_db = NULL;
+    tcg_ctx->plugin_insn = NULL;
 }
-- 
2.39.5


