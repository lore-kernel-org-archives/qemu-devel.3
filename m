Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C451BC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWS2-0000A4-0N; Fri, 21 Feb 2025 12:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRy-0008My-QT
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRw-0001YS-Vh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGeedFex4hwcA+4WKc4T7rcitnlGc1D0mCRSihvSmdw=;
 b=UN4FwTxyQAfMZt/YZQPiWuznipXqMrgdJRTBYOKqzRsOxl+BideIXVrZLp9MGhFCOBAKqw
 mdjAfKzzjkMJGLXa5Fk1WePbBNXICVS/kJsCLdjQt+MfZxRuMVele4UVQOYOojclCZMjvu
 kW7AlEgKY4Xxq3jb1lw5BQNDYW0Q4CY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-l6xVWyGvPgyPd7DDnFshQQ-1; Fri, 21 Feb 2025 12:04:26 -0500
X-MC-Unique: l6xVWyGvPgyPd7DDnFshQQ-1
X-Mimecast-MFC-AGG-ID: l6xVWyGvPgyPd7DDnFshQQ_1740157465
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so266944066b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157465; x=1740762265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGeedFex4hwcA+4WKc4T7rcitnlGc1D0mCRSihvSmdw=;
 b=lKNidc+bu2yv22KpCu0IVz/DvfFGSWm2pYfH692qsSXj0+lkLr4n0tzH7+MwzKsMQQ
 eUaT9ZiRXre4pDvbbug57rPBJrNqfEsULlmURqJzIHaHF/pjc2tC5vAU+mI013Ngau/r
 Twg1bsjX4ShT7NrBQNqGjmJpQLr3/RYHl1uzBLiKRfVQhLWsE9gTYGjsFHJgoKHVNflj
 gDuJidpbdxFN39+Dy/bXoG2vhIsEW8cibeOhtlCGG0by5vxW00RrcZT0JnRzkarY57Hm
 rWvU3pVt15CRfTYvlnzeqQ8uu/2kqCmKvbp3kp5IiC38KqiBTnLrcHk+t4mIF6RO87EJ
 GiVQ==
X-Gm-Message-State: AOJu0Yxu+Ph+grPDGO8DU2LWBviM54CTqfgx2X9NJlUC2mQqpKYHdT1S
 YiQr+UQYavxqMvegB7ALwMsZYVmE/UHFbGJlQ0yohrZk47JyKZZP+0aJ9KoUJS5Rxr2BclUm+qB
 hLLkm/im2xSmW6828ppe2tFTWhrXxGIwaLQiAIuB2yPWoA8/aj+bSLRi2gJZ4l1sczM6ZxDBI1R
 2y+0p2qVh2AzbH6tEyytE4chuxkidNMyRV4mw/01I=
X-Gm-Gg: ASbGncujMUDZ6hQC9PJ0fgREwP/HmCQS5WP/R4Z22LYkna/5UGHHnzfoFew3nH63dPr
 HDRRWUY/t3lcX0QJCB24gdfZOhbU2Ij4Iu0vuz/NwBKg52thPcrZ4BNUKeGgm6OUgq2gclDSaU/
 5oLuFLp1blxFBfdbteaRkHE8WaGP1sIRzlJwmtIercx371xW5a4TpHAQGE5Rmze/8lQHP/FSx0Q
 tlgcqNRtpr1s9Y8s1KkbGTQcDkARwtC+hPDF6zejnfZ6Aqp/gWyd6ZEGDuqSvkF4600ha2VbTKU
 NyxW3hjadxMmn83X+So=
X-Received: by 2002:a17:907:1686:b0:abb:dbc2:bfb6 with SMTP id
 a640c23a62f3a-abbedd4df55mr796077266b.10.1740157464644; 
 Fri, 21 Feb 2025 09:04:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEECFPHS+8PObVyoFvxy1YQzPxv9V7w9Vt4je3ICUJK7nFtqsY2CGp21/qsO3xZ0JJk5hx44Q==
X-Received: by 2002:a17:907:1686:b0:abb:dbc2:bfb6 with SMTP id
 a640c23a62f3a-abbedd4df55mr796070266b.10.1740157464045; 
 Fri, 21 Feb 2025 09:04:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba910e8b11sm1394251366b.21.2025.02.21.09.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:04:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 15/15] rust: bindings: remove more unnecessary Send/Sync impls
Date: Fri, 21 Feb 2025 18:03:42 +0100
Message-ID: <20250221170342.63591-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

Send and Sync are now implemented on the opaque wrappers.  Remove them
from the bindings module, unless the structs are pure data containers
and/or have no C functions defined on them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index c3f36108bd5..3c1d297581e 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -25,15 +25,11 @@
 
 // SAFETY: these are implemented in C; the bindings need to assert that the
 // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-unsafe impl Send for BusState {}
-unsafe impl Sync for BusState {}
-
+// When bindings for character devices are introduced, this can be
+// moved to the Opaque<> wrapper in src/chardev.rs.
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for ObjectClass {}
-unsafe impl Sync for ObjectClass {}
-
 // SAFETY: this is a pure data struct
 unsafe impl Send for CoalescedMemoryRange {}
 unsafe impl Sync for CoalescedMemoryRange {}
-- 
2.48.1


