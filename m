Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A3109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMU-0005MY-7m; Wed, 25 Mar 2026 12:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMS-0005G3-Pm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMP-0004h4-Up
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZY+lfUSv0hQPzNSpxZLNfkq473QlRLdQ/ZgmDN/wsc=;
 b=A0sF6F5uS+5PjSpKq3rU7pHm5M7OTpobYs7kRwVphj/Mwfs60Bxq0C1WejstmZhhLVcWVg
 swXm4pnHleD2kJ7UCO27L/cre95jRUlV/lT/UdXP6aZPgCfLXK/uR5K+QplAgARyIwkYYU
 9wRgZycI5UCpRQAs6qVmC6Aep3T8aJM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-UDDvAeeqP5-1mknoODAUrg-1; Wed, 25 Mar 2026 12:45:34 -0400
X-MC-Unique: UDDvAeeqP5-1mknoODAUrg-1
X-Mimecast-MFC-AGG-ID: UDDvAeeqP5-1mknoODAUrg_1774457134
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-79ac9fad874so234907b3.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457133; x=1775061933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZY+lfUSv0hQPzNSpxZLNfkq473QlRLdQ/ZgmDN/wsc=;
 b=cpnpsR/QypEJ11QZdYrnn0NrlKj9ja7bn82VjQVBiop2hGa6zgx2RsdBdZBRNNf+8k
 1Z5CN55m4lPeDEwTHf5B3OwGSWp8g7B0g+BxzlVHbPkm5RoG0c4Zsesl6oRqAXoYRf4M
 B1ZzQtaY52VxN2u7bNE5M4ExwtcjuEpulckfMqPAhW4o6axHMjXRRkScTnERTFPjc8MP
 XROQroIlItaxU0cmpXu3GNroWxTFEnxu7w0F0KofDksXDqoNj+8Eq73emkswvCWAdM0Z
 Ze6BRaG7XyB4YITLr13I371JgD/6N46FUUJ8dytyoRjur1mq/2WKHv2b6c2cx22TmUWW
 KsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457133; x=1775061933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZY+lfUSv0hQPzNSpxZLNfkq473QlRLdQ/ZgmDN/wsc=;
 b=kIcLznsOJdZZezM0NbE79IQOZtDhU1/Q03poL5OXXJxlII1NDvuT/fqVH3Y04cFdYw
 rLJVtAbdKUfm7KaD8AfgHTPe2iiOJf63x3cKSB8XodkQoWi7K/ZyJ3oqI5JPys9HFC+S
 PY54A4+2dyeA7mmiUdqRT/DlNfV/cTwofJU/9Cs7UAz9KSphfzfZAhONRpgVSbuXQyjP
 hXQwTf9if4hwk30GK+ZbtziFyHF9MzmVPwh6vYZzEZW+6Lg+ogI1Q+tmMncxU9hauuYA
 GtZ5yZAN7F3RwAzPMilP0OtK52nAA/CiyJGmecFL2Ao63xDEHpym+pXSpKBm1w4ylCu5
 PIOg==
X-Gm-Message-State: AOJu0YxyEfOeyCAVzEk5PT2CumPG5IzJchPh7xZjhOhNhtV8tLvqqdwg
 LJG4G0nihDGw2YngLOp3AD5R9RYR5IV3e+1G6rgXThITESQFyrQMr20Lz6HA5J/7I/kl7BvcLKt
 fE4OWuOOJeBwEnwQpePVqYetxkPQKWE1oWkiFO6IYEYj3gmkcydjkvOs569KHnmz7h+fWcn6EUm
 fkBr7+h8k6fG9znGjiyBz0NIfuPHITdb9Z42r5daTh
X-Gm-Gg: ATEYQzza6Jg9BNEqDE+wb9/p4GNzfx4JvKfIWsHaTpnlQF5/3zs0Gii6Ew3RXLSTH1z
 bAufeabMYWih6BwKX3fS6jx9kYaywPRC6DUkd+rPfIiKlqWFB7zXAFH+/0+NiLAVQ3fW8rHovED
 /bfF+xs87EKK9ZatCCr8PjgQBJ3IU1kDX/t0xJzUgmYxkkeEP6QmXRcgAxG9D+5QsGvydnTXnqO
 ZkmSTePU4gWK1LDlVMAsJ3vnHkJOp5asKXfRo0606ozx/2sAeylnVJt73gGU89WBxwN+Lfm4+Dv
 KdWLGUJlvmrdjXFK0yiobG4BDuirvxWbN+uhCT4UeSW8+J5Gzi3f9FXQQIFrPcBKdcs+Xq/GE2N
 dSF0AJVPXGA0u0JG9lpc6CQXs7Tx/teYgFK9stWq8bozbYHt2y3sQNknpTBPI+iHYlAv+CvfJAF
 95t8guQFjVfO2HU7T4SAocH8F6
X-Received: by 2002:a05:690c:46c8:b0:79a:67a0:adfa with SMTP id
 00721157ae682-79acf65926fmr44787667b3.44.1774457132957; 
 Wed, 25 Mar 2026 09:45:32 -0700 (PDT)
X-Received: by 2002:a05:690c:46c8:b0:79a:67a0:adfa with SMTP id
 00721157ae682-79acf65926fmr44787227b3.44.1774457132256; 
 Wed, 25 Mar 2026 09:45:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79b17e4359csm463357b3.20.2026.03.25.09.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 19/19] target/i386: emulate: follow priv_check_exempt
Date: Wed, 25 Mar 2026 17:44:53 +0100
Message-ID: <20260325164453.72127-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Follow priv_check_exempt flag argument for
x86_write_mem_priv/x86_read_mem_priv.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324230016.80914-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 1aa373f5b38..c69ae96acb7 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -263,14 +263,19 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
     CPUX86State *env = &x86_cpu->env;
 
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MMUTranslateFlags translate_flags = MMU_TRANSLATE_VALIDATE_WRITE;
     MemTxResult mem_tx_res;
     uint64_t gpa;
 
+    if (priv_check_exempt) {
+        translate_flags |= MMU_TRANSLATE_PRIV_CHECKS_EXEMPT;
+    }
+
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, MMU_TRANSLATE_VALIDATE_WRITE);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
             env->cr[2] = gva;
@@ -311,14 +316,19 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
     CPUX86State *env = &x86_cpu->env;
 
     MMUTranslateResult translate_res = MMU_TRANSLATE_SUCCESS;
+    MMUTranslateFlags translate_flags = 0;
     MemTxResult mem_tx_res;
     uint64_t gpa;
 
+    if (priv_check_exempt) {
+        translate_flags |= MMU_TRANSLATE_PRIV_CHECKS_EXEMPT;
+    }
+
     while (bytes > 0) {
         /* copy page */
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
-        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, 0);
+        translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, false, is_user(cpu));
             env->cr[2] = gva;
-- 
2.53.0


