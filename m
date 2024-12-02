Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2602FE69E94
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDDY-00020q-V3; Mon, 02 Dec 2024 15:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDX-00020a-8C
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:27 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDV-0005Yh-JR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:26 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so809942066b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733172023; x=1733776823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iP7yF5GPIVTV0GRtgGJcyPA+z3a6BZgq6N3Cha32UkI=;
 b=nelolVYZg/iJYIGD0yEKW6TrD7AQ/I57fowSz6seeE4Uey+GOX4ZpYRlQLGYCR8zrF
 /AK6kpevjhiPyXIdLVjruQc3ypIBKI0K3PAwC1U8YutCHnzTvRU73x6Xw1h+OzaNK6rY
 U6+9ykKBHPxEosbaMCEVbTYDDqQtNi5QakK9bwgAjhXJP7WFTWVK0+wXQt6S3bzCj2GV
 PmZuiWXsDiSRFa4GIiRiVst1EAJ3WG77LepGUh0OAj6XJdYbgMEIYsy8FItUw6Bw6qq8
 8ryrl69CJzvJbj8wJo2KDLjv3ZJxv2/bl5LFiOLEL/nSO91OOC5kbTUeC/1ufElTZyye
 OGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733172023; x=1733776823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iP7yF5GPIVTV0GRtgGJcyPA+z3a6BZgq6N3Cha32UkI=;
 b=nUbozYfdfuLP9pEnxmKU8nMJGh/EqVVCpdRCrha0kgpZq1eZFXG6HkjILqDP9d66wb
 sGpq6EZbimSruLisDCO8w3O737kgZ9Ik6TYUNs62dBIbddEvNq3iBT3qVzA8fwzTOs/l
 nncckYOvBCK/udXYCRI0vKy+OYDRRweABpGoOWopJALI3p7RzIcQvbc/TGHfy4UOKYae
 celQKPnASsVVLLvsju1t4HWLlGoAgHCQy0Opz8bPXtygFiYH/n8sKGCSs4P3sTi/giZf
 yRqsyuAn/JYRWJPnJFXpbax0JIYuzv89+9eXm5HYlAliDBOUi8hiUA34cZcPmVIeymQz
 618g==
X-Gm-Message-State: AOJu0Yyi8LszgqjuNTbi0nvR7ozT5KK53vW2rt0RQEiwiBRBUYYwvN91
 f8kcj41N2yMk5W4Qu04xXdTQjeR8zwIbfPZKNdblnUlaJaPmJqgX+h+v/7SxPm3hZCBKjfvS66E
 XDIo=
X-Gm-Gg: ASbGnct+SEhgJ0nN++NcO0IOWwuoo+OozaR6BWXPr6fHODX9aFbH2gbt0sNxMKB5ozg
 03tLH+I+CpblxLRQvovUzkC0h7WdvfSxJBdGefMzH6Yqw2dSSRBKmSDkC/jh1xfvemyXiTN/W6s
 zIGi2YOnHPfmkQ5Jwfs3bPLOuxeorHiyoSKEcRZnCLdZ25QCwYtlH6F73KxKyN9mS9GHGYq8vHn
 LgACNAZ33yuserwuku+HOvkrdzj1ojYuWegWd3kn57AfSA+ey6P/jChCHifr2TD864OIiDL
X-Google-Smtp-Source: AGHT+IEh7OftC3eNwNLUWGxserCHzyPx0WrfQPCo5twtNar87A8t79sWPRMUfrdPvFt79HS41wWL7A==
X-Received: by 2002:a17:906:1bb1:b0:aa5:26ac:18e2 with SMTP id
 a640c23a62f3a-aa59466fda2mr1767260966b.23.1733172023443; 
 Mon, 02 Dec 2024 12:40:23 -0800 (PST)
Received: from localhost.localdomain ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6da2sm547112166b.102.2024.12.02.12.40.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Dec 2024 12:40:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.2? 0/2] tests/functional: Fix tests failing when TCG is
 not available on macOS
Date: Mon,  2 Dec 2024 21:40:17 +0100
Message-ID: <20241202204020.55665-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Explicit the QTest accelerator to have these 2 tests
pass on macOS when only HVF is built in.

Philippe Mathieu-Daudé (2):
  tests/functional/test_version: Use QTest accelerator
  tests/functional/test_empty_cpu_model: Use QTest accelerator

 tests/functional/test_empty_cpu_model.py | 2 +-
 tests/functional/test_version.py         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2


