Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A8AD216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNu-0008M9-2W; Tue, 15 Oct 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNe-0007eH-2q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNb-0003Ny-Ei
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pffMq5HlyyQSLR32u36d0WlErfpMZsApxMOlecv7nh0=;
 b=TOm/wJtSlR4rS82ruG3BfXtTMl8N9Fa4/TDVME6nQOOkul+vNEPmRfyNSR95a6BHDV+uRB
 wAi8P+gnKeV3H/I0dr7WHrvVSYRxahH+q46OsYuVvZSnv5gXoMO9aIhXOY3jxNaBYC7ykK
 rI8P1PWoKA/npLVOqlRmaPOHtjz20YY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-00TvkT8DMaOkx_Xb3GmFvg-1; Tue, 15 Oct 2024 10:18:29 -0400
X-MC-Unique: 00TvkT8DMaOkx_Xb3GmFvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so2743337f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001908; x=1729606708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pffMq5HlyyQSLR32u36d0WlErfpMZsApxMOlecv7nh0=;
 b=vdo2Ip7HntmfuG9r4x+N7mSYJKvhJ9QDf8Dc0RXt5WA/sor8tuxyGrSCq17gTJQ9VO
 nrk0M1zoOE0c45mp+g94OhNpLiEqRIrWOzo5mUPT99bUTsVoksZ3i8Wv491Ue7nPuYQ5
 93kf80PwIwAUJuW+zE0NDHF1nk5FAaVHn0B5Nf6+U3DmLgEms02bOJIHh0J0UJkhnto/
 VkXwfpVVY8k+dw5n5HriUQNNIeE51wiY4tEX2cSt6y2fWXE7UGqCamEMAq4OltyafLHW
 76U2fijuwxX+sbcQBzkyQ0oz6nsIq9T7srCj8t4GuU/SHbGEmiumPM2l+C5o00lPctXt
 AiAg==
X-Gm-Message-State: AOJu0YxJFRcaMmiO6f6YpeMvwzR5xLKpY0bLvkLhdE5CAygxWxAw5biK
 IjFkV+liPftnTuchlz55mwgcHpXpmtY9pS9xnVZsttn6B7p935xcdUrAsSpCxfbi5lNxWmgsJgB
 63He4gPJWVV+Zja5/GSSuLuNl1oM6//cR8EWTl8sn5vyLo5sO3RKSnC2KxGWZAzmSrDZZZKG8ws
 /skOjQU1P0QpppTLgmjuzf4z+cUAEzn9pmmva3h88=
X-Received: by 2002:adf:f810:0:b0:37d:5026:f787 with SMTP id
 ffacd0b85a97d-37d86d55306mr310481f8f.38.1729001908081; 
 Tue, 15 Oct 2024 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTBsI8Ng4EX8YHdcxhIWcEYt4Z36CfPGgFTUIAV9qOPSKVTATLt6XzP26/IrbIfC2H41xjVQ==
X-Received: by 2002:adf:f810:0:b0:37d:5026:f787 with SMTP id
 ffacd0b85a97d-37d86d55306mr310462f8f.38.1729001907569; 
 Tue, 15 Oct 2024 07:18:27 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56eaa7sm19056745e9.26.2024.10.15.07.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] accel/kvm: check for KVM_CAP_MULTI_ADDRESS_SPACE on vm
Date: Tue, 15 Oct 2024 16:17:08 +0200
Message-ID: <20241015141711.528342-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

KVM_CAP_MULTI_ADDRESS_SPACE used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, the number of address spaces
can vary by VM type.

Query the extension on the VM level instead of on the KVM level.

Inspired by an analogous patch by Tom Dohrmann.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 8be731cfeed..4287e254df8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2618,12 +2618,6 @@ static int kvm_init(MachineState *ms)
         s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
-    s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-    if (s->nr_as <= 1) {
-        s->nr_as = 1;
-    }
-    s->as = g_new0(struct KVMAs, s->nr_as);
-
     type = find_kvm_machine_type(ms);
     if (type < 0) {
         ret = -EINVAL;
@@ -2637,6 +2631,12 @@ static int kvm_init(MachineState *ms)
 
     s->vmfd = ret;
 
+    s->nr_as = kvm_vm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
+    if (s->nr_as <= 1) {
+        s->nr_as = 1;
+    }
+    s->as = g_new0(struct KVMAs, s->nr_as);
+
     /* check the vcpu limits */
     soft_vcpus_limit = kvm_recommended_vcpus(s);
     hard_vcpus_limit = kvm_max_vcpus(s);
-- 
2.46.2


