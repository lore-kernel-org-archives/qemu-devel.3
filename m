Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943C7D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvh-00088h-5R; Mon, 02 Mar 2026 03:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0005NC-Eh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyul-0001xV-QK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgpTnmDlQrNYYO6m4642qCf1swsSA8ghfzunh+4QPMQ=;
 b=CMp/33DqdO1Il2BRR3hmU9J41xsm2U6JU2/EkaN4URT9CaVGYXI7uzqfIQUseKXrZaRoAQ
 wInB21UnPAUcIqwEbco/edBBvsKjRIEV33IPnvUuRQzAx4I7RFa2SPUD/wg17dylwbMpJb
 OVLYWdZBhXF/pxpeZedDsS3O8XrMSFM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-4bPiVrZxMLyh0n5Rb96pqg-1; Mon, 02 Mar 2026 03:46:02 -0500
X-MC-Unique: 4bPiVrZxMLyh0n5Rb96pqg-1
X-Mimecast-MFC-AGG-ID: 4bPiVrZxMLyh0n5Rb96pqg_1772441161
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837246211bso54869455e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441160; x=1773045960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgpTnmDlQrNYYO6m4642qCf1swsSA8ghfzunh+4QPMQ=;
 b=QQQhxZHWfy1ifrt/czxQbSSFejaCxHTVn+pVyw36Pv7/byY/qTWVgjYxWBZblOL6iJ
 qDAChqdqBynYuigk5ouWnvjPMLXzudl0G4hpx3sV6X56MoX2C95fSRUoZ4VbfTSkWPKh
 d0/Gvw2o9BjYMagwldJ028GsOuzM2hahyJBO3ARKTnRkyspyJsMjjbPor55GKk+DpwFZ
 eTBllbn4qxGWNskQKLsS21VglkfxMlYHMGhRwk65JVqhsOBUdGO1/7MtiGRqSmV8A4nT
 IArgCUgCKYimcIxHGEEy8GgozbqF1EdK5/l8WpjTHFoiQMi/VLM0MdeZzT/Z0AgTndpY
 lcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441160; x=1773045960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgpTnmDlQrNYYO6m4642qCf1swsSA8ghfzunh+4QPMQ=;
 b=dsI/mXhHbfInAPEEJy0cUT1atENY3P0GDx8AICOkmN8TF339ToJQH1HPVfphnBQ3Ex
 v6U8MPqDGbh9Q7UkYlaThI03xeO/cPKz8uTfuZTlZ0xsZZBQckz7RYRdzy1tBsSu040D
 HYUTkr+RGxUQsOQ9aIqoBwIne4EFUT1Zih6YvG4ord91/W4Xm6Wi07pPwQoWdR+ycL+o
 3FLqHPXR8uzTcBlZCJeo6VcjJ36iesVWvpZ/AjJzAks+64I1ZoFcqtIU7QdABQSFS1XS
 28efCx3MyD3dmQP8/Pmj1Q1rF6VdWrghwoS6qpbSVrJIGsL5AOWTSAtC5kYZyhXMNzUB
 jf8A==
X-Gm-Message-State: AOJu0YxcVhmSxuVnzacy/7YdyT09FizY8AjlpfDDjq7PlWDP4bn+0R2Z
 GLefqc4cpPd00S7cLnBpGArXDQUjpYXqwlUSpd62BqJv/gL2VrbMcblBREKCbPfZ7EAjlTSVHOf
 EztdMsQExfkr7vZlIEWKQOtyJIkFctwwsZDwTpaKr1wl4F1uej1v007F3WpCKGZiW3jSbfniyrk
 KuTz0AT/Gqhd7Gh82gIs6Tiwq4nvSLin7dCKrAKHTu
X-Gm-Gg: ATEYQzyxrLUQb+hHgP4efKIkatUDm4vNlR7DVIqJEAIgkADtlDh1i0eT3B15R9hF3+r
 UllrjOBD6ZePF7kki45wj6TuhDoHj5MRgw0U90/H4v9p77z/Homyb4WOdrTMRI6Ehzb+3vvu/0Q
 sQAlPluLE9xuweXLJ3BWVyZeTyAfIuUc4Vqw/Woo7Zv1WicavkDv7xmBGOVGCK9p0vGc85cDmX5
 V/kOp9Tizlg0/zWQ9X2EA7KUXi/eZxzsAMSxjUvGAzSshKQkXF6kOUJikgeTiZulk577RcNW4y7
 8sz1QOMd6EHMKzH5f+gP+ig+MOSOhrWhr2+8LzqvJv4lX+eurQln140qfPAuUfsrdrqsdgY8fMf
 69cBYBIEmMNNU9VuC0joemBOcwfrGzYKW7Hme2tjTHaunFaclJuW8B6e3t+h2DJF16Nh7aPbB4u
 Gb5+jsfhWPs/7OZUnVsa4gjPVo5n4=
X-Received: by 2002:a05:600c:8106:b0:483:afbb:a064 with SMTP id
 5b1f17b1804b1-483c9bb7b7emr192748625e9.1.1772441160003; 
 Mon, 02 Mar 2026 00:46:00 -0800 (PST)
X-Received: by 2002:a05:600c:8106:b0:483:afbb:a064 with SMTP id
 5b1f17b1804b1-483c9bb7b7emr192748155e9.1.1772441159444; 
 Mon, 02 Mar 2026 00:45:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm289527035e9.0.2026.03.02.00.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 052/102] i386/kvm: refactor xen init into a new function
Date: Mon,  2 Mar 2026 09:42:47 +0100
Message-ID: <20260302084338.473368-53-pbonzini@redhat.com>
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

Cosmetic - no new functionality added. Xen initialisation code is refactored
into its own function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-12-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 40e4b3f1283..cc98cc961b7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3433,6 +3433,24 @@ bool kvm_arch_supports_vmfd_change(void)
     return true;
 }
 
+static int xen_init(MachineState *ms, KVMState *s)
+{
+#ifdef CONFIG_XEN_EMU
+    int ret = 0;
+    if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
+        error_report("kvm: Xen support only available in PC machine");
+        return -ENOTSUP;
+    }
+    /* hyperv_enabled() doesn't work yet. */
+    uint32_t msr = XEN_HYPERCALL_MSR;
+    ret = kvm_xen_init(s, msr);
+    return ret;
+#else
+    error_report("kvm: Xen support not enabled in qemu");
+    return -ENOTSUP;
+#endif
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3467,21 +3485,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (s->xen_version) {
-#ifdef CONFIG_XEN_EMU
-        if (!object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)) {
-            error_report("kvm: Xen support only available in PC machine");
-            return -ENOTSUP;
-        }
-        /* hyperv_enabled() doesn't work yet. */
-        uint32_t msr = XEN_HYPERCALL_MSR;
-        ret = kvm_xen_init(s, msr);
+        ret = xen_init(ms, s);
         if (ret < 0) {
             return ret;
         }
-#else
-        error_report("kvm: Xen support not enabled in qemu");
-        return -ENOTSUP;
-#endif
     }
 
     ret = kvm_get_supported_msrs(s);
-- 
2.53.0


