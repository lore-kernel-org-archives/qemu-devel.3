Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE689E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxb-00038A-IE; Wed, 18 Feb 2026 06:43:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxL-00035N-E4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxI-0007ck-8C
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=eX7bWVkydZulK/4qEA1QxQAw0NQSzOsyymH6Zt29w34STOClcxEn1G7+SIfcRFbQpi2gXL
 2v99iFOhqkDqurpnmhvWPjBY17rVOcGz5WV8LkUeVNZP+I2nRQa5s5K9J4i8o0jBr9P68y
 GfJ3OFNnn3zGBUR5CCxxISmX8w6TNk8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-mRIaz-tIOMCesekqYUjtbw-1; Wed, 18 Feb 2026 06:42:50 -0500
X-MC-Unique: mRIaz-tIOMCesekqYUjtbw-1
X-Mimecast-MFC-AGG-ID: mRIaz-tIOMCesekqYUjtbw_1771414970
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a943e214daso257831755ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414969; x=1772019769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=goCqEYbUV8kHTrgx6KOmqqMxw+WHKM5jH/JXTkqBlsg/nBsYNYJLFJN8fkeyEECE7F
 P0ohWEFFyREU3pQLfZscQcxjPFq1r65HcIk6OQbJmIYx+TxGaDjBFTe1erW6xWi0vD2P
 z9N7A3w7a/5nDurE4O4dz2PxYGof6WZ/IyB8d7qqCbpchbMn5Zd2Kfj5gGeRgdEYYsht
 43V2Af7nUM91X2ldbcYDqt7hC0XKI1pXU5NxUAsfFOIMxKxScUSb5VhO1vJ7pSuidD02
 Qtm8DthHRYcwmTJVj+m2iP+SO6lP5ekfsHlIp/if7ms6VkTIwu4KqRofKrehVuzPmR9P
 OO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414969; x=1772019769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=pRY8qCoEtgWuWjM6cgRes8JYnFIkEkSEut/SsUo3v29/8D8qbrguyEprhMhdP/q+h+
 I8bd2FVrSuqYVyEoUVkjPbkX7Vy2FfUTHBzBSkjHNo+it5pET3erZ+x3YTYu17kKW/6K
 CZ1tOTtnLD4ZrEFrUobV0owP1vOKMuqgn+1dXRTh6OkaH9rN8doWhT6ETIsrfCHN2i+4
 zji6vw7+6C129gpAY7Fnf/Njj5FcfdGLFuVqq9B0bSCrWKJpIWWmLgr3KAEEqF+iWk6m
 n5WSuxyY+Ite0gfO+NQKhe62+QTf3NMQZ/+ASbgiuBjUTCfoLxkNbyKNkYN7uFFNArkw
 SUJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtjiVIEYL6gBrYUJcf2ymn0JYmFjK4yOqk0+NRbHge+O9Z0tZsyhbSZwEU57QhDIRwup72nW6fIfYs@nongnu.org
X-Gm-Message-State: AOJu0Yw/2HwhESE3b6Kz4OXxOq5shklJAN2NIFtTS7x/loxMitXcpWKv
 ubVu9KaU9kMQUNveKDSmM6CBSvwzzsNHBWYTA1YxTQTV3BNjZF6nviOmce4c26KlsY3hz12DhnA
 MA92bjGJXVVSSpgZycNNOUXV8yn2v/XXOs+QY0HFI6lA/b+pftHYvZQRJ
X-Gm-Gg: AZuq6aIKM7tu/KIRJp5oa/EXFkejWiFPEa1p2RwyVYB3H3tPXM8njzkY6yybUKpxH2D
 2/Mb15FurcXG+lUbzdwK2kMZubF59KJT+rL0sCwA3kEcEUWvIsH9WvpXPWjzvtA7Z9iGK2FiK1Z
 cWoz+Ql8J26GbF1zQuxv8nqvuWn058CbQNpuZS3K2KC0XlCM0lx4NKHJ45vA4MfRO2xH+bP4FtW
 gPbdpZnEyW9RrHcjOxFdyNMLDGrBRcGwov2yGgpBiXeS0BcT4sfgLkP429E/yiXueMZKLhn/OVn
 2OTiLrIWxnX/KCNfHRXmM8GOJQIAhnVbpp4VxMHGcWmvx3uvti8u4fZ3CEW4dhKyhJvprSZ+/Jb
 Hioe9b2F3Wv+Ob9w8VitS82PiNWQNiGI6LYYs/oPzaAnO1VRdzCLV
X-Received: by 2002:a17:902:f60b:b0:2a0:bb05:df4f with SMTP id
 d9443c01a7336-2ab4d053111mr161183735ad.44.1771414969597; 
 Wed, 18 Feb 2026 03:42:49 -0800 (PST)
X-Received: by 2002:a17:902:f60b:b0:2a0:bb05:df4f with SMTP id
 d9443c01a7336-2ab4d053111mr161183605ad.44.1771414969251; 
 Wed, 18 Feb 2026 03:42:49 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:42:48 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 01/34] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Wed, 18 Feb 2026 17:11:54 +0530
Message-ID: <20260218114233.266178-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 9f1a4d4cbb..6d823a7991 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6278,27 +6278,33 @@ static int kvm_install_msr_filters(KVMState *s)
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


