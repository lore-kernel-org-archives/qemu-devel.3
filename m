Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A03606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=iw9JYJ7L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJmoK-0002y8-Tk; Thu, 22 Oct 2026 03:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmnj-0002oL-Jn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:25 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xJmni-0005vp-5E
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:01:23 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1792652469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hYWmxUkKZzPcn+f2QGYdFeMzebAT/dEKFc9UdyBWqA=;
 b=iw9JYJ7LX3OMF4PfHVswoU5zxDq75gUjShny98ZJMNZYx/H8j2SmqGkd5XCRmEQwgL/SIv
 LyDpcVK3HLCTOwCEaIQ3PohjYZU1RPGFrukJzKu0ycMWI0vxuKZZxABVkRbbFRLn2iYl8t
 tBgKsFfyFotOv85ayxwoQ0o4ly2WH54=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, Stian Halseth <stian@itx.no>
Subject: [PATCH v3 8/8] linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto
 CPU feature
Date: Thu, 22 Oct 2026 09:00:59 +0200
Message-ID: <20261022070059.3861291-9-stian@itx.no>
In-Reply-To: <20261022070059.3861291-1-stian@itx.no>
References: <20261022070059.3861291-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set HWCAP_SPARC_CRYPTO in AT_HWCAP like Linux does on real hardware
that supports it. qemu-sparc64 defaults to "TI UltraSparc II",
which has no crypto feature, so it must be enabled explicitly,
e.g. -cpu TI-UltraSparc-II,+crypto

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
 linux-user/sparc/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 181f1e00b5..0412741285 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -90,6 +90,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
     r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
     r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+    r |= features & CPU_FEATURE_CRYPTO ? HWCAP_SPARC_CRYPTO : 0;
 #endif
 
     return r;
-- 
2.43.0


