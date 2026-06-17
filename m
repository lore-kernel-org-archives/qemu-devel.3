Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5680FCD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj1V-0007JH-K5; Wed, 17 Jun 2026 01:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1T-0007Ib-7x
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1Q-0003uE-Kv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf30d530bdso53132535ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781674867; x=1782279667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=BQEWgXktcVOZGb0SH4AhjUQ8K9ug44WGZ2I0DwVF5GA=;
 b=hZjkftaCGLZ41y9WXaD3vcoufpDICRlMTdCGWJPg/rVFsbvQuC6tRKZ1yInFv5ORgm
 Izpm6OaAiWSDZvhf8o3QlQfirvXYBSL5i+uynTNdZP0BgUy+qbc08+RGvvDLf1GDi4nP
 o+pgv8P9rSNoJDV1o0mRfUQTlcCt4auT0EwKcUN1DcORoNS8RTNdd9UKU/eJ39jLDmOc
 I0eaOCfuktFe07xBe8G9lTgl516KNFvEH+Fbo/Cx2BOOM6DvIplMGZSA+lkQtqU6ol9j
 RdbTqok8JI0U/Du44jVHLEAGDKYTMu3eNXPp1d54NSJmlcDNKQotsUuATHiQhaT02qvv
 jqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674867; x=1782279667;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQEWgXktcVOZGb0SH4AhjUQ8K9ug44WGZ2I0DwVF5GA=;
 b=MeEe4AdVfhOUJ49qmguUbudHtIFOZuBJpKTdKWn1eDS5yBvWLI+W9g9fPHRK3SvdZp
 GvGD8OXA0waYKVdODZqjuF4t39zrKeoB0eBeZm/2L2XNcPiseHkOuOTbl3CGIULY+URK
 H5GWFJsRxZ6IrymtJovVrZ55897V+2EYSnhC+R9vwfQtCbWiiV8WEhJbU99U0q/5k9nn
 gTT7rjPW98tCDn53X9FeqSF02/6/rCMKNnMdYtXamLt5jNk01TAWTV5xiOEpzLhbA4NK
 kaY2t8icWjdEQrMuIlExkwrlYrY33q68g7nEWlZX/u5jLXJqKsNT6exU097BXI9sjiUS
 Tgsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ82Foz9v2Ia4b409DULe8rm1cJb0daJF2bT2ZR9KwC5poc7yOloJTPkG7ykVBP2oTz6tVBcuIvQNthp@nongnu.org
X-Gm-Message-State: AOJu0YxEp2ATSiq1PA8I5DgCyOgvu0BOqCo5Ew0irVHARJqdimq33J9Y
 lf7RrFnaHrOIwtgq5ZVBC7oywKOFsh/O+Edio0DOQffjLGtJ+nE7uGw+
X-Gm-Gg: AfdE7cm4dPrQl/Ngg2hdNSZt/dglA5RUzyAqBpNMNI0PHO4id8qv6LqAjFjYKO8nkNt
 CzHXQFSBFJhfTXizua4//7e6VKCRVMNT4bzmbcAJG3ae2K1Tb28sAaWN1+8nF21tXhKWZIwFyDj
 zWuBaWZq4FzkVp9wBZJdRTnLhwmIumdc4yTH38Gz+9ZfWnx+JKg2gro7qdQSHCZCFJ1oGUrmnSx
 IktrZPbA2Z47bmFim3DFNuG3S3u3ExRrW3sYOEfXcXGisMCq32VSfdupypv/7ilZg+tV11PWA1h
 nM3bzph9H9smbuh13nYJ2b5OSlUwbyrJGgfl+zpUQluq7XMpXmTXG11n90xMMAZGfZtTGmqt5EI
 PGamZ5tsW3eNDJkqNffYsdWSzJHkV/kSvPcvQB3aGgBVMc1DzURA+qxmpt8tmbs2G/+tWKRmDHf
 Nz+oDwAIvjFHKmK/gnd9TOfX+WKScrtsLp52ibgfV5fqCZe1ZBe3w6neh+BPsrf0rZPTCMhrPDI
 LCv+jN2ABSZRqzGi9HRJswg3twPg6mPrgm9Jh7Triw=
X-Received: by 2002:a17:902:ecca:b0:2c1:a19:839b with SMTP id
 d9443c01a7336-2c6bc24ab5dmr23415805ad.27.1781674866607; 
 Tue, 16 Jun 2026 22:41:06 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm149294725ad.65.2026.06.16.22.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 22:41:06 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: alistair.francis@wdc.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] riscv: Fix IMSIC CSR write and add tests 
Date: Wed, 17 Jun 2026 15:09:25 +0930
Message-ID: <20260617054034.1020724-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This fixes a segfault in master with any machine that uses the imsic.
A test using the virt machine is added to catch this in the future.

Joel Stanley (3):
  target/riscv: Avoid NULL deref in IMSIC CSR write
  tests/functional/riscv64: Use newer kernel for tuxrun boot
  tests/functional/riscv64: Add virt machine AIA boot test

 target/riscv/csr.c                      |  8 ++++++--
 tests/functional/riscv64/test_tuxrun.py | 11 +++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.47.3


