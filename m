Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2759CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOU-0003XT-Aa; Sat, 30 Aug 2025 11:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12o-00015N-J4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us12m-0008T8-S5
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlTIbJwiIwq0If++9g+C1KJj+kHFMOoHzQVRSslQuLU=;
 b=AGDPi8PrA+KeNH8RopmXKW0ltZs/yt7wywJ4PCa885Wa5cRBlAQMeZehT7cE+nl5LwP3E/
 2P3/QtwXxAj9KLN9ZISUuNZVNKyy7Kqo1I5CFgX+W1uY2DDzW+F4lK40dCjag9/GKmO9vl
 BIVXS8waKLOARfUzLq1rkorpKJNKQMQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-gaoRWRLiNxmk-GknoSfO1w-1; Fri, 29 Aug 2025 11:29:34 -0400
X-MC-Unique: gaoRWRLiNxmk-GknoSfO1w-1
X-Mimecast-MFC-AGG-ID: gaoRWRLiNxmk-GknoSfO1w_1756481373
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b05d31cso11192395e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481368; x=1757086168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlTIbJwiIwq0If++9g+C1KJj+kHFMOoHzQVRSslQuLU=;
 b=v/S/QdX29DDZCXKHk3iMvGSqpeO238bMAy2FWS009EB5EXaehLO2ADYcpyk0Qn20LG
 sDWZvHWCS6ofLDeTEmJR6/fzfgf4CqNRKcJvMXCSs2Ikj+RVuJAGa5itvP5Jcn0AnHGP
 1Ckw04ST0aq1cpZ5UHie8R+giNMZEqKoUlj4JYOymWQL7h7SeixsZI7ZllYto1u54uoA
 Rnp+VfsDkGVLJIAcf3yn1mgjt4vGV4yKBkrLpQkGfDimYfVMhFFcxLd3eV7kdsAZM9nr
 Ts6WCoaymRJctZRyhnrkcx3Z736HmX1Ml7p1iOZ1yN9pxBzthAwS3zLJxg7Y1Bc9LR4y
 UANQ==
X-Gm-Message-State: AOJu0YyQQmnLtfb0i3lMRPNoLzHbzFqhH+jCx5NtuOGDvAHEr8NctyNf
 qP64jSy7Rovh7PdKW4DkfDkUy6BwRSWNMfpo/0wlzK/+n2s28DZRELcGcoUxmMO5yP9/uqm0TpE
 1MWz0w8c2QJxRadq61AEz0hmzzt3cG86m5lq+d1hk+5A7TO07DgfS5vOljTJExCtdeCJ9wbICtg
 2z323RC0Ht2FLIF/jt4/tfeKmAguL1ljQjN31LIexS
X-Gm-Gg: ASbGncuoH1EHf8Ugnp5Yo/y52mFR1epOYM/mC4nQVewJcq6/CjMhandStzdRD6IQb4f
 Xz7LVkrRCISEg81i/2OIGX8COnqzj1RjCDJt+xhkdCc3AVVZg+TSgNgqh8Kn3maNnjgQeVjusyg
 4jkIb3b3h1rOD9in98ylxWiHt2ABv6YXvcWjO9yyQs2Mkmfk7iqWCZK7Kds6bX+v9WZ71vLVgb4
 nFZggNOvsVAYSZVjK3dfFFyrxwY8l/vjOtZ4RVMCl5z7A0ksjXQ2V9wWaSkjuAvPv1Ss5z0arC1
 e+1nEhrtMjm72gwgXhbPSMTqnMAbAjZz3Wgms8yF6kN6hth3aCH2iZJWxsL070sEaiuaP1+Qioe
 L0Ikg5Fsw6tddSYJ/GOqvb0Svh35ZYZwOYZ+jnc2Kz0Y=
X-Received: by 2002:a05:6000:438a:b0:3cd:6477:a3c8 with SMTP id
 ffacd0b85a97d-3cd6486e955mr7218515f8f.16.1756481368380; 
 Fri, 29 Aug 2025 08:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvE3rr0qhc74dGJjFOFc3DbS+Y0GaA97+f6HIDKn8EXjlHA9UrLMyTEUyx0b+hgpmr2NwYKw==
X-Received: by 2002:a05:6000:438a:b0:3cd:6477:a3c8 with SMTP id
 ffacd0b85a97d-3cd6486e955mr7218496f8f.16.1756481367910; 
 Fri, 29 Aug 2025 08:29:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276c751esm3737041f8f.16.2025.08.29.08.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:29:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 03/18] target/i386: limit a20 to system emulation
Date: Fri, 29 Aug 2025 17:28:54 +0200
Message-ID: <20250829152909.1589668-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-i386 and qemu-x86_64.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index e0aaed3c4c4..651041ccfa6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
 /* x86 mmu */
 /* XXX: add PGE support */
 
+#ifndef CONFIG_USER_ONLY
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
 {
     CPUX86State *env = &cpu->env;
@@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
         env->a20_mask = ~(1 << 20) | (a20_state << 20);
     }
 }
+#endif
 
 void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
 {
-- 
2.51.0


