Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C818CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWRF-0005qw-RH; Mon, 08 Jun 2026 05:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWR3-0005dX-3E
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWWQz-0005UI-42
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780911495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1W0FDY9Vb0uir54xHVAuRUaBOc53guGxtfsBJ9GpaY=;
 b=WN134OyqP+i9Ai22r15CT6+3jNSh5elos5aYnFsiltFkHkTW0moGd5AFGzjfFMSgKPNH+7
 Lht291Hmw2jy0/NEb05yzBku7aW4Jn9GSNHDTxax6cHKU33YpRvAjoI+BYiKPYBzSIj42S
 uYzRCIavvANNAMO6l4ZrSlMLaml7+UI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-4VhQstBoMdycBKJcRdXK6A-1; Mon, 08 Jun 2026 05:38:13 -0400
X-MC-Unique: 4VhQstBoMdycBKJcRdXK6A-1
X-Mimecast-MFC-AGG-ID: 4VhQstBoMdycBKJcRdXK6A_1780911492
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so9552545e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780911492; x=1781516292; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k1W0FDY9Vb0uir54xHVAuRUaBOc53guGxtfsBJ9GpaY=;
 b=XUFIePcU7ji2/7fv3JXYYo+jgJ7yYplKvy0EzLtwTNg8FQvJTcXsWgDc5usS9Clinh
 BJsutEQLdtXpmBH60+c8CDl/NEoJD349Uc22kLBXjYizUPyi13J6Obqk+td1dRutOUbi
 ECp9NaRfmScCVpz8Mg2folntw61ONqdVLPS0EBACQn7fTmbNaZItiygJG2j9XW/gqncz
 TIK7FM8h9TaqMl5Nyf0XN2oV5Kf+Vte14a+/O2Lz08OS9QogfThy+V67rg0MUu80cVo0
 fQGu2S4VEKEH5guVBchYZvNBkQjmUq7jumvP4A92F5sFiybfo5qlFpRfrr9r6ZfN06Ry
 MIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911492; x=1781516292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k1W0FDY9Vb0uir54xHVAuRUaBOc53guGxtfsBJ9GpaY=;
 b=Ww58MGb1jw6A33V2p9SWZFH9rcXbHedOcnM4o4lUiKx2BdvHpse8MPbwHmiN1sySW/
 tNxsKy8yFk1+hYYF52Sc/8lvXQxanmdZcdaBJiZDO760JOs1ZqlCvLYzZKKjxryYdgFG
 CY5k0vwMSb2qiKuXbjAyCoo7mBjCpnYTvuUPb010cqtfWO6YW3x0o8U8mX6N1DO+4VMA
 +9sxVkF0mWA1IplMRyfvgTBKYNPZLyLZRC0DnUv7HRmuGY2JU/uwsbTchqEDnEQ7bQOQ
 hLz6OkiIGPooyCaIDUJYgU7+jii1wT7/4wylYO4fqnYe12bIRhrb7nI+xpBW7UYLmYnN
 gZzA==
X-Gm-Message-State: AOJu0Yzn7o8uCQ5ssyUjOOq4YTAgP3ljgyw8yTxeqm/yJRopb4K6NNGn
 h4Hfkp7PlfJ8VvzAydI1T6SK3GsZNkn91CIo0RkxkgVpzIOlHAMQSVDpd9/zdqiujlPLk0ykIqQ
 ZwQQuSbRN6GibuAfHdO1Ww57KioZUyabihaS9cEZfFMarbhH2V2Rymwsk
X-Gm-Gg: Acq92OHGSj1pP9jlK5fsCNAR7xREISmUi47v/+nYn2zk6cffuvMq20WsVkmScfPZR2N
 LwiCYc9Pav85YNdi4X/cc6B7xLzQ3IJ83qqebqi2NJ7K0eAU0pjFdGM9y5YO0DSaDvnRelN8tIq
 S4nFQlDzFQ75WZS9JfqBD//HO2Uz/6s9vRDnPyv9+anDaksbGUnztiakny3t+gph/ETTYkY19HZ
 Et2GSL2KfpRmFeaW5PT5kq8LolOt0gPyJNXKqC6oABf/yoepz544HY+Ig8XAXKv2VzpKL5JXkoY
 NZwbe4WObfmRdODcpdnr+jCgb3MnDwAj5HJ0+svcwGgwnxH/N2FN9oG4f9GMIx88aeiOCKs+kKf
 0PjrXef26BN5sAgdgJsF0M0j+49+2b1k+IhB33+NJXDO4jXRIMugdjZ7WTgJ8qG8jDLVpmhaatO
 oPZU05vWrMxVM0N/mWIGeWNZkTfCI=
X-Received: by 2002:a05:600c:a218:b0:490:b0bf:7606 with SMTP id
 5b1f17b1804b1-490c2d2003cmr119774155e9.16.1780911492536; 
 Mon, 08 Jun 2026 02:38:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a218:b0:490:b0bf:7606 with SMTP id
 5b1f17b1804b1-490c2d2003cmr119773975e9.16.1780911492197; 
 Mon, 08 Jun 2026 02:38:12 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm50144923f8f.21.2026.06.08.02.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:38:11 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 08 Jun 2026 11:37:46 +0200
Subject: [PATCH 1/2] hw/i386/microvm: pack device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-microvm_device_tree-v1-1-730874ad0008@redhat.com>
References: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
In-Reply-To: <20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After the device tree is generated, it can be packed, significantly reducing
its size. This is particularly important with the upcoming support for
the device tree via IGVM, which can have stricter memory constraints.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/i386/microvm-dt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index 45fbb5bbd1..9de2abf92c 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -43,6 +43,8 @@
 
 #include "microvm-dt.h"
 
+#include <libfdt.h>
+
 static bool debug;
 
 static void dt_add_microvm_irq(MicrovmMachineState *mms,
@@ -326,6 +328,7 @@ void dt_setup_microvm(MicrovmMachineState *mms)
     X86MachineState *x86ms = X86_MACHINE(mms);
     MachineState *ms = MACHINE(mms);
     int size = 0;
+    int ret;
 
     ms->fdt = create_device_tree(&size);
 
@@ -337,6 +340,12 @@ void dt_setup_microvm(MicrovmMachineState *mms)
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
     dt_setup_sys_bus(mms);
 
+    ret = fdt_pack(ms->fdt);
+    /* Should only fail if we've built a corrupted tree */
+    g_assert(ret == 0);
+
+    size = fdt_totalsize(ms->fdt);
+
     /* add to fw_cfg */
     if (debug) {
         fprintf(stderr, "%s: add etc/fdt to fw_cfg\n", __func__);

-- 
2.54.0


