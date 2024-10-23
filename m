Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A378CDDE6E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zmf-0001xX-Ke; Wed, 23 Oct 2024 07:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zmb-0001vY-S4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZmY-0004YS-Ca
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso8651023a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683844; x=1730288644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yP4SNsaEappmzZc/gnms0PRD/uAmEAQCRgu6RQMiI8=;
 b=klfGWULhvregkR5+7mEysgzylwl85S2wHOEeodVczX1s0fNewS03IH/lh1Cmkm4C0x
 okTPHotFzgTHl80SdQlJsJBrJyxYhmzITRM+JNYKScOadEMJ1VgK+xOVv1iTs7mrG4Q0
 5EQk+Yrzt/qCBjMXFz+dSFma1lVPXWD+UodeOmF6YxlL5t6P6XCe18Ls1Bvi33/+DmSV
 0vH68ZcxP9ppMeZPEEqUDb7JJNAfdyxCh8kVqNtsGMqet9VJ4Gm5DDo77VOYe4dVvQIR
 P1Epn1PqMYpLedAtnSQCTEEsIs1TY1TVz2xPcTIVNKnokJen3uaJuDUMQHV/J/E/TkxW
 NNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683844; x=1730288644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yP4SNsaEappmzZc/gnms0PRD/uAmEAQCRgu6RQMiI8=;
 b=rbyRr/k7G8OXGGlFvkwjLQHGIWImNL1AEv8vO2bH+CxCewWgvfKoTcL7nBijyXzyDV
 ++GP1bLBnmhddXDGmqqhQVE3vXDkW35gFsJECyXWUrJPQjJfbQCvWBZpXZbAndX8iR8K
 mHoC3SSrdWJupEonPPv7p/jKX6KiEidgS8GiMYDfixvtibP0tpB1D+SOzm9BM5MS4lwR
 Iu9qaRXEW6mthXmkwjuTZZfdXTJ09yQNyk96cgLYB9J1CshidLZFmv2x1+pt6x6f5mhj
 u4UmmBb+MxdnRIhUX/1/uqu0q41eqUfIXb+ZTFW8zFx0WgguT+yuV5fQ21F9XTcwwsQh
 hhbQ==
X-Gm-Message-State: AOJu0YyFxO34aGEd8+OckIJ84l7+djSIHZ/43ubq2Ki54rzxMPbTNTFg
 72e+EzdN+vAp7X1rtktO1pyD59w689U41yUzpkCoxfs6bK1pKWvE2cczxgHQ5+A=
X-Google-Smtp-Source: AGHT+IHMnbwSpFbIxFr8E05r4uLkxn6q0bmtEG4CkFZ2WZbJ45lEqJq6MM15OG/HAzJxk8Ota85Nkw==
X-Received: by 2002:a17:907:a4c:b0:a9a:e9c:1d8d with SMTP id
 a640c23a62f3a-a9abf8664aamr189274166b.17.1729683844365; 
 Wed, 23 Oct 2024 04:44:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ed3sm463602366b.164.2024.10.23.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:44:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B34075FC34;
 Wed, 23 Oct 2024 12:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robbin Ehn <rehn@rivosinc.com>
Subject: [PATCH v3 18/18] plugins: fix qemu_plugin_reset
Date: Wed, 23 Oct 2024 12:34:06 +0100
Message-Id: <20241023113406.1284676-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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


