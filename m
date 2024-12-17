Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC40E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZGA-0008Qz-JX; Tue, 17 Dec 2024 10:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZG8-0008Qm-FZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZG7-0003IK-0T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso39462715e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448393; x=1735053193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FH/72suxrUOMAatoct7CthEOn0DQXdaIvd71YSiEkl8=;
 b=tOUh0tvDfBwFyXvMU7h1LcQCdmlTdYPjbqvjEK2hmCxo8gJK9qr277z5mhfVe3NdNI
 AJRo8nya5uf62NBWh1y/1LtcCmqRUz9i+jMXQttSxivQrlfgQJThln2W0Fpte2jYd/KS
 4ky9JBqQvKSbT9Hr/QQ3lMEAnNvtmvfsavuB8LTQ0LdaDfNXLvBdhsBGkMricJGRIk3m
 weLISN2i6B310dxMijC5xWMRgmMxZ2EzbCzK8MMSyWKgu5s3gTDgyUCAMDSICkq3l7P0
 TuAvgOd5Ubv1UIC8IjRvKsHdl7b4es3jGA+JbX8rZ1oJVUTJPIaKAT31o+uRYD2hZFdt
 5W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448393; x=1735053193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FH/72suxrUOMAatoct7CthEOn0DQXdaIvd71YSiEkl8=;
 b=HlolW0h4u3JIZQ1y7j+f/mxgB0UeVX7QnocrcsXNLcZdCc6ao+Edt1FVy4cJAbJKeF
 jMWQGJ0uxhPwu4LBJKH655/s2XgtuLFzRzOuzEvML/s8HMxmnmqj1nZ0Uzo4vOe9bJMn
 v37AyR573YJqKnUW4iaa0pfIshTd5fPwD/ZrsomZk7JLrw6CVwUf8KKFJOFQKMYEW73z
 VQDpXn3refmgk72wdYGjOFpFpR14XnmKpIS6BE3aBGsn1SSpt4W8n1ucppzPlnYEhp4V
 W9G4UTAGyxOGBbtSgaw85Ub/1gLT+Kz2d2I++c4AfhPk4iZafgot8Dy62LqI3YlTibAD
 nJFQ==
X-Gm-Message-State: AOJu0Ywk7GbL5tQ0WUzVwUsZocgSbHyO0J7I2jIuVeq1Ri3lKA+k8wKq
 hhOhkqiQvgfMeLls3kw7xJv6PGNuGYjqze5c8zkDv0Z+bHB/t0TDSi3aGH5z3SW8CDXWdec7GAh
 X
X-Gm-Gg: ASbGnctha2s+SYfM/VecTwpjBUP7aP3iQeo54AG4H2O6GIzUKm+GBpmgoREVqQ7NVnZ
 vwgj+5HUtmQHOXs4CZxb1bMzKuACTe+yqAiUk1CFI9U63hGQ+/C+eaUt1Blub3AVz9qFNYS/k1G
 7FgiTCdknPqmEIfN3xLaoeAfmgQG9FpJ0uzs1RA+tF5avMuR9dxTF+HunImWuOB+lgJSL11HdUq
 b9pFMERO7vzIMrZ4PniPmlSF0aoK1JApqMyalyQogtSrXCXMcDWB63Kj+fke729vxSgqfVhF8Gx
 gYsl
X-Google-Smtp-Source: AGHT+IE3RmiEs/P0yDnumj2ykAGCoV0c6wATPDpTgTGtoE5l2Mfa/4IktujX2VH2nZS0c49GlFQyYw==
X-Received: by 2002:a05:6000:4715:b0:385:e1e5:fff3 with SMTP id
 ffacd0b85a97d-388da5b7cc2mr3362824f8f.57.1734448392938; 
 Tue, 17 Dec 2024 07:13:12 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm11384835f8f.37.2024.12.17.07.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 07:13:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/3] hw/xen: Remove unnecessary 'exec/cpu-common.h' header
Date: Tue, 17 Dec 2024 16:13:03 +0100
Message-ID: <20241217151305.29196-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217151305.29196-1-philmd@linaro.org>
References: <20241217151305.29196-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Nothing requires definitions from "exec/cpu-common.h",
do not include this header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index ecb89ecfc14..e94c6e5a318 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -24,8 +24,6 @@
 #define __XEN_INTERFACE_VERSION__ 0x00040e00
 #endif
 
-#include "exec/cpu-common.h"
-
 /* xen-machine.c */
 enum xen_mode {
     XEN_DISABLED = 0, /* xen support disabled (default) */
-- 
2.45.2


