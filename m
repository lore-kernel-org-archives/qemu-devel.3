Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C6C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaQ8-0005Ov-MU; Fri, 07 Jun 2024 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ5-0005Nw-FC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:17 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ4-0007TS-0k
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:17 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f2b7b19so1086498fac.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717769894; x=1718374694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EKBJ8oPgx6RWyKkHBwS8CUXIUj2Ph4UlirUDin8kck=;
 b=KnutrkLH2ijwMrmuunl4JJy/lAnzCYJn5Nw7akq8yESkdfqeWPs6Q4VB/uGvyh1RcY
 wF6C/S4aI4qkw8ee1u6K8WfYOkfjQX84k7lXrGRdgmhbaaHwdHEcxv0MiolLQFDJcZt0
 BQKrh8ybkd/o4O9vGJi761g3hkcH5QQhYDES0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717769894; x=1718374694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EKBJ8oPgx6RWyKkHBwS8CUXIUj2Ph4UlirUDin8kck=;
 b=U9H/uYSs1oNVuVcJihYln0pPsQT/toxWwd7IzGbzSSq/aKbZMnpoi586ZRf9/VywF7
 /Sfm6wB+mKcTI4Hn2WylajE7d6s5Eq/RP6QXq1Ayg/qYWr38qwp+yto+MQqEqOlo2HDO
 0ho/qCO6abxvjcESrkFPqNOv5F5UeurmrMamNEE0IxQa/C9ds3/99Zzz7M+ef/i2VOfb
 OsCZqfVCnyEmr8Ixfu3kLdKlhijb99a2i1ZERnptsDTJSY6hd6TAUJGXCQ1K1uAZtAzE
 xKgLqaugwYJkjV16gZUY3eLVXNZxs1/NPEdxIZbWB1EJJHDY5uP5CmWAEFnzWZ3SH/ZD
 Hdgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP5RAJhFowOTNpHTbuAvW8udipTSN0mbBcxoyHrPlKeXMrroZ5oPXaEo78yLvsMtACWorBe4sqnvSzS+jNfCAOB0ISlO0=
X-Gm-Message-State: AOJu0YwXeXievM1+RBeYlPrm6KwOmhXxC0FFuulyNgInYBQX1RHpHF4a
 WTFYj8oNc3bPDQAVhVHcuILCp1UKaKaTJVhqZwV/2JDeiiZfCeGbf7n6uYEEoA==
X-Google-Smtp-Source: AGHT+IGea9xbmP4pQjMRnCYNO64QwxZqXeDkwvVLTtam7GRMX0N/6D/lCTHWeswr0uamFTOACHqFUA==
X-Received: by 2002:a05:6870:b491:b0:23e:6d9a:8f45 with SMTP id
 586e51a60fabf-25464f0d3abmr2632335fac.48.1717769894101; 
 Fri, 07 Jun 2024 07:18:14 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79532813a2dsm170873885a.20.2024.06.07.07.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 07:18:13 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Fri,  7 Jun 2024 14:17:24 +0000
Message-ID: <20240607141809.1637137-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607141809.1637137-1-ribalda@chromium.org>
References: <20240607141809.1637137-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=ribalda@chromium.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b2c2c10cbc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
-- 
2.45.2.505.gda0bf45e8d-goog


