Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A308D13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXy-0000qQ-97; Tue, 27 Jan 2026 04:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXp-0000i1-G7
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXo-0008VC-0l
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi4LcsT4yM3F07gqORld+zxtNy2ZgUvhd+Za1U39so8=;
 b=VKvIBvDCYzAbLiz/gX13436Akoju27wLm6MN1snEDdztmGChDPy4eY3jYw/zKLShU/um5l
 qukJym/AJclJOsE40BkGHH2fPuIHynJDLIlpoO3N0vFHkE0gXj5JCpR7xogOPGb1ZMkYeR
 glcUpXHDMYLntkltm3YLDwJdmEVZ888=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-XzN1yorkNN2D__TD74Kxew-1; Tue, 27 Jan 2026 04:39:28 -0500
X-MC-Unique: XzN1yorkNN2D__TD74Kxew-1
X-Mimecast-MFC-AGG-ID: XzN1yorkNN2D__TD74Kxew_1769506768
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so4066976f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506767; x=1770111567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pi4LcsT4yM3F07gqORld+zxtNy2ZgUvhd+Za1U39so8=;
 b=PdYzVPBq8logTJ57ibXoDkJpXIalM6y3Ls8cy2FnjQaeRvLfKhvVVg89MWQXS4Daq/
 FJXaxn0lEzf9Mfu0StiZaXhR/x7AdI5oriyWuhnAkDCpYua7wc+fq61w0v5Mvb0eH6pX
 u6KoWYpm95ried+oTB0EXIhotSPZJ9QfUcWIEAOwCF6WfRESAwwzNehIuHGQyoW/WmZM
 AaMm0ScUIoCYWOXhv780zKvumzx+3/vjgD2w9V6zDID3LuR+02YRZk4e36cf7WRwiQIb
 76K5HwEE+EcaIZDt8jZwVS7jbao/25MpY+octorAPj6siPbVz/3zBjDsrPrRtwwEOp7o
 nROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506767; x=1770111567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pi4LcsT4yM3F07gqORld+zxtNy2ZgUvhd+Za1U39so8=;
 b=PvveWTOvIMRVYyrAlksrfm7T+uiWHtuAWagyCrEUyPIfB8NeMwjywQ2XLqHEnTCuvn
 V9OqTZE1VZ9PglKBfCgUVeNujdiVrC70lx5Mqqr974C5PcfBDkdVXpTgjYzLWfcCC0/5
 S7XdT9kchvFAb56742ED35eLFC9XRpwb+GA2IFOpKXUb2os5RIU+acEaMxJMO1hhoxc/
 qLTJyEpI+fmWp+vp6Nwp74IkqklE1xNL+tz1C8VUbFl1WJuEQlyV1Fm9yv3qNGOyDSup
 nJ34roQKTn/0nCGB5nzr/MatZjXdDiXjWYPAvCiiRnsWZkyKNSP4b/fFJxtzpsXi+0fj
 i/AA==
X-Gm-Message-State: AOJu0YwdaOlptz3fdPd+wS/KBJc1En/PO2irCJiOr8zoyhhOI3e04VmV
 E3vucBQk4oYahv3asCS0cIni8WBAJaVVMWJOcDO8L05JZGwtIzhLjZVXw2M5pQ8r/YmBHWzX0uT
 nwixQ9F2mJxsrXO7GsnXLZXVAWA4dELsdcO+1hw4RXDWWgxJVSetTYC+m6IOxNzIdTWstIOn4s+
 vJMoPMRmmYQUJgoCJPMvR/YVNVBJfKWEDNcYxFS7aP
X-Gm-Gg: AZuq6aL2b5L1tKmZF58wq/LcMNtlIbcQbvxfxiR8hwYyz168W+hYgNkAlmCWzaxTowg
 O4R8249aXFvNTziCP7flyiTqMnxe0oIulOj8TqwhXbG23GwLwCyBvx3gcEymp2rTQf0XyyQj/Io
 rwll920AjTr3rfBdt8Kvl6sStnKrTxVEWcvnPoEY1Og2JClotu/fmvo6sFNrmhsdS6ZXbiXVZdw
 kgzJ5oqdQRPB9eiW2ZyGOYd/+AI8ZL3m2qmDf53vblYrAtx7L7AsOCye9wSX3PxTjGDzL9rqLBQ
 dp69Jzdhm30J4F1CxEN6N4VPftaRA5g0o8U2J99ClMOjFJdyvAbiX1wyYcrqguDpO2eDFmMw7nE
 hOJfhlS+3zZ5WjF/Iv71cLo4nO/ylNS2afmyZBfj6rNwnMYOOHfv2/g6UHEtJ3FuUAaID7LGBIx
 qHCpshHNHd4uCleg==
X-Received: by 2002:a05:6000:2388:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-435dd0bb30bmr1513921f8f.40.1769506766599; 
 Tue, 27 Jan 2026 01:39:26 -0800 (PST)
X-Received: by 2002:a05:6000:2388:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-435dd0bb30bmr1513874f8f.40.1769506765901; 
 Tue, 27 Jan 2026 01:39:25 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c0179bsm36549337f8f.1.2026.01.27.01.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/13] target/i386/tcg: fix typo in dpps/dppd instructions
Date: Tue, 27 Jan 2026 10:39:01 +0100
Message-ID: <20260127093906.353741-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 639a1eb638f..f23c401189b 100644
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


