Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27EECAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Lod-0004oS-Jv; Wed, 24 Sep 2025 05:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loc-0004n2-Bd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoV-0004nE-3e
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ejcUKAyx1DDoRWuve8SmmSZaJ05MRViPVUHIuBU4JY=;
 b=VhT1t8GYVFxdkgJjIZp+vzHZAtVJAVwGfkFHy+MbtbUKYFvYmeLRVYQVLDM3PgLv4xu6+v
 1MKSOsBf5Wa+/lPJsZRLNrw1QsbW4dTr99STWWVe+yXefXKOY7ACFgCB5tQRWkzD46gASB
 NxtgxJ7Xvfp/eql0W41WWwsKwH5nuts=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-BQqhbT1RNjOAVfaI6mY65g-1; Wed, 24 Sep 2025 05:29:23 -0400
X-MC-Unique: BQqhbT1RNjOAVfaI6mY65g-1
X-Mimecast-MFC-AGG-ID: BQqhbT1RNjOAVfaI6mY65g_1758706162
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b044a42959dso815380766b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706161; x=1759310961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ejcUKAyx1DDoRWuve8SmmSZaJ05MRViPVUHIuBU4JY=;
 b=FMa9NpW7Eaot1hlosS/ycoaaKSYpKlhbegM/PhXGfmpPZ9gR4NWgZtQtuFgbiS3LpA
 9m2L1V/0OeLYMWR/ZV0408zUUMudp6eT5p2oZQucGOttT9pukdPtLdv7dp13kIF+Xq0D
 kqSO1q0p6hl2frizyuBLpWXRFPEV5w3WQcPYRfLsW8ihT7/pPYIQpS6TiCbmUKLieLcr
 W9+ZYrNGghXR/3gz+/NDi439cdawVmEywACwNN/jA0EK30QtWQcaCXttI1PCuYr8FmN0
 GzE+RvtIVklOZWNX3O+7a8Kp/CiIhNq6VvF5Gjcix+rJxAnHnzh0DsudVZKAWfuAKqsW
 LXBw==
X-Gm-Message-State: AOJu0YwMJJqtCwlUuiQVlVnBn9rz9Eqba4T9NGsaxh/1dlT3vBk0TK7q
 0UUmaeaoOUaA/jJks2MF2OQQS2SDZ61QstT4qizqoINf5g+SDrJbZADUFWJMy/4RopBsB50ckJP
 4/Di24aAuwagOwSPsV4RqWCPCel5QPdSNPbIGaUWPZx+136D//diLda+zoW7zmVyNygi06lHCDB
 LZLAfemXjnl8aYnHblx7ZJ0H8ripIdgaHZuOswRN5z
X-Gm-Gg: ASbGnctF2M3gIEX+S2CiMeBVhNlq8w0h8tITm/6/ssFwExxuUqBLKbOU+2ZPMzzoP1c
 Q7jgXsq58swD1f/t3nDBu4tmMVMOLc7YjiRIzTPIRacGL0Ug2i3u7qz1294AgaKu8llIyVjPOJ+
 MFi2tpcIu50p1IB3ZpKT+ZkIqqSGK4EUjg2oyZRjpQ6S+aDk9G34Ig/5qbPTl8lmTXQnbMNm4iJ
 r3kTZM6t+h/rh08GQcepH18iR06vVhTbNsrq1kfnuslhLw74BeK4iGZyQt4019S7BOYO2DxcU7y
 ki0MO/bDaUTLLYfG7kqCLcE1WmcHB13t3DftSiRss6hG1h5EuZh57F0FIQcwHtBRz4v4ZGW8sCQ
 cv9Ai92bntK46VvjY3ULJVCaPdBLgoj9qB82nljphiNRWmQ==
X-Received: by 2002:a17:907:25ca:b0:b24:7806:b59 with SMTP id
 a640c23a62f3a-b302b4160c1mr545713466b.55.1758706160920; 
 Wed, 24 Sep 2025 02:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPR4/gPoDSSP9fNF3CCGFgfzPlERnka5KYzQMiknzSK3KvyJWuZwFeWgywQURUT59VpjS/AA==
X-Received: by 2002:a17:907:25ca:b0:b24:7806:b59 with SMTP id
 a640c23a62f3a-b302b4160c1mr545710566b.55.1758706160444; 
 Wed, 24 Sep 2025 02:29:20 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b28a990f6e1sm946869966b.37.2025.09.24.02.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 09/29] rust/qemu-macros: Fix Clippy's complaints about lambda
 parameter naming
Date: Wed, 24 Sep 2025 11:28:29 +0200
Message-ID: <20250924092850.42047-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

error: `rename` shadows a previous, unrelated binding
   --> qemu-macros/src/lib.rs:265:14
    |
265 |             |rename| -> Result<proc_macro2::TokenStream, Error> {
    |              ^^^^^^
    |
note: previous binding is here
   --> qemu-macros/src/lib.rs:245:30
    |
245 |         let DeviceProperty { rename, defval } = prop;
    |                              ^^^^^^
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#shadow_unrelated
    = note: requested on the command line with `-D clippy::shadow-unrelated`

Rename the lambda parameter to "prop_rename" to fix the above clippy
error.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-4-zhao1.liu@intel.com
---
 rust/qemu-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 7ab18061776..37e1b723bd5 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -242,8 +242,8 @@ macro_rules! str_to_c_str {
 
         let prop_name = rename.map_or_else(
             || str_to_c_str!(field_name.to_string(), field_name.span()),
-            |rename| -> Result<proc_macro2::TokenStream, Error> {
-                match rename {
+            |prop_rename| -> Result<proc_macro2::TokenStream, Error> {
+                match prop_rename {
                     DevicePropertyName::CStr(cstr_lit) => Ok(quote! { #cstr_lit }),
                     DevicePropertyName::Str(str_lit) => {
                         str_to_c_str!(str_lit.value(), str_lit.span())
-- 
2.51.0


