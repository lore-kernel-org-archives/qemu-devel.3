Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7BEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2L-0002i3-Aw; Wed, 01 Jul 2026 06:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2K-0002ev-Db
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:20 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2I-0004nc-St
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:20 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-13b24ddadedso855908c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901157; x=1783505957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uwx7Dcxgjj/2R7LIGG/v8kQ4FX3R1WYl6fEI6neeRi8=;
 b=Iqc9duHzdVm3Bj8RBj7MtIQVPRX5tra6OInkk7P17fhue0wUtDnCs/taqJB9yl0im5
 RlYkxhE3FR5iiFdE50E93ZySi4GfaryfRLnZNWxPatOI5VtdIUv5j3S76SahBf+v2RHU
 Yh98dCnuDZ/mhO+1wQm6Ojcrg+nYfWGhb/h7Y5xvukxSlNkMOWajbfy3UVmg+YUWG2nd
 kGnmCWV8f3lM1K74bMJsaYkp7VExNGAMt2vPHmg9723c0CwsTk6xIT2SKdJuxz7UA5oe
 /Xc03M8DbplEZoYTWoQnde7bDWukD4/ByAfNw6bfmgqRqTR82jRSAkaMrHwzdQkmiqLt
 Px8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901157; x=1783505957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uwx7Dcxgjj/2R7LIGG/v8kQ4FX3R1WYl6fEI6neeRi8=;
 b=W0ZZ11IVIz+j5GzaCmKuX3C9Rd9U9tEmI2goYYmepvYBDofPxUGsajqpX05MkLFhYE
 HcqtgOpAnFIZBbSCaz6DJXb3Ru78C9RE9fJy1nuB+qMoNvuMEqdyL4H5TebV3RgoEq6T
 o6AQ336LUtmETDkDdqNwc35KAMusA929Vz9NIwPd72kvjzBDS2jz4IDz/+idXdWByBk+
 10R+SbwW1kXWDz723JHi+aOR9G7QyCvUJL89cs0oh4eXmqj0BotOxqpv17WFGJWolkl6
 YC6YfcsfTn8dDEgsvHAJ+5M5DGE0q5QMcKRy+Zfq1M7pYhTG6CTw23bgS1Km1ht15tFd
 2MWA==
X-Gm-Message-State: AOJu0YzPjoGENIeTT9uX4rXLUSOhPwc+m9n6NgBNsVgu9PiZhccq4JEs
 QlXhlJyZYAfAlT96wPs9xVA/C7ECSR88z7Fn+C0+DMYHnbfGpbUSMWSY1ZwVvw==
X-Gm-Gg: AfdE7ckGJfumYxQhxK3moS5FewXeyePu4P5IKkEmFM4SAgjDPpwLbC+E7HUbB2tVxLq
 aNRfaWwBxXUlG43xcvNfkUn79NSw0Sqm0TxFvoXMv1pCIERaVWq66CBAVw8wgUz87EuOsy8fVfX
 ZrLqqhGMSQbQGuyX3YHq31jcIKkBAdUBCQxxVVB2MwWkIlAeC8UMWme14LmZPNeLlz+1qQ6wUY7
 eOL4IYyfxkBA3WAQ0WxGMlGvvEwXEpF9xy5+X0vAmPWRmXQVtRBDbcfnwzDgfF1Mz925ZnBCrvC
 2vX3znd6f6Gu2eqTv4U8W6eFXQ1eemuOwIMtjzfpPw3BDU5k0scQ5D2MSgPfIx4GxxUCmKwaN3p
 Wfi2iW0N/a5AC1Up68oVgvPPceHMSJPqvwcPD/eMJUmMxxlDFccFSfBuidOV9g/ZMJ0RoPpNRBK
 cKBtYKtiy1+BL6/hUivL8TT7yyjRxtQ6o=
X-Received: by 2002:a05:7022:4c:b0:13a:b303:516a with SMTP id
 a92af1059eb24-13b36d7d9aamr1130620c88.15.1782901157454; 
 Wed, 01 Jul 2026 03:19:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/39] hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV
 appropriately
Date: Wed,  1 Jul 2026 20:17:36 +1000
Message-ID: <20260701101752.2522962-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122a.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're hardcoding 'true' to FQ_HDR_PV in riscv_iommu_report_fault().  Use
the 'pv' bool the caller provides that indicates if the process_id is
valid.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3556
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 9bf02084cc..c65e273dbb 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -580,7 +580,7 @@ static void riscv_iommu_report_fault(RISCVIOMMUState *s,
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
     ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
-    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
+    ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, pv);
 
     if (pv) {
         ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->process_id);
-- 
2.54.0


