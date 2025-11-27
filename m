Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E250FD116F5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqb-0002cN-1V; Thu, 27 Nov 2025 08:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqY-0002ae-Dk
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqV-0001E4-QQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfCaKxiAJjTwjj8O2cRflu7YluljfcNTILF8gXRcDSo=;
 b=Ah37P3jlYaBYUymE56Z8ze0i2eSGuMBWboJ0QfWMbnSUgUT1HklObIaRbuzXe0OKM18WeW
 XxGTdZj/9tDAzERGYZW9dTekT/JKSaQR5ZJ4zkYDlDtaZ/sGey/O81hjiEcR4EjD2oA+J1
 jAJE4xY13nggCTnDDhHjwbz9VBlulxo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Pt1HpvY6Opi8o0cVONRE9w-1; Thu, 27 Nov 2025 08:15:38 -0500
X-MC-Unique: Pt1HpvY6Opi8o0cVONRE9w-1
X-Mimecast-MFC-AGG-ID: Pt1HpvY6Opi8o0cVONRE9w_1764249337
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6430b32e97dso797561a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249336; x=1764854136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RfCaKxiAJjTwjj8O2cRflu7YluljfcNTILF8gXRcDSo=;
 b=bp5BBe/KQ3Dm08J5acKGLknb2T8fOoeolktEB5YPVMWmr/FQ1hEGN0M1c8Uc6uUPsa
 RfytuvgwZKCpe6k3KEJlfQXGFD73oji0bPON5rmofm0p7/b+BOmfYwI93zgrtp0gkVVf
 J3fuOJQc7WmSX8s8gtE+zVWyM40mYcKvsg5Tjgjq4P2phqTKEDoUeELNaPET68OtUU8X
 fFmt5c5UFv5ezku3yA9UF44xSXq8u4LU6GA83kK7vhvK5eBRRO8DdASe7gN3zhPL4+Uz
 YatC/LpzXq+E5qScAm5cvhASm0QGnp1nVBcUI12gPnvQIWn1XhWsp9KDIRqdAdrmKn8v
 OjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249336; x=1764854136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RfCaKxiAJjTwjj8O2cRflu7YluljfcNTILF8gXRcDSo=;
 b=ZKtlQlRgXT6qYzEKKakiGToRw/668KSo2K34wvLk2iK1pQZaHn56xcWtJNxtWFDWG7
 B8MOQy/BtmCoLV3PDtLUc4J4up1PPHtLinN91NaiF7BSKuTaNjWl2FRPfIOv7oQBxFSp
 MV6xODDb4+c+nTFm9mZ6UyryjbZwFa+u7kPrNodxVtdXny/lBE+Hi3hhzp78hiFIOaNg
 EwsQaEl4QuDGtxQlOrX7yoTnWs3kHjMcN71OMpl+DScLqZ5+GrC8S3tq2ARQuxNYYoTp
 ZfZUb8OLKTEoN5ZXhV5kYloKvhiwLlGUt/Zx2nVcRmJepB5b9h73oJHR2crnBBuEaoOF
 r1fw==
X-Gm-Message-State: AOJu0Yz2aVWcUYLyRIB0t6OYqeVv4tXTdE4Gy7WGwc7gAZovxEsWzDQF
 itYPuksvujxkVNKt7wE/snIDxzFye2g3abEkxc8370lk13vhzj55xO84uMEM7UzAWWSZEiVWhWG
 vEQ1I9Kf9HVC8HaPOmTSqxt5qr+EIftmjRoTXceICNctaJG4h0HYWdpJvkC6oE+bjjifaHuSqUF
 Zi93ahlJ7TQRhEj/2YpFFJA7dpHM9pRqNsOmAcVj4i
X-Gm-Gg: ASbGnct8N8vGrg5nw15RXdM91g097XMIFw/04RYfq2eccz+BJMExU7xtlmJEdj3xG5s
 q00hTYiZ9ufyDUUqhWij7PSJULfraUESIg8Dnse+wNa+jL7p2E6VOehw6cx+Vq3J4slreJ8sGPq
 LBvF3W8GLaMMexxMj1HyOcG0faGi+UbWNr4r6djBp3qHmmfDBgTHAyIb8/171GEF0s+BXL0H/QO
 8VhvWiQg9ji9fQOEFIYhSapgF7NxklwT6Y6R4dl0SYJ1r2BQYSTe+mpq8zhZ2Lh72djU/4dew/7
 vgBS8GezADRxz3HvKe1G2dW80hrlalkDMNyWdS1P472mMNvCObBqe5G5y1s4GWO1QuDlcAURXeL
 CbSrTu3KCoA8xdPx5xHAs+J35yVzC8pJaP3jKfgIYvDGcfjkgh/R3lUZeGI8Mt9aNfUFBBRQTNf
 trZsD1mlY8LULX46k=
X-Received: by 2002:a05:6402:2816:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64555cd8cc4mr21641194a12.17.1764249336408; 
 Thu, 27 Nov 2025 05:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH319EwxRY3m725ZALLFOJRgIWbRs0XdR3xy5nWkxKLzdg5JPmGmMm/P53ogZn1NVspW4pHoQ==
X-Received: by 2002:a05:6402:2816:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64555cd8cc4mr21641166a12.17.1764249336019; 
 Thu, 27 Nov 2025 05:15:36 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751062081sm1507217a12.34.2025.11.27.05.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/28] include: move hw/loader-fit.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:57 +0100
Message-ID: <20251127131516.80807-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{ => core}/loader-fit.h | 0
 hw/core/loader-fit.c               | 2 +-
 hw/mips/boston.c                   | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/hw/{ => core}/loader-fit.h (100%)

diff --git a/include/hw/loader-fit.h b/include/hw/core/loader-fit.h
similarity index 100%
rename from include/hw/loader-fit.h
rename to include/hw/core/loader-fit.h
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 2dea485ae06..59a625ea57d 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -22,7 +22,7 @@
 #include "qemu/units.h"
 #include "system/memory.h"
 #include "hw/loader.h"
-#include "hw/loader-fit.h"
+#include "hw/core/loader-fit.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index dc9da0b0401..633b2a90523 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -26,7 +26,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/loader.h"
-#include "hw/loader-fit.h"
+#include "hw/core/loader-fit.h"
 #include "hw/mips/bootloader.h"
 #include "hw/mips/cps.h"
 #include "hw/pci-host/xilinx-pcie.h"
-- 
2.51.1


