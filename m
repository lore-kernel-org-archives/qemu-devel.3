Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47770C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwq-0006r9-5H; Tue, 04 Jun 2024 02:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvo-0004ZT-0D
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvl-0007cq-SW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoy71PGVhW2t6jto2xgSYpTI6VjhvKq7Bsd1mn8lHa4=;
 b=RzCVYqHDmleECnTIphUxBLrRA0p+k2HfYyZNrci9hF8QrgwuwfE3d9LcD/gg1oZOfVJEWd
 +q//v5EgRP998xbCEXzUiOVRlW3XqDIBO8ZsHcKlDdwlG/sg2+N8z7SCPOiCK0C69ZC5Z5
 GYyTX7o25QWsHJuMA/cWsIz6E2sUj84=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-pADdj1WDPXunDkA9NjGngg-1; Tue, 04 Jun 2024 02:45:57 -0400
X-MC-Unique: pADdj1WDPXunDkA9NjGngg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68b2e99c38so157928966b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483556; x=1718088356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoy71PGVhW2t6jto2xgSYpTI6VjhvKq7Bsd1mn8lHa4=;
 b=PiZzG9YqBc6MBlhG74NWQ82VKct0LsgiLwZxGaVwaImgdvWP/qKMjqsUEk2ppB7mZ5
 8vOBMK69BHu+38uHsgM1SbPqfT6y2jSmoXmyB4U5UYiNE9viYT8Mm1cpNdMIkjFHIjFO
 Zm7TZiC1eqcVGwOdOCFtzWO9KGW8SIrqODKDq79M8/VzbwVcyjwnszJmEn1pSnLyywrK
 gBX4Uhe6vqkRYUs7aF6l0TJ4vdKbDQ7i4IqLMYnzZM5x6LzSVhaNi1++ZRhZFCq1yPKb
 jJo1gopEt8g+gai9p3yNXTWuPtaGaiMoMReZ8PDYjihAimqmp6DzMrJUniWlcj7Cu3Oi
 awrQ==
X-Gm-Message-State: AOJu0YwOWZrytNp18rEftuPcPKkbDnIZNwxxHpiJoj/AVpFEzHIAD48O
 yEN06bIVG7pgm6GX9v/enyJbWnan5uT2WrF797eWUm+B0j8M/dZps5s3izOzGK57NmgXywUC+0k
 qcgtna1fytSSnQk1TDO/l0IMqogiInaSOYMKechU7Xyj97qzozb/1p+2sLH1VS7ognjh50qZO1T
 J0+Zng1AWD7DMO3JJnBQvH5vC4mjljw5xYtP0i
X-Received: by 2002:a17:906:7004:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a68b73d3801mr578750866b.6.1717483556148; 
 Mon, 03 Jun 2024 23:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrzs7n388rS/uiupio23/9t7AgEDPVJETZu/fipCe7jEJQtphm7G+//LzaL13SIqHSj/XkLg==
X-Received: by 2002:a17:906:7004:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a68b73d3801mr578749466b.6.1717483555809; 
 Mon, 03 Jun 2024 23:45:55 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68fbf068fesm310585866b.26.2024.06.03.23.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 37/45] i386/sev: Invoke launch_updata_data() for SNP class
Date: Tue,  4 Jun 2024 08:44:01 +0200
Message-ID: <20240604064409.957105-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Invoke as sev_snp_launch_update_data() for SNP object.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-27-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 8834cf9441a..eaf5fc6c6b5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1091,6 +1091,15 @@ snp_launch_update_data(uint64_t gpa, void *hva,
     return 0;
 }
 
+static int
+sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                           uint8_t *ptr, uint64_t len)
+{
+       int ret = snp_launch_update_data(gpa, ptr, len,
+                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
+       return ret;
+}
+
 static int
 sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
                         const KvmCpuidInfo *kvm_cpuid_info)
@@ -2216,6 +2225,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
 
     klass->launch_start = sev_snp_launch_start;
     klass->launch_finish = sev_snp_launch_finish;
+    klass->launch_update_data = sev_snp_launch_update_data;
     klass->kvm_init = sev_snp_kvm_init;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
-- 
2.45.1


