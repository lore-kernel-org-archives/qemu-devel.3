Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D26FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeeC-0002hX-9Q; Mon, 09 Mar 2026 13:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee8-0002fQ-3r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee6-00026V-LC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=OGa6WBAUEiQXdelQkYs3ccbwkp4NFdB/Zkuk4LmkneSL2cIfVHL/grVKO8c8RphtQ4fDNX
 UMRmzBQ2gpMrE1ZVyjrqPm8IfIkX6SMRGgbMd1j1Bb4llfuq8ZlnOMrGwojTiPWjHFDGnn
 Oxm0zIrM4qejNqYopMfkGhiDgC2363Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-gH6Pa9IHPDWNgLv3gpSQ-g-1; Mon, 09 Mar 2026 13:43:56 -0400
X-MC-Unique: gH6Pa9IHPDWNgLv3gpSQ-g-1
X-Mimecast-MFC-AGG-ID: gH6Pa9IHPDWNgLv3gpSQ-g_1773078236
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485355493aeso4935105e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078235; x=1773683035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=q/j53KqR4WltbCSqcFlh9N7FPzpryKbqAkuQHaP0S0Kn7Og3T/h6OxnM/QL3oFzTkt
 DoW69/s9F32LfBGGkMGiVac1U0o07At6fy5uPj7mNiBL5rOZYBTv4ix9dabnuQW4zgoX
 1OcYAIuVBG9x4SBj0VWlviZNBmtR5m5URmrN/qr4oWeYfUTdfFiEyLb+zlNyARtrbVO2
 q6Qa61dqkYNo8O2lwtkiDPNcffTJ3hC1+287y1PYoz/CEs6D8xN8t4MoIgSNbQk1zwI9
 KtNXj8EpX0dQ9IRsGPQr0leoIR51/9fmIG8wSf9WiH21cLem1ia3L2Gq2sf6Gycjpc0N
 NwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078235; x=1773683035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0eMpYMCvhFSbjZnQVatmA08KRwb8Q1v1D8tShGnW+0=;
 b=lI5uBXEt5S6QFsKvy/h1ZpTk1LpwZh2W6jnCBtxZCidoMi5/Xx3egDstlXNg43g1sD
 q0I5NusgU1D9T9npEvP0XpFsm7APIbLrxBXwMKzEGakvSbLgwmDPKaq3ynFQr+7EdBTZ
 iZTIRMMoSzvTkIjyKeWDrS206Hz83SpaDhaUDHW4KvhDIhonUoHTi/DhEzDqAMMsOnEy
 SPclONsEors2+6Cfp0O4p4TEZAKcFy+Dq8mWQZItoim6oJqN6PsMoZM1ciChkBuMcdcX
 GEACOfMamjq97JFhM0qZFj3D8TOo252hijqX0GbqoTqufe8W36vEzOthXpqg98IDIVm+
 oYhg==
X-Gm-Message-State: AOJu0Yz2tzVbURUcGPTeAAqVvc6blKh8S16HGgy2LqOV2TxrVjjP1VhK
 ++KmMjQ64ZSc/JY+z/nUQNHgZFPeqy6s/ANGCtaDN1keMn2a4uLX/ho7Kssy1eb3IPy4OJRnPpV
 XPd+Set13phcEYwhRBCHCqu6/G+VLUcGffqjP5kC7KUnqDr6+brYAmWKClvA9VMTm9G9fKrcP9g
 lh8kz0lD7gQaetHYUAh3skoXMdq3GPoy9x5PiIFyS6
X-Gm-Gg: ATEYQzw7Jp0QHB5zF3Z9O4iklrwWEQlJBPlrMYZ/zt3qWOnCbMuysMjAn4IPloy5TqA
 s0cwfgZmvDU3EvP7BsE+nnvBL6r4vCnI3txpQJ+oetmRsUK8bYLBwyVWMrmwF4tkZyCYjWS8/+G
 2VbWy1FxBUJpHFLWuGaMwDF34goVVueu48fVMce6xMK4TH1USUlTdnQRzJRIzDKDvtiuYCN7Usu
 GzCrImOmR5zvD126E39ldUKGzy9XHCdQkxt8EU0qZyBjBC6QYpXsNFpxshBA92LJ7OjPEDLbjTZ
 loEsAPIdnC1L8NyDZy/oZzjVjKcdvKXMXoG8CZDTJmsw/VfbOD4dIs/q0BeLoMi8kFnBM+wsmFe
 9hpRizNT2SHcgmTMdnCTC4FW5aygPEADX3HaCfSkWFCfLvVnAe9hzXYQNLB3VC29uRUcnpC0Gvh
 2SyMdhSofQtYxlwNBGRVR50zCjoGk=
X-Received: by 2002:a05:600c:c102:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-4853bb59937mr44504535e9.12.1773078235030; 
 Mon, 09 Mar 2026 10:43:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c102:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-4853bb59937mr44504255e9.12.1773078234505; 
 Mon, 09 Mar 2026 10:43:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f255sm6495965e9.12.2026.03.09.10.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 06/10] target/i386: emulate: LA57 fix
Date: Mon,  9 Mar 2026 18:43:36 +0100
Message-ID: <20260309174340.52174-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Seen on a Sapphire Rapids box with LA57.

The top level of the pte array is taken for CR3, so there was
one entry too little for 5-level paging.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-6-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca16351..4e39bae025e 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.53.0


