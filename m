Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42550C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuu-0004qV-Vv; Mon, 12 Jan 2026 08:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu6-0003BH-PA
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu4-0003ox-Lu
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbSNbKmTexfLzSNcOAGGTpME53mT2JoY4BGZ0NYwZQc=;
 b=bwChIUKkrWQyCCfRt3j16+QwZOY4VEvboD5JUNNpeIZ0No8EDpz6in5Z8sGVhqUw1cJcbS
 krDBOxuMRdImbjJcL/Qu/nKT+Q8SLYjvolNPScuqDniEPY9tiIys800WuWbodTjhj1r7GY
 95u+uby2QLjft3Feca65qHJmXTyJ6Nw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Wd_8y5h1OCKo3BuVz-tC3A-1; Mon, 12 Jan 2026 08:24:14 -0500
X-MC-Unique: Wd_8y5h1OCKo3BuVz-tC3A-1
X-Mimecast-MFC-AGG-ID: Wd_8y5h1OCKo3BuVz-tC3A_1768224253
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c552d1f9eafso4718921a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224253; x=1768829053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbSNbKmTexfLzSNcOAGGTpME53mT2JoY4BGZ0NYwZQc=;
 b=n+QMuH7QGWI4PufVCdVl6Gkb3v6ENx9th2gGQUvWxOfl3SN+Wfs49JjMB1VzfEQjeB
 VNn6rz5Tcm0msQpVEEokeU7WEXhYfabaVpEqbDAC3AcWhF6w10/Itud1CHPUiCl/YdhT
 /xSFf+rtyCgHTtigb0F664E+0zsXhldKAJiJL/iTMqjr2p/JvZ7n4pBTB2PYFmdW5pof
 3viSk6s9kM7HArrWHWDGOJbUuGP2u5GVMHTVtCPsQjDC3HKXOIMsq0jPnTmpG9Mcm+X2
 3ow753tCLruV+bEAWf+CfUM+Ory0iighFbNmMg7UxZjLfKVkpy6OWcQORv2AedX2n+xW
 TOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224253; x=1768829053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WbSNbKmTexfLzSNcOAGGTpME53mT2JoY4BGZ0NYwZQc=;
 b=aW6sO4bH9An64y/KTXvP4YW070igKambizKZ1TZ8JJnqhyt4Wmjkxo8eL3rvyoU+X+
 gI1dJVuvSQpCh3A9ss0JgPMQ2UEhHBDu+gCmTbXyoM1gsWfHT6/B9EhCK/AE8/vWdvRX
 n5yzXyUMptxDU2Mgh/41ANVjl/l3OdzgUXuweR62eEmjhVBChOb4K4eyqlo11gUd6vJz
 XDuVGnQ3qPHHJJSu8OUa9LNHKQh87METqgEX5Cw+To9u70ct0srIcJY1fGJs8kqQinmk
 RXcdcBU0ABVORsRekSfwFA2jN2SBwRzG2Q1EW4hXL/UkVC0zYsWxzPEzEnWrSUHqo26E
 ltcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj+S1lA1VCK+EqUIOzT2QYGt+7sqdR2toUbB8RIrxlPcr0BlO7UMmk3oYVuDXfe787Z/ZSjUV9ZNGe@nongnu.org
X-Gm-Message-State: AOJu0Yw+xhxl1CE3rZwCByXSHAZVhlYmPbpB9hl2pmQwui2K07hpmf2i
 eNHX/5TIB/LdGjJpsxPdThXBZVo/m76ScN1sPDPl2hbbERAIINku7Rh3wKNzATNvIZhcrb0QB3A
 VqtEVtcEejqlrJjEvD7vCoi0FzvlY8LEWqis5PinHEHmkShhDkm59lvKq
X-Gm-Gg: AY/fxX7RWPZDpq//UW11nibv/V4hrKwTdnmSuFTOcOHrErLLiQeJs10QVskD90tWy2R
 Nxo9KRduBHy/YiMAxiEUe32ByyHmvV3ICHS5OKEHhM+wN10oNc5EzQsbvgd84x5B9RlocmjhxLJ
 b/mBllMNdzuOxQvqcBoDBI6sSTiOBaYE9tyhfBI0eWn1kKGyEK7ntnE0dq27D6ITaZ+hh/rn89w
 KMbvvbKHZYGDBAi/dCHN7lBLGWpHvUypZrMzAZrHwQm9R3KxVfQ5YClZR2O83HulBch45eQzb8r
 DisZOzcA/FohY7LBZnQHbuTDxYvYuCroPRY2RGWedmhWxdkL7xacHvk/0xxN8h5WhlpOp/7Wk9i
 5uldsHvAyAjtl8TGdtN7RAneZCT895eFiHtQH5kMHmXI=
X-Received: by 2002:a05:6a21:3381:b0:35e:b995:7098 with SMTP id
 adf61e73a8af0-3898f8d0267mr15548747637.9.1768224253121; 
 Mon, 12 Jan 2026 05:24:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2OK+gMC6fAaYfSLI0gqpQ6KfWfNIPVV4x1e2pkcK2ja8trgOCdiiDYappareAuAFJ5KU3LQ==
X-Received: by 2002:a05:6a21:3381:b0:35e:b995:7098 with SMTP id
 adf61e73a8af0-3898f8d0267mr15548727637.9.1768224252679; 
 Mon, 12 Jan 2026 05:24:12 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:12 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 18/32] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Mon, 12 Jan 2026 18:52:31 +0530
Message-ID: <20260112132259.76855-19-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cb2213a32a..d7425dde96 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1768,6 +1768,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1775,6 +1776,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     sev_common->state = SEV_STATE_UNINIT;
 
+    /* free existing launch update data if any */
+    QTAILQ_FOREACH_SAFE(data, &launch_update, next, next_elm) {
+        g_free(data);
+    }
+
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
@@ -1961,6 +1967,8 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
 
     if (x86ms->smm == ON_OFF_AUTO_AUTO) {
         x86ms->smm = ON_OFF_AUTO_OFF;
@@ -1969,6 +1977,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
+    /* free existing kernel hashes data if any */
+    g_free(sev_snp_guest->kernel_hashes_data);
+    sev_snp_guest->kernel_hashes_data = NULL;
+
     return 0;
 }
 
-- 
2.42.0


