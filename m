Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45610C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSPi-0008Gf-KI; Tue, 05 Mar 2024 05:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rhSPa-0008FS-Kr
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rhSPZ-0007UF-Ap
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709635958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KbJZNEr9warbU0/vfDnU1gqt6ZRkEXy95/pYSOCZa0=;
 b=Slk/Z1nIA6WgrFvczucMiW6v8uW3Mm7znTCD9vXQtw1vNwj0CUuFu0LBtxl6whKS8PDxBO
 o9iifTFqxGmwEmrX9qi11n8Ccp9CXSNAivFq8RPY1mkz0+q0nV0eiPvwF3OWOFk8q7T/Vz
 pPAg3m3S+hWdAmIxuhPO0BO/meoY1gs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-rzcLyZL0Mueab07tdBuiAw-1; Tue, 05 Mar 2024 05:52:35 -0500
X-MC-Unique: rzcLyZL0Mueab07tdBuiAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C31048007AB;
 Tue,  5 Mar 2024 10:52:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59B54C04221;
 Tue,  5 Mar 2024 10:52:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 414AC18009DB; Tue,  5 Mar 2024 11:52:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/2] [debug] log kvm supported cpuid
Date: Tue,  5 Mar 2024 11:52:32 +0100
Message-ID: <20240305105233.617131-2-kraxel@redhat.com>
In-Reply-To: <20240305105233.617131-1-kraxel@redhat.com>
References: <20240305105233.617131-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 42970ab046fa..7298822cb511 100644
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


