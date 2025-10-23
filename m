Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D0DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwMO-0004Wq-18; Thu, 23 Oct 2025 10:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLp-0003V8-Db
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLn-0001xY-Ce
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso4590435e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229893; x=1761834693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJPhtmNHwD4RyfSudQB2lB4+tgVTD2bBz5E4KUs98F4=;
 b=vhgwCS5kRVWfvpD2WCxrp9a9+z7CxkNFj3z9jDKiKxuAkbDJN5tsGjFfM0NIGdX5t6
 6tlL5lpWstMJ6ki1yFMFPrDXsiVjZjAwDGlyQW609O2XDjtDrI+ifcTvaDGkJevj8LR2
 x9K32ZtfG2a4o+0MXa5v4HjZ3qNDWalUPwco44s+ZW5cNHSfIxWllZz8J6d2R5MEUR0i
 HxFYyN80jm3cCc9GGAsT4BWvk9JQRaZAACLtxXaYuo9G92ofrboqod0OGj0lSX/ZTSiG
 8CTHC4jS7fmhK6yii3Llji9rV6xEYXizXKmbnwVDU7DqkI+7BDvgNo4uWLB4McD1lZCh
 zGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229893; x=1761834693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJPhtmNHwD4RyfSudQB2lB4+tgVTD2bBz5E4KUs98F4=;
 b=Lz/ANlTgqYTX5Iy6yupGrbvpzt8dU0Y5SlHhZUvYu7JMJdLY8kzbTkQwvJ9KQMn/Sp
 zR5EYvODhGoWNE7y00AkKE6hSE9sAsEyqvruNIxYylw0FCwwrEwjjuR6SmuYGDpSKlVq
 YxBGwHsZeSeZAL0WLfZKtzQFLvZic7T7mnHuvE8jhfrpiIoRAwRKyGc31YxG/a9dEa4G
 MxcGrEptxPH4LojAs5UMOJk12fwB7ZKv05g1LedmXGcX5HjP2SGmc/lIpFIguygsx/OI
 BWHTBo5pEedpQz5pzM8VPnrJZ40eVEryPkdjqqjN3B9Vt2KzP9fyi0DcrVuAnhzHyK6O
 AGxw==
X-Gm-Message-State: AOJu0YzBcXqhQAEhUv5tK15vpz3xt+spYBIvRa0ICfwvsYIs72pZGDbj
 VoBfu42v7PagNDOobr3E+dnDHv8a1EvScH5egF+dk75HqVjk/OtAQHAp1lDI/V8LEo/pFcn7jAo
 pedz/BSs=
X-Gm-Gg: ASbGncsxn+V0h7dIqKuAQyryV7IORtTl7XFGn97SH1xbJuNpnnPOZVmWYHxyXgoIXpe
 VMyFSO6X7olzYA7vAAZC87aLgankKV76KiRAm50mFL+k/LZvoIRQaDiMiU5XeR3VjF5KSKPqaox
 28BcftiwxHZBqwZ06Zooa2wdcG15/eF9vaRoXvjScvNhkuneBlrJhkLYc1D+q8v2tZXE68EwShD
 GKlqIepnpvi3cUY/gw7D30KeGMGCHjUk30J53o0EjFHCzTKq8RVmq4cWYY2eKEfMRqZYMw82QjH
 3ari96S6c2NzAqLGAMQXbQ3NyhCNmJcR344P+IN9dCdlTWUKq5O0+WE384IT2/gaRiLGchoDXuo
 +2SHCsG7I1aqEhACd2clDWyrZy4cXylYIVfCSShBCyA8aq/XmUYiTX1vovIY9U42wBxN0KDHbGd
 ZQwoKQxFxN5NLiyoRPJs2SbA8RzlcFJIC0io2eEPwNbg26oR9thl/FcOu8WFk+
X-Google-Smtp-Source: AGHT+IGTLm24JLDGYoibU7m+mWfY+5u1JheArmeOiHx2uyp7Ijs4kwHqOpR+EEUQxFTEbrfFp4iQ4Q==
X-Received: by 2002:a05:600c:4695:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-475caf92922mr19038425e9.7.1761229892652; 
 Thu, 23 Oct 2025 07:31:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b33sm99643335e9.14.2025.10.23.07.31.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:32 -0700 (PDT)
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
Subject: [PATCH v2 28/58] target/arm/hvf: Emulate PMU registers
Date: Thu, 23 Oct 2025 16:30:49 +0200
Message-ID: <20251023143051.11195-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/arm/hvf/hvf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 26bafee259e..4fc92760934 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1214,6 +1214,10 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
             *val = env->cp15.c9_pmcnten;
             return 0;
         case SYSREG_PMUSERENR_EL0:
+            /* Call the TCG sysreg handler. This is only safe for PMU regs. */
+            if (hvf_sysreg_read_cp(cpu, "PMU", reg, val)) {
+                return 0;
+            }
             *val = env->cp15.c9_pmuserenr;
             return 0;
         case SYSREG_PMCEID0_EL0:
@@ -1505,6 +1509,10 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
             pmu_op_finish(env);
             return 0;
         case SYSREG_PMUSERENR_EL0:
+            /* Call the TCG sysreg handler. This is only safe for PMU regs. */
+            if (hvf_sysreg_write_cp(cpu, "PMU", reg, val)) {
+                return 0;
+            }
             env->cp15.c9_pmuserenr = val & 0xf;
             return 0;
         case SYSREG_PMCNTENSET_EL0:
-- 
2.51.0


