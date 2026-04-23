Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7960F9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKo-00014c-EG; Thu, 23 Apr 2026 06:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK2-0000l4-6y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJz-0005kt-3u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hk+it+aWf+hIiKfd3aH+Bql7T1PmX28V5gYZq4O1mI=;
 b=HN03l5RkuBEL0fx0EXNftjBURHJLTX67/Z+BthjU+tdk04KOkB430oHksXGzWa01M5WmiY
 jvD1q/KYtLDF2xrzkLMipLfO7FzNKK2G03rNflP2MU8+zgFai5UltDjlwu3Mfb11PIlK8V
 IY82gh1OiiTO5mZ2vkbNP/Ew0iwvHtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-96H_4pUhMK6EUrDDmO5YSA-1; Thu, 23 Apr 2026 06:30:09 -0400
X-MC-Unique: 96H_4pUhMK6EUrDDmO5YSA-1
X-Mimecast-MFC-AGG-ID: 96H_4pUhMK6EUrDDmO5YSA_1776940208
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso72599695e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940207; x=1777545007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hk+it+aWf+hIiKfd3aH+Bql7T1PmX28V5gYZq4O1mI=;
 b=aQgyikV20FvL7oGyWb97vL6MAJ3GOdtL994ZnIoOo2Lmba6xQtsJxnnlouDaQY8vai
 2hpyGbZheL5mG5AIaQ+Hh7hllXeuPCwBKeSnQ4QZTatJNtqvaw0Bp0QqvAwA3KYjoRTI
 8cnVAd+hDo8B0aSkRMM2TmaIVM9qj2v4ZlAUFs7BpS8t0eHCgXDEVRO8NNuktuHx8INK
 j7ccbQub/ZPyWAr0RGVQjtGuf5hJdWjXc+W1dWVcIKb4cUCKLYZCcGKiALchncGWQ6e/
 e6Nai71F1llx3z+apZxjPKAKRo8aroq0qKiRl8SXNI3d11GYBnxMAQUUgqfk4Uu4ozov
 9oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940207; x=1777545007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9hk+it+aWf+hIiKfd3aH+Bql7T1PmX28V5gYZq4O1mI=;
 b=CB62dragHRAj2UAmnCerJOyAuIem0/s7EriNSzvK5ad8sgogc7IbPR4cYvSn/4GIFX
 guIE3clJD7wxE1hPg2MhvRFeILytXMEpnxVejsbBRaB5u5BJ7mKwlQDM1Xwb0oMKQdU4
 7KAoDZi2dnuDtFCd9VTCjOZ9KTh1LAYrIsgVXZEHWp9ZMmO3fFXCYHSZMrITHT2WecOw
 PBTmtnwYIxN3OWvFI73Ldv4VhE7TtdvdbQilpL5WsmmT/tXLpKGBkhnNhPEZHVgR9NxW
 9ly5uThG3hDnrAXD5e50oYP3uHAwQzR+N+kK/HunlOXCOO21t9LUl5HPLBIqdGiMCN7a
 7XZQ==
X-Gm-Message-State: AOJu0YzMMwVurJPz4henhDp8KTM2bG5gWjCYeSPRzEMIzYS3e8Ik9RMp
 gXaL/Rpp023D080a0zGMhciShemvcZ1+NfHPlExNkJUKZ1ytv4qOEu5sSGN8cYTlSyCwwr/s7k/
 BurKvDcRx0wC/qbjKrVH7KGAzpHnO1+hIY6gaougsPZQOn8f6D0RUFKVO02LCJIwLiXodmYP9L0
 SUR5EltHLSWNZZ2FVYU1AcYgECK5xj2X7QfIg0ggM6
X-Gm-Gg: AeBDiesaNsv7hXSAOXGyuop9YBPfiXbqj00/hyGQm/v/LgUSKe5mKPjaPcCUV5St9ej
 Eb0FkBCgpeb3DQTx6dOFp9THHMI9VSVvapKCLKr9aYbJSgYCfChzDjdWSbw8Z10qm8+X1VpotEC
 aJw1QPkeI+ZGRGCun0V6F7x6k8ZUe5CFHmeH/Mpk3qQXW5uHo3VbdF8IcF1XR5BoB3PW3QYfSfY
 IMPhh2N29o35tiZo+GN8GsQ7UFXr06xa9Wo8K6QXmyBiuq7/hn6puUaELhGCDOKjjEShXKM55+C
 FO1S3fEHE5khMZPrFe7ZenW3MBcTkKxYrSjw1QS6X6gv7IcXxW3naQf8eRHy2twyleTe7u7oxx8
 80H9dypRsFzI+GwbZIsWSURw4OwopwsDJ/3YoEMfDw8/e7GG2BJ+ZrlB7Ljx3MZjJvdPz1KNbx5
 YvTh+jqbWtJcG+Fdx2eWC2K7za/yE/CaPbpCU=
X-Received: by 2002:a05:600c:1616:b0:489:1cd2:6106 with SMTP id
 5b1f17b1804b1-4891cd261f1mr133250505e9.6.1776940206886; 
 Thu, 23 Apr 2026 03:30:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1616:b0:489:1cd2:6106 with SMTP id
 5b1f17b1804b1-4891cd261f1mr133250025e9.6.1776940206286; 
 Thu, 23 Apr 2026 03:30:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm155359945e9.2.2026.04.23.03.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/25] util: Remove unused sys/param.h
Date: Thu, 23 Apr 2026 12:29:12 +0200
Message-ID: <20260423102922.443639-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
basically completely rewrote the path handling).
Now we don't need any sys/param.h defines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260327134401.270186-14-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 72a255890e5..e1565894d20 100644
--- a/util/path.c
+++ b/util/path.c
@@ -4,7 +4,6 @@
    The assumption is that this area does not change.
 */
 #include "qemu/osdep.h"
-#include <sys/param.h>
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 #include "qemu/thread.h"
-- 
2.53.0


