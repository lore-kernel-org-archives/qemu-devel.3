Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E369EC5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtfJ-0008PV-4r; Sat, 07 Jun 2025 09:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uNmfz-0001a2-HD
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 02:05:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uNmfx-0003PC-W0
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 02:05:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235a6b89dfaso4725415ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749276304; x=1749881104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cfDoMuhI7Gldw7nCdfYIkXAF3bm6PbFrhph+ITePBMQ=;
 b=ePCFSrKpvvfYo17dDxJS4htNHXJsTy4KjW/ZrBuWD4BkEO5rIKeYMj2Ul97ZFe4anN
 Ya8sI3JhysuHGtbR+PsjIHgG2V0kK1V5D6eETjbFq8oCqsLF58K3EEIdEBj9I1qLfE8Z
 OX0ANyX4dC7XMf+B8Rj42ujTYm67S3QGQdceQaa7B2pUdTxmJOrF+Ncqa1eIU9FseFI0
 jSF03rCJrSGszxg05LO09E+gR3RC4J5VH8Of0Jyb7eL4ffSbsSsN94dtCpRUN/lV6hLz
 iWcACfXFdQQh/jda9O72GViq3tl0hGumNFweu766W5AvGzGZ7j15kG451pmbXKYM8MH/
 OUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749276304; x=1749881104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfDoMuhI7Gldw7nCdfYIkXAF3bm6PbFrhph+ITePBMQ=;
 b=vuITqZ/ABQXJFyCcACp4cKYtxiGEdvhaap3TKytyUtvPY1D5NGhlhqXONiZbRrmtXV
 IuPGixlYQjo7kyKOgLde2m7aP5hG8hqL9mVhXcHXZJDVC66UJ8veNuHXmCvbICF67h0r
 Q021dQXGlPxyETf5gK/oa3ecqrlFn0UUVqXxZ66gxwHm36o0lenFoyEZtICqkOZeHHyJ
 Pc5NiwUFkWxHRtZTCzHcnzIf3xwBL1FwpzQcYnmkdAn/nlxgmXK38jrmyj6+aEsF65r5
 QAZ4Z29CzZKxoQQLrONzRWHa7oEIpALKTAgC24iI/tqke+Yeefx86S/SqW/DSimCDHRI
 C7AA==
X-Gm-Message-State: AOJu0Yw2DCEoUEFBEfARR8tG7ssKksDezgQKPbh4PjuTjdjHgfMWyioc
 CXKKVs/X/VHmqZf63RUl3G+1rJBTr8URpetXgJp1rAXE7ENijVWu0jv7QuUgsRaXd2Ugnw==
X-Gm-Gg: ASbGncujB3NbreeL8GUHrC0GjWnuDMd4TDyp42iCnsMv7cpXEqXO3TNveruAdfIndnY
 LauAmgS3BIpfcqTZ1khXaON8m2NN/uxut7tHLISsAAIQQ4cyEheyMBqCEzVIkmgFxLeDglAP9J/
 GAxASILYbdr/MIxm8CeMJVfaVQknfU/RWGagp745rrC7vC7AcvofmFFy2UjhieDCOz3SIxZOJ1q
 lAw2C/eYp20LoUldUNWS4N/RWzYwaIoLAzp1nMwL0B5qEgmNc5rUmCc/VxLSJEhef/GkTZn91xo
 tjjtkXxeoC0MyB9w549Cyt+xozB6SLo5g0ToVq9p7nb34CWzLSHlwyGh
X-Google-Smtp-Source: AGHT+IHtYtiHdUOYQtjFhQ8PlvkLbB9NJeagIrgPQMFF1b6/+80CrqZe9xaKTNPfNcQtnH+LdakYKQ==
X-Received: by 2002:a17:90b:4f47:b0:311:9c9a:58db with SMTP id
 98e67ed59e1d1-3134e3123ebmr2876229a91.1.1749276304012; 
 Fri, 06 Jun 2025 23:05:04 -0700 (PDT)
Received: from bong-com.. ([210.97.55.153]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128dc7sm2135597a91.23.2025.06.06.23.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 23:05:03 -0700 (PDT)
From: Haseung Bong <hasueng@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com,
 "haseung.bong" <hasueng@gmail.com>
Subject: [PATCH] tests/vm/README: fix documentation path in tests/vm/README
Date: Sat,  7 Jun 2025 15:04:56 +0900
Message-ID: <20250607060456.28902-1-hasueng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=hasueng@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Jun 2025 09:32:51 -0400
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

From: "haseung.bong" <hasueng@gmail.com>

The README file in tests/vm/ points to a non-existent file,
docs/devel/testing.rst. Update the README to point to
docs/devel/testing/main.rst, which now contains information
about VM testing.

Signed-off-by: Haseung Bong <hasueng@gmail.com>
---
 tests/vm/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/README b/tests/vm/README
index f9c04cc0e7..14ac323309 100644
--- a/tests/vm/README
+++ b/tests/vm/README
@@ -1 +1 @@
-See docs/devel/testing.rst for help.
+See docs/devel/testing/main.rst for help.
-- 
2.43.0


