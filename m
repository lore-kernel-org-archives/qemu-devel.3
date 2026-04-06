Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A5AF46C46
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmA-0003sW-49; Mon, 06 Apr 2026 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9km8-0003sO-62
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9km6-0004zT-FC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDFMxGizdhMe8FGMdKmLAoCznPJVA10mqEjckCECz7U=;
 b=V4lunZZI2yvgvlsynubInufxF6tM3i1NtBj/g+MPax+MSHXL9gg/ZShK3kl5jp4D+51YI9
 sFAf3QKaVqEe9/Vd+YkFmIFoLSxAKq+cerZd05ETMnR0+u9rZj39m9qo7BSwCEvwGo79wg
 agiyu7u+plL3pmkdTQShfAf0MLhgAz4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-zL_jj9DhPAqJOR-Kd4gB0A-1; Mon, 06 Apr 2026 10:17:56 -0400
X-MC-Unique: zL_jj9DhPAqJOR-Kd4gB0A-1
X-Mimecast-MFC-AGG-ID: zL_jj9DhPAqJOR-Kd4gB0A_1775485075
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b23c909256so58690225ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485075; x=1776089875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDFMxGizdhMe8FGMdKmLAoCznPJVA10mqEjckCECz7U=;
 b=Zb0FTiLz6bTLDWcTSmnisEoy6My7g8EA1bfD3OQr0E0sIofnyrv6gaGIs6ykUW2KTP
 Et6OuuSUmVO/2Yh1rgcB5BBa9M/kSBb48C3LqsjlyYEBMUdjmjNLNHrrOIbSLhfF55lw
 EtfKqKJnn1+WfUzfVs3K70ijiJ6kHZ2KE9NcPGGPjOE2Mf5RoOioajKbM2LESR95Z5rD
 7M5hpM1jWshLFT6/UIbIBQX1T0GsI3rV8GL3k2MjvySMPT/E2bmw2XCW6l+oGalWGVvO
 P+Oo1cieu+YPKWWhlhlX7HBBnw/yMOuLz13Mbiwt6lN0KG/VBm8Nd3Bed9g1W2Fd8GOg
 wrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485075; x=1776089875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDFMxGizdhMe8FGMdKmLAoCznPJVA10mqEjckCECz7U=;
 b=s54jBxkCdMiXoudg1kfAHHTuAiwvk0CYIwsS4KqZHXNr5HU7jhBsOoXTmWyMADTaes
 w7+hi5nWvCfsVz8l2dXFa5q6wex26J2PNlClMco8lJMaZpSkS9scZm1lljxHmndISY5K
 5N2rei6lEjM07GG0+qL1xryLtupa2Wjatgg5/gI8gqpEw6qhmKHAlZpvGp8hgQnbHHVO
 elF5+Wkf1XnhmEXmd7KU5fJ3Ee90h/9DZfWllu1PJG9PTHfsxV5Tgp3RqN1eUZt3vdqW
 YL9XLKs0nMntA7zT0vDxxC1felxXT//88BOpOIKtNsVl3I8x0PUR8o39gvr3XKNpMQKW
 VPgQ==
X-Gm-Message-State: AOJu0YxCB7oWUIbkfIkKYVsn//t/+xuW1Tt/0zeyvwnr78rh0gODTOgo
 tIdljrNvV0+ck3tHfRoXaJuWHCfIFMbVtNYRYLF1N+k3rIgVE5rWHytoIfos66cmbTb4v82utJx
 MALB9I6PkaEe4K25A+2SwRAUo3K+IpTWLFv9fNuPeQ+i33xQkgpIGX3xLnA3e/hYZCMgHaI7pnp
 bod4tbq7MxrQ6h6l+/o/zmB5hj5MXqZBvG/Rd/usk=
X-Gm-Gg: AeBDiet08kY5XW7wjo4aJaz5XIrs9s67W+LuvUwZJzpQfDexEmF176CKoseUTXvxlYQ
 fwryxLC5Bc8iew/75bljEVdbhNqpRmL226tbVQK5gPtROgdsGFP/4+AKtDwoUyjJKEsWunFYDPx
 bXEwUi/pa0cwV+j7FH4g4QXPBnesF8q7NLGIWp98LnN889h4TWTiQCoBmp/y3t96EcfIlFG89vZ
 pXLlwzj+eaBw0jEVnUyjb4Q8N5fBVJh1Gb4WFqFL2F64s2NcUEsBb13OvyCDJaO4rK/x1MK8km6
 ERfSq1WinKcOsYY5ergQ+Uybn4OyRnRpvrH+ZvQ3dIbNuc0+cgLbQD+M8u1CctLVLrMeB1I8FUl
 2wmjob3VcOZmQHWr6WC3gnbmWoGepb1yo9KsO0GN4ZgVHlqJzaaOM4BhSVwjOqXeMGQ4=
X-Received: by 2002:a17:903:a86:b0:2b2:42f8:1a4b with SMTP id
 d9443c01a7336-2b28178a72amr122161375ad.27.1775485075010; 
 Mon, 06 Apr 2026 07:17:55 -0700 (PDT)
X-Received: by 2002:a17:903:a86:b0:2b2:42f8:1a4b with SMTP id
 d9443c01a7336-2b28178a72amr122160885ad.27.1775485074459; 
 Mon, 06 Apr 2026 07:17:54 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:17:53 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 01/10] hw/tpm: Add TPM CRB chunking fields
Date: Mon,  6 Apr 2026 19:47:26 +0530
Message-ID: <20260406141735.25844-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
  this revision of the specification.
- Refer to section 6.4.2.2 of [1]

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c      | 3 +++
 include/hw/acpi/tpm.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f93..0a1c7ecdc6 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
 #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
+#define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
 
@@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c5..03d452d2b5 100644
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
+  FIELD(CRB_CTRL_START, invoke, 0, 1)
+  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
+  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
 REG32(CRB_INT_ENABLED, 0x50)
 REG32(CRB_INT_STS, 0x54)
 REG32(CRB_CTRL_CMD_SIZE, 0x58)
-- 
2.53.0


