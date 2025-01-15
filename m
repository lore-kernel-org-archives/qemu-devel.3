Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227F1C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjF-0000H6-Vh; Wed, 15 Jan 2025 18:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjD-0000G1-9c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjB-0003pr-RB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso1500465e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983392; x=1737588192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0j4K60G/+NPzfBz6VwUPX3RpYVnufxaRC/J6EqkjwQ=;
 b=OeAwRl8R1DtjiYSUEYn6GRIvLzX4adm566pH8ICfsYY3+H1J15ECdPWRrYxx/zIbYD
 CMbAlfzeOaBPW87gzxBxC8rCQRk2DzRRe2PE5Xi24GG27wqBC5W9S9CRf7tTNXQ0Om5h
 LYYwhaXtWBar0tdzKGe15D5ev7knPv9Xhgp6/m3ZanlJtO+Hf1wnP2t9D99JpeOYPdh3
 KnS6lvpRP8IBu9wTT8lUSym7caHiuk1BR02aDGwUD7OuZnOUkle8WuuweO2Ydaa66w5N
 yTbm9XmWeVKQZhaQDceXBEnwbMaInAAZ9ydE7Vbne1a4iJZTWbkl3dSr7witbPoqjyXv
 LlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983392; x=1737588192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0j4K60G/+NPzfBz6VwUPX3RpYVnufxaRC/J6EqkjwQ=;
 b=EOe6F6CSI34PZ4NL8+WO2DTlBCjyNQjin2C8bngG4eaCh700KdnbF+TwF6sNOYN8D6
 W/fZ7Pnnm10IZWq75jUbQqFBhvhHHq/XXBj1jaYCSbnaJQ0/xo59zQKVWYmteJFZp8Un
 NKJB1aS2yGEyJqtT2/M3uTG+tsEDYn30wZd1p9hlZwgbsWX1rMbbWAkviX6E32rbJNzA
 QoGDMsnvXaAkaqjKcrG01/MOFx4A4fJTptc8eLyBB1+WvfTpPraUSNniyy6JXSKyDSk6
 7MfQ/EHFWCGt6lNbWCRFYPQwnSfAyAZyhG8ZzhWVYcDuYR5WkQlLPtsbYF1kTYHk/Jqj
 vLgA==
X-Gm-Message-State: AOJu0YzDo2MmYd8BbzT4qedg+CQ3Naec9qZebic8Jx8DRoMSzjOM4PAR
 i9GFuGYQInNurknNY9p3QvdBZvSvQLLCt32XUZMELCaHjhOlswLmT0zKPxzrDuW4Lqp4lQxBuCR
 htyQ=
X-Gm-Gg: ASbGncuF+BPqMfFcdzbq6VydsJFy8mGy/6c9uHfmAVmGK5nu9Qfvtbd7RaOwLcK+wum
 i5YGz/TKxu7qk7dGPIgv2CvBCgJe/l98AlrWNSa0EtCVoM4bSa0R9QWCkdu9M5pl+ineiRywe71
 pvk6v9tO4QmDcI+r+wkcW8Bllylkh6zKIwyBUE3s0WvPKgo/mkr/dMS5l7dvYxw3CsmuE77OJnn
 u9lB6tqP4UW/jX8pgRbIMurAr+fNGG0wP2XxARAKNBSfcFhGIx+mnoURMWbe8zIqh4YszcSR/55
 ElOiKZxO/k6+yaaxB9o6uoasztyvlH4=
X-Google-Smtp-Source: AGHT+IG5m+ucvFC6ezRuwfSJFcIil8xHuKtwE8Itvgp5ddw3WTU47NgNTI23V7VI/jcyvo/67IxqNw==
X-Received: by 2002:a05:600c:4ecd:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-436e269723emr313900205e9.5.1736983392101; 
 Wed, 15 Jan 2025 15:23:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749989asm39785625e9.2.2025.01.15.15.23.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 04/21] hw/i386/pc: Remove pc_compat_2_4[] array
Date: Thu, 16 Jan 2025 00:22:30 +0100
Message-ID: <20250115232247.30364-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The pc_compat_2_4[] array was only used by the pc-q35-2.4
and pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 19 -------------------
 2 files changed, 22 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7fc34bb4a34..31e799061ef 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -298,9 +298,6 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
 
-extern GlobalProperty pc_compat_2_4[];
-extern const size_t pc_compat_2_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bf5308160e4..6d0c9014d63 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -257,25 +257,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 GlobalProperty pc_compat_2_5[] = {};
 const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
 
-GlobalProperty pc_compat_2_4[] = {
-    PC_CPU_MODEL_IDS("2.4.0")
-    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
-    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
-    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
-    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
-    { TYPE_X86_CPU, "check", "off" },
-    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
-    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
-    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
-};
-const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


