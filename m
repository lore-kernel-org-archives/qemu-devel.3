Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4654C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLWm-0000aE-2N; Tue, 05 Aug 2025 13:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWi-0000Vi-G8
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLWg-00052d-KK
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:32:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-458ba079338so844125e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415156; x=1755019956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOv0e8g7dpHxydsNkW2B2z60yaVe7rRVLXsrB8NRcV4=;
 b=o5vKEXjsuxICpKAkcOdYHqi4YyPznJebBCti5yE3Lgf+oxRwWLa2Km6jDMQ5vUsfK8
 bmn8JOMFUY0Mv1znauQWEA5DgUh8IOYoKn1OcvH8RVGxDAo9QRstC9J0sOGUiH+zR+pw
 bRn7dnWM32BTt7h+G7LUcm/UQ+CS+awj+fxh3X08SN6wwM70BGpAsrqp2Gydp3dCz+cR
 VVcYmYmQ0GGCUR0+9qRQ9s+MeFbNSwnTDTsEKj5gKiVpJoUpwp/l7nO8/57bv7iPPpyX
 vrZE3pKYZAASfZTns0XYN2uY6lJi4nQLHaivz8HrSlJ/O2K8sVU5DSZpkYgLTAD7CqJM
 5lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415156; x=1755019956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOv0e8g7dpHxydsNkW2B2z60yaVe7rRVLXsrB8NRcV4=;
 b=fYTE64+naXiubDqx8m7aiECKM6HAlDWaSSCFMgoD40DQUqLMJWpNRerFacocQMWZOC
 jwLmL/0e3qT7qrYOqXuTJ+WtcPVzCihBMFra0+ztEIhI8AKOICfDEohXvQ7K8EvrQyF+
 6Sw1ii3ydbEcPw19h1kLH6f8ZAzKtYg9zYdKshuPICXLor4/nrqP6y+EIZfXbIO9+b1N
 XaEqxWnyAWsj2CbcO+RIonPXV7lKPxUGHunwbGWrpOMCfNZVZG8bY0nd5G5wAZLPpnCj
 uNm5r2oLasJisnsEwDAcLwnVDrYWDwPqIMJ1mNMGCdiDqioI2HPf7V2jWbMzDoha8/YQ
 55ow==
X-Gm-Message-State: AOJu0YyGk19oi8RAznCpHs6yQiUzHCyAB7wv2lOze7ug8PgGR/vUO0kl
 L1Xf6ggVhX/FkVAuZI4c0SGeHe4AM5HntVyPv2YgKeffUK4cgscw2o40LMAZ9AwTLj5BQRvD2aO
 AVg1p
X-Gm-Gg: ASbGncv/D1t8eoerlaqkzCzuNeg0ZvD7mUCYDmd7O7fHSmzQY7wFeeB+iGwbYHmJ5+W
 Or0SixtE1SzdaWXV20I7/hr0EYz/oZcYMsxlxqacnIhIxHOhEmA1CvqNfQEpbAq21+ZxtAUq8vr
 LqqivzuVF5cay9Y32xcGgVfSCJcQpynCQoGtOv22VQSIMUz1/tCcR4nyOCZKdDIx+uLMt1LJaYH
 EkL/PdF1CF06ZCLJ1maQxy/m4gSjnNBpdhNyoYI/ch4BdlE/9m3z4Afab3VgrhR5FPkB+5+FXYC
 IXlHZkLL1ThRwHcqOyjzpotys6ZhtFcNXhp6xvcy6J9sX8lxqByvqmzTyLPUSk3vPxovJXurOy3
 p2Iyag2bqrX1JXqJqYzrl441lTtXzFBthlwlzYAswlJGVjmM4/v3+uYzefTIdFXs/5Gzj66Uz
X-Google-Smtp-Source: AGHT+IH5dxVVw90egUuFXwukH6tJi9+46IfHfaT0NaYEB2/6NJ4F1AqFQlDFWLFb1r/I2aq7hxBvVw==
X-Received: by 2002:a05:600c:15cb:b0:459:dbc2:201e with SMTP id
 5b1f17b1804b1-459e611e82fmr3946825e9.9.1754415156349; 
 Tue, 05 Aug 2025 10:32:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5843021sm15071965e9.3.2025.08.05.10.32.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:32:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/13] target/i386/cpu: Move addressable ID encoding out of
 compat property in CPUID[0x1]
Date: Tue,  5 Aug 2025 19:31:33 +0200
Message-ID: <20250805173135.38045-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, the addressable ID encoding for CPUID[0x1].EBX[bits 16-23]
(Maximum number of addressable IDs for logical processors in this
physical package) is covered by vendor_cpuid_only_v2 compat property.
The previous consideration was to avoid breaking migration and this
compat property makes it unfriendly to backport the commit f985a1195ba2
("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX
[23:16]").

However, NetBSD booting is broken since the commit 88dd4ca06c83
("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]"),
because NetBSD calculates smt information via `lp_max` / `core_max` for
legacy Intel CPUs which doesn't support 0xb leaf, where `lp_max` is from
CPUID[0x1].EBX.bits[16-23] and `core_max` is from CPUID[0x4].0x0.bits[26
-31].

The commit 88dd4ca0 changed the encoding rule of `core_max` but didn't
update `lp_max`, so that NetBSD would get the wrong smt information,
which leads to the module loading failure.

Luckily, the commit f985a1195ba2 ("i386/cpu: Fix number of addressable
IDs field for CPUID.01H.EBX[23:16]") updated the encoding rule for
`lp_max` and accidentally fixed the NetBSD issue too. This also shows
that using CPUID[0x1] and CPUID[0x4].0x0 to calculate HT/SMT information
is a common practice to detect CPU topology on legacy Intel CPUs.

Therefore, it's necessary to backport the commit f985a1195ba2 to
previous stable QEMU to help address the similar issues as well. Then
the compat property is not needed any more since all stable QEMUs will
follow the same encoding way.

So, in CPUID[0x1], move addressable ID encoding out of compat property.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Inspired-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Fixes: commit f985a1195ba2 ("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3061
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250804053548.1808629-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 251d5760a0b..673f8583c80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7885,8 +7885,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * count, but Intel needs maximum number of addressable IDs for
              * logical processors per package.
              */
-            if (cpu->vendor_cpuid_only_v2 &&
-                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
                 num = 1 << apicid_pkg_offset(topo_info);
             } else {
                 num = threads_per_pkg;
-- 
2.49.0


