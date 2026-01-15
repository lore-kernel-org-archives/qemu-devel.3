Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60613D4116C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbf-0002HL-44; Thu, 15 Jan 2026 06:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbJ-0001eJ-Mo
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbI-0003xH-BY
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giKSKVqcCxHJXVRjF7LdnzruvLYzc/gtOi+ALaTIzgQ=;
 b=GXzX4jFR5JiHlkAgWMxrgI/rf4WFYQmEjN9s2nSFXeNHRGPpItsz6cLjUdPeEh3A4wvTHH
 DMip2li/l79hETVvqwZosvzOGsEXco9AdqPjeLINfyiwMGQ5Bqe5R+MztZOGcztTl556Ip
 sXzsbAev/nQHqkBaqc4UY40DzdDPy3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-IV_uDt_hP0akAY574tsMxA-1; Thu, 15 Jan 2026 06:33:14 -0500
X-MC-Unique: IV_uDt_hP0akAY574tsMxA-1
X-Mimecast-MFC-AGG-ID: IV_uDt_hP0akAY574tsMxA_1768476793
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47ee1fe7b24so6972935e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476792; x=1769081592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giKSKVqcCxHJXVRjF7LdnzruvLYzc/gtOi+ALaTIzgQ=;
 b=pW/PxRXqvEwr6Al+FQKfC3+56094z25qxSzdhq244UXJI/OU3TczlQ2ONO31JuYulF
 I7i1zpxjakQdBDkrizWA43fabXBXea1simw8GRzJ769Uc5VUELFqx0sea9Mr2Z0GJuTM
 GQUXuifyHh3Sp5Zna0++hs4itBbJjSjd8WARVUtMHHB+6dJLAubfSocPLMPhzWWWa2Eu
 +TARiYPtc7XZqqELoaVPKA9pailhkGTaP+v5ChK0a5mOalkeY7PoR3tZcg01wB3zqvr8
 /Xv5aIT2zmtY1T+ey2c6UIB9A1p3MfigwzlBdUYpM9hPP0sLN7j3qHr0NVgSvg14uQ7y
 bRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476792; x=1769081592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giKSKVqcCxHJXVRjF7LdnzruvLYzc/gtOi+ALaTIzgQ=;
 b=kfKxc3mdNPP/uvExA3GXkoYZmt4P+2iUFjm4bg57n5LYGE6LjFQAnWke2EioEU77j+
 vCE4GpfHgfDGY3Xf11+QBGzb+J4hNhp5aLiffH73fcNzjK4Tcn4eLW1uo3fmcCSokEaF
 IOjaDgpMd52pMxyvOYKCWHDOEQDo7PexrsN6Cks5DcwbX+5NPEepEUP4tpqdQdJYpOk1
 mxyG73JQnvuhTQv3mTuwF5p7gbHioqPEHDpZ/JixNoAT+kL8BnQ06kBwgf+jycOQKvqn
 3dEMXs22RSGOL/sLjPf4lYabYjNaxL1jcyIfmOl/Et6fa9TCISDcc5t4DhLhXNkxBqTS
 00dg==
X-Gm-Message-State: AOJu0YzQ5ibuBhBjfGXv/K4Pv+bO3EtFsoBM0PYMFC3eaqwrK0d9WMG1
 pbAnzQsli57PrUBdW0DCdq7slYKuIGNm1Woa/Bs8cKmSRBCc+b02lN5yHifLlm7jocXbOmSoFrI
 e0DKeJxa4aSICDNnA9w+bDMMHl4lOloChnUjtxqKD8TjrcVG2o5TcDEb3hufWL8dY9yN6oBu55z
 bpwkPek/FI9TdkBgk2VjVqt7oJYTKN1svqON8VHM9w
