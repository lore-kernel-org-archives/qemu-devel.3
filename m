Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23823C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk379-0005OK-My; Tue, 12 Mar 2024 10:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36z-0005NF-89
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rk36w-0005Pz-8c
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:28:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41331166961so6692685e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1710253688; x=1710858488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HKnaDlEe60prpVqOOnUpQEQIKkbmlWPjhwDXh5f4Us=;
 b=Wb9z11oVwuwSlKwq5ldVsQWjefRIfBPWJVH9dHK3oDPAnJvKP9VOOFkpp3UdjJKi/1
 ZMiMVnDosDlJQVD6WiuF4J7i4afNQx5g1ujoM4kAbATod7yQbORz8t8ZI4WNzLpSVg9R
 JiCrrxKifYeEWzHi2Rf4bVNRqLKwKrN+Vn8po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253688; x=1710858488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HKnaDlEe60prpVqOOnUpQEQIKkbmlWPjhwDXh5f4Us=;
 b=a/REEEWSO4XdLowfjavV8F4y2aF7gPjv1Er9o0MGUTyFFBDw5WSe4oXk7Mrl0ctLqd
 pGpthZplhFJJdcXgKBiHDeVX8+i2wVh7lxx71GjpxZ/m6VG8U7NLZOtkSCJhXB7btFHl
 mFNdzVhL+h0oS9vzJBP2/zujnz+WU+cCrKF9lBLQOF7lPQEDcNe0P+HOtR5puJlgXnKG
 H2moZlIXCZHkHH3fvOKVA3JtBseMUgJWd2+7ziaTM8bQvYoLAAKR+FDtsF4lnvrXHU8f
 A9WblRgCqFM+Sj+qMf+KykSQn0tCw6Ymi7vXTPaRZUJ3jhiJ6jjp+Q8U9geTl4wV3M43
 Es6g==
X-Gm-Message-State: AOJu0YwJtQPxN/k4IWuS6VwJ8/unkjgjRbyBvOy9zRXnIYMWtQn6mgfu
 X+UhVkturBpnjSuOszWDJC0yD0rjw35IEWq9GaIozwplEq+tiieAJtwRxXstWoweEfVB1K0gWdU
 x
X-Google-Smtp-Source: AGHT+IE75osoSUzpQVWxFnEp79N1bEFbcdqUUk+T0bTtBjE9bDwyEXvCsJAWLfQieFqh+wyQzP3z1w==
X-Received: by 2002:a05:600c:3b8d:b0:413:1f8d:f97f with SMTP id
 n13-20020a05600c3b8d00b004131f8df97fmr6714661wms.29.1710253688564; 
 Tue, 12 Mar 2024 07:28:08 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00412b0e51ef9sm12810270wmq.31.2024.03.12.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:28:08 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PULL 3/3] i386: load kernel on xen using DMA
Date: Tue, 12 Mar 2024 14:27:57 +0000
Message-Id: <20240312142757.34141-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312142757.34141-1-anthony.perard@citrix.com>
References: <20240312142757.34141-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Kernel on Xen is loaded via fw_cfg. Previously it used non-DMA version,
which loaded the kernel (and initramfs) byte by byte. Change this
to DMA, to load in bigger chunks.
This change alone reduces load time of a (big) kernel+initramfs from
~10s down to below 1s.

This change was suggested initially here:
https://lore.kernel.org/xen-devel/20180216204031.000052e9@gmail.com/
Apparently this alone is already enough to get massive speedup.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20210426034709.595432-1-marmarek@invisiblethingslab.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f5ff970acf..4f322e0856 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -718,7 +718,8 @@ void xen_load_linux(PCMachineState *pcms)
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
 
-    fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
+                                &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-- 
Anthony PERARD


