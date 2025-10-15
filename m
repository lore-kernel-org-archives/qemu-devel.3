Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D039CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeK-0001vT-S0; Wed, 15 Oct 2025 05:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe9-0001qC-R7
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:14 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdo-0007FP-PT
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:13 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b41870fef44so491092266b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519870; x=1761124670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9r2NZ8qPeD/1NWJeAAk7/Qwh8XmZ+kDhkQXgsWKtWs=;
 b=bpWg9SE1rpJ/5b60Q5n6w6KuZYacUuPCZRgDbZXWdEF4BQg5MRPCw5eLGbp5jkqUSk
 hx8P9om/2udK5ZlgSSaAm1+NLXo/QdtMsxX0N2cgKpsY14DIiy+DjnIeOAReEezyg7Of
 PDwcpUc9FQCCLvpmTrzTpeNcdfliKFvhwtdUgXexdPeQ3IAxEoXP/Kidd4jTfh65Lpd0
 0gxIRG58iuL7+Bp16vixLZs4zjK+33WSifRfudl8Z4zh+x95i6Y4FEReTPpIZemsZhBJ
 dbItyn2G/D8NclrtQVnOeXDbv4p4StM/A1vhqExd+yrUPLTRmVe3sfdCRp321bpNQH7D
 KYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519870; x=1761124670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9r2NZ8qPeD/1NWJeAAk7/Qwh8XmZ+kDhkQXgsWKtWs=;
 b=fuUYPWYkj8p6eOBQX/Pgup3ErHNbXIItfIlyyv1ErzldMqUCu0Ifg5+1ceA94BgoQ9
 oQfciqa31ArHaWrhiB9VOmNh/cDaAQpYnOFWO0sTTF5vh8IQIw7rnEKSVT4tY7cPxHTr
 AB+4HB44jT0VmsdV3EnWLVVfPmxgWhmy9PxiUdCbaff3lGNH7BEkcedSR+P1I6wcIr9B
 AF16/w3j7KSaQ0N+8Y+iLTFE2mbBtaFPggTjGgA72QHJ+4sZVoqzzFhdKSzJ4vMhqo1e
 iabIUJFcdr3gmSdVn+lwrtm46KfiRXc/MLF7WTsQnQs9ogCSn1MweCneJ4CTEe4saZKG
 igDw==
X-Gm-Message-State: AOJu0YyeBhwBn5nO1k3B9M+pdV4icAvWEZi01QvVPlsYH/aOrtBPn8yT
 NAI3eJKHotsDPVKJgSwzAIIkv0s6jBK+c//pFALPOUaS0xFmQDfe4AWe7Mf4DHA06mA=
X-Gm-Gg: ASbGncsJwN/n7RDXnmm3MU5LYyRa2E4AwIFK1Ad5Cc7RnBOPmCJGRQkNj0+BqREhWNY
 Q+4MJYlNBJI6vVo8VmyqcApGrfQj473QVWI850DcnLj9AG69QmC9C6H0XAesYNVRBWLKMRraigP
 CMO7uSEiZ1QNEXI1aIuVMGDV7MpSrjbmmmXM+izb6ZrBbHz1szSPlg2TemT5zA8ZXq+lJKQsQ4V
 msAykiGoWcDkK+gse29xJBRhi5LRsH6uWFe34Fo3morMM6i6TsZKnhneabaXSgLpNrZyEPTSbe5
 QE9fXvamUZJHt/MVU0qG+tlSTy0aR7Vi7Sq9tMMECY9emOVqs77IlT6NFZ/d4q9U+7I51wT2rNz
 QCxjoqj0QSaBefadoG3r9Hgw3nbfX7FSasEG2MyyvWVd5t8hKMqOdGTNHD0MFiw==
X-Google-Smtp-Source: AGHT+IGZh5/mdhSQessTGCP8Brm9F1tMGNXfVXYfWSJZJ+/jqqaS/yvYCFPoRFiU289eD2HfIXylBg==
X-Received: by 2002:a17:907:94c6:b0:b45:913d:f523 with SMTP id
 a640c23a62f3a-b50aa99edc9mr3097372766b.18.1760519869630; 
 Wed, 15 Oct 2025 02:17:49 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:49 -0700 (PDT)
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
Subject: [PATCH v3 08/14] hw/dma/zynq-devcfg: Fix register memory
Date: Wed, 15 Oct 2025 11:17:23 +0200
Message-ID: <20251015091729.33761-9-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x634.google.com
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

Registers are always 32 bit aligned. R_MAX is not the maximum
register address, it is the maximum register number. The memory
size can be determined by 4 * R_MAX.

Currently every register with an offset bigger than 0x40 will be
ignored, because the memory size is set wrong. This effects the
MCTRL register and makes it useless. This commit restores the
correct behaviour.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 3df80a279b..bd8057caa9 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -393,7 +393,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
                               s->regs_info, s->regs,
                               &xlnx_zynq_devcfg_reg_ops,
                               XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
-                              XLNX_ZYNQ_DEVCFG_R_MAX);
+                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
     memory_region_add_subregion(&s->iomem,
                                 A_CTRL,
                                 &reg_array->mem);
-- 
2.47.3


