Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A110EF9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrD-0006hi-1b; Wed, 22 Apr 2026 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUqz-0006fm-Ij
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUqv-0006qQ-4r
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8P1JQ/3nfAUVN6IA3Ayq6ubLufw+hR8iRx/Hjum7dM=;
 b=THHlDPGwDDq5YWpA2rtzyeCR8yHUa4xsjNyzUcVm5HSB4eXKdItr4l4dHFI2gDYsfWliAK
 zyUWu+ahJbmrshImGPEe2Ve9fY3EuBK1wdSVl3/C9Katif51UxHT1D/i7HUcJiRn2L08Hg
 klFvdVFewGO0xpzBt7+itQEhl+CSQ4s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-zdVWMz0NMQC6MHvtF84RMA-1; Wed, 22 Apr 2026 06:30:36 -0400
X-MC-Unique: zdVWMz0NMQC6MHvtF84RMA-1
X-Mimecast-MFC-AGG-ID: zdVWMz0NMQC6MHvtF84RMA_1776853836
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c797efdaa9cso2413499a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853835; x=1777458635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8P1JQ/3nfAUVN6IA3Ayq6ubLufw+hR8iRx/Hjum7dM=;
 b=HlJsAUvxHWNNQTS6fcb6jb56tsI4U1Pdv98r5641B6zPxDbPdPxYA5bWnan3dbP86z
 8ZvBcO7T/rBPgMW+mSqEqgcsQWhfqNwPTagBUnNrqfUBlkix5Ei32FSURu6XgQUPe5pa
 Vu+O4ppkyq05tlM5WLoG50l7e8YpyvHTQs25gI/4m/9F3GOSa16AufJaKGHHyj9Mr2al
 HwOQBLTxsTkpPY2ISM2VhhZ3vWMxBE/o7z53lrPtvu7sT/hAZpoRdsArgFRH10RA7LLw
 fYHkZQW9vXmRn9x84EeI80mYypc6VmMIauL/taLyGKCP9FcaQd0kaUia0KLAJLFpaTp+
 z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853835; x=1777458635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T8P1JQ/3nfAUVN6IA3Ayq6ubLufw+hR8iRx/Hjum7dM=;
 b=dUz5hxXPV2U4BnF/170wR4YbWzucoNiiwTNTvPLHAqtpHHO7xqRbRVZMAtHqfz4P0x
 rKeArVB7zfZobNdJSTQ+IvHfoV3RYNBuUHaa9Jhw7vACfLzcXsilg9YmRNU6RYoCG3sa
 /41RkV6sGwwCJAax3R9hpYb2Z7cXGXg2f+q3zWMtYpJaaR+5SU7NHs5oCTP4LWSA7II/
 pdUhhf45sjM+HdsVBm/mjffodZc6TFbLm09uKuRPt6f6Ol2RGnilsnAN0Hp7kgQiwhI+
 HbaQnwiYqf4I8gCALYj1u8PfLomrJzt9EVAu4KILfaw23u0RJsekJkU5IqiwtOQUDyNK
 WQmA==
X-Gm-Message-State: AOJu0YwTLWk/P5eCtCfgg5hcJbePuoTdNEM0y95bnfjsIu8R5GCvWQT4
 DMyVXvEDLcuwCw1qMDeldcEc1K4AzoK4Lioj0d+u+iznZjRxpdPGlCaj5yPBOevnIyJcJFxKGtK
 3Nx5tp9ncaHQohJRY9p+CUZqMTH/y5q6b0J4Dhey/IOrcmLrDsbYgd+DHbUH1BKzMEge+9aVZ+/
 ULuh47LkqrwPWFggJR6aoPrtrCxzYJrG7sqLYIYbk=
X-Gm-Gg: AeBDietc/1vUsdhjDGThhkoaNREQCvIgaOxuGBINUmtLyINVEdklBzsuffV16OqCn6F
 mTL6zoBcqTVASW2AshGY6J/xHH7g6YDoENAegGYJf7oYY2fOtOpapaNZK8zoG9QD9SRNtQXby4y
 l+Eg/FkmybqnXWyoXPu12WyimURqIOQJiZJ7zPgkOVPFdhs4asARByOy3oWTGw2rNg9sHd/tjmu
 EWn+RtU4+Yroqfzua4Pj1Mh+sElATxMfkTGPUHYTRYtw9x76Bwnmhf4y8uv1Fm0siHujepflcl/
 DZSQmjm4bf5GDMNHZLAlnA82d43N7AAlW5xPfWmZZm0TP0Ymt+E0R94FD11AQFbFNF1Xx4wWoeZ
 OOkTs+Zk5652FB+ymeqS1NEPmzIEljGH3AbTZRwgIjg4Pm53nw3yg1ec1Wy5S5rMhHMrz4rHmeg
 ==
X-Received: by 2002:a05:6a21:6d85:b0:3a2:7ef4:81e0 with SMTP id
 adf61e73a8af0-3a27ef48641mr13983792637.55.1776853835147; 
 Wed, 22 Apr 2026 03:30:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d85:b0:3a2:7ef4:81e0 with SMTP id
 adf61e73a8af0-3a27ef48641mr13983718637.55.1776853834480; 
 Wed, 22 Apr 2026 03:30:34 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:34 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 01/10] hw/tpm: Add TPM CRB chunking fields
Date: Wed, 22 Apr 2026 16:00:09 +0530
Message-ID: <20260422103018.123608-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1abc8ae737..6d27cf69a2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "tpm-crb", "cap-chunk", "off"},
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f93..9555b2c62d 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -45,6 +45,8 @@ struct CRBState {
 
     bool ppi_enabled;
     TPMPPI ppi;
+
+    bool cap_chunk;
 };
 typedef struct CRBState CRBState;
 
@@ -59,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
 #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
+#define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
 
@@ -229,6 +232,7 @@ static const VMStateDescription vmstate_tpm_crb = {
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
+    DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -262,6 +266,8 @@ static void tpm_crb_reset(void *dev)
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBChunk, s->cap_chunk ? CRB_INTF_CAP_CRB_CHUNK : 0);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c5..6eece21397 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -149,7 +149,7 @@ REG32(CRB_INTF_ID, 0x30)
   FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
   FIELD(CRB_INTF_ID, CapLocality, 8, 1)
   FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
-  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
+  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
   FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
   FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
   FIELD(CRB_INTF_ID, CapCRB, 14, 1)
@@ -168,6 +168,9 @@ REG32(CRB_CTRL_STS, 0x44)
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
2.53.0


