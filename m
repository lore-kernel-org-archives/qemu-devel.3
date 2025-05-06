Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07602C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJU7-0000G9-7H; Tue, 06 May 2025 10:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSE-0006q1-QL
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJS8-0001Nx-L7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so32603725e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542362; x=1747147162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rBTFzGlpmN0XM4Xhc9yiz4Q5nlS539l0QvdyVgqZAM=;
 b=b4ykbO+J15g+wh12lFCUrgh0juJ69bLqx7+6K/LtqNRF2pAqIrVK1g/pQ1FeFDGncR
 B6CiJE7uNc5KisVLX4xOWHmsZjM9sw95WO0xWXlhJXk+0MBqg/xPofxnoVc/60NJrJva
 WbnBYOVPPB1f31ojsigAK+ibAbioFpRfk9LWSDNvnhzEtbjVPOWcHak8yg/qZFZfghTE
 5F/qsOdH1YKI9uTnTbg0Tr24AHgeedY83QE4yAdxGVyKVd4AHK5RktOfcnVwKCJxVFzc
 KCuScWS95RUWoXqNOeCftoLXbezSxi0+LyK73Xe3Ujub1m3sQVeBUkGb213t0ZdcnGNd
 AuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542362; x=1747147162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rBTFzGlpmN0XM4Xhc9yiz4Q5nlS539l0QvdyVgqZAM=;
 b=qVN8MCV/df2GZNQte/TC7SvJ4lo6VQE1+k1N5l2jL3hPoYVD77UEAiU/Wwc5FzdU9I
 Kq7Tyg+hx0EyS4S/BtgGKAkXqtU9s/fQggiSPmeNokjd+2o7c1BO4Io8tIB/QQi3lqHP
 wtbhZiu9dyfMeBhQRhBbfLy0lI2mlJ9vWR0cnaXfQ2kLcoddlpJWKsUeiuAJdl4+vaeh
 24+NpYvpweIG373yyR7GG+IAds0wtEufIna0KxPsvr0hA2n9w5PMmq1f93gbG+g38SB1
 UqQ56uGdhNX2fIsN03ik6BTXami24cEeYyc8poz1IUj55a+yDzy+UROGk+UxahZEyTbq
 677w==
X-Gm-Message-State: AOJu0YwlBJcec3aEkiTCOUeFWaDJNaTPbKnRrvyke7E39VKOAhchv+DR
 bdt0ERZXpIkK/E14n0inyUfpVHWYckt5rGKrtoWhCvlSb9p5oZgFhygemJ5pxhKWSPpv7gPGr6M
 f
X-Gm-Gg: ASbGncsJmRFm6nBVflBFU5aBn9AfnGiVv8F7fzU9xjv/6PDqfeIFZCWhgAcMgg/zDFa
 IRHYx+IxDPa9GOJXrEi5XXLX8qX91Ydg5Jc05KUXwwLhRTjqgaNIEOsYZHrQvQv2fCkG2y++mK6
 XT9zG6HUKkcARhvhwKWhZYxuYxfGttMsLZXG9FJ6GXcCiUqbAVE6lbz5ZAlfPIagZuFASDFkeQl
 2eJ4RVfiTTP0DeujXGbJ+ZntZctfEIm9ZSpZ9ZWtfYh1850e6OHgReVNaXwKYBjA3ixqjmt7dY2
 WUjae0xQQ30UvYX45kKatP6Iex10PVDgV9DhH3tuNqhWFfL8SrnBJXG/yUQHhIwJrvXTv+sJI24
 msXF6DT6EO8YLXoDEhext
X-Google-Smtp-Source: AGHT+IE6/y5uBu17rar7px9vRhKXkctL2ZkIdhRKBudoNomYp5AK2/ZDL1DDqx96TjW3VJM2Zv283A==
X-Received: by 2002:a05:600c:3ba2:b0:43b:c5a3:2e1a with SMTP id
 5b1f17b1804b1-441d0fbd2demr34983385e9.2.1746542361997; 
 Tue, 06 May 2025 07:39:21 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae8377sm14138964f8f.59.2025.05.06.07.39.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 03/19] hw/i386/pc: Remove pc_compat_2_4[] array
Date: Tue,  6 May 2025 16:38:49 +0200
Message-ID: <20250506143905.4961-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 19 -------------------
 2 files changed, 22 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f4a874b17fc..b34aa25fdce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
 
-extern GlobalProperty pc_compat_2_4[];
-extern const size_t pc_compat_2_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c8bb4a3ee47..2b46714a5ac 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
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


