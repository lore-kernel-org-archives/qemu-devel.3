Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383BCCA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsN-0006Fs-Bj; Wed, 27 Aug 2025 14:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKr0-000532-F7
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqp-0005rk-82
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9niItugBwTK76KNRSSgFrZGT4hieFON52ayVP379pb8=;
 b=OmmBfaflF3lKiWtNa+mgqY0wECLYOd6ayJ57rr7+6G6eI4/ZM/mbGAsxo1aL/WxF9BYNGx
 fBIn7do/2iltZ1rKpSr2C5+iPMhL0Dk0WybM4nCcyHgu3FwizjX1Mu8UGa+KspxNat1S4p
 NN7lbMwpfqspma1guI9JMSCk22cUFgQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-ORfivGgdMuifU1GJ99Fc5w-1; Wed, 27 Aug 2025 14:26:18 -0400
X-MC-Unique: ORfivGgdMuifU1GJ99Fc5w-1
X-Mimecast-MFC-AGG-ID: ORfivGgdMuifU1GJ99Fc5w_1756319177
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b629ed73bso449545e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319176; x=1756923976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9niItugBwTK76KNRSSgFrZGT4hieFON52ayVP379pb8=;
 b=gA5Oaf7WfYUzAWlrqIPZTIdZaV35rUhctSrMibuT0ovxVkSEtirYTMc83v4Be5ttRu
 FDumZ8HCfOP5DhTKZz7USB3BAxlEOlSg5TRSnlRhMSY956YSEb/xmBgynhLfQdaV07AX
 RrBjgG5OIREd+9pm1BYJOTE5PFnBjMz809fvSHZ7fNMbDwswQZaYJzR/gkX6YRCGq9AE
 VhXg9cdtwNNEkU97ScvxZ/VkaIgLOyt7qq/NK+pjEMuLKpFHzgjMFNEWjNSz1evhxltK
 VVMKLnNNbQxhxV1zO+xQgy9pmIp5wewl2a7TRh+yIzwoB+qsWRdgbANYuGSKg2lDX88S
 afXg==
X-Gm-Message-State: AOJu0YwgvtUhd/Jd7XK1fsjXA2/3/kkUBPDcqKi1IkyoSojKwBFxwEW8
 zDHQjKsoxQ3IyPkjDkQN3Ywfz5Ecup82DV9Eo++Xoo5454PRMCrwMDrD5IEgyeQTv+omo+vAsbo
 7/MxnUkCpqsrRP2tYbd/qTs/zLqGqTDPB9ISmkZZi+Lmgxe16VDlbOGK1VY1pKz4kQ748GAJlIQ
 w+yormNs/AOghmaLENVkj9jdOz2eyyHxa3H+OdypB4
X-Gm-Gg: ASbGncsa+CWU/bcF3jYTVy1NwGvh2wjZ6rDmqxYH6mi+67vCh3Z44l7kYVlA8nF4vTl
 wZqvKGo/ImCePZId0IeHymfzoc7DuTRX30Lk7s6+fEKLsBKgx8hlH8Yw0+FXPHkOMcj55kMd1Df
 LSIFynmq3I2x+ja2HzmlrrcdDKE66FE8JP0mvxPMP+EKOds455M5j238IeiejuRMCWYCPzFTCjC
 0VDb+/ZLw+0g9rA5xzVQJvxjsGeYHDRKeE7atmAEBK7E2mmupOYA4KJIPFtMqw4Rkcy8TEAwKNI
 TXOLFFXb1I+dI5LMtvGbdgLizb64bmOvD7iquCwVg8S0jqxOJF3D+pnAZnsRpWdmbzzGgFVGLFX
 ili9q2BEeJugZaiPYvMZyW4VHShBjK78N3kVQlHoWgRE=
X-Received: by 2002:a05:600c:4511:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45b517dd3admr163523515e9.28.1756319175809; 
 Wed, 27 Aug 2025 11:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpayYBwhCuNFtb0mF7eTcoOySRQGiWJV2F1eowaZCy0H+BoaQXQRyjs2d332dv2UugkXmE1A==
X-Received: by 2002:a05:600c:4511:b0:456:10a8:ff7 with SMTP id
 5b1f17b1804b1-45b517dd3admr163523305e9.28.1756319175265; 
 Wed, 27 Aug 2025 11:26:15 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0e048asm39541335e9.11.2025.08.27.11.26.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] rust: qemu-api-macros: support matching more than one
 error
Date: Wed, 27 Aug 2025 20:25:28 +0200
Message-ID: <20250827182533.854476-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/tests.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index d6dcd62fcf6..6028cdbc4c3 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -7,9 +7,9 @@
 use super::*;
 
 macro_rules! derive_compile_fail {
-    ($derive_fn:ident, $input:expr, $error_msg:expr) => {{
+    ($derive_fn:ident, $input:expr, $($error_msg:expr),+ $(,)?) => {{
         let input: proc_macro2::TokenStream = $input;
-        let error_msg: &str = $error_msg;
+        let error_msg = &[$( quote! { ::core::compile_error! { $error_msg } } ),*];
         let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
             $derive_fn;
 
@@ -18,7 +18,7 @@ macro_rules! derive_compile_fail {
         let err = result.unwrap_err().into_compile_error();
         assert_eq!(
             err.to_string(),
-            quote! { ::core::compile_error! { #error_msg } }.to_string()
+            quote! { #(#error_msg)* }.to_string()
         );
     }};
 }
-- 
2.51.0


