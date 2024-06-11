Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A96CC27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RY-0006yI-Lo; Tue, 11 Jun 2024 10:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RU-0006wV-JH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RT-0005zn-75
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UESLOAT8c4Zm/qHI35z4dw0wDSvB6GAFl5eoxqQcv7g=;
 b=QQwFK8uKJyXP0U+fhDAC+oAPdpyeV8vNtqdb5nwwW9QzZ73M35kBMnJyuClFZTQIT1/Rsy
 74QJiXHhh5UcelaPvri90yuiMhSwjTRBh3Kgsl5PgsEs0bEml7BigYphMb/FlyTeDj/wlv
 TT2Ty2EQbPJdqtMyHM4hQSPY3v1+lsk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-1y18heDKOaWXzXP0x4G3zw-1; Tue, 11 Jun 2024 10:25:38 -0400
X-MC-Unique: 1y18heDKOaWXzXP0x4G3zw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f2662d050so80394366b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115936; x=1718720736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UESLOAT8c4Zm/qHI35z4dw0wDSvB6GAFl5eoxqQcv7g=;
 b=nvXyrqnzas0L0jx5lIGRx8p/wOADotX+wo2q+zmhZgZsc3LPC+geP2gMorBVBRaqdR
 JdqnDSrOhlTam3qztiUXd3i4zJ4v4VkxIbn94ep1ySbHL9WVAhWP3G3UlVKa7+7oiRvT
 nsdGTn66H05wsLkpqLXZOfevpC6H3t4toCDxrMkFFWv/fyVUCNu9Xwl3xlNXsW+uAflU
 b9r1/O420yMZv1wYhetRbP2K2+Knbpk6MMpjkhSIGi+Ljwc1k//pPEF1/sY0Zll8IvHr
 a7JjFggS8jPT6cMRtV5g+pZKdPxMLKM0Yvf8DbbXP16neWUT0545VrKc1FTIym/gYuD3
 Jyjg==
X-Gm-Message-State: AOJu0Yx3Ar6wOGx6H4/FC6TNfatPWTI1GTKI3yfBeACdAhp0g4U+4ZvZ
 vTzwlPR1kz+e/r3dpojwoF/XSd40q4Iw6kydsIRy7kC42+ZKgAjPzIPMV/iVKWuaYTyP2jHKoDG
 /7Fpb9i8lC7VSLQ8i4tNgPBcxQFMRmHefbzJjbpiRpAIVaNhRlSJVwwh+di9g97BekNH/GMKb/o
 uHjQlJcttwv4qIApTI4faGKBraws4zWxsov2bU
X-Received: by 2002:a17:906:a243:b0:a6f:3e5a:881c with SMTP id
 a640c23a62f3a-a6f3e5a8a44mr80818466b.5.1718115936461; 
 Tue, 11 Jun 2024 07:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDgF0p2D0HoeUesqSBpjIIMyBuwZ//HT7u7d76U6wqgIkOQR1wDRCY0PhfNtPcn0lbpV3ygQ==
X-Received: by 2002:a17:906:a243:b0:a6f:3e5a:881c with SMTP id
 a640c23a62f3a-a6f3e5a8a44mr80813366b.5.1718115935241; 
 Tue, 11 Jun 2024 07:25:35 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1ec85a74sm265976166b.56.2024.06.11.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 05/25] i386/sev: Return when sev_common is null
Date: Tue, 11 Jun 2024 16:25:03 +0200
Message-ID: <20240611142524.83762-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Fixes Coverity CID 1546885.

Fixes: 16dcf200dc ("i386/sev: Introduce "sev-common" type to encapsulate common SEV state")
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240607183611.1111100-4-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f18432f58e2..c40562dce31 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -587,6 +587,7 @@ static SevCapability *sev_get_capabilities(Error **errp)
     sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     if (!sev_common) {
         error_setg(errp, "SEV is not configured");
+        return NULL;
     }
 
     sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
-- 
2.45.1


