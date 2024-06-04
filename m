Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95302C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuk-0002yU-Pf; Tue, 04 Jun 2024 02:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENui-0002xe-UD
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuh-0007Hm-Aa
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdwTvsCx7edNSXKoA8pOZOCc+yJ4yzpVxsliOREE4sg=;
 b=R5pDZ9KMhYsTksuElkIy7KD16j78dearu89iWjx/7nwVDNQfU55RPIXtMBgHqRLBvi5sfd
 mCN4AkCLBTFNnxT6b5Bzu/QLvkXh12oc/m6EPI9NvBwXVp9RfTDnmuEwAQG/wA9tvkXHRV
 aBihqS2wejfk5zNb3HZKPXoJWtK7oUc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-8mIpo79APAqC-0mAFPQIlw-1; Tue, 04 Jun 2024 02:44:53 -0400
X-MC-Unique: 8mIpo79APAqC-0mAFPQIlw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6929fc5b52so44951466b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483491; x=1718088291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdwTvsCx7edNSXKoA8pOZOCc+yJ4yzpVxsliOREE4sg=;
 b=soyQDz34opwCE+iRt1VKXiwps7yGs5NPohOds1Zdu7Mh48pz4qIdBcsnfy95YhMTL3
 qFEKUo2AJVXmq0vhwCPW+f9VXExaCKR+M+33ZFXDXOf0RC5qOvK7T3jkJrnK1hSxakCa
 iEAgtqxzZmdwAAU5bSr/YmECv0XUpOMbyNpde1p7zqmHpdtTW8myvN/9SgclvtwVLPzX
 6giF2LKFi4bH7r4tzT9y70dUz++p9lqFUKj/SiJR9EIl4HzOfaVOoJdr3b6Ds+8X/zen
 /MPd/XTwWyOBIAiUFokNQdrXoGZzN0G1jSKeiVsRM+sdJNtWzw2D1lQdLCJTMPDPzrZp
 ETCA==
X-Gm-Message-State: AOJu0Yxz+TnlN85UixkoPuWvzcNZzs3qyyiYiwi/rN6TOrcke5hWmjW3
 poKmSFY5OIe9tDr/l0aLvqq8uG8p7EPgxcycmuFqJbxOudrp4m8/nJb2N0pS+jCFPgiYxS7UMc2
 hd97T4Bk2/P1+tX87nce4O0d7hhnBYpT31SREIF+yN/MJfF+Qik8kc7yh1tMKEHlsMPVeT2NCEI
 HBBerxVNjU8+8bi2UZGFFoPFWcZ30HckH2YUOb
X-Received: by 2002:a17:906:a1c3:b0:a66:dca6:43f6 with SMTP id
 a640c23a62f3a-a6820136b23mr805614366b.27.1717483490725; 
 Mon, 03 Jun 2024 23:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhSl8mchuuOuzv0kfTTNNk0cmtjRedJIyrDvbhGeRrQwb5iUytSzd1Zw39dHKuBeRFGk0j5g==
X-Received: by 2002:a17:906:a1c3:b0:a66:dca6:43f6 with SMTP id
 a640c23a62f3a-a6820136b23mr805612666b.27.1717483490387; 
 Mon, 03 Jun 2024 23:44:50 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b59e925csm443122366b.220.2024.06.03.23.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/45] update-linux-headers: move pvpanic.h to correct directory
Date: Tue,  4 Jun 2024 08:43:37 +0200
Message-ID: <20240604064409.957105-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Linux has <misc/pvpanic.h>, not <linux/pvpanic.h>.  Use the same
directory for QEMU's include/standard-headers/ copy.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/{linux => misc}/pvpanic.h | 0
 hw/misc/pvpanic-isa.c                              | 2 +-
 hw/misc/pvpanic-pci.c                              | 2 +-
 hw/misc/pvpanic.c                                  | 2 +-
 scripts/update-linux-headers.sh                    | 6 ++++--
 5 files changed, 7 insertions(+), 5 deletions(-)
 rename include/standard-headers/{linux => misc}/pvpanic.h (100%)

diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/misc/pvpanic.h
similarity index 100%
rename from include/standard-headers/linux/pvpanic.h
rename to include/standard-headers/misc/pvpanic.h
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index ccec50f61bb..b4f84c41109 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -21,7 +21,7 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/isa/isa.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 83be95d0d24..4d44a881dad 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -21,7 +21,7 @@
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
 
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1540e9091a4..80289ecf5fe 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -21,7 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
 #include "qom/object.h"
-#include "standard-headers/linux/pvpanic.h"
+#include "standard-headers/misc/pvpanic.h"
 
 static void handle_event(int event)
 {
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 57a48837aa4..7e93acb3b5f 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -231,10 +231,12 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/const.h" \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/vhost_types.h" \
-         "$hdrdir/include/linux/sysinfo.h" \
-         "$hdrdir/include/misc/pvpanic.h"; do
+         "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
+mkdir -p "$output/include/standard-headers/misc"
+cp_portable "$hdrdir/include/misc/pvpanic.h" \
+            "$output/include/standard-headers/misc"
 mkdir -p "$output/include/standard-headers/drm"
 cp_portable "$hdrdir/include/drm/drm_fourcc.h" \
             "$output/include/standard-headers/drm"
-- 
2.45.1


