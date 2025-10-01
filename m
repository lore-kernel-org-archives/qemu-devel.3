Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E33CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v413O-00025Y-1d; Wed, 01 Oct 2025 13:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413L-00022s-BO
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412w-00010V-Vx
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso611505e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341313; x=1759946113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9ekZYHpJDRZOlVJcikM1vyUhcFtsxbY7lhISL3cLWE=;
 b=dJJML1PW3Y3ZTdRusXP/F+uyUiR42C0GyHxkaHT337X5oWcokPJ5YhIAMiJonTDu1X
 d/HyyaUGIU6NWSN+k2bEm9Bekor1/ThpiASORMoby5LbcJz0IrIISXkBdezrvMqMboNc
 BhdM7+hcp4gHFl16GwDbzUfw0a2h/Fhd5d4VKLDTHgnrDNAccioLztnPwzZnEkKDUzVq
 Q2cudp5hw3QA+UWxhjhlzx3Thypt9WPM9cbSVjdrOKUVpP+vKtHC+VGDUtW5h0TOfG3u
 GETutvvieI408XS7xiIuLzftQfBNu+xB5SV3VmHey+Ja8n4gbrvJkqa6G0GgIekjJVYY
 2WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341313; x=1759946113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9ekZYHpJDRZOlVJcikM1vyUhcFtsxbY7lhISL3cLWE=;
 b=BxQB37jLXfeKEN8iOhzbR5yOTzqXq4cZ/Cw8uEfPn6IFGggehtxKA/Nvph4zg0k+OT
 940X8GUuEnnoXxGAINm4u5v5VYJ8ORI5bGV6EkQdRBJDr+r6SmO8IEyQJXiL72N0IjOl
 cBMldhFvAMroYEYq7asKvY0itnxaJ4d+tT79iSjyeYVufydsTz+gF0uEQVlCwiLpDoFX
 +W9UA04wCGxJYpqYZDPbFCqsujSLnBOyY8fGv9AzKyuvukoS5TZJ6FNxdVEndgiOnek5
 LtPD/DGW9FhWt236+perAEK1N49rGZvNuM2Lep7LFKJarowiJQL/3h3YXQHznv82tiuz
 01Jg==
X-Gm-Message-State: AOJu0YxxqM9DhQvHULk/fcHdZD+XpuQR5GOpnyMXWuoGTA+w/+koSQeN
 I1BUJnK7aEx4eADxd74FjTADCn52NW0zmOaHgkBSnCLvF3qyOVqyIVnEvcQjf/L0Wj33MHD+HQ0
 F1BnSSeGWdQ==
X-Gm-Gg: ASbGnct1soaiJzQNgqdI5+B53WcNr1aSK8bKZDOXMOmGFMpIoUX9E7QFrmNA54698ar
 GMrPbh4d5NRdrhMrQBCw/EeeokziTo+TgotxcuPAN3JL26fZVxnWyqGvlnhl6IV0hJ62eo6vBSX
 SoJ0648ZBo5+/PcE5g0Qa5lwpqdl/96zQXtNjZKOFdtPzjW+L6W+tD1Kt8tzPdPiPGOdk+tRgnW
 kSLuErk4wG+QVQEJZ0x/Ywkdf7tliEfAnTvEb92okqvtaEZ8emQWK9TDvq2oFJWQCZdvG5Kdjlj
 MV7iBVY+//bevAYhBkejXTQ9UJJU6UNr/y2hqPeFgh4TkmWz+bOdwCUMbBvZp1eW3EXyQYjGj3z
 jG9JohKmTm4qfX/C41UW8ql6i9M4BzkdxoK9XI+3w8sB8CxkhWnK6lbmipwkahtbOGJs5Mpxgpz
 215uK/Vp1DJf5kZRze7HCIEEQMFA==
X-Google-Smtp-Source: AGHT+IHjfz50VbN77vl51yEZuShG9ZWJl90dZfPlk6WYnylKSeRTX299MkK2JbX1c9tALFa9dVMZ4A==
X-Received: by 2002:a05:6000:2204:b0:3e7:ff32:1ab with SMTP id
 ffacd0b85a97d-42557819209mr2844287f8f.50.1759341312780; 
 Wed, 01 Oct 2025 10:55:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm97984f8f.27.2025.10.01.10.55.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 04/18] hw/vfio/listener: Include missing
 'exec/target_page.h' header
Date: Wed,  1 Oct 2025 19:54:33 +0200
Message-ID: <20251001175448.18933-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  hw/vfio/listener.c: In function ‘vfio_ram_discard_register_listener’:
  hw/vfio/listener.c:258:28: error: implicit declaration of function ‘qemu_target_page_size’; did you mean ‘qemu_ram_pagesize’?
    258 |     int target_page_size = qemu_target_page_size();
        |                            ^~~~~~~~~~~~~~~~~~~~~
        |                            qemu_ram_pagesize

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/vfio/listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index a2c19a3cec1..b5cefc9395c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -25,6 +25,7 @@
 #endif
 #include <linux/vfio.h>
 
+#include "exec/target_page.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
-- 
2.51.0


