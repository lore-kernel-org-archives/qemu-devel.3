Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87833C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHBW-0004Od-17; Mon, 14 Jul 2025 07:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1X-0001xy-GB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1R-0002CL-3h
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MV2oFzCG81p61oxBJMzjbmDGG+yfWTjq0dyOU3iCtvA=;
 b=eKQ6/i7G9lpWOCCUQEOoobSFvUzXh5wLTXp80o9s8hUsKuk2CiEruZsH3AC14UeO+/DFdk
 VgzrgH0XloZiOq9Os0NydWbPaAEcvxEUTEhu9U7Pao8kdtlZxnSs1bSU29MR4/9rh9NeBt
 6EncouhmepEtz0B/jgVsfkXYEwu9hSQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-UCEMOoMtOyOPIWqZg17K2w-1; Mon, 14 Jul 2025 07:06:58 -0400
X-MC-Unique: UCEMOoMtOyOPIWqZg17K2w-1
X-Mimecast-MFC-AGG-ID: UCEMOoMtOyOPIWqZg17K2w_1752491217
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so22972345e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491216; x=1753096016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV2oFzCG81p61oxBJMzjbmDGG+yfWTjq0dyOU3iCtvA=;
 b=d5uh64g9ZfoKuLjkvh7gzFnBCvSK5YL/YsSiwaWgVZI0mFq5nZrV6wmVMY/jH/+CXY
 AZ65ELNSADJpglRRTyPjeyC+Lwj8grE6v/8xyeiMKSGod6ofxhuN6yu+vUb+5hS9QIUr
 ymyzoByuEmXUJ4ZbPSAqAtDUMUBxJ3iN3nr7Cq7M9bXfnZmowXGQ4TrlzCkeiiGwWtHq
 e2BGzLa2FrverO7m/c8aBNA6x1KZk2jtBQA9rKdsjhGr/FMMgJbDM4JPMxjLX7bG5sNy
 HsUGY0bmKUwsRX/qGX12jSuk/E6Gb1lgpicK+KKbYwhqToA3Rg2KeCTCJXS9ie1JZHY+
 T1zw==
X-Gm-Message-State: AOJu0YwDFG/FcaUTrZdCVY6XYZ7WEEhlJYf9srnQfMCJw/6ffHqHvncv
 rXY2huNsp6PXGOoBB0BRW7oRwzJyde28i6UnQTtn64V00tLdb+PD87eMb4NY6m6jHY6zGwCPbkt
 SMRlDP1JttMGGacJY1TrqsCGtlHtEL1lwMo9ZAO0pDOBcGaUn2nouhQtjbfPbbNngHYJvpB/4CU
 /umuODUTv+eg2aZWjfKrGdI+oAYjKiwDWP5zgOA8Zi
X-Gm-Gg: ASbGncspDDHEghsQy/0Fw5xcCDFUaj+3qBUaYWSQkMSgrJ45vMYRNHKWPfW1XfPWsqs
 qiBDe1qRlvnBtISfuw6/+AT+bFJvjWntjDr9YzEqhoRvnVurpocRuVpSirFxQzaUIPqc1EOhUXr
 CpoT80EIfcmqMC7LJBX1I21Rk7vUyd+L6e4KSUL7GvGvD0gwPq2uPpZQRf2W9/zkknjorL2vZob
 VfaOxxJMHSDeODkb0+Idqlw9pVgrL+wtOTSgIu9jFC4f1/jvG60Woelupyyl489Ycdi9nXXoqcE
 eAIERE2ALh0GqGFOrWMgl3RULdn74ugOQgZ6IOtHc3w=
X-Received: by 2002:a05:600c:5406:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-45600771e4dmr73957485e9.5.1752491216591; 
 Mon, 14 Jul 2025 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEvbajeSmwsaqdEPZ55gULI1l/7NoZUhEaAEOPxPKtsv/KCnO3SAPO3RJYl/voWzSfaiW1eA==
X-Received: by 2002:a05:600c:5406:b0:453:c39:d0a7 with SMTP id
 5b1f17b1804b1-45600771e4dmr73957075e9.5.1752491215949; 
 Mon, 14 Jul 2025 04:06:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm47008285e9.1.2025.07.14.04.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: [PULL 65/77] i386/cpu: Enable 0x1f leaf for GraniteRapids by default
Date: Mon, 14 Jul 2025 13:03:54 +0200
Message-ID: <20250714110406.117772-66-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Host GraniteRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c15082e8afa..a11e9bb1117 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5239,8 +5239,12 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with gnr-sp cache model",
+                .note = "with gnr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_gnr_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                    { /* end of list */ },
+                }
             },
             { /* end of list */ },
         },
-- 
2.50.0


