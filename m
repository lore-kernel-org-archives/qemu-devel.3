Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8319C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKSj-0000sL-CT; Thu, 03 Jul 2025 09:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSg-0000rB-P8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:50 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXKSe-0000hl-Hf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:58:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae0b6532345so184357266b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751551125; x=1752155925; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mq32u52RK+HWwNC5TASeS+/bUraLvFaEkHDNXHlNzLk=;
 b=x9GPW1HvFnakbLDW/cqUR4wPeYzWgmwaFJchXCZVPucCl8SgC6oqwa1S/POumsabFO
 XoijhYDt9/Z8sV3T2ii4YjDCAeH2+MlqXeIbSXkypmHDnsFdnALoQ++cQFHp1fD2hsRq
 mHwFJT+tblzgtU9nMbNmu8P65ui+HLrHjxI3HMiGO8IrrSlHt2IaGkiOqVJbZghserdD
 Z+cunD1MQgydZ/L6HsjePDXeYfmq25A8qc+mPeoaqYKBDiLr6mnll2aK/ZVD3mywmZnE
 Yvy0xAU9H7EarDb9eKHus+WESD+5xA+vsgqwx5EsHhIQoLrHHvP0wdbX8Dm6TZj0Nv4z
 ZShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551125; x=1752155925;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mq32u52RK+HWwNC5TASeS+/bUraLvFaEkHDNXHlNzLk=;
 b=Adh8W5RfM5VJB6Bm5oBzT0CEzMcF00vDW5VSz0NVonflZ07iTEAyn+u7OGP+ru0WSb
 xvfT8ndam9m3DY8I6htoSjYnchbMpYDF03ZDH+m8dPY8kzySXDPjNv5KuldwP1AnxE7t
 Ks20TTkrR7t7zGC0GVnHTKsbYMP82IQ0N309uGMptQBWwuI5GcewKGO1V+eOdOTf0nq+
 fBHkLl87J5CmCm7wf65cBs+c/bkgZZ72Kk+rLgcTMvpwc6qfM5woc/yLSf8d1bcmviRY
 0szrtWaBFrQpjtiUmz3eJlzxW4qHSc8mM2Y7lvXveTbYTImQOQi4TRpnuZ7XDJEqTG8c
 rd9A==
X-Gm-Message-State: AOJu0Yy5jytm1ifgY2higLpAE0Xn98E8A5YznUT36msg/LcJRtyVFVJT
 gtA8C6ooxncyRC6QW32aaTXPJHIcjvU9uNzlWJEQEaoCWgYOFLb2y5goHhdst8ZMNfY=
X-Gm-Gg: ASbGncsAFXnDq6R7b7nT4Mcx2t9h0lpdqfN0Mrjmq+8BjwdZe16793ORDz1L0niOfNi
 Pms8yt5iI0jrQacT9R9hVeIj4vkzR7PYM92BEQmqZ6DXE6Kp+XU1m64jpGxrRSjvvv8cQLarDxl
 Cqid5+A8F9jz9fGVcRmalSydiYd3xNX46djibcs/lodmyuD0sG2V7Af8AfgDxkXCkdmPN0b/Mqx
 I6JxrfQeVkE0vNEOJs5wKccfzur20dPoa/w3rdAqz70xCYDWaWLlUQj3nFahs6+z4h0ICd434js
 y2YCwrTpePe8ItsQKhJI3bVUI8nbHk1Tny2GguIZDbgywVCAirBnafK2pVJKj+VWkon3TJyIWvj
 RzUd8pigSxZCuHT8vVPO7EWNi7OQrQn4=
X-Google-Smtp-Source: AGHT+IE5o9LVGaXcBrAdQk0V6fbGZzjDbatvFTtJ/HyLnlDbfZHpBoRE7AVguy/axbOkt0UEN5ix9g==
X-Received: by 2002:a17:906:f597:b0:ad5:6174:f947 with SMTP id
 a640c23a62f3a-ae3dd5ef9f6mr276716466b.22.1751551124892; 
 Thu, 03 Jul 2025 06:58:44 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353ca1ca6sm1279678966b.176.2025.07.03.06.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 06:58:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/3] Small Rust memory API improvements
