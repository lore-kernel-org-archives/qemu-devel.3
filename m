Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A5AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJR-0006HQ-Hi; Fri, 08 Aug 2025 14:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJQ-0006H0-CT
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJO-0006gm-QL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn820PJK97/jK7UY+QSi/KFlnTyM5eBHCqtQu4mxZHw=;
 b=TDyY87h7SZwmHH0VP2wENwLBP1cBY/tw2xB3BXAPvlL27ANiHgSP8OkwL5nByzvs4eChYh
 DdF7zz9InVIAawgFams1XVj3/xkl4uPedZyF+tsofeD7t9sxYaOrcEL4RpMip5+bE+VbpQ
 2WrD/j+iEzPQi9HGXspIDPIBr8gCjX8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Pd0OcQsAPiS-tQYIPoZ0sA-1; Fri, 08 Aug 2025 14:59:29 -0400
X-MC-Unique: Pd0OcQsAPiS-tQYIPoZ0sA-1
X-Mimecast-MFC-AGG-ID: Pd0OcQsAPiS-tQYIPoZ0sA_1754679568
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7891afb31so1625396f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679567; x=1755284367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jn820PJK97/jK7UY+QSi/KFlnTyM5eBHCqtQu4mxZHw=;
 b=t+86ySx9u1jtC0aSkLpy1G4ZG+bGxhUO5bEpCLIir6kL1c3pSnrKwiVsrNtW3U08SP
 ji8WlU3UAFD+pnDDXNkCaNMAepgwqVmGX+wu54EyWJbQlP5ZNfw1vKpWUN+oXGK+yX8a
 EwEldvswfvpDmCW4yY/NCJbr2y52P7cWcO+QgXjha+IV5HK0BxrfMLsNXeQf/34qdnwk
 hoVdNTc8i9+6NHeujGIexMPFjRfBamgs9LXZ8KO7r9aTtqJ4sRfvjtyo49eTUQbqCoow
 9FygR7eM1oOf2jdfxFoNA3tV7YXGrd+5IRyhEQJwXerrcOCdxpkIV9y9Y2Gal0Cumwzy
 1tKQ==
X-Gm-Message-State: AOJu0Yw2ctQR5T1Mv6f49SIvvpN0SdObPzsMGkdQShLyhVlSJ4rhjvCJ
 NTOWghasQhDO+PDThGGlujHgI6zzgVHPpgrn2n4LBS7AlI6PQiWw5TQjkK5bKylN5nLVqyyFJG2
 W+bQAsDmosdIVbic4ITURdbCv4oNtRGSe15CkFfH0vtD6eYtu5CXnr3vHVG+yTdqI7VbOfxWPyh
 F1HwMYVz3+ShLtm8rR/SqkJCrDsRPmCNHzzSDhaiGj
X-Gm-Gg: ASbGnct+5U3j9c0O2GJ84PV3Te2HuVQ7vWFe3/b6dSp3QD+DQQimIMW0TToRwQ7JNOt
 mvKHFOJj1eafFUeKb07LlOsIZRTksJgKg9gM3ocMC2oLBbRAE4Ez36t54CVIaTd5v1KIA2V1QFI
 +9lz7UomFrJv5MUWooW2Z7fafRdertWcK3gq2Nx5FzRCa2eGULsvNX+CuA3yQf45ESNki7ojH7u
 AYm0gpOC6IE3ye+k8LxLfwl9MZY9Iuf/72xwQzRSQZ5yCNqojtmHDr1GOpvPPaMZV4ctUXFTeMy
 3mECsNz1HOiLDGvlI1aeigvGXgqJF6wCSXzAVpb55Gse
X-Received: by 2002:a05:6000:420a:b0:3b7:9617:c9d6 with SMTP id
 ffacd0b85a97d-3b900b7afe2mr3471457f8f.45.1754679566819; 
 Fri, 08 Aug 2025 11:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE38YB5T//0PzEBQHbysY3Y/CO4jeFWOCOR3tBEP21/Bb0VSkd6UejIymhJ8hEDozInVG+mCg==
X-Received: by 2002:a05:6000:420a:b0:3b7:9617:c9d6 with SMTP id
 ffacd0b85a97d-3b900b7afe2mr3471440f8f.45.1754679566334; 
 Fri, 08 Aug 2025 11:59:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm31951038f8f.24.2025.08.08.11.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 7/8] tcg/user: do not set exit_request gratuitously
Date: Fri,  8 Aug 2025 20:59:04 +0200
Message-ID: <20250808185905.62776-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

User-mode emulation correctly uses cpu_exit() whenever it needs to go
all the way out of the cpu exec loop.  It never uses qemu_cpu_kick();
therefore, there is no need for tcg_kick_vcpu_thread() to set
cpu->exit_request again.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1a973596d87..b9da2e3770e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -750,6 +750,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 void tcg_kick_vcpu_thread(CPUState *cpu)
 {
+#ifdef CONFIG_SYSTEM
     /*
      * Ensure cpu_exec will see the reason why the exit request was set.
      * FIXME: this is not always needed.  Other accelerators instead
@@ -757,6 +758,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
      * CPU thread; see kvm_arch_pre_run() for example.
      */
     qatomic_store_release(&cpu->exit_request, 1);
+#endif
 
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
-- 
2.50.1


