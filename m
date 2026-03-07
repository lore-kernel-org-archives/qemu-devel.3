Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49280F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytZ5-0005iX-GX; Sat, 07 Mar 2026 10:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZ2-0005hA-R9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZ1-00087Q-Ab
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso85676725e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897253; x=1773502053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwCDSeqcjlqyyEF5HiUPsBSLXDo8uF7LDI+JShU3BAk=;
 b=BNoY0WyXM0sjO26Z35GbTNQjU89zVMmAraPSgGFoIQBkYsHH/dQe71vz7hbNgqSF/P
 MXELsxjx25mmVpCDhOjpAWLtOZdEDvslMby8f+4J1Lq/Ne59b8nrZxM7r/rDK5J8P48X
 ta3IiUzU1aEAv7fBje4dvOB7U8Oe4yHZtxV/mN92R69DcNGePLrwWT1o4uHUf9d/PV61
 CL41wSfAFlw6Ndz7cjdrIMEPcDA6u4HTl+a4j+vz2HGf2jH15x3c7OhBLi2FJlwbsUbc
 XuZCfXTR3t1FExd1bJskF8v/sPqem8jAg6FYLwBfE72Vq1yEKZuZvTzWgOM2nz4BNO30
 E0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897253; x=1773502053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dwCDSeqcjlqyyEF5HiUPsBSLXDo8uF7LDI+JShU3BAk=;
 b=EZW2tA9m/q1ysMGOJmRBtkwCVVFJPcXfWjJAh+XNnAC2ZDnScPQ1yK6wPOeJbaOmhI
 nbbmRf7qyVl6NnPUhPqJ0sXxVCDtIrOJJ4mIzL2nwpxKW6pakH73brGHjlF/4XnyegJ7
 fZ6/9NvHncCksVyBtK1EKc97Lno2VFvyCvzq81dSWQO8/9vucNuZl7uAQBm3JGPKWdkp
 yVo2fua3e5uU8b2f03dd4J86EqBKL6fmYX77TZnbB+XKLCA4S9He+BCYAf6bK/qbU1Ix
 CmZYbKgjDlT+WBYYMQzH2+kGUPbtz8lG9dhjz2XEqcWm16TQy9tdAo5mf9KQRstAvD3+
 n8AA==
X-Gm-Message-State: AOJu0Yz9sbGx/D+49nWOh+A9dhLDlhOde/pGN8s71/MWidvVUDno4THZ
 Jc7OShqWUhrXaGIcsS8VpNKej7pbseKWBhAijEVDGL8SeVl0aF+Cgl3qIA9yO2c6bLgif+8Nlrj
 vSLOgSN8=
X-Gm-Gg: ATEYQzwG5IlOh0UKoTfI0RPc+1jgPvoqLjdD2vziSUMUFBc1bujrNC50Bu5WvHS8lio
 hHNcOAXyNwY+93oXZQfEIEz8+EU6h2EQv34eUfLCX3qhxvQqqmvEURkrZyBcuRI57Jo0TvwCZTa
 j0RT+Dm6t0qp/89TUrpONdh+x2fXs9++pY/83n0ml49dvjtGFqXoQfphcvZYNqC3V6RTBAuojBo
 Y1NNhglDG5tGmcoTiclV+a9o/OZtJYREo7hfsKc1AdrCDkGJwGtZbTM1TYWvgbp/yXR/ANV5k9T
 yaYnopAmSJUYwuwb5+mkNWGlKl43mfhSAyK23mAwvcIyNiaXPQxZxKVf/NGPeIC9N6Mfj5w/Grl
 fYKoKNrz7FLkCZOrwF4ZkMZGd/b3+fB6nrJTDSZ3EnG4YKShj5WV8sEROgQ0ZON5H/gS9sABBba
 glfghfN0+HrTVMMQYfPriVPyO7ZUs4lN8uQIic0KD9x/3ob02E7NcncuXopz7ISUqECPW+oVYI
X-Received: by 2002:a05:600c:198f:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-485268b8dbemr96810295e9.0.1772897253410; 
 Sat, 07 Mar 2026 07:27:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470a654sm41107915e9.29.2026.03.07.07.27.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 08/10] hw/core/machine: Remove the hw_compat_3_1[] array
Date: Sat,  7 Mar 2026 16:26:32 +0100
Message-ID: <20260307152635.83893-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The hw_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h |  3 ---
 hw/core/machine.c        | 17 -----------------
 2 files changed, 20 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index e15dbcea83b..9155e0cc9ed 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -867,7 +867,4 @@ extern const size_t hw_compat_4_1_len;
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
-extern GlobalProperty hw_compat_3_1[];
-extern const size_t hw_compat_3_1_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 162600425b0..9a3d826c3cb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -221,23 +221,6 @@ GlobalProperty hw_compat_4_0[] = {
 };
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
-GlobalProperty hw_compat_3_1[] = {
-    { "pcie-root-port", "x-speed", "2_5" },
-    { "pcie-root-port", "x-width", "1" },
-    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "tpm-crb", "ppi", "false" },
-    { "tpm-tis", "ppi", "false" },
-    { "usb-kbd", "serial", "42" },
-    { "usb-mouse", "serial", "42" },
-    { "usb-tablet", "serial", "42" },
-    { "virtio-blk-device", "discard", "false" },
-    { "virtio-blk-device", "write-zeroes", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
-    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
-};
-const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.52.0


