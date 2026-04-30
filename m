Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084BBFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6a-0004xO-02; Thu, 30 Apr 2026 13:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6X-0004wE-VN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6V-0004T7-T3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hUcq6A7hmtpQ4Z5g+/0lakuLs6bGhM5h8wBcF/fIJo=;
 b=Azif22Cpxetwq+Ed00rTooMtQy/hr1bgX90kyir6i+aalLISoOwbAcaPW9BtpX3FZ65rWI
 APceZIZ9FekKhIa4FimVujyE3m4C2oSGOzyvC+7o/577R6VsaXjLbv8zmB2ohdwULuYKvN
 0iSKD6uUXduPPVdQBtyw+eoM8pxCJno=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-aJrFvzdYMLmCsD7KfGEkRQ-1; Thu, 30 Apr 2026 13:23:09 -0400
X-MC-Unique: aJrFvzdYMLmCsD7KfGEkRQ-1
X-Mimecast-MFC-AGG-ID: aJrFvzdYMLmCsD7KfGEkRQ_1777569789
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb52a22e85so262106085a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569789; x=1778174589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hUcq6A7hmtpQ4Z5g+/0lakuLs6bGhM5h8wBcF/fIJo=;
 b=LBjiejOcFrfQp1Hh401+ucb8WVsRrK2zM9s6adSybKNb/d9wA8Y+qqwWPi0FOcbbaw
 IV3eTTZm5KHySvd8RSNvXbknhk86+qhh5lfTy7TeT1qRT+r2APwYh9RKtli/fsQ1bC7q
 HOMIesQNXh+/IPUD75/Jg/NTvwGrfvIGKNt+5USEgRnbN8/wWYg8hQnarGrx1iSG1lIV
 wlv5K+6W9MpoOiT01QZc0CQ7M2T0wUGnHydhgm7xqoZNiCgYdnPFfURqO93k1qVczSpI
 UMiJjuuaHz1fyDrBTej2gZDd6FLouQdQo5Yv4s+7ghdU5lFBWi2m9pp01r6WB64q4HzJ
 AQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569789; x=1778174589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hUcq6A7hmtpQ4Z5g+/0lakuLs6bGhM5h8wBcF/fIJo=;
 b=JZucg70EbYbKBsOqUaYtd443P9HriAZhVCfzKDNQHSJul/YWastjAlmAtTvFrktX9p
 Gf39mjWfcBBNhIJwgiFQctAmwrORciCqUfT07QfKBcC8c7NyEuJwPopFui/l6BC5P0Tn
 XdoL5HycaL0tsMx9sFPMxWbv+wWXmqU/KIz5zFAauiRRRqGjVrm84n29br6DYgckQC/b
 3QWkI162quQq7rGfC432x9LvTNkEOeC6EqbmPci7eXNBWiqjMTssvau+DcHv/rLlRYso
 HtqqIoGzS+xSppLxCDkULjkrk0n7GfraqsEsSK4VKUKVhDf+El0+Vo2NY4F6nluK4GH1
 L+UQ==
X-Gm-Message-State: AOJu0Yxj3hbfeKjCy8mLpcMPX6lqjix7xRUvULV6es3sIGagVWoF3+d3
 VyUp/q+FUbYRN5VxO9EKGLVMup4S6+JTWmmxYG8ZqkQfxWufSVEa+OGXWL2MCgx3n/I5IT5TSWz
 i/qFv7Ew083GMuiNXHkz33abBlJysUTHyXIugq1c8JDD/XTSscKAk9hYsQwdyd2T/LuVNlQ+k4F
 fQDmG5ma1x6329K3szrjQs4E5rxa4jXgyKQqajyccQ
X-Gm-Gg: AeBDievEfHPmhyoLVvXz7yGUL9s6vcVGeaEDkaicUKkuQYvKKXUR5qRWRiy2rQvMuH4
 Z++OPmbH/bTJGzXDOS+9pxmc91nacj3UTIAxaGtstekp4EHdNNswHyuRVk8Q38vCw1aFGpLgnCz
 SFq/eDUFV9+basYZya2ge1zvsmcGwRpHPC702FMZnKtM6Llwx7HAdr124PUag+DJAlYcte9hhgf
 Gw6sAPO3+nAwbZKxEGUji3XLkwKib6jseg+o4sPxxip8/D/oS2E+P1AVPooh+QwbzxvyqFWV2W9
 844g8KGKSpYCwrBtf/WBgm6qcAfv80URWcL2t8wxsHCT8qdK340TBnb94B4O6d3AYeICXEnwQld
 Hay6BK21f7tBMrv29NgGVbklEd7U712p/kLx0KgVQNcgQ39AFPwtowSe6IQbHwI7qLBjzHaBkY6
 v2FkGkXL4v+/SELdGF1OZSYktIUL7i0GXzs78=
X-Received: by 2002:a05:620a:4804:b0:8ea:b4d3:b19c with SMTP id
 af79cd13be357-8fa88943897mr571094785a.28.1777569788695; 
 Thu, 30 Apr 2026 10:23:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:8ea:b4d3:b19c with SMTP id
 af79cd13be357-8fa88943897mr571089085a.28.1777569788137; 
 Thu, 30 Apr 2026 10:23:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb4707c2dsm21586185a.47.2026.04.30.10.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 19/58] hw/qdev: Prefix bus type in qdev_get_printable_name()
 device paths
Date: Thu, 30 Apr 2026 19:21:25 +0200
Message-ID: <20260430172204.1006673-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
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

From: Alessandro Ratti <alessandro@0x65c.net>

Raw get_dev_path() output (e.g. "0000:00:04.0", "/1") is ambiguous
without knowing which bus produced it. Prefix the path with the bus
type name so error messages become self-describing.

Examples:
  - PCIE device 0000:00:04.0
  - virtio-pci-bus device 0000:00:03.0

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260321100405.1525059-3-alessandro@0x65c.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 78156185d57..0efc83f6740 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -419,11 +419,13 @@ const char *qdev_get_printable_name(DeviceState *dev)
     }
     /*
      * Fall back to a bus-specific device path, if the bus
-     * provides one (e.g. PCI address "0000:00:04.0").
+     * provides one (e.g. "PCI device 0000:00:04.0").
      */
-    const char *path = qdev_get_dev_path(dev);
+    g_autofree char *path = qdev_get_dev_path(dev);
     if (path) {
-        return path;
+        const char *bus_type = object_get_typename(OBJECT(dev->parent_bus));
+        char *name = g_strdup_printf("%s device %s", bus_type, path);
+        return name;
     }
 
     return object_get_canonical_path(OBJECT(dev));
-- 
2.54.0


