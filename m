Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1740D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvJ-0006QF-0s; Mon, 02 Mar 2026 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyub-000593-9E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuS-0001v9-25
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUiCCppSXUrj6OvmEjf1mYs/b824NOK2nmd/Wogyixc=;
 b=ESevOJknQveCR3Haga8k9DKiV1GtkeDNUyz4L0Tlz1AU3OWqnZ48SZu7RG4rm7tbOs+ehN
 5uC7YisTK969DaDK01C4Yu1Viezq3uihbpCawS/L1e4eiCEIHWGjq3rJa6qEhIdn2GXG/R
 vhvlyl3rT3tKmPKv9ME47OTT+VStjms=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-mfzfasL9PoWYTn-OdoPJ8Q-1; Mon, 02 Mar 2026 03:45:35 -0500
X-MC-Unique: mfzfasL9PoWYTn-OdoPJ8Q-1
X-Mimecast-MFC-AGG-ID: mfzfasL9PoWYTn-OdoPJ8Q_1772441134
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43992a50893so2799897f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441133; x=1773045933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUiCCppSXUrj6OvmEjf1mYs/b824NOK2nmd/Wogyixc=;
 b=pCiHPvzloEzTTTdEEqxxzV6yz+zOL6+QbeSF/zP3mCGUcEgh1R1fx4zWPAcpaPcesA
 B6C8z8Fa7ufiB4J5oGk+9gu5Wsj96Z5VEoVm9NqL2upk2++AjuleldyOYqg1Vu3QARcF
 kvmLvWIgwlSzOeCS7y6O1Yys2iW5KlTAm5gvcP+YP1qkJhdaTLmNlh9mqBQeHrq3hs+F
 QgNrRkBCtR+USGMyypOcloZSzrn2BuPF6YfZjQnpoZkKRyTrJW6Eee/7QQhS42wZzRzD
 njhgdA6g+54xHwS7qxOHEr8UrwMtzqmJZHk3BOVDq5nZA5GIMOGmniikDoEUOw7f2JcA
 no4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441133; x=1773045933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUiCCppSXUrj6OvmEjf1mYs/b824NOK2nmd/Wogyixc=;
 b=KAFMD8o9eSJwR380nA+uWRxmH06LwCpeTQcmZlsfCOk13aWry2B0Z3Z+0ksTf0h1ab
 Vz2jBUyrc8Xp2hCZ2EBcAGHWJOlwX6UvMG6uZsiWdpVrDBYD0Bwnw1IyL/JcqzfqtBaU
 SDRRkvFkkUJppk/gkzGpCK72yp2+dtaJBkVoPDT+Yguu0XkDV9oKKvv0RT5G9EDl6Xy7
 XktLU+qKSozLMQHQa5f/waV5w+1Div157M2zTmvJxcssX3lQDBpWn9g5rVkC+GNQA/+I
 xjx5cDyiRxm15IFa7AgY5Jk1M1RC+KM9Yf6d93IPqNeCBkFR78d46Up7HaK7WHK1mijs
 ozKQ==
X-Gm-Message-State: AOJu0YxbjkPM074TkBapK3fJtElXowVPRn83DDb0yDdg+VevCDK8OEt9
 YnM4XL4kt1lM+G4bdL5GDwB0ZNoi/gjzrUvicaHpaiUKO4LEKxjbA4W8JGU+Jtvyt92dilTMz2y
 j+fUCgr+I6FvZKLEATyxB5nTRGGbWKLs/g43JVbbpvzS1yU+jrbTsRMZOjC3FOWNXiV16KmO4TA
 DxHbzjfJicycHeP6i1sTzjcrFON+QjxXS+t8Aer3Ng
X-Gm-Gg: ATEYQzwGgdX5d1Es8mAAcO/uTLKkwuBB9naKBE+Re5Cs7Preks5xs4OzLJVc+XzZGAZ
 PbaDcKP81cQy9LfPHsiFcxdbDTxTUfhLiE3QIkljMSQLtHV7kehFEVLyFgL1zMGJtJBWbt+IIxr
 lYdgXzxgpwDbP5Yd7BILRUaFQnKGciw9UqiOELzlk8C11tZ6tMlMbYbuOXxxObuG04hmgIZH745
 WrmpTc9T6orLxTeUxbnevT6gMJQNJLI/8uWzz63HvpC0YBmpFEX4jkQ6ArPr4ubQJGvmyfeA1Nx
 PWAvcT4gRZuI6LhknlFviIIdTz4Up/Vm95BBqXmepkUxkmhl6EJR23MpixRjlLypmLCNgZyeHt0
 jewIifEBxT8zCp/JvxVT/if46B6y9i1b7+fz+cD+tf3IJrXjq8OKK4uHh2LrqYjuTaGMWM2XMkP
 1LYAByhVCg6f2sDZ6jwYBXvLrhd7o=
X-Received: by 2002:a05:6000:178d:b0:432:aa61:a06e with SMTP id
 ffacd0b85a97d-4399de2b577mr20486854f8f.32.1772441133291; 
 Mon, 02 Mar 2026 00:45:33 -0800 (PST)
X-Received: by 2002:a05:6000:178d:b0:432:aa61:a06e with SMTP id
 ffacd0b85a97d-4399de2b577mr20486800f8f.32.1772441132715; 
 Mon, 02 Mar 2026 00:45:32 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a58dasm3386241f8f.27.2026.03.02.00.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 042/102] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Mon,  2 Mar 2026 09:42:37 +0100
Message-ID: <20260302084338.473368-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

kvm_filter_msr() does not check if an msr entry is already present in the
msr_handlers table and installs a new handler unconditionally. If the function
is called again with the same MSR, it will result in duplicate entries in the
table and multiple such calls will fill up the table needlessly. Fix that.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-2-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index bb8303c39fe..c0be2e932da 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6273,27 +6273,33 @@ static int kvm_install_msr_filters(KVMState *s)
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
-
-            ret = kvm_install_msr_filters(s);
-            if (ret) {
-                msr_handlers[i] = (KVMMSRHandlers) { };
-                return ret;
-            }
-
-            return 0;
+            break;
         }
     }
 
-    return -EINVAL;
+    if (i == ARRAY_SIZE(msr_handlers)) {
+        ret = -EINVAL;
+        goto end;
+    }
+
+    ret = kvm_install_msr_filters(s);
+    if (ret) {
+        msr_handlers[i] = (KVMMSRHandlers) { };
+    }
+
+ end:
+    return ret;
 }
 
 static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
-- 
2.53.0


