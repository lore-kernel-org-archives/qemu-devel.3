Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86C109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Doi-0005Sa-57; Thu, 19 Mar 2026 09:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dof-0005MA-HJ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dod-0000so-BL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7XFCbg+RalMNcf1QfRP5PRTwEgFZvtOws8lguSobZs=;
 b=Dp7zh5ZhYxZbhgBqEeXkcLlk6FvluvxuwVQ3cTtfr5NnFV4kEqRIRH69FSS5t+u9oMbJ6H
 AxspkrkCs/zHQmzJEB0q1AFbWA5/h2oFchwDYTJltyNQliA3kGgoDJva9aiG+X8Fy/DEfj
 AEBWymKHCt9Wj9XglW0A7fgdkSoUqU8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-uWBfVolGPracFgcyREiRjw-1; Thu, 19 Mar 2026 09:53:33 -0400
X-MC-Unique: uWBfVolGPracFgcyREiRjw-1
X-Mimecast-MFC-AGG-ID: uWBfVolGPracFgcyREiRjw_1773928409
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aecfe69196so8769875ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928408; x=1774533208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7XFCbg+RalMNcf1QfRP5PRTwEgFZvtOws8lguSobZs=;
 b=FzryI2b/GO96CYYu6Bt9gRzEDxIZpn4m4heXdu3Xh/MtP0kIHsXpZvcI2qFIIsKaQl
 qhS3vpHRwOgk8OiGzbbgpIlwqWfClbaaueQVdiSUIcWEH139vjvwI1Hj//sapiJ9Yqjh
 GtN0xzmAtWWqUNbs6ZcYnyZpf73bQFWHhnBi+DkrOeYTRewP45VC8q24guX7eQrgf5F9
 taiQWIHpbCj+6dIjvGp6CZevMB9Vev5pHSf0z22/sT9OmqUwxdTUktM2uL/5+Awcum6C
 HPSTKxgG0bFn5lE8CN+5aH7YT8WHFDmDsqZgPLSZDifxkn39BuV0/NE5aZAywjVCEcEt
 x4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928408; x=1774533208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7XFCbg+RalMNcf1QfRP5PRTwEgFZvtOws8lguSobZs=;
 b=e1ts0ZUejlYVMj4hM6+naowU6RD/G88f9iAA6NWcBYZhCIbummuVflp8n/uPQZNLoI
 6tzCiy6BBqsrCW7+XSpUZYD9zuZNdGgWIrlWckxNGS3B3nypEE/mSBNV3aM2FNxpgs6T
 RKv//2zCH8vb+SHEqRHX7j/Sn1+VDtPm18DXHnL3frQI0urrq6CutEe4fOrMGoIKGD9i
 d68vgnuANBZ6QcKo+f1GW+EYfp0CzLbz14d0+n8Dlv0Vs8e3xhOHMSpL07g6ILmSA1x3
 F2tbhlpsdzNXw5YKRufuH8jpanxgD8SKMOxYSzNoyKiWEAVHUxKo/b7RkVX+nPkxE27m
 sIEw==
X-Gm-Message-State: AOJu0Yxj4x+qvG6xIjHK/8V5FjmZGfovKiEY6KaKP/mTwSvZ2LW3w21J
 d9ff7t0kTzfSmlwyefYGSB4oBaDGsOoyxtQ+7RRHsVTxZFOJ93okXwuyf/68T6ORdkRqmlFIyK5
 KoWnPNR7dJJgjlJSvPyDq6HGDsIgcC47P5wL68MPszFLX0Go5Vme7GTciDDve7zOmVGvDGEU7Hm
 rHfycQZFcipzVJ5aLDQLxLx13/Udi9Kdv/Hi0tuf8=
X-Gm-Gg: ATEYQzzMwftEl/kNOi/tQabyExe8jXXbVQD73O5D2thczl+ZVXpRVUTHi0vV+/2jmVc
 CQI3SSH/IE3XCIL6dmV6nBqorB69urv5WRKHIaV3z/uYqBzLf8DtkqJi03+tH2WEHDXdp9uC10F
 UgOTQfqbMAv+Sv27UKMyRsUfZWu1kGd5dmjgGf3Lh24DjprrtLv6E2HY+Hj3BmOxScJh0b3VPoU
 9bAc4CCfYxJwfPO+1wWqD/F4FqFTAGy9kuTkfzt5sMxL+hTprRmULJvOKulfDLN3JPX1jI9xK9D
 c3fJrTRts5jEbzi9mBQAnPOkpvw17Yi8k+uaM+P7OjZlAF0Nn9YGtrNwsr4ERTdbtocsSY8Od8L
 SswW1/OOLJBtEwwLRh63kBDTq/wbuFhk+iJPPU8/qeaxQEW+4rb6y+sfEHhFlaw==
X-Received: by 2002:a17:902:f705:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b06e35b4demr74891405ad.16.1773928408548; 
 Thu, 19 Mar 2026 06:53:28 -0700 (PDT)
X-Received: by 2002:a17:902:f705:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b06e35b4demr74890995ad.16.1773928407949; 
 Thu, 19 Mar 2026 06:53:27 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 1/7] hw/tpm: Add TPM CRB chunking fields
Date: Thu, 19 Mar 2026 19:23:10 +0530
Message-ID: <20260319135316.37412-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


