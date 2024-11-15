Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FA2D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzO6-0006mn-48; Fri, 15 Nov 2024 11:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNs-0006fq-Rb
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNr-0002O7-G1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNF/kcmKbI8KDX0YtdYyqZMFkG7Dt2MJ7WbIuixbzu0=;
 b=ZT4f/eDrNSnCBcKKXAw2Mx8TXPDWn2Ok1809tzvpMfyD2Gl9o9kQ6L2v6/U8EOfcVLnxjk
 uoXBybNdVKOI7w1Lm+SJijAfwp+c1U3X9Q4dTMgtxdhwvzOC1/Lx3+Lsggew9VlrE7W23B
 bGqEdY3Pqt4eu5zcBCxZPC17GZmy/aY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-zQSW2y76OzKNC2GWNhtDeQ-1; Fri, 15 Nov 2024 11:41:21 -0500
X-MC-Unique: zQSW2y76OzKNC2GWNhtDeQ-1
X-Mimecast-MFC-AGG-ID: zQSW2y76OzKNC2GWNhtDeQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso6157915e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688878; x=1732293678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNF/kcmKbI8KDX0YtdYyqZMFkG7Dt2MJ7WbIuixbzu0=;
 b=IYFuXAWFGh2KI2FVL7dz+Gw62w1tggRzusa++5emSi6U2rhkfUjuPVRQc+cccVrbhU
 7mK1/Y67JiBg1h92SFJF21xY5MuVIMCcbqnmL9fg1wvqQ5f0RNmg1U1br/Sy75VT7Dlf
 o0hmQii46/gHLvSHSFo9tChaJbYRXqpSt/Q65GrNP/Vcx6TySY2X1285kOLows2zGdS7
 arNtVgAfBl4ioW05DbV1ENAmqR0ZIufQtlnRUUZNTG4PBzAOLvBNqV7qHmkjLRHTyaHf
 ApxNcEnlJVIUXxmXy+fOIcOl8VWYNS9gUQAtDkUblPpvKgk2WfgmmeVw5XUBfVBP1VS3
 JjAA==
X-Gm-Message-State: AOJu0YzmolDtHMGnOa1gruPyKK28kMIXOey6YZL/uXi3epJ54EoEoY6y
 OhWAvCoN1jCCuS2G0zKeuxDX4Jmp3VrnkmhUiInQVs4ncl7O6jj6MoHf6IzQwq4LAgyxpCGxN6k
 mNTkxfMYCsLWn87/pp/bRFaezFJJ6UTJThp0yFff4QYpkzza09NojOfKqjHdfterug6NLsFeGFn
 qVW3dbRKUGq3EQL6GYygQpn8f4ys9m6BeY5cOJ7IM=
X-Received: by 2002:a05:600c:35d2:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-432df71e8d0mr27732245e9.6.1731688878559; 
 Fri, 15 Nov 2024 08:41:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYIOmwqMaZc9Jpmv3POLb6H0rLNE34fZGiIM3liWc2MH5JMcADQ/llNm6desKG+DqCpuOlxQ==
X-Received: by 2002:a05:600c:35d2:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-432df71e8d0mr27732005e9.6.1731688878150; 
 Fri, 15 Nov 2024 08:41:18 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821b461a84sm4659639f8f.34.2024.11.15.08.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:41:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 12/12] rust: fix doc test syntax
Date: Fri, 15 Nov 2024 17:40:25 +0100
Message-ID: <20241115164025.1917618-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Allow "cargo test --doc" to pass.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/zeroable.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 13cdb2ccba5..6125aeed8b4 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -7,9 +7,9 @@
 /// behavior.  This trait in principle could be implemented as just:
 ///
 /// ```
-///     const ZERO: Self = unsafe {
-///         ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init()
-///     },
+/// pub unsafe trait Zeroable: Default {
+///     const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+/// }
 /// ```
 ///
 /// The need for a manual implementation is only because `zeroed()` cannot
-- 
2.47.0


