Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5471CCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9mPt-0005L1-T2; Fri, 17 Oct 2025 11:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPg-0005De-Bt
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9mPZ-00014u-HK
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:30:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47112a73785so15559495e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715029; x=1761319829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6AV+a4VK9i5eCGB6i/mZ4rJ0/eiGZuZktFjKNZJiImc=;
 b=oSQUZYX+Kok9+JL43WNgKoXaR4M26UlrIbgdk5G1+5bkWcrzC/dlQtr6tQ+xfS7eMV
 zOKrBW11yLYlddaS96V7yvSOP6E+YHV+AufYRyfCKf1RXRh/jQFam1hH4T0n2ffX9WDo
 xFhs7OuIy9S2n48Y4Nl0VVR8Czv78utDi1tsBdueuU7mktQDw6ZTepkthKsKOBfy3E9z
 4s4knlL3tWTn1T+nWa2j+IoJHOKczgb990WtiDgxkpzBqC9LJojacKYov3RBQyKIhzqG
 rguIqXf/34D8OkE5DA2bIpgkQsr5f0s7a+v/CtWD68a3+PLMhSvrxr1S7ic02kBmOwEc
 /RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715029; x=1761319829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AV+a4VK9i5eCGB6i/mZ4rJ0/eiGZuZktFjKNZJiImc=;
 b=OcKunCobAFOW9HptUG21Jr6huT7RHnH4DJRZ3ViTDlrxksgYSgPlR7xwszeTYC33tE
 R5hg1sWSSZOwz0hT+61ZUqFVPHXVy4AGTFHRLQWA86Mho4o54wZlPQ8K+Jq/52AnCFJy
 gH0GSotS1LEiSN3pwOj7Wrl7Mvxh8y5sJjCabtzK4NWgFOw2N05XQAepvPEhWyEXNaz5
 V/OKAkk/mHbx4hJzkUFiWPVuNpWL3Tt0xlE4YTNWwvCMkwQKxdTNcsAoSvlKeqODD7c2
 CtpRUK9JZWp9BNPN5A96CqXcrxmgO4d9GX4hCmpwX5kl81n3bwr5bcdgc/pP3PLwgjEN
 MmVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFd9PBiMaa6EvgwgH7cepq9NfVUcUc0IGXEnp1sdorTUtk4V2nJAZHlzXub+odro3xzKmG1YBtyFa9@nongnu.org
X-Gm-Message-State: AOJu0Yw4Zd8N1plh0VCp2+GQFoQszKsgB1hswIv6VDXRvGP+vvNaE3mk
 DGcy/S+Cd8+BLkKU97PsqTrdveeHZ5ZTjRQnQV04KRIT7IVLmO/sTC3WdOtpX/ILigQ=
X-Gm-Gg: ASbGncspgjYt/AT+6NlZtfX3YB6PNDQa74QhJ3qxGUl2Rjx5wZ+7spwvR9XrBKE32cw
 WUNQFHp6wHXCU7WsI27fiLOyyluQd4TiwfbFG+30DvUxlW41QBxOSKGoin4jwJtJ6pSacJlqCbX
 IxFJqyvVyLWJeXKPaIWGwzCEWE/is/pG1z4c2asZTWcX6j8qQbjy+/i6D2UbUsjj7RF+IrTkWgT
 5wkKWuutJ4NTdJLJPCjjsBcO32AXHKs7y9B+rM8gi43o2eTizGO4gv6Y8QknYEcxMeoc+lERcvJ
 67MoOfBeNmGaO7UmcWRkJTBgMxc7IIM77eu0MlRKBY1Zw+69CpbaPs99WgPlwbixMGSX+dEXbE+
 S31+p5QvNAl318dJuRJ0k7z6iWDDscId2A0K2bY5RwR2oEstrxmLsDdvHUPMRZceh8Yh5LFo1tu
 QWd4Kll4XmLSt0P39d
X-Google-Smtp-Source: AGHT+IEfsmWDVH2D/mkgb8t2QRcK3JvhDYhgDqU+ZCr3dG9hHbfCVGar0ykvnyuEPHHXnh7ldMPsmg==
X-Received: by 2002:a05:600c:5298:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-471178a748bmr33366515e9.15.1760715029056; 
 Fri, 17 Oct 2025 08:30:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm85038635e9.18.2025.10.17.08.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:30:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Subject: [PATCH v2 0/3] target/arm: Support SME2 in gdbstub
Date: Fri, 17 Oct 2025 16:30:24 +0100
Message-ID: <20251017153027.969016-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This patchseries adds SME2 support to the gdbstub. This is
fairly straightforward as the only thing we need to do is
expose the new ZT0 register in the XML in the way that gdb
documents that we should.

Patch 2 adds the TLS section that we should in theory have
been exposing already; this mostly will become relevant when
gdb implements the SME lazy-state-handling that uses TPIDR2.

Patch 3 is a simple "check reads and writes" test case along
the lines of our existing SME tests.

Changes v1->v2:
 * use static XML for the sme2 section, not dynamic
 * add patch 2 for the tls section
 * tidy up some excessively cut-n-pasted stuff in the
   testcase script

thanks
-- PMM


Peter Maydell (3):
  target/arm: Implement SME2 support in gdbstub
  target/arm: Implement org.gnu.gdb.aarch64.tls XML feature in gdbstub
  tests/tcg/aarch64: Add test case for SME2 gdbstub registers

 configs/targets/aarch64-bsd-user.mak      |   2 +-
 configs/targets/aarch64-linux-user.mak    |   2 +-
 configs/targets/aarch64-softmmu.mak       |   2 +-
 configs/targets/aarch64_be-linux-user.mak |   2 +-
 target/arm/cpu.h                          |   1 +
 target/arm/internals.h                    |   5 +
 target/arm/gdbstub.c                      |  12 +++
 target/arm/gdbstub64.c                    | 115 ++++++++++++++++++++++
 gdb-xml/aarch64-sme2.xml                  |  14 +++
 tests/tcg/aarch64/Makefile.target         |   9 +-
 tests/tcg/aarch64/gdbstub/test-sme2.py    |  36 +++++++
 11 files changed, 195 insertions(+), 5 deletions(-)
 create mode 100644 gdb-xml/aarch64-sme2.xml
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

-- 
2.43.0


