Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7ACA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQp0-0006h9-6O; Tue, 02 Sep 2025 09:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQon-00061w-Ek
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoh-0004he-FR
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ceb9c3d98cso2366672f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818771; x=1757423571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0cgRxzdDVR3zXfTQqZdmJksGVdhvkEH1rphhF5Ksx4=;
 b=IDSb6cnIB4fxQ3lEwYl5ptutAkLQC2FpXINXYsc+1j3gfOCx8v7NDYfx4zF3tbf0Lj
 VRBy+tZF4tc62ag1Uk1zl9a5daGRfCBVx1pmQNXu98tm/lpaD2UaQtwylHqwK1vQWvjn
 W33VZ1EqpZ3yyW7dJGEAwIMgkZsVXXnlpA6UF6X+VqjCyEmOmendrLDrsfgLPNMwSpix
 Qky8CylnDX01ov0ICi0/G6B4/96JRfCIiGW0qKi5dHKO8wSdLdjqCoOVNJIA8zVrEDYX
 9HSaYD0xzHxLThKng8SuURIn0W6ZYnHZ0Op8mIMuCZ2zUSN0ip6a577l4wo4frpr4eRG
 Xerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818771; x=1757423571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0cgRxzdDVR3zXfTQqZdmJksGVdhvkEH1rphhF5Ksx4=;
 b=E9gn9v98qB78yuOLolOcSSsrO4E4+CSjtr21nD5v40m/j2+DO0A92g329neSa9ZS+b
 O/GOTOgy0KGtyxGbi+cV0d4cf5L8mbHQ/meJ/bQydakPbF9jHTbnMX+19usStKNcdfhH
 CgHlkN5eR0GfRw3wteYqXSIQr7FQoUbTg+2BGKUV2uwd+/rHRouNVEdQnAMOUPtJOjWZ
 AnTW1by4IBvc49Kj8WKKvS5rvmcOADCKzarMgDIiMCFN3SM5eckUqSQpznPU6c/SKDiR
 HSmW+GQuMl0FHPQXvOePlTjrxT7NXSzG03L1ymtlgq1uPgSATad3jEs4AdePR/EcUkaz
 JIZg==
X-Gm-Message-State: AOJu0YzCQTo/pqrxztRChbl0gxf9WfrVTpNFvkVkpK21zmCnZUxft5fD
 GdkdvGN2UNWSoHBwsUKlXgvHEpPKLIAgs/coFjATKbU8Fkcl00Lz8yRPpjBAJaPGpuUt8CqF+lH
 jFEZW
X-Gm-Gg: ASbGncvn04Xstj8v2Zd8KdPW6ajXv4v6nm2b04hd/sAURV7G0pj753m6fw4yYjMdS3H
 +FAN/GbU6URVRK1+dtvLJuhJ+L9ALQDhMVKfofrH7ImHToftxQS6V/3uoZ9241LOTDy//xDJzFo
 hoH8jDRZI3A7sDSdu0nQNdkK/aQdiV785Mpc+CXkrY7ReD19VlWsdZDLqNRDb6l5wRgw9sm1lNk
 nvQo2BQ71qPl/D9lcnlqJx9DujcMnqXHdvXtE0K9D12hvGWDilc6DDiqP+xvFAudJz6xYfaiGg3
 27+QgMKEaBNQPfKq8a4Q3K2JTK8EVdDShN35Iqy7e/WT8dRHTQYgZYPr+thaGrUWhWQkNZJcUWg
 YMPiQZugY6q+VuZSvrelonGsuvJ6tw+fKl/PaV8ti3uTJKIHq8keeUUXGhgGZK4Xr1Mh6cmI/0X
 wyOMvdls660lJ9dBG/rg==
X-Google-Smtp-Source: AGHT+IGjSqVpRr9cgIrdKLG1o60VgwbQir5TgdJSFZnZdDPragq9wy5UxSBZhHjrvIv4dQh+N/Iqgg==
X-Received: by 2002:a05:6000:24c3:b0:3ca:8031:4b38 with SMTP id
 ffacd0b85a97d-3d1d99cbafcmr8816551f8f.0.1756818770547; 
 Tue, 02 Sep 2025 06:12:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc3fasm19387060f8f.5.2025.09.02.06.12.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/39] hw/arm/virt: Include 'system/system.h'
Date: Tue,  2 Sep 2025 15:10:10 +0200
Message-ID: <20250902131016.84968-34-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Cédric Le Goater <clg@redhat.com>

hw/arm/virt.c should include 'system/system.h' for :

  serial_hd()
  qemu_add_machine_init_done_notifier()

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250731144019.1403591-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250901064631.530723-2-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1e63f40fbec..e5c4142e822 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -50,6 +50,7 @@
 #include "system/kvm.h"
 #include "system/hvf.h"
 #include "system/qtest.h"
+#include "system/system.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-- 
2.51.0


