Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A5CCA0FEB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 13:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqtmn-00037D-8d; Tue, 26 Aug 2025 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtma-00035A-J3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtmQ-0001lm-BF
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756215124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RR4g8tZJYaGJJKv2wytLuzgUMVl5cxS9qnE1E7u/Aok=;
 b=A7PZJDI/AEacaalwKGT0Cg2VNd4pHy4eiNZCotFgXUvJyfuPmpqK31qhs5LowRAxVZK8RD
 WkMCt1NFbse87/vTxWnQmSz7cZUiEeNfpkFEIHTTAHPT0N9txfUrqfL90/+K8Wm+rVgeP/
 /H6AL59wzo89sjxBFtuEzy3vOb7Pomk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-XlJcgt1KMw-iKnXx8pL7Xg-1; Tue,
 26 Aug 2025 09:32:00 -0400
X-MC-Unique: XlJcgt1KMw-iKnXx8pL7Xg-1
X-Mimecast-MFC-AGG-ID: XlJcgt1KMw-iKnXx8pL7Xg_1756215119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7640180029F; Tue, 26 Aug 2025 13:31:58 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9205E180029A; Tue, 26 Aug 2025 13:31:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/4] rust/qemu-api-macros: make derive(Object) friendly when
 missing parent
Date: Tue, 26 Aug 2025 17:31:32 +0400
Message-ID: <20250826133132.4064478-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
References: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 rust/qemu-api-macros/src/lib.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index b525d89c09..a614741889 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -85,7 +85,15 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
-    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?
+        .get(0)
+        .ok_or_else(|| {
+            Error::new(
+                input.ident.span(),
+                "#[derive(Object)] requires a parent field",
+            )
+        })?
+        .ident;
 
     Ok(quote! {
         ::qemu_api::assert_field_type!(#name, #parent,
-- 
2.50.1


