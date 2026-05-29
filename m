Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125CCCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1lr-0005hN-NN; Fri, 29 May 2026 14:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wT1lp-0005h6-FJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:17:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wT1ln-00033y-9f
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:17:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490686877a1so42776535e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780078637; x=1780683437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ov3KLWRcK+0MkbGkn9F2YY7Ip6m7E5y5ES5E8QNzB60=;
 b=q4y8TgQNjNJ5VA6gZAqjHH8oQfz0RMb2mxLIy9WV9GIxcdoodxSNbdlqMmnoSzI45w
 1ldfuCtXVYAFd0r3VyHLHi/kg95JjBLSEVoNAnBFKEG5MPXgJvur9wzrgI6qrzTUSXjq
 3KVPFwDexs2kCjcZFkkmCrfCtz5MdrZonZe36BiRee6JMrFpyw9X///6rFBGGOHg2Dp3
 T7lN+VlSXsCHGi9rHkqvf+QG3zLJ7SpccK0OvpsZR3z4DDtIOSICp4qi2nQydJaP6qP0
 bnOu6PHlMqi1QlUoT8X8Dn6goENrYRZqq/ysLlIuYLTg+ylp0J7xjlFgN8pv8IKrbNIp
 tBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780078637; x=1780683437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ov3KLWRcK+0MkbGkn9F2YY7Ip6m7E5y5ES5E8QNzB60=;
 b=Oh+xD+m+g/sSALIusGyDIv2In0gkr+xxqc93kpENkLyuMH30zewl76BTYrpezoD28q
 GWNpuWph2i+Pl4WIc2636o/GpkoHXr5JqKlFSiXWCGwBomnUj+Y0UlhWD+bT3dwnQ/Xi
 rzGqVgj1B4sZddnogYw53LtYNfp1JMMyOJ+MZbIluk7Y4UnGGMaWwsJx7kcgk2LMpuCM
 H3dMX7y41YTQHNyuoQ7Grr1s0hiAWOiWJPG2ennXitcmqGNbOXixHgG4KnVIhpJI0wLz
 QycX3D6YlVwV1l52oS10aRNYe4j/riOq9UG+ybhVlBmWu7Vv6dGC/8fDxj1Tllwp5yWa
 QePQ==
X-Gm-Message-State: AOJu0YznkFkNGHAdGNZFRd1nsPwgwD9snOIXdfqYi0k9t2ns9B8e4Bo+
 uZzT0OjbXNzr8tnfUWEBxXfwUmb9/42CSGMoxECN/lQFgW8nfv9lmxGJ5s0NR0/O7Rs=
X-Gm-Gg: Acq92OFrQ8TeLeutaxV5HPCE4vXWtgjWLshFqEKyYfQzUrpDnXXqmz61qiygcFA+0MZ
 yG0Ha0mvm2orPC5yRIoKXqvk1rKq041D8DaunAG/R3bykFCFNS/762YGmWcgaES3AxkoJbmaG63
 MWN/SQAt4z9c22zp1LTIF/m+2EpOVv8GJPjs4LdxI2LIJMeGYn/nMFBWdzykr3YEHzkZJd+Fv/a
 QxKOn04GfkUDftbM+DMuI5+wbPDOWj9cwL1dR5tgwM/3V+dLIQo6efpmNsWul4qnHIIYzurZQ95
 EELko0veUbP+w4eMYYWDsIhjBWYudMkxZbyErlbcwJ5X/mB8izCiduCLO8eJ29I5aSudw9hSyok
 SNQSm7FDhDcxZbycm9BcCkDXkGhs3BAVq24L7lXCEVSd7e0R8hkHZocnIroaJuy82KbrUOso29W
 Yjih3g+i1NJz1ODLt+5vbOIoP9+ZFz1RsImA==
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id
 5b1f17b1804b1-490a2a4bac0mr6509135e9.12.1780078637278; 
 Fri, 29 May 2026 11:17:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68b853sm58318555e9.3.2026.05.29.11.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 11:17:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E3C861D26;
 Fri, 29 May 2026 19:17:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] configure: use debian-all-test-cross for mipsel tcg tests
Date: Fri, 29 May 2026 19:17:13 +0100
Message-ID: <20260529181713.612230-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Although we have had the mips compilers in all-test-cross for a while
we had been surviving using the mipsel cross compiler image. However
when that was removed we missed updating the container to use.

Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index e138d83bc9f..1ceb4d7ecc4 100755
--- a/configure
+++ b/configure
@@ -1430,7 +1430,7 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
-      alpha|hppa|m68k|mips|riscv64|sh4|sparc64)
+      alpha|hppa|m68k|mips|mipsel|riscv64|sh4|sparc64)
         container_image=debian-all-test-cross
         ;;
       mips64)
-- 
2.47.3


