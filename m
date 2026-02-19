Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3FBE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e9-0002N4-LB; Thu, 19 Feb 2026 14:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dv-0001Nc-7P
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:55 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dr-0000OC-WC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so12333585e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529090; x=1772133890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8hIylEh0E74uDpZfZNSyL6s0sAcVhZoCd8DqzB724I=;
 b=sUcx6yvjQJu6DeG5zrlsfezdkujd+1s1266WjEDF6jIyOqUUyDHTSMYXzedwUp3VuS
 NHuyqeFi3UPMBXTWV73zTAmkAMyEAnq5V2HbPpZWKJanyXNzHmV6apJhL28Yf1hMQfpK
 nW/CAJpRiVc8RNLkoFFAgDBhhyXsBplDYOVUscGQc14a4mNznJDhCufvCuYdF0L+Vmn+
 SgDfwcmGb5un6fqByxRU+QB6ZhrMSEkKLNdYxKhjnSwKZTBZJGkY08Cle6wkV2yQgCqk
 1JExR1/OyIwu1L2p7Ko+pqUYoSD3+8bzIywuQbzXHtY6ge7WLyxxG2/JQvgqfIKf9/dg
 cWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529090; x=1772133890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o8hIylEh0E74uDpZfZNSyL6s0sAcVhZoCd8DqzB724I=;
 b=faCaSJP54SZ/1NpZFldmZxbgBtqSLnYbQHz/lH1Q7Lh2qOkeBArOWuDoZO/gTS+uak
 3DRPv5hOQ+JF2TrG5dayo7jzQ8y8KwKxpm8OtPWSSMbdhKMgotBvkVz3CJs9su5b0TIE
 J+leAYNDj9E1Is8mc+qHTnrFXaaBQhN45tzSaKpgjAZTXjX8dG2V04fbO0ATNPlljp9Y
 Rbt/0b+zsmskIHPIExUWnHMy6dVTXD3+qH8PPesPK4MQm5fU51J5qJ2TBnbtj7J2sjib
 Mpw7P0KaeTtX6twu/G7C23KXhpXCRYYn90FrHOpjfmv0n50TOAd8pjLhdVX3zkBGMz1V
 W7Fg==
X-Gm-Message-State: AOJu0YyyhLyfXaiBn5BXf5gsszy1IogV6outTmcCwBr9+WSPAP88h46I
 xlZFdd6ujSod43a7eR0dvx52QCvW7OLmLrkLpMZKW9owGLQrxnzY3U3WHEvW6opzaY57Qcx7etU
 9YmRGCBrDUQ==
X-Gm-Gg: AZuq6aJWjNUUfUu1CGJLNMZPhSiL7BZzZJfSzCAzA2ebZpQZZP+enyIb27V0ZPifj+F
 shawJlgVK0Az5CDRaGQ64mr9K5ediItJZmBx8Xje/Ephwj61dH7+oJnSe2QcVHj7WCV0/vyldLO
 KPaXkNDf3v7pbAPNmIvUFfabAOjtoGB8VbfccNVhB4FE1sQrz+2t1t8Sldyu3AFCYCEFeGnGm/f
 QmDDpYgueUaxk5KEfi9ohkth4fQTTeSR89SXvWR1ARgeo+JkglGegzQ8lK/nNonsUhC10Csiwsm
 MctGfHsWeJo2S3IS94Tigvie5at7eOYl3+h6G8bKjh1Vt9nKVfvAjIz86RP1W5PcEUDibQXH0Kr
 WF7sU9J37Fbmfa/I5SUTQvVc9scI7lVmRn4nHilHkRfT9bv6redFdb1KrUcEFjEltpYIbmRJhJL
 vPwbNDQn1GnF6gzqVLBRRoG2BDGBHEyizNZCZVzrQPv0ymMPJQgCrrkCTpdOOmc+uMzPVrgSIF
X-Received: by 2002:a05:600c:3552:b0:483:3380:ca0c with SMTP id
 5b1f17b1804b1-48373a636d6mr405620555e9.35.1771529090060; 
 Thu, 19 Feb 2026 11:24:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3e01c32sm1672325e9.20.2026.02.19.11.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 41/50] target/or1k: Rename 'openrisc' -> 'or1k' in
 meson.build
Date: Thu, 19 Feb 2026 20:19:43 +0100
Message-ID: <20260219191955.83815-42-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


