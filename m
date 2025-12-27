Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8816E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQw6-0000PF-Tb; Sat, 27 Dec 2025 04:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQw4-0000C9-8B
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQw2-0007JK-NT
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkQKI9pL9QEKwisRnbeQa466UkPQngXQc9/Gw/kxCsU=;
 b=EvpviqUy7ciLZQU5D7akS822TE1wHJD8+4JkFnSk69xHUBqTXbe+PGUqCtC1/Hl/dVeKNh
 iSM28iKBM6m86AHv84aU/5ZBsIFpCC65h6MJZRmPz9pPxKUqwBPCzEq68qnxU7U5pBJeWH
 Eg26441IhbWcOOTz8tmMZxEDzmPmDW0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-HAUPgw_eNPWKKPszY1iLgg-1; Sat, 27 Dec 2025 04:50:03 -0500
X-MC-Unique: HAUPgw_eNPWKKPszY1iLgg-1
X-Mimecast-MFC-AGG-ID: HAUPgw_eNPWKKPszY1iLgg_1766829002
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso55692735e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829000; x=1767433800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkQKI9pL9QEKwisRnbeQa466UkPQngXQc9/Gw/kxCsU=;
 b=ExrLAXbOBO6N1hLTCcdi+p8f1Cy6LIQNZTKhfbt+XFpcFyXFLYEhVf+obiko0yn5KU
 zu22+mCe+RLagXjDIcGvLuL8JYS8I8+PX6EdXfyuyfstCG2zBIidG9wiwcOknNYTdshS
 pSk/q+80r+elxwrJTE9eDA3slo3XM/gNUSKC3mJkebAfHpAe37yCZiYRN0KXE0cfT99o
 7SHNLEU0Gt6wvDMm7jCtrT+62RSJtZjHwLJgRGQ44m0BZ1Cv21T7ZRqJS9yhWU3fniK0
 Pf1Had4P9tvPAUbnM8vLykDglkanwxGXA9267QfvDsacq+iRt8hBF+iCONBnIR2li8q9
 f+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829000; x=1767433800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PkQKI9pL9QEKwisRnbeQa466UkPQngXQc9/Gw/kxCsU=;
 b=dQtPe5T2gkVFT9ydHWV+D50v3L46DsFWCg1cfLw8mII3oMRf9nyKOrpY99aZUJ9UZy
 vC//vmIEIACYSM/D2khvrcFISbUfL/4qqbavlevyjzZ/Nrgdkv6NM6YBuey2hJJClUnz
 f03PMXnucgQesW33nVhAJfauBzqbkQg9gvlSgmC91QHT+op6wLWY1KH68QQO58LHpMfY
 hZUK9REbUVWP9iFClqdtaPoO2N14b6I58aEI9/GoLBHPmBUnWz/UBYrZneXAMdSwixKb
 YE3cKTXOGWrjBpVb+MGKIPxdcSQqGOdEQhMWV+lGbCHcL3MH4T+q9z9IeBycxfm7Vvb4
 pjXQ==
X-Gm-Message-State: AOJu0YxSFkhaaqfzuhx8TeCB+kgt15qXOZ42cayMUieE0+Ng1UIrdrsb
 1F7QoH0lTNFTC3FXRIrW/QmruYmyhzxHyTUH7UalGH7EUT5EMaudh7LIuiPEUjfpYG9NPU0m1Zj
 NHDHw0SS0MitcXr+cAuUXiDmQp7JUPo+EHGve2wb0cm4wUD9lT71TUfeTRKU7uVQFrhbEdAmzZw
 dqeSv1C7I1jek+v+F2ybQmCJ322QPgCFtI/9j59dBI
X-Gm-Gg: AY/fxX7ptCIPsKg0tKsXEqKFZbFNN7Tc/y1sIZYOWi7EVlT9/vV5eUMHjyXcIWhhm5i
 e6QvGXWzCgXwBZHXNl3YlLIs3MxvSr7fPY/eSYxaqq6plwWgBW47dTSKfhmJb5i+esC5bPx4cK/
 fZ2Y9PDxXomFLBi22BMwWvhFE2YWbijEeGqOKuanqxaSGRDkDHh6qw7+EVJvWT9rxnaOUNNIu1h
 xDS2OpysnHudCfDFm0SqbQYsOgXfaQfYraM8VC2TihACPiphPI4gQj77DG2gzMmACv4L7a/Ghl8
 wXq6W9UvUG2Wrzxadc2eQRnjUFs78AEK4vioCdxOOqpuV+FWWmXTvmgYOVTNoAdyGeOPPaFCPIQ
 aup9KQxYPNbmAHaO7rPPto6XpWhUhT3Vr2HfV8yk1kxWoueZpN31Ta215EJ0ZefBk8LIGFK5r+C
 RAL5UriGLUjgFDoRI=
X-Received: by 2002:a05:600c:444b:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47d19549625mr246540175e9.5.1766829000370; 
 Sat, 27 Dec 2025 01:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC8ZN1aBo8QJMzQeftFctozI86cnqOWjj1zSFB2NRhjJkGrAwb8k242bCnrf3RwdEDvn4wxw==
X-Received: by 2002:a05:600c:444b:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47d19549625mr246539905e9.5.1766828999884; 
 Sat, 27 Dec 2025 01:49:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm48761867f8f.22.2025.12.27.01.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 119/153] target/i386/tcg: do not compute all flags for SAHF
Date: Sat, 27 Dec 2025 10:47:24 +0100
Message-ID: <20251227094759.35658-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Only OF is needed, the others are overwritten.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 22e53f5b000..131aefce53c 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3778,7 +3778,7 @@ static void gen_SAHF(DisasContext *s, X86DecodedInsn *decode)
         return gen_illegal_opcode(s);
     }
     tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
-    gen_compute_eflags(s);
+    gen_neg_setcc(s, JCC_O << 1, cpu_cc_src);
     tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
     tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
     tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
-- 
2.52.0


