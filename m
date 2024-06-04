Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBAC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVdY-0001fJ-JY; Tue, 04 Jun 2024 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdW-0001dD-OC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdS-0005C0-U8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42133f8432aso24168695e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513177; x=1718117977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4bZgUY9V+0kKWae7i+NFy4rFQRdggOPXTna/u1168M=;
 b=Rlee3hIhU0/0oxfqFUgiWy61y/cLgcQONCVPg9Dryx/GtW/wKV1BsD3QpbMv2GE/Ey
 juC8jCvh5PTqYT/8fjOhXfcSrBrjUUDoNLRg06OZADG48YRHP/DQQlpLvyJ+JEUoOzFi
 WjRue7nbVHflDhJsD+MIvpeqwVKnc+aATsHpGnCDiwobgz3y5kxaVyT57ejofqONp2ri
 4SF793YTW9e6RIPuk6QtRJVpbZLDM7F+WTo6YH/HwE2LlbF2xSCv5rT7mjKPlU/EOyqV
 ZcnIMdhWk79Z+1h64KgwEOmGmlbc/UGb/TuW8O/g20t3em+QacMOsg8nOGpSfikUDVlq
 rREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513177; x=1718117977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4bZgUY9V+0kKWae7i+NFy4rFQRdggOPXTna/u1168M=;
 b=kzT8aBAtpBmAKmEE8bhQXAqxnOQt+vHi8SS0glBm2BR67nRlF12pCiSl67cDaf68Ya
 XXkzdCTKBQY0ybuDpKSV6uwaRfY4KwzlHNxO63q1bC/nwBgnIa1k7MgA2HW3UlouDlDD
 44sxHVXZQHLK3j5OB6sfefiYliKA/9lpEJw/pjaHqDQhDuMDZDP/yVN+ldQqgvox/w1x
 O4GMhrqdHd9pWxs/MmFbnRYBzqKLaCAUxA6KRGPcRNV3HUSw5cp2Qqg3QuEj2p3bW6pS
 /cYp7REalBUyClihkKxtwD3LdrVMhZwRlJmklk6TzU32jBnFx5k2sIU8jv4yZEUF4xh2
 pz2Q==
X-Gm-Message-State: AOJu0YzvoyI/oUC4aghFidEzLYoId/V5C/VAqLmU7gxMB4dZAHkEO2Xc
 FEPF+bNdo6upAt1bSmuVnmXNJ/0siYEvtW4LDOhSmqI0inFyLhBFc/P+by9Dp7R+RgrLZvtha5J
 n
X-Google-Smtp-Source: AGHT+IG99QVCExKSz+aNCEWqZDPJhs9fcrm8QQCPoofLvdREIr22QfztX1BZ1zsWYCcV/k4+nxkhTA==
X-Received: by 2002:a05:600c:3d15:b0:41b:f979:e19b with SMTP id
 5b1f17b1804b1-4212e0c1435mr111984605e9.39.1717513177132; 
 Tue, 04 Jun 2024 07:59:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm11767869f8f.101.2024.06.04.07.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:59:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] scripts/coverity-scan/COMPONENTS.md: Fix 'char'
 component
Date: Tue,  4 Jun 2024 15:59:31 +0100
Message-Id: <20240604145934.1230583-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604145934.1230583-1-peter.maydell@linaro.org>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The 'char' component:
 * includes the no-longer-present qemu-char.c, which has been
   long since split into the chardev/ backend code
 * also includes the hw/char devices

Split it into two components:
 * char is the hw/char devices
 * chardev is the chardev backends
with regexes matching our current sources.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 98d4bcd6a50..fb081a59265 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -73,7 +73,10 @@ block
   ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
 
 char
-  ~ .*/qemu(/qemu-char\.c|/include/sysemu/char\.h|(/include)?/hw/char/.*)
+  ~ .*/qemu((/include)?/hw/char/.*)
+
+chardev
+  ~ .*/qemu((/include)?/chardev/.*)
 
 crypto
   ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
-- 
2.34.1


