Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6492C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHK1-00042c-D6; Mon, 14 Jul 2025 07:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0I-0001Ls-MD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0G-0001xZ-MJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEj7OUeiZaj5KbOO4n1tkdCJTwkHNuAAciWyaP56m5Q=;
 b=RXIFfQyQ+856lJZc26Fr3LxO6SgG+xTiR22T6cmtOBFuMO5VHG9yD884M9qKY+l/ttQmwe
 aW/MLMnU463GpY6M4JXVyupG3yMxt316TIuMSxn/a05P8vDW78Bihko/KmvhEptOY1aX7Y
 NNQDEnNZAlbIWqkxZSQY9xjrDP1E4ec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-_gx5G_ljMKudNl1REvnSSA-1; Mon, 14 Jul 2025 07:05:46 -0400
X-MC-Unique: _gx5G_ljMKudNl1REvnSSA-1
X-Mimecast-MFC-AGG-ID: _gx5G_ljMKudNl1REvnSSA_1752491145
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso21441865e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491145; x=1753095945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gEj7OUeiZaj5KbOO4n1tkdCJTwkHNuAAciWyaP56m5Q=;
 b=LMGm2Lg0v2uYVJlyjePKYYOOiSbvx1Q+c3yAfswLU+hoj5PaiC+Cr+OvQNXIr03LZv
 NuPpAsUl+g/XBqZ0ajh2DeiRcKnYdig8N/Y0F7e6cKYXmtLCzY477kIiI61m+4ZDYwML
 fbWIsPSiQ4E4to3rRQQSmfoP0adJqwgk33esCSSfLipJ4uuRwY7aAcIWq0HDg6WlwFKz
 DmoTRTp/dWZpLnQ9kNlMXKAeF43DKfjgUAWFPpUn0ukxeAxPJW3yUFkRhcOKEKJwWuWS
 9uuZ2FhouW+b0/FikHDaU1YofJX3iWt0bM1eL+Lvrf9YUg+0YZ8Q/djAPfNqKbQhqBEr
 LLDg==
X-Gm-Message-State: AOJu0YzOuEvvBmGTp0GjN41mpmz8Bc7L20b86M5PBBUJUeUvZMHBL93F
 YFmNQ1DUW6DEFhBo4VCnjn/K2DxHaGp0lyxwng8S0qty/vO/lKW4wwNUfRFFp3ZS7aPcIi+vYkp
 DEaPlW4ZzwbKOW84VJja2RrQn6dPo+iTtWTKi+d+WOja6KeWRzohRbWkKifK5VgIQxA+selKVTU
 kiqFUcRQ3KjbFbMeXIDDN6SyAQPB46tNtcgOJQ3Qm5
X-Gm-Gg: ASbGncut6nhzlttB00cQ+xvvLqKn+GQLVAqO8bccGEFFoBVwUHCBtff4xhlpEZsYMEb
 O56/vNLqZh/sHX0Gewh1aCaXOQsA3jG7ogxdz9W5yvInaYF5ioNBJ+JuUE2GR+JXwoK1acDLjrq
 f85Grnhsx6fJjegsGnxgVc8rZbl4jmnTtZpu1wvcxLnix1TmwWBY5trjAK7zQpGCcAbYXa5M3Cx
 LATfedTmZNWPyfNQqZ3JPC30mJ33dzzFYGjwS5Npg+n2p14XjgfW90JyJ+iF7KzDYW1f8k1fzhK
 gBhC6ecrCDirwkcnTFq62TwO97vHblRMIEJM8mYavI8=
X-Received: by 2002:a05:6000:2388:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b5f187d0e3mr10951920f8f.7.1752491144988; 
 Mon, 14 Jul 2025 04:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnsRLedO6U/Niq8M+7MzRou9iceh2Me5J+o26pxc1ZFLlkyyQkF13iZrKDTp67gbIUBCwTmQ==
X-Received: by 2002:a05:6000:2388:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b5f187d0e3mr10951897f8f.7.1752491144529; 
 Mon, 14 Jul 2025 04:05:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e2703csm12095979f8f.97.2025.07.14.04.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 36/77] i386/kvm-cpu: Fix the indentation inside
 kvm_cpu_realizefn()
Date: Mon, 14 Jul 2025 13:03:25 +0200
Message-ID: <20250714110406.117772-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The indentation of one of the } inside kvm_cpu_realizefn() isn'f
correct. fix it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250630080610.3151956-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index a99b8764644..89a79536594 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -73,7 +73,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
             if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
                 host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                            &cpu->mwait.ecx, &cpu->mwait.edx);
-	    }
+            }
         }
         if (cpu->ucode_rev == 0) {
             cpu->ucode_rev =
-- 
2.50.0


