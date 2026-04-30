Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49AACD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7r-0000AS-6T; Thu, 30 Apr 2026 13:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7k-0007Vg-8h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7i-0004sb-HX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFQDmvQVPvkQfq8ddqdKQnGOWaRXmS2QmwZh2RMVRUg=;
 b=M31WZK/TsCtP/FEOIHCoDocl8iP2eywYlw1+owFsJNCZoDvr4yCWBdRmTzdXuaGZYMXFzI
 mNahDoAf2mtgzVJUC4ViWy4/elwswH4MSuYmo14OYlVDmAIoyWpn+E/9gHNv/67dH0rxBS
 DBjELH5f++Lxy+hb6u4JzVATy8HG8QI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-sO-LKw8dOPWfjmOY1_vSdQ-1; Thu, 30 Apr 2026 13:24:23 -0400
X-MC-Unique: sO-LKw8dOPWfjmOY1_vSdQ-1
X-Mimecast-MFC-AGG-ID: sO-LKw8dOPWfjmOY1_vSdQ_1777569862
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fba8d8c40so27838291cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569861; x=1778174661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFQDmvQVPvkQfq8ddqdKQnGOWaRXmS2QmwZh2RMVRUg=;
 b=lhWeErvMjG+sZvv8516lBgHkwYqdg7FQRPEaboCqRqIB6hUqnog4x/KmtUmXoCbUJR
 IFTZAT2Yp8CLa6cnI1Yqz4Zxjow5jw0xnlPsEeEb2twuGHrZAqWLREHV25p1iKmuYtzs
 DzaokcyC2VRwlZ3IikoFnB7dWXwoIRqx5Fgg7zJUkPAjfm5fOVa05CurodVhm0oZTH/k
 IkJkV1UnpGVUJ9rO1LybQkDjTaIqE7/72iJw5dFZVaLI8XO81ZglMa/NvRI3KC3xLKpG
 8PoMUcYm72q92Vp099hx7D0gHEyPp0SHN7ly8/cLIFBEijWb5ETLbDVlheaw8fwuEZqz
 B8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569861; x=1778174661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFQDmvQVPvkQfq8ddqdKQnGOWaRXmS2QmwZh2RMVRUg=;
 b=AJMRb0qf75izAD33YHVaxZIIhJSxdT4rIja5CEY6qjUMqg8gQEEtPy8KUZWGY+s22V
 rsLhGc4tb1Z9XjNxmW/AtJCQVkMoVoL2gM+jqklhZ+IoX2X8qFlmF1/M4YqduYHyzPW5
 1VGnfyeAhe5evieNYSp/G3+R8aUFSoozZ795yGJvU6YW529krSWtqm7KaBfbNkInNdvf
 A7QcR1/NDttfwDCsaUVJ65lG6R43dEzZnDEolh4f0CFb4mbQL/B8LFUNSNijojOEMpYa
 LRBZptbarxVbwCrAgfljJIGp7t2lSCfig3aTeSQPjyujrh73zeSzIlRLrbUBF0jF4IFZ
 bZmQ==
X-Gm-Message-State: AOJu0YwKQe5nEkFrsvGAmv3mqJBqcCO52zsM7FYMqExfPMTJ4bijS1W1
 87VNVdjsX75/4UAQeVkZ9tgMRyx6fpiEKk3U3VIKddZZvDtgXgeJ8jlOxyGivIrgO7kRcVGVQKe
 jNrCoJbDWxCn21KcMXePCdynfUzT5EA8RW+rP540cmTuCx8pLQtvExAJmxp8CdAJde0+/77uQMb
 krfaZ07tA9f4Xv4N26w1Xg5PdjPC02WDZRU9LGWrrg
X-Gm-Gg: AeBDievP4iasHhMaIWzRCR92VNUggm9GBHWa7zZNukBjwgCrl+UUF90cFKxRugpcY3k
 2x9dzo/sSL2z6NFEZZjv554cy3ANpgBKLKUQrYKlBpIcPhl012L4si1XH1F91kaHZbft0KsinkW
 Buqr/jqlAlp636iyoedVn0ZLy9zIw26XSyEM9xENDxNqLN+zLeb0/GI0Qf2A0A1leNLnQn/yO2j
 iSEMGxlmWQGx1fULuH1KjrmNvBPBrnm4ftqk5XT3yE5Lw/aKjpB1U1KThbP71nEQmj3/1yCDZwW
 sGl6/IlMdYehyyem4FBwy9yJn2B8MxL7BkLNdiqH4hp02tp1MelgOfw1hOm+9AuvQvu1S3Xiy4T
 W196HnFHdStCNb2BG+StlQUVRbf9RmBtOIXFkjcP1fwYCsrDL2mpCNgq9Ofs7oSxYbqPFY+Q/Xs
 9WyG1qS0uT0eSz/XM0XXtEInqZLWaPUET5LyU=
X-Received: by 2002:a05:620a:4514:b0:8cd:c03d:b6db with SMTP id
 af79cd13be357-8fa89324c0emr612048285a.52.1777569861537; 
 Thu, 30 Apr 2026 10:24:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4514:b0:8cd:c03d:b6db with SMTP id
 af79cd13be357-8fa89324c0emr612042485a.52.1777569861046; 
 Thu, 30 Apr 2026 10:24:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb373fb19sm24177485a.30.2026.04.30.10.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 43/58] whpx: i386: tighten APIC base validity check
Date: Thu, 30 Apr 2026 19:21:49 +0200
Message-ID: <20260430172204.1006673-44-pbonzini@redhat.com>
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-20-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4bb99a8e900..8fbce415903 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2079,6 +2079,10 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
+                if (val & MSR_IA32_APICBASE_RESERVED) {
+                    x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    raises_gpf = true;
+                }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
                     abort();
-- 
2.54.0


