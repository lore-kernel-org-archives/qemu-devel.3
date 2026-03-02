Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557ADD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvN-0006us-Fr; Mon, 02 Mar 2026 03:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvB-0005w8-G6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyv8-00021B-FF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ctp31faHRscLU5956r9Sxi2RU43/0uUnrBnub/aS7BQ=;
 b=glaLZzWJcPpdiibKa1xSWV/rCecMbbkYzlNiM/3l6//1V5gM4RiVxwxIgobSzCdvMyXuQ6
 jZ2DJJR1IS49uzOzvOfC0pawtyducjBaRyGWErB3UG0zAfzJquYdmn4QIbqzohOLlCyZol
 0i16LXY6GAWfgONn2IDj3lpRw0VjX5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-CwYC17V1NgWeyabo8DVACA-1; Mon, 02 Mar 2026 03:46:27 -0500
X-MC-Unique: CwYC17V1NgWeyabo8DVACA-1
X-Mimecast-MFC-AGG-ID: CwYC17V1NgWeyabo8DVACA_1772441186
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so47402805e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441185; x=1773045985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ctp31faHRscLU5956r9Sxi2RU43/0uUnrBnub/aS7BQ=;
 b=tLOTij5xC3jV+VaB8s8t1vnzMZ5Lm63qci69fiw03rxA1PXrwACImBml49yrIY9zNS
 7G3ZiZyQNeHBCxPB8ztD9Kh9Ab9CmHvNkgTKYKbB61uJDUPJFe3wG0dD8iT3ckNEaOy0
 ASdfSc+NaBB3qwWidaVxICvCj/mqe/XiLcCfUNgj9zrp3FpLIiMd29vk/xgQ3uWmMmCW
 TmpyOLXfDIRFxRHfLv5sQv3NRv0OuCQb8h1/08Tv+X4x4Laq8kBzxP7+ch45bMdJGZMv
 BAoBAVgAbFVKrArtjX9fKv7A8Q77ZrE84vPabJjTQFZFVOSatJiwscJ3FOjQrYyx+atm
 024g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441185; x=1773045985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ctp31faHRscLU5956r9Sxi2RU43/0uUnrBnub/aS7BQ=;
 b=t9+L/MWoO+uaqhatt4xrzWUC0iBDFhY+nGTsAQb2vxz7SIWeyNQuxoEm/BscGsyH7c
 G3UAkw00Pk42Co8XnKo2bq2xesoLm12u4H+orXOtMJon3lz0AY3YNS5TF8Q/aWDrII3Z
 caAkFlZVHhPVOTxrMGEqGdJoPDcHpMEfBSo0D3e2ZgUV7yrLiAeK9+3E6QiL+uotBqXP
 gcByZuL0COe+XkhRRgE8PLA9GPvYlnm/+h0+u2I765f/ToyUu5PlHXALmYy1xFzdfCUN
 RoSKqRjNxWgRKSQeVCnoAfXQbV52nJNcDW/lIUMyIwBCclFn2sxczOnTLcbgdlI+djZJ
 sFcg==
X-Gm-Message-State: AOJu0YxSQkOPZzdAsHqZTbqwCK7gwWNnEM+hJLJDkyUmH77JGuMNncmD
 rE9i+mR1++wJGwxN1+LzaMT9t0k23On+QZggm8XC56j4q5Ltm5iE8jk0qRpF2OJBCYWIIZaw7oC
 Z/dM01tnozUYNdKYf3e6xHBC2f6/eDH8+4k4qMlIysA8TVVJC4nvxHG1Uyaw/KwVp663NQdw9g4
 sOQ+pxLti9H3Mzw/25yyHDaAUBCxl3Srh5Dlg2nJZ6
X-Gm-Gg: ATEYQzxYH+/RgrXSD15Yr30hSIQtZAnzVppcF14sZoLT7La3jDFFFn1pp8eov7UTiMB
 HchnAaIY6WWx4EOsK426H8UQVAeF+tZL8BLzMCpuzuAVxyEwYZQM55gavf9Fu+GSRXwUgfDgQMl
 apJrHFZUQqWoEBIxzMGODuLuW9rAEeLQmn5RTAOuP/w5nLC+iEu7kvddsHjA33KmDxMrj58RgMR
 WPirZyh5lX7wKuJ9GZJKiKAbu3CTZAidwWNTQo+k4MGCqT15tO1wMPqsBOmUmlcWmfMpe2WRVHU
 xbQzOdnG0/42zCE/oR8wFy7sM4o+WpV/ktHRlh9oNgAIjJj7WPMTLOMfw3tWZN8uYpwEt+4j7bU
 CrAFJ3bDa2iqJa7eL5tp+bErkuIdqhMEFgQuQSmhkSXsX+QvbD7opel1GbEu6+lwds4cHWVJndr
 OM7XZZfUZW9Tee1V/wd9SPihYkuOg=
X-Received: by 2002:a05:600c:4ec7:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-483c33cab41mr264453085e9.8.1772441185365; 
 Mon, 02 Mar 2026 00:46:25 -0800 (PST)
X-Received: by 2002:a05:600c:4ec7:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-483c33cab41mr264452605e9.8.1772441184853; 
 Mon, 02 Mar 2026 00:46:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7030b9sm317786045e9.4.2026.03.02.00.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 062/102] i386/sev: free existing launch update data and kernel
 hashes data on init
Date: Mon,  2 Mar 2026 09:42:57 +0100
Message-ID: <20260302084338.473368-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

If there is existing launch update data and kernel hashes data, they need to be
freed when initialization code is executed. This is important for resettable
confidential guests where the initialization happens once every reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-22-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 647f4bf63d5..b3893e431c4 100644
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
2.53.0


