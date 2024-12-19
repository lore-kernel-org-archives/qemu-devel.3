Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE94E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxn-0004UJ-Rh; Thu, 19 Dec 2024 03:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxg-0004Sh-3H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxe-00055C-Fm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3TnyK753dqDu4koeMykmPOwEc/VEMfDm3HvpCbzTwI=;
 b=Gjj1n3Ecu0rLf9aECsRNK7xq1xd6vCqCSxR1nb7lEXr0PeAvxKItQiYjXA7odemiijJU/h
 tK8s79xrrLSR3AELaJ+KVISg5M2Uep0apQ+Hu+UAo4v6iunrxKKnDbj5FktwFV/spRl9SF
 L2ckn9S8eF/a5Y8Y2nA32eUDTaXR10w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-tHqClV4eOImpFE4EAib5QA-1; Thu, 19 Dec 2024 03:32:44 -0500
X-MC-Unique: tHqClV4eOImpFE4EAib5QA-1
X-Mimecast-MFC-AGG-ID: tHqClV4eOImpFE4EAib5QA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862a49fbdaso235233f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597162; x=1735201962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3TnyK753dqDu4koeMykmPOwEc/VEMfDm3HvpCbzTwI=;
 b=enoSZVmN8yFL2pg511hN++MHEW71DalOb0PMWr8toG+FAjrI/gYoi7qObfDC3sL1+L
 wn5Tf7ZoE/FKsv/4YQ1CQrujG6PqN7cmwimdJszQcExF/n3MvVKsPNlEob6m2V3TNOzA
 rQqHUUbkQkItrzGT5ycGqfG9MlEGs1vECeiMJGtuDptDXwN/LB/9mZHEA3cUtLrFmi+R
 1oe8MUW7K4nz3GfB29t+55mIRUFDVYZqL5M4mzMBJUfpFfd476q4fiDLUbEJZky1EU5p
 xEdKfZCtCiBmQyda3I98h+WOqHsKC27bJ8vDpmIKMtzyK6CEFLVUIAvtBJ6JVLeLLCjj
 vlOg==
X-Gm-Message-State: AOJu0Yx/B7igWUtMI8e0ohG/jXci17C2/tUa+RxWX/xv+8KQptaF4aVk
 kLXYlhnndlsB42dRcx86OyF41e1Fd14lIJ4aR3xJzXcJjAdi7BzYly4tTpwQ8KEY5rgH3wMUWt/
 xhU9/0qSixFmUy3z8qFZhfzaDUHGmIzTnak7fnddwXtjIo5HQPgDVg7CKHiEgLnFzg59kgrFOEw
 c+U6S7T0kxXKAHE9w88uo4JjYnngTT3p4DEWgn
X-Gm-Gg: ASbGncv4s20dO/K0v2nelfRtj2fzPKBwF4Hx/o1HirFCUPqKGORXUImihOU00m7zpxC
 m8b/HuaN3CKsF1VmgHYBj22mLp59oCBEMJKcFS9JKy2M2DQgN7E1nztI4b/fxAi7O5U3YFgkD8A
 yeFDp2uQA5C8MeRFArLTLvvJKlCrXCVUAzLzWYrYhZpnlyYHGg8NPJhKqXBm0F2+kWuxAwNOwrv
 GcVRQXrWceAwpIahsqqD2GKuC/UkTZDXsWY/fN0OZc6pkqUuiT7zqguUL6x
X-Received: by 2002:a5d:5f83:0:b0:385:e38f:8dd with SMTP id
 ffacd0b85a97d-38a19b3702cmr2366435f8f.46.1734597162237; 
 Thu, 19 Dec 2024 00:32:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOSLx+ewTZ0Dw46r7I5GSRtFsA+5Px+cgdxviXxYvN9v4DnHCRbbJc6QRD1wgm6eyxwCiRpQ==
X-Received: by 2002:a5d:5f83:0:b0:385:e38f:8dd with SMTP id
 ffacd0b85a97d-38a19b3702cmr2366399f8f.46.1734597161765; 
 Thu, 19 Dec 2024 00:32:41 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828a8dsm1004177f8f.2.2024.12.19.00.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/41] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
Date: Thu, 19 Dec 2024 09:31:53 +0100
Message-ID: <20241219083228.363430-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

Do not register an empty set of properties.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-7-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_nvdimm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 2ef6f29f3dd..8bcce4146a5 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -884,22 +884,23 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
 }
 
-static const Property spapr_nvdimm_properties[] = {
 #ifdef CONFIG_LIBPMEM
+static const Property spapr_nvdimm_properties[] = {
     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
-#endif
     DEFINE_PROP_END_OF_LIST(),
 };
+#endif
 
 static void spapr_nvdimm_class_init(ObjectClass *oc, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
 
     nvc->realize = spapr_nvdimm_realize;
     nvc->unrealize = spapr_nvdimm_unrealize;
 
-    device_class_set_props(dc, spapr_nvdimm_properties);
+#ifdef CONFIG_LIBPMEM
+    device_class_set_props(DEVICE_CLASS(oc), spapr_nvdimm_properties);
+#endif
 }
 
 static void spapr_nvdimm_init(Object *obj)
-- 
2.47.1


