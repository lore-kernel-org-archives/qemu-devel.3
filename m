Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC346CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQG-0008B1-08; Thu, 09 Oct 2025 03:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQF-0008Aj-3J
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQ9-0004KM-11
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7iCef+6xuKmyGyRbd91CCrgKoZW7PCNqJldcVjWmVI=;
 b=cYKXyulHFBlbzG3W9E9sww6WurgynsXh+aeeONrR1SgN5AYMoBCCHwNo6k4xyWaOR+PXA0
 RP/h1nNAy6JwkNva7csybOokBSHbeClu2HT/ncggq+TmrEOk6SICjLRx5C1GeQg3QK7/3e
 XrUwa8n+IoO//OOBRZADdulusYV1J1o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-mixsM9F0P_Kg6pa_LtgDuQ-1; Thu, 09 Oct 2025 03:50:37 -0400
X-MC-Unique: mixsM9F0P_Kg6pa_LtgDuQ-1
X-Mimecast-MFC-AGG-ID: mixsM9F0P_Kg6pa_LtgDuQ_1759996237
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso558433f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996235; x=1760601035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7iCef+6xuKmyGyRbd91CCrgKoZW7PCNqJldcVjWmVI=;
 b=q2iz4Z4/jKii4LEjEpDZkbVBgN8PNoLSLL0XNOWVN7lUYt2QHr0xt4FaSngo9eWwdV
 njwHeprOEsLOsd/8hrakIp0xEUkqx12ieoI2maFYl++7TAup8n4KhnqC5Axc9BYH8UNJ
 NPit1Ma07fCPrga8Tn64rQCjQcBVqfbHqIwQGNta+BlcoDoO+qZzk7YYGWUttNbTpq6E
 jG4AcgxThGHZzyESw3aFZOvVcEQNbsWJr7gCZCNrwcPn1jdG/B7E5DrVf76jPiM7eoI3
 qRk8da9H2xTkq5rNPVY81mDLL4Fx72RwERc7Bzasmfq3+V332dE2pFZBsTaLGolOxFQW
 TGRw==
X-Gm-Message-State: AOJu0YxiSGcU78nr/mKFHXLa+FZxHl1E6ySe6IXQZ1d8SHGhbo8zrxF9
 0OY8cZ62EJr0urKH/7Y9g+HPi5Bk4ge8Ohep11mC2rFlQQ5l1xUWrRB7CJUcxyD4qyWJtvrP1Yd
 StUU9bcJYaFwVtvVkII9aqH4w2+3pIsEgfTw/t9tXZb0xd0C0Wmr49Hii+0RMzgbyFT5XIrsK25
 lCv0PkcEKD7XfccRFHrnRZQeEU5yyWTseE7tytNVDZEqQ=
X-Gm-Gg: ASbGncsntvxUtk1xnbm06xVDcI2skwF+hmqsmw9VmR0fCmvrbZZK2paDqeK1yxABgtW
 7g5NmQXuSEkrVYpiNi669bZqhTUbWA+rQ32UHfwVsZqECqHGRn8exBSN38CHGxt0d/wHdwfcQr4
 kmLGwsba4D8LrR48TuckYkynittwH81PRK+82rVGTyeAdpvqqV90254XXwuz1GD+2HsjE9Ya+EO
 6NUoIaj+kauwpcQbf3zcI1dB8tuhDb57geIaplBR1NacRWpYGW1fkCUAZ7czJxcvvMX2vYT2djT
 vNwEkqEG4yZMrWrT+HjLbC76hu9LgXkhd/NOUWoeqI6nRAfxfaOVpcwxgEbomTZGUr9leclk7c9
 exNEyqZSQmHua6oSudN7hossYSWiORLM8bC8rwqmcCevZrV6p
X-Received: by 2002:a05:600c:154a:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46fa9aa6985mr62371495e9.16.1759996235232; 
 Thu, 09 Oct 2025 00:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHic47KYD6Lyd7imfahdStKHrOl4RrBSc2ujZXUCYrnTqHN+svz2j61oAH7RXpjSmkDqNLmA==
X-Received: by 2002:a05:600c:154a:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46fa9aa6985mr62371125e9.16.1759996234701; 
 Thu, 09 Oct 2025 00:50:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb1e0f019sm13829315e9.10.2025.10.09.00.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/35] build-sys: default to host vendor for rust target triple
Date: Thu,  9 Oct 2025 09:49:54 +0200
Message-ID: <20251009075026.505715-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This fixes docker-test@alpine, which uses "alpine" vendor.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20251007134558.251670-1-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 78445cbb4b3..a467f3a2e05 100755
--- a/configure
+++ b/configure
@@ -1216,8 +1216,9 @@ fi
 if test "$rust" != disabled && test -z "$rust_target_triple"; then
   # arch and os generally matches between meson and rust
   rust_arch=$host_arch
+  # default to host vendor
+  rust_vendor=$(echo "$rust_host_triple" | cut -d'-' -f2)
   rust_os=$host_os
-  rust_machine=unknown
   rust_osvariant=
 
   # tweak rust_os if needed; also, machine and variant depend on the OS
@@ -1225,7 +1226,7 @@ if test "$rust" != disabled && test -z "$rust_target_triple"; then
   case "$host_os" in
   darwin)
     # e.g. aarch64-apple-darwin
-    rust_machine=apple
+    rust_vendor=apple
     ;;
 
   linux)
@@ -1273,13 +1274,13 @@ EOF
     ;;
 
   sunos)
-    rust_machine=pc
+    rust_vendor=pc
     rust_os=solaris
     ;;
 
   windows)
     # e.g. aarch64-pc-windows-gnullvm, x86_64-pc-windows-gnu (MSVC not supported)
-    rust_machine=pc
+    rust_vendor=pc
     if test "$host_arch" = aarch64; then
       rust_osvariant=gnullvm
     else
@@ -1310,7 +1311,7 @@ EOF
   sparc64)
     if test "$rust_os" = solaris; then
       rust_arch=sparcv9
-      rust_machine=sun
+      rust_vendor=sun
     fi
     ;;
 
@@ -1324,7 +1325,7 @@ EOF
     # e.g. aarch64-linux-android
     rust_target_triple=$rust_arch-$rust_os-$rust_osvariant
   else
-    rust_target_triple=$rust_arch-$rust_machine-$rust_os${rust_osvariant:+-$rust_osvariant}
+    rust_target_triple=$rust_arch-$rust_vendor-$rust_os${rust_osvariant:+-$rust_osvariant}
   fi
 fi
 
-- 
2.51.0


