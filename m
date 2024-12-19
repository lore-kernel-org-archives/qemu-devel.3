Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7616DE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByy-0007hM-27; Thu, 19 Dec 2024 03:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByv-0007Qr-JV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByu-0005Il-1z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa8Jvk5XtGFb7kM38ZNsMvSHVR2vxrvQofjqZy1g3DU=;
 b=e97Xjnscg6nHZT9bb+dU7iqKvJRSnstPIWfmtW63bPApIRlc9oYN0djdxpS/m7oaP9Wd7L
 yjV+DTxOGuHbxaDZtXROwJT9unOckf9VTwIXpJEKdA0AjPm+xWAdMlnJ8Z914cOatKbBo4
 AtoxgHbSB230wlhGr3PREfoSm4eumTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-L_PL5zvBPfy9aJQIqNJoHg-1; Thu, 19 Dec 2024 03:34:01 -0500
X-MC-Unique: L_PL5zvBPfy9aJQIqNJoHg-1
X-Mimecast-MFC-AGG-ID: L_PL5zvBPfy9aJQIqNJoHg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43621907030so4126805e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597239; x=1735202039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qa8Jvk5XtGFb7kM38ZNsMvSHVR2vxrvQofjqZy1g3DU=;
 b=CGTzJ/3gMVpEL66kFz51dnLsSc9INfrxLabVdeFMuMLvj+mdxBbxuchok1/6ynfEZ7
 iPZcmB8r1KV3QKl9UyDEe2jbO6Iw0dTqhnmonxfhl78Bkm779VUs6WPb2p+ihDYGZFl8
 bZDjc0PySy0dVK104blSpMSfPzFnEPJ19eVBzLG0fM1G+IIhkOu5Er8yTEBSjw+Vw6Vb
 H29TT51mjPppOH4zO9K1HzVGVHw/JjCCZjlwAODOZ8jqGBIvPa+J/TvuBQBVA8pSUlAg
 5v9kZs453qVTRKviRI6tnPM0V6NSb2xzC4Jcyd3gKMb+6LVd6Fe7/7WEPJ3PiisbbYSZ
 Ncww==
X-Gm-Message-State: AOJu0YxcUbO645ATjICzJd1KTa1UarPpyAMmCBkLb50c5l8ulkzhsyZm
 JbMDxgNSgpCzpr2W+ZOFc7xpKhn12RRGCQtNklRc4Y/Wj4+4zrzLjxc+s2ndoSA/er+l/4v1KZf
 2hM6CLLjOByKfNjLeFrQ4QzCRXxJTDUEArTtGYMc4msoCooIEO8XcCTqwbUercTuT5KdwXmye5d
 3uwEbFBxremRI2JwwZJMJaHWPAdxmE2YeUSUr3
X-Gm-Gg: ASbGncu+/9JWOjuQv+GGgkd1E+JuRWyoDNhNl72jbdWiZ/6GdCcxLWYDn1K5SyQH9iI
 KOsAWkAEtLsAX4hvEMMTQrpERNJnwjvZcL4h2DdEHhcMqohPJ9t5/HH1ghVoFLFYYHcMeMeNHZn
 hww09WkUgccWANGWdV4dhLZSx9Hgpahgd7FSbVZHp/JZWH9Aw9l2XHGYi+7soUGvoZ6T6PPBTBu
 O8aIbZF5rBxFbnsmJo66Pieg5gqKAhrwjc0+J8bmYzrxbBtHlnwloq6AnED
X-Received: by 2002:a05:600c:46c9:b0:432:d735:cc71 with SMTP id
 5b1f17b1804b1-4365c7c8eb7mr16230625e9.25.1734597239049; 
 Thu, 19 Dec 2024 00:33:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF45Ik7RTEUR17b+ZfqI4y/Tc3WtLm5baMZZoY7kwAtEbBTIdaxeia4hBTRioVAThkNx5aaQw==
X-Received: by 2002:a05:600c:46c9:b0:432:d735:cc71 with SMTP id
 5b1f17b1804b1-4365c7c8eb7mr16230445e9.25.1734597238677; 
 Thu, 19 Dec 2024 00:33:58 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c4esm45213695e9.4.2024.12.19.00.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 41/41] rust: pl011: simplify handling of the FIFO enabled bit
 in LCR
Date: Thu, 19 Dec 2024 09:32:28 +0100
Message-ID: <20241219083228.363430-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Use ==/!= instead of going through bool and xor.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++----
 rust/hw/char/pl011/src/lib.rs    | 6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4d620b442ed..18cc122951d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -302,9 +302,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
             Ok(LCR_H) => {
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
-                if bool::from(self.line_control.fifos_enabled())
-                    ^ bool::from(new_val.fifos_enabled())
-                {
+                if self.line_control.fifos_enabled() != new_val.fifos_enabled() {
                     self.reset_rx_fifo();
                     self.reset_tx_fifo();
                 }
@@ -497,7 +495,7 @@ pub fn event(&mut self, event: QEMUChrEvent) {
 
     #[inline]
     pub fn fifo_enabled(&self) -> bool {
-        matches!(self.line_control.fifos_enabled(), registers::Mode::FIFO)
+        self.line_control.fifos_enabled() == registers::Mode::FIFO
     }
 
     #[inline]
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 0747e130cae..69064d6929b 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -419,12 +419,6 @@ pub enum Mode {
         FIFO = 1,
     }
 
-    impl From<Mode> for bool {
-        fn from(val: Mode) -> Self {
-            matches!(val, Mode::FIFO)
-        }
-    }
-
     #[bitsize(2)]
     #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
     /// `WLEN` Word length, field of [Line Control register](LineControl).
-- 
2.47.1


