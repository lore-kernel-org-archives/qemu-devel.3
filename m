Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC89FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbz-0004tX-BL; Wed, 23 Apr 2025 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbu-0004hk-AM
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbs-0008MJ-Ao
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7294wfdbH35oeJE1OLJ47GmvFn6r1Eevzfswj+cP3Bk=;
 b=BzQigN8dUjEdBYWovIAMB8f2pz74djR6syFFngJRJmRIcXAHzlO7IG3OoCowxeK6tXQC8h
 mRuaPfPYIbwVLBge7SbZD95tLHUPn5FEUei3Re9UiDifrpR/+Ja4rSgL5HVfqdPlVi0MV7
 ulABOPVnIMOJWUQy/lHNLQFqOkUCQG0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-MwFbic_dN3GbuxAI91wXUA-1; Wed, 23 Apr 2025 05:41:37 -0400
X-MC-Unique: MwFbic_dN3GbuxAI91wXUA-1
X-Mimecast-MFC-AGG-ID: MwFbic_dN3GbuxAI91wXUA_1745401295
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb61452b27so561367366b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401295; x=1746006095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7294wfdbH35oeJE1OLJ47GmvFn6r1Eevzfswj+cP3Bk=;
 b=cSouJboWa/hox7xfyb6I3OnUmwnu84oRdIg8pvtTjzUOTD2LsLlse/io4vhEdOPpU2
 rVGuATd/coRUWKMQg0IkaoP9DJdsgbJrv+o0OFNxaUAkX6qBWsx8qHMwHu3gZbbMPeZS
 oA3HhIVpu22RZSKo66+NqR3R43NSAN9Bzd02J/QAkgfqK/whFLMweqYyo6CuvihScSPA
 UR0OaG4UnUpTzHK92j9OSByjFodvwDBuAnSgMqrdBE0kDl8REIqPZAW7zBCxsPh3tfrA
 D3t84gVl+jgXFs5jNNRAzMP5jAQ95ixxqUdf942aC2GpgwLMfG+g1gkHS5SXV0+ar4J8
 vj1Q==
X-Gm-Message-State: AOJu0YzmoA40KvegulPPz7eAvmEoKzxw2+RcC6iIE6sax1uw2zif+B4E
 x6bifLW7UOfB4rWNAiMvNUlx9N3odA64o0RvkWIFELqgyDrfUJtwhbl6R6cHIDElBd5getzihLz
 NjGNKsEPIdcWOySjG6XdZ4SftKYilf/rOl17KzHg3t2EwyvZ6dgHckIRjJcoZ+tLetClmCmdZJR
 Ak1qphrSTgvA5bR/wWpY70u/j4r4ZB1CrD8MiR
X-Gm-Gg: ASbGnctDNW5erETr3T5EQySzD0cwSMfCzapehXrg1ECESQbaGpjV0crZ3dpWHbV5uUj
 Km+J3OIiy9nHqEQ0eDpzNQiWmbzDzuCsrlk47DSBNvuBsZ70p/PqYcdhBOyZmAEYjcOv+0af4mx
 8ydqHIgeBuTpSfdEiVs8cOwzYTZ9KsN76QqANDV4201NhOEzk7hgPIdkOWOuup5VxtlM78sVXbN
 xztJiXRjeufuCMD1okkghlt/uUpVnpGY/yQmFMkWm1JN50KT53DGKHwoixuu+/CQMAxu1n8I3qK
 U9WgjNjtCDshShGf
X-Received: by 2002:a17:907:2d0d:b0:acb:4f46:9d18 with SMTP id
 a640c23a62f3a-acb74af251dmr1671160966b.3.1745401294907; 
 Wed, 23 Apr 2025 02:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEONFVJQ7jIqqH43pCDKg0/syZ5gXCNiTTbG3S/sS+v3eMZOPj0Dsq230kyAPauTmumsosYcA==
X-Received: by 2002:a17:907:2d0d:b0:acb:4f46:9d18 with SMTP id
 a640c23a62f3a-acb74af251dmr1671159066b.3.1745401294397; 
 Wed, 23 Apr 2025 02:41:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6eefcf37sm784093266b.97.2025.04.23.02.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 14/34] target/i386/hvf: remove HVF specific calls from
 x86_decode.c
Date: Wed, 23 Apr 2025 11:40:44 +0200
Message-ID: <20250423094105.40692-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Wei Liu <liuwe@linux.microsoft.com>

Use the newly defined emul_ops. This allows the module to be reused
by other accelerator in the future.

No functional change intended.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-3-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_decode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 5fea2dd3cc0..728e1596381 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -21,6 +21,7 @@
 #include "panic.h"
 #include "x86_decode.h"
 #include "vmx.h"
+#include "x86_emu.h"
 #include "x86_mmu.h"
 #include "x86_descr.h"
 
@@ -74,7 +75,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         break;
     }
     target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    vmx_read_mem(env_cpu(env), &val, va, size);
+    emul_ops->read_mem(env_cpu(env), &val, va, size);
     decode->len += size;
     
     return val;
@@ -1893,16 +1894,6 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-static struct x86_segment_descriptor get_cs_descriptor(CPUState *s)
-{
-    struct vmx_segment vmx_cs;
-    x86_segment_descriptor cs;
-    vmx_read_segment_descriptor(s, &vmx_cs, R_CS);
-    vmx_segment_to_x86_descriptor(s, &vmx_cs, &cs);
-
-    return cs;
-}
-
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->addressing_size = -1;
@@ -1914,7 +1905,8 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
+        x86_segment_descriptor cs;
+        emul_ops->read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if (cs.db) {
             if (decode->addr_size_override) {
@@ -1950,7 +1942,8 @@ void set_operand_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
+        x86_segment_descriptor cs;
+        emul_ops->read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if (cs.db) {
             if (decode->op_size_override) {
-- 
2.49.0


