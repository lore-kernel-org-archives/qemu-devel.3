Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6629CFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAc-0007Rg-I6; Wed, 25 Feb 2026 18:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAa-0007Qg-JA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAZ-0003UQ-0O
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:52 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483a233819aso2862595e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061589; x=1772666389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Tr/RjfOe6IjCItdEvRBAstz9dZRVJOfGHzOcEgiwtI=;
 b=H/Gd1rNQOjIS87vVCxK6MjdHbEsagacOw+18IuTaxLyO4GnY6aIs61k743wMmOXJm2
 23YEXkTZVrZnJp3PGMP+35mGxkzYK7gDEfRvC+BnWZxDCwn+LwrK3sesgJV4JtYiqpuT
 X4NrabKZekDcnWbFdQLEo8lW625cCcqKzvO8bEaHM80FP2NVCqOX6kZFLLdyVhPuptpy
 6QLWfOHqEK3+f0ts379kFaJr8t7p8EZirQvXHcc77a1WXGngRLbH9sSMpkE11F/Hj60v
 0OnfNU7kjI/SrsQtr47Zd/6pdLoUkmfbIkm+ylWexI67hQr4AXPQabIWWWsIdte+1Ft4
 IS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061589; x=1772666389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Tr/RjfOe6IjCItdEvRBAstz9dZRVJOfGHzOcEgiwtI=;
 b=KCPAU1HesDAzxejJO/BLl2pzZS5+V18xGOrzs/YFTfgCmjAWLHC7ApZQuQrBb747TA
 8E7yxolcotGruU/zBB/n4lFq2Uk3mTKY0Bn+CS3JPgCsDyNq9K4N9fDcLckeeyTdx5PO
 WA9uGvdpgGI9fkLH8+nfehC+TRYVWOibcR82hzIKxe9Q0mEFn/lNVCFy3dggfhzzXiM8
 CPxYijmMAOpSAdfumcTLYoQObZEBhQoMVmHPnxJ9v2eAvnJuJtqkvBtCcjXWEzugeM52
 UmuO6vD1pH1RtzC59A84WyIdfaiOjYADWAHkwq9N5Vlp6nq13Z06+1TbpjxZJDHmjqkx
 /riQ==
X-Gm-Message-State: AOJu0Yyv5VzVZMJldIFOJarpC1f1PaII062KKS/djNAErcAiDnEWlGg/
 OYiBQV+b6PDpTMgP7GARtD0lnCsebKwe4uYeY/167jcJWZC+UgM44ZwbE6DJitSvqV1uLTiX7Ov
 Ol9u22Bc=
X-Gm-Gg: ATEYQzxA1YgGSjHQwn3TNz3P2QUBMPKWcwVTqHgVIuDSXLv15IdtzIYBRCW26EEC29U
 DoqzNp6e4gKPVY1V11GPyDsTBS75lpJQbhipHdREdLSp4X6vI1FrVrBkBiwARrLwN4M1emg5rqQ
 40D1YvWoq28W+R2VphKjul/j5E1RAvKkBCAv1vQWUKy1wP16rN4GEWyZT/dInNkA0VoP+hNqQAZ
 //DyKJaT8IN6ciWU7IEgSb6cv6I9VWs2yC1jRUgSGH+MzV2N+3TEuz6GRIB84zKDrp6e1k8pf6i
 SYFpRlz1yr+hMHJcXyx5t5Y7CwxSnBdOfNTKub7LRxZlbIO1q+bZlrGo+mwqoruclcYW6Ax+ZaF
 8W3YB3bs00OuuR37eiZZ0l/5gGhsxfwQhBHZIlnlWT3pA3CkBipg6IcXZ/RNNJXKMOZ1n2B8L+4
 364Ro73YWxv3teTsXTi4ZicehIBEPh5C3gtk4YB5yo9vVBB9GorXavRioWBGWBVz8yeuJ7/70l
X-Received: by 2002:a05:600c:468b:b0:483:c35d:367f with SMTP id
 5b1f17b1804b1-483c3dd6fd2mr1468025e9.21.1772061588932; 
 Wed, 25 Feb 2026 15:19:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb77437sm21740475e9.3.2026.02.25.15.19.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/70] target/or1k: Rename 'openrisc' -> 'or1k' in meson.build
Date: Thu, 26 Feb 2026 00:13:49 +0100
Message-ID: <20260225231411.96482-50-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Follow commit 62822fc7e0f ("target/or1k: Rename from openrisc").

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-42-philmd@linaro.org>
---
 target/or1k/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index cad8c1b1ae0..cc912ee6cf9 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -1,8 +1,8 @@
 gen = decodetree.process('insns.decode')
 
-openrisc_ss = ss.source_set()
-openrisc_ss.add(gen)
-openrisc_ss.add(files(
+or1k_ss = ss.source_set()
+or1k_ss.add(gen)
+or1k_ss.add(files(
   'cpu.c',
   'disas.c',
   'exception.c',
@@ -14,12 +14,12 @@ openrisc_ss.add(files(
   'translate.c',
 ))
 
-openrisc_system_ss = ss.source_set()
-openrisc_system_ss.add(files(
+or1k_common_system_ss = ss.source_set()
+or1k_common_system_ss.add(files(
   'interrupt.c',
   'machine.c',
   'mmu.c',
 ))
 
-target_arch += {'or1k': openrisc_ss}
-target_common_system_arch += {'or1k': openrisc_system_ss}
+target_arch += {'or1k': or1k_ss}
+target_common_system_arch += {'or1k': or1k_common_system_ss}
-- 
2.52.0


