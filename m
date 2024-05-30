Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5107C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaTu-0002EJ-NY; Thu, 30 May 2024 03:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTY-0001tF-Ox; Thu, 30 May 2024 03:45:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTG-000308-KM; Thu, 30 May 2024 03:45:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f480624d10so5310815ad.1; 
 Thu, 30 May 2024 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717055103; x=1717659903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GHdHJEG5V4dWaxqkzvKLMfLAWaYqBj5hNJ3BNB07XiI=;
 b=hKn3cuirezMZnC2dSQXIla+RdsSGKiB3FTPJTVh1N6MwsbmcqnZxVyUBdYW91bb4wd
 E29yLrZXUM/61zkUCT2vOgWLU0wavhJe7dLMTA+VMPlaYy4evZO5JcF6AULbNsrNX5Qk
 nM8aL4K/qP5j0V+WxmfynaHiaUDlvXS4Qmp7rDPH2Q5finxk9D/QHY0kPiS1pk3aiLxm
 xoBFpKpHS2yQdblUitRaMmUzRRm0Bxbc4cPYgZ2kTo9/jfP3sK9GqYjcQ3T0ylDtjb5W
 okLtCqzcBqTN+veCwnBQGPi3URaXfJZm4ZvO5SxVhJH7rGfJpaUKKNVlzB8CI/JZRoxz
 xrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055103; x=1717659903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHdHJEG5V4dWaxqkzvKLMfLAWaYqBj5hNJ3BNB07XiI=;
 b=rhsN/U51KT3vh3562RaGYVcPtf/WPaa6dafJfFnDQtqHjnWeD5nVLwY2IifQXzMHpO
 lEdcvSMU/wAwv8iJgyHxEv3C1O3Iudc95OPXWlG5VUhgPb60s95221PTwO+pc7/mf60y
 m9e1uBe1/0H963HAGmqYOHQeoqqyVNbg8e89ZUmEO6+7uJcL2YcHOtqi8AUcpKkNSe/G
 reBRsH7eacJqTF5hz8cbe5ktK6Wq0z5OCk5Vb/YdFjuV+TdJ7L2ChK8EDXkCOqHiunb1
 /gAxQP/W3JZwPv0Y0iU2QfuxFjgMiheuG5EQagJv0VunWQsVP3PcbeTSxBR2gFp3KqLb
 xx4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWtTJKfla9uytCajo9QmkhulCAkvMnWXS98wAshOeya4pXEPvOYJXNKpOboUlCoesyDUCRd1zURzdIkxHw7Ictj0Lu
X-Gm-Message-State: AOJu0YyoyC1H8tMkxQ9WU5jwsXogbfY1+L017j6CrhlPGT5GO5Chirbt
 LBOUsUyfsvEVIVOoZDvfy1Z02nQiBUwlATEGG0vsAK5rw+OEXfVHCzOMKQ==
X-Google-Smtp-Source: AGHT+IG504AcnOprhvm0mb1XVnuw2Q/xh1MzTfPlf+zkrUB/fv77MdPE9pcDt/waw8yKSmSeAYnVVQ==
X-Received: by 2002:a17:902:6507:b0:1f4:8bb9:9ab8 with SMTP id
 d9443c01a7336-1f6192f0b6emr13038665ad.14.1717055102928; 
 Thu, 30 May 2024 00:45:02 -0700 (PDT)
Received: from wheely.local0.net ([1.146.118.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f61aa2e998sm8025335ad.62.2024.05.30.00.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:45:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v3 0/4] tests/qtest/migration-test: Improve and enable on ppc64
Date: Thu, 30 May 2024 17:44:48 +1000
Message-ID: <20240530074453.21780-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Since v2:
- Fixed subject typo noticed by Thomas.
- Drop the non-ppc patches from the series.

Thanks,
Nick

Nicholas Piggin (4):
  tests/qtest: Move common define from libqos-spapr.h to new ppc-util.h
  tests/qtest/migration-test: Quieten ppc64 QEMU warnings
  tests/qtest/migration-test: Enable on ppc64 TCG
  tests/qtest/migration-test: Use custom asm bios for ppc64

 tests/migration/migration-test.h   |  1 +
 tests/migration/ppc64/a-b-kernel.h | 42 +++++++++++++++++++
 tests/qtest/libqos/libqos-spapr.h  |  7 ----
 tests/qtest/ppc-util.h             | 19 +++++++++
 tests/qtest/boot-serial-test.c     |  2 +-
 tests/qtest/migration-test.c       | 53 +++++-------------------
 tests/qtest/prom-env-test.c        |  2 +-
 tests/qtest/pxe-test.c             |  2 +-
 tests/migration/Makefile           |  2 +-
 tests/migration/ppc64/Makefile     | 15 +++++++
 tests/migration/ppc64/a-b-kernel.S | 66 ++++++++++++++++++++++++++++++
 11 files changed, 157 insertions(+), 54 deletions(-)
 create mode 100644 tests/migration/ppc64/a-b-kernel.h
 create mode 100644 tests/qtest/ppc-util.h
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S

-- 
2.43.0


