Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B4FEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ94-0007YW-Ml; Thu, 12 Feb 2026 01:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ92-0007Y5-G0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ8z-0005Bc-QN
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8BwHOpnoiGVi9W+T3Y/yleQ5+CcGtx7LvYvltU6aAQ=;
 b=DVBc2Yw1wk57S8yw5G26E8Dqz1ygHBIdy9eM6+YRQYPX04/HhkXKjVS9Qk9QAzctwra5RE
 NtSpeAgp1YcaP7dUimKyiSNKzTERbEGvymi1mbYTJ/yCcQHqpqqIE903hBRFRyBENnHU1v
 aPbG6U/wNj+OC8SWVD4fpkNeD9mMZA4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-a-SPFk0TN4q3fjUzxCdhfg-1; Thu, 12 Feb 2026 01:25:39 -0500
X-MC-Unique: a-SPFk0TN4q3fjUzxCdhfg-1
X-Mimecast-MFC-AGG-ID: a-SPFk0TN4q3fjUzxCdhfg_1770877539
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c0eb08ceso7659257a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877539; x=1771482339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8BwHOpnoiGVi9W+T3Y/yleQ5+CcGtx7LvYvltU6aAQ=;
 b=UAN+zQY+JfLio09uoKgcWMP1I6QNJO05c6gB0920/WPeRKqJeJiNQAw06o0d6PJD3C
 uPjFTk7dCjxz/3RPeJvu6yVVviA2P8xoJpfkrmerOA9ruS3FL/i5mHI1F7htzDKbjmVg
 Dhu2NNGMeMw4ZlsGmMYf2UL5dXULiC2EHFa8ty2cJubH3nqQ5s6C0JqkJwtr6YyHFw95
 WQ0Wcdy5Uwy2gGOC53TwSkCaNWw0yTYhQ3uNT1Mjtay/gN2W1nKumr+I1LiViJuffii9
 W3RoyJB3wpGsf96qnE0EMeCqccJIt9oC4HRtomOtS+gyAbI+RO9P2ppgr3gO1LvHnM6r
 GhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877539; x=1771482339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8BwHOpnoiGVi9W+T3Y/yleQ5+CcGtx7LvYvltU6aAQ=;
 b=qekuvFdgkstYxK7kjaw99LGFwO4CMH8oNlLmhTOCUZEv/2lcK6H38wOzz1LIHn2B2A
 rEkLO4W/iPg3poMCAYS2uk2g0RqsI3urjgDNXBijsUgiOlKumhx+F5x14hvSZOYe42gi
 FEQTWmUS1xJ3NZrDtBJ57WOMcVbPw9fT/1gtBcCxC+PlhgNDSeSZ8vxHNMe94Caw4ny8
 ROkkfwT2XqzCMyGzoeFTHGNNSBLryMHLoPsvfwDG6voj8xnK6tEYaYOn026l7+MvY4O/
 J43sEpA2uZNmh0Uyp5Nd1EvZLQoHne7rS6UUDOcFhMnaxY3eZK5bh2u4N0gaeLAPPsfJ
 dycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAJbo5tt1W+82An/0osGrO9TMsxp2Hxw9wB8nM80+FLvmIH6D8gbVocCmMNY89FDVLOevHXTkgmXvQ@nongnu.org
X-Gm-Message-State: AOJu0YyWzo8WS1VbM6S4tlUNIKvBXGs4Xocfk3nxeTPZlcGe5LsCbGYD
 sB8b4vfRRV/YFWWQat4CTHo2+3RcKX3K0NNWoDQ+elTV1nxIbeuqGWjJQ8vPTwNIAdZiFOGzFnt
 NKjf4wYecKnvX+5ylH5/a2O4A0ATh8Bx4+0UCeBGtkqSq9MfpkwpYNWyU
X-Gm-Gg: AZuq6aJrO4jGhfvOljUdHoXPn2jJY/rUeVZ0wUP55i5UZ+s4F0zhAo8X0usNZbJbQlF
 F3N+T+qWUY9KaaumKuNB138L3ghvlPOuhmj4n6O9mkGdiMqudo7dJBOKg4QZ9lAj44HTgjzz4J2
 CEdtVZyzSURz2d5JEKCSW+O0Ah/xsn5LY/l5gWVzaAFy04IM861r9RJRovF7/GBCIwjF77M9Mc6
 jWLhxL2QnIuNth+qWVuEGdg1wlML8AhvLPkybjZqYXw5fb6ftO9PTUCcNelTdhWn7N+UbKMb2b3
 KsYCdP3Ebh3IHqwEyebtqrLcaaR5TpquxoBKPw7BVqNQbDw7Nq4pyNos4Q6uRdTOtRjNs4UBW84
 HnTakxG0mXnj/4PrVzTvOmuSEFVbUNvXFhhV+EIw08KoeaxB2EFYeckY=
X-Received: by 2002:a17:90b:1f8b:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-35693cbd055mr1186994a91.8.1770877538770; 
 Wed, 11 Feb 2026 22:25:38 -0800 (PST)
X-Received: by 2002:a17:90b:1f8b:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-35693cbd055mr1186983a91.8.1770877538479; 
 Wed, 11 Feb 2026 22:25:38 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:38 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 01/31] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Thu, 12 Feb 2026 11:54:45 +0530
Message-ID: <20260212062522.99565-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index 0c940d4b64..da1ed3b62a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6042,27 +6042,33 @@ static int kvm_install_msr_filters(KVMState *s)
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


