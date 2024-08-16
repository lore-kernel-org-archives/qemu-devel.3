Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D7C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezaR-0008KQ-Ka; Fri, 16 Aug 2024 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaQ-0008Dr-04
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaN-0007dy-Ha
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3718acbc87fso951724f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723824834; x=1724429634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjWmXs7UD5GkRyRxaGCKBrnzIsbM5XteQpuL4ObGWgY=;
 b=S6jsYj8gPgHJAzOPftR/QOtNunJIGW49g6/2mc6qL2U5WK7oE8LwW+upqiLDayKvIP
 uH+bw9R2kKjNNcWwQdR9JH8XK+Znrd1mkczN8WQ/1FovdawKfohdP4yZPEEcm2cYBv15
 0L7apPjT+GORivv6rtacSWNAECFcOW/jot6AW2I0pT8aUcPIHdvkBD8cUD3JiAlgandP
 Q9lGbt/d7x3+h7ffXPe1Vp4ZsMGL0ewRu/A4IZR0EVz8JqsEV3YV4n/OkvVL5pocssYF
 CqTOjkuatFs1i7YwFJAoEn2GKP3SW/uAI9New8eWRnEBPVSYBAvQ/aas7QbEXcWDJm2/
 vMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824834; x=1724429634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjWmXs7UD5GkRyRxaGCKBrnzIsbM5XteQpuL4ObGWgY=;
 b=CST640mg0elShZMx8qWgUCzKBL2DsycfRjLzh5d1Zvcd3EmpjHrMMhTFmg1hGXh43Q
 9vhdgBQar2v69bHgoP9FrbS5zCPusKUZtqQJk2OyxHdpoDqkn2WVCCQbZg6dIHAdzFVo
 Q0JuINJPilG529J3RuyRwGgrNIfJaZCBfGG+cJBuQRRT3qr+XwfiVvUNL+RzoAWQv2KU
 CpB1WPNqbZn+EfOAs7nqBbmf9VN2rFtrxBce7eTeFkXtvBvL7ytsT0FbW6qMJzF84K2s
 Ib1C4AbWoltxpB/bxi3urgU4f04AgJj1xIRcOvzb/8quu6GJFdOrTmemw1ZO5ggbzEnP
 FV4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7EFhkfMolVpPUEziFovez5ehTvMoryl57fZ6aVuLLStkvvYIwOyM63CMQ705hwUMmGPPoFI3OkK0UYT4qPZSMWrYK2pg=
X-Gm-Message-State: AOJu0YzdwDjazgpINZaUDBJKiNIsqhjpuLr5XFmWNXkc2ocIHiM4fI6X
 Cf/Rm7yp23vEO4IdldBYe9GIBWmiWupZsCFGy4UVTlMaAgwFWkceyhOxIGY4dbA=
X-Google-Smtp-Source: AGHT+IHZjYiYqPXIE4QIXylxyBfvl3Ig/Nz88BUzphg9g/iVb+79u4H1WJvVtQ/pYXyYN2fPUQAvxQ==
X-Received: by 2002:a05:6000:141:b0:371:8845:b850 with SMTP id
 ffacd0b85a97d-371946c2b36mr2406984f8f.54.1723824833988; 
 Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3912269f8f.115.2024.08.16.09.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 4/4] hw/arm/sbsa-ref: Use two-stage SMMU
Date: Fri, 16 Aug 2024 17:13:50 +0100
Message-Id: <20240816161350.3706332-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816161350.3706332-1-peter.maydell@linaro.org>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that our SMMU model supports enabling both stages of translation
at once, we can enable this in the sbsa-ref board.  Existing guest
code that only programs stage 1 and doesn't care about stage 2 should
continue to run with the same behaviour, but guests that do want to
do nested SMMU configurations can now do so.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ae37a923015..396abe9c1bd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -621,6 +621,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
 
     dev = qdev_new(TYPE_ARM_SMMUV3);
 
+    object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-- 
2.34.1


