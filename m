Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F9DCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EmB-0000Sj-Ni; Fri, 10 Oct 2025 11:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EmA-0000QS-Py
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElZ-00049j-6F
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsuDg+5N7j9JWWIAOco6bdUmkbDvZiJZ+pBxqlSdH5Q=;
 b=bKD7q7M/aUg2rlgQMokMTB0QgOy1tYx0G2qaDKhJKR9MC0hvMSWmqZ53en/4zgpxSWb181
 26mflt4VBlnbYwgjiUVh+UxRWijtt28PbioUWpBSNpi9uchSjmNqLoxrQw0NY5eOKsj40H
 /H5d35CGDWy1GexX3SISlJQlPlp5pvY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-SQZ9-khPOdS6AZGrh2nC9w-1; Fri, 10 Oct 2025 11:10:40 -0400
X-MC-Unique: SQZ9-khPOdS6AZGrh2nC9w-1
X-Mimecast-MFC-AGG-ID: SQZ9-khPOdS6AZGrh2nC9w_1760109039
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-633009e440aso2856885a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109038; x=1760713838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsuDg+5N7j9JWWIAOco6bdUmkbDvZiJZ+pBxqlSdH5Q=;
 b=Y0UHvCHW7SIqpyR+b+1lXLuPcUvsHrEn3D1MLxOCaujDRQmd+Nr8FCgstakurxs318
 80vuUEVoPT0AAJ2iMezRN18sO66xKihafM+G6F/SYCRXA0nJ6O/KgAtpRqEZLzR2Akoh
 8Gw5AiKAmVHUSvsxyg5aWje+vFnJH7yHLPKaB1l19xWoo+JiGa6Rcl/QhCWaqU1kdObK
 iTPD6JcM/mt0BIthZdyocMAkvcu/0cZ4I9UEM91AwUD73rOmZHQPHpheesZQSugcqgwK
 Ova26dYyWZH6+EzMCNYn8UuxcdnRB7YyH11ex9vHK/f44E8/dJVeyzkVupAJreHmUx4G
 y/3Q==
X-Gm-Message-State: AOJu0YyiMoZAMkPJbsqrV71MmJyR6CFX1ynDnDSvgTrYjHYyfhfE/sS7
 2yp4pxHwkejmCGw6Q9bPrwuEhPnU4zM7H95QpZZrmNwGa478b8K0+ke/WwpMnA6uOUesxchgABL
 VALzkhtB5WNKq8TSPewZXn2ypOLYG98BEPK3+RVroe4HNYszvKFwilp/Fy/LXJ6NGq5WYUtG3ED
 flfIC69sJnFKcogLE7QtEO9IvGp1HJIy7lMAS7WhPc
X-Gm-Gg: ASbGncsMxiutOwo6UKpo3YaBd8PmjyKlRDEd58RmfXpXwMdOLaGdogRcEsMvx2yplGy
 rqqKTnxoqqCjUWHzaVKApR2Vel8/snZvQhXhYhGgxyTHqO4uIeTm3jFDp0AVaQD6ZsyEZFSvseG
 jhu9uH5mucH7W6D0VRrM+ocjlwzXk50VEa4eQnh+G4r/Pfz6OPVtIMzkAX39s0iBwL0u6yoOxbi
 kS4pFx9oB1QRoRtoJ1UjhvoW8wk5Bes3/MVgD0/ss1k0N5z88xdT0UG28wKoonRwoHicM84I67j
 uWJgj4/TMq9L4o1U2Df/bZ+PvVlkdQAmR44RTbjO4FUnmSi4M/THlsAMjUQY21qBJGU7UDYVknK
 MZxWI/9U5DH3u0Saal6Q1SzWe3Cjv2HOntqsO/yHf9pPJ
X-Received: by 2002:aa7:d5cc:0:b0:61e:d2f0:5875 with SMTP id
 4fb4d7f45d1cf-639ba74b30bmr12289439a12.1.1760109038498; 
 Fri, 10 Oct 2025 08:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb7DtcVGVaEg6pEnHRjhhov0dDCAdTcxK07IMyP5zw75Xmx/jCCdYI1yEsYxCAxqiUnkiHMQ==
X-Received: by 2002:aa7:d5cc:0:b0:61e:d2f0:5875 with SMTP id
 4fb4d7f45d1cf-639ba74b30bmr12289407a12.1.1760109038044; 
 Fri, 10 Oct 2025 08:10:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c32249esm2455770a12.41.2025.10.10.08.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 12/19] rust/qobject: add Display/Debug
Date: Fri, 10 Oct 2025 17:09:57 +0200
Message-ID: <20251010151006.791038-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/qobject/mod.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 292a3c9c238..38b98fdb1e8 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -12,6 +12,7 @@
 mod serialize;
 mod serializer;
 
+use core::fmt::{self, Debug, Display};
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -256,6 +257,33 @@ fn drop(&mut self) {
     }
 }
 
+impl Display for QObject {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        // replace with a plain serializer?
+        match_qobject! { (self) =>
+            () => write!(f, "QNull"),
+            bool(b) => write!(f, "QBool({})", if b { "true" } else { "false" }),
+            i64(n) => write!(f, "QNumI64({})", n),
+            u64(n) => write!(f, "QNumU64({})", n),
+            f64(n) => write!(f, "QNumDouble({})", n),
+            CStr(s) => write!(f, "QString({})", s.to_str().unwrap_or("bad CStr")),
+            QList(_) => write!(f, "QList"),
+            QDict(_) => write!(f, "QDict"),
+        }
+    }
+}
+
+impl Debug for QObject {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let val = self.to_string();
+        f.debug_struct("QObject")
+            .field("ptr", &self.0.get())
+            .field("refcnt()", &self.refcnt())
+            .field("to_string()", &val)
+            .finish()
+    }
+}
+
 macro_rules! match_qobject {
     (@internal ($qobj:expr) =>
         $(() => $unit:expr,)?
-- 
2.51.0


