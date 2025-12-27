Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9E3E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRj-0008G1-B9; Sat, 27 Dec 2025 04:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRa-0007NX-N2
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRZ-0004Bf-5K
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYnTTtVJ8ZUirzhAJBf/N7drNMZHzXnzITSzRmZeCzQ=;
 b=ieeiDi/1on8o+KawSZTg68WFgAIbPs0jtRe0ldHp4BE0O6llHmgOwz3kWPmQPIven3T35M
 WvX8AdbHuSIFwW8pIyGkldQe/SKMpLU34UKXjUipTU6FG8jUF1OT/RC8MgN8t6eQJTzcCY
 /yJNjgk3L+loZ4heg6Pwb0DxeVOZECw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ZF139d6oMGGnd3zPU_h3fw-1; Sat, 27 Dec 2025 04:18:34 -0500
X-MC-Unique: ZF139d6oMGGnd3zPU_h3fw-1
X-Mimecast-MFC-AGG-ID: ZF139d6oMGGnd3zPU_h3fw_1766827113
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43351575e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827113; x=1767431913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gYnTTtVJ8ZUirzhAJBf/N7drNMZHzXnzITSzRmZeCzQ=;
 b=ctL+FiiPxOQjhzJj0eNSQvP6b9rL+lkuDKHc7ksx0A4nNcVupfGLnSZkSkM93OGYdK
 YvtGR4HHWiHnarO7xX0N5BkYKP5spRkR5MT1TUUUHC7dmV7BiWjWdqlHpFn9ln2TaBCX
 N0kdWDtc8PE8I/3dW/OibZnwBmT8xq2ronasYl7EPUsgeF6j5Rbrlv2MWM1KQMMccKX1
 adqPFUwntWIbhW753g8xpPclmy5wN/cyAemfREafgamZMyyZpoClS57wroZnofTaoF0A
 bZtxFCC07ym23s9zW32UGBI/bwGHSuy9rkajnLD/PURSPUQfB2t9hDwu78iTqzm2rex2
 T9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827113; x=1767431913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gYnTTtVJ8ZUirzhAJBf/N7drNMZHzXnzITSzRmZeCzQ=;
 b=j06K4qc1YHCbO8VafDGdexyaMmcDdXI8bNoSvZmfQ1gLgBKtNCNcbi7pA2DC+cUJMe
 /vJgS5GmzD6aozMKUTqoHfoKF5jhcnh0VLEeFnIBixsRrS0Z8p3r7jcwS97ekUAs+812
 nlC9GINk+PhCKz2n60aoYlPu7+RjnFBMSJ3JCY5iV6KN58yp1wxvs8OyqG/AxXum0FPp
 OprGJdkplGJuXakq2brif7s1wEccPFm9VStv2vEcvppoAuWsRAPIdv+uaglqOeDg5G4l
 bcuAMIvkxIvWaBLgBfq5nj3W8jRDM1j7ANU6jwFkCFb/yXSRrqZ7a+eFuG8Lg+JuWEYF
 k1Ag==
X-Gm-Message-State: AOJu0YyV7KKm/2mMok+hhCBUS+go4Pz3cUBpnfKFt2peqTPAqtoIW27+
 o9GMhgCGNGsGkuzkB1NAzKAFzEM3ZiPR8onGVu6gAQAZ77SU60Q2jeuCducIF4u8v/7Ix1/tzN+
 XFqXa4p8ArjWJo3x3BCLzb593zBqdwFFiSWkGRtEp65aiVSYRIE97CA/4x+OSFbjXBXGiOC66c5
 EREBdjunmsNn0pQvEAVn3ccSGSnA9pKCetV11X75ta
X-Gm-Gg: AY/fxX6ZQHw/ZUoi0VEIUJg5C1+BqhAodn9znXIKgLHMVvSA6FMhy2wGyUHiH+Jnu2k
 GsDZFnqaJBehIwKMDGPBl2HRVhdzKLEZK9CfPPDGNhL7aSDHmRbI1fKM9Em63SEVe7vlV67uEqD
 29dMkurkZVKSNAqeHZpT88vH4bHZDeBlLkhJP0LcgpvUYXufUdxTfNoht9yxxE1iHnlNq6tx5bo
 PL1PEPvWoRz9871l6+/Bl7DRfoZ83hiIPwSJalkhvAamqkb2FyeK73URCPTOMDnisjC2ktpF3Au
 oix3I/+ulSdH3YPC3CQMFVRrD+DAv5YlZDcGJ2OUHupihlloCzkssN9hOHl5SJX9Aqlbm1NQe1V
 HweG+MOtef7nmoHKvldUfeZb+r6TRR/cLf8VIeehatD470XjmF2j4V8uptoLmyQadU42J9MIPWB
 /zLfqXjHxdRNYoty4=
X-Received: by 2002:a05:600c:45c4:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-47d403a0498mr102533075e9.4.1766827112902; 
 Sat, 27 Dec 2025 01:18:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3PZkZWKP7+DMLrY69+AvRk5rfpMchAA7oqI6Q92Nib2PHBMLFl66gzqiBhhegkJr+a90wgQ==
X-Received: by 2002:a05:600c:45c4:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-47d403a0498mr102532765e9.4.1766827112482; 
 Sat, 27 Dec 2025 01:18:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm452325335e9.14.2025.12.27.01.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 066/153] rust: timer: add bindings to timer_mod_ns and
 timer_expire_time_ns
Date: Sat, 27 Dec 2025 10:14:53 +0100
Message-ID: <20251227091622.20725-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

These are needed to implement ToMigrationStateShared for timers,
and thus allow including them in Migratable<> structs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/timer.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 829f52d111e..f8e65c9a0ac 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -10,7 +10,8 @@
 use common::{callbacks::FnCall, Opaque};
 
 use crate::bindings::{
-    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
+    self, qemu_clock_get_ns, timer_del, timer_expire_time_ns, timer_init_full, timer_mod,
+    timer_mod_ns, QEMUClockType,
 };
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
@@ -88,6 +89,19 @@ pub fn init_full<T, F>(
         }
     }
 
+    pub fn expire_time_ns(&self) -> Option<i64> {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
+        let ret = unsafe { timer_expire_time_ns(self.as_ptr()) };
+        i64::try_from(ret).ok()
+    }
+
+    pub fn modify_ns(&self, expire_time: u64) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
+        unsafe { timer_mod_ns(self.as_mut_ptr(), expire_time.try_into().unwrap()) }
+    }
+
     pub fn modify(&self, expire_time: u64) {
         // SAFETY: the only way to obtain a Timer safely is via methods that
         // take a Pin<&mut Self>, therefore the timer is pinned
-- 
2.52.0


