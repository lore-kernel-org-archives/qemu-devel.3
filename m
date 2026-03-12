Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CD3FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XTx-00005x-4D; Thu, 12 Mar 2026 00:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTu-000056-LR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTs-0008Lk-PZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nh4xFu25fP4+98Q20GIy5ie54KTLY9e5JyU0jfcgH0c=;
 b=e3b0xfuYpwYK6qpXL248KTOsQ6qG7zvFeGDh8Prs5t8jRfuGnZU8D2k/xSAeyixDl1nXYg
 mmckzL4x8LTnWdGZUFw6+UJ2YpFO/mMqKGN5NqOwRWOPwYKXgpz7JMbjNuTh2YJfb1ywO8
 sLo3Ut0LukB0Yq1r31NZNXiwjNFBrsQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-s7wLx-S0N46hX2I-uqxQDQ-1; Thu, 12 Mar 2026 00:17:02 -0400
X-MC-Unique: s7wLx-S0N46hX2I-uqxQDQ-1
X-Mimecast-MFC-AGG-ID: s7wLx-S0N46hX2I-uqxQDQ_1773289021
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7380305a9aso974327a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289020; x=1773893820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nh4xFu25fP4+98Q20GIy5ie54KTLY9e5JyU0jfcgH0c=;
 b=iLD7WvHkFFT8z9tHaK15ff0sBKyT/COVacwm2DE0t1o61UX1R1eoOVvbR6FYLPyRgr
 99h+aLLP4ivskGo+QBM4wj8wbowCYRydT+TXUq0VM9W5M5U86zqtk+w9lyP8Qt1dzI3i
 syEu+69FegdeH2l33MRltY9cx4WiyF5w6XE6FLFVWpzKRIxH7LbpD4XqxT6iDzeXf488
 vJ97DXXzXSZyE5r63O8FXbOGJMNHlbRSk+x/MTnPJnbbEQZbMR6Gbhi330A5CBE/4SnC
 ptVcCoAg4m6izl839EPyFTG0KP59xBKT7fCCadJIq96tyQXe3I0cjEvIbQ1/Acw7/po5
 tHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289020; x=1773893820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nh4xFu25fP4+98Q20GIy5ie54KTLY9e5JyU0jfcgH0c=;
 b=PqtgNoede4g5dqFWr4VR3hD00wAM8w5Q/OI3f+PcBZuHHBkalzM4WQG9rSrXk748XA
 i/nyWRf56FtjZeQfykL5FQvcGe5U8ZuPxoGt9Zs8hf0T7lhuEVQ9Qn2SWjlIFZ6d9i36
 2KxFnHO+oos8zQNvRyEbtXfkHWr5j7TeDw4O7NeN7dGumg3IBL37JqkcNjZVF9KoVpfF
 GIKRTCgqMVV+lEgbR4EGWXVI3MB73pPAlrGMKPGUBo/WWPKuOoIwy1IujXpJKyQjLSQM
 8d90J/5svaLh0Zmw/5I+SfR/IaLlZpy+CFBSoYCuN/wDHKTVsCrzovObhMmEaO2PN5uw
 mgOA==
X-Gm-Message-State: AOJu0YwBHbi1khIUqJHd7GTAOyiRydYY4oKDxXkBtaCFtNl9XxYaq5L+
 bekItmevjyvGU1FpuneBi4kMpEo5SzbHfZddOm/umPTmY2+ptCql63d3XAuU5EwB2KD+SUEare0
 lduAUJQuCGPnzZo2XesvIxXGj5HSyq6wH6Y0z5KH2kUNLhuqUi2rZwFYwNiB+AsrY2P/he9dUKC
 YFA6FFTw1OCclJBh9ZmbnVDgTDIztZ6T+WTkiWSkM=
X-Gm-Gg: ATEYQzxEVBfYcuce8YJOcKyf1Jux5rfXrsWFL0yHdJVtWtA1v/uT+dbXV1x5vGpfhln
 rPLhoP7ZqWwK6dQwprt45ZxW0OqEwiJydFUBjeuOOi6Qxn5BdP2eWiUfXXv5VA5mkmcJH40tmxn
 u+aHVekF865UJzt0nP4QQgepITugc8BHLDHajCFwYCrhfetODDuTAOV7UfyR0xUZBlwxVnwo/WB
 TrbObVFXcM/Lw5PyfBqZspyt3avT/9vP/dpItwk2fem4+vdejbiqHjyybPbki5kg1hHskNBuQX9
 fNQqNObXs/9zE2BPdw+uE3+vdBf1Q+Q9sFkmo1dMJRiSqP5ENZkDKLaBgWaN6nfkObuBdmoD3Q/
 UU94joS+LhQPS7yQ1AsioY4+FeCPUWlSiQXsQi0O+vTRTptbO/sr5CZGxK3Ryhw==
X-Received: by 2002:a05:6a21:102:b0:398:a97a:e758 with SMTP id
 adf61e73a8af0-398d78a44f8mr1836607637.21.1773289020634; 
 Wed, 11 Mar 2026 21:17:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:102:b0:398:a97a:e758 with SMTP id
 adf61e73a8af0-398d78a44f8mr1836581637.21.1773289020212; 
 Wed, 11 Mar 2026 21:17:00 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:16:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 1/5] hw/tpm: Add TPM CRB chunking fields
Date: Thu, 12 Mar 2026 09:46:46 +0530
Message-ID: <20260312041650.181411-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
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


