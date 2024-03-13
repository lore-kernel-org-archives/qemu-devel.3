Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFADC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 13:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkOdt-0005EI-5A; Wed, 13 Mar 2024 09:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkOdm-000589-UO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkOdj-00040C-KA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710336446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BI4HOo+y1OP8vwXu8d5yJLtE+j/ub4ZbV4dHw5pceEE=;
 b=bhqN1ZUZ3nySyWnWzUYI2ugwX+QUJXun04wz9WsP9DFr7ctO7c9qJqA1RtbxT5UnhfJdSW
 On8N96toCLewqqlgKqoGQt/B+H17LK1MbxNo9OsTlIVxApeBG+SnSFVXJwF7Ty6evucAw3
 Va/qXAd+/P+D6VHfd/un4VEr9lc+NVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-tMChy2nSOiOsiOd68MVPKA-1; Wed, 13 Mar 2024 09:27:22 -0400
X-MC-Unique: tMChy2nSOiOsiOd68MVPKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD9E800281;
 Wed, 13 Mar 2024 13:27:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E97A3C54;
 Wed, 13 Mar 2024 13:27:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 814851800D6A; Wed, 13 Mar 2024 14:27:19 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 1/3] [debug] log kvm supported cpuid
Date: Wed, 13 Mar 2024 14:27:17 +0100
Message-ID: <20240313132719.939417-2-kraxel@redhat.com>
In-Reply-To: <20240313132719.939417-1-kraxel@redhat.com>
References: <20240313132719.939417-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

---
 target/i386/kvm/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe929302..2f5e3b9febf9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -276,6 +276,20 @@ static struct kvm_cpuid2 *try_get_cpuid(KVMState *s, int max)
             exit(1);
         }
     }
+
+    {
+        int i;
+
+        for (i = 0; i < cpuid->nent; i++) {
+            fprintf(stderr, "cpuid: %8x/%d - %8x %8x %8x %8x\n",
+                    cpuid->entries[i].function,
+                    cpuid->entries[i].index,
+                    cpuid->entries[i].eax,
+                    cpuid->entries[i].ebx,
+                    cpuid->entries[i].ecx,
+                    cpuid->entries[i].edx);
+        }
+    }
     return cpuid;
 }
 
-- 
2.44.0


