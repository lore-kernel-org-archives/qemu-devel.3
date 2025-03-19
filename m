Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439A5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4K-0000Be-4l; Wed, 19 Mar 2025 14:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4E-0008Uq-U3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4B-0006Mg-9V
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so49877005e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408578; x=1743013378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xItThavxbz79L7NOidpyzs2tzBWqOmj6JZGfASxb4os=;
 b=SscHJqBTBFWXdkeJwyb7PRP4rUqBd6duBxNtZQpSAT20TqQa4bRUCeJG7lliHPeYo9
 J0kq8FU9jV0zPAg7GrqlqDGfiKnN69bh0db5772F2Noeb0JckM9sHHWE57sa69JyOdg7
 EmMo3aDdliIyiXfxgIn6fdlOEtAepuZFKdJJlhKUNS1ayJ/PSfBZHV2k7DsUe1kBZ03q
 xzARHUJoOK9kDg7cv2YA0E6eVnpWH9xAB4NBFz52NEINHU+dsTP/Rgf0lf1XHlVW8yX0
 uLZLAoa92pXn05sx7rz0PGeDmS9YUlydBGEz36Pjd84DgO998xxTsyZNPNf6jdch3CYD
 LHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408578; x=1743013378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xItThavxbz79L7NOidpyzs2tzBWqOmj6JZGfASxb4os=;
 b=G/NLdvYztYdvpaUhXbo0f2xNe4+PDqBiTJEOBmIH9+wq2wY/MAT+QOff2myxc48fAs
 OaZGaL6hf4YWwSRTa3pdUQqV5IBZzqW1vYkoAG+p3IzX5sTCzb4sLJKf6mm10ApLGQYN
 uR4vdNiw3sybLHGyu746iSE/3EA4Ed63K/MtWjIDSLkAb0IV+S3K3dvcV0hTBTCCyd8U
 IuZsS0lMTvMw2YB864B/bZDBTQu3qxevuOrY7My1XJIxU7/JKMJQw5tU2d6Ctxsfy8la
 a/ZnrYEATW48KDGNa+1n7C9FQINprycMt9XovrWV+wxNfQHym5lryQrVQGlequn35mI4
 WEmg==
X-Gm-Message-State: AOJu0YwkvutOnOlkI4mUPOx+qvQyiZaIfmCji3Hf/zl0NgoB3XZZRvO8
 nm0/x0Qg8Kx0Zod2+2JvWLbaGZZtlhOV7Q2ggvGroX3NLcphm+BIcgWBmx/GXUY=
X-Gm-Gg: ASbGnctqeH/1c9iusDpMU0gAHlgrL6qQ9oqrVUNugWUYbM1FRDNNkAKdYQzHeXUSIIZ
 tsIS7qXENTURDZCJ1jbyt7ofbDrbDYEWyiCMobE86bNSq8QWrjAFjyvLyamtZHLfNhbBVt8IOfy
 u31pOj8oxMnDCIgG2EW2m+ckn0bYmyvEbirmKeYhpK8+jx2r6gG8+W8ryvdHtaGfekFbFwLUYK4
 GNAGHTFMY/il1eDddUSqxM3BC9pLfJ4N6iSjVe6FG/cjhYH/nY37U4Z0HiYNVqSaFqNm7Ro9Ssz
 TQr5/9ijKsSVkZkw5/GZ98hpVFNIx5UNeQdT6QQjiHe8LQg=
X-Google-Smtp-Source: AGHT+IHrirMGLJOsTvn3TyaLhG6Us97Zd0BeQXlzpZv0ZprWPbnGw2yk2OkIryEbStosDw7BQgNApA==
X-Received: by 2002:a05:600c:1906:b0:43d:2313:7b54 with SMTP id
 5b1f17b1804b1-43d4950e273mr1767245e9.3.1742408577496; 
 Wed, 19 Mar 2025 11:22:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f32fcdsm26234845e9.7.2025.03.19.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 356E55F93F;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Date: Wed, 19 Mar 2025 18:22:45 +0000
Message-Id: <20250319182255.3096731-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

The aim of this work is to get rid of the endian aware helpers in
gdbstub/helpers.h which due to their use of tswap() mean target
gdbstubs need to be built multiple times. While this series doesn't
actually build each stub once it introduces a new helper -
gdb_get_register_value() which takes a MemOp which can describe the
current endian state of the system. This will be a lot easier to
dynamically feed from a helper function.

The most complex example is PPC which has a helper called
ppc_maybe_bswap_register() which was doing this.

This is still an RFC so I'm interested in feedback:

  - is the API sane
  - can we avoid lots of (uint8_t *) casting?
  - should we have a reverse helper for setting registers

If this seems like the right approach I can have a go at more of the
frontends later.

There are a few other misc clean-ups I did on the way which might be
worth cherry picking for 10.0 but I'll leave that up to maintainers.

Alex.

Alex Bennée (10):
  include/gdbstub: fix include guard in commands.h
  gdbstub: introduce target independent gdb register helper
  target/arm: convert 32 bit gdbstub to new helper
  target/arm: convert 64 bit gdbstub to new helper
  target/ppc: expand comment on FP/VMX/VSX access functions
  target/ppc: make ppc_maybe_bswap_register static
  target/ppc: convert gdbstub to new helper (!hacky)
  gdbstub: assert earlier in handle_read_all_regs
  include/exec: fix assert in size_memop
  target/microblaze: convert gdbstub to new helper

 include/exec/memop.h        |   4 +-
 include/gdbstub/commands.h  |   2 +-
 include/gdbstub/registers.h |  30 ++++++
 target/ppc/cpu.h            |   8 +-
 gdbstub/gdbstub.c           |  24 ++++-
 target/arm/gdbstub.c        |  57 +++++++----
 target/arm/gdbstub64.c      |  53 ++++++----
 target/microblaze/gdbstub.c |  44 ++++----
 target/ppc/gdbstub.c        | 194 ++++++++++++++++++++----------------
 9 files changed, 257 insertions(+), 159 deletions(-)
 create mode 100644 include/gdbstub/registers.h

-- 
2.39.5


