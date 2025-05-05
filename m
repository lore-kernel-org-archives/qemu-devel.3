Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B93AC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrlJ-0003ex-8F; Mon, 05 May 2025 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrl3-0003c3-GY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkz-0005m5-9x
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRtlT+rfQp/A6Zs87LxR8mcqRVthqez4BmiYWwSHafw=;
 b=e1Zzg4tbX09QbcOs/xPwcqGuHa4QNul7eI4q/1CTBL2gi8nUlO6qy8mBxY04urkqJwPI61
 degWQMWmb49DZ/YuAD9978eizHg+VXPsBT6an/MaWIdfzth5ckrILjm53dIBJK01AO6HBd
 nIZKctwRi5FK1pT3XBhxxrOqpIyENVA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-O_kU_q-WP_OJvkCb0ekMNQ-1; Mon, 05 May 2025 05:04:59 -0400
X-MC-Unique: O_kU_q-WP_OJvkCb0ekMNQ-1
X-Mimecast-MFC-AGG-ID: O_kU_q-WP_OJvkCb0ekMNQ_1746435898
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39130f02631so1034030f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435897; x=1747040697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRtlT+rfQp/A6Zs87LxR8mcqRVthqez4BmiYWwSHafw=;
 b=MBQOc6wVpi/w7eNvT8edhxL0nCFjpGjiBA3aQgZa33G1M11w7AW9k8em6J0kWaAk8D
 wHyWBWzYS2qhT3fl+UnJAgoUQeeExBI3z1jfiCYQNTTX+u09ptG5QDw5N1dmRO8NT4FC
 rQgFwdZ2nJzowWtasZQESO/u0poxaO+UG8QsNHmofVTdVPQgftN8uaN+yGipwUyE1hrv
 DCkMSLRT/XjCJAVzoC2c/3Q32lhYd0juyFjZnJl41r9aGdUKv4X4vmRVjkRg+2gM3vjT
 UbetoXtV0+VYFeibjZsGsO7GkTl0TUkXTrniQ/73RsKUp+2MB5K7tMyB+7En07Vxm+15
 wy8g==
X-Gm-Message-State: AOJu0YxZXY3PEdxreIhMkftpRphv3VIwW6Bmq4Fv1CZ3gmY9MFN1zvmX
 0UQDE77PsvgYjdBo59AfeCaWSc1PSJPofJxKOc7lXLmmBYIPuLkGVfW+QU5+k5oLqp1m6w8wEEe
 9iqwfi0Q7lV8h1zq7uZhw+hSXKsR4KhRC+S5OHe49dkCyP1rA93xcrbKv+XWuVCzitd09g283vt
 4eNnOIYi3wim8+yBc4Tcr/Mzfx+P4d35CfI+uF
X-Gm-Gg: ASbGncvyNfWoT490/pJhR75nUBVxZuy/ERKxLksqw4J8hMYeyLWS75vJVfb+eUSI/5a
 qQjF4gczV8X9IkcV8Yxuki7U7Aek9zNmgfiWMQp64fY8HU8VZ9JBWULpGFmU8Tofh/VYUsi2Gwr
 U4GCICP2nnLw6sF3Iou8usOrRR2exjZa21Cji5lgXv5yHPi9vfboI8hKCIL9CCmC8aP8jIOZThu
 eu78VBakfag22JcHjkGGK9j+F2ctDiuUGrMd20Pz3f3zb7RaWcKogECrGhqx/iYI2boTD0GsFN0
 V+eBdm8hK+y81DA=
X-Received: by 2002:a05:6000:3113:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a099ad1aa7mr10556841f8f.1.1746435896897; 
 Mon, 05 May 2025 02:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoTVyw8OSZzdXGEOBTSx3zPlsaB4qmHKSedrUa2N0vO7aivae0TFHtWZww5UkTGV9cxyFYyA==
X-Received: by 2002:a05:6000:3113:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a099ad1aa7mr10556810f8f.1.1746435896554; 
 Mon, 05 May 2025 02:04:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ffcasm9765797f8f.74.2025.05.05.02.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 07/11] rust: qom: fix TODO about zeroability of classes
Date: Mon,  5 May 2025 11:04:32 +0200
Message-ID: <20250505090438.24992-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The proposed suggestion is not correct.  First it is not necessary for
*all* classes to be Zeroable, only for Rust-defined ones; classes
defined in C never implement ObjectImpl.

Second, the parent class field need not be Zeroable.  For example,
ChardevClass's chr_write and chr_be_event fields cannot be NULL,
therefore ChardevClass cannot be Zeroable.  However, char_class_init()
initializes them, therefore ChardevClass could be subclassed by Rust code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 6929e4d33ae..52e3a1ec981 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -534,9 +534,10 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// While `klass`'s parent class is initialized on entry, the other fields
     /// are all zero; it is therefore assumed that all fields in `T` can be
     /// zeroed, otherwise it would not be possible to provide the class as a
-    /// `&mut T`.  TODO: add a bound of [`Zeroable`](crate::zeroable::Zeroable)
-    /// to T; this is more easily done once Zeroable does not require a manual
-    /// implementation (Rust 1.75.0).
+    /// `&mut T`.  TODO: it may be possible to add an unsafe trait that checks
+    /// that all fields *after the parent class* (but not the parent class
+    /// itself) are Zeroable.  This unsafe trait can be added via a derive
+    /// macro.
     const CLASS_INIT: fn(&mut Self::Class);
 }
 
-- 
2.49.0


