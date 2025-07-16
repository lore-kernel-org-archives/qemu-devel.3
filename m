Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A37FC83F34
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzoY-0003Xt-Nk; Wed, 16 Jul 2025 06:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmO-0007w3-9P
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmG-0002Td-CU
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:27 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0c571f137so1214535066b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663258; x=1753268058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2yDR5WJ9OW5kxmFisrP8SwQ6sGdbHJXz6jo6wbRIeWk=;
 b=yWDsIjwKnPTobkQ7WOxNcp6VRRT6LXSAbhtKuy19xoGr4fYAqgGQshsxo4xD6up62Z
 GGo4jaz9FWX0HeBSF9w39wqjaw7tdjKqo2+vGqxv3bQSmm4v6HLduttmaU5EZ1YfNUdf
 nkcGyRRY8eBuQpJplUpAHRvpXltZ+8uZwEWVeiZwrEmAF1e3cz+/L2jZEYzJy87B2ZXg
 2w7QlubTxVFbKlL5CIHflvnxuOgwn8XQnciVXSfqZwFhzJL0OltMDrh8qhoIR4oG6RcV
 Oq5mIhHR0EmQ4EC0ww6k54H9rCJFvzYXdZqE9DtDILp0A63kAjnyl5l5ruutmWOBkScy
 UQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663258; x=1753268058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yDR5WJ9OW5kxmFisrP8SwQ6sGdbHJXz6jo6wbRIeWk=;
 b=gDL15dhLHGWJad/CFl063yPLdX5x46z9cOwgCSLykXXserR6h6+Hr1S6GEMeUVAslq
 hzajSAR5kuDbn//GcR41/+DrnZK9YalG68lTspCXv7HsEiygPdbAQJdP930Y0CPt7Rx+
 7are+DDFmgS1DVYGNWCQ+SG5z8zI7EBQfRSqKMPMR0GG4+YeKdLrurE1MYdKrSn2OHMq
 oIOh619NW72Pfz0ER7wR2rOZQoQ2tK2x4CtREuCq/4heknMEo/2eMkZcFqTeOf9zyUnE
 YP1Hun+ugtYiBjL8fXFGtqVzCJDgmP0Gsw5TTtTN/vBY/uqTgTSGIXiGo/GezcCVJsrz
 MFLA==
X-Gm-Message-State: AOJu0Yx6d/m/UZ5XyqhxTerl5KU+oiBXf9W5DEgaFgC5ELxpVpy2bW+A
 Zo2xNfr6xw06CRRgudaZYrRSSK44ZZUFuRqHkKrpwGSeiusO9mU4n/bDrL299R5eMtc=
X-Gm-Gg: ASbGncsun+Rb05qGdtkhdewxCsxTuMrrUCqoj4xM4Sh5udKXcZieQX2hrvtO8fLD6f6
 u/6kszGqiQNs9RmNm1G4thEoZqzaqoZjWNPCQuBy2kQDv9QLnVgwFVlRVNB0wYdshsancBFAJO2
 fJ2ylPpi6Y62ZGaakGdP6gvby+D7PuWLrWxjSozXychnFPq74ZiVK800Wu9GlmuRY5gOnWKaaQU
 lXJ7JqMxdSGdxBk2FFFqE0M0CsjlZsaTUITrR8dh06+P/+tSQiBuaXJoiI2CtFF92NNBJMLvdxq
 DTdv0L9Zc5xwdQNRUw8V7hPh9xflf6b983frFxLgwqgo79YV29kPrLTk2sahLG2v3aoUQII1Bnw
 Lx1T19l7YMKNozWCLy2xfJfT8iVqz0suHpQ==
X-Google-Smtp-Source: AGHT+IHCZacBFDTN2v9FlfKT2YpbhxXVY+40ghPhSTmNr7MtWL68Chi/OtORgrExloRg/HUo+Fy+2Q==
X-Received: by 2002:a17:907:fdcb:b0:ae3:bb0a:1cd8 with SMTP id
 a640c23a62f3a-ae9c99be1ddmr240182466b.19.1752663258397; 
 Wed, 16 Jul 2025 03:54:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7eec2b1sm1184025566b.68.2025.07.16.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DD0F85F885;
 Wed, 16 Jul 2025 11:54:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 0/6] Fix building of sparc/sparc32plus test cases
Date: Wed, 16 Jul 2025 11:54:08 +0100
Message-ID: <20250716105414.2330204-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We didn't have any reliable way to build sparc test cases. I have
found someone who ships a compiler but the binaries still don't run
due to the need for CASA.

I'm posting mainly for those who actually care who might want to fix
up the remaining cases.

Alex.

Alex Bennée (6):
  tests/tcg: special case sparc test cases
  tests/tcg: special case sparc32plus test cases
  configure: update sparc and sparc32plus target compiler detection
  tests/docker: add sparc-leon-cross container image
  configure: enable the container fallbacks for sparc/sparc32plus
  docs/about: deprecate add sparc/sparc32plus-*-user

 docs/about/deprecated.rst                     |  8 ++++
 configure                                     | 11 ++++-
 .../dockerfiles/sparc-leon-cross.docker       | 40 +++++++++++++++++
 tests/tcg/Makefile.target                     |  9 ++--
 tests/tcg/sparc/Makefile.target               | 45 +++++++++++++++++++
 tests/tcg/sparc32plus                         |  1 +
 6 files changed, 108 insertions(+), 6 deletions(-)
 create mode 100644 tests/docker/dockerfiles/sparc-leon-cross.docker
 create mode 100644 tests/tcg/sparc/Makefile.target
 create mode 120000 tests/tcg/sparc32plus

-- 
2.47.2


