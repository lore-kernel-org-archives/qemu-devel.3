Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05369C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtw8-0000yK-7j; Fri, 30 May 2025 03:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw5-0000xi-UD
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw4-0006sd-1L
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4euU7urtYC8/FdRoR3xl5SEetWf8oe9lhTlN6Q0lR6c=;
 b=RmRei2dH1Yygqg3A+LUw7XzmlweM3qeWun2FX06Wk7B9qGbFantovGV2vj8NDDcYBKVb4c
 T8aQA9Kn9I4fPScMlFDVLHichcYfaPEckZO7VpwFUjCJd24rq1lRiX2cPpuHWNuxpuuXTc
 3YnBc6EJxcJ/HwPccScNFam3IDdKHSE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-XxFWpeNQPNm3uP6FQl4uRA-1; Fri, 30 May 2025 03:13:46 -0400
X-MC-Unique: XxFWpeNQPNm3uP6FQl4uRA-1
X-Mimecast-MFC-AGG-ID: XxFWpeNQPNm3uP6FQl4uRA_1748589225
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad891713195so120124666b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589224; x=1749194024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4euU7urtYC8/FdRoR3xl5SEetWf8oe9lhTlN6Q0lR6c=;
 b=eqCR/Sq8a6xF222VDlLFk8FFI24xviEoBvUqQSRyb9ZBMkOXccQ26LHAJo6axELIw2
 x7/HO6/1MJ2yEVWgnQg4tv75yCdbkrTMKH9dhde+DuzqUR8RztDRWtsdUok1KHoIxVtG
 n6iQX1BRPX+nGpAcK2Vn/CUn3aRP4LtNIby5K2G5IrHXy6YG60Z+a78BCMpKGNb5eizz
 FS5gY4UIks/PJRUW0h57mQZilUYTa9iT4Bw2R3a31wMftxmk51r/3PAyt40PN5aUEDkC
 VAYwNQ/aeRhOq0DVCbpm4m3ozRkYC5Y5Z/26/AW9uDfXyMkrv306M7idUfRvcBEMShWi
 wqcw==
X-Gm-Message-State: AOJu0YyDWgAD5JL0DJMJ97S5xYL4AGE2/NDtQdSkvnUPv/xwgG13rhqz
 z9dYPvqJHmVa3e0BdN/y1ctDg1jpyEbx57u485nTI18ncf4HtlWQnnmOKBePvT+S8j5cp2+/Bhh
 IJ22L5d42k4izrb74ZcWWtGrHQwEA83m+ZNTtTtulQvRYJfojLmfqJYfygMUrQ1+Tia5p79Sss/
 5n+u/VbwqFwCLOLOO06wjh/4L8vTQyZcWB7U5CRG96
X-Gm-Gg: ASbGncveh0qAq8LVge1o3KPzCC+AJ4xS/dCF/ZYzrdci8ANC03ZmCfM8SGJz3R7BZOU
 rffE/28gtN7fx3BUIqnUHWXqc3FXjDzGK1BhkXgkf4JL/jS4XlEKPl7pGXPPywG98mwceMzSVuT
 GQ7pMiUyq0DYpCdOh4mOUpEM1+FRx0lWQxmHPgliqfuOwBs61pGOUX9Al6nYrMgrw/KRAV4nEG8
 A7LREtlFg3pLqSiexLxSgm5b1SHoDdjk1bEpYwwevyrCz3/haaxSNU2nWsujX8exaSC5sQll6Wo
 1jgGRTDXOk9sOg==
X-Received: by 2002:a17:907:7e91:b0:ad8:9c97:c2fd with SMTP id
 a640c23a62f3a-adb322d8de5mr210215566b.17.1748589223964; 
 Fri, 30 May 2025 00:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRBpTFVZNO0ZZt1h/STIW4dglIbeCDw1v8w9EXuujT6CFA8mNenhfXgH1X2aMxIljE8TiwIw==
X-Received: by 2002:a17:907:7e91:b0:ad8:9c97:c2fd with SMTP id
 a640c23a62f3a-adb322d8de5mr210213066b.17.1748589223513; 
 Fri, 30 May 2025 00:13:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fed3dsm281027666b.12.2025.05.30.00.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/77] i386/tdx: Add property sept-ve-disable for tdx-guest
 object
Date: Fri, 30 May 2025 09:11:51 +0200
Message-ID: <20250530071250.2050910-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
EPT violation conversion to #VE on guest TD access of PENDING pages.

Some guest OS (e.g., Linux TD guest) may require this bit as 1.
Otherwise refuse to boot.

Add sept-ve-disable property for tdx-guest object, for user to configure
this bit.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-10-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json         |  8 +++++++-
 target/i386/kvm/tdx.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 3d7e11efc38..5a88d364236 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1055,10 +1055,16 @@
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
 #
+# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
+#     of EPT violation conversion to #VE on guest TD access of PENDING
+#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
+#     be set, otherwise they refuse to boot.
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
-  'data': { '*attributes': 'uint64' } }
+  'data': { '*attributes': 'uint64',
+            '*sept-ve-disable': 'bool' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 2d2d48c083e..32ba3982ff1 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -18,6 +18,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -252,6 +254,24 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
+static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return !!(tdx->attributes & TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE);
+}
+
+static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    if (value) {
+        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
+    } else {
+        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
+    }
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -272,6 +292,9 @@ static void tdx_guest_init(Object *obj)
 
     object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
                                    OBJ_PROP_FLAG_READWRITE);
+    object_property_add_bool(obj, "sept-ve-disable",
+                             tdx_guest_get_sept_ve_disable,
+                             tdx_guest_set_sept_ve_disable);
 }
 
 static void tdx_guest_finalize(Object *obj)
-- 
2.49.0


