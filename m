Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911CAC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvR7-0005zL-Lx; Tue, 11 Mar 2025 04:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvR5-0005ya-GQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvR2-0001Ho-3b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:58:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so522385e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683477; x=1742288277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFPI1v+4fToZ6wKriqV/HJMz8kpUPqvU5UnLhoYJpgc=;
 b=jaxtfWZixfyl+vO6L4vNUQNHllSCqJmAxKN6i7nUQRZ7AF3pymbRdfe6YKxdG4TeQ1
 4Mh1xSxavJcAhvVgtP0H4rbHsJm+Ze1UMLDw6Y40BPNZE6Zssx4wXRKNDvfAFLE0dU4G
 jyHhTR5rfhCZrq84y15xBbDUNWUuVUCCLHWaMU4Ev/tHvP8ZlTKBOwQ0n07s5ubHBuMQ
 L71mADs4eW4MM5L9labgIiluLA01iVrmGtbVU2lGxp7iAtmGXUAuRO7gIB0EJn4FAy/q
 p0dXb0WFn2tIZDZhKRu6B7YO9q7efpYueDalErVajmEV10itiG5q1+Zn7QB8HZhmilZO
 zu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683477; x=1742288277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFPI1v+4fToZ6wKriqV/HJMz8kpUPqvU5UnLhoYJpgc=;
 b=S3UUxpOUgKLdYjYZ3zAAQgykB1FIf5e4cO07Dx+mggHta1tLErH93Fz+mg69/il6IF
 TNL3ViT86i+8+baboLtQ8RQThKAPWGcEhnm+3RgNOMnMJGYjBBvwPeBsB5izCukhz1fx
 gInnNFl0KreFHIgiHe+01EseAWMRqyVsNfqqpErTRCtj8oXfTr6Sg2Aqn5PV5iK4IXuq
 hNTbA1LS3XEX68lJRDMUKNbBeHV052KbTYNBeT8caKaRw+/FViIRGeZ/LkSh/aiXQHy/
 OWq0Ihp2dfxJJ/uafMFQ8pXHFt2lPsU1j0+/gwlEKjbdoWkuJcsT5bFrtHiH67UmZOZo
 g9zA==
X-Gm-Message-State: AOJu0YzuO11xNROWHlquymMtQjDYT0x2+YHMin7O+fn3ssPWRRp/3ukd
 K4BULanrDSRW0WYXRYkZ9OvTndarwexzlfXdltauxDfJLkg3AaGCpm+4pSLJC9klSg90JeFJ42b
 AU+o=
X-Gm-Gg: ASbGncu7DCgfGYfCyR1hvDO2OSMGueCjM3uHK9gJb+7HRqpBBtNtJQ0Hiz8lgyDxySJ
 R2XbOcSXFpvZ2o3xzzfsJaXW1QsMveq1gtKd+DdthsWgH0NEfzMozMnctfXDZIw8ew3PA2DuA3M
 gbcWDtzcscVt7ZTBM88XUnUdAwUAmrGmLrQlxc0jjHYkF/dgzySBhq8fFXGFxkDKXkkIHM+VQII
 2gtsS1JDKer29+ilUKeiJMtWCys0OYwp/mjQDrke2shk8FdNOjU4IDN8ENuGVBi17KmyeSd/Bcq
 QlvSUKlAtst3ss+urswnPm00IFF+J5sC9f+3oujBnOTlmtOrskjrlKh12n2xlEGGvYoi1ZCEtH4
 ryRXoIkPXn8/YLRWGS/c=
X-Google-Smtp-Source: AGHT+IEjYTa2lj1pCEeGQtjX2D/3h3v7NMoL9ZSg7hb8pZcZ1SMqtLbTZYJjvkY1KwoLs20F9eF/kQ==
X-Received: by 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43c5a62a276mr107910565e9.19.1741683477588; 
 Tue, 11 Mar 2025 01:57:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d03e2448bsm9721505e9.1.2025.03.11.01.57.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 01:57:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH-for-10.0 v3 2/8] hw/vfio/spapr: Do not include <linux/kvm.h>
Date: Tue, 11 Mar 2025 09:57:37 +0100
Message-ID: <20250311085743.21724-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311085743.21724-1-philmd@linaro.org>
References: <20250311085743.21724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

<linux/kvm.h> is already included by "system/kvm.h" in the next line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250307180337.14811-3-philmd@linaro.org>
---
 hw/vfio/spapr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 237f96dd3fa..1a5d1611f2c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -11,9 +11,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include "system/kvm.h"
 #include "system/hostmem.h"
 #include "exec/address-spaces.h"
-- 
2.47.1


