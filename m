Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA38C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcUL-0006zz-Jr; Thu, 30 May 2024 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUI-0006zF-Hk
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:22 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUF-00026A-2k
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2bf62b121ccso483227a91.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717062857; x=1717667657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fqOQQsWYFsiD427DANQ9dVJoq1lGeoayCWBiRsEqQh8=;
 b=YdPIk29tmG8uU93eTSl46olc/MolkHddNNpc3/gRIxQT89TQkCHSaFHcb2wJ3EdDDn
 S6ngmrYuZjwfmHv0OgHgBbAwTtkp9P3+kwhhVETscdxnBz2AbJKuamqAGBg2vzv/t2Jl
 xyMpfMh7V1zKFQ3eUJuO+xksW1mcqFeiGAVd3mCKR0FgSrmLythJNq+G7w5xBAvUMYa4
 OyAUa86DJbWncMz0CcnVOUQitizSU3qbLJfJRyDppyqk4j/8mEJ1uyCjK5+p8OYqoPlR
 qdpwfMKm6+PqVEtXzmiX0bWCIMiFXd/6hv5v7D4bpmddjvrqeei5BBBvHj0WtJ8b5p5I
 jaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062857; x=1717667657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqOQQsWYFsiD427DANQ9dVJoq1lGeoayCWBiRsEqQh8=;
 b=H+y77ZsdJjfTYYY+uZEBguq0gsY10TEaOgaY4XdZAsXmg6Zm03aqMhqm9t+3IiGIck
 Jy+1Nw/iQjGiTrPnS8PhhD6pcjP74QoSUf46qc4DDBl3LqpWGcVtFMbcrhOenYeGQ+8G
 UQP1zAeN7pHCSLZ9nqPtG0zMthtEKZCRBQn4a3nsFAGKu+QrwPKsPTEAjyHi6XqK5m4F
 YBGpF4H0h+AG2T2WXjzK0GniatoasiljxEw74ycITiKF9MG4TgWQtRnWbXryA90Zkq+Q
 2IkkCpV9WRE/y2U2rDTNfYZV7d8bU234XoLNZnB2fW8VajnmEZXVp/nPyHyg+oaG7xGh
 JFeQ==
X-Gm-Message-State: AOJu0Yxw618YWHTtu1Vr5segSGHq4hPdjN0IxYfITe3+mPoQYKzCspF9
 nNUowf9+qCUWVacntrkIxwvgOSc4rdzVnz+nWnvB3ve/THmUtQ7055YywWGR
X-Google-Smtp-Source: AGHT+IF9yVV3OUOweh3X7ETmk8qE9VSHpKwbm5qEbphjmfvm3i7pNBoSUH6WK8S7b7Az3KTY+3oeUA==
X-Received: by 2002:a17:90b:1191:b0:2c1:a9dc:7f07 with SMTP id
 98e67ed59e1d1-2c1acc912f9mr2020557a91.18.1717062856982; 
 Thu, 30 May 2024 02:54:16 -0700 (PDT)
Received: from wheely.local0.net ([1.146.0.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d28asm1183626a91.8.2024.05.30.02.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 02:54:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/4] tests/qtest/migration-test: Improve shared
Date: Thu, 30 May 2024 19:54:03 +1000
Message-ID: <20240530095408.31608-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These apply on top of the previous ppc series. They are similar
to what was discussed except the end result does not attempt to
run /dev/shm tests on Gitlab CI because of concerns about
consistency of test results if shm becomes exhausted.

Thanks,
Nick

Nicholas Piggin (4):
  tests/qtest/migration-test: Use regular file file for shared-memory
    tests
  tests/qtest/migration-test: Enable test_mode_reboot
  tests/qtest/migration-test: Fix and enable test_ignore_shared
  tests/qtest/migration-test: Add a postcopy memfile test

 tests/qtest/migration-test.c | 128 ++++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 40 deletions(-)

-- 
2.43.0


