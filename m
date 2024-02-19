Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC6C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Ps-0003bd-34; Mon, 19 Feb 2024 09:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pq-0003YP-8C
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:42 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Po-0008SL-Ti
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:42 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5649eb3ab68so828635a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708352079; x=1708956879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19+qnM30bgsd9CC9/msvt9m3ig3W+6Jc4ToSCcgfANA=;
 b=tN9mSXOxKqMxGPk9JDbRT4NSQdDLxtE0kcF4IsJM8iiek+ieWDY7J+VqmlrH4SJuEO
 Er+TDVuil7/daLrc4wUvD/IkTESLBkfTOTYQlYLCjgYAeGBsDMuEd+CXxPeGVBPgWyCD
 9Osxd7yiV+p4l3hsY4PgzuR9eRdc2v9Akf5+74o+xlkoLoIJIsL0k5cWcK5LNmQ8xbXJ
 FshnemYOpUpH4U9hi35GTHGBPoN1lLcWdZq5MdgeWXC1DK1tdXchs3vxbMXX8NyKH5NT
 9fwqraJw23H6VOpVV8h8ln7A6SMo7s+0y4npnlFzv8XcXBqVamAU/IgGPycIVsXrcFgC
 pLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708352079; x=1708956879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19+qnM30bgsd9CC9/msvt9m3ig3W+6Jc4ToSCcgfANA=;
 b=sf0Auo0Z5tgBA73NLw3Yg0zQf7i1qcC0URRH5e/nNGhUPSiMDciCDz7K+OkGSfdtOY
 oIs+c+QTq+6F5CB0IijsnfJ9+8cyt7wWw3d0CdeLUHcs7NwNgYN1RnVP9eBHpPdui41e
 CXPWgj7ZYDnzpeQ1Cd2RxASiVQya9L5algYz5DgaerLw+K8GzQWbO0bYXAhyjP18roxR
 Z8oMXFQGIGpNjqg/4WteMzuySAMbfcrrtwSlmKbjlEalzuQXMusOor9a0e25iLPtJC5k
 c9523l8eJQKeVSffUMeypOehg9jHDiKodQy+doirKgNwy++jW7Ot8Y3hflPnfiWPm30z
 ka6g==
X-Gm-Message-State: AOJu0Yz460xt2+25m9c3jK1GmPqnChLgHT9Y8NpGMNJJrOpkdKJMIlpE
 UalRCRrM1bswxA0S4GSMRXFT5B21n4DyEaGvNfvkv1hAAB6kH9c7LfjmPrH3farPmbslqVP10BY
 0
X-Google-Smtp-Source: AGHT+IEfAIpgWYiwqp/BrdqT2nlroolynPNqtlPRvFLUOim9tluhVSl8y4FFAeCiTHVTv+jbLdfvVQ==
X-Received: by 2002:a17:906:f8d6:b0:a3e:998a:14b with SMTP id
 lh22-20020a170906f8d600b00a3e998a014bmr1766628ejb.47.1708352079412; 
 Mon, 19 Feb 2024 06:14:39 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 vx10-20020a170907a78a00b00a3edb758561sm144542ejc.129.2024.02.19.06.14.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 06:14:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/acpi/ich9_tco: Include missing 'migration/vmstate.h'
 header
Date: Mon, 19 Feb 2024 15:14:10 +0100
Message-ID: <20240219141412.71418-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219141412.71418-1-philmd@linaro.org>
References: <20240219141412.71418-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We need the VMStateDescription structure definition from
"migration/vmstate.h" in order to declare vmstate_tco_io_sts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index c4393caee0..2562a7cf39 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -11,6 +11,7 @@
 #define HW_ACPI_TCO_H
 
 #include "exec/memory.h"
+#include "migration/vmstate.h"
 
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every tick */
 #define TCO_TICK_NSEC 600000000LL
-- 
2.41.0


