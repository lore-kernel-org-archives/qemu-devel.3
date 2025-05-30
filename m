Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16DBC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1a-0002C8-I6; Fri, 30 May 2025 03:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxy-0004bM-OE
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxw-0007GW-24
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLPIAlLGq3ON6ae4KeoNaGH8uIU4FgqjV03BoMS0gZ8=;
 b=cfcPPtRweQ2DhuwLd24d00h+Vnt4dHKAxAPh23mnY68zZHkppgKMZQC8NgPICHYdEJUg1q
 eXDtPCA1No4fAJYCMTLKvpZOhY3KE6LMrPseat/q9Ovv37uxa3GYIPsBmlgvOM1rjuoqhi
 rDHLtQpGV8lTyjjw6EsfnKWlX/tPPbo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-e98Lblj8NVC1RJi5IFnivg-1; Fri, 30 May 2025 03:15:42 -0400
X-MC-Unique: e98Lblj8NVC1RJi5IFnivg-1
X-Mimecast-MFC-AGG-ID: e98Lblj8NVC1RJi5IFnivg_1748589341
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad8adc22e88so166117766b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589340; x=1749194140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLPIAlLGq3ON6ae4KeoNaGH8uIU4FgqjV03BoMS0gZ8=;
 b=Tf/rQen8i6ZnzzotvmcOWVQMFaJc7etFadr/07Bb3ZhIyqvKcx1I6rwM5w18YbqdHJ
 OQ2fMeVIapJ/KUPLk0tLgMHJjdcXRWsT/RTRZDfCJAfsOihgy9iNbq3t/+3hRefTkndb
 UYvcjnq7gqMzITNcfDX7rYlj9Gmnbzl1XdjF2dfrd2aetia2E9z4gOfSnEBxwtIi3vit
 PZ4ooJD7Ji+pCFN++GFgwg3uFGLuJqC0oR84yb0SnTjTIOUkkDUMj5l0FP/3iCZGCwGG
 TmuzWL+CoSQ3Bc9jB0Xpb4VbDoqKS+hpsOeOVXdMGHYl3aS2H9I+WBrejgs+O/cCVUGB
 oErQ==
X-Gm-Message-State: AOJu0YwxTA47VhJFGAS/HpiGR9N1Hoplno5SKInMqzaoRcQgq+N0qYWM
 7YWqUPBR/kX2VZhjDCb5zDiYmLejEM20aYKjEDptw/4lUO4EJvCwMzaff8GfmKApVWRt3asu3+N
 Wv9o5Wo5tOtoqlHP+pFA2XCWdP8PdR+cI2XWbhlxapooq18PhDoSVmrcbOxZ+7+w5mYPwI78O8X
 hEcyuwQKXXTM/M2eHpQlkF+9+2nmk5pBW/O5nrqgWn
X-Gm-Gg: ASbGnctogCxwPDu+c1Wup2iTE3icZnEQA/I0a7DcSRqjXYElKFfgMGVmSNY6y7jf6XG
 NqY0lKSU8gT8y1VPWUxW5aC0ly/goYHe8ELVgmW5ZfOE90FGjs2HIf80Cuv2nm26m8bw8ufJ8Ht
 3amlLouyGIqs400yfpaKER1rBLRfqKAwW5BAB3PF3aILcqhcPiulWTtbPpkKZor+6TcYQLU8JMt
 ylCZz9Bep3tqfqi8EpLh4UawiXrscLY1xJmNxV8AQcT2lOnL2ZLzD9k+gxs8SbTEbLrqTnuH2m5
 U6un+tB+WYIMmw==
X-Received: by 2002:a17:906:6a1d:b0:ad5:4a43:5ae8 with SMTP id
 a640c23a62f3a-adb36afcf8bmr114195966b.12.1748589340212; 
 Fri, 30 May 2025 00:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHym3IzThm0AAWKGXWepTSU7KITCsEfTXMQNePkjuKPFljtqsJ5+B9pNtZPrjAGZB8/lc5X7g==
X-Received: by 2002:a17:906:6a1d:b0:ad5:4a43:5ae8 with SMTP id
 a640c23a62f3a-adb36afcf8bmr114193366b.12.1748589339776; 
 Fri, 30 May 2025 00:15:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6a76csm272999466b.165.2025.05.30.00.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 67/77] i386/tdx: Make invtsc default on
Date: Fri, 30 May 2025 09:12:37 +0200
Message-ID: <20250530071250.2050910-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Because it's fixed1 bit that enforced by TDX module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-54-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 76293029917..a55ab436ad9 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -742,6 +742,9 @@ static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
 
+    /* invtsc is fixed1 for TD guest */
+    object_property_set_bool(OBJECT(cpu), "invtsc", true, &error_abort);
+
     x86cpu->enable_cpuid_0x1f = true;
 }
 
-- 
2.49.0


