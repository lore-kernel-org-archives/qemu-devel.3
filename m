Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8270FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rdh-0006Wi-0f; Wed, 01 Oct 2025 03:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdY-0006UB-W3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdR-000342-If
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqplbETHKN8kfYff5lMiilXZJxaDojc2q2HQziOrxgI=;
 b=DEv0lsgwPMeFyeiT8jDy0wbBJdzgPgmzEHzAs1htofvSrDdZ61zu+wmQ1YQtmgDD6qycAl
 +7yCfzo4rYl6qW6gh7rIGGdIHLcT7HHYKvIYYYgAmtAMC6aeUKLcWGRLeOxWknwykT0DZr
 qiWs96ZgHY1uBgB9HU0e53jHIVbFhgc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-VDWh8bSzNxGfebzkFtY1Lw-1; Wed, 01 Oct 2025 03:52:17 -0400
X-MC-Unique: VDWh8bSzNxGfebzkFtY1Lw-1
X-Mimecast-MFC-AGG-ID: VDWh8bSzNxGfebzkFtY1Lw_1759305136
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d6645acd3so258483766b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305135; x=1759909935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqplbETHKN8kfYff5lMiilXZJxaDojc2q2HQziOrxgI=;
 b=l03B9R0V0osI/UVFgMu/BoPpySjf+QuuiMv96AE06TyuhBmFyZpoTKXC321nZpBfeA
 5K+C+eo+qIWgs6b9BpCAaacXA+r9+smaPk2Yx6BLnIvq9wU1Iqga1fMA+kaBTC4RFN+B
 jCJTlJGXdnG/Opr5U5NE9k1mcnKBzxwY7pQaTy5Lc0D5ARPG7g3umJiQBi0zqBIOykL7
 etUuAh4lUidaOGChmVCctE6fbkEblaDXYegWiUpYvdJtyCu8aBtN5PUaFR5E+qrRzZOh
 yEG85zjatiMsNiKFg2dNTlbh0hX4iBAN1mm7WuiCw7ICs1E2TINrI8nmYOMafgksqUrZ
 2wqA==
X-Gm-Message-State: AOJu0Yzk7PjgIpDCquOJY5K4Y8A0SYGHkG0EpCVMPUweADmMscHNsLc5
 s5fnSLqr5fP28/90BvlIgBBgXQGJTjsb/l+gzmTOrfj2gO0tsIZVZkKrSG+fXcKEpD326k9FXY9
 wA4jxX4izugm6pULku+SBSmyKv5RYW0lWxmiJ7wczHVhcN1aP6acOKwQp/MScv2OVEpAyR3e4xQ
 3khLYlLXsjYcgqqElN14tDj4206JAAYqdSIlYjKiCW
X-Gm-Gg: ASbGncszMe9TcKWittLkbYCuY+C7TqgZrsDFNwhj067u2WuapNdSoT+SK2XT75b7Zgu
 BnChR7Z3gjbAa1gDxc4zkY1tslgM2+t1aQ6rdg8nO8BC07tLSNwz5+RC6bX12xBc/3IoXIBT7mO
 kFvOotB+jmAZ2HkvDhc9dQQ9Bc0sDbuJQQm3B3UkyJFmFSrlOPvMr++royCcsAfi4riTfMcZaJb
 +1MezUwu88vbeEZ3SjTIDJJIkhEYxFkpvN7U3yLGy7dFtmTToXNLOUtv9/96N8t3FvdZ4FaxLCZ
 N6tNCudryjlREHDE7PXWpSX0CYWVdSEcmwk4I2XsIpL2Yau410N3MhtWDil1ggD0bQwl5+SeBbP
 eNXZMxINQHrsfyVJO1VGHEoXAJH6kOjCd2vJ5RmKqPF+b46ZPovo=
X-Received: by 2002:a17:907:7204:b0:b3e:8252:cd53 with SMTP id
 a640c23a62f3a-b46e3ae17admr308088766b.27.1759305135627; 
 Wed, 01 Oct 2025 00:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqoEC2AE+R1M82d+ZR1bGz6Vn7PPxnGVVucI2x8ftqesW0Wt0IyM3m72rgXXjW7M+MfZR5Sw==
X-Received: by 2002:a17:907:7204:b0:b3e:8252:cd53 with SMTP id
 a640c23a62f3a-b46e3ae17admr308086066b.27.1759305135141; 
 Wed, 01 Oct 2025 00:52:15 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634d8beedf1sm7868602a12.26.2025.10.01.00.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/11] rust: migration: do not pass raw pointer to
 VMStateDescription::fields
Date: Wed,  1 Oct 2025 09:52:01 +0200
Message-ID: <20251001075210.1042479-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass a slice instead; a function that accepts a raw pointer should
arguably be declared as unsafe.

But since it is now much easier to forget vmstate_fields!, validate the
value (at least to some extent) before passing it to C.  (Unfortunately,
doing the same for subsections would require const ptr::is_null(), which
is only stable in Rust 1.84).

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index e04b19b3c9f..319d353c311 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -424,7 +424,7 @@ macro_rules! vmstate_fields {
                 ..::common::zeroable::Zeroable::ZERO
             }
         ];
-        _FIELDS.as_ptr()
+        _FIELDS
     }}
 }
 
@@ -676,8 +676,11 @@ pub const fn unplug_pending<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F)
     }
 
     #[must_use]
-    pub const fn fields(mut self, fields: *const VMStateField) -> Self {
-        self.0.fields = fields;
+    pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
+        if fields[fields.len() - 1].flags.0 != VMStateFlags::VMS_END.0 {
+            panic!("fields are not terminated, use vmstate_fields!");
+        }
+        self.0.fields = fields.as_ptr();
         self
     }
 
-- 
2.51.0


