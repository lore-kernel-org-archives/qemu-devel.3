Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E3C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiD-0002W7-39; Fri, 30 May 2025 04:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui8-0002Ug-FZ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui6-0004am-S5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=VHNz+WniFEagXQB2cLfCCroUCFHgByqhLhcAkKTmgs21oVfDvRTPw7/cDk/9vx47Wwhmbg
 xGWHHJtq3FyXwxdQo4VrArBNgEUf2IYGf4zEDgg61TlHh95vPhUcOy/ySFRezjSGXI/1h6
 kJnG7zfqcZm+j/AkTlot9jyA+QsVjwQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uFPu5UrRM6yVn8KMI1MiNw-1; Fri, 30 May 2025 04:03:20 -0400
X-MC-Unique: uFPu5UrRM6yVn8KMI1MiNw-1
X-Mimecast-MFC-AGG-ID: uFPu5UrRM6yVn8KMI1MiNw_1748592199
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56c5412f2so153907066b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592196; x=1749196996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucBnDbok7v6Mu7KPseGvFTjV3duwh5RlIILFahRdtRA=;
 b=OfnkbbSDpO0vOQS5kTQjYleIioiAVCraGY0MjqG7569uxn6kXwuINwAFOIUoGSzwea
 MM2tPHbDJ6ZW0q73UvilstjDKhZRFk35vdYtvOYUsMHihfw198OpCm9eTM7e1dnSdQ8Z
 9Zhw4stWx7OoRklQLFdmSLcx2sau2vAsxwSkZyjKGFG9EjPdsjCcUEEmaKxq3n257JZE
 sQJ8VTIeMgobVxjgfYfQ0ZhnY975Uk9cjcD3lVA78WbM1DfWsHVPuiS+ceGXukob7i+/
 ruzHmIxFXPfIVJ66dpcwsBYTRMGSe0Fbez0RTQqyTOTm97kdT5qq9lswMwYPxEP6ViAT
 msEA==
X-Gm-Message-State: AOJu0YxkabdetOCfZ+sy5F4VcLmsX28yy8otsbI1f9ZX0RTzH8KPKp16
 HnQGLyy9Yq58TNIvwZ3LjjHT6vSVmcQT15xG3FCkB6l8GjaHZogZrAl0jwCEihqpxSoX3BNdPq4
 EvIEFGIpUdwpcmZT6sfUb5fzZO4BGJbZ0WEwx1ytyLigBOD2ca+iivHQQGItYcGwnIOT03qBYLn
 SWBCNDirszzUQRz4r3Qa+jykC7nDa+chO8eldB3zAf
X-Gm-Gg: ASbGncsnBhWFS5lDgRSCqk6doTCsaq0jjcJCVfFuendYZr920JcfCd+6xtajhQkgZTw
 z43mrEU4E5+lvMXASgG89OQd+FKqXuAAODyfg2eydtZf6OgZ+7g1Hje7Y8F3NrU30FFsBbDPjj7
 Shohi+pWe6z4/kZ2cwnElrD1DWS1IgXxcDNwhRQsEAhcZ+bbuo5GsK6kjNaVIWppPP8L/qKkfRP
 03sbGaPu8RzYvzTaBsX6UM7CrQKRs/TH7a117h0MiPkv5fTLKFLMu/HKJCddHzwEGqZzvLsofW8
 XEwlDPz8fRrF+OxtGj9Qxzn2
X-Received: by 2002:a17:907:3d90:b0:ad8:9257:571c with SMTP id
 a640c23a62f3a-adb36b4cdd9mr134316966b.20.1748592196338; 
 Fri, 30 May 2025 01:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoaUH0pu+T1ZgUEPTJlRucO+jfglmnp6UDpzApsFnlT+8QhhfYXnmbuNXg/a34e/1wNM6Fhg==
X-Received: by 2002:a17:907:3d90:b0:ad8:9257:571c with SMTP id
 a640c23a62f3a-adb36b4cdd9mr134313666b.20.1748592195840; 
 Fri, 30 May 2025 01:03:15 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb32e347fasm111858866b.168.2025.05.30.01.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 03/14] util/error: expose Error definition to Rust code
Date: Fri, 30 May 2025 10:02:55 +0200
Message-ID: <20250530080307.2055502-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is used to preserve the file and line in a roundtrip from
C Error to Rust and back to C.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/error-internal.h | 26 ++++++++++++++++++++++++++
 rust/wrapper.h                |  1 +
 util/error.c                  | 10 +---------
 3 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 include/qapi/error-internal.h

diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
new file mode 100644
index 00000000000..d5c3904adec
--- /dev/null
+++ b/include/qapi/error-internal.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU Error Objects - struct definition
+ *
+ * Copyright IBM, Corp. 2011
+ * Copyright (C) 2011-2015 Red Hat, Inc.
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.  See
+ * the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QAPI_ERROR_INTERNAL_H
+
+struct Error
+{
+    char *msg;
+    ErrorClass err_class;
+    const char *src, *func;
+    int line;
+    GString *hint;
+};
+
+#endif
diff --git a/rust/wrapper.h b/rust/wrapper.h
index beddd9aab2f..6060d3ba1ab 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -60,6 +60,7 @@ typedef enum memory_order {
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
+#include "qapi/error-internal.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
diff --git a/util/error.c b/util/error.c
index 673011b89e9..e5bcb7c0225 100644
--- a/util/error.c
+++ b/util/error.c
@@ -15,15 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-
-struct Error
-{
-    char *msg;
-    ErrorClass err_class;
-    const char *src, *func;
-    int line;
-    GString *hint;
-};
+#include "qapi/error-internal.h"
 
 Error *error_abort;
 Error *error_fatal;
-- 
2.49.0


