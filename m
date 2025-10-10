Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A2CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EZV-0001vM-H9; Fri, 10 Oct 2025 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EZR-0001v6-WA
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EZM-0008Ne-3c
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760108282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7s9EiLhlZflinEBwM73+iJsHXRyl2pAwtAtyO0Xql9k=;
 b=gwykt5aAkOar8eCpJQ3w/tbVnGVKpr5o+VJeLqtqRL29bIdVYPPNaH30A8n5/oXKmdjni/
 u/HyqQeOvWhA82JlQQBJLtzDouGFqctY2bdRylvBolWMVFtp9OOydB+x48PGJm1tw0+XAH
 NfMab+wlOM6ZMJCKTV50iXQRPaAgoso=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-WqYpaJxyPnmr7JHMwjG5BA-1; Fri, 10 Oct 2025 10:58:01 -0400
X-MC-Unique: WqYpaJxyPnmr7JHMwjG5BA-1
X-Mimecast-MFC-AGG-ID: WqYpaJxyPnmr7JHMwjG5BA_1760108280
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-633958a757fso1739481a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760108279; x=1760713079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7s9EiLhlZflinEBwM73+iJsHXRyl2pAwtAtyO0Xql9k=;
 b=K/XajgK4LY3mR/KGBSMf1O+lBmARI3IaKAGtCB+zA8RmzR3q2nYGQ7P5Xh6jPbJQBt
 Gd2Libxqr0/hvft8yiUdTF/wRBNuH/jJwpsqtgFNg9cCcxrWQdmMlTlGNPS7BK30CrCL
 Wf8DIa6TdP4opQ8IsgB9tG7qPqyHpUv1rY0pf8mKQqef63iwyyYo9Dkj7U+9myFFHZuR
 qUcwdChNH3IMVgz3tHoQ80iZ6BKLJDOgZ24q9w185JL4lt3qPs8feBqSVSe8dnrfIlMv
 HUc6T+rSYq3yVTUBySWdRhxN0vRLJ+b7WRP5pLjn7UuWw5cdJvM6KP0zpnNL9rChsHpG
 DOVg==
X-Gm-Message-State: AOJu0YzwUsWMysBIp9kTHZyfxxB1qznKGMCBAIO7NOAWmdxkStPzThWA
 CNnkIQliawNl8IDXf0AwUQdbpc7H7mJDKPEVukbTmizI17xyaXyaPZm0GmZpO+kfuDE4vwhpeD3
 JVEs6WTkBW/C5zmid5cEBqcNxKoym5nHLHkYGx3IBW+1LkzC/Kllb/GiELPLONaSCsJhoOQX63O
 mH0bF8a7fnv39K5oYakHlY8etWy/C8tRpn1heaXwGX
X-Gm-Gg: ASbGnctY6atjjaZxYFFYWWN6fjzPsMWQ/+OLyciDWGpkqjFRTgahyNtNmsshEvaoHmg
 Um+PYncQ4zA2QG9w+TLF07pq1XQusp54jHg3+NflKXSXAUNefizrbQCpMUEixNaUPH+Dp7tG/99
 m/eS/Ryj7qFBY1ipl3LEuBpRKHIb7fbgrHl1aX1y7+kvIbRykOMwVKsS+qYwa/mk4S7gv6Ek+mb
 Tie3432iT/k2Y4dEyDMrTJZ/yDMGrbkSmLdnrxDIY4Q5y5bO16y6hL1P6+cfo3KvefamMrb7Ybj
 9DbDQm4rFDo9W7Z2BwfD/WlMtAbkL/KgZ0bXIYEDOFG+Hl9i0EIGyXornNz3yh18mV+quGJXhsi
 R1jsqh2goBLMmehwQU9raHWdBp0IurDXXQpMC1WMbNVj0
X-Received: by 2002:a05:6402:5106:b0:634:544b:a756 with SMTP id
 4fb4d7f45d1cf-639d5c59407mr10672956a12.32.1760108279317; 
 Fri, 10 Oct 2025 07:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEybSr5SrzNqJnlH+7OprsG/jjWlGw41JQiczdq4BTtPJawMSNl0jLnofWJIrFaF9HeylBD9Q==
X-Received: by 2002:a05:6402:5106:b0:634:544b:a756 with SMTP id
 4fb4d7f45d1cf-639d5c59407mr10672918a12.32.1760108278826; 
 Fri, 10 Oct 2025 07:57:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f860sm2462367a12.15.2025.10.10.07.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:57:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2] rust: bits: disable double_parens check
Date: Fri, 10 Oct 2025 16:57:56 +0200
Message-ID: <20251010145756.787800-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
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

It is showing in the output of the bits! macro when using the nightly
toolchain, though it's not clear if it is intentional or a bug.
Shut it up for now.

Link: https://github.com/rust-lang/rust-clippy/issues/15852
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/src/lib.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 3e21b67b471..9157f77a4dd 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -401,7 +401,14 @@ pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
     let ts = proc_macro2::TokenStream::from(ts);
     let mut it = ts.into_iter();
 
-    BitsConstInternal::parse(&mut it)
-        .unwrap_or_else(syn::Error::into_compile_error)
-        .into()
+    let out = BitsConstInternal::parse(&mut it)
+        .unwrap_or_else(syn::Error::into_compile_error);
+
+    // https://github.com/rust-lang/rust-clippy/issues/15852
+    quote! {
+        {
+            #[allow(clippy::double_parens)]
+            #out
+        }
+    }.into()
 }
-- 
2.51.0


