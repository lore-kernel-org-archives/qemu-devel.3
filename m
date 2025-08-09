Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E3C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 21:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukqqV-0002y6-9a; Sat, 09 Aug 2025 17:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqM-0002oG-K2; Sat, 09 Aug 2025 17:11:10 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqK-0000TM-Th; Sat, 09 Aug 2025 17:11:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-af9180a11bcso660389066b.0; 
 Sat, 09 Aug 2025 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754773867; x=1755378667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hy0jRWoRKSa/ItelcnJbwYMxz/tJPxS++i76CTjN9hM=;
 b=QeZjXYxqeFQcVXHoJ5nfZe7kaFZFNkB0MqgQj3l1e60DkST6GzLqlTcBUEm0jiX2Of
 /eNyh+0LXvU2DIm5wHdzV8rRUdRpxwg3Wobq7VL1ejFqkSKqMFIfGRLaxuTu7WErrLzQ
 LptLkW2dkVSriMKxv75QSFW+1IWaEUg7VBcgi14McJLvpj4vr5bW+rFkHWTbJi8ps6Tz
 V4POCfmiQNhaqnVFCYUSO9vP3poKOsMztkKKAhYqiJOoJm/gRFM7o1am/y9zGC4JoDyN
 Ja9i73rltLQxDKc4ocx2dZPJAP2R+CxbJ+daVQHW2RfmCmTbKUisyegbLE2tCvqnerE4
 Zk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754773867; x=1755378667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hy0jRWoRKSa/ItelcnJbwYMxz/tJPxS++i76CTjN9hM=;
 b=j0hpo4kPBgbn2kxsFK55HxJX4HLh0bbNVXQbwAZQVuFO/D7jrZGY9aNhfehaXJlHIy
 /snEeRQtnmdj0q1nlAl1QpeLZ0jyVXy8YVpFOioZ6xHjdtzz0Mnjfu3g07b1skozZat6
 eyymARSjOQOUHlUA8Gmo/3pqpitI93z5+e2PFyITSmkV+cND0SmX7u6sKtl8CXPldp3J
 oNQELs1Ql3yx0xQCl2OJEZlrUFdds4hVx089hCPSWMCg7Fx2rlYMzoXZkeYeWEnmORyx
 tu1gfwU86WGDmj8GIgRfKugj3mImRyoDSwSeDhahP+KThA/07OQx+57Mzaw+EewEN8ns
 OCVw==
X-Gm-Message-State: AOJu0Yy61jefj34INXhe8g28ehz/A4LIfbPofnwT9MJEivgZvq2dTnnE
 LCAcuJNmkP+s+0d5ukJgT3VOfjKDcBiW9aZn6bcA1mNcFg2vR1pKwprSNyKCJ8vCBIQ=
X-Gm-Gg: ASbGncs5TbbFWREr9SNcfUn12yCvoQ3eIN0FjT7mTdehimyU9ktixZKKvcAgIHh6pHM
 l/JZTMur0wmuXr23vj0QP1aZKnjeJRNWGkLzW/mHG1cCsBfqCwu5hp9OZ0+V3+XgbhpOtC8HrzN
 I8bCA2n4iwxCxKWuqdg9HZ8nMQAlsUOyedFi6Uaqdd2Ygzj3YOB7lqhfSSXrczaMFDKlmvK4sdQ
 OijBoOCL1BdBmWzgNiQD/jUAS+X5xWXu1uewluKw8c3vAP2a15oIYVYtjB/vGXit8FgrTeQgd+M
 qapK/mNDFEKsPNnvZjEkP0GEjAFQiyRslh3HxfFaFirI2ugwgNjCszX0dOsam1bwLKCsa4Z4EbO
 ZrhErPr28r4+ZmAnWaeukSaNXBbKuLin5snEldgAori+Hbh0O
X-Google-Smtp-Source: AGHT+IF66LENE1fFLXx2cWgIkhikOv2s+KX10w26arXhQyxhLvSmGNR/IFog2DM3TFpiWm4/WtUG8w==
X-Received: by 2002:a17:907:948d:b0:af9:21ed:6ebe with SMTP id
 a640c23a62f3a-af9c700b437mr659975466b.21.1754773866577; 
 Sat, 09 Aug 2025 14:11:06 -0700 (PDT)
Received: from localhost.localdomain ([87.251.30.120])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-af91a078a11sm1759490766b.7.2025.08.09.14.11.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Aug 2025 14:11:06 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/3] tests: acpi: update expected blobs
Date: Sun, 10 Aug 2025 00:10:51 +0300
Message-Id: <20250809211051.68824-4-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250809211051.68824-1-chichikalyuk@gmail.com>
References: <20250809211051.68824-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=chichikalyuk@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Previous patch changed the SPCR ACPI table for AArch64 virt.
Hexdump diff:
@@ -1 +1 @@
-00000000  53 50 43 52 50 00 00 00  02 b1 42 4f 43 48 53 20
+00000000  53 50 43 52 5a 00 00 00  04 78 42 4f 43 48 53 20
@@ -5,2 +5,3 @@
-00000040  ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00
-00000050
+00000040  ff ff ff ff 00 00 00 00  00 00 00 00 00 36 6e 01
+00000050  00 00 00 00 02 00 58 00  2e 00
+0000005a

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 tests/data/acpi/aarch64/virt/SPCR           | Bin 80 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
index cf0f2b75226515097c08d2e2016a83a4f08812ba..6df47f5c95dfbad2a0b060151c0733bdbc9f7392 100644
GIT binary patch
delta 30
kcmWHD;tCFM4vJ!6U|^}3$mPsymd6NWGcYkkFz7J=09{iA+W-In

delta 20
acmazF;0g|K4hmpkU|`xfk;|DG$N&H@<O9(F

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a60794a3f6..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/SPCR",
-- 
2.39.5 (Apple Git-154)