Date: Thu, 03 Jul 2025 16:58:10 +0300
Message-Id: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHKMZmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3aLS4hLd3NRc3cSCTF3ztMQ0UzMTk+SURCMloJaCotS0zAqwcdG
 xtbUAKD+YqF4AAAA=
X-Change-ID: 20250703-rust-mem-api-7faf5644cda2
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=cXzmzyJpLxv1pQB88zIDrrVR5bfuIDmXpNrttE6CKSA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9ab3lUY29XV3FvcjFZTmJ3RW5wZ0t3dEhsVXZxCi96QkRGRXh1YURHZnRDSWVC
 bFNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhTWt3QUt
 DUkIzS2Nkd2YzNEowQVgyRC80bVpEQ0NHMkdJS2Z3ZVNDNVdrQUl2QnpHK2M1NTVnV3F4dFpleA
 pQNU1KSkd3YjNlSjI1dUZzZGdPZCtibGE5U0xyTUJsdndLdzBjclRIbW8xeUtmdTFvTEQxMEVEV
 W5uS2dKdGRMCmNqV1M5UGk2YlJ4dG1MQXpMYnV6TmhKOVNWT1cxMmJWQmZZWlJoV3IxdzFTMGVW
 N3BqQml1cTdwMldqVHhXNC8KT0RraGxpUWV0M0lHenZOVWF3YkhIYisvanpDd0k5WGNzL0lwQzd
 JY2pIbVpTRTV4cWVwdlVMNlgySjJQM2svVgpldlZ3bXFyK213V291bXpLcG45YWgxS2NxZTh1Sz
 BDU2FOZjFhbEgzcjZ0TEVuK2w4eWdtSGRKa2xLN1l4ZGlOCnFiQ3JWTytFWEZiVk43SksvOXdST
 llLQlc2d3lRTXZzRnZVNnVxdjJ0U1JoQ0pQdUNXeGc5aVBJZWc1bEEvK1kKSWlOK00vc3psREZw
 SkFiVGhFZGhmYUJ5RjF6djlBYks0aU83RlVvdGpab2lTMDhPYkRWYVNGNWxCNDk5SVZRYQp2ay9
 MY1JWWTlNY0RpZGVERklNT3Z6Z3puSTBVbkdPVXQyTUxiRytIdU9BMEdLeVpOaGdvSHJyaGErMT
 ZHaVNhCjRackhRNVVyTGwwOHg2QzBIek1nYmN5Z0cvZVo5ajlFUHl5aC9aRi93MCt1Mm5iRG5vS
 EdrTWhHSWpPVklzRGcKTTRBVlpkQ0p0VG8vVTVqcHZiN1BRTjRqaXN5Tm12VTBzTVAxWTUwWTIy
 QUxlQ2hjVG0wcnRLa2ZQQUhhOTg5aAp2YmsrT1UybnduYVNxTjFaQmVuUmtvNUdFN2VUSGNjNjd
 uOFpKZ1A3VC83YUVVblE5UHMyZldiZFc1MmNZaVlzCjRvZCszdz09Cj14d2R1Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

This series adds minor improvements to the memory API:

- Use an enum to define bit width for memory accesses instead of an
  integer
- Add *_with_attrs methods to MemoryRegionOps

The *_with_attrs methods are not currently used by any device, and that
patch can be dropped without issue.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (3):
      rust/memory: replace size arg with Bits enum
      memattrs.h: make MemTxAttrs into enum
      rust: add *_with_attrs methods to MemoryRegionOps

 include/exec/memattrs.h          | 11 ++---
 rust/hw/char/pl011/src/device.rs |  8 ++--
 rust/hw/timer/hpet/src/device.rs | 14 +++----
 rust/qemu-api/meson.build        |  1 +
 rust/qemu-api/src/memory.rs      | 86 +++++++++++++++++++++++++++++++++++-----
 5 files changed, 93 insertions(+), 27 deletions(-)
---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250703-rust-mem-api-7faf5644cda2

--
γαῖα πυρί μιχθήτω


