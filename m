Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2281EC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtiw-0000BR-UA; Wed, 19 Aug 2026 23:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiv-0008UU-CB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtit-0003zd-Mt
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:49 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2754694a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197546; x=1787802346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zVHz1vI4ZmKFiVEVtHQt6VWbe6dmqIzbriZ7N5663A=;
 b=fJ9Fvt/yUbJvxyXPW0HvCXB34CL7V4xBVg02G5zdu18KxlumLf7Dgfn6uPu2tP88nZ
 pyDL3X0OxNNNr7+n6zRWYLEk3bxI+xy2wkbL4BIq7HUyOo0PiW3jDHM5ajZIdxNQ0mza
 /KQDvNFJ/GZvAn4i5L8lBh9XYapz9nGIFMuH4TiSUkoSqmbVpnMxD+y099jBX8+octzQ
 Zzj/56EIDoeGjHer0IQO1gT3D9KWca90HhI6uCvzKEpJcNNV8IxFzq7BUJ5yzowQsy+z
 dfcd4WlksY36TyTQhZ/kCw66V2qjN9BOsEDrg6vjDvZ2RaoinXMeA7IfTQT6jBO0thwH
 rA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197546; x=1787802346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zVHz1vI4ZmKFiVEVtHQt6VWbe6dmqIzbriZ7N5663A=;
 b=PiomH7YZaBmdfEY03CclPVZMqBipv6HmrnzKYLS5xYVsudmwIFa2uurBnmahHmLxgS
 hwhhXnbnzt2ss3Xwu3B1FmyX/UTHHGX8xePC+pT/O3OgLAkl1CQ2dsJl55AoweBmK6gb
 sAOOMjA+z4b54wyk6O4We3RBDKpsKeWngsH1bLZKfgDzDsZrMW1sYSGUUtbbGFymfeeP
 3ZfwIWB790nYnZr4OY1waZ1pNUfSDyCErB4mOMHYQK7M/OhaUwNUFUhxGQbqX3PnASSx
 jqnHQmhbOunRUq0RsAU4qi8fvX16JRL9WwxiNdwcUr4flvH9VNQFNdgUmnnnko8byWtH
 Vt4g==
X-Gm-Message-State: AFuF++lz6K7QYG4qx4sPT9g/5uIR+HMtmjv0UsCCflqfe/Ud9YxYgdjF
 qJ2eCsGNPK1lAL9OqHdgR0znte3jmP5aEd0hWQQbjN/BS/RwKMNIFydWxdnaWA==
X-Gm-Gg: AR+sD13xTKXuSToISBpdR9iIDzB+kD+YMUDOLPfsDzPwD/TbqnCw0YYisLCFt8tk8em
 kMscuQIwNAoy5ulAU7bJa7pAYo0EXU3McnsaYAQJoZhY4A/kFH++CURT/cYBaTTqyoc8q7EvSBb
 u6oQeoiBEXPvVVMtqVYiV1WDXtDueP2ZDRD8SaHHgROmGwrRGH/kuiIEjyyBmy+i6HJe5v5qRJJ
 lOZMRlcYS+ueQqrPhxgADe3xyL2HWOYskdOdvETJYuMNPU2nhqvYXeyF5O0u+gL24eqLUhrcHjt
 Ge4fx7nnCo9obQfsp2YBGE+6iozPm16okVORDzcEyyEB4ASNXoe608ahYgr0cQYYYTsnKnOOZZp
 2KBWL82pVBi/U4oc5GtyseIr4JjIH7eHkFrc+WW2/DLw+x/XVAe25KJdHc3mdxHU9o9XXHtH7ek
 JaYgqHDnCW0HE553+z7qmcGcFj96pvwrfPIlfKBj449rRYyUeIxy25gT/ti+3QUiMh0wa1XH9lA
 iRZfuyckZc20+OO3g==
X-Received: by 2002:a17:90a:fc45:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-39580f6d136mr18842994a91.12.1787197546101; 
 Wed, 19 Aug 2026 20:45:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/93] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
Date: Thu, 20 Aug 2026 13:43:18 +1000
Message-ID: <20260820034430.1186695-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
Now that Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-7-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b2693f4c20..d8f239e41d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -165,7 +165,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -2316,6 +2316,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.54.0


