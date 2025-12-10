Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F585D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4J-0004q0-P1; Wed, 10 Dec 2025 08:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK48-0004my-1C
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK45-00031J-P8
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BD/p3i1pYSpxH2FTrrqUtcDabzPQWRLo7G81MLtCrgs=;
 b=KxsrcWmbijBBpQMmtqdkmZhjIlP/2cWUtOv8ZwWmrdWj95SI98cbZSa4GUlmsOUCAtHeEo
 GcHdOtSqP3B4FQLPj20UipUUGjmMSUwPY7RAggzsxpf+Kaw+kdXIhqz6KwT8mxUuXLZDjO
 epclVAzPRd8/nM4oaXnq3G37mUHlrSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-5eefyLdlNUaQUbguQVkrOg-1; Wed, 10 Dec 2025 08:17:07 -0500
X-MC-Unique: 5eefyLdlNUaQUbguQVkrOg-1
X-Mimecast-MFC-AGG-ID: 5eefyLdlNUaQUbguQVkrOg_1765372626
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cabba65dso37346685e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372625; x=1765977425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BD/p3i1pYSpxH2FTrrqUtcDabzPQWRLo7G81MLtCrgs=;
 b=pR0O6JrJIDAIjjAsX5+lfqX0OnIi9spPnooX5x4gj+gA4g51ms4/L61BWwMX5XdDKB
 dmwz51e5PdiCI1GVdLCmqlsWPlgdiqN6nYQO2EKhyVEUZj2f7PVqs4k1FVR24cJNxA23
 /4t1wKynPv0RiNk+BwzQrRnwV2QQ/AcUYKqocVpTOkIoLR32j9hIIZvBUav6yWv6Zznf
 RiGcxtBjUfwdnVM/Ao7NeE0ELOIJ1WOYYs2YujKrhQ0f1kOxdVTN1uY1DLG7TYFsXv/w
 E+3Q/SKmVhXcFrx5I82LW5MQjEpRawPbDi0awb1xO0M9aQxRg/vUXsY5x+MRQl7FzcNJ
 tSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372625; x=1765977425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BD/p3i1pYSpxH2FTrrqUtcDabzPQWRLo7G81MLtCrgs=;
 b=bSIg1B4BGykb248ALH+Lzya4Q763On1+5m+W2TRxLtVnt5i36enkm8FAeUZEBbzwjU
 VM4/c/Smemx8On1Atfpaig2QXfmlHA+4d2H7MCRX7i9WrJUHDWNarlei0SN+SCCRBgqf
 W1UCyi/KssBRHcHZNrZ26BNU8766bzgWc2szkQIKKioT394VYWe4VqRdUwU6iJLoXK42
 y9LreCXjV153W2NPnZDcPaSF2Qtfz4vmnNXaUv0gRjXAbwR4div/NGA7nmimO7BszQr1
 E1k5l6e90HOCnl902rDqsBX00CVuy8k3AfR/aYOLdFH9Rl+wLq3EoFx9EzJuwAuMXGKz
 tgMw==
X-Gm-Message-State: AOJu0YzT/lo82nY9znv+jFmLygSwHebB8WuL1FRcARSIWQoeX7ykwAF0
 veVQEhc1tWXR8g+fK8PLlCjIkL7p+eiN2vCQBU95CWCiB4Ik4BXa6mSldgyTk88uinSKmNqO01Q
 wR/K+Xjvd+6WOGNRkxgv4wG4brKDf9MMru9sOyMvlwq71Oc0mWQMKnwUgtkGo+693Y/kGd3cTMZ
 dnAUtNA1RWbTq0XqaFd3EfgmNV6vfNxGv877rK9AMo
X-Gm-Gg: ASbGncvJ9p6057Sk6PqZCuHP83YlGEJlvSwbZA5ZhfJYxjeDg/Q2NykSroBQeIQdGa5
 F5hWuyVTymw7bo6whxAfkmku6J8DZ7xbx2Zjx5YfDVogT63UF6RfDwoUxZwSsQhz/v+MdwOAH+Z
 BdjF71tWT2o77J3ceusIs+BE6RIeWAtBkApMza5IKF6+SJ6nYdv/qNLNUzwrTTWswTbB4pxFSp7
 IfkjCg+1CwmMDTRDcfAR0nL5jUC6qajuDEPCO9dV1htil5mVxOBnY+4D/83GkSZZiXeNkvSA3CE
 +MoC0rpTG1qecFCkhcS2SmW+wwmfkTxPiBSaFtnwQnkwfU7+ig140lvDeSAqurfuinRsl7IY2tI
 MaDxFha820+lsCegDz7/+AE6TaeaEitb6XWfFjrSPomRkVMGRsHmTbEnAcHLH1hQ9tAdpoKw0A7
 mTCowMo3JVQHvs7X8=
X-Received: by 2002:a05:600c:6089:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-47a837a3110mr20461075e9.35.1765372625684; 
 Wed, 10 Dec 2025 05:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQx2rPCHVS2/HEnZT+9KcaqjOkQO8dc5sYXmuWAv1UJeOINbg032pVZdvpdYqEeiqpt7tSqQ==
X-Received: by 2002:a05:600c:6089:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-47a837a3110mr20460845e9.35.1765372625165; 
 Wed, 10 Dec 2025 05:17:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d35904sm43161185e9.9.2025.12.10.05.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/18] target/i386/tcg: do not compute all flags for SAHF
Date: Wed, 10 Dec 2025 14:16:40 +0100
Message-ID: <20251210131653.852163-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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


