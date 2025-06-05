Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAC9C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7ZS-0003zL-V6; Thu, 05 Jun 2025 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZP-0003yF-P2
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uN7ZN-0000U8-MJ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 06:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749118293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNmC5Do3yi81y5Ng9JdAMfDVJMpEljlycID+S3omCnY=;
 b=AC+YH6qa350paetIb0GAFGrSRgMBC+zPWFTHqdsOqBeesx/Zmmi3T1PHBEUrorFIh46R/A
 BL7cV665raiPRdhF/TiUJjazGzkJ0nkZBHyWu7sHaA1nF/Vebqgv4iZIETYPkVYAXhbUdX
 /DFY0ZtFRP3dcKoIx34ja/gknvFipQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-5t4x-Ua0OLyD-phEd7G-bQ-1; Thu, 05 Jun 2025 06:11:31 -0400
X-MC-Unique: 5t4x-Ua0OLyD-phEd7G-bQ-1
X-Mimecast-MFC-AGG-ID: 5t4x-Ua0OLyD-phEd7G-bQ_1749118291
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso6607695e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 03:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749118290; x=1749723090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNmC5Do3yi81y5Ng9JdAMfDVJMpEljlycID+S3omCnY=;
 b=fZs5W/bUpxlrBL7QD/dQP4LnbZ/KmuWnTIG2zvqdXkQYfBc3SofEsSZAWdh43+eNiN
 R+3agAVrYU9ployVaSIC9DYL7M/ut5CjRdhrYE9gs8X8tUbqRxilWAljHb0V8QdP757R
 A/Own0pXzvd6pKjpmvBnfZ/Vhuazn6JeuEYsn1TJQlyC4pJ6iivjsseHWnkn6IApjl38
 IBwY1pQtb3mJMYcztuIYuA6aksMUOENBsuDs+sRPSc8qSHkdvSiDxKxKsxxcpBJxVFS+
 L3KzS5BUp9nKI6swVnh7atEe8+AsAUkCLE9HDlpTCNC8z+P9BtyBGCULzcroz0fwjTxQ
 3nZQ==
X-Gm-Message-State: AOJu0YxvQEmrhDuFnhB6rHFhmq10H1Wb6LghxeOWSYFd9xJj5UdJjEdS
 9eR3mgU11C7gpPKuYZDMjwly/pn+JdQsar11rWjC8nQjMj2bGNTefJopZNBqdnPdilkqnUOXiOJ
 vKrvIvWUNQbDfkX+MZpMzZU2LnHXAKIQ/c1Mo9+ba3XLgzW+3Dw4g4UOWA8Nk8SkPSOa6qGWj/Z
 XrIbm8isTUTm7fRDRNLokHRGO9jC79Wa1K/sgofw9i
X-Gm-Gg: ASbGncvopKumxpHYL352EKOHGbdc7Y+E1Q11MgBY586PtbiYUgBOUsbIBYCNijmTNsr
 FB3m6aid7nMsmCoNBjXP8PDyGaswFuV6t6sQNQDtNIzp0uyB2mXY618cxUvr38/dXiedmpGd1NU
 wg8skrqIs0DYc+CLA2eaAdGa//Nt4bEwnioSi9y3KNFOZk4zoAUEE4GX0BOhCImpf0e6teIv+cS
 EO+d1VG71gkU0+nQOEtxk+CkgjYEpBHqIwoQJmlFy0gkHPNMOMLmFELjrn3z0ltfqVY8en6Xrz6
 brKQl0kml18/KQ==
X-Received: by 2002:a05:600c:8b21:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-451f0b2445dmr44914705e9.28.1749118289718; 
 Thu, 05 Jun 2025 03:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGPkeZGRoWwlpWOAPwqSV4CTlLw4HFBNC3X0Hc9EfLOzc+sfCUv0SNzfbqf7xSVUhnK1XImA==
X-Received: by 2002:a05:600c:8b21:b0:441:b698:3431 with SMTP id
 5b1f17b1804b1-451f0b2445dmr44914425e9.28.1749118289295; 
 Thu, 05 Jun 2025 03:11:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a00d4sm24451285f8f.92.2025.06.05.03.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:11:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-rust@nongnu.org, armbru@redhat.com,
 mkletzan@redhat.com
Subject: [PATCH 1/3] rust: make TryFrom macro more resilient
Date: Thu,  5 Jun 2025 12:11:22 +0200
Message-ID: <20250605101124.367270-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605101124.367270-1-pbonzini@redhat.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

If the enum includes values such as "Ok", "Err", or "Error", the TryInto
macro can cause errors.  Be careful and qualify identifiers with the full
path, or in the case of TryFrom<>::Error do not use the associated type
at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 103470785e3..c18bb4e036f 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -203,8 +203,8 @@ fn derive_tryinto_body(
     Ok(quote! {
         #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
         match value {
-            #(#discriminants => Ok(#name::#discriminants),)*
-            _ => Err(value),
+            #(#discriminants => core::result::Result::Ok(#name::#discriminants),)*
+            _ => core::result::Result::Err(value),
         }
     })
 }
@@ -236,7 +236,8 @@ pub const fn from_bits(value: #repr) -> Self {
         impl core::convert::TryFrom<#repr> for #name {
             type Error = #repr;
 
-            fn try_from(value: #repr) -> Result<Self, Self::Error> {
+            #[allow(ambiguous_associated_items)]
+            fn try_from(value: #repr) -> Result<Self, #repr> {
                 #body
             }
         }
-- 
2.49.0


