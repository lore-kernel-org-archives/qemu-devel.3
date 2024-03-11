Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D936CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl6O-000482-Ji; Mon, 11 Mar 2024 15:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4p-00033q-1m
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4m-0000KG-8L
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41331166961so1665215e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184362; x=1710789162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=favtUxLmDKXZiO4JfZ2fj5dy5zLH5B1wjbEvWCFDgAc=;
 b=xJk05WX93WhKVO7uXeqwVv3e3lM7uPvQKM7p10jQGbJ8gxjuLskFMPzsmJ3UHj/a2O
 kag+GsKnEz+mBB7pcooDhvohMkEPxw36dbM5o/gtJlZVtyWtUxBaatpbnTpanEMzXq1I
 YU/KEjWV8N1K1KYk2OlU5a3N9ZZ67zryWkHE54KKJQxIRA1tHhgchKbmT5T3BK19DEgY
 E5voziRvYQHa8e83nK60eX1v9IaEM3BtXlL/LiJwNEh2TNO0lSjkM1lQO8I2iANzcAMg
 fRitw1jF/1wUsASdgqq0XQrUzJVbWZN8WOmZV5LRedOuClmDy3IQ6rz0F1eg+ClCDWPs
 1KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184362; x=1710789162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=favtUxLmDKXZiO4JfZ2fj5dy5zLH5B1wjbEvWCFDgAc=;
 b=fAZvKJl7ch/Kli4flS80n2LspY79SezbiLdaSqLQCRXyq1dm7kIuqM9eyABgC9FlaZ
 oVQGjNxHTH/tZGLKtd1fKq4GzLKiFgQ6HvEyYcZdmH/z2Cz9vLyGcPQTlJf2E2eT279I
 gbiMWHAb2e6lWhOgROOXSbN4eXigKUoVM6ahILn06NS/tWJsK0eDmcB3neJ1n1Rn+O1l
 M+7x4MaVvA91R0qBpPtQ3k7OJb1LCO6DGOpYAf71Td4d1R2KhgEP6y+QtsnNE37aAMQI
 0EJpPL61R9q1Cns/cA2MTly3s3rF0/KXiu2fG4YibdiIJJuSOKPkOa0C+WokHfoavZDb
 i1ZA==
X-Gm-Message-State: AOJu0YyaM6YnK7ZveaCyYEtPCadx0INW9Ujd51hAcrF44kpQcvufi/pw
 YS25QRj8FI17ND28IAGM8Ur/FWdWoGNa6Rcx4DGCVIZY8CKlQW45OfWJCFlwkY7kWeI17Gm8ayI
 6
X-Google-Smtp-Source: AGHT+IEnD2RVHkwdxb/1wvuB05txBLxJzl+k+h8JhDFUoagc3q9kF4lEVmwh9cYxlv1z2hLzV8+fXw==
X-Received: by 2002:a05:600c:a06:b0:412:fa5f:7f85 with SMTP id
 z6-20020a05600c0a0600b00412fa5f7f85mr5378416wmp.19.1710184362560; 
 Mon, 11 Mar 2024 12:12:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] target-arm queue
Date: Mon, 11 Mar 2024 19:12:21 +0000
Message-Id: <20240311191241.4177990-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240311

for you to fetch changes up to 5dd6bfd90d01e0cb27c349157208e5e4ce883846:

  docs: update copyright date to the year 2024 (2024-03-11 17:21:21 +0000)

----------------------------------------------------------------
target-arm queue:
 * contrib/elf2dmp: Improve robustness to corrupt input files
 * docs: update copyright date to the year 2024
 * hw/arm: Deprecate various old Arm machine types

----------------------------------------------------------------
Akihiko Odaki (18):
      contrib/elf2dmp: Remove unnecessary err flags
      contrib/elf2dmp: Assume error by default
      contrib/elf2dmp: Continue even contexts are lacking
      contrib/elf2dmp: Change pa_space_create() signature
      contrib/elf2dmp: Fix error reporting style in addrspace.c
      contrib/elf2dmp: Fix error reporting style in download.c
      contrib/elf2dmp: Fix error reporting style in pdb.c
      contrib/elf2dmp: Fix error reporting style in qemu_elf.c
      contrib/elf2dmp: Fix error reporting style in main.c
      contrib/elf2dmp: Always check for PA resolution failure
      contrib/elf2dmp: Always destroy PA space
      contrib/elf2dmp: Ensure segment fits in file
      contrib/elf2dmp: Use lduw_le_p() to read PDB
      contrib/elf2dmp: Use rol64() to decode
      MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
      contrib/elf2dmp: Use GPtrArray
      contrib/elf2dmp: Clamp QEMU note to file size
      contrib/elf2dmp: Ensure phdrs fit in file

Ani Sinha (1):
      docs: update copyright date to the year 2024

Peter Maydell (1):
      hw/arm: Deprecate various old Arm machine types

 MAINTAINERS                 |   1 +
 docs/about/deprecated.rst   |  15 ++++
 docs/conf.py                |   2 +-
 contrib/elf2dmp/addrspace.h |   6 +-
 contrib/elf2dmp/download.h  |   2 +-
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.h  |   2 +-
 include/qemu/help-texts.h   |   2 +-
 contrib/elf2dmp/addrspace.c |  63 ++++++++++-------
 contrib/elf2dmp/download.c  |  12 ++--
 contrib/elf2dmp/main.c      | 168 ++++++++++++++++++++------------------------
 contrib/elf2dmp/pdb.c       |  61 +++++++---------
 contrib/elf2dmp/qemu_elf.c  | 150 ++++++++++++++++++++++-----------------
 hw/arm/gumstix.c            |   2 +
 hw/arm/mainstone.c          |   1 +
 hw/arm/nseries.c            |   2 +
 hw/arm/palm.c               |   1 +
 hw/arm/spitz.c              |   1 +
 hw/arm/tosa.c               |   1 +
 hw/arm/z2.c                 |   1 +
 20 files changed, 263 insertions(+), 232 deletions(-)

