Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E77E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyc-00048J-D8; Wed, 18 Feb 2026 06:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyE-0003WG-LX
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyD-0007vC-7i
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=MHyY9DcnCdObHVVI8YicCJUrkKRFAAY/soMJ7QtK8dv/urBC0ab4uzwtU2AzIXCL0PPLDm
 reVumu8rhiuUp74fVrQhbm6e2M3QwArysopHguZ75isbb58kL0jxUCegcIJLWJ0vTDfqnK
 BES/4uvkyKHH1sl5sr2/6XIOL/hv4o4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-z1paCqalMVWJUDFU5RUulw-1; Wed, 18 Feb 2026 06:43:49 -0500
X-MC-Unique: z1paCqalMVWJUDFU5RUulw-1
X-Mimecast-MFC-AGG-ID: z1paCqalMVWJUDFU5RUulw_1771415028
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a946c0e441so53230335ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415028; x=1772019828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=mAfUU2TCPwCFDK/Nhh7/uKK4Ce/KaXmnYrQ9E1tvAvCsY83bkMg0iryFJel4raIS0j
 SWy0Ooq1KH3/8nUvMoc3Tm9R7+9gDLNEMjW1kUOQx1pVGGupEu0+QzsuayKfV/48HEeU
 55RixzTXmjzELUObw5NvHY69qgIxPKuNREWiqf2fMSg2VWvGxLx7bbtWpfui3ndjO+Dq
 ECfqQHgJVVDH2oql7eBRhzbt7EEYKDDr8/sshmYaLZOiwiUeDocabIvaNRzyfPPkMCh2
 fDDhsG2iwPL45ngOYFT6fTxWp3QvHJCfifvru0VQWoWge5j+Q4//B+magfTR83zS/4r6
 9xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415028; x=1772019828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6P5ZMHhQ1gBULl+0OpCFy+J1BWjsvb7Pt0GdIxytUuE=;
 b=nXc1xIF0GtTA0TKJIMYfK8iUF/cT0wC2HuDnJfTvaYBHfBkZXIHCzQLRrozhPCuJTe
 +bk7UUw1fiZ56KPqYXuYetkvlzMWBBZGx73N0tKmTeK8YrKo2SfcvW/MR8tj0MGvLU4x
 Of3T3pvLIQzmh/5RkBa6AcMF8+biPSAwkEnGnyJm2uuJCWZUSPjhpi+D098RvvxQhCGX
 dCXak2AvSQdEW9sGq9RRZSrhF1CJKZ2euu12NW6icxA2fm1Qss4181SbmEmhThCEC4P2
 DvTSPBIE4+JmiE/7C8lqits+8xmzoyquv+fBv8mWJcwTcNLAZxTP8+V0vhbDyZOS6q6+
 MgAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXImv6jACC5/kdwkdM86Xu5LvK4fUc60nbrGkPhw3WrwJ07FBZOdH54LRp/dgeHV+2wuPqJj0z5tdqC@nongnu.org
X-Gm-Message-State: AOJu0YzqQsx4+CGbwq5AhDkoCz8r05KO+6ag8jlCD5Gx3B64BRq/ExE4
 ElgUKijkLOK4Ml6V1WtMorsItuU1L/dWhgIw/LQo9/ES7BoS50nOC+oAmrpvoZZx8Vjo6l1qE+8
 d8FWQ24HPjz9cP3kRQhMC4Ob4CffwHgWr4n0VQludkVYDn4C2FlxwtFh8zp4mfVMd
X-Gm-Gg: AZuq6aK5sxmh7d56YSwNi/zcykJOq07S2vaeV+/2EZKNgBQ+d47yDnsY3q4ALV1tN7p
 QNs0rkaECVZqPNO0al0l4Jiwo+1HRBnXBndq173BeB3FM9ixG7pZ7CGyKPPVIDfmC8TcM2lhX4A
 g5CJyoMEOW9mTxzsvB5oZhDcZ1362uApu19TJ+ZcFBSMZ62CN0ByevP53EIGz03Bmb3YHZ6xCc4
 PLovCftsmFiiENbQ8TYyMgtQXlGaHZayYH2Qx/fHIm7DzgcyEkkC1FdWvCJNRy/eJx02OEGob8i
 TyX6lXpofYEH+M5ZSTWnftlYu8/rr+FCwl32fWL3r8c3wtfK8xJD0ZSfgIrjzd8t32VRX3YQjFp
 gDg9mS9Lui3MXxqPzqKEVdeqJABcN0cjltLVVvtSh/6IcugxdR9Wr
X-Received: by 2002:a17:903:19e3:b0:2aa:ffa0:4454 with SMTP id
 d9443c01a7336-2ad50f5fd5emr17898305ad.31.1771415027883; 
 Wed, 18 Feb 2026 03:43:47 -0800 (PST)
X-Received: by 2002:a17:903:19e3:b0:2aa:ffa0:4454 with SMTP id
 d9443c01a7336-2ad50f5fd5emr17898095ad.31.1771415027447; 
 Wed, 18 Feb 2026 03:43:47 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 20/34] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Wed, 18 Feb 2026 17:12:13 +0530
Message-ID: <20260218114233.266178-21-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 647f4bf63d..b3893e431c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1773,6 +1773,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1780,6 +1781,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     sev_common->state = SEV_STATE_UNINIT;
 
+    /* free existing launch update data if any */
+    QTAILQ_FOREACH_SAFE(data, &launch_update, next, next_elm) {
+        g_free(data);
+    }
+
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
 
@@ -1968,6 +1974,8 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     X86MachineState *x86ms = X86_MACHINE(ms);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
 
     if (x86ms->smm == ON_OFF_AUTO_AUTO) {
         x86ms->smm = ON_OFF_AUTO_OFF;
@@ -1976,6 +1984,10 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
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


