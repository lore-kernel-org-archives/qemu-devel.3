Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B8C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU9f-0003pk-Nr; Sun, 23 Mar 2025 18:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9d-0003pF-FK
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:50:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9b-0007Dm-OB
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:50:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so28139825e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770249; x=1743375049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6WdC6aWpTZ6lZgOVQVDbE+FD+AWc4UjS8TBCE119Utk=;
 b=lrGKdCHnmTKiuls3OdUYnWnMDo1njuXQhxoWg6JryUZ0ALDU4KI3pZSr0uCKnT+Ag6
 NjCXy+CzBdpRIgYc+O2tY6C0sjcCnLLhVQ9KhbncX2KPgeM2HiyZ8X+cmFJBlULM7CNw
 ndUptnmyAKSRpg5h6Ep4Y6vhhPfv8MgCr4LaSt/F5tbum2E7T+9CrjNXh93i/YJS3VC9
 CC3Tl4wvNQyR193Hyot3ZM+lKll5Xl+Fx8TNBy3uhqTd77T3aBEKPg+jg77sWXxkS7Gt
 uMx3cGLB1ood7V8zlxCH3v1BeoFzx+0ot7lUjqbpyW3OmtrP6XOPLqcG8muDBxxHez2N
 hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770249; x=1743375049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6WdC6aWpTZ6lZgOVQVDbE+FD+AWc4UjS8TBCE119Utk=;
 b=hBHQ/ko5yvrWnUdXhHh+DEsMi3x1r5P+QwUzIdBYqcbcz/oEu50epOiPFRITHu2f0d
 eJom0dZ4hD5NUQTXcZzR1LBsGG5ARTUoJu+CXx3ihfRWdtQfOcYL/rlHw0fQ+yNgYKom
 x37IjOQk3DHqn00XJr8qFr5quqz3QK0RjAn5SkEz4Xktuzp6K2QdDJLTE7hIPvpisWj3
 WnGF6P+nU8TT5zjEhiBYGHqVvOGYDmI4n/q2eHPHyI0bDk5DSshJS2Bkbcmxi7eGI1AH
 6G1Ahi5U+5T2X5DPEHy1nNGvSBWqjt4VX3Tzg3ywReSXBed0m5veAyVy5RWEoKGstIIl
 BiLg==
X-Gm-Message-State: AOJu0YwhltjR+34hTqOH5RD6DeQHSrXjjLM3/NwP24YyFBTmLmt4ANc8
 wYkaRDmbXUHnETMrxTwurjB3VKJo5b9k32o1fSLOFzK6zAFPoPhAsRJmO04ClZOtsfew+WNBdGp
 f
X-Gm-Gg: ASbGnct0/GrXlx6aJCTLwpdr1qpWIbl2HOP6CmID4uJ3iJKomBIbFd7U1sdQt28HwQf
 re/ng27xembZWyuaj13EpqgypXY2HNMXy/ktQY5xEd4zt+sUTxbBpLe27nkDCEGTAz73vKhJaVj
 eq1LS/eAFBapfiQqDhHeB/ztVku84q6fUu9r8iN9WL3pzu4UbuNDqe8tDkAS+XrjCgKb8E1yWvM
 4/TPu6KGlXIMDQcgtRBS20j9rFI0koplv7whqJ71ULHuU3YvfGMFaE8YCI9MpGlPAyWrAR5zgSW
 H3gNzWNhybGb8bryt3Hv++NFQe/FR5boKoqGqVUEeEVmE7I6iNQdTB2lTqOnsv+eVzBD59uwUt5
 HpWkPIokKCUKXa/oapQY9nXt/O/bHywJMl5I=
X-Google-Smtp-Source: AGHT+IENR1xs/XF6WSIZ2MVubJdSIX6lNXSooFZjY9v8gdPnJz6o4+BpHKkFni1p3iekBpP/FdtA3g==
X-Received: by 2002:a05:6000:2d0a:b0:399:7f44:5c74 with SMTP id
 ffacd0b85a97d-3997f9389a7mr7738963f8f.55.1742770249100; 
 Sun, 23 Mar 2025 15:50:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef16csm8887431f8f.86.2025.03.23.15.50.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:50:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/3] migration/cpu: Remove qemu_{get,
 put}_[s]betl[s] macros
Date: Sun, 23 Mar 2025 23:50:44 +0100
Message-ID: <20250323225047.35419-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The following macros:

 - qemu_put_betl()
 - qemu_get_betl()
 - qemu_put_betls()
 - qemu_get_betls()
 - qemu_put_sbetl()
 - qemu_get_sbetl()
 - qemu_put_sbetls()
 - qemu_get_sbetls()

are used twice. Expand tl -> 32/64 and remove them.

Philippe Mathieu-Daudé (3):
  target/mips: Inline qemu_get_betls() and qemu_put_betls()
  target/sparc: Inline qemu_get_betl() and qemu_put_betl()
  migration/cpu: Remove qemu_{get,put}_[s]betl[s] macros

 include/migration/cpu.h      | 18 ------------------
 target/mips/system/machine.c | 12 ++++++++++--
 target/sparc/machine.c       | 14 ++++++++++++--
 3 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.47.1


