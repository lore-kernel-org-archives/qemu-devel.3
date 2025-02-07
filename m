Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD6CC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQO-0007oR-59; Fri, 07 Feb 2025 05:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQD-0007cf-Qd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQB-0004KF-Ho
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjaNShE0GYpF6KF1Wxl7XEXpF6pZfvD+oUSQf7rKQdY=;
 b=jV2Tz9IVGiFGbqScoqWtZHj99lxSG8oONKRbmS6LPf7HeegVccgkH8xBoDKQpBn/lLNJWA
 jGE4LnO7oqbTYFAKDJmpNGN50huXwXcOEJeOS7k/ABsGN3S8SfOWNumwL37PcYIuNrPRNW
 hU/Mj6kqPIYOrASoY593ct6yNyyk0RA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-RSPkADiuN06ZnFi50KAnhw-1; Fri, 07 Feb 2025 05:17:13 -0500
X-MC-Unique: RSPkADiuN06ZnFi50KAnhw-1
X-Mimecast-MFC-AGG-ID: RSPkADiuN06ZnFi50KAnhw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5da0b47115aso1969815a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923430; x=1739528230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjaNShE0GYpF6KF1Wxl7XEXpF6pZfvD+oUSQf7rKQdY=;
 b=JSGVGz3v/XKZueiStPoTDW1Xy14eI5kImQmc8NEBr5uMw4Zco5twqchM0Rgd7pCk1j
 0hLb+y9cJPG3TA3e2u7ah6SdaOhAT5lmt1A9acOIcHpEjhsSP4EMlxETXp4WzT7Dsti8
 PQrI4/vuHbQE3tdQBQ7mpxRsjDA+rNooGd8kFF1siKQxSej/Va7Umpqe08C0RUpgynVv
 2YLnNjWR8a+Ur6XhHtaeIPsKnzcjlFwbpq77MsNBK8Azs4GLxha9zTc1fWk77Y9MZvUH
 etay6TJz0T7SDyW5tCtf71xVUAD33RxAlS4DKf8fGUhVw1TzgnWSfVfPioRV2nAMYhEu
 zBTw==
X-Gm-Message-State: AOJu0Yz9DDdF/U04rNDouozl3JsJ3RBge8c9PdGKufmUSxjiIyT3gBQl
 +aQyujJ3cWqmJU8QioR9Cj7mfOp2rG8vs6ClZnsAZxZKHC8+PcKpesZ0wDmh7jicCetQLGG1nfA
 FCRtYMMvdSDy0dRB1JosZwVsq5On0qM/yUfSZ8QctfbTpdlqJvZLhe3cMKYzWFa8NpA0xzjkH1q
 385IVwnZywQ3/pvtOCDiQ2KwgtBmFlESXH6D1GKyY=
X-Gm-Gg: ASbGncsPqVoxVa02yy9s2pbcPq5+Jic4z1eHv1wTGPkXExFP5uqZGrMQEnrEV1abUyh
 glhqqgeLhuU4cXzTeBgr1xfassHlO9s+j3Bo1UHOzYbs/1p7YZBMRMlKhErnakLPOmZuoOJq2WQ
 9SlvNAlHYHzhd5ntY4exR8DGfSmMmNhavVLOYAmLoa/QSD3aGRJyGXlX/zVl6CRuIfNOBco36JP
 lYtD9ArqTI67r2Mrz2dAQtvMdB5w+IgdhFznkcbMrZq6c5txWkgrIPXRjEhp2bifcgziTE7psei
 lhPDnQ==
X-Received: by 2002:a05:6402:2106:b0:5dc:8fb1:d44d with SMTP id
 4fb4d7f45d1cf-5de450e21aamr2777324a12.31.1738923430081; 
 Fri, 07 Feb 2025 02:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYp/qCQKGqc9ALJGnFfpCzNDn5MW+i6Srj0+xOB+dOTx67uTb5tDI5ArxPFQFyZaPjizB/GA==
X-Received: by 2002:a05:6402:2106:b0:5dc:8fb1:d44d with SMTP id
 4fb4d7f45d1cf-5de450e21aamr2777286a12.31.1738923429553; 
 Fri, 07 Feb 2025 02:17:09 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b739f8sm2283300a12.6.2025.02.07.02.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:17:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 08/12] rust: bindings: add Send and Sync markers for types
 that have bindings
Date: Fri,  7 Feb 2025 11:16:19 +0100
Message-ID: <20250207101623.2443552-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is needed for the MemoryRegionOps<T> to be declared as static;
Rust requires static elements to be Sync.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 46 +++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/irq.rs      |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 8a9b821bb91..b71220113ef 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,9 +21,55 @@
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
 
+// SAFETY: these are implemented in C; the bindings need to assert that the
+// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
+unsafe impl Send for BusState {}
+unsafe impl Sync for BusState {}
+
+unsafe impl Send for CharBackend {}
+unsafe impl Sync for CharBackend {}
+
+unsafe impl Send for Chardev {}
+unsafe impl Sync for Chardev {}
+
+unsafe impl Send for Clock {}
+unsafe impl Sync for Clock {}
+
+unsafe impl Send for DeviceState {}
+unsafe impl Sync for DeviceState {}
+
+unsafe impl Send for MemoryRegion {}
+unsafe impl Sync for MemoryRegion {}
+
+unsafe impl Send for ObjectClass {}
+unsafe impl Sync for ObjectClass {}
+
+unsafe impl Send for Object {}
+unsafe impl Sync for Object {}
+
+unsafe impl Send for SysBusDevice {}
+unsafe impl Sync for SysBusDevice {}
+
+// SAFETY: this is a pure data struct
+unsafe impl Send for CoalescedMemoryRange {}
+unsafe impl Sync for CoalescedMemoryRange {}
+
+// SAFETY: these are constants and vtables; the Send and Sync requirements
+// are deferred to the unsafe callbacks that they contain
+unsafe impl Send for MemoryRegionOps {}
+unsafe impl Sync for MemoryRegionOps {}
+
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
+
+unsafe impl Send for TypeInfo {}
 unsafe impl Sync for TypeInfo {}
+
+unsafe impl Send for VMStateDescription {}
 unsafe impl Sync for VMStateDescription {}
+
+unsafe impl Send for VMStateField {}
 unsafe impl Sync for VMStateField {}
+
+unsafe impl Send for VMStateInfo {}
 unsafe impl Sync for VMStateInfo {}
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 378e5202951..638545c3a64 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -43,6 +43,9 @@ pub struct InterruptSource<T = bool>
     _marker: PhantomData<T>,
 }
 
+// SAFETY: the implementation asserts via `BqlCell` that the BQL is taken
+unsafe impl<T> Sync for InterruptSource<T> where c_int: From<T> {}
+
 impl InterruptSource<bool> {
     /// Send a low (`false`) value to the interrupt sink.
     pub fn lower(&self) {
-- 
2.48.1


