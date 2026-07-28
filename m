Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8169C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonSH-0003P5-E3; Tue, 28 Jul 2026 15:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSE-0003MV-QY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSD-0001XB-EU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:06 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so241071a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266824; x=1785871624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
 b=gIaxNUQsYS6dMjR3slJWeGxAZPbdBXojT2vcwNr9Sx1LG8ayLRv+1TSaji9pMmJ1BK
 kIkSehRbIjtx7UoYTfD6g+fpVfkGK08V/OG+/WJXFrQiSehpmKAZJ4JQqDFNjrhr5f8r
 clgLISZW/2QSdKPaKFBH/F9FyrXxn+W1eJCaScShazFnKmg2XKwszh21rSgv3drZxZNY
 qC+lYDpY9OSR9cA7H/Sernfi1wTgKv+pGaOmTag9eH+Kja/yLgxHp4UzzXWhS58fQAMl
 qdV6Rc1VIm2tuzklRiLKNCYwpNZ2YxeWbP/rElUc5bdhdsFw5QOCwWFGshQDUzl9BW3W
 7Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266824; x=1785871624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LOuBVMlOe80id4VIdSsW07pBBJsvlGWj514CqDOCv8=;
 b=bm1r7uBN2r/I113UsdqCh4Ckvt2wSzbezOtUOBpCGqwcQmHw2mtzzuBsIyqy5OCddH
 Yb1SvBdMZKLlsLHRqEpPbzQqcySzybMpHXlYzS0eeGJ0PUpxOGafc2j+m+oeIhjMFIOx
 nMTQO9cwV1qBIWwBQ+fR/FEGT41Id9qnefRNWC9EAEet4enTIqBtW6kqKY3sUUiHK78a
 7A6fVxWv46DHae3mkSVCQp8PXTMSr0w68KyyTcfZVBB2mLJqi9BvCckjyVgQT1/TuNIq
 3GzQBbQzvNssz7uzK9+0vdQw2NoVwtoFU9F+2u6v8sEpWp+EC8W+gHvt/3ElalJslDda
 lIeA==
X-Gm-Message-State: AOJu0Yz9R1nv1aKwdfLCxroim0UxPzIXNPWJmS20T078xHWzkOMnUyBl
 ojdN22orDYCLRDoPouUWB4WijCs0Ux9Cp6SSS3evzU4ByZtN+tSdl5lKkH76oD57HnM=
X-Gm-Gg: AR+sD13rwdktu7o0bTS6uO/ufKQr6DSecdrAkYXP0SlsYPwaoWFraLCFK7YZiznc7t9
 ziUedoq2pKaVCLKla4YRx8WLiSUYUtoCF8Xg9L02Lj+aZhzT9tt7mTAEhzB58PcHGwgOiodpjPc
 Keg/QtRj6GwVt2G0SsVmA86rAvZwRCPvlBrshUZEaQYyNpnXlYP1A+zsro+Raba6XWMgEGLYeE/
 8oUeaTjBD+VIIgM9kF5YgLGqY6RmbLGP/gcj+csVrwCEkZLzHdhpbPjp+T3Nsy06wbwXzat7R4s
 /R0t93TRWVWHzjUFgaZmC8wNFfB7D4sKvoEzi4pGQ5AillvDL93mfwPxfRp5Lil5dK7y6zGYEvF
 VjZ7u43JhZWIOFnyEV/lUq7ZaMiWm79HRM3Oq1ipbBfDTn2VbgfiVeVs0/yH3m03RJBztsxtFXg
 xNM45IgjEl0gUiK5W/1+5UHOB32Xgk
X-Received: by 2002:a17:90b:1645:b0:38e:6aa7:686f with SMTP id
 98e67ed59e1d1-38f6a465625mr3705387a91.36.1785266823878; 
 Tue, 28 Jul 2026 12:27:03 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:03 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 14/24] target/arm/cpu: Don't read Realm registers
Date: Tue, 28 Jul 2026 13:26:20 -0600
Message-ID: <20260728192630.240375-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The host cannot access registers of a Realm. Instead of showing all
registers as zero in "info registers", display a message about this
restriction.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 787e4dc7ab23..7679b8758262 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -965,6 +965,11 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     const char *ns_status;
     bool sve;
 
+    if (cpu->kvm_rme) {
+        qemu_fprintf(f, "the CPU registers are confidential to the realm\n");
+        return;
+    }
+
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-- 
2.43.0


