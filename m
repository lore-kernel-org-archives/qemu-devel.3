Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A150ECCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeI-0001t9-Ce; Wed, 15 Oct 2025 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe8-0001q3-Qn
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdm-0007D2-CC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso14182218a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519866; x=1761124666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSujfC2+BtnBsUbXy51XTtLY9h2/Ra17MGX020tEjTU=;
 b=TwRNv9fO6/f5niwkuf9/M8zKTU9Mokv0oRY4HGooRcqC0cDLFZO8M5WUuHby++Yb2j
 D/AmpkHOFwYvsyFJ87F2RmPIfY+f4aGwMHFITd2kl+rXm6o0tKA3OxhP3CJrkdKBIEFq
 cTEd7XnKLCQRmqVxJ3ckQ3r2zWNkR+gAfzg0nTz8ozzwf9BdGCCgwmlleLagvXiF9tbx
 9GFqyhKMKA4yFB82QD9tuGjb+F4eMBAGQTWBGqdaYz4p+V6YP0aVGyfhTzj5GcbZ0a8A
 ys6Q4m5qGeheh/UyH2bqjsOOWMJuJJbIeRXtP+YZxDWpQ7Ss+xHsJGEmdqZYK1eU1G40
 oW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519866; x=1761124666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSujfC2+BtnBsUbXy51XTtLY9h2/Ra17MGX020tEjTU=;
 b=f4BEjZ9FKPlBZf7rsSQqtLKIOZS3NEBDIMY6dWgIaUcPbYIwpbuxp0zWPW7KbSukMK
 OMDCMG/i1ZFkzc5WJNPR3HSOaCml4RFbyI4xvkzObxJeykpqQKoALbxlUX15EPrORkGe
 2V1BRIoPAk7v2S+EvpBnFwf4+M1ugIj0o/f/BS3gFxkdLyCcooLjJRwJ8y6qEPm6uikj
 WDkFIpS83Z1+mql+TFqUE86uQy6nUcmyHe6cwho7Ablqa96beHoypifoJX/s0Wq3K22g
 hs3DrNPYIswS/W9MGv72Uu/bcvZQdJ5oKr+TqlsamvcZRGMNrkVqU27sE/bhxz2rpits
 5aPQ==
X-Gm-Message-State: AOJu0YxbFlHqoTp4ArwGPikocg4LjX8U30yuzO/9G4wc6uwMV7b4S92L
 ZlR1ioy2HlTRrVsaa3bgRlKzljKAlWysW1jk0Qw+XRnPmAfGR/8Vd6A8mF56XszuUUU=
X-Gm-Gg: ASbGncv3YjKkUsACKMi3Z+hnv5pLSiSKWC1OygSHVV5QvX36RG3UR+h5ckgLoQG+Tvf
 LLS5pcMZul2Hdb+z3WCMl+cyTKPTSJU62C0/aiCPDVU58bpU3tjDVQgRtrZMHbXfyIfBKf75Ld8
 lakI8X76cLQ36cf4jhbJwsHtDGM5Hu4sBg01kDxwHCVR96hWWEjEnQz7mkoWn3szWZFUgaOdGqD
 V2/ABMfIrJmPEJB35q40yUVNSe59dN7ewYLkpB/BQEVJvd0QIuGlYhqSsb+V/UZORajZe+HEp6A
 Vuw/L02618EismxCzNGwcylJPiBlsak8mrbT+jGNLeGO79i+RcOhPfRCQa/j0bWgvmUDxBM770x
 LLgIdXSnMfnedGhMDi70ZkDej3ITy7I3hyQn5Qia2Y/VlCUKcMQocim2P0sFhkB5v5D5MvX9v
X-Google-Smtp-Source: AGHT+IG6XOp9huMJrW8Ci+fIIdS/2oTxIMTa3EW7f0U+yWhb3bjs9b1M+QT57cDof0el3mCm6j0RBw==
X-Received: by 2002:a17:906:ee85:b0:b3c:200b:4364 with SMTP id
 a640c23a62f3a-b50aae9839emr3060671266b.27.1760519866201; 
 Wed, 15 Oct 2025 02:17:46 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:45 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 05/14] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Wed, 15 Oct 2025 11:17:20 +0200
Message-ID: <20251015091729.33761-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

All register bits are clear on write by writing 1s to those bits, however
the register bits will only be cleared if the condition that sets the
interrupt flag is no longer true. Since we can assume that programming
is always done, the `PCFG_DONE` flag is always set to 1, so it will not
never be cleared.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 72d73e93c7..c875acd4ac 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
 
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+
     xlnx_zynq_devcfg_update_ixr(s);
 }
 
-- 
2.47.3


