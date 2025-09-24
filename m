Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D070ECAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lor-0005Cs-7p; Wed, 24 Sep 2025 05:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loj-0004wP-FH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Lod-0004o0-Qi
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoARvTbtXhp2bZv3DG4znBAUsLqgG710YBnBSzlsqKw=;
 b=Nmx/dNHlwav4077OpN8QWmG9KdDytRfimoWna66wXKUHS7zNaIHGGHoeOR1IOcYKlr9TL6
 RCOzKeVjSnCd3IwpnfgXDJpVTga7sDVzmt1Zlb7pWWQ2PBMPMizIOoTz1aiuebpoc1n4NJ
 4ZiVYz16zQ0RBlsrsbHytdXuANxZQs4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-o-1HNM7tMW-YMeK0AqR37A-1; Wed, 24 Sep 2025 05:29:30 -0400
X-MC-Unique: o-1HNM7tMW-YMeK0AqR37A-1
X-Mimecast-MFC-AGG-ID: o-1HNM7tMW-YMeK0AqR37A_1758706169
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b25f63db20bso72702866b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706169; x=1759310969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoARvTbtXhp2bZv3DG4znBAUsLqgG710YBnBSzlsqKw=;
 b=NoXi4So0AmiC2oEk8IprNUd/xOHVYLdOaKjnBM/eEyt2LAd2m5o+s0FDAI7sZ92Y/9
 FcF2N3eY+7zQccPGB0CkOY/MjWHW+e4APObY/JjzOJNl1FGyeMYuoYrVRRuGfGOcxKYw
 EFArFaFlFnHM3S9EDzE2qJbYBvsyfKrfJ8I5P1gXaNUUcV7Rze9ZXxmzWCXrWf46+xGg
 P3p+DgWK/62fqv6vPIALaGIgbJCuULqV0MjdMaPF9iNbP/rnddsupSuEkj1kKtB0a+/j
 phjszNcRZSAS5HXaPqgkBoeg6LRnEGyxYkViVAWwkGf3hWxRkcnkm5SE/D3Js5psVqAe
 9HvA==
X-Gm-Message-State: AOJu0YyP8qPbndVW9O+mmfar92vRuHW+13cjEaWG44YNdNZEnrS1dsYi
 VbVmi3Pip7W1zxb+ChfH0fIFmzYjr9FAyLflQVIXHz4saZR/iy5sS/6heNi7ALrHhxVP9ts10Ku
 xQQEJ9zjy+Y9nSSfZydErBzDlyUEDpzpM3GhUHGpZtkWdIOktjowBtOB8+bWby656RzPRJBOa38
 ZE9B/zU0gvtEARGJmg6+THcdNorA0DkadNZu7qgJEf
X-Gm-Gg: ASbGncvV9I+GhTRBZPkWx2eTXGknVfPCOIx8EpcTHxuNFrwNpLG1xBNbJJZqX14IJL5
 W6L31kgvnjDbaa0gYJX94l05vghn37puWlHW+pYRHuJrn00ySxskdoZB+OfP0ThSZiZTWOFjbP0
 Jy3+IDXiqgo+1I2bgOcuT8bj1SluAmT4vKXcn+/9ac7pQPA+OGM5RC9EtCeVGAuxN2TCtRFG3VD
 GJVJFl0G/Q+nEByu3R7bdlQv69RP2pIE9z9xmpf7Bfk7n8HgK4x+UBPqLezliDaZZPq1YcrbqUH
 8SMDTS65uJX2/B7ZbAw321tdYpbKU3LYhMJbcOdHSGL3csYnKRRSo+/+jMKp6w4/ofqm7q7FfIe
 /1hvYKE3+w+PrfF4nMaIS4wCkz9IVdtfNbxbWT67d4bV8Fg==
X-Received: by 2002:a17:907:3eaa:b0:b04:6f77:9cff with SMTP id
 a640c23a62f3a-b32cb7827d2mr185074866b.27.1758706168698; 
 Wed, 24 Sep 2025 02:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWyGN7LuM/bvTaNp5/1TM4iQgQUquYtwycl9ti2v547UHd27XPPBCRUdBgy/x9lH+RmFsXew==
X-Received: by 2002:a17:907:3eaa:b0:b04:6f77:9cff with SMTP id
 a640c23a62f3a-b32cb7827d2mr185072166b.27.1758706168157; 
 Wed, 24 Sep 2025 02:29:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b29912fb4d2sm893729566b.14.2025.09.24.02.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/29] rust/qdev: Refine the documentation for QDevProp trait
Date: Wed, 24 Sep 2025 11:28:32 +0200
Message-ID: <20250924092850.42047-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Refine the documentation to clarify:
 * `unsfae` requires that `VALUE` must be valid.
 * using `*const` instead of `&` because the latter will cause compiler
   error.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-7-zhao1.liu@intel.com
---
 rust/hw/core/src/qdev.rs | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 3ee5b242622..2735e2b2c10 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -109,9 +109,16 @@ pub trait ResettablePhasesImpl {
 ///
 /// # Safety
 ///
-/// This trait is marked as `unsafe` because currently having a `const` refer to
-/// an `extern static` as a reference instead of a raw pointer results in this
-/// compiler error:
+/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
+/// reference to a [`bindings::PropertyInfo`].
+///
+/// Note we could not use a regular reference:
+///
+/// ```text
+/// const VALUE: &bindings::PropertyInfo = ...
+/// ```
+///
+/// because this results in the following compiler error:
 ///
 /// ```text
 /// constructing invalid value: encountered reference to `extern` static in `const`
@@ -119,7 +126,7 @@ pub trait ResettablePhasesImpl {
 ///
 /// This is because the compiler generally might dereference a normal reference
 /// during const evaluation, but not in this case (if it did, it'd need to
-/// dereference the raw pointer so this would fail to compile).
+/// dereference the raw pointer so using a `*const` would also fail to compile).
 ///
 /// It is the implementer's responsibility to provide a valid
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
-- 
2.51.0


