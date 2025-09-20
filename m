Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE6CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybL-0007FA-7e; Sat, 20 Sep 2025 10:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybJ-0007EQ-Ai
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybH-0005QQ-Mh
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJ3YNFEPq2/8msLkXx1NZ4U+hOxlX3VeLMqMSz14QdI=;
 b=hgQ2X7ixbrM4qSSXK571LmVtoSA9TbmsBui39p7XhiypQTlnERm4T3UEgLj9UjpJAAhXdl
 IiE5JhXEXwSmRXweK/HwuU9wuEfLZF7mZoi1NJs7TP9r5brGqnsCk5Vr0+Il+5YmiJMors
 8LlLPtQwxc69ulJ6DEJ1VM8BdPNM2nU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-6LkvF3GKM5-Tt21ys0aBRQ-1; Sat, 20 Sep 2025 10:30:05 -0400
X-MC-Unique: 6LkvF3GKM5-Tt21ys0aBRQ-1
X-Mimecast-MFC-AGG-ID: 6LkvF3GKM5-Tt21ys0aBRQ_1758378604
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45de07b831dso17774155e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378603; x=1758983403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJ3YNFEPq2/8msLkXx1NZ4U+hOxlX3VeLMqMSz14QdI=;
 b=Ucz4W5XOUqFDYpgSnOJLdkG4xzuwABYwTPlvj9BMyNpbZXV5hzOIsw+u9AQzGtPF2f
 HZgYucSnmChyU2v7WaTh/HB2bM7fZFiXGkZHtrmaxI8aLj8tw/5TsBAL/+GkH78n47XH
 Jw+OtK9gYq+ns8g5SGb1b18zeYVE/q0LePEJJd9bTPQ/lqd9bFyMVrXKKx49jfSdq8GJ
 EDdQBrwZpTyeyqwqIFd3W5fx24Uy85XaCV1LH3ejvbASltZs/m6K6Q4GT2mi748vch6d
 XxAyoIZLbTUXh2evGdNXKq1XXwZ/XJstzrFD/8KMEWSV77pERHtsMMRYkV4SR1I3OjoT
 M3AA==
X-Gm-Message-State: AOJu0YwZ5WdXiPs3PQpWQLYOS84/gFT2/4vQ2tPDhE/k44FEi7Qd+tO4
 YWsLkDX2VIQvS+/SA8Jq7gUNeZR92hzRG0B3MgulgRc5cxapsDr30OXhN8Oe+MnROacwww3e1+K
 ZKPEMPc47w/k1qfLfRUIxJtb+EgsuPJtbh5/+0/CiTUopevvatESb4GYNzMsyTFVHFcNEEKNJwO
 kHK16VadPVIUcVdbke0Gsr7mwBPLpnHxIHmZeHaNvB
X-Gm-Gg: ASbGncvRQP9rYb9VHuCNmJcuaVMVA3M1BJjGzPnmoUYGwerCwp+TgTVQhTP5PC9dF6u
 W3GAN8KXjC6ZDWWj1lvBAc5WX1ds936aj8BGIIRAZzlM792yJ2eGpEuBkR+5hESc5gnf9yTl+dB
 xypoHdS6LmiJbMgoftF53eVH3MPGAthHMaYqXJT0xiCbJKAYVkb5oG+OW78+bR1+GiK2iPsWIsl
 UnEPYY81TfuYs6m0Cr3jYbRiLBYt29MDRLZY6DLjU2Pg5pd5qRvU9XrdBycmKaqaKY63PftwaP5
 eta8hF9wQ1oEr2KoB2fLDHWF/4arVBRk0KNYJCNCCryy2SyELWhPIuYHJAxAok1m5fx4xNyyQHX
 AVNUak84lgkzC3mhZUnwTjvvEhJ7u8Xo3V3GSF8SP2KU=
X-Received: by 2002:a05:600c:1d91:b0:468:11af:782b with SMTP id
 5b1f17b1804b1-46811af793emr56247815e9.29.1758378603311; 
 Sat, 20 Sep 2025 07:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/qk76o0RmehkijCLaE4imfHrVhxw+6WVQ5uZMGzREY2hhrdZoKipoZrfdr7YlRVt3B9wLmA==
X-Received: by 2002:a05:600c:1d91:b0:468:11af:782b with SMTP id
 5b1f17b1804b1-46811af793emr56247585e9.29.1758378602834; 
 Sat, 20 Sep 2025 07:30:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f32136cdasm99628655e9.4.2025.09.20.07.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 1/7] rust: bql: add BqlRefCell::get_mut()
Date: Sat, 20 Sep 2025 16:29:52 +0200
Message-ID: <20250920142958.181910-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This method is rarely useful in QEMU due to the pervasiveness of
shared references, but add it for when a &mut BqlRefCell<> is used.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/cell.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 24ab294b60d..8a0c8c14ad4 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -580,6 +580,25 @@ pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
         }
     }
 
+    /// Returns a mutable reference to the underlying data in this cell,
+    /// while the owner already has a mutable reference to the cell.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use bql::BqlRefCell;
+    ///
+    /// let mut c = BqlRefCell::new(5);
+    ///
+    /// *c.get_mut() = 10;
+    /// ```
+    #[inline]
+    pub const fn get_mut(&mut self) -> &mut T {
+        // SAFETY: there cannot be any outstanding borrow,
+        // since `self` is mutably owned.
+        unsafe { &mut *self.as_ptr() }
+    }
+
     /// Returns a raw pointer to the underlying data in this cell.
     ///
     /// # Examples
-- 
2.51.0


