Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9C2C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KTH-0005Cz-9J; Thu, 03 Apr 2025 09:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KTB-0005C1-Me
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KTA-0000Ey-4E
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743686335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4sWFJAsd6uDegNVb1OR0ba7NgY+ZHMqGRsB8GOL/kKE=;
 b=JwjgAAMIfJqU/5sLI3G7YGk4j58ogAmtlCY8Ccgz+KLqmHUPCFD+P1zy1tLc1xTq4sC33R
 kbcbJ/JAPPmPfDxE0IVgC8QhI91f5UmfZgQD+rAfoNf/eZzCZkNsW/K7OumIuSbABtqEWX
 1pTj5LrnHgzCdwZrtaDiXuD0QFsv7XQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-OdmLK3CJOuyq3EVOTrzslw-1; Thu, 03 Apr 2025 09:17:59 -0400
X-MC-Unique: OdmLK3CJOuyq3EVOTrzslw-1
X-Mimecast-MFC-AGG-ID: OdmLK3CJOuyq3EVOTrzslw_1743686278
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac79e4764e5so84702966b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743686277; x=1744291077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4sWFJAsd6uDegNVb1OR0ba7NgY+ZHMqGRsB8GOL/kKE=;
 b=W9Kd1MYLJc+/ybgRmj3iGmPza1oTkZ8YEkk/mO9oDZgRXLVR9KEt8quw3W3jtr912/
 nSAR1mtVgjjR1T0DerCQQx3oV+mUzZXGFDL97iH2i/xpqgccdCMI0CI7gT7IkXwnv7zc
 PLz0adejSU04iS5CqaA2zOe58cFZgkNGfnfWCgZmMzqG2v+HR6Yl0J7hf3Ke36AEMyKU
 NLt3jhm0UtrKj09jDqaKVd8ffAk34SOYYD1YojK/yHQe314MzkR8c7evodobOFHnIfAv
 XDVf1xUeN/54ubJ/vw7kNgmChXmersmS16jty18hleC3vu+2wS+EPKqCRZW8Mrjfn291
 DExA==
X-Gm-Message-State: AOJu0YxxNsM7C4pDD4XR31ABO0AQY7H3T1g/+sCN7KuMENaLYF5B1pf9
 uxHmodJS36ng8YoKwTSR73BJW+2TG/xQtEfkWWQOxtJOspB2QO1Q8+my3vf4XmeyCKN6ifKfbs1
 oerxZ+AquxxbPazvBp3lwh1wBjVT9gshdOw3iQpqiqLGr/4TGEVHxssGjY1+oEE7lGcvKbIwYd+
 D7SGybwamcGB6LUDo+YbTxnd0Gbcty7Oi542MH
X-Gm-Gg: ASbGnctfkAE8gdi1eFVLV9G+dWPJzcPSgz1WcnrtVNGcC1dlcVZuQknecyAPECtBhfU
 8tkt3SCvws15o3ytE9jQg7kgdPdnat2ZytHB1Fq/3hg3jYB2xpIGLwhSD4Cd//UYk0Kq0+U5EaZ
 +Hrh+nwl5CPN0+mTqy8nBb4JJIyk5hVo5jYHEUT8SPymXQIF+gQpBA6tMFi8GQcsyuM+MJNiP+S
 OcCl4uwfQwCjwlyL5JqsD3OsXzRNPu30hl45KKLsUle0sXRcXAkAqcjJdPwHJB/wsm4/VLYjUHV
 9T80G60OgQ/r1u7V/tIc
X-Received: by 2002:a17:907:9693:b0:ac6:d0f6:c85c with SMTP id
 a640c23a62f3a-ac7bc0dad63mr249843966b.20.1743686277319; 
 Thu, 03 Apr 2025 06:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCjKvELHPBrrr8E2MWPevIwTx8+qgT2P2krUi7vvgcMgfEm8KVhce4I59uO3Dgc7AgUq4+Gw==
X-Received: by 2002:a17:907:9693:b0:ac6:d0f6:c85c with SMTP id
 a640c23a62f3a-ac7bc0dad63mr249840066b.20.1743686276869; 
 Thu, 03 Apr 2025 06:17:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5d442sm92533166b.26.2025.04.03.06.17.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:17:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/i386: tcg: simplify computation of AF after INC/DEC
Date: Thu,  3 Apr 2025 15:17:51 +0200
Message-ID: <20250403131753.82072-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403131753.82072-1-pbonzini@redhat.com>
References: <20250403131753.82072-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

No difference in generated code, but the XOR-based formula is
easily understood on its own.  This will make more sense once
ADD/SUB stop using dst^src1^src2 to compute AF.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 9aff16b8801..b821e5bca3b 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -175,13 +175,10 @@ static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2;
 
     cf = src1;
-    src1 = dst - 1;
-    src2 = 1;
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
+    af = (dst ^ (dst - 1)) & CC_A; /* bits 0..3 are all clear */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK) * CC_O;
@@ -191,13 +188,10 @@ static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2;
 
     cf = src1;
-    src1 = dst + 1;
-    src2 = 1;
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
+    af = (dst ^ (dst + 1)) & CC_A; /* bits 0..3 are all set */
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
     of = (dst == SIGN_MASK - 1) * CC_O;
-- 
2.49.0


