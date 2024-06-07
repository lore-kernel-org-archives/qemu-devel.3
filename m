Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABFC27C5F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaQ7-0005Oc-KC; Fri, 07 Jun 2024 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ5-0005Nr-8r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:17 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ3-0007TP-JE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:17 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7953f1dcb01so55837885a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717769893; x=1718374693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GswNpYyzrojMh6Rycvh4hXEO2qJe9DuvUgxafxyx38I=;
 b=WyTjN9cAwqVWldPFOicCHrdeIcv0JrITbUh5kDMDqPrjdSEDYXKs8cUDtaeHKbC2xv
 DdMNr7MmMEKGRU3idYWDOIAwJ/MCtOTEodZItnv8+3TYgr0viNDNYmX9FTGdMAPdIQEq
 ZE+KOfAfcxbi0WcO61B5TrW387H6MhuWRzm/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717769893; x=1718374693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GswNpYyzrojMh6Rycvh4hXEO2qJe9DuvUgxafxyx38I=;
 b=UpdFPEeOVzJo94OtuH2bZH8349ikYaUr5yg8SGOMIMqe2LaCpKzTQ/ClgI+2wmiUkQ
 M3Ef6hLCuBd+CQs3KIsGH94cgTue0ajn9piVJdeM47fiR1Tm/Z1ViS0ViIfgVjIXTjXU
 +8GZCU5xBH2gOcJ7RWtycff5+MeCE++96Tb9jzLA1fHPNhzxycmMW1IA8T1e81gDKnk6
 muoT8NKVzAE0w0HZXcX8ySQfi4vPA9AlFvTjtMCoXa512cFQzgIXcLXqPkT9PsQJleq+
 LtAibGgYCuXJpG7ngMWxHEkU0PaA/cYzdKA2Re2eeztGc+NPN2HpmUVWDt1vcza8xDS5
 qxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1i5AVXQaAk5F9zdfi9IbjX1Ln3Z89UTUZiemt5ISNKKzgQm/SnmyqP8mFo6gudmmdhh2qCfqPy5yndJ56ixI9vztrmOY=
X-Gm-Message-State: AOJu0YxU1gBBPtHBfqOu1WT/BpoWKeCUzg6NLLDD7Sjvuub+8OD04H4z
 7X1eP32QKf7cv7qCGsTmCTimqRPTJxDotyTykKUC356r47jKX5nQCmwZeF30vg==
X-Google-Smtp-Source: AGHT+IEF5m/WEQN+G9SSM+q43DSdMOCP7+EOuarQxwZXqR1ew6jmG7i/S4utZTWlC922HqBqR3kxww==
X-Received: by 2002:a05:620a:394e:b0:795:4745:df49 with SMTP id
 af79cd13be357-7954745ed8emr143030285a.65.1717769893498; 
 Fri, 07 Jun 2024 07:18:13 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79532813a2dsm170873885a.20.2024.06.07.07.18.12
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
Subject: [PATCH v3 0/3] hw/i386/acpi: Pre-compute the _PRT table
Date: Fri,  7 Jun 2024 14:17:23 +0000
Message-ID: <20240607141809.1637137-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ribalda@chromium.org; helo=mail-qk1-x731.google.com
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

Today for x86 the _PRT() table is computed in runtime.
Under some configurations, computing the _PRT table can take more than
30 seconds and the ACPI timeout is violated.

This patchset modifies _PRT() to return a pre-computed table.

Changelog v2 Thanks Michael:
- Code style
- Add cover letter

Ricardo Ribalda (3):
  tests/acpi: pc: allow DSDT acpi table changes
  hw/i386/acpi-build: Return a pre-computed _PRT table
  tests/acpi: pc: update golden masters for DSDT

 hw/i386/acpi-build.c             | 120 ++++++-------------------------
 tests/data/acpi/pc/DSDT          | Bin 6830 -> 8527 bytes
 tests/data/acpi/pc/DSDT.acpierst | Bin 6741 -> 8438 bytes
 tests/data/acpi/pc/DSDT.acpihmat | Bin 8155 -> 9852 bytes
 tests/data/acpi/pc/DSDT.bridge   | Bin 13701 -> 15398 bytes
 tests/data/acpi/pc/DSDT.cphp     | Bin 7294 -> 8991 bytes
 tests/data/acpi/pc/DSDT.dimmpxm  | Bin 8484 -> 10181 bytes
 tests/data/acpi/pc/DSDT.hpbridge | Bin 6781 -> 8478 bytes
 tests/data/acpi/pc/DSDT.hpbrroot | Bin 3337 -> 5034 bytes
 tests/data/acpi/pc/DSDT.ipmikcs  | Bin 6902 -> 8599 bytes
 tests/data/acpi/pc/DSDT.memhp    | Bin 8189 -> 9886 bytes
 tests/data/acpi/pc/DSDT.nohpet   | Bin 6688 -> 8385 bytes
 tests/data/acpi/pc/DSDT.numamem  | Bin 6836 -> 8533 bytes
 tests/data/acpi/pc/DSDT.roothp   | Bin 10623 -> 12320 bytes
 tests/data/acpi/q35/DSDT.cxl     | Bin 9714 -> 13148 bytes
 tests/data/acpi/q35/DSDT.viot    | Bin 9464 -> 14615 bytes
 16 files changed, 22 insertions(+), 98 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


