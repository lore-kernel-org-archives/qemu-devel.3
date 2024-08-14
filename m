Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59927C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCdQ-00046X-P5; Wed, 14 Aug 2024 07:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdO-00043N-Vh
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:46 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdM-0003Xi-Nv
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:46 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf6755323cso724376d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723636664; x=1724241464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS/4eu0i7qnpPSrFXWbFUJUfVGkHkmY+q/9pM4o5Aow=;
 b=oFKT1zaeF4e/5jeuIdqw5+iev04/Q22D+AjcS0bIXKtMenO7v7yt7kzxMuOukXE22K
 YI1Gm6IR1rYucENPE1QHuCILB24TnMyY++AkCnwSSjvpA+smY/C+NYY7aGJVPpz+W8Ms
 tzDQXD0Ig+KSAfl1HPGynKr1W3vcqyyV1jTCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636664; x=1724241464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XS/4eu0i7qnpPSrFXWbFUJUfVGkHkmY+q/9pM4o5Aow=;
 b=ubFxM/DuZ9MT7Eslq+GpaKQqTvOPS9UF6z3KXRcIeyf/t6e5ksjK6SpWG5tdY3qFNT
 Bs48Fu9KTcdqPG9YzwRMxQChcmeRlMEQrAQx7yIDC4YLBzL2RyFwAsLim8XO2GaV2bcz
 WIAWsf7IjIdzXJ4jfKJUdlD7FYsvwDf1FjAUeC4FG/CzRQXmYWweTRcm66HTo4A48wyD
 bcZ2Crb3wZVdU5Hqsm/FQVvuQKZwE6JbqaDNIkmG4BA43hHmL7KEbS0ybeNn6IzTOXV4
 fiyI1jhUzBFET4v4Ze+ytf/xGbBTA6/m0NKsYiKV2abCoWESYnFTxq0cBgStJr9Zt5xK
 tjMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjLGHO/EL9pcheu1L3ZVaHEx0AYZAuRrro33EKiCHhl7d/8HAxKgTKtQ7JOoaUkFCGaAlfcjD9SFL14BPWoFgPQJGFdGU=
X-Gm-Message-State: AOJu0Yz9CD8INr0yPLWjKAlnN/oekmhxax2NfBUKX/KTFhVgsIHwYWSw
 IDidjlpWztUNU+yzTJBVmxNrBA9rtJ93LzxZ1yYHhVEn49ym92+PlLtSvdo5AQ==
X-Google-Smtp-Source: AGHT+IG4O9chsKcVeax35SEd3Jes7TLoso9syvSSxfosjOjRR0c3fSE43Itiquq+g1BTvBUXhCTR+w==
X-Received: by 2002:a05:6214:5b0c:b0:6b7:4398:594c with SMTP id
 6a1803df08f44-6bf5d1f5394mr18524656d6.38.1723636663721; 
 Wed, 14 Aug 2024 04:57:43 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82c5f375sm43001586d6.14.2024.08.14.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 04:57:43 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Wed, 14 Aug 2024 11:56:09 +0000
Message-ID: <20240814115736.1580337-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814115736.1580337-1-ribalda@chromium.org>
References: <20240814115736.1580337-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..f81f4e2469 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,16 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.viot",
-- 
2.46.0.76.ge559c4bf1a-goog


