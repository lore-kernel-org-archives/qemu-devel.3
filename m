Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D842C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtR-0002Xn-1U; Mon, 12 Jan 2026 08:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtM-0002RS-G4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtK-0003fq-7s
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=YpUnZz4UBx4O4CP6bPAuQuSQx5b8EFSHizJdTRBQ0dThT/LV2QbQ/j5kWBNJ63kRWIhZ3B
 we17tNNR7EbGPuAtUEhcjbcbM4pGugNku4q/HXsQxMHy6lF7n7uT5YBcOfpWwSR3951V9M
 VVbkPrzbtTpWryLOKmWUyhh06KmEJIY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-RUw7Sqn9OCSW8XGe4b2KyA-1; Mon, 12 Jan 2026 08:23:26 -0500
X-MC-Unique: RUw7Sqn9OCSW8XGe4b2KyA-1
X-Mimecast-MFC-AGG-ID: RUw7Sqn9OCSW8XGe4b2KyA_1768224206
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c52d37d346fso2155393a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224205; x=1768829005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=N5fKHg02vYbangFZsEmTc0fLClHi+j3f0pu7KevvmP3jGofl3/Tnka6FFtlLaS8Icb
 31yewKKK8pPTTMLf0Jp69hadMnIdFFf/8LTxP5Ba4sFCpM78QRXjgBwRQZf9XUVXeNY9
 ZdmAruZVkhXNgJnwhbpdQL+BVqqc0q7gDLoNzJJgWTln6NhDgoGtZkaJUH8fk47Q3Jcz
 IzLaBeZzpPB0wCIso98w4UVxwxIms4EPSk8QWGyhKYXruylw6CjMrGeKyzPkrrM1Qd/V
 2tZtSTh4aSZPh9gXs7CJxoCubjobk3p49hKKnixG6HmYp1nrad7Po+krbG8VQ/Gidhbj
 abNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224205; x=1768829005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+khot+OVhL5+e3tOQKUptJ6m/mk7Ksd4tDhst7pTHg=;
 b=ZCVkgLI/hiBddBsgWsdzH0ZpECLMQy+YQwWM7cxfnHgqT08qoEfrdMLs3HeU7y51Z5
 Kdrj9JHPGi0h0VS7wVh9y/bia4bJ5rDitwRIn0fqT6KHheDlvq8BgXuezH4TBSnb+eRa
 2auYdKA9oG+zyXTPuUqp2oh7+GLlPm5kaB1636FBpsYVkRdtwCtBaXyv+NFRWCYu8+gI
 xS6PmX3s435qvWr2quAv76fteJcALRMvtekdegDzdj1rhAzigXfBimqJTn7ydKzEgYff
 zQN8VErnJsf/L8Qmdd/l4BluwSw7eV4sFuli2vssQVXE6q32s2oNOhkOfUzBQsoLnbEr
 bTWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1bpSXs5lVExl3d8jrEQvZq+1ucPwlqH+f5ChOo1pt3HUYbv8ja5tUjAHZibcvv0UCoXgvl3cn1b6D@nongnu.org
X-Gm-Message-State: AOJu0YxiHbbOC6oQZ460wp+Y3ua0i5gQpuXAmktpe2VF0oOuYrJnmCLX
 yEaPySpLtaAzVASNF1uK8yj7NrWmgx7yv+NofcCGqCx2doizTYujiFFl67qRkIomodDQZDH9H69
 +ueJBEpwaRCbS3V7fZv+ASh8Rd9Rs6+y2uZxm8Q/+j4hIRY0hw7JWJkNvuviz32SP
X-Gm-Gg: AY/fxX4hnckQdM3dN0d9LP+9RSNxhAPvwDNfNdHi9OwUTKaF+QScu3PB8Bm60SGwMmL
 NHdRG5dX4xuRza14wK6xSzkCvFKDHcV9fBFGEPRTSPB2UVPUgwAikyV6Fy473i4RIBmlu1BSGfY
 tAVlvFQXpqhd3PJqWf+v6sQ6POvGVu+uojUS+zA7yFO+24qIOt16kpRBoTRYoIJh6JO9DQjL6Qd
 ULZH9ZpfPoHhyLDXV7lMVm47NB/jglj8pdCTYRDDuj28qFL0LSshVY6o2xbD1VmZdmShfWcTpdY
 GilIMmMJIH7ygnBbB+oaIqRI62MK5qPlPtd310T9vglmHZ8HNvJgtshD9asDtchF9kSKLDAbSzz
 nrvINcbgoyhVoh22BeW0vUvOtj8LThIxn7/g2qcr+Dsc=
X-Received: by 2002:a05:6a20:6a04:b0:389:8e40:a150 with SMTP id
 adf61e73a8af0-3898e9c82f9mr17456672637.6.1768224205502; 
 Mon, 12 Jan 2026 05:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi4Zg7KdOtP8qLyP1McM4GBBuhCcQb94iIzKBNrcIfxcUavjuesbrpptymmYu05SfJOoquaQ==
X-Received: by 2002:a05:6a20:6a04:b0:389:8e40:a150 with SMTP id
 adf61e73a8af0-3898e9c82f9mr17456651637.6.1768224205076; 
 Mon, 12 Jan 2026 05:23:25 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:24 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 01/32] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Mon, 12 Jan 2026 18:52:14 +0530
Message-ID: <20260112132259.76855-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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


