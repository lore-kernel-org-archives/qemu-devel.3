Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA80C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENud-0002pu-6L; Tue, 04 Jun 2024 02:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENua-0002g9-TE
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuZ-0007H6-GI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KuYC4l98tp+GN7sW9Yoq96D/6Jc6WoIXh7OieOEmCQ=;
 b=FmV5JaqKjnUVMQdNX0elrvM6dAfrFbaOlx/+BzG650ymWdxUHGR7NQ2VS3siE1AKuwoMDQ
 5nCDOomqO/uxPDHWmGGBw33mkUUuVnRqKqBGvhLJXvT+42/dzxDRwGZpCOZAPYmGlu5hHE
 S+kIj4ox5YsWwzQAMZpYZhs4lGjyrZU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ilalQQUaNsuTE-p7rEnJgA-1; Tue, 04 Jun 2024 02:44:44 -0400
X-MC-Unique: ilalQQUaNsuTE-p7rEnJgA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68abbd0c78so160199866b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483482; x=1718088282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KuYC4l98tp+GN7sW9Yoq96D/6Jc6WoIXh7OieOEmCQ=;
 b=UVbcvDbbjvA5+pojGG7VH0rpGJ7+6IpgU02PYURwqbhL1yvZYdcQGubsRCImkqSVWC
 b57JJ95KVoPq0hEhX53eoOBh6HNjVkhyHw6XTPzqTyHITjAspjtBlE4W6yArglaIFIpF
 f2Ggn2y6pqYH/r7rr+Bv1PNaYyWEkODkM179z43ONu6eAYm5unaAGBeZQm7aDfmTUPjz
 adB1qjRF6QHKxXg7yP6ZLTdsa5f14O6L3GGLHoCRhYTsduEwMaHFYU1rE2ayPrZ/ZD3b
 mB8XVyErrsgfMhqzunXp89CvSTOoePsIXWHQnKfmj2vT2qQkZgnDswutvH3R83GjJY88
 ZoPQ==
X-Gm-Message-State: AOJu0YwZpRzHHIKii3G3Ho9GYRTvPQ8sZrYUQWihgeg+b85swmbtaViB
 2VrWGcfDd0iPxIOo+71vJyGxxVY+p6bjPSIsZr2Ff9Ddmz7S+w28ZaEKWDFKoJ+REEvlzA+FP+4
 4pZiscK3zd/OdZB4G0E+ywsXZlIMqmQjBtmqrA7GM13P6X9iKZT3USx9scu+o5q4q2Mpah1g4eU
 wiAxVPz5rvTZ4OBdh8GiwgGMLAvV4W1b4pAQiQ
X-Received: by 2002:a17:907:9867:b0:a59:d4f0:cfc3 with SMTP id
 a640c23a62f3a-a682204a7a5mr663859966b.59.1717483482654; 
 Mon, 03 Jun 2024 23:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhiYZ9cJHIOtcLVmaKHnip+Ko9s4rcUsxMwwJpC9S0rx8qQrbOonfut7ax8R/gMNS1jw9PpA==
X-Received: by 2002:a17:907:9867:b0:a59:d4f0:cfc3 with SMTP id
 a640c23a62f3a-a682204a7a5mr663859266b.59.1717483482276; 
 Mon, 03 Jun 2024 23:44:42 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b59e925csm443108666b.220.2024.06.03.23.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Xinyu Li <lixinyu20s@ict.ac.cn>
Subject: [PULL 10/45] target/i386/tcg: Fix RDPID feature check
Date: Tue,  4 Jun 2024 08:43:34 +0200
Message-ID: <20240604064409.957105-11-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

DisasContext.cpuid_ext_features indicates CPUID.01H.ECX.

Use DisasContext.cpuid_7_0_ecx_features field to check RDPID feature bit
(CPUID_7_0_ECX_RDPID).

Fixes: 6750485bf42a ("target/i386: implement RDPID in TCG")
Inspired-by: Xinyu Li <lixinyu20s@ict.ac.cn>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240603080723.1256662-1-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 6dedfe94c04..0486ab69112 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3199,7 +3199,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
-                if (!(s->cpuid_ext_features & CPUID_7_0_ECX_RDPID)) {
+                if (!(s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_RDPID)) {
                     goto illegal_op;
                 }
                 gen_helper_rdpid(s->T0, tcg_env);
-- 
2.45.1


