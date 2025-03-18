Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF201C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWkq-0003b0-PK; Tue, 18 Mar 2025 09:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjR-0002Q6-U5; Tue, 18 Mar 2025 09:11:52 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjI-0003rf-4S; Tue, 18 Mar 2025 09:11:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so9911224a12.0; 
 Tue, 18 Mar 2025 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303493; x=1742908293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLy6aE/EeuI5uid3VlN7jU07cW6eNahLR7Xv7H+Vk24=;
 b=FDzFZywHonNvFweKH/Fv/YuaLT1ujiZlttpSjAFtLf6hHc2QxgosbjYKimjUGl4wzf
 FH49JA5mCZkjR+3L4JRfG/uWU+1ehLdxVlgGH3me+8jKrYaD2Qoc0dE6nErFcwODuR49
 PCE91EkcUBXYdSq38RFPiZ4URd3TeYipo9h6i/1RvqPcBUL5plbM+B2/CBrA9N688cK+
 jKmu3HJ76017dbsSM04Uz4c5DWOLxmtq1MMrGHzOD9LpNFQMxleKN4buC65LMKjmSrJD
 uWyzhL1HOmDkaMHtNmHRjV9D4w4bzzjzZLNMdTrIe0uv2Z44j3z4JvQctsmKQAGRLU6C
 Zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303493; x=1742908293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLy6aE/EeuI5uid3VlN7jU07cW6eNahLR7Xv7H+Vk24=;
 b=Aoa4HI7gG/HZcb2SChgTJdwGE3lLOuLtMwMtbHM6WguaJVOtGFkqPdYfRFB/zdY1Of
 /umucnBA9HCB6mwpn0OtpTuRIBdlNRHN/ugzccRlHfQDxcQ5kwkvU0KKeNLUeOInMhD8
 rJwfHUF8gt2ZU0+Lwm0moS1/hNjAO9cJ+7yLy2OdqRdErny8Trh/UH+yaerY9LyaczhH
 3YK11VexfAZsb4DLMMX3YCyie5y7+W6sdkyjAggIfD2d5ELX8hNROn1uHXrPisTfnM4Y
 nV7j9ht4wCWSBefgMVIcBC3fi6mnvSNLZMNaDB3jgZQqbe4wfEoF5vJi/eZwovelNQu2
 7utg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLOb3R+d/pE8NzDRoUJSxe8SFJ38glJl0LkD3qx2bSWM0APJSJ6saNBLtmVNphMCYXVUDUMKX0xw==@nongnu.org
X-Gm-Message-State: AOJu0YyRJCfXKxOtRLi25XOcyjh2jZBK2iKRkuN+76371cbK+DKsB/br
 FZiQ1Y9IYTDKTSWTXcmNawGz7bF2wY0mw/tf0mxg/QFPWiF3qMoFZejrIU0w
X-Gm-Gg: ASbGncu7fn7Z1gEq1/O/j9gKwIBTyKv5edQIAQFDSaSp1rxQSSUP95KkEYgYbifrtUU
 d7eBhZrjwb/UGtHdfJaWGbP9C20c0aKlNETQqZRdEDD1jojfK2VIiZY86KiFjOKD0Vp8/ypL6wE
 qnLTwezcTEqjVUx4/0kOVcbMRZOrquac0KQQ8Jr5v7PoDtiMmX5Arb7C8eqAyx5xdW6drCZh++3
 JD9kesWgfbpzSlXOHpJCjigKgxyS7JfrP0XK1Czk79YFmlC4E4IyJlNNhT+Tahh5lp1fB/30YRN
 z3eMug2up/C9BjvjaXuUBBXnOwnprhnvE7413TzVz7fGghgDDkP21VNJ2oN8o5bUyX8=
X-Google-Smtp-Source: AGHT+IHihL/Cq7L9zV5OfwuOJhib7AxVnNMS6ebIe+UaM5k0LsmMuiZJaCfpgQKR2TAzlqzZ/1zlvQ==
X-Received: by 2002:a05:6402:3491:b0:5e6:102a:c30 with SMTP id
 4fb4d7f45d1cf-5eb1efcbee0mr3955471a12.2.1742303482100; 
 Tue, 18 Mar 2025 06:11:22 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:12 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 14/21] hw/arm/beckhoff_CX7200: Remove second GEM
Date: Tue, 18 Mar 2025 14:08:05 +0100
Message-ID: <20250318130817.119636-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x534.google.com
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

The CX7200 has one Gigabit Ethernet MAC connected to address
0xE000C000. The one connected to address 0xE000B000 can be
removed.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/beckhoff_CX7200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index bf3c66e5a4..3ceccaa9e6 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -317,7 +317,6 @@ static void beckhoff_cx7200_init(MachineState *machine)
     sysbus_create_varargs("cadence_ttc", 0xF8002000, pic[69 - IRQ_OFFSET],
                           pic[70 - IRQ_OFFSET], pic[71 - IRQ_OFFSET], NULL);
 
-    gem_init(0xE000B000, pic[54 - IRQ_OFFSET]);
     gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
 
     /*
-- 
2.49.0


