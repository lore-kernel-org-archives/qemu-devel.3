Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FCACF649D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMF-00037a-0m; Wed, 19 Nov 2025 19:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMD-000373-7y
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMB-0007PP-HA
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VScUxvTA0V9fVcKlY6sj0omEw5O4+ANSWsdN9yl+u+8=;
 b=VkuYf8eHqB4T1jUH5WNT7/IKL1FteZDMJRyeFbbh+a6ImgH9nMAD19PoK2R8qGOQA86Bq5
 38+tqupF44s7oYJAqyag59+RRlNw1r6vrIbAJohqyfc5dDvvjGZHjGa0Y6WAYkBluM4sDu
 jFjtlbG6c+Dpnr8mbSzdRxLSeDcm7VQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-1-kz-T8LN-uYG0X6v3akzA-1; Wed, 19 Nov 2025 19:17:00 -0500
X-MC-Unique: 1-kz-T8LN-uYG0X6v3akzA-1
X-Mimecast-MFC-AGG-ID: 1-kz-T8LN-uYG0X6v3akzA_1763597819
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779981523fso4306215e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597819; x=1764202619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VScUxvTA0V9fVcKlY6sj0omEw5O4+ANSWsdN9yl+u+8=;
 b=sJxaOqSkvDgMIEVOhWWjt64iqub9v5HlF9XYvhqkrdFt+9y0Q5qLy49hcuLvIG/NZc
 tGfmS4eQvNsUUPuh8TW2Cxj7OEA4CAUKCBZXegh057a37eX8SjKk1wXly7O89+GewcTU
 AqdkxFLLh5nXuW4aLVRe1Jq2xIjw9airGab33HlfWoIweWmmoi6/0j0xdTM3zbmEK4+0
 l0iAkZP/TLEFtJj0gOBJNCAlAtX9KDJAZXyzGqaB5hVAGxNjgNbSUM7keEIOSNREqhQK
 2fFB+Lbsr3iwr7zefVspgRpaTAIslWpO4z2hPqgHUtXCNqMWGWiRMg/0z1kwQAlYpE99
 lEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597819; x=1764202619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VScUxvTA0V9fVcKlY6sj0omEw5O4+ANSWsdN9yl+u+8=;
 b=mRgcinwgb9Zk+tFTdlrESdtTRLKzO0n83WGuJxVwdchtpcHP2BLavHqF1tM/ceDist
 siAtSFmCE07KE5AOG5Ja/QfKPJJyB8SyLB0VeYZWaz8BStN+6ghmrNjgaUBuJQw+50Fg
 Cmuxdm6eV6EvDAntE2zUdq+esZ314bFyASch48O/Zo4QL5565mAe2z88liavic3t6hqN
 jhojPYhWGkN6UUKFkWM7GqxeXB4axGcwL6UAqATCvRLjHv+SPkyhh4c1sBj2VAn1b05K
 D+Gu+ViGEcIV2m0sCJskLOGmOqdfe+5RjvUm8/4WYmmun+I1IjEnWChgRoEw10wP/vd1
 1krQ==
X-Gm-Message-State: AOJu0YzT/jDHr3B/Pp0V4Xs8z6AXVWic6pyasPJdQHwOpin5Uil57V1d
 pYdaj202jR0dV7nDu3uXoXWPcMgEDdD7+yHriU2G55aSgch9czuEpsNjmbLhfFCKDc72kCtVEHl
 hJPXfqGC1HoPJHk5hwKNDzfQlMPw+IorzNXkN0KkAdDd5vqDcTYd+VwUVPSZ74vwmURprS4GKbF
 XBxCMyoF40ZUYd1VAnurBq7qN4SbiAhNY7iFdbsDzT
X-Gm-Gg: ASbGncv87S4JsGmcOlb5E3n0UkuYOBUd8m9uzfTfI5Q5923FVNpTPZ8S2HOqcgb03VL
 rJOC9zoA3yxyAAxQ+sPxkLDfSMLNK+mDKaaVzOphu9bB2lAP5W5/2cPWqdtd4eb5GCXHMxTDyH6
 uIkehlwAWBFVkAjP2Xpk5UVXJHf1DWXSDLI00tTZ2o21PL4gTNvzMaqaEM1XKhhwD2RQOfqx9lq
 swMv4dKRADLXbCZB9D4+OVbRAUnrxV8CxRkDLHnNpoR3KmFpxRB1j4lZ/4yQU/p11UdVOKJcN93
 lJeSaLaaDjS8Z+Ikx3eTXfmT9ykzFdCGBQk+FhabnjwD1HWc+bVUvdLyIkjQao6l1TzoC9cVZM+
 subalDmF3Ptk0kxO/r3Sd9tgNeJCW7BiOETe7e1z6e3xAWsOJTIc6U4GXzAbNccn9HGT09TPMHX
 /lJXSVk/VEspvcDXU=
X-Received: by 2002:a05:600c:45d0:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-477b8a84acfmr9946305e9.17.1763597818690; 
 Wed, 19 Nov 2025 16:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+82/zn492FLmKBZZofCi3g95NICfGS9SNuYpReGiEDkp2DBIyWfUUBuom2BoRCvvFpC0HqQ==
X-Received: by 2002:a05:600c:45d0:b0:475:dde5:d91b with SMTP id
 5b1f17b1804b1-477b8a84acfmr9946115e9.17.1763597818330; 
 Wed, 19 Nov 2025 16:16:58 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffe377sm75071285e9.1.2025.11.19.16.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:16:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 03/10] target/i386: Mark VPERMILPS as not valid with prefix 0
Date: Thu, 20 Nov 2025 01:16:42 +0100
Message-ID: <20251120001649.1085913-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

There are a small set of binary SSE insns which have no MMX
equivalent, which we create the gen functions for with the
BINARY_INT_SSE() macro.  This forwards to gen_binary_int_sse() with a
NULL pointer for 'mmx'.

For almost all of these insns we correctly mark them in the decode
table as not permitting a zero prefix byte; however we got this wrong
for VPERMILPS, with the result that a bogus instruction would get
through the decode checks and end up in gen_binary_int_sse() trying
to call a NULL pointer.

Correct the decode table entry for VPERMILPS so that we get the
expected #UD exception.

In the x86 SDM, table A-4 "Three-byte Opcode Map: 08H-FFH
(First Two Bytes are 0F 38H)" confirms that there is no pfx 0
version of VPERMILPS.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3199
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20251114175417.2794804-1-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f4192f10068..805cfd08e83 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -643,7 +643,7 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
     /* Listed incorrectly as type 4 */
-    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
+    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
     [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
-- 
2.51.1


