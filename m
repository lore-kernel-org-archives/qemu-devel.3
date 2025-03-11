Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78ADC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzID-0001wZ-Vi; Tue, 11 Mar 2025 09:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEN-0005TL-Ui; Tue, 11 Mar 2025 09:01:21 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEJ-0000DH-2M; Tue, 11 Mar 2025 09:01:11 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff80290debso7724277a91.3; 
 Tue, 11 Mar 2025 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698062; x=1742302862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAXQPpG8yd5CXPgOFWtFPIwtpv24G2eRO8aH++zGVxo=;
 b=G0Zm74GA1pzpklSPTPSacE1hJP4V0G36ex4nKhOHlf26g7Bz6y57HAHo6fMWSZa6Wj
 2JbAUA2MIeDl3787lVzG0Odho+8xYVTB+2PSdosWF1qzcAxBNWSSsTVzfxVG/pvIKmcU
 g/1c8oIEBoo+kTjVAoQBhoZ/UQ8aW7TckLhBPjBSbzbJLiNjpb/+Tk7fXb2gG0sZqLc4
 DpG5bkiO3Rp0NXTl31igvUQ3SZhotNTYHgTBNwX/lHi5zyq6O0BQimOTxgCRHe0dWkBU
 g1l1kuFkFjsz3sSyv6A8wb9oFl4EzjQ20X+ZOa6bsXGmGdyysliK5a8aL7+U59alBZf/
 IwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698062; x=1742302862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAXQPpG8yd5CXPgOFWtFPIwtpv24G2eRO8aH++zGVxo=;
 b=bpxMZJPRi5TbWsCe1b6WbLxlua052m4RSnxjY9raZrEIdrbabUbloF6ubOvkMs3Y/t
 S0pRaxF8zGwXNMlyOHt192WcfBkQJD7xa5qlJmiRDZoKoMh9eg3xFLZl+x/idCOCTIKq
 vBOo4Ykxw87DYTmICgzkU+HxoJ/wnxYfwkh8dLRaEBmSlN01V9Y+xEBBGHOC2zqhl/8V
 jjVXnge4okPIxTrB+fmo6itOwHS6KpjZoPctamh2igwESZZDOruR0YHy+Sr0mXAqt/T0
 CLo9IGwQYmRdTuhxoDWKpMZuGNGNduth8HcBIuHNphKldAx360cPObpnybNiAp1nSjkz
 eziw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRKEjNiDuoN7UBiJQy5WIA5B4WZsak93ZAm5IDZI++KNve+1rELh7BAIV0Sds+p6TM6TQf1erndA==@nongnu.org
X-Gm-Message-State: AOJu0YweEl9/qmsLDBiQgnRMttuTFOGP1jCS11oCgh6xktUiw6BY+i4L
 u28BeLYckAiRSY25KNYqATxC49bQcHmJ5ERYDH78MkX43JkH7tXtj8g+DA==
X-Gm-Gg: ASbGnctnIOpq6Gx5V++I+XFeVH2FjgvrPYd9bwzTBtMl1TTAvbPxkkKynmWqr0flW9m
 LnVrlszoFRUvoarcasy1vSiTa0nSdGT8yJUWIKeUY6ayCqscdxBpkTvNGkwMPFlKXX6GiWjEfjw
 hjtaUjL3pTaSYcM8KS4Ibp8HL487a4b70zB08JF62RdcBFY0xHzkghynJtc2SJ5vOFucOG6PsnQ
 EytqbR92Hm9RTZWXF86lBL5/TGhaNTE6m/IdIrm75kQRTRuBqv/vfC9jixzQf2WVmDHcVR/MNPm
 RavAVgK0nJA+BXlQM4scIMK4uKw9c8RstILpCICnykd7dtm2wiU=
X-Google-Smtp-Source: AGHT+IEJvJex1riie9VM+bWx3XlnhXhRmXd5P61c4kiVRPjzQmZVW6m/KZ7BsyvbNOgHzGmhMPAdtg==
X-Received: by 2002:a17:90b:390c:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-2ff7ce63ffbmr29281898a91.14.1741698062313; 
 Tue, 11 Mar 2025 06:01:02 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 51/72] target/ppc: Fix style in excp_helper.c
Date: Tue, 11 Mar 2025 22:57:45 +1000
Message-ID: <20250311125815.903177-52-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix style in do_rfi() before moving the code around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-13-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 511e27f726..659852543f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2558,8 +2558,9 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
     msr &= ~(1ULL << MSR_POW);
 
     /* MSR:TGPR cannot be set by any form of rfi */
-    if (env->flags & POWERPC_FLAG_TGPR)
+    if (env->flags & POWERPC_FLAG_TGPR) {
         msr &= ~(1ULL << MSR_TGPR);
+    }
 
 #ifdef TARGET_PPC64
     /* Switching to 32-bit ? Crop the nip */
-- 
2.47.1


