Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90559C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTht-0008Bc-69; Thu, 17 Jul 2025 14:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8r-0002vg-3P
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8m-0002H8-0y
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zxpl/PQRwn3jQnhX2F8Ka6KHfmWqxvN4L1LgBM5SOU=;
 b=KnDUx7L5XPUJF/zka/ahU9GUqfnPUGFBSzdUY666zbPO/GjGoywQ9u+Gz72XsH8cFYJZjK
 hRl8C4B1H5E/FAB6AtT9e/xPMTe7d9m0ZDB1DoAMEKpzR02l6v6RiYxhBOUDjYpntUKr+A
 WmX7ynbnRJXlYP6ru/WRzEjw+50RT7c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-vkbwoY8QMhKfg-wkoswWBA-1; Thu, 17 Jul 2025 12:07:18 -0400
X-MC-Unique: vkbwoY8QMhKfg-wkoswWBA-1
X-Mimecast-MFC-AGG-ID: vkbwoY8QMhKfg-wkoswWBA_1752768437
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456267c79deso3751585e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768436; x=1753373236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zxpl/PQRwn3jQnhX2F8Ka6KHfmWqxvN4L1LgBM5SOU=;
 b=fdUnd5E/h7bEvtZG18iGVPuUx0QRfjMHdnszOKPn+coMTMVwgowEq3+wj0/LccjHqC
 ovyqIZv+0ylpgECLyBapk1ZG45/O61JMomjquAoCOMLtxLUIpXGa+5TIzqqXi6PtDGNk
 0RqWdm5lKkYwX+9J1IbrDPlVDhyAkvZgYk4Bws5WxGAF8GOF7gF1KLBUphSGvPD79RR8
 FGzzw+39HApNgFW6qgk88LJwtNOw+ipQ4PZjVAu5vmEgdLWLHeBelQ01klLTgeaiAa4/
 AXKCOkCJVv/uZdTYmTQhgN+RtsTa84ydWO9jhrLQtI9mrXH0u763w9uMpsLHgDOTth2j
 lE6A==
X-Gm-Message-State: AOJu0YwjdtBbPAwpQNcHGFRVrpDWmyUwq8VZo39AO7SXXlqdMdd2N0Zy
 lqGR9YMVQCMghF5e6RJDhed4A9wM2Tp/H+pmjvyOM5/wK1uqibh8y55HGogEYrgw16Dug4SqS7g
 mk3RJWSBrFmQRqMoRe1nZRDjpWFeey+Bq2tOE0pzBZRt4GrrIS6yNsFpm8N2i1cYRAM0xzt9HiW
 2avpV0UxpWYp/ZbmYcI47j7/5Uw+fYnZtUkSoI+/Cc
X-Gm-Gg: ASbGncuQGJAoPhMi8Q82Y3n5R2sOEWYM3QGfECrRYzVdfD9oG7iMrEMAQ98tD5r7QYL
 RY/HSEo2pkIY7z4JEVdV9uGrZHcWdBrGf2bt8i7PQoWyQkyALhX0AkAhG5PiCpburSG3gFhY0Sq
 nVBrUFXxD4p2BZdT5uF0WyUutgDMJeu2f2yYq/pQi2hec1VBx8fYGoCRE6j+qTAkjgciI4iD5+D
 PXZlMkITp5r1yH6VNfcGIL9yUvoqu0r+lU3VOBu1m3j8E6t9UY9IlWZtnbmch+xslLaqCCoS9p9
 wMV276Y2dcIT+Q4Q1RRAbtoQivb4Oz5zAMovxbo3Buo=
X-Received: by 2002:a05:600c:3481:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-4562e3c4b8bmr63183015e9.25.1752768436428; 
 Thu, 17 Jul 2025 09:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuchvTf+jdstqtSaVFZsjDPxLdC0wssJpUGm/o7pWMq6jaG91Q0jM+Wt9WLF+B+hMLMqWuLQ==
X-Received: by 2002:a05:600c:3481:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-4562e3c4b8bmr63182535e9.25.1752768435895; 
 Thu, 17 Jul 2025 09:07:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886113sm55937915e9.23.2025.07.17.09.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] i386/tdx: Remove the redundant qemu_mutex_init(&tdx->lock)
Date: Thu, 17 Jul 2025 18:07:00 +0200
Message-ID: <20250717160700.357384-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Commit 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>") added
redundant qemu_mutex_init(&tdx->lock) in tdx_guest_init by mistake.

Fix it by removing the redundant one.

Fixes: 40da501d8989 ("i386/tdx: handle TDG.VP.VMCALL<GetQuote>")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250717103707.688929-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1574e7d76fe..dbf0fa2c918 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1527,8 +1527,6 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_set_qgs,
                             NULL, NULL);
 
-    qemu_mutex_init(&tdx->lock);
-
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
 }
-- 
2.50.1


