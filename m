Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA60C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiEH-00020V-KL; Fri, 17 Jan 2025 04:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEC-0001vP-UF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEB-00085p-Db
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPqO3KKHtl5ANg7/aro6hR1uN7oeqpunby/BKuICj8Q=;
 b=SqLIJGQsHuPlT6AfrKKICz0VExj78Ky4I3Fl9imPamuuBA+KDXXZDXSm3vzr1PGj2mg36a
 8FdKx1O2NlX5zly8s2qGrO2fjQU7hUiL9tyAkhBkbNQuIv9gpN6XNLmW+CNbgSFzTYQPab
 0PY4W148kASR47Fvukp9ANQtj/98ScM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-hNB8QV7_PZONVlQJyXG4Hw-1; Fri, 17 Jan 2025 04:01:16 -0500
X-MC-Unique: hNB8QV7_PZONVlQJyXG4Hw-1
X-Mimecast-MFC-AGG-ID: hNB8QV7_PZONVlQJyXG4Hw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aaf901a0ef9so164145566b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104474; x=1737709274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPqO3KKHtl5ANg7/aro6hR1uN7oeqpunby/BKuICj8Q=;
 b=H1iEvGDhCPSywU8cycOQcQRBlgCk1DKe583gja0wx2H79bF8ugF3iERFs1WENPeUE6
 GiTeBBqB8UIDQt2q/zD6adYy3Ke5/fll14RHZKoRaOTD16x5HvTK2bJeoBlJsOOQcJ78
 NWWtwTeARayRe0JJuTZZ6q1nuVf1TXJhFSA4b4r/KcibUfWLuPn9iXO8AjGoT1LCBYxZ
 FiOdcV5cCff41uIIKYTBYeTeYcBCNKfzZZkOqvBzpBqR2e1jMOx4EH8619Y41cMiakP1
 Xlu6cWVgcJqZrU1gPwkFOrDK8pUhHTmi0+wJe0UKm+rp0QIJzs1jqD5Upu2J6ZKNGEW1
 Me1w==
X-Gm-Message-State: AOJu0Yw7xZntvJYEOQzOO75vW5o2raRE/eGKd5hf8O+hqcvzOIVP6q8V
 mzjkOWBkLnlwPc78BsZof4WyVx2tKHo8daUyXZztfDeOaXTecwihZrG7xScNwGEPRmgeuUg3ORR
 VeFJtFnEYAQMjpuAzG5UR3thX9ths9t7IinIRZFIVhgEd7OSJXNeGLKlXe5unVeM3DjJ2LeiXkh
 MtSkGD9Zz0JCAhYf3P/XXNnlL2H6ARSeW/zIgFmMY=
X-Gm-Gg: ASbGncvC6QkV/j6sy+30mwwIuheuMSzlk9I1363rmyIgz6BGFWo5esJZKZCo5myhEaO
 rgdatS1DmMkSc6pRnwtBUohF6rfBBmCqLHRD8R7k47MX/RWgUZ3ZREo7eHhsqbPHO9nNI7kfg7z
 x+ZsvBrN9DSPQ0mk/GRAT9O6zMdREeQ5aLbzQSTQYYKulebsBKB3K7gw1b0wNX+0cF20SrrmRRD
 1NHGx1t1AZqhawkwHnoRSBnW5aSfrbE0OW0u0LkJQy5sNUcsDAL/0ggpdyL
X-Received: by 2002:a17:907:86a3:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-ab38b4c8520mr216833766b.54.1737104473914; 
 Fri, 17 Jan 2025 01:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqVVadJoAURPuj9qG6UA2d1Ww6Do42aCy9rlg3bBLIvmHMy9EWjTbuoQ4KFXomFtmR5sShBQ==
X-Received: by 2002:a17:907:86a3:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-ab38b4c8520mr216829166b.54.1737104473456; 
 Fri, 17 Jan 2025 01:01:13 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f223fesm135133266b.105.2025.01.17.01.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:01:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 10/10] rust: vmstate: make order of parameters consistent in
 vmstate_clock
Date: Fri, 17 Jan 2025 10:00:46 +0100
Message-ID: <20250117090046.1045010-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

Place struct_name before field_name, similar to offset_of.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs | 2 +-
 rust/qemu-api/src/vmstate.rs           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index e0d3532e956..b052d98803f 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -27,7 +27,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
     fields: vmstate_fields! {
-        vmstate_clock!(clock, PL011State),
+        vmstate_clock!(PL011State, clock),
     },
     ..Zeroable::ZERO
 };
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 70dd3c4fc48..89ca643a58f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -457,7 +457,7 @@ macro_rules! vmstate_struct {
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
 macro_rules! vmstate_clock {
-    ($field_name:ident, $struct_name:ty) => {{
+    ($struct_name:ty, $field_name:ident) => {{
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
-- 
2.47.1


