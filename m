Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EFCCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOH6-0007xB-Mz; Tue, 19 May 2026 13:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOH4-0007wW-CP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOH2-0003ex-Ny
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso39356425e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211831; x=1779816631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmDzBexxRfZjdXehCa61o3ozeGzuRkBiMBbnJs72aFk=;
 b=M7zR0JTEIxMOsbmcOgJYDYW3MvLPLoFm0x9uLRdSJ5IthniKtvD9GfZnbBbtPCSI/6
 HWUwnNPy/fp1q9Wu8NktjW01inP9zNQYCjUC83z/Wv3FSStUgORdP9wY+qWbCrE2pr+n
 R1bhbA4CCvTgTZesaA9+q0dJtyr0CTodBVnCM1KmtYzP08X4A28rwKjoCI18u60NFNpz
 mvZRe7dvCzvySjAjD9X4IQpMCwW+E9YzFS2SErdbcXvMpoJ3H/7pk2U+Lxk0ufH34hQB
 Y8xfXyCnBWmJj2YQYmtMhGQelI8T9Ig35VmR+9F94xUKnosPxWmGstQfvYMLxBCzMXL5
 ushQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211831; x=1779816631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XmDzBexxRfZjdXehCa61o3ozeGzuRkBiMBbnJs72aFk=;
 b=MAJ3YU2wliLKLL7AzuYxvzdYGC0yonbOAwstQNcWu0Cz+s8vz4zNt7zxtjffug1K/s
 kppqj6Lt1bDZmZiDXSIKp/TDf1oQslhcmGnAnqHeW7odeaAWiHCkXS4ypADe4BHqZmBF
 cdxl69ojrU3WPMPHt/Wp1VlyTCF5WcdfbaCwzDviQm/+Sr2cBNqLuUeQV+an4zrOF/OH
 gFKS4p0Bil+j2PaCcOC2giaqxN8dT9t5mbyL0xqdWHy/ZTX8lAzstG0EQy8XHRzpYwyP
 rT8GI27SJqDTfOTPDzIblChp7DjIWO2vzc208WHTsMlA5OZrNcZ5DIyL0mEbSjmrSq5G
 j+9w==
X-Gm-Message-State: AOJu0YxRtKjmXP6/ldDkCyDNhaU9X7aMhUBk3deESIMJgF9V08Kfdte2
 lPsWSizl7qygcPculfT6yabbDgI4OW1CbdWFx8I59J6O9sBb4PkZWC1vaMyRdJMYdqrAzDVCAOC
 rY2n3tEg=
X-Gm-Gg: Acq92OGSV+UG52k8nMJTFGx2ETwJzDW4e+0htBaXanWPTvKipmgpOPzwjsAEVE091GC
 e5zh+/ZPNuvh7m3u1pjVlO/g2nHAAvKA2B14hxTpZec1Pz3bR4g1ZKgPDZP3dPFmoYqDCQhg88F
 7Gr52uGKKgWjvl6KGYrU3gNmuATS4jMQGwGExVijC4kYNgv2XmVwENnLM3ejxYvLov+a41zD8aB
 bXHBXh4BPsK4z2fFK9eR+/8iURDKllvXbidwGFqGdTE6Whatm0LixE2KKhH+SI1pRExebOL9bFV
 jfB0kuEEjXUW55mUcz1xDUz8cYwEeem9L7lMZl/TkL2qxjauOVQmS56RQuHGgmNMCbx8T7k1SNl
 XaAAhttrHmbhUMVcrSeMWnSzBo66IuIaFJ2r9M7YuyoJbHV45VQSzla3ip8CBmdJ2BzVNDWkgsu
 asD2quw89baJ262khGhYBpd/rAGXzCZemkMqUBd86PE3CpCrhGSDBRS+7Q4K0RKUre1D3J1P9w
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-48fe53a8eccmr313189915e9.16.1779211830483; 
 Tue, 19 May 2026 10:30:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab6aasm365812085e9.2.2026.05.19.10.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/2] MAINTAINERS: Remove PhilMD from firmware sections
Date: Tue, 19 May 2026 19:30:14 +0200
Message-ID: <20260519173014.98967-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519173014.98967-1-philmd@linaro.org>
References: <20260519173014.98967-1-philmd@linaro.org>
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

I'm not paid to support this code. I haven't followed
it neither, so be fair and just remove myself.
Demote the status to 'Orphaned'.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ba6391dea6..6b1d004c054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2875,9 +2875,8 @@ F: hw/usb/vt82c686-uhci-pci.c
 F: include/hw/isa/vt82c686.h
 
 Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
+S: Orphaned
 F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
@@ -4010,7 +4009,6 @@ S: Odd fixes
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: hw/i386/*ovmf*
-- 
2.53.0


