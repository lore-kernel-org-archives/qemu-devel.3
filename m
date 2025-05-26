Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10A0C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQRn-0003VS-Fw; Mon, 26 May 2025 01:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRb-0002sP-57
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:16 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQRN-0002J4-S1
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:32:03 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4e130b8b9acso519961137.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748237520; x=1748842320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5vADRSpaCj/9JLSnM/LCtAoOlQ6L/Ad7qAHo51qFbY=;
 b=R/fIvjEKvMbZfea3G10PL5sEknrHStq6EagxbUJN58xTUyjVwYE7kttFmpgJDDIRVJ
 Gd4nsuciaxonWimrk3WLw3xo1HeqoGRlSV4KTm/loZ6avBSlzB8QWg9o+ootzjsvlv3U
 aICCOneAbpOfwFrARljaNVHYOXRlr78rzdiigg3IMkYVoysYTDE0R1Y1fC85DYLHslRC
 D3IHuqTzHB+EI+yhXLqZ8LzTCiqobqtzKx1ktcwu1pw7Lr5RMFNyxhelpqpIDLu13kfO
 7PQHQFyxuv8JPbY551eO8Vnhx8Z/xMUmYwHXiQHnnk3O7wCs+gW0I2LJpGSKhrIHNYAr
 OPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237520; x=1748842320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5vADRSpaCj/9JLSnM/LCtAoOlQ6L/Ad7qAHo51qFbY=;
 b=COy/MUCtVsydi25ep8t6umaSCzv/xRZ5K1DCGEmdp4Y5Bq5f3eK01PQpmss+KFQHxk
 fddI1yTSahilk6EzYsD48aBvgBYqlQ9RJaFxTHtvUewQOwbWiugX3S7o9pQZYTgcm8/9
 6l5o9dLLidzgzupjTatF7RNle6CrW8ziBE0628cysxdHEuyRUtWcmEwf7UBaFuIYJ4XF
 TjDiMAYAIAVyZ+SbvvujfXoi6XjiQzhwzNvdayh/BnktDv9n5g7rKlneL1uQzbk2EpK3
 E6Gp8d8eeEfOo4g95sA5otauKFkHUsLDV9M7bhmMwi29jv95rLh/2VIDpjnbgT0tJoC9
 nY7g==
X-Gm-Message-State: AOJu0Yw8bQ5xUb/Nyk31W1tiLumfBATp15gaB2egRJDKeFD6PJeOQQWy
 zuMxruH1ccIZYaFw3Lf0Ie9ZZT8F0TpAyCI3CtNkXamDmTZ7XZZW0Zfu4s1o6k9KETkEZOWfaSp
 ZlHAwUJc=
X-Gm-Gg: ASbGnctuqmPdKQaiklhgopncDibL72ORI2/bHMmYoEjTPaKhT6Spa9Wy1FefV7X9Sg/
 QGDeFqMAHQfnB58jcyYwiXhoOxmuLQxiEJbLQHFguzBKjW5CVQBqCPT/SVsIdDf/xqfAjB3qvBN
 euEkximq6UaNKUM59BZ1RZqpxG7vXhlqEGmgvHBo0EnwevY0zk8aTpPcDZYh4O6p/FABEfjKj/l
 p7gch3cI7iaYKVvyOdJyxsmY07b+r4TdtWJXUU1quOFd8Bk3ieuBUPU6uJR54lkAfy28akWRRl7
 Exp0KbBRbOBtnjb2iVrLb8GBCpggHLTLNWtbabC/7yCFVDWsLNoEi/gg5QzNG8rxwqe4sSZczk4
 vEEDji3P92rI9S1uksR5PeQ==
X-Google-Smtp-Source: AGHT+IFDV5nITDE+AAk4SA10CIGkWS8aapNvx5WzwccXba2SmPusZwhwjuTrqZfc1r3CMBUfZfbUGg==
X-Received: by 2002:a05:6102:6e8a:b0:4e4:3c36:9336 with SMTP id
 ada2fe7eead31-4e43c36952fmr3179463137.9.1748237519935; 
 Sun, 25 May 2025 22:31:59 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e454da4378sm784310137.17.2025.05.25.22.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 22:31:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org, mst@redhat.com, imammedo@redhat.com
Subject: [PATCH 1/5] tests/qtest/bios-tables-test: Prepare for changes in the
 ACPI tables
Date: Mon, 26 May 2025 05:31:19 +0000
Message-Id: <20250526053123.1434204-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526053123.1434204-1-gustavo.romero@linaro.org>
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe35.google.com
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

This commit adds to the allow list the ACPI blob related to the base
aarch64 'virt' machine and all of its variants, in preparation to adding
the ACPI PCI hotplug feature, which changes the _OSC method, the GED
device, and adds a couple of new methods, like the PDSM.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..abe00ad4ee 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
-- 
2.34.1


