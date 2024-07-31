Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5485C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Lj-0005a1-Tf; Wed, 31 Jul 2024 07:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lh-0005UE-FD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lf-0006mc-L4
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Bnh2khxE06uRGlglbrZqD8PmhxT2BPf5aSSDHqB2mU=;
 b=CjPFQs2wxwhMap8AsvibqOvY1J1QoG3895JwWrDgPD800vSE4Yg1gqS3WBlKumopaEJeNy
 uFjqYbcySFoCKZyEDaVt2DXu1Kr+bigvaoMLk4oIgBqILh5oQgiZDoweVqm0AgheDYGCeT
 D1Yv1L85+odSTQvjEd3CakbUjkUFvjc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-SDkhY_fPN9OugKcDUiKjQg-1; Wed, 31 Jul 2024 07:18:24 -0400
X-MC-Unique: SDkhY_fPN9OugKcDUiKjQg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7aa56d8b14so502985566b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424702; x=1723029502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Bnh2khxE06uRGlglbrZqD8PmhxT2BPf5aSSDHqB2mU=;
 b=MW8mwkk6bhTGA7zi/ev0kmX2VfkF4+xooeoplEyozqtCDygT4WT2Sy04JdlHgzHWjm
 qaTe2m29QLxI1oxa8tyhS3iJ9DHXMp8d/RF4RxVXwcLDCximYmvPVH7I5R+DhwOCMjxB
 Q+Y2rqXeQU69wVlcZQrQDf6EvLqs4WT8Pn/pRxkMu530mx1FXPjqJBIHdsa4Rr4anAVI
 D4YFBXkJAxgsN4HfxGOcRGQSBJLgl7ZY/hb2GxhRnNEISDL1GgE2XXYNORPhrJNKfcIm
 dQL/aPa1R7bG6UkeF/10IjyM9/MZINlHdgrgXnb5igUEqM50m2GeaJtZFmUz7mDGjvgB
 TOtA==
X-Gm-Message-State: AOJu0YyNI+3pmJ6CEqrsy1BYqZ1xItcLsvjzYZw6NjIhcEdjrTNk8aQY
 9a/Y0RrzF/qQgXCqIau+sbYLVjF/Tb+8WH98KIcvxKo6weF9AL/QNUdQ80293Jjx9nfrhKxl24T
 qftnsEttxKJHnHHXywe9P14LDd55qLG0RftxyqumiFxPBD/MURzG12J1xfctKN/W62QSs9UPceq
 BZMkNeGwIJezq05IGErtLtXTAi8A64iPBYK8vx
X-Received: by 2002:a17:907:3f23:b0:a7a:a4be:2f95 with SMTP id
 a640c23a62f3a-a7d3fdb6696mr1138242266b.5.1722424702632; 
 Wed, 31 Jul 2024 04:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRYsE9dnpqXe/IuPJvNHRIYHejj7MEooJagaN1SWluCATfzErb1yyMtGrZsLLtGG4jxTvgIA==
X-Received: by 2002:a17:907:3f23:b0:a7a:a4be:2f95 with SMTP id
 a640c23a62f3a-a7d3fdb6696mr1138239866b.5.1722424702200; 
 Wed, 31 Jul 2024 04:18:22 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acada27ddsm749995166b.184.2024.07.31.04.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/10] target/i386/cpu: Add dependencies of CPUID 0x12 leaves
Date: Wed, 31 Jul 2024 13:18:01 +0200
Message-ID: <20240731111806.167225-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

As SDM stated, CPUID 0x12 leaves depend on CPUID_7_0_EBX_SGX (SGX
feature word).

Since FEAT_SGX_12_0_EAX, FEAT_SGX_12_0_EBX and FEAT_SGX_12_1_EAX define
multiple feature words, add the dependencies of those registers to
report the warning to user if SGX is absent.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20240730045544.2516284-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e864f55d4fc..28b46ef536f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1734,6 +1734,18 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_SGX_LC },
     },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EAX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_0_EBX,          ~0ull },
+    },
+    {
+        .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
+        .to = { FEAT_SGX_12_1_EAX,          ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
-- 
2.45.2