X-Gm-Gg: AY/fxX4bup9Ekb+U4Xl7AlYFSCkm820m1OjaxN50MzLFsFzr+9D86isIR/dUdrWNBIl
 abPH3fH659tRduiH+gUwuLnV7rUspwNo7QL0J8vI4zwxhS9hrexISkPMBE01320t0wMZy9JW/0q
 LHjUiwHZD+pvRPXaP91F7G93EHoGxSMLFLh24qFkU03tnUrPiyG51w8ekuGD5sDz5GFzYrcEglB
 6/euKQbi7k3lBEPY/0tgSQ35EoFdjlokuVkKNTZOGuhQRmWsgN9UmUEttoeNKNiaZ0nG8cuuu+u
 /KdHV3eVQc9Zk3etw0RSKd+OaZwNzXq1RzOYFStsQF2mE8fGcmhqbmSwKQWup0SxlIv/lLcbpTH
 88ePBJk9MIy+8cDkni4SrbTg2OxH5I+UFmyqlgRvSHJaMP5yVL3Tot05Jq0NRNnSYQfiwd3QNPP
 YXvE7puSPx2uAzpg==
X-Received: by 2002:a05:600c:450d:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4801d7a4ab8mr1080055e9.19.1768476792638; 
 Thu, 15 Jan 2026 03:33:12 -0800 (PST)
X-Received: by 2002:a05:600c:450d:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-4801d7a4ab8mr1079575e9.19.1768476792248; 
 Thu, 15 Jan 2026 03:33:12 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a778sm5373995f8f.3.2026.01.15.03.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 2/6] target/i386/tcg: fix typo in dpps/dppd instructions
Date: Thu, 15 Jan 2026 12:33:02 +0100
Message-ID: <20260115113306.126905-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115113306.126905-1-pbonzini@redhat.com>
References: <20260115113306.126905-1-pbonzini@redhat.com>
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

Their gen_* functions were incorrectly named gen_VDDPS and gen_VDDPD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 target/i386/tcg/emit.c.inc       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index e44b92710cf..b00ea3e86e8 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -977,8 +977,8 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x21] = X86_OP_GROUP0(VINSERTPS),
     [0x22] = X86_OP_ENTRY4(PINSR,      V,dq, H,dq, E,y,  vex5 cpuid(SSE41) p_66),
 
-    [0x40] = X86_OP_ENTRY4(VDDPS,      V,x,  H,x,  W,x,  vex2 cpuid(SSE41) p_66),
-    [0x41] = X86_OP_ENTRY4(VDDPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
+    [0x40] = X86_OP_ENTRY4(VDPPS,      V,x,  H,x,  W,x,  vex2 cpuid(SSE41) p_66),
+    [0x41] = X86_OP_ENTRY4(VDPPD,      V,dq, H,dq, W,dq, vex2 cpuid(SSE41) p_66),
     [0x42] = X86_OP_ENTRY4(VMPSADBW,   V,x,  H,x,  W,x,  vex2 cpuid(SSE41) avx2_256 p_66),
     [0x44] = X86_OP_ENTRY4(PCLMULQDQ,  V,dq, H,dq, W,dq, vex4 cpuid(PCLMULQDQ) p_66),
     [0x46] = X86_OP_ENTRY4(VPERM2x128, V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bc3a07f972c..f5f12e48b77 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -788,9 +788,9 @@ static void gen_##uname(DisasContext *s, X86DecodedInsn *decode)
 BINARY_IMM_SSE(VBLENDPD,   blendpd)
 BINARY_IMM_SSE(VBLENDPS,   blendps)
 BINARY_IMM_SSE(VPBLENDW,   pblendw)
-BINARY_IMM_SSE(VDDPS,      dpps)
+BINARY_IMM_SSE(VDPPS,      dpps)
 #define gen_helper_dppd_ymm NULL
-BINARY_IMM_SSE(VDDPD,      dppd)
+BINARY_IMM_SSE(VDPPD,      dppd)
 BINARY_IMM_SSE(VMPSADBW,   mpsadbw)
 BINARY_IMM_SSE(PCLMULQDQ,  pclmulqdq)
 
-- 
2.52.0


