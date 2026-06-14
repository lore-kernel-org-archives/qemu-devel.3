Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01374CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDm-000247-Q3; Sun, 14 Jun 2026 15:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDk-0001rE-Lz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDi-0002yq-TO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBqy2nyXhPmWPOZD69Mk+la2XQBzGaVJdV3UtpUY4nk=;
 b=Tfeq4+Mermn1GBqzcd1NR9qmDPGevSyC5k9GmKDahVv0J/WUGsS3KRYNi7TS6xh12r5dAG
 luPGHGL9XoXAaVnB1qwJ9Ig/aDwSXvBnuykjG0qmCM+BuXhLL1sRt9e3sGe9N50BH37fxc
 3INvkPTVFSrNgvYhrKmuBYT7b+idBaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-PwYYRDazN0mZPSc88KtQug-1; Sun, 14 Jun 2026 15:10:09 -0400
X-MC-Unique: PwYYRDazN0mZPSc88KtQug-1
X-Mimecast-MFC-AGG-ID: PwYYRDazN0mZPSc88KtQug_1781464208
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so22241635e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464208; x=1782069008; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SBqy2nyXhPmWPOZD69Mk+la2XQBzGaVJdV3UtpUY4nk=;
 b=f6z9yTQ2aLzjjM5whoH157YhomScm7MzrPAUNfBa8t7/geL9SeRbEFVM3Cak3KppOG
 ZGM8uKW9iMvj/0WmgR/Imy96IM6LTj7ir7qAAJ3mIm6UknQytBHBC2DYroX8wstaj+N3
 ShqV8YBxeidB6G2s7Y1m6bl1RsvfBprA/0hEjz3FwEao/fIOEmpqUj9g3mX+y6eXapr4
 di7LQjIoLpqyrWjZu+D2/MbjN7XKuPgh/TsbgwRMiRn0Rht/arXRf4wSuH1qf9d1AxRw
 aoxGqyS2tUL1uJuwnrP3bh4Q2/PLHB4Xn698JuwKUp4Q2l8/Tw3ro6eqFxNICD5x3Lef
 zkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464208; x=1782069008;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBqy2nyXhPmWPOZD69Mk+la2XQBzGaVJdV3UtpUY4nk=;
 b=sWr8QuvgBYzy9bAM8uCxhUTYZP0l0lBzTmW4GH87U3uE26AZ4/wmraSEAYSBit6UCn
 LxaD3EQ1f7dAODbpre0CWW9TU61hknnf8azExDb/fshm1hQzLRNqDskdCETcIwEJc1xm
 BuDnW+vSIX26ZNplVp/X+6ALI4JXVZy1BGevNiVWby2+BXeIhmMt14OlQoGGTxNvjCDr
 ZmAphDvCqvhvINpj4tl2QrxU6Bh9sDVrlB+Run1KmVKKQn4fKGlWbci+j8tSEdI+BrvX
 XIAEzMgCo5NlE6ZG0FlH1RWr/yNtxbWXhw3c7mgCcaKgYPnVzt6+EF0Cc4hBxHU7Mqeq
 y15w==
X-Gm-Message-State: AOJu0Ywq4dAMX4d2jfurI73aHRT7IYwVI6KLMfIE6zQcg47YIL58RMKF
 qG8BP4L9q+r1vubzwNSxjU7Tyq2tD1mNLeqopGpSVZ3+1vTlylywMaEHsWFIErnGLdnMP536Cqg
 U+vGLWPpnkByNZNCJ9i6c1XuCHN2sQ/SB8xT/dHTPUA5u8huVz82dVlHWWQ7kSdnBIG1qCLX1nd
 gVigfT+EOeYzPZaJ7yuhtZe1yID9ls3g6/iQ==
X-Gm-Gg: Acq92OE4OLFDirMmA8T7aaQbq3xr7/v1Z6R1d7NFn7lbGkUC+lJIvms5n7WWjhjK2/M
 vIyeh6O+t/uY+QYO44Ds/zFoVfwDsc6hF8NG526HrMkRO1wLt94rbCkubAW6ZuKhL64K1gTyp9U
 3iqT8ftBOnuu3fR9g/JUZoK26nDHvwkhqay1sxQg65uI8vovR4Er7JoDZwwY0JLAmtKwSL9xSB5
 vay9ppKPW8ixV/Jw4NH6bQnuadFii3a2CFnilCbwaB3FOtxMd8MaOlKCQEsLF/HcSooJkSUQOjF
 lwi1mzQu2ukwwT7h09f9+TIxapQoVdS6pD0B9lz6/2E7jTg/7z1+5t2iYJLZ9HIiZp6zHh3uoqb
 rZ+4PUZw/JIkCKyC8U/ti+SBrr1ll8Ynx57sBhkcj1es=
X-Received: by 2002:a05:600c:4fc5:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-490ec3388c8mr144461765e9.0.1781464207684; 
 Sun, 14 Jun 2026 12:10:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-490ec3388c8mr144461505e9.0.1781464207177; 
 Sun, 14 Jun 2026 12:10:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm23360807f8f.26.2026.06.14.12.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:10:06 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:10:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Quan Sun <Quan.Sun@windriver.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 106/106] hw/scsi/vhost-scsi: fix build with older kernel headers
Message-ID: <31dbba011d0f3a21432d0629fae0b4885f2eed25.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Quan Sun <Quan.Sun@windriver.com>

On build hosts with kernel headers older than 6.0, the system's
<linux/vhost_types.h> does not define struct vhost_vring_worker or
struct vhost_worker_state, causing compilation of vhost-scsi.c to
fail:

  error: storage size of 'vq_worker' isn't known

Fix by including standard-headers/linux/vhost_types.h before the
system's <linux/vhost.h>, matching the existing pattern used in
hw/virtio/vhost-backend.c. QEMU's bundled header provides the
struct definitions, and its include guard prevents redefinition
when the system header pulls in its own vhost_types.h.

Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260525182730.4098543-1-Quan.Sun@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 859888fdba..657403cad0 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "standard-headers/linux/vhost_types.h"
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
-- 
MST


