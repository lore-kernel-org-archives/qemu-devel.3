Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C475FCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8D-0001cW-6Z; Thu, 30 Apr 2026 13:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV83-0001Oq-LR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV81-0004xy-RU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwSTO23tatX4qo/4Z8YUUEq0ozPSpRwl9jKyMZLnpSI=;
 b=K5zdE+ViOvpLXQiN1ncTtwqOfha8ZpTz4jkspVjafz55tsezZgt9dNJzilOvc8tB5A0dFJ
 f9XEDtZE/XLPC8+G/SO7iE6wrOPoXScemgikyHGJQoMX4ChuYv8AW1kGgySytzBM+Nn9VN
 tso3lxgtWHgRISYfnZBZbgA2jUm8Bfg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-j7MiLVQbOXWH_o4x7dsdKw-1; Thu, 30 Apr 2026 13:24:43 -0400
X-MC-Unique: j7MiLVQbOXWH_o4x7dsdKw-1
X-Mimecast-MFC-AGG-ID: j7MiLVQbOXWH_o4x7dsdKw_1777569883
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b4bebd2b2aso10784966d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569882; x=1778174682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwSTO23tatX4qo/4Z8YUUEq0ozPSpRwl9jKyMZLnpSI=;
 b=kyPtOKlAHwXoU7Fe/6JbhTrKrqJLKYrpidKVPp4pOmGWUWw7/kgNBMqecQV0Jr1MHV
 3H1FJItNY5H5bOtay5KTNZ4mDtANwTBAB5I0YSP+TaqmBjrjfo9KdIOcWJNUhWzHN+rt
 z7t5Z2T8KIpOgW4xg/CIqWfXu6f/9HoX/s2R5NsgHym9hUst8iEU5y6eVEFpGj5r1ZBD
 yWTzwXxb+d61dDlw9Acr7/xuBhCpVrREVAqINMLQtz2UKbPVCZ/eB6RiC6rLQuSMr3pn
 UKxNgZRbLL6BDy9CRYMVD1sWyRml+Q0llp3xRGwcwgAkY9KPW262kT/eLtJV7MolzBAP
 1E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569882; x=1778174682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwSTO23tatX4qo/4Z8YUUEq0ozPSpRwl9jKyMZLnpSI=;
 b=lTyxYJ6fD65bLDZqmrku2csVv36hqLePxcVar6m5TC/N9bAB/ohiB4/YVZkAWMIFy0
 RR5AuVTQppdiDjKC8cm3J81HdwjvBQ9prNjNR6fzHQUoogiOFrCAqiHYM9jEdQVIeJd1
 5AYdGVFT42zUrpP6rpm2jx7mbR+bc9n3ZI/Bkvz45UgwDe3S3EW1T4+lVVY7ysX/E/vm
 99OlPPR0JH/KGiBOQQcu0TOvZKYGbLTVhqV2uu3eYD7xHlceMLiKHNZbo01vLf9+eAMn
 irb4yydrSo5GdOk6Jlzi/RPGLXQMn4t4Rtmb9pw9tU+wfVujF9SphY+odo1l/Y+YOuY7
 goLw==
X-Gm-Message-State: AOJu0Yysc0kwqSJxNSLcejzm+yLDJCt10by4TMznwE8yrxTqaqZEol7g
 J4zV79jbM5149OfP0IW2x1tlTnIe2aTIr1Bp7fEax0S7ZgzuQFSNHxBBoJ63UGO1W1e1NuQhkdf
 lt40iQZ9cuvEk8yDHW1yR3vLG1PpE1VvYTYNm6VkayB972zvlpApHBLuZz37QIkZUhk8Ywgt4/K
 9BhWIX9oRFmdaeuze/0ZB4pyLlgsc78irr2QdShnqK
X-Gm-Gg: AeBDieuuHrMtI6puKgjdlUPu6nJ4yo+ujZAPtWPnWA+x9JvX45sYPvedbDWXXB5HG6S
 5PxmSplqpgdtmPY6bSdQKvc0zBPwQfCzzgSXCbQgJtRacFmJ+Qk8xPDSe2kINUAqrzNL7SOuqmv
 +yKqbdRZnlWClxhbufgjC+KmaUwXmLicrqm5T329KyHp50X3WFy8F8YTEOvGQwlqZfOhO3it3ND
 m51Cem+TNxCNYL9AaD9AuUbp6aFajMZ9Im3lipZbHV/FfzLUKT0SaRmvrftA4eQZ8KWFmAEcqmk
 Mro2lIdORqwons3YA6uGhJPruWKrf59MQ/uGJ0lY6MLebgA3LbPXPm/mmA85ejt6m7/xi0mjN+f
 P8NnOEem61sn36dE+8zh55yEdu7d4RiZQRW+YjUrh8InZXyoE8MmkwA7mJVinawnxK0jxcV7f8v
 5qqm8htLwNJE8i2H4VTrqE1X7BLeElDXGVG/g=
X-Received: by 2002:a05:6214:3d0b:b0:8ac:9fe9:bcd5 with SMTP id
 6a1803df08f44-8b4000fc37dmr43928916d6.35.1777569882435; 
 Thu, 30 Apr 2026 10:24:42 -0700 (PDT)
X-Received: by 2002:a05:6214:3d0b:b0:8ac:9fe9:bcd5 with SMTP id
 6a1803df08f44-8b4000fc37dmr43928426d6.35.1777569881956; 
 Thu, 30 Apr 2026 10:24:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff301c24sm22789796d6.6.2026.04.30.10.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 50/58] target/i386: emulate: use exception_payload for fault
 address
Date: Thu, 30 Apr 2026 19:21:56 +0200
Message-ID: <20260430172204.1006673-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of directly putting it in cr[2], put it in exception_payload.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-27-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 3 ++-
 target/i386/whpx/whpx-all.c   | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 007de582de9..8d4371467fd 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -277,7 +277,8 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
         translate_res = mmu_gva_to_gpa(cpu, gva, &gpa, translate_flags);
         if (translate_res) {
             int error_code = translate_res_to_error_code(translate_res, true, is_user(cpu));
-            env->cr[2] = gva;
+            env->exception_has_payload = 1;
+            env->exception_payload = gva;
             x86_emul_raise_exception(env, EXCP0E_PAGE, error_code);
             return translate_res;
         }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 25ace38ff60..8d8aabf4db7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1891,11 +1891,11 @@ static void whpx_inject_exceptions(CPUState* cpu)
         WHV_REGISTER_VALUE reg = {};
         reg.ExceptionEvent.EventPending = 1;
         reg.ExceptionEvent.EventType = WHvX64PendingEventException;
-        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.DeliverErrorCode = env->has_error_code;
         reg.ExceptionEvent.Vector = env->exception_nr;
         reg.ExceptionEvent.ErrorCode = env->error_code;
-        if (env->exception_nr == EXCP0E_PAGE) {
-            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        if (env->exception_has_payload) {
+            reg.ExceptionEvent.ExceptionParameter = env->exception_payload;
         }
         whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
     }
-- 
2.54.0


