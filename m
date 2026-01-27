Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD529D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSb-0007TA-IM; Tue, 27 Jan 2026 00:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSP-0007Dd-MN
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSO-0008Vz-6G
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0WZvtS1qnQEpVvyt8WDpPuTWCq46G5+n4cXSJcdfvKs=;
 b=QOVPUB11cOgJXa3MzZOb7BRb+2LqDEkpRhFHsRI2ZGZRytHGnwyQML9hGvol3Nl/xzYtVu
 MLkZpQbPwPgBdOCKr2b6RXtPLhdSwyZCZf5z9J67GasYmuqJ+UUvWXRuH0AxtZPVfMTW6U
 nEA2zie89w/KOvEgCiNOTIsRFKj4Gu8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-JQjQrN8JP9aRqU1IJk2wPg-1; Tue, 27 Jan 2026 00:17:36 -0500
X-MC-Unique: JQjQrN8JP9aRqU1IJk2wPg-1
X-Mimecast-MFC-AGG-ID: JQjQrN8JP9aRqU1IJk2wPg_1769491056
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a377e15716so138320395ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491055; x=1770095855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WZvtS1qnQEpVvyt8WDpPuTWCq46G5+n4cXSJcdfvKs=;
 b=POu2JMdwNCRDmaZYFf8AZZx0DJzyVTUDDga50t5S4hbcKoSRInqOxlvN4glXOd4X68
 RLgoIBzj1zXDT/vssM63Opf3k0lcPgpyFuTt/DsA43WEC/fIxD+hRWGjBsa9IK8TGWVK
 NosUYjOwyY5rnx/gltPyFyxX88L1LJio5BBF/HfzygxC4XoX0zAe1FdO79Yb15EIdkJH
 1dbZz3gSeymRnl27HsqnM2xIDCVsJnRfG7n5LLEJJYNylbeNpXDjRyvZ/Dv2kKfto8N7
 EiWn1Gmke5nklA0FafKk/L6SesrmAqIorglfy8PupK8//hhmQvMSI4YPlikhwStyq7aX
 Uh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491055; x=1770095855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0WZvtS1qnQEpVvyt8WDpPuTWCq46G5+n4cXSJcdfvKs=;
 b=LhiEcVTgh0UFLNWTp8ZY/YlRB5wA93/0tAHDq05BVhJUsQDg9W9xcwpAzkcfdN7Trn
 iuhLyHXmTkwmxNQsfDrA7+gBRVmM7Aaw4Jll9V9HllQY3zD0o1LM3r5FX6OIwBw+ytUr
 Cd+Ut1am1IUEXAQKjpeKYL4yAlFolxq68HtonXB8UOuReuxXJnjF5tzx1uegZniP2hVR
 FRSK8aeJvMNYjkVSamPrzwYmZvkyyA+M48kjFpYktt3DmA98a17lePmLkKMC0b2RvsdC
 Sqg3npTy3AMeKVTdaIWM8KdmfFaCnPY4SYCfvBeq/radEpd81GqsPS+AJU33LlrzyzMe
 ASSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFbg1xd3JElCWnW4EWjuy7HqWMrRdoXBdMxc7C0NtFLDsl6TqXz90Fe/H4BsF/d7hbb3JeY76iI8Aq@nongnu.org
X-Gm-Message-State: AOJu0YyESmrsvizycZIEbODimUmDGemXAL3xFj6lWyQggJeS2csJLrx7
 lN70zpW6VTgr0cE2VG1/hURUo0F4GNvaYOFTK3U24I8Lm5HiLBqGOu7JDDftc/RQPBJcI9JLgoO
 lpIqPUE+B/iqjrajClwbC4+gwPLxJptYKo1DKMJvlA6urDCi7KRO89QvG
X-Gm-Gg: AZuq6aKgpWu3ILjrnn8Tl3Y1kCQeR+y+oYdZTjb+NbCD2DwxbimiZDbvYpBEiBZK5oY
 1F0uGD4nlkV94bR5Wxm0sYHUaGYSoUBXTCbce/y1La43vnceu9TxzWz2dDpjktyUse8nUMcAOBS
 GotcHoMl7WjiQnkegfLo8VeKjI4Lrn+wPulBbSFK/S6Gh9lypuQ9E6AcjOzFUeqOs9ssS5xKggq
 lLyqlHpQNloTnqDq4/4T7UZdVmwPHYJr514O+QzMYbOFcMwBlfq+xDTjQ9meARBLD8tML59udqv
 vLkQRKuIABGGfrcgSNKAt9pW1h3424I+bU/SMsZGjN17WSdJmXA7jlY3IREwkIlq+bxUVOnCir+
 BdeEPkoZDUVfFV6+z/2+WyqPOhRhz+DwdXUf2B2YtEg==
X-Received: by 2002:a05:6a21:7a90:b0:384:f573:42bf with SMTP id
 adf61e73a8af0-38ec63fb1d9mr471156637.53.1769491055553; 
 Mon, 26 Jan 2026 21:17:35 -0800 (PST)
X-Received: by 2002:a05:6a21:7a90:b0:384:f573:42bf with SMTP id
 adf61e73a8af0-38ec63fb1d9mr471146637.53.1769491055207; 
 Mon, 26 Jan 2026 21:17:35 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 20/33] i386/sev: free existing launch update data and
 kernel hashes data on init
Date: Tue, 27 Jan 2026 10:45:48 +0530
Message-ID: <20260127051612.219475-21-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index a65a924fb3..d1dc0f3c1d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1772,6 +1772,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevLaunchUpdateData *data, *next_elm;
     SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
     X86ConfidentialGuestClass *x86_klass =
@@ -1779,6 +1780,11 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
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


