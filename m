Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A241BD25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRS-0006fQ-Dc; Tue, 27 Jan 2026 00:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRR-0006fH-LD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRP-0008Hs-LG
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769490998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=bbRniVQZuq0ZR4EpvIbwWm3hB2rzbAlFwEkFetzfpdEnAgA4cBABgAugZJFN5L1odjSqCM
 0CAaChgoHtIn9U7KvZzJgnmdFKyvURwhUL/clyvo0LMJ5x0xMZAlSYpptKEDNhE+24ythy
 EMGaw6xEPlc+aAhPeD0fpw96o6+fy6g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Qu4H9H4fN3WKoISIDzyWCA-1; Tue, 27 Jan 2026 00:16:36 -0500
X-MC-Unique: Qu4H9H4fN3WKoISIDzyWCA-1
X-Mimecast-MFC-AGG-ID: Qu4H9H4fN3WKoISIDzyWCA_1769490995
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-353049e6047so3890211a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769490995; x=1770095795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=mdr0j4gmeUydHIpMIIPNGrqXJAmIN6yH/PFYZnFnr+alx6VsRUDNTFOCkH1IIg6/D3
 qN+KCbvjuS8J3a0r7LskuqGtinS5KlJ2FXt0dwgQR+wzr/M56b/7xbxxZr5ochnPmBan
 jWDGRvIb5rPfl8i6qIc986QEbakklQj/QZ6W1O1lkSgohtgaps/LgSmYHH1vizgN5vsK
 0YtbXJ3rBcbYz0jYo6CvJ2DVpYAz+OqDd/Ftrv6vXkPmRa4hbwRptDbl7vWOPzwnxENX
 YhcPrdglBQWutcI8bNN6ACgvXeZJ/l6/4DYDnCYAxgFfiM9TnPC09oP8jXhiUqWmIata
 XdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769490995; x=1770095795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=KJMJwrEeCRc7Va/RgVHYejW0NKZl+xsmfyh9Mkg3tIGifFZpodM2H4RllAueu/fiIe
 DuRIUL23uKn9cacQsqG9mNAS5rulp74vNvDHmf/Z22yUykHpJ8SMf7NLcD6+5SvVL/TG
 5x9KFGffOqguSh27vqsM+KG4DgtGEOib7Is4Ce7U0kvDipKvSNhQ6g+5ftqTjJG6qN2o
 HCVhIB7PzaEsHZPWsoeCR1WLhcxJRZzYOXr42AS0ROJkLhg67aLnbb5sE0X7kGZW0lGe
 1Ukjo31EPoiDXIGijXWRVZGQORwE0liYkUW9dqIZS/ANfBcZuPU/WzNwReJIBQNPwoj5
 VbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx70ciyKIqd54LzB7HN9Dl4AosdKjmhM6xFlWu/fyBlwLyZ0HXIs9DNVLyttoRNrjYa1Riron4SiLW@nongnu.org
X-Gm-Message-State: AOJu0Yxkyx5c0ZFll2fnMufgLjfx90cRtNEbgVMkMHf7lIKv2K3lwMyI
 NzFojC1w/86oBaXkESAuRxESfYGl6yA/7ZaOjnmhM2RS90ktRCMkktgnmReJaLPQgwMyWPFwG9Y
 85RawDLpR7jO1EtHTPekAX5ZmWCZv5rPNz6bCg2Q58POWd59mXivi87fV
X-Gm-Gg: AZuq6aJYNo7lQtAIyJo1rBaEz6BergOXBvBsspNN3XdKWjvFipmXuKqnZk3ygLNae2A
 lXY4YsOwi348QYd4RQlKUbMR2fB8PRg+ZLj8N3abtS+l0Ls9dX3ZyYiVYmfnW3KAzX416k5Enm6
 nG4zrJXUtYGrMT3sC4WZjdz+Qt4AR0JYNBuH5lCyYBMjaADoSZdzV0gtlNTeU7Xu5PSuxjnRZDR
 KBsGBG6tWZlA+TRTuANwMtyd7cCdxzjzSE4Pl5BIGXhHmaSemi2rdMhL0w7ru4n2xfdBc2BkIKX
 2cmJHE6V9lc/q+njRDtWBdrfvRqOTin6eHS7vKVE+GoV5u9KQDhEnvbsnpkcJvASmSAf0av7Hqf
 PkqkGCZXV5oYo5ijiiJEln1+O4QCNlr86wipMTW5pwQ==
X-Received: by 2002:a17:90b:5208:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-353fedae2a1mr663345a91.34.1769490995485; 
 Mon, 26 Jan 2026 21:16:35 -0800 (PST)
X-Received: by 2002:a17:90b:5208:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-353fedae2a1mr663332a91.34.1769490995166; 
 Mon, 26 Jan 2026 21:16:35 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 01/33] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Tue, 27 Jan 2026 10:45:29 +0530
Message-ID: <20260127051612.219475-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

kvm_filter_msr() does not check if an msr entry is already present in the
msr_handlers table and installs a new handler unconditionally. If the function
is called again with the same MSR, it will result in duplicate entries in the
table and multiple such calls will fill up the table needlessly. Fix that.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7b9b740a8e..3fdb2a3f62 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6043,27 +6043,33 @@ static int kvm_install_msr_filters(KVMState *s)
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr)
 {
-    int i, ret;
+    int i, ret = 0;
 
     for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
-        if (!msr_handlers[i].msr) {
+        if (msr_handlers[i].msr == msr) {
+            break;
+        } else if (!msr_handlers[i].msr) {
             msr_handlers[i] = (KVMMSRHandlers) {
                 .msr = msr,
                 .rdmsr = rdmsr,
                 .wrmsr = wrmsr,
             };
+            break;
+        }
+    }
 
-            ret = kvm_install_msr_filters(s);
-            if (ret) {
-                msr_handlers[i] = (KVMMSRHandlers) { };
-                return ret;
-            }
+    if (i == ARRAY_SIZE(msr_handlers)) {
+        ret = -EINVAL;
+        goto end;
+    }
 
-            return 0;
-        }
+    ret = kvm_install_msr_filters(s);
+    if (ret) {
+        msr_handlers[i] = (KVMMSRHandlers) { };
     }
 
-    return -EINVAL;
+ end:
+    return ret;
 }
 
 static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
-- 
2.42.0


