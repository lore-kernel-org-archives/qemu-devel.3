Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE32AE7718C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByJ-00059k-Nt; Thu, 19 Dec 2024 03:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByG-0004zj-RH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByF-0005Bt-7k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgfb1jJ+uI0m2LNzjpbnbFnNCYuuMLTRbLqF62ceNkc=;
 b=dHoNFIlOLrD6VJlkMVd2l7XQiqCLp7VRkLNTp533cPe2IXSjU3LUuEXJkYkwOhNJwIs2Ax
 MVzUDQ/0GBqFqLzNfZQPd9OzKTeDXH3DoH6EBVF2fRZYjDJsL7KNf8fr15PeFKHNfH51xi
 2GArAyrOz8myu4yutliHLie7dJeVM0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-7lPD2bOZNzqfbRve80DOkw-1; Thu, 19 Dec 2024 03:33:20 -0500
X-MC-Unique: 7lPD2bOZNzqfbRve80DOkw-1
X-Mimecast-MFC-AGG-ID: 7lPD2bOZNzqfbRve80DOkw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436289a570eso4202735e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597199; x=1735201999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgfb1jJ+uI0m2LNzjpbnbFnNCYuuMLTRbLqF62ceNkc=;
 b=PHW4BjhMypvM/sTSrfkkvsfuELEVLIDHD2sEI2hv/rkgNX0pjQL7tRFAad/vsqFIjb
 tpub3XdWK3/dgSP606shxSDK+bAMU9rAqSnNGxzeplMObHpUuKqlglH8vgnnPUFdMx75
 V6259ut2a/1HR6sWQ5QhABsoS4bqqwP8fym0hsmjdUXBEsWOYizHn5s2X+cCeALrcO1J
 cj488bhO8g2EpooNN2on/KEhhlxjncAt5hPDhTibVHbgnjUB39SY4ADFyOqaIPwJ9kaf
 yzqDg9GozUhO0fopNbLF1SU1M+T9Zp5xk8JpgJDAEtepk1Ofl3apBghv7+iMGNGo5whi
 8yUQ==
X-Gm-Message-State: AOJu0YziB2cF4/BE3JGh2KUmjmrf1tIdf9Vy2yEUm0KovJgpvxF1km4f
 gjZzRN0C0sNND03CHm2+BQ6R6VhMxxcJG7VgLGJl/FjMxGt9zYWtzLhhxoYM/bCAZEKozycNFmR
 gFm2C81fZntmp10r/G8A8Nwq83ilfAV80Upz+lxAsh0rWaDoA/03t6bk7jfItHkioJRITocfxBy
 NNC8pgQ8guX/CeJhQ2c8+17N97jGcHJ2JlLLB0
X-Gm-Gg: ASbGnctuF+JDRVWG2IlIUwLtyQgKSb7GZb/i5W5kgFN3qgCGf8VWzEn+85XEDJlG6OB
 KqxybXUrT7NK0vYZ5BgQGlbwDROLSBs44NMB5S7BXg0J9HAiIbqx3w+5pIBR7SVu0CjwBM9aSzr
 7lisLNO+3t07XWM6hPfGDACxXizTvZquxKWBMc5js8XYEBZqb1ZPiXCD6+OvyHWcX7+2YRDY8wS
 UuHRVZeGGhRjgQEqGwEK+0vht8qTYHpEvQmnYoR6+3WC6pToAWL48Me3jy6
X-Received: by 2002:a5d:6da1:0:b0:388:c75d:be97 with SMTP id
 ffacd0b85a97d-38a19af8799mr2341174f8f.11.1734597199199; 
 Thu, 19 Dec 2024 00:33:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyOEAzzbAZB7fZ7XYd/3ZVSXNKlsaiYFHZyTUHlIqM5M3NCaIhdrEGs4TeDStthbDaktxzLw==
X-Received: by 2002:a5d:6da1:0:b0:388:c75d:be97 with SMTP id
 ffacd0b85a97d-38a19af8799mr2341148f8f.11.1734597198765; 
 Thu, 19 Dec 2024 00:33:18 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828e7asm986991f8f.21.2024.12.19.00.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/41] hw/core/qdev-properties: Constify Property argument to
 PropertyInfo.print
Date: Thu, 19 Dec 2024 09:32:10 +0100
Message-ID: <20241219083228.363430-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

There is exactly one instance of this method: print_pci_devfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-24-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h     | 2 +-
 hw/core/qdev-properties-system.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 447767688b6..bf27375a3cc 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,7 +34,7 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     bool realized_set_allowed; /* allow setting property on realized device */
-    int (*print)(Object *obj, Property *prop, char *dest, size_t len);
+    int (*print)(Object *obj, const Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               const Property *prop);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 22ea1ed3583..1034e9b5809 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -869,7 +869,7 @@ out:
     visit_end_alternate(v, (void **) &alt);
 }
 
-static int print_pci_devfn(Object *obj, Property *prop, char *dest,
+static int print_pci_devfn(Object *obj, const Property *prop, char *dest,
                            size_t len)
 {
     int32_t *ptr = object_field_prop_ptr(obj, prop);
-- 
2.47.1


