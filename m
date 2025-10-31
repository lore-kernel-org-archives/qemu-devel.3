Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30A7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwm-0004jJ-PI; Fri, 31 Oct 2025 14:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwk-0004fm-2g
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwO-0006EK-U2
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429bccca1e8so959615f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935613; x=1762540413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qOE3oOcQ2vXEJvzQtPpnmIuRlktDL0KnYr8jhqNcteY=;
 b=iPRZnMo0dZHIPJPnGZ6DCupBHHl/pqOt45azdIK26NFwX65JGz+7EJg9jUBMH9Nk7x
 N/kfj3cGk0ypchk/5ou4FcHN1RAXTbE3Dux1dzG/yB5+9xTRnxGqvbQ8PwQMXA+eGGn7
 j5WF/fNc7hRoRP2kNencEsqKvut1FfW/nVCX2InV0yC3l7MlSlIgCeC5rUUUvZ3G3kaw
 6RQ8uAvtCcWHvxGmw4wcFLdHopbIOm7uLVB6NqH9fHs8edh4UWtR2Vxar7Bze3jxJ8Ar
 B4P58pHqUs3QrjGl4dljJTNsYOUcanGiD1viN5lF2dkLopMnNwKFB28LXtYodJmXPt2E
 7IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935613; x=1762540413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOE3oOcQ2vXEJvzQtPpnmIuRlktDL0KnYr8jhqNcteY=;
 b=QRUr/sghE770StK/FniTuf23HtZ604rw4kHwXCkR80BFY0DymUd3SqT2O4z3xg7/mA
 cHlrfWpAdvNSbMfivSSKReSD00tMJzr2m5ylLv2BlLNZoJqXAAIK4B5nMWX9uCW1pDhe
 noouSzJUpVvARLzD74tuhujvDXVi1w/DaZEU4Q+JZdEklC0+nvwUVS6g4LMGy9hk/RAs
 5+TdStRBUTE1BnoIOfqVblDrb6DbgLhsr87+BKyCEF6fhmelcVLeEeZdJYYb+U4p+4J6
 XARpCfLVtMp6X4pgnRPBKHLfwr8x+lgmJhhor+Nu+ZzwBtxT1edokNH0DJ+oHl1WLeKl
 siAg==
X-Gm-Message-State: AOJu0YwTvAZoqY6LMvr7bSbdzxTheDoCzGb4DPte8IpvxSxyvAwakref
 kxjGziGQNS5UFxVTeqeGSiLPvNYF8SXfEUhPV/lZ3HN08ayJG+/suFo5LUs5wxlO0iKBv9MFTrx
 UPc+0
X-Gm-Gg: ASbGncsPowMVdVVKjm1ESVTwZ8kfjWv1b7ttmsgNb81MVdQGc89d3YLDlY1kMW5hRfA
 YdqFEcPARC5qZ1J1SMMzwBXHPirEGAwZ+gHyZtmlPgzn5mcwELwyjEGmD7tgcmia7UCLIlHe+cI
 OEHv/9vt956483qcJvSWag9zPtyxOI6fIKDLr2BeEFf2GA6/FKMm2OjitOBKT6SIq0LQQPhrZ4d
 L7EkSmJDy6EZQvJuA1+E1aP0GX0x4+LHgxGe0a7EfOLzsWLlk/guRSpj+XkBDX3B4uSvNTDbV5d
 vQtlnh3bBof90/aRE7pYB3kXuCApu1FUILXYzs6HK4H3i8QmbNBeNfzxYyKMqZDaMszJp9SElmq
 Y9OKfOOSMyw32tjn1xZQSDQrrdf1PnhPQUi26/mDvh49xZQWkMSz0Z5oZo2KuGroq00ayLc3v4x
 Ywmxgu+ts4WYX63H3S
X-Google-Smtp-Source: AGHT+IGpijhIY4Qcl8CLprfBlIvUUxbmIcnJups3iwFlvsOFBLTjFywzPqv2YPFSEScqdEAczTUZWA==
X-Received: by 2002:a05:6000:2f88:b0:429:ba8a:a860 with SMTP id
 ffacd0b85a97d-429bd67243bmr3900479f8f.12.1761935612765; 
 Fri, 31 Oct 2025 11:33:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/38] target/arm/hvf: Mention hvf_inject_interrupts() must run
 on vCPU thread
Date: Fri, 31 Oct 2025 18:32:52 +0000
Message-ID: <20251031183310.3778349-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since hvf_inject_interrupts() calls hv_vcpu_set_pending_interrupt(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ee04943b0f8..0d8ff49ae15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1664,6 +1664,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     return 1;
 }
 
+/* Must be called by the owning thread */
 static int hvf_inject_interrupts(CPUState *cpu)
 {
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
-- 
2.43.0


