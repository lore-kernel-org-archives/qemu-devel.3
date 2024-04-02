Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEE1CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP5-0008LV-3d; Tue, 02 Apr 2024 06:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP3-0008Kc-8h
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003fw-GQ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:04 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d52e65d4a8so69636871fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053796; x=1712658596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3T/JxAKeGpx7vAttG4gUgA6VW1jV4RfEeZ0Alec6FS8=;
 b=xnTQhwaso9lY6fMPW0y/rTjCV6wR/JJyIMyB0+UwBndffM6l7fT0cGzF8w8pZJgwFj
 YRiVysbNVfFwC6Ed78mSpL2I/7NBczJNRyaKIAtPrug6BuwCV7c0jJG3yImH0eAQX+Aw
 avOlvj8cggumMZUiAElhcsJguAdCcoO3AivVH/KhtWKFhrYJQCzpP5CzOEeWKv+F9vsd
 GRCyD1nQLc61oJRH0w3aD9GiTvZFBxXOMsG8eoOIP6zuV6SbILGKFR0fQNfcYMvG1LDA
 Cqr1pyq3vQ7tf8aRRXHGoE5D3RGAuQ8TfUcpOXlH0X6mrur9KJ38Hlc84HuUjDvKlUxZ
 aqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053796; x=1712658596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3T/JxAKeGpx7vAttG4gUgA6VW1jV4RfEeZ0Alec6FS8=;
 b=SU859G+xB/B55rj+3w88hqzJwD9lUNgMbXqPHzLQQXrvUsAzK2RwQCG/hGchKNV+k8
 DwqSXydNZp7s/J4obVVkCYM+QcFyH6m6J+k6jnR5hluiM8w+LZTJryT6ZHj56nrcDjXd
 zmwxuQYA7/ljGcRA0tKM1PGIvHpR5Wd/PGYn9U0Q5h6eo3eE/qD7Pbzjmfo97vdStdEg
 JgJmlkFykC4+hQKLm2tRKBHFZexo4Cb+y1u4c9hzE759QSTJWf/xExdO7EIE/MSFndrB
 r59mzq8+1F/nbxjTdFA3U2UccsmrnuQT/0JXgmDvV6n2dxTDXnobLlnzW4T4VCyas3ZX
 UT2w==
X-Gm-Message-State: AOJu0YxXpds3CvlxAB5h21WlgYz5o3+zvI285n2ouwgRZ/DwihsrXdOw
 4UuNZRNTkMZV9cKf+SP3mWtqDcQ768BffpgL3yvgPSYTw4naiDrvFH+oa0vfc3YeAVa3+aOUwqx
 f
X-Google-Smtp-Source: AGHT+IGz/PLw9RUcfbsYHkDq9hTYtOr+isn7UeTFiNaddyfTcWLfytgyu3nVyfzD3u2vpzzUf96kFA==
X-Received: by 2002:a2e:b705:0:b0:2d6:ef1e:90f8 with SMTP id
 j5-20020a2eb705000000b002d6ef1e90f8mr7317956ljo.49.1712053795894; 
 Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] raspi4b: Reduce RAM to 1Gb on 32-bit hosts
Date: Tue,  2 Apr 2024 11:29:51 +0100
Message-Id: <20240402102951.3099078-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Change the board revision number and RAM size to 1Gb on 32-bit hosts.
On these systems, RAM has a 2047 MB limit and this breaks the tests.

Fixes: 7785e8ea2204 ("hw/arm: Introduce Raspberry PI 4 machine")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20240329150155.357043-1-clg@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi4b.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index cb1b1f2f147..85877880fc7 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -112,7 +112,11 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
+#if HOST_LONG_BITS == 32
+    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
+#else
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
+#endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
     mc->init = raspi4b_machine_init;
 }
-- 
2.34.1


