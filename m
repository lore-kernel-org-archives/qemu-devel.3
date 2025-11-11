Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95152CD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlci-0008PN-DR; Tue, 11 Nov 2025 05:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcP-0007nm-7i
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:57 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcH-0000Gj-MU
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so478575566b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856922; x=1763461722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nebiko2e8E9Ki2NoxKJO7wXXHO0pfIKqcEM3oGXROYo=;
 b=Eadv8SLSij+fi9Ydz89OfcFG3F2xs6BZGIdVDByxhaLSCLozPWulg5aOvXQLFervIU
 8B/ZDrsk+66AHureK5PmOV/LYCtOrxnVw0DqDH15DHrNfuxb0ju2OUpJZ59ax81nsKqv
 q1BSESmuPSrgsK8alyr4Mj/LjYvB3ir+EoYDKcsoY+eg2uBM8ALoxMzgR+LcixTkieQn
 iwS1gwlkrHjeS17Ay9+O9j3M0vEXpuZe4/XQ7InQglImFdgahnkOinnMckYV+NCbPY64
 1Z298gve3pX8OhmmgwPnb51odGlxYmx2gRIr4Md24MYzD6xwcELR4cWJ+foY1zrXRi3T
 AvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856922; x=1763461722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nebiko2e8E9Ki2NoxKJO7wXXHO0pfIKqcEM3oGXROYo=;
 b=i8cY5tJchqZUVkMvruOxBiTe9ib/yu1fzv5rRcRJepqwnpTd6QEDbDS0iXHYr7TWet
 uMAINAaXxfK+1XI3wAaiAVgTUpBdmC97x0yZ8SkoF25jCSwsk7WPsLbyc/r8QJGd6hHJ
 aLDN1UFoK+lPo5rCVoZIj5brey1ZLSPHZ/fKpGa/WuBxXJDqqaf82Y4xsIoYSsEcZej0
 HcCZE/1OlO3uh5iRYCmsVYnoxqQXIkrneHoZpuAqHLJHRujFden5+uNHSkdWxrh4WryP
 Qa9ibnofIe1DAPnzIrGQCgDuwatAu9kCFosdli79B28EoFmnpp+XclE6b9PSitb1AKtX
 TRyg==
X-Gm-Message-State: AOJu0Yz1RJZkQfI1BH0XVCpBVap5lIYIiiEad/XGldpUwiMSXlG3Cln5
 TX8mmIOD/tuOZtZrME4R4XIzyJ2yehXo9UycUVdY8JiZPeAjH3TiJYZtJMZOAymd
X-Gm-Gg: ASbGncuHPfnJCD6D7VrhvWKokyoe9DiTlIlGIPmRNPIDce++T9dfVzJVklkIvk0bPiu
 5HGxgBiQXKBASfmJm+8HgvKwAw2uffQPYuA8P/zFJHqREY+X9oFatnV0Vn0PZ444x7iiBcmA32C
 1AXf10IAXy1VmJibQbnxndQCjbyK86ffdOC2JgGqznunJl0biRzaRsi/MWSGs3au+8Eym20T5qh
 fvzPOkgtU6EaQlwvSkfKWW8RwByS4mk26D9PdmRmTKPujU1FbrVsLLridQYEYzdyxtbYoqKeEwI
 2OndtwGZZYvauUxYEowkpKDEraY9Ykma5vWxfYFUEUIErbL9QrG8DcgKTQ0xvsVfRAX2NhxJSFR
 XDSE3W6i/PPQAz6ImBw/I9RubSrTWYfYw1bol6McT6PiRqjnDUoCJchSu6Ehzg8Y+ZsdKQ5NLTy
 32nYQNrtLNgXTMfdVt85antA==
X-Google-Smtp-Source: AGHT+IFpcOXmVrH5pW+O83+G34A/vN9m3eynA7yS82zpn4vnxG0brScbTKkne7F1vs6WFs5u56UY7g==
X-Received: by 2002:a17:907:96a6:b0:b4e:d6e3:1670 with SMTP id
 a640c23a62f3a-b72e028c900mr906068466b.11.1762856922464; 
 Tue, 11 Nov 2025 02:28:42 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:42 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 05/15] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Tue, 11 Nov 2025 11:28:26 +0100
Message-ID: <20251111102836.212535-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index f28d0015e6..28b3cd2902 100644
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


