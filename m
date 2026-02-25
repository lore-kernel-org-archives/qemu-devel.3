Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079AEF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5uo-0007Fj-5F; Tue, 24 Feb 2026 22:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5un-0007FX-0M
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5uk-000859-Ge
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=MyezWHhO/AZHHiSenW27Fkk7XMcqrOeGaWCZn9/hCHxzjI+K4QkO8n6kFycQSU1ED9AcRo
 qkfftuV7xaMmZAvu57uADug+giTV8fGhoGpyYNGkPb7XMG3unNamLo7gdp5pvr+c9iO3Lc
 bvuZXOAy3opS5y0yf2RvOeBdeEeUceo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-_IUepzEaMbS0wKeI_GJJMg-1; Tue, 24 Feb 2026 22:50:13 -0500
X-MC-Unique: _IUepzEaMbS0wKeI_GJJMg-1
X-Mimecast-MFC-AGG-ID: _IUepzEaMbS0wKeI_GJJMg_1771991412
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-356236ae3c1so411051a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991412; x=1772596212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=l/fDuky2tiL1FKUjGnr1S/4trxUOKsWOpUGLHGgzdbKdFKBunY0UZpZrVOd4Sfn8/W
 okVx7LsOjAkWLyuMaGedAqzznWuIZ258Ae/JelLcV388FCe6CoY1A/bMSZ4DOmVIab3K
 ACtTkjHldkSImwEZp8/e5KXx+KyEDv1FawM+Ygt9C3/FiuuUwNx+RJszRmnbV/7vVyVt
 WztqUeyMgMtV5U9gZR3khqjXQ0jq4NURk5Mb1DN+x+2CSAZoJck4YYYSbJeKqvyb9yFJ
 rp2lL60GK9k0zqwRS8JozErwTkJLKckaji3scIb6bZ8P9OlJi86GaZAWspLsxgd+dt6Q
 PSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991412; x=1772596212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tl/hVXrG5h9KMQqt7EBB/wY/rgh04YPReYpJxV14peY=;
 b=EFiUZdc/vGXULbG/Mbiop4FwhX7HUlRQbTGcwms/TfQJVjJBXuxICzwtajuefcn/S7
 s+gtdRTrKcl9lWPVhmOei7ZqFWdCaBelTCqXcC8P88Yba/hED4dt/78yacE3rQdOY7Cc
 bVRTe3nXEfFfHIOzDqe5fs8RwY8rxbUA9zxCxlHm6eqfh+xYW0ZUZdPgeksbxBgLXJzr
 UhS39SmjlQQb4KNs2lrfKjRseVby810UbT7jLJPyxN7x00dGLGfmXya9zIwPtADvxw1R
 cuXF/W+jbl/Q3ohsVC0GG58ZaFurop6Iage9e8V/NGKm3W+ot7CBGeo36QMx/oY7lO6j
 XbOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxvSTMPommp999rszUzrWByXqGAwmvSG9wwZnmza4l7YIawtiQgFhexO3USrnoTLeYTqO4RJf+Rgc5@nongnu.org
X-Gm-Message-State: AOJu0YwYIdkKcQ5ZgQOgkIn950zWG2nHWITmP99BRJwwwFYPO9Br7etS
 YxLuxVnzn54UpZupT1k8tByXJGMyIF5NGPpCtBjjBL/TcVzBS41RsKRWeoYTkWh1cEkgtUyCDER
 fgMsmTE2t2MjTqs0ODn/YnlMMRUTQEOX2nNaTsVJxqQKyjJzltuCw761d
X-Gm-Gg: ATEYQzw4/t5lyI24Zh+Jpquo4GeNg1PGKUCf+1toOQ7mC1uhHcLKJDlvpf6Uhg7o4jj
 Tf7Z9yhkrq78FX2gE9hIH6EQ2rd7LbhQ34/x/pCS9pNjzlvfoaPaavoKMg+cyTI/sPqI7PA+viG
 xcjaDTi6P1SGU7tjM8yPDTH526uyM2RdzfCyndVcpulSSLNY23ElxU9OZz37nCY36FWN4oRQCLI
 Gm4aXa7pQ0iYriYMR+9vKkUunqZpxD86mmUrXk5Km9bwezkbKynyNqLSfDcqfwVq8BPblXiDS0v
 2DqTiyCb80qHrRDj/z6OZyWA0W6sBxkN9HVLqwN6Z+55NF7/sks1kZhmqHuuIycohky2D2+4hgP
 hyPMpXpeV+RnBQFjfMNqtHBWtSzNhdUhbHA8uG3cUK+fZS7axctVVnLg=
X-Received: by 2002:a17:90b:2801:b0:34c:ab9b:837c with SMTP id
 98e67ed59e1d1-3590089e3f8mr1848666a91.0.1771991412441; 
 Tue, 24 Feb 2026 19:50:12 -0800 (PST)
X-Received: by 2002:a17:90b:2801:b0:34c:ab9b:837c with SMTP id
 98e67ed59e1d1-3590089e3f8mr1848645a91.0.1771991412045; 
 Tue, 24 Feb 2026 19:50:12 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 01/35] i386/kvm: avoid installing duplicate msr entries in
 msr_handlers
Date: Wed, 25 Feb 2026 09:19:06 +0530
Message-ID: <20260225035000.385950-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


