Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D7D49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hF-0001os-FG; Fri, 12 Dec 2025 10:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h8-0001lx-JU
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h6-0005c6-T1
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+6NaZj6uCcfjgVjpMn6N6VF0Wu9Lu6jAdnQUGrVPW0=;
 b=hY/xserBZpUR1J8nJY3qt+gcp0FFDT/KMqVfVbMd2iy8oV67GtwT9B5MVc3zX+K3V38mQ5
 8mjyj0VL1weNPC/S/7WZfge73TdRjobS+8mXKnfi60waP7RXwSZKaWxeDr5bt+qm18kmuI
 Abl6r0bAdkA33kz+6g4Nqm/Xq5mtGNM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-pFRA2Vd1NS6LV40gbHjMxg-1; Fri, 12 Dec 2025 10:04:27 -0500
X-MC-Unique: pFRA2Vd1NS6LV40gbHjMxg-1
X-Mimecast-MFC-AGG-ID: pFRA2Vd1NS6LV40gbHjMxg_1765551866
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2956cdcdc17so14640055ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551866; x=1766156666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+6NaZj6uCcfjgVjpMn6N6VF0Wu9Lu6jAdnQUGrVPW0=;
 b=IU7MwHK1MROYo9GsqHIrFsKXa9uGZDvolYeqp46ze6O1Iw7Y2ElTUYRR88N3/SQTUT
 ymQqxBxy5ka1+MlC1RPv+i98PFX52jmHi8bUtAAIoM/gPFgkE3EWcPrm9aYp7I1HWw89
 Ce94001zA6Q/MvWovHJX/79hx98AcYhkOiMZC2old3M3swALUusJ4LC2Bs4c3bUWhS2c
 VArODtlT3TrT1LEIoIkn4niVR/IKVTabASVscbj6j+rmZYSPdZ7YFGPmQeVvqaLIcwFh
 hB5rrUG+Ldt9pH1KxG5lT24ZA1Pn8vJscfgxdxa32V5deGursT8Yg7EqRfqatDnRSYgA
 0UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551866; x=1766156666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+6NaZj6uCcfjgVjpMn6N6VF0Wu9Lu6jAdnQUGrVPW0=;
 b=tGzW6wU1YIHJaWskViu+IJZZ96FunyhVUiYCzke9NattZZ7cFzD/6YmSrWqaojtmAl
 rX5+tpM7n+pKMRdqdsbv1WOxB4gaetXrJBm/8WIdG7fOJITNzeWoRVgD2DY2/Sc8/UZr
 AWE2KwaVs2u6yiwuqDRkXF3nEMIVqDNiBhJggqyQAMJ2IX3MyzTNca3UUOtoj5PfK51o
 +ZB60OeCqKWSx/jS66ZkJf60cGqKJGpR8/cm1EVN9PgB/aLpKNbaUcw+tLvkmsNHFKIS
 kaVGJj4/9R1eogqz6F/7hn0toHkRven/+5ohc0i0VJGZFuaOD4o8cD27mSxFdfykFPPm
 81RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0K0xAoCpoVxuDHpwdWM+mkpMUsr2uUIZLUtuciYbgeGpuFdy8zEMmk6TAHmOwKkMhP9URbthn7k+3@nongnu.org
X-Gm-Message-State: AOJu0YyRafJcVjqfHPKwjQtOSW0pzRCkFer3luhaY5/x9XKEuLJPSKMK
 lDZ65OyA7HWGGmOmywiOSBBe4v1u3XXXjr6dhVHtDVDqMIkJeeKylSQ6IasN2YRwvAJ3xPTl1vt
 zJO3Et+m+QoIhOh1Ndnv831XRd3tdeK2+lJGDR8zMrAlXWR22tAKOc8ce
X-Gm-Gg: AY/fxX7DLndv2QzGNPIUuhdZNF+H3U/nwz3ld18nmfu/HPkJc3Dep6khQD4T+gxsnW4
 f/aOqRymOjHt21ov6P5wyfE7xVJNr7Lujfb6MAs4H1TELnTqP8iLjpmnjpvuJGUsNkcPUsJ7pBS
 TDAFC+eyyURjQqS8m3yOASMh3UuzQxv4bEBWdaNvfytme2vrOg+PBYf0ZM+FZzrIRwGL720OgQO
 SmmCZOCCZRoVN58kVcri5aJsl7khFxLGTlo+e2PW6srgrENvIY7I4KiZKvOhh15e9cXxU/zJiHw
 7MQUuaqArCQfTtjhzysjGEiekmNxcVHYiLvCMADvfsPKjX/G4YUnu5YiJFlNjDYMFJspWO9XgB5
 r+tBwzbtQa3+q3wiVLPE1Gr6/WsCUIg8vezyQYbXeU5k=
X-Received: by 2002:a17:903:1251:b0:294:f6e2:cea1 with SMTP id
 d9443c01a7336-29f2403ae65mr20162735ad.38.1765551866240; 
 Fri, 12 Dec 2025 07:04:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV1fQTYZ+clwq9ydcPTOFwaYkLMqAp/AA+rJcxVTgTzUunLMGJFAylqzmwqrNF009OwJdo4g==
X-Received: by 2002:a17:903:1251:b0:294:f6e2:cea1 with SMTP id
 d9443c01a7336-29f2403ae65mr20162125ad.38.1765551865342; 
 Fri, 12 Dec 2025 07:04:25 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:25 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 01/28] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Fri, 12 Dec 2025 20:33:29 +0530
Message-ID: <20251212150359.548787-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

kvm_filter_msr() does not check if an msr entry is already present in the
msr_handlers table and installs a new handler unconditionally. If the function
is called again with the same MSR, it will result in duplicate entries in the
table and multiple such calls will fill up the table needlessly. Fix that.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..02819de625 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5925,27 +5925,33 @@ static int kvm_install_msr_filters(KVMState *s)
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


