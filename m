Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8096ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9Q-0004uP-7E; Wed, 06 May 2026 03:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9O-0004tZ-Ae
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9L-0000bY-Q5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=Ody11UV4TXXAmYCRh6hWUEZlRM4+eYY1vWBEzReotrajOotdIErCGgZvDmHDUqKh778UuX
 7yskV/MbKYHW5ydXRqrOCC3S70tBco77+dHqOc7o/0YBzu9WqEnAiz3xvv+XLQIYQr0I4l
 KLJMbljI43+32LryU+3IrmsXy0Drmd0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-BwQ-UbfnMIeR9p6vBbanhA-1; Wed, 06 May 2026 03:58:29 -0400
X-MC-Unique: BwQ-UbfnMIeR9p6vBbanhA-1
X-Mimecast-MFC-AGG-ID: BwQ-UbfnMIeR9p6vBbanhA_1778054308
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so72796675ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054308; x=1778659108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=cWCx8Ib3OjxnFm+zJhuQqYnCrKzrrh3JdzIgQnJYDc7MZ+vIVt3aOXICOpXZqj2v7B
 04119ufEyrttG5/owjT0aT54y+RygcflWmHxueX8nUhguIGbLnDb6vSeEvnCdHdSBRnx
 Yi/pH2BR6CqNrDoW+DwWx/MK9R6G/8RsbuJf6syj1cKs53WOG3bR1fH/T7iPimj1Z+6K
 weLzOmTFZRHTcr1Yrp1Ve99z/UJN+DzxR1wHZF5BkxuTAJOewJa0MVeyjcx4CnGb7H0l
 hP8kAEnmw+jBwjHrqbRe3K4WX3crVRYjofEC8Axgx+sjHOjvC4XHozPGzzqYeyCp+xrW
 BrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054308; x=1778659108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=Ky85RPXChjE6+C1YX5/asVEGs4Eqcm4UVx7oZuA0DbcLKFqvJ8x5kNzL1FyrcDDQJf
 RNgT2aczuoKBaGnwwsfYJkFl5G2vzi6VFlkWUkllpJmcBklBDS0ynnna5Yhc9FOcaAF4
 W4wTnB6boXi9W8K09ONWpxmItvrSnpoG2zzl3Zn+A6N2QzBSU8UoXldz1tHSFbgv91Cc
 JbNUIY7ZisM2To4IdPZS+z5qOZIV5shy8mlLZ2+PL4nimBqYpVmMppQjvgJmFqV98QiQ
 6xdMs/rw7P+zc3cnwhnZQsqcDGMV2kDZTKgklSR6W/6yjw6fgD/PKb7Kw1HjWagdiogv
 Ff9w==
X-Gm-Message-State: AOJu0Ywi88t37UDTfUWOJvi01irZW7K13TvKsLZCkHPy5flc7f/pyk+K
 gpLPMwy8HB349O7CRx91L72tqM31DBfe43t1KWau0a/UXch7PpKktdyP0eFZM71iTVfLBS/ZBXY
 8Uino8RANQky/hO782funb9/Gi4MJ0H+BuT6WsD8vtg3SOam3rMRegghR0Gtp2yb+l+HqDGqVFt
 BWIXgaEd+oSqZMs13JuG/G13UF5+TZyck23Zotr6k=
X-Gm-Gg: AeBDievwhLpZu/ZwYLxD0jJYD+fvr6LZMADrzIF/g+lVTFhcwIgyrNGNkaw2VqL5SC6
 RHZedfwGD3EwAnHPmUuxh6LeRygEEsu4NbuUCia6u8Wi718tuqqCukxG9Dds6nlmi1DLPhkeJ8g
 Y6SlcEcVNo45gqYmvaxSWVX+LKETaLrglUyLxQT0oVDCIUEkmXMbTbIqqXyrEVFZaWcDxEfWxfG
 hOHX+FWfEDXUTOeitlVn/02B9wmPsaLlNZDuPETi21D/1gtls89lqz10BM8YeE3M+w8D3dcNz3Q
 zv6B9Q+QEUKnGVJQqrPk964e2EoodEdbTRFKpuErd9w41fZy1HODQvV0T0Gx6I7uKdhwvH06rq2
 odpXfP9o3h9hzpf1erNx5AAvtHr6pJaBLIBPh/vJpfDQlxG9wTLOcG5gGex/Em5W07WIKrDrw
X-Received: by 2002:a17:903:1a4c:b0:2ba:9587:25c2 with SMTP id
 d9443c01a7336-2ba958726f3mr4407315ad.3.1778054308012; 
 Wed, 06 May 2026 00:58:28 -0700 (PDT)
X-Received: by 2002:a17:903:1a4c:b0:2ba:9587:25c2 with SMTP id
 d9443c01a7336-2ba958726f3mr4406945ad.3.1778054307452; 
 Wed, 06 May 2026 00:58:27 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:26 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 1/6] hw/tpm: Add TPM CRB chunking fields
Date: Wed,  6 May 2026 13:28:08 +0530
Message-ID: <20260506075813.120781-2-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

From: Arun Menon <armenon@redhat.com>

- Add new fields to the CRB Interface Identifier and the CRB
  Control Start registers.
- CRB_CTRL_START now has 2 new settings, that can be toggled using the
  nextChunk and crbRspRetry bits.
- CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
  this revision of the specification. Refer to section 6.4.2.2 of [1]
- Add hw_compat global property called cap-chunk because the chunking
  feature is only supported for machine type 11.1 and higher.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine.c     | 4 +++-
 hw/tpm/tpm_crb.c      | 6 ++++++
 include/hw/acpi/tpm.h | 5 ++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36a..4e0a93e231 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,7 +39,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "tpm-crb", "cap-chunk", "off" },
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 02701ab948..bfa09c04cf 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -44,6 +44,8 @@ struct CRBState {
     size_t be_buffer_size;
 
     TPMPPI ppi;
+
+    bool cap_chunk;
 };
 typedef struct CRBState CRBState;
 
@@ -58,6 +60,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
 #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
+#define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
 
@@ -227,6 +230,7 @@ static const VMStateDescription vmstate_tpm_crb = {
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
+    DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -258,6 +262,8 @@ static void tpm_crb_reset(void *dev)
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBChunk, s->cap_chunk ? CRB_INTF_CAP_CRB_CHUNK : 0);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 2ab186a745..782dc8212c 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -150,7 +150,7 @@ REG32(CRB_INTF_ID, 0x30)
   FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
   FIELD(CRB_INTF_ID, CapLocality, 8, 1)
   FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
-  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
+  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
   FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
   FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
   FIELD(CRB_INTF_ID, CapCRB, 14, 1)
@@ -169,6 +169,9 @@ REG32(CRB_CTRL_STS, 0x44)
   FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
 REG32(CRB_CTRL_CANCEL, 0x48)
 REG32(CRB_CTRL_START, 0x4C)
+  FIELD(CRB_CTRL_START, Start, 0, 1)
+  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
+  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
 REG32(CRB_INT_ENABLED, 0x50)
 REG32(CRB_INT_STS, 0x54)
 REG32(CRB_CTRL_CMD_SIZE, 0x58)
-- 
2.54.0


