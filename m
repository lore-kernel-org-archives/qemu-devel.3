Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9CFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENw9-00050E-IC; Tue, 04 Jun 2024 02:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvH-0004Dg-QQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvE-0007ZF-Uk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA/y1DfJBKS/73xmbANVgak1mNgSJBh5Ul2xMCcB2+g=;
 b=NpfkNyK0qyl6o+OWXxgTPzVratYw6zFlDWxDSiBLRWv90UMuSW8gsGc43DyFxlpfuakxaI
 2hHDKQ0lB+tcXkzZq4VCoP1Q4Fgb5wKck3krxxNtxJKbl7swudG8qbwXULVcQlTRfn2pIG
 mVE8WOLJb5My8jsiaEDWcxOzjwlLtFU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130--a3WzyhcPp2vnlZVXKd3Pg-1; Tue, 04 Jun 2024 02:45:25 -0400
X-MC-Unique: -a3WzyhcPp2vnlZVXKd3Pg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a50752cd2so2136300a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483523; x=1718088323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GA/y1DfJBKS/73xmbANVgak1mNgSJBh5Ul2xMCcB2+g=;
 b=tStHYDwE+dnCqGbSZ2CbfSvGaKruCxJujGy0aiyt2UnWDRi/PfkAH+aS0QKtHPbq5Y
 lvlsFMAbbTRnmf/s8txJX2F3fLWyrK0S34lCKCLbzN2+HGljjX4bXxiEovNR/JP9vxCW
 l1dUbnBKCI7Lv8B6bPT+hXP5b7ATQlxSN1Z6VOLXuMFNzRiM4NRDOLTMM/b0m5m1CwMN
 lB2mPjTEczitgL2oTUIs9sAQ61iSyZv7JmgRzAXFxbgbivsz89OnrL5MuW7kMMkRA3Ci
 rUtQpOyP13UNpAv5Ne4RKXNLQHtLvruUsCZ7EbXMX0LaZe3DUYpxiSX0x87REMrMoUzH
 t95w==
X-Gm-Message-State: AOJu0YwyWG3CfWZViVFVhznuOE6H8GkwkbiirW20+erJNvQYInQdkuzn
 VHF5WWAzQnud875V5ceaHdDX51GT19+7Bwtbsqh3PTItZIl4m/3z57xF6TDekqPGm8tpK5kOEZ1
 tDGviEsOozUhz3/kTTYjKhxcY6W7Be8EdGBfxbihF6p02HXyFIOQ+UxQ24pmwsqG/rTMlVQpevv
 yPsxnZ8NyaGFtD0ByzKq7SBa6uymASMi4Fk5fB
X-Received: by 2002:a50:c342:0:b0:57a:27e8:deb with SMTP id
 4fb4d7f45d1cf-57a7a6cb931mr1197299a12.12.1717483523330; 
 Mon, 03 Jun 2024 23:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWf0N3cqQxPlLvmtGV2qSglFItVfTZbCr13g4iaCwITCG7HCv+qeJAvA9Ut3biBSuyBP7e7Q==
X-Received: by 2002:a50:c342:0:b0:57a:27e8:deb with SMTP id
 4fb4d7f45d1cf-57a7a6cb931mr1197282a12.12.1717483522711; 
 Mon, 03 Jun 2024 23:45:22 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9c16fsm6803084a12.88.2024.06.03.23.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PULL 24/45] i386/sev: Add snp_kvm_init() override for SNP class
Date: Tue,  4 Jun 2024 08:43:48 +0200
Message-ID: <20240604064409.957105-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pankaj Gupta <pankaj.gupta@amd.com>

SNP does not support SMM and requires guest_memfd for
private guest memory, so add SNP specific kvm_init()
functionality in snp_kvm_init() class method.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-11-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 5519de1c6b2..6525b3c1a0e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -885,12 +885,12 @@ out:
 
 static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
-    SevCommonState *sev_common = SEV_COMMON(cgs);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
+    SevCommonState *sev_common = SEV_COMMON(cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(cgs);
 
     sev_common->state = SEV_STATE_UNINIT;
@@ -1030,6 +1030,21 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (x86ms->smm == ON_OFF_AUTO_AUTO) {
+        x86ms->smm = ON_OFF_AUTO_OFF;
+    } else if (x86ms->smm == ON_OFF_AUTO_ON) {
+        error_setg(errp, "SEV-SNP does not support SMM.");
+        return -1;
+    }
+
+    return 0;
+}
+
 int
 sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 {
@@ -1752,6 +1767,10 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
 static void
 sev_snp_guest_class_init(ObjectClass *oc, void *data)
 {
+    SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
+
+    klass->kvm_init = sev_snp_kvm_init;
+
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
@@ -1778,8 +1797,11 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
 static void
 sev_snp_guest_instance_init(Object *obj)
 {
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
+    cgs->require_guest_memfd = true;
+
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
 }
-- 
2.45.1


