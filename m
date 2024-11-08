Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182BED64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJN-00028f-Eq; Fri, 08 Nov 2024 13:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJG-0001yC-Gu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJE-0001xW-Ka
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz7vl/ta7wDz7MWKeB1ZugqNvFL2k59T4+vboRZ4+nc=;
 b=SvkWkm6cQMlfDdxokW6spIJ+RzM5jiLSDKBRbre09MyEpXA5KZZ7A/giGigsEJb3RFGjQ0
 ejNG5lCjOCKMHJVE6gikPiHjeCAGOctwQGjsw5pJRI5mWS/9a+hAJop/lnfaqftLbAKvng
 QGM2YfZMvn9OVqRolwFaB11AGBiXv9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-kECcr5GJM7ePn3Pr94tGgw-1; Fri, 08 Nov 2024 13:02:09 -0500
X-MC-Unique: kECcr5GJM7ePn3Pr94tGgw-1
X-Mimecast-MFC-AGG-ID: kECcr5GJM7ePn3Pr94tGgw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so16410575e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088928; x=1731693728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hz7vl/ta7wDz7MWKeB1ZugqNvFL2k59T4+vboRZ4+nc=;
 b=XOJZ6T5xmLZsnZm3rMrZe4KfCC8RX8va5seFVPcC0+v0sP/cW/w8RLLcMtBIu0hc9b
 1a0GbgzmQnNKD/7cZYgBMMHCskUbdDkRInyTGDVAYcSfE7Seu2yiXcpPM5rsyFoVYa3l
 S5u0BTC0UDRbQ7r53/u4Yc02EE2bhbkcOScho55ZekjH5gb89QF7QfgJoIGoxr0pSTtZ
 9iup1LdBBwuxk4BYmFbzcz/VmN6ZbaohVG5DMr25cVleXcM2XnqdNMKhTDEAuQ81695L
 +CvqoQDL1b8DP1H3lfFMYxiFXfr/WcwDDzXvXTvadlOPQd77AOIjtIXTFMN0WqOVFSbT
 imNw==
X-Gm-Message-State: AOJu0YyjZDerlgQIRs3kUnS1EDNIDFeoVkXWH+dSB5jupkcTQ6bOYY0u
 Qdrs29gv+VpqNlv+bZ28CHN06DJt2fGkPUQSVKgn33sN+CL5RQl5Rqh1Q6Yuy9VEc2wEGcPyNaR
 pwjyMUACHXAZQn/4lsBwde+SnG4I5Iai+uoWLa407mAQBPDJ77dDl9pE9SAttqlhUzuctNcLqar
 JX4Pk9kN5LXU+c9cGGUedtNO5v+MSVXpHHCLXjsLg=
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-432b7517aa4mr30347085e9.21.1731088927894; 
 Fri, 08 Nov 2024 10:02:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhgB0HgK/Kfy8Dc2UtI0nUDMgVvzXK7o0cV9tPZ48JounXGUUudIS5GShYGA0zbj9l50H0QA==
X-Received: by 2002:a05:600c:4f83:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-432b7517aa4mr30346575e9.21.1731088927412; 
 Fri, 08 Nov 2024 10:02:07 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35b3sm109272695e9.18.2024.11.08.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:02:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 10/11] rust: fix doc test syntax
Date: Fri,  8 Nov 2024 19:01:38 +0100
Message-ID: <20241108180139.117112-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allow "cargo test --doc" to pass.

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


