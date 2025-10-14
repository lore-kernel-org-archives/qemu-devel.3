Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA423CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8izR-0006fk-G6; Tue, 14 Oct 2025 13:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8izO-0006f8-1L
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8izK-00021W-0w
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:39:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so41159405e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760463543; x=1761068343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vJ9KjSNebpYb47dA5PUtbwhpOV32g6vAS6DakupALcU=;
 b=tIsy8b2QwPEL+KGQMmHAZjr4c1v/3swjHAbwGOruJFUqOunB7/iylHP9iHOD3rhGqx
 W7cVs9wDZhm4EbPPKKlrEaAWj/wmclFrLKhu5wiXP/aDKITYfhCCUkq9sRZJUJeOU94i
 9Gq9o7hsV/Tff1Peih497+XDfH50PzSrBwLwPsoPmS9+vk93qGSiWtC6MtSYI5dGYxRD
 HpPoIJ+0DCRsiFqHjUiesT3VONmAoIo7UwO5E5nvIqMZFUfgzrZIZkdVJVwDglyBN99p
 6gVbD8CMdUrEc2hhQOCASCA/a6UxnsF3447BvXvxnmJghlvCTxsoHSJTk7PfgSCE6kRz
 Q2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760463543; x=1761068343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJ9KjSNebpYb47dA5PUtbwhpOV32g6vAS6DakupALcU=;
 b=A9HFd5+8xD+rd1rv61bJRbRZ+u535gP4PI4XomLNqH3gtenxOomde8E5u585hvg2zb
 Kt1AdhMGQEecNTHT9/s2dpb2rdXOK/uTJ7q0zNBSf5qktaPsrK8P2WcjlKxbe2RtRIzP
 R7BwMxk/KrSdGK7WV5oOIWEIKbR3upGcKc3Fm3C9oQFlxGJtHjDJOBpkLULHaqbZpkcf
 uMMuCzMdNixMC73qBezHVXGrxYjGqaO/kQmW9Um3TuZ1dvauuUc8K1OtrCWQUVLs09PO
 Z2Hr37NHkg+VQ1XI4/0kUbopWiq/XVliTksEiwPNkPboont6fNzYp6rsg/ZPJjgrKPtZ
 6oow==
X-Gm-Message-State: AOJu0Yxyex1xECj6cNzHrDqufHyTsG99CPzUlAJK5b2TRIa7nwzEyxH2
 lng+F7Tkk+DhB6x7/NzsVaNeFtsdGdfsZocWPDzRGrAkKiq3+dZdNc93QdVdAhvVcmAcTSGARFX
 ToZwiZHBsolat
X-Gm-Gg: ASbGnctJwdsjtf2W54p61dJb452Z7Rc1zEIhjNdZwooXlHHBz9bUnPbdubpc5JdJId6
 hAGh9ZaQs2/JhxnTTlEMp+j2sqwGPg+icxdtkPL9DtduxVzi3EFSomatS1kfsxQRJg1ym4wK/8V
 oMnRStPIxOAb+RIwNsDX03Ys3x5kufREY2fkYurLnzO9vjALAKfTjONPXlJdDFa0jpNZ1vG9zL3
 6fa+GFLevIE0o10ecR6ETIGk8cPh+vh/PUccxZdQtBqHsVnFLNnIvZKnLxrUhl1YBJotvScaSvz
 xoaLy3tO9haLAohDf6PRPr6L9I0LKJDEZdz+Pf3FfUTVdI40oRJOFEl66ohp44UJE2LRZNnLSiQ
 xSXkDBZOdSqrvJjHvm+HMkkJ03gXwOQbNw73HTJ0XpZ3I6sf2Sgbp41tuWJi8wUNtx/uZSLAl0r
 jYnYHKp5dUBw5XAV7dYL8aB/2c9A==
X-Google-Smtp-Source: AGHT+IFGJoCouzvrvyuBVaxYfD7qv2ZVWWJSoN0UW7JceVJ+GbAltROdW+QWrwS7uxvJRFDpl1ULHw==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id
 5b1f17b1804b1-46fa9a9ebb8mr170341965e9.9.1760463541944; 
 Tue, 14 Oct 2025 10:39:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ad27sm250715145e9.15.2025.10.14.10.39.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 10:39:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/3] tcg/ppc: Remove support for 32-bit hosts
Date: Tue, 14 Oct 2025 19:38:56 +0200
Message-ID: <20251014173900.87497-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

32-bit hosts are deprecated since v10.0. 2 releases later
(as of v10.2) we can remove such code. We removed the MIPS
TCG backend [*], follow with PPC. Remove related buildsys
and testing.

[*] https://lore.kernel.org/qemu-devel/20251009195210.33161-1-philmd@linaro.org/

Philippe Mathieu-Daudé (3):
  tcg/ppc: Remove support for 32-bit hosts
  docker: Stop building 32-bit PowerPC images
  buildsys: Remove support for 32-bit PPC hosts

 configure                                     |  13 +-
 include/qemu/host-utils.h                     |   2 +-
 include/qemu/timer.h                          |  13 +-
 tcg/ppc/tcg-target-has.h                      |   5 +-
 tcg/ppc/tcg-target-reg-bits.h                 |   8 +-
 disas/disas-host.c                            |   4 +-
 util/cacheflush.c                             |   4 +-
 tcg/ppc/tcg-target.c.inc                      | 383 ++++--------------
 .../dockerfiles/debian-all-test-cross.docker  |   1 -
 9 files changed, 86 insertions(+), 347 deletions(-)

-- 
2.51.0


