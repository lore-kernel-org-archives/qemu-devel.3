Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7444ECA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQpO-0007Q2-61; Tue, 02 Sep 2025 09:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQp5-0006x7-Km
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoy-0004jq-Gz
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b7d485173so33677295e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818784; x=1757423584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NGqxHDZXqk8C+oMKaLUoVk4ghBJAywHOZPex4RT6YEI=;
 b=QEpcjAxst5cIS5OCN+0FbJdpTmlJjOk7VJryCxkbJgR0SkDxWc+aFM4YQhIXEW4i+X
 IGKUJbe5gQavQ5vNSG89siQFPWfj89oc5kfsW5V6jeinNY471XypH2HeHoRJzWKMDWo3
 jBD5ScmFiKHECe77fvOcDAcgkBZSUyHE2dKuJ084ncS/vETzIn93xXUhrKJeVUsGUdo/
 yaDo3p9UEXUmQD7dN0fc03D27wz1foOO/Hweo1PQRRy2F/XzuiP0FgQUi6UaJgO6XOKF
 Xr6Ny0m4Jsd7UgP0xoDAl94iTW3VSwijIx16tiVT21/uLbXfLTgVDmqxBHsXK6tjQ/gb
 lM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818784; x=1757423584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGqxHDZXqk8C+oMKaLUoVk4ghBJAywHOZPex4RT6YEI=;
 b=NxrlZ20kCZd0PEQnmK3yDcz/UFj1inVk3Xd227/UYjlXYujCp+F5wU+F8giNUVOxun
 zcdOY78heRdOEgQd+eZ8c26NOZmZAQ3VF8pbPi8PckodHatWvt7ejU+S9DVyeat94tSA
 zZ7G6OSblt/0osmAr3yorhXgg+romh2CBQEwKc+ug9N2axu2zp0LhI5edLe7VS9ubWKe
 YPR7AqusCDxUsij9aVduURCui324wc9/nj3X4O16CgRqOlEC3gA39jSN4dUkUa5gwBQr
 M3o5jF0ZuSMPneOCUTAbVOYXQvCxe5QGKvutnA1BtoHhFZNbf/LhFs/XNnAzTfRXKMrS
 uCkQ==
X-Gm-Message-State: AOJu0Yz+KB9wm04USqbNQIaCD/aUSxs1yj271bPx7D4Xdl4DV7IRMgrO
 QbqVMIEpczfOUFWD7NPAiFu/UNApe4sDw10LeyP34AMaCLwkv4KDb48ztqrnwo7qt2j2XPSAGZu
 oMVuV
X-Gm-Gg: ASbGnctptE3LpaBu9NjcltSxc39fXv8lTRc7tCxN14y1mtlcGaPRwNWgUQ0yso9bnah
 976JdKp5VSlre93voA/QLuEI8rieCyYEl90rCJXVX1VcuUW3AE4IJv9/91Z/QJLZ9JUEun6CjJu
 9Wj6U4inCzZuTid/xHctC10avVz4cFDAjBtDgf0jA1RyjTA6bxdtQiTcpqZM0lf49hNc861bsdN
 MjI3SDDtijGk8UuYr/DTxCJJRLnj6pvEcRl/gJNeb2tNhva8pHSLS0k0u/jWafg1Y+1uaYrhlTy
 mx7d57Y/JjGlRiaey8OsSoYwE+Eo0NsnU/jiuscghQ6qm2EnWGfesFjYkechsFvYcdluDeSQmjn
 o/EnvQA0AELuiyroe3Xny2Y0nCjLXzQUc57YSOm2zHCxBL6bZa3Q/Fvw95n1TlsntVM50VbZD
X-Google-Smtp-Source: AGHT+IFhs4prCBDZxeoCadH1HaPY0Cfw/VTV2zYfVHZ2g2jqdJJDu8Q0Q0DRRW1fhU2K7Va2cDAojA==
X-Received: by 2002:a05:600c:474f:b0:459:ea5d:418b with SMTP id
 5b1f17b1804b1-45b85532b10mr94140325e9.9.1756818784349; 
 Tue, 02 Sep 2025 06:13:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab14esm214282885e9.21.2025.09.02.06.13.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:13:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/39] hw/mips/malta: Include 'system/system.h'
Date: Tue,  2 Sep 2025 15:10:13 +0200
Message-ID: <20250902131016.84968-37-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@redhat.com>

Files using serial_hd() should include 'system/system.h'. Fix that.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901064631.530723-5-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index cbdbb210568..344dc8ca766 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -52,6 +52,7 @@
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
+#include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
-- 
2.51.0


