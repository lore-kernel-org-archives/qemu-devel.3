Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E8FC83013
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 20:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgX-0003Gc-6K; Sat, 28 Jun 2025 15:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgQ-0003F7-4V
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:54 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgN-0000Ja-L7
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:53 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7d3f5796755so313449885a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140670; x=1751745470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sh9BBAUKCRRchEMhh1wAwvgv0ZLAu/7PDYQAsn4UYuo=;
 b=xtji0o9g2QIap+pTOo3RrOD/dUObhvUSznHsvHdeWMuvybGL7sFklEwubHwvTE3tt0
 DEfV1YqrvvHSCJ1MCzns6nmpU1nAM4G/aNJ/xUuuqW3zDDIUlnY8FcibZ6zoBSm4mPmH
 4mLIoYcYmYziNTQUNbzSg8AGQ7Ax5cMLSXCQsqPczhBn80O5pOOBShHut7el4ONfE5TV
 VYdnS8zc3vuN6W7ksDQj7M1DeeGaZMrN4KMDoKxCjfSbihDcOMem9wH0p4ERLJiaXSct
 +vlf7ru4BXe0/RxOmPgytyny+1GISSBe1ED6/NLpsFEEccp7NjTrAy3F2uid0yx1IXHG
 +YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140670; x=1751745470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sh9BBAUKCRRchEMhh1wAwvgv0ZLAu/7PDYQAsn4UYuo=;
 b=dWSCXl2I8Uf+D9I8T8KV2F7SsBgUrXp4UB30o4FTpUR4mdIJk3bW+vV413X6cFmSaD
 76YfzEutju/RdmWubKdxtdL2f7SiE7RUucwnYkdRtBzIHc33MOVzYLN0feIUKZL435GU
 9omslCmto62FTmj91Me2Tml9ZwsLgrLEauOwMPLmyUDpre/8IEVcTWNmL2EvR9y55J1k
 iY4PlDe/FuOL4GwqmAig/sIVktVBDiLVjaJySVqTLH7ViXyJTKEtNdF02S/l1dZrOD3V
 CaomOUSqx9amrCq8Dq7yT3XoQE6KzO+IbzEOMayPRlu5hff2bMn7c/w7atAspX0u9w3i
 yvtg==
X-Gm-Message-State: AOJu0YwADLePxeZrw4wGVopQxgr35R2lgzpoxvnEDnkYxBpMqB3WoAOa
 VTLqDkG5Qfg64zjRqi8wvBoZ1wCJLsDsO5T2Yhhz4OfYpGF908JKEvH7Ey0BRhoYiaD+Z+7+qas
 laYJ2
X-Gm-Gg: ASbGncvd5J8NQpKLk1V7nzqM9mmN7XJopqWu08bpZTXQwcUcj/CVwo7AbQKJ7QDFkY5
 5Z51G3DsKIru6rXUTegPTbgGUiPnMnv3LrRxKaiTvbkp2kusE9TInbWfOlC8G4KovnLQK5hJ6Xh
 2sdbzg/NTIk6ogByfuyrAO2u2B0gC7dzW9K9z77KQ2zb7bUG/ECCi4fCoZi555sQ95PbWYPcpDi
 UUDHxs1V7XRSkwApSIShwdmn+5wBay3kQFyWCIa0nTgG/Fx/r9yPTYIRcZGIJWbbUEmSoNQVkkY
 Vim69FXRtQYRO7Eaxrv7io0jbOFYErQIm0NffNYIjb3ekPzy5pN09KgwSiX4yvfN7ENP5JOVvvp
 EEw==
X-Google-Smtp-Source: AGHT+IEokQlorS1v4Gz7zCFH/PUm0ODxAYiyCE6aFtz1gJB0afwNAjlfXOvvrvcQgadQe/yJmqRJ0Q==
X-Received: by 2002:a05:620a:4541:b0:7c5:4b18:c4c3 with SMTP id
 af79cd13be357-7d443979161mr1158238485a.30.1751140670338; 
 Sat, 28 Jun 2025 12:57:50 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:57:49 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v6 2/9] hw/arm/virt: Simplify logic for setting instance's
 'tcg_its' variable
Date: Sat, 28 Jun 2025 19:57:15 +0000
Message-Id: <20250628195722.977078-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250628195722.977078-1-gustavo.romero@linaro.org>
References: <20250628195722.977078-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x734.google.com
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

Because 'tcg_its' in the machine instance is set based on the machine
class’s negated variable 'no_tcg_its', 'tcg_its' is the opposite of
'no_tcg_its' and hence the code in question can be simplified as:
tcg_its = !no_tcg_its.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99fde5836c..6d9256a525 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3342,12 +3342,8 @@ static void virt_instance_init(Object *obj)
 
     /* Default allows ITS instantiation */
     vms->its = true;
-
-    if (vmc->no_tcg_its) {
-        vms->tcg_its = false;
-    } else {
-        vms->tcg_its = true;
-    }
+    /* Allow ITS emulation if the machine version supports it */
+    vms->tcg_its = !vmc->no_tcg_its;
 
     /* Default disallows iommu instantiation */
     vms->iommu = VIRT_IOMMU_NONE;
-- 
2.34.1


