Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7568CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0c-0005CI-VE; Mon, 28 Sep 2026 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0U-0005Aa-Vn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0S-0004MU-O6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NptjkWI2sQNwUfLL1DrSnSM2e5R9WkikDlAfiT6IwcU=;
 b=PG7nWm2QAT/536Q+EJEMykifbE5qyh2VqjpvpGhKNPwFJ+vHwwc4gDQnrKYdUeVZWdK6dr
 G2ZgBvnx3sU82Ua8CVllx9Nhi+9tKCIBLYyUPx/naY5G7JoK4in9YkhfWvQBPEc122KYqY
 Z6i5Lh1OnZD0t0xHv4mUzsNAZFG9wTg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Lgzt_wQ6N8KL3gXSD2AYrg-1; Mon, 28 Sep 2026 09:02:53 -0400
X-MC-Unique: Lgzt_wQ6N8KL3gXSD2AYrg-1
X-Mimecast-MFC-AGG-ID: Lgzt_wQ6N8KL3gXSD2AYrg_1790600572
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c294ca8193eso135488166b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600572; x=1791205372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NptjkWI2sQNwUfLL1DrSnSM2e5R9WkikDlAfiT6IwcU=;
 b=lCZNxe9AbJBDu9CXdIC1CL+livGfeyWJFUTsTWuHeESOsX2jei2baw4rCjh0I2XMOC
 nOj2dF6sj8cR19IEKhx8jxzxYgWks/6Aj+g1HWOHKMjZpjjfjH5WQfP6+lCoe+UbJvod
 tIZfwfKU5HYSnLSrHe0kCnARm3NlhMYR+9fmpimZEdMB+yeSFwYao46h+Fz4stjVYHLN
 jbjx6WIXqdZVcQvvuNzKBOAXrIKZkEMYetmDHrZT+dXceuPtXn5jrqGE4Guo7kaMeL4Z
 BeIx5CbydFDinKTvXeQIcrV3Lf1lUGbt/puoYZ/JRDsdsHurjS/wSPoZyYPoxvZ/nDAk
 WbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600572; x=1791205372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NptjkWI2sQNwUfLL1DrSnSM2e5R9WkikDlAfiT6IwcU=;
 b=fvfmWp5xnze5qgpUKbc6VWRy2N95MvOujBzdhcZxKQg2JVlti7EIkPDSZZLyT9J3/V
 qVQGhYZiEeVNaaDrWBxNV5UPDD8ESPQVK8SLXXsheWIfsZ0zLruJfmdwFqzwFH0Q+fT/
 /FkCqd2Xr0kU33efnrSiA22OyfiRTduhoBzrHz4CKHbfaEPgg70rtaItaNCsPdrzsKml
 NVa44i6P0JRaSSC3nIs6+ihNItuSWvgGsd8n5pyO6fObWViFwrjR8WhannvQaqg/oUr9
 UeNPMhKgY+sh3LzBfYv+tgW0Zt+ZAFBgjAuS13Z/kBoJ2mLSGqTrhf8hLgLEF4nqFlhJ
 s+9Q==
X-Gm-Message-State: AFuF++nnEzTvSIqmRlA77YbImh7Q0OI8GywR0quSalQK0Xc1U8gfPbxA
 CdQ0Ol962RwetiwlYuV4TBBCdLrakDjtRwy2kJQgWrgYzUD+oQ46UTbFO22PeSDDnzUd0mA2NIP
 KNyZ+ms9nv9UudVNcoDYIR4lO6HtekCUMlGBVOZ0xCYhELY9OOu5qIFSmVrkilpSQjDJpiXqXyN
 n9HmT4G67eI+6LWOjdQ3vTnXXrhxr+O3E4X946VmlO
X-Gm-Gg: AYBFou32RGwZXqZ3deDxOVAgomOV8d9rQV/BbNcoPL2BHqW0rP2qZL3gm8NDfIuicE1
 29WstKCTCzF2o18lDv/2KXDf57PXYck9w7bzEMLBO8VgPP2/DIRgTQWMwS/t0uO+pOt1rJhwho0
 cDGf1NaZAsEu7j1Znp6NPnCqTiTACjvJsz7Dg0Npht7U6Tx/NJ2eDb123buY2RAOBfb734UOoSL
 hI9rOy+M5EaSONHmq0a5PwK3S/awGFVNgarQ4L0krB7HjXDkMn5niD1Ws/aOowwa4U19PQnF3Rs
 BHPdbgGjJhaNwEzstCOEsyC+JIUhAeHVvmQLDZHcUx9kpn0nzmI9WHNAQcfUo5aAa6XSx23kBSu
 oOotBfZNk1btun77du22ts+Q4I/fqzuJMU61w4jZgUugzEgw/YCutJz05SuczxRLlMecueYA35X
 9VGr3z
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c2ac53cb0afmr1074740166b.37.1790600572139; 
 Mon, 28 Sep 2026 06:02:52 -0700 (PDT)
X-Received: by 2002:a17:907:6ea3:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c2ac53cb0afmr1074737166b.37.1790600571608; 
 Mon, 28 Sep 2026 06:02:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dd68786a1sm163341066b.62.2026.09.28.06.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/30] target/i386/tcg: fix REPScalar with memory operand
Date: Mon, 28 Sep 2026 15:02:05 +0200
Message-ID: <20260928130228.877003-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

By the time validate_vex() runs, e->s2 is not used anymore and
decode->op[2].ot has already been filled in by decode_size().
So it's the latter that has to be adjusted, just like before
commit b7d4ec4832d ("target/i386/tcg: move VEX validation early",
2026-08-26).

Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
Reported-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8d1e581cfde..26f6d6277be 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2671,7 +2671,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
             }
             assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
             if ((s->modrm >> 6) != 3) {
-                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
+                decode->op[2].ot = s->prefix & PREFIX_REPNZ ? MO_64 : MO_32;
             }
         }
         break;
-- 
2.55.0


