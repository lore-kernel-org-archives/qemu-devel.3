Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C911075290
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AM5-0001au-9p; Thu, 19 Mar 2026 06:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3AM2-0001aN-N1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3AM1-0007b7-Ai
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773915108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lw5UTLFTSnesBq6uUOdxGnFVosUuLhym50lDWqJZ1T4=;
 b=LR5BUqbilkimsn2ucU+hN5VwwkHaQiM8XuJyqhYSYFWYz1Y+oG/7BYHx09frkMB2a4XTyr
 kZFKOxyhZXGdx4tM1xS3GBCJX5XEiz4vj7DIu3q3f2FvHGNDTP8PFn1A9h8dxhMzioFsk1
 cgHMSRU4Lv5FFEMBJYz/nIJi+AsbmDo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-2JUEoYOTNzCJ239b3Y8o5A-1; Thu, 19 Mar 2026 06:11:47 -0400
X-MC-Unique: 2JUEoYOTNzCJ239b3Y8o5A-1
X-Mimecast-MFC-AGG-ID: 2JUEoYOTNzCJ239b3Y8o5A_1773915106
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82a11aeee8cso510520b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773915106; x=1774519906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lw5UTLFTSnesBq6uUOdxGnFVosUuLhym50lDWqJZ1T4=;
 b=kdnLOOY4w0XLrqmiLkFsom6COBKJPZmxQrsKBrrtBCXobL+KnX5xAz1twBslfHRIb4
 MIjMj+wojz57FuNRf5NuBarcVfeVGGpN/CHkmjrdj1+ldZmSRsqX8qxhr+iKGLYEaMHO
 JvmXMofsk40uk9XI0q8x7AP/qPj0jahwBQWSAZJ7yDbVxmBzvQWpRjjqwT1etNyJ3sqT
 JPbgSIVY2WDJIhA8rm3wTW7ahbjAizroboo20KYMnZ/Msgt2QkHzU5+iwuvykQ9LjnJz
 iguWJ/mJAZGCchzEGM9NhqK99W2Ts9Z076XFAXOTfgl/841tMLb8xqo86OQiAXgpUUEs
 egxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773915106; x=1774519906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lw5UTLFTSnesBq6uUOdxGnFVosUuLhym50lDWqJZ1T4=;
 b=DhmzEUX78EIIiA8dCQ2785qIV/Ncz3WSCujbR9zyruVFhRDS9qKwsxqmxSAPDr46Ep
 A5kVonQ4znV21KiyTVTSFHjw+wCtPGXh45Z3Iu3IUqjOBVGs0qbG9P4nU9hyNM81KTGD
 gjuJ1Jvi+7sIcCgLGgcJZ22XoGbN0uIsrpW08vBtEJTSZ8Nh5thSUNN54ZPMa9/Rc9JX
 zjbV9dm6S1+96/t+B/ZyUW7A36nxN7geClihHODzH3pSOtI/Um8aAozCMa5njMMsaiXm
 HQxNK0JcrdAVzfIA/9wgtP5Hj0u8MF80vwfDxwyHxcjhKQFfOD11vtoOKKSb6VVXObLI
 R8zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkS5ISrY2M9RZPzZFLLhEw+8f15lIPRd7+7lL1/PGktj8kzX/CAELduaKxgFWHBzrdDGjGkZnSX18F@nongnu.org
X-Gm-Message-State: AOJu0Ywi4FUnhdg3zF63PEXyhisdecInVzG2eHL6l7uTguAFyMUWs15P
 TmChv5vE7DcwY23sOZRvrIaji9p44MwNwXa6ArR47C8M9hdvYcU2//9m2hRLNx/F8ANjTAPavJp
 OoL4PWlntuBU6LHgqdfp+AKfo+RXTin+pJNkoTadoLKFn7gXVbFz0Cf4l
X-Gm-Gg: ATEYQzz7KaudIDmqW36ZQ6qw2Siserg1DED7aO8JUKP4vPxMSItGx1gf8P8wSKUjTb5
 su11vGqfxXL3OnEEisVDvjb1qptiS9t9qsnnPFs2tla+ryCoPJilLoOTxpiBxlo7+3hRaNE61bY
 W4KG4RbU44BszwehRzYg2ugsDgZ6WT6F1l9z50pAvQ9SbDkteR07waGuOgIFfr39+ivrbvE+WNZ
 r4jM6k2C/UpZ7iPci8YGe9zOhhRqIRaYR+UNfrfz9g61Hi/p0xvFyWz1S2Ib9Ri3HozR1GADroN
 DXe14SQst2zYxW1wmXqwkvNuITNt4KAttD2HgGgKf7bwsbFRg+SVRIIGOVrzpVDiGeoqqoHTy7a
 cVOTt87DPuxcxE8zFGNQqSpJbwZ7gX5XuYBMT5bK3jKWSZnoNbY0Xu/Y=
X-Received: by 2002:a05:6a00:1ad2:b0:82a:1380:417d with SMTP id
 d2e1a72fcca58-82a6aed1ee2mr6047109b3a.52.1773915105956; 
 Thu, 19 Mar 2026 03:11:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ad2:b0:82a:1380:417d with SMTP id
 d2e1a72fcca58-82a6aed1ee2mr6047092b3a.52.1773915105607; 
 Thu, 19 Mar 2026 03:11:45 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb2f34sm5594319b3a.30.2026.03.19.03.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 03:11:45 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0 1/2] i386/pc_sysfw: stub out x86_firmware_configure
Date: Thu, 19 Mar 2026 15:41:27 +0530
Message-ID: <20260319101128.116301-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319101128.116301-1-anisinha@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

x86_firmware_configure requires ovmf support. Add a stub for this function call
for cases where OVMF is not supported.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_sysfw_ovmf-stubs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..b53906a052 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    g_assert_not_reached();
+}
-- 
2.42.0


