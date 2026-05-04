Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D472CD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxJu-00080G-9x; Mon, 04 May 2026 13:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJr-000800-Ht
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJp-0007bi-N4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=BGoyBHzJDRS8hTyz5DNori2YI+TRvoQcw3VLLNzvT4VSj5d5PzI95ST+5lLASFAL2A1Wij
 oGr9/AO4snVEljsTGdd8cfKiwMwSn/ZlV74uYQjUZD68pgFua1pXPN37EUNEqTAMNotJrx
 0edm3Cb/tJAGaaFsuhQtYBoj6uy9byM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Qf2xW1VyNCG-jZBiDlONAQ-1; Mon, 04 May 2026 13:42:55 -0400
X-MC-Unique: Qf2xW1VyNCG-jZBiDlONAQ-1
X-Mimecast-MFC-AGG-ID: Qf2xW1VyNCG-jZBiDlONAQ_1777916574
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b465bf993cso45071375ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916574; x=1778521374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=cVHcA+eRrxxlx0gVVzpj34zKcFsMc/uz1Qig7dc2ghorjZBhIV0zna3Ck0LwSQBdsZ
 3p75IQuYXZhSIFeF9Joa2hyjpYenT9Hc0gre/1Ch4u+te2SAse5P2kevwH6EMafFcd6m
 yYPW9k6DlO9b/vQ0hp6dqQdwk7owiy29JFiHs85r7JDkZCdiuO1oFHg0deUcAbRyRTIa
 KJ8FFGzxnnU6b69UUt8by2X7ppdcItqd/T3Eo8URaw+2Q4hagfuvZSWViDNbyBCvQRP0
 AwGLV99G4nK9R9mf7QvMsKP6g6JiN+fQigjBnvgTNqEIpF0OLrVb8StVTFuYBnH/W/4Q
 mNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916574; x=1778521374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v4pF4l9L+XhDbGXCnZWjvEQGjfAJPVkKy76gDH2nELI=;
 b=r3EDbmQAaTBGgZMMPL0mclbk335lBgSw11v4usX87kG49Dspoi79vLYOgPEqqKnnrT
 n0g0JKD/Yj+kDGI986MJKHjZWccu3Y9iq6rAMlU149SPw7VmK/XrJ8Se9YlUgYkSTh5R
 ea1rwwvQXeLrbbtf2z9UlxtF7k8hNRdsYH8LVIlVQYfHcuJDhsNseywSW39d7exPr6X3
 gVX6XalTRqQ2JdMpnp/at2YLq8upLWHkeT4Q+yNdXuWnh7wWJVHw3qv8KiA5FGegOZIk
 2FRYZ7HuYVSIMzRJh2Yl4cuI5CRWf6JR1wCoJFCp7lhmAxOnWiRqorkq1mLfMP5FJWQs
 CRkw==
X-Gm-Message-State: AOJu0Ywnj+2dRJ9/HFMg++1kta9ERu+1Z88amw1lttpLzjZ7gKssXcdZ
 zn4DqHifbYL67jJeKToApyz/SJ0X4S5auR8aocexFTtI5EE09jYE3onU9KTvn0KI2FSgjuf0MOc
 WH1Ygaf2LIEK73GyIf1FfvNfdOUiR0sDgL0gEomTbddP72Udyi2XaBaiDoKLzgh1FNhvFMjas8Z
 wH2uNqHacnAOCh7CY1LWMbsgG6IcB1fd4CVAGtqRI=
X-Gm-Gg: AeBDievpzyPVqYkgpKOunzed14kiigWCJ0LpWYujbYtrHcXvzyEblzC1hqkSK4QU2i5
 oeksiWgwRw7KdTe/riMHLfdcsjfmIQLJrjHh9Nmu10oplJAz5L4m8d0Fz+/95sUwIHACNl1jbip
 hVW5fWsqmSHwb+2Ecgcr+3Rrb1NBSEwvfzS1ww4piJ840GuJ+2r6lBjWePykkqXSz/Z0WLRgohK
 Ad97lmww2LrB+EqHyZC22svi4H9crThLoObrXXcMISpJZUMQtIh0MdyD7VV9CCjibuBobAzJnLR
 wQ9XFveWU9cGa0HydY/DR2Zvd0hmU93xkNk0eUXYxrhNtXSB1+sBgUOiT48OyMnB0xiiYGyxHVl
 P04l6VfQVzRyaPrPSOJ55M9musMrPEvdXSFLbQc+VdzC2k8mczEOU/XflUjYYV689jMO0WGzG
X-Received: by 2002:a17:902:c40e:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b9f2810604mr111287975ad.27.1777916573940; 
 Mon, 04 May 2026 10:42:53 -0700 (PDT)
X-Received: by 2002:a17:902:c40e:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b9f2810604mr111287475ad.27.1777916573137; 
 Mon, 04 May 2026 10:42:53 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:42:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 1/6] hw/tpm: Add TPM CRB chunking fields
Date: Mon,  4 May 2026 23:12:29 +0530
Message-ID: <20260504174234.13556-2-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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


