Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 12:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFAJT-0000v4-Ne; Sat, 01 Nov 2025 08:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFAJI-0000t0-Jr
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:02:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFAJF-00051J-7q
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:02:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475e01db75aso19283385e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761998535; x=1762603335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khfVYY1UJRANfTe3uSdDUlTmZ2chbclm/a9R8cDFm5Y=;
 b=J4nGF3yumZ+t7PBZuZ9UsmvJO/meguY0FnYyS//FC6S7mtkaNgIas9TwMl9gCEYaex
 8D7GnkNl26XRL+c/RNQYqKLEW8RdGH5iWrbvqh1bQvFnfrO2VRip6mM3NaemlrvPIrdl
 oH1ZkPYsTZk07yx8GaOz3pdrocQIvTIA1Sr6VZTimNLRMrIW2W+40BDo0fLb3EUPnWRY
 /WMhcdXi+TrSyTLyTkFTLtyDekK6NsahjlvaI6XKE8EKeuK/h0Vb4hwEabORtJ9Xl+Iy
 ev8Pm1HD5zQnTNBb9u21JkQcQYBMEgQ+Jndv7t4mCJFnLdTUJTaEWsekZph0Dtc2DyjY
 e/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761998535; x=1762603335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khfVYY1UJRANfTe3uSdDUlTmZ2chbclm/a9R8cDFm5Y=;
 b=JYgfkMYe93R7ve668BF/wKFtRUbenwx2mkVt5N4Jwlc8LCG+BVzt3ZU7mc9WPqv4RQ
 xQriJV+vvrW+7UP9ukHu44jWHAdsWweySNBc74f8aQcL94qPhng8qWdLlgyylaWLSiiL
 mz1T4TzmurPrcbUpf1GE5aeuOa9co/y3M/B+6blxj2m3tsBi1xtT0BxProqgsRbIE+KP
 btHAHTTKxBO3lfZNSbNUd0WB5Qo5uek/S23BuBWf3GW01pL7coahGaJNNgwXbDDGoaPR
 1I4tKo3+vrHetRvv1ztZFfYV5ofHWQ2UUEj36Wjk8n4pTNnh2/qUhTQOvlz8dKopOjQr
 0Mvw==
X-Gm-Message-State: AOJu0YwjmKQXls6fv+50TZk6Uuu30cICufjQGhio+xznnXmfMxT24MGD
 tLW7mdWfcytTr6U72ZXwlMr6WYkUUwlZASsVeXakvYmi4GeP159m98Xj0hvoVQ==
X-Gm-Gg: ASbGncvhkP1m2mX9fGPJTYUgo91jKoXi75I+DK2lh2+qREs+2H/NTLi2N2F7bFuE3/e
 gIRTHJiJ2YEyYY7cNeQbGSffEmfk+Wdi+9/E7sBQp6rfis025RYm4aNduv8FotGj++EKgGxMF4e
 kbmZ/5Hl/vchXKXL62Dt8tn8t4MBPYlkR2Fpx8Fp+WSG8oYfAXhWAvtGUW3CvSIMp/yqziU3FK5
 NEqtDJjP5/86uNUS8duhqsaqjJZ/7ZcolkHQMeBaUniOMBxDrFomIzFGyNK/XXiq5hg8RAA7JiH
 LMSETfNCNT5RHVZ4QfgH2j/oL8cIe/It3/iCQormqo2fxHdDKSj39wDy4sxjJEzmbb2kbEo/2jv
 /3T4q6LVOAk6GyDLkzX6TjTuu+lGJ3YYf+q4Uc1tqjgfApcE/7/+U5tQpNNwX0w10fCA+P6h97Y
 duYL9tR5A1ZuX8sUgQ+q3lOfkH9YEWoVav5cm4gYu1nbmPWgz+z64Zzw==
X-Google-Smtp-Source: AGHT+IGbfE+9R23E1GbgdTQciHz1+9Wfy8YL4qUH4+qCo4L8kmVaAp4pyxBfdhqvkVhUkvZOL7c5/A==
X-Received: by 2002:a05:600c:8b6b:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-477307c1fc6mr76940705e9.8.1761998534564; 
 Sat, 01 Nov 2025 05:02:14 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772ff83182sm40734215e9.4.2025.11.01.05.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 05:02:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] hw/arm/imx8mp-evk: Fix guest time in KVM mode
Date: Sat,  1 Nov 2025 13:01:30 +0100
Message-ID: <20251101120130.236721-3-shentey@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101120130.236721-1-shentey@gmail.com>
References: <20251101120130.236721-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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

The imx8mp DTB hardcodes the clock frequency of the system counter to 8MHz.
In KVM mode, the host CPU is used whose system counter runs at a different
frequency, resulting in the guest clock running slower or faster. Fix this
by not hardcoding the clock frequency which makes the Linux driver read
the real clock frequency from the register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mp-evk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3ddcf1af5a..44e0601967 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -44,6 +44,15 @@ static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
         fdt_nop_property(fdt, offset, "cpu-idle-states");
         offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
     }
+
+    if (kvm_enabled()) {
+        /* Use system counter frequency from host CPU to fix time in guest */
+        offset = fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-timer");
+        while (offset >= 0) {
+            fdt_nop_property(fdt, offset, "clock-frequency");
+            offset = fdt_node_offset_by_compatible(fdt, offset, "arm,armv8-timer");
+        }
+    }
 }
 
 static void imx8mp_evk_init(MachineState *machine)
-- 
2.51.2


