Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D503EE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB6k-0005gr-G5; Fri, 13 Dec 2024 14:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6i-0005XN-PA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:48 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6h-0007Sj-3z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:13:48 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2a01707db44so650420fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117224; x=1734722024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mACfDBbl1zp2rBr4xmrT6K6hg/pPK23y61jj5zZUfg=;
 b=XynybG96KeT2sSBCym8ibYLPyLKT+Lf/l2IFNsS2ymEQPzRh3X0tZlVoOKbZ2iAGmR
 c6f8nEE1qhgjSoXY9o+aZsW0WuEhCtxER2soDx45+iJsDb0RhSU00LoO6oIHKuQD9stt
 Vkt6s0s20lwLM7Dh2RXIe2d819muw7k1rdtdqbOLc00GsyAoUnRPUxyxWiEmFvhrzrzZ
 n5k3zEBZ61H/w/EJfbSmzNqXhm2TFJzD/QgpBW3TpQgtT51wXVei5uH0WSfH71IaHU1S
 cD5wF24r/jE9tzxHwg012g3P02s82ONlgxTMzMU6W24NgWlocCIYqAQmaqF94QTno96R
 vX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117224; x=1734722024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mACfDBbl1zp2rBr4xmrT6K6hg/pPK23y61jj5zZUfg=;
 b=BSOUqKYmZ4nfOyUHm6d/o9lM5GQWKD7Me5apr5o8MpUHziq/G7rh8O5VC0UxuR1JiC
 mLW4Ux8oBQ6Iea1dOLCEugt51KSRfNwqRVdmla8JDk7773JdgdVSe9nekesBU3Gu3QQv
 O6ZycIQjNXvhXOKzkMkjIT4QIAIX5PsCA6cV17ISvdN6Fp4xN/hZYn+HIo49PykaIf/m
 DkRDlJXWQwkW4aIBhtpm0RwfcYKzPJ+BNUORAE+WqHmK1cOaa1c28Y/KNB1LZDisWe1k
 LyYnW6ER029+m2xVQYy6OQWB31WcFbOGvozG8LDg++5cFhl21FjeKJScTkJ1otqntCCZ
 qAPQ==
X-Gm-Message-State: AOJu0YzhBFp9fwHtf4H7TceSr8yRtqo18KFS2AUWPPOZnxqTpxxYDTSc
 4ax8AgHQhkjL1hv62n7OkFo5bfnwgR1mdQikVzaZk2vG6TugUXDtUkzq11eHjneLzNnjq93mVpm
 NzNP3ZplM
X-Gm-Gg: ASbGncsfDpDFVV57JJInKQWOxJ61kUP53ET0wK/A5uUlOtYbTVp+Ly03t233PJgNZBf
 FEakzi168w8Wzeo02KO6OROcTBPZDr7RGCpOxpv/9bd3rrwLR4rNCoxAvzlq/66epQCq2aHfdds
 EnyW+7P6GIFOtma3Wt32Q4HqfyND3siniKHOC94vT9SnLOdcinHq5eBDbd3O0uweBd9lE5VYrRM
 zj+PzPomyv12YWfCv+V2+WSb8UcvkOHBOnfsz8UU6VO/+0ayWzfPMVcFmR/juRi
X-Google-Smtp-Source: AGHT+IEmuiFWl1I1MYWJAgAOZexB/d8jUengi7ZrtuwOBe3P5Elu+6t0mlPCwF3o1pnhMCYhX28Dng==
X-Received: by 2002:a05:6808:f88:b0:3eb:5160:f859 with SMTP id
 5614622812f47-3eba681d8f8mr2365306b6e.9.1734117224684; 
 Fri, 13 Dec 2024 11:13:44 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 38/71] hw/mips: Constify all Property
Date: Fri, 13 Dec 2024 13:07:12 -0600
Message-ID: <20241213190750.2513964-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 13046628cd..1a2208666c 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -166,7 +166,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
 }
 
-static Property mips_cps_properties[] = {
+static const Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
-- 
2.43.0


