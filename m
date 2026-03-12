Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7EC105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drQ-00042V-6P; Thu, 12 Mar 2026 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0drA-0003rx-Va
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dr7-00019n-A4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MgY5YREgmMJYwQV2ZvLduP7xmgUOYd26sS/Y1PYJ7k=;
 b=hkZ9X5czWkQPWVQRDXytX9N5vytq78RA4IZmwkKnGylmHQo5YYqtuhlEhKpI4b1VrdKckr
 rHWeq9UrAplvyoC9moZOo+gOgs2hQrssL0ummzXrpzNRcDTghfIeqGQrlu17u2CDZivM8z
 YgUSHq0Kz8EtAfQCrPtiISfrmpWmPHw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-YQzRYm-wOye-TqJMoJktqw-1; Thu, 12 Mar 2026 07:05:27 -0400
X-MC-Unique: YQzRYm-wOye-TqJMoJktqw-1
X-Mimecast-MFC-AGG-ID: YQzRYm-wOye-TqJMoJktqw_1773313526
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbc5fd75so561350f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313525; x=1773918325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MgY5YREgmMJYwQV2ZvLduP7xmgUOYd26sS/Y1PYJ7k=;
 b=o+hdVmadxGY+fVz6KCt5IWt98TGE3ga1AUP2KFj7WWhjd5YkX91MFxC47I01E6nu2E
 wVOO3L+x1CJPRhBXBp9KF/ha7yfQyE+67rtLFd08WMIhwvZw19K+yJg9+eUJ5z6NJpgW
 JuEWgjeocV8qFHDO5HW4A6hdwYmscjIC+PJxCVNfFiGyMvAgRMTZocnl/uqWHUhzYyd0
 9qvTBNpKIT7/FiRj5KWDjt3HcXO1871KXebfxVxoMSw/cwdTJURYgvCOZudplp8Rsxg4
 JDBXhoGXTJG+9Bav8BK3yEt2w6JSFPmKv42w1Knoo8Imhz+3fraXUjLkNK4M7u4hbzcc
 m9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313525; x=1773918325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MgY5YREgmMJYwQV2ZvLduP7xmgUOYd26sS/Y1PYJ7k=;
 b=Y7rlqFr2iUFxCz1cWxeelQAYZESu3Dwibb6dXtvc8nV5WS3PgcMskQbrB7TW0X1v4m
 10/oviy2+AabOh+aXPLdT4WxkXwKcFvUyh6SQRznies248gSebItpf3d/bNuKGz4dkq+
 mwCleHa7BLIC54qxuJlrM+6+8JUF8NeqdrBhUQ7QKlywh/1fQbhYvqvfwMd+jZVz0PtM
 bNH7rfxn2kOn8e60a4I/oETiuyN23G6jnwgWArKVE9Pd0dxFeFFuPMRYT5PeSgJrDYJ6
 Du+394N5v2k0jxUorLT1JoX/H2OXOVCxXeal2lPFCkdoKiDAF0nj+w3cHnNqSUStfaFs
 1umg==
X-Gm-Message-State: AOJu0YwZDdMfBjwvfPAD+o5Pbs8FB2h0wkuBOhFG5rlHNIcuRwk//G2o
 NX2rwxurk/Sx1XqPhCp7Oz66tQ9fN5gg2qdF15fI1ss2PrD57NB5zdoZPd1M37zRu6VhEmfaEmb
 9ZKN+QXwEZ92dqEB7NrtMxjG7w4vCpAwBeNxqDUshdUmhfoN/3s4TtBZDekoAQQiHI8YUxF9gxQ
 Gh/v27DbtDRQyhOCEMjztW38+ejIb0/9VRr2k8fS8K
X-Gm-Gg: ATEYQzz3ZA5Stj/Z06NT/TsyWNLHcI1o3sxKvGrYcplXSGSPh0WKf1yVrx0RGBLpKGQ
 fZSNKvd0OWVXwZTgPTCCttWNo2lbp97K+8ytiLf99Wu/vOJMQ7AyHgEobu5tsEicOyhihGlEVrt
 79SytmfVarJN5AzDNU4vfQiTVHg5yrn+CvQGkEDiOpZyFFRWZka/zNQWTlpCxm80iPC49HrrpwW
 GGA/it0VcTCop+wKLXO7fAzq5zUInpCdKy9Ae6/e+1ctRx61uAuFo27165igfoFZR8mLfNfhDSr
 Ke1t8W835blhoqJWaGdBepb7me3KJpM/IW5Uyj1BTXPCDblWEjWYm+NJ9ftdYEuZMohboh2PlFt
 BmOAifJ3REhSmejETfUM5vwnEEA6gXNIG00W77fginzQjO7LblfGh+5W2ULNqhgCmRlX+I2nTdu
 hGdmaqQLxcsPekyEZKFCT7QteuyDQ=
X-Received: by 2002:a05:6000:310c:b0:439:b3bb:276b with SMTP id
 ffacd0b85a97d-439f8222f4fmr10521494f8f.43.1773313524531; 
 Thu, 12 Mar 2026 04:05:24 -0700 (PDT)
X-Received: by 2002:a05:6000:310c:b0:439:b3bb:276b with SMTP id
 ffacd0b85a97d-439f8222f4fmr10521421f8f.43.1773313523868; 
 Thu, 12 Mar 2026 04:05:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe21b631sm9128382f8f.27.2026.03.12.04.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/14] target/i386: add compat for migrating error code
Date: Thu, 12 Mar 2026 12:04:44 +0100
Message-ID: <20260312110451.685161-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

If cpu->env.has_error_code is true, backwards migration of a VM from
a QEMU binary with commit 27535e9cca to a QEMU binary without commit
27535e9cca will fail:

> kvm: error while loading state for instance 0x0 of device 'cpu'

In practice, wrongly setting the error code to 0 on the target is
often unproblematic, so additionally checking error_code != 0 in
cpu_errcode_needed() is not enough to mitigate the issue. Instead, add
proper machine version compat handling.

Cc: qemu-stable@nongnu.org
Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310154348.495332-1-f.ebner@proxmox.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 1 +
 hw/i386/pc.c          | 1 +
 target/i386/cpu.c     | 1 +
 target/i386/machine.c | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7bd38f0c039..0b539155c40 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2361,6 +2361,7 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
+    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index addf602da08..4b53b5be4a9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,7 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
+    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1debc0c61fc..5b9ae79f165 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10651,6 +10651,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
+    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c9139612813..48a2a4b3190 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0;
+    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.53.0


