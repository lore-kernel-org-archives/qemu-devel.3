Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2ACA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZTO-0006tb-7P; Mon, 08 Sep 2025 06:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZTL-0006rC-2x
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZT3-0006BT-0Q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxh7i76txSo9I5v/IAz/zxBwwm7uCe0cVuGNbgqkxec=;
 b=ffuQh/v7cYPMCM2nlTh4pxYXItpTm1Xiv41jbD08t/35nJwUX/a68x4V8pvMQ/yj3vO9Ge
 NwFrmt36xdUVH/rjuTnG4p+KmSvjVAoijN2ykU17mFusQ1KahXZ6h9jEJftWUU8D3zV4q/
 iYyFJaNZauIzUNmL+BY/t8Vms1JwHQY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-R3XsW7H5Otmoobfa2UNB_Q-1; Mon, 08 Sep 2025 06:51:18 -0400
X-MC-Unique: R3XsW7H5Otmoobfa2UNB_Q-1
X-Mimecast-MFC-AGG-ID: R3XsW7H5Otmoobfa2UNB_Q_1757328677
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3db4cfcc23eso2173809f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328675; x=1757933475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxh7i76txSo9I5v/IAz/zxBwwm7uCe0cVuGNbgqkxec=;
 b=lnLbVO4AFQwxYnT+kPdMUzJ0mm3EKq68FNJGy/nFF2B8Gp9QH62X21t9SVN0JfUlS2
 HZvy4sz9zuosiQr5sU4mT4axBmBRvMUij7Z841JfKEqgZzHb2ARuwtoSsWJqjoesgYVz
 0Q//VuffIC2w5x+3ZuMss9meGqvCHOQg7h9I7OXIdUoVVhqmCEVhiHgQK0NsqfgpNvlU
 64tbev6Y3ctaEm2wUbwafGmcJpwTn/9sbEo8IOk9cnixv4Uy/tG+4Skq4cUB8nvtXfdk
 8AisF99Z+rHZ0hU7d47aq4vbJ6o3lqetiesAV+C5P6vP4EHwgUkoqlq5stsl+f6vVMeY
 Wm4A==
X-Gm-Message-State: AOJu0YxAVWmD/uCYiGNVxvkyo4DI6+By5GDIDyxCFd2wkgiIDP4uMPfU
 LqrM70KlyAFn+6ZY7XJGwk9+FlF+eztEOKs7GbL85o/XD6WjptasiLIYoh82YP2CfvgM72Bf6uJ
 qycyQSU88BFbXlQKcbAAOQHQPA+9RdClUP6aAasGkW567qqpAM3v1uWbcy3vNjj8sp4fBGQa4gg
 hxqZCq6ZJ9M3r3UTRMr6ZJMOJqewyuK211DlOh3bZx
X-Gm-Gg: ASbGnctdyjhZZD2V6IoWOepLbOWhQbbXhhU0qtBCh90BwB0nzoHJLkxgsBFjQ/5Oece
 oh1s3geLp0tKI8hIzm80qTmtbeXs4r9XrPi7ZQXU2sxzR83xAIZbt8JfnUvJteXpDQjp9cyJqJF
 n+Kdu0SXdgfwdL+M0b8hKWgS5Nsdz+ws71CtjzvVLfSMo3f7/operPo2szBDb7irMA0GBX4J9S6
 lcxqpqwlkpLm7YbCUJ6JclMcD7kOTFGNNU27WmxLm4bNu/hwhXvYlkCo66f9MX1d07lf7M4wEk5
 nMTVrklWWsabQoXbW100rAHAmdPy3+FLQY1jnH3CZ8n6M/ZxXDKm0PbU4eiF2NAokR9uIvz7PQY
 BgVLVacnQgYBXovJuG87OJcqad9N9q1y4wc+qYX+3Ksw=
X-Received: by 2002:a5d:6d50:0:b0:3e7:471c:b11a with SMTP id
 ffacd0b85a97d-3e7471cb271mr2697445f8f.19.1757328675610; 
 Mon, 08 Sep 2025 03:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAIT2v6ogmmkj9mZRxkhb7Hu6VniDCru+dzJGOp6r9Vqb08u3l8Q19/uqhY/yfsevfcofFFw==
X-Received: by 2002:a5d:6d50:0:b0:3e7:471c:b11a with SMTP id
 ffacd0b85a97d-3e7471cb271mr2697420f8f.19.1757328675183; 
 Mon, 08 Sep 2025 03:51:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45c6faad9cfsm257874165e9.0.2025.09.08.03.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:51:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 29/33] rust: re-export qemu_macros internal helper in "bits"
Date: Mon,  8 Sep 2025 12:50:01 +0200
Message-ID: <20250908105005.2119297-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Avoid the need to import "qemu_macros".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-21-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index 1bc882fde18..d1141f7c882 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -380,14 +380,17 @@ fn from(x: $type) -> Self {
     };
 
     { $type:ty: $expr:expr } => {
-        ::qemu_macros::bits_const_internal! { $type @ ($expr) }
+        $crate::bits_const_internal! { $type @ ($expr) }
     };
 
     { $type:ty as $int_type:ty: $expr:expr } => {
-        (::qemu_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
+        ($crate::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
     };
 }
 
+#[doc(hidden)]
+pub use qemu_macros::bits_const_internal;
+
 #[cfg(test)]
 mod test {
     bits! {
-- 
2.51.0


