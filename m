Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F90ED1D89E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kg-0001id-0S; Thu, 04 Dec 2025 04:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k9-0001C7-8C
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:21 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k6-0003S4-Q6
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64320b9bb4bso1448102a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840916; x=1765445716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IEAaSPzmzz5B3AM/apm91VbHSHgHQnwVHyZGTcUVH8=;
 b=OlPHENvKc0U09m5wD+TkZ+B9JdMfH7KSYzIhLa49u9UJPwO0i/yp/hhhpb8lESupHI
 qHtRoAThwwW5YQn2CzQ2J7nXQIzuQMrWSQchKjEgHA98Cc1NwyaBehThLzda8S9JZ1mp
 ixvMimXKPfUzXu2yGZFjqARP4Oit0YvuxrW+N2XlJRLmwjPbgYdfllQdXIKmzaBXsmy0
 56V/mn0fIRRbR87/pJ9skz0TLwL0SxPuuwJSFquikL1msRMmTtNOaBPc+Or5P6UQgYlx
 6wg0uPlHk61hh5NSGXB34k8o7GhZ/9hsXGhJsqokTGCimDPJRMmda8A/LjqH8qjMW9x2
 Nx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840916; x=1765445716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1IEAaSPzmzz5B3AM/apm91VbHSHgHQnwVHyZGTcUVH8=;
 b=Ighuao1Vlk1S+kWP+jmiUgkWTB8tIBd0zeVe3YdVpK21JsRBuXfDh6yxu5uAM96sQ5
 IC6Ptl0EdPh7sZVmmiFPKQhwUtazKa+2LuzepaEi7n7f6ENxKAt7Y9/rtBv92vscZeNp
 lDS7gkzQsiF3/c5r45S5mRatcLcAf1Yplk4FOBkupbxL1RmrXfqIrsj65cUgywSXbtZa
 CYhbiTDCOY85VuHD/z2vdtRgN2gC4hRCagwyzcioJU8OwQCoLfryUZxeuGXZXll+6ZQv
 GuK5GW5wNYA45q5x8F2bNSFSk3dlEsZxwNiCSEjjNKZ0YJ7bTtPQo090AkQ2K1HUPOUB
 D70Q==
X-Gm-Message-State: AOJu0YzI4Z2/lI1RdWwZ8EFjyMZef4/SqzvqhFf3wIscjAOsMWleedgT
 5UqtJfDt5GxuMEv9IfM8Y2dIuw2U8gwYfNB+g3ISjlI6HWGTvMcvJQZwCyOp6sdr
X-Gm-Gg: ASbGncvmqPnaepuimKO3otR6Wi4xhcOV/JK1lllxBdrB0I7o25Br+IsPm1bRUCGFJ8q
 S0hUs0PEiLV+IFogrCGeGHSxGYoNs/0uA1hWTe8Bll5RTi0/xD4VHoa/fd7QcdNCIpmNkJbp8O5
 RNIO6CgFm4J748YJKScyAjFxa5Jr7GkU4eiZyGAfRQsWSFYPv2vu6PSTLkRGvCX818VE9+jA74U
 ODaI9SoEuQcgrvlzSwE2tlUVHnCLroh9jsZYw/UqEhwfFT2po4UNTxufJvQRc/AhRWR+ZMEaden
 8S2c9G7LWBpjC8HNZe5d1tNeptmtcaS7FIbmE/gg/uUMgKixVTiThgPcGtt9rKgYdrAnQPFBXL1
 fFc69zpraIyGdUOmKlDfjcsaMN74G7IhqKlFpCIQfcHZ6/EeXRmftgfiY75nh18ggu6VpMAw2AR
 McoCpIf+2XsbZa9C8DpnzyMIrrgHbSdCbi6uEe/swvHQ==
X-Google-Smtp-Source: AGHT+IGvV+sCGJwOTFpGpCKdSMYu4U7c5oQUZ4Ip2HqD6FJoA3/JuJo/SVgHxJKIEhPAkKuNBJvIvw==
X-Received: by 2002:a05:6402:1ec5:b0:647:7bfb:6ce4 with SMTP id
 4fb4d7f45d1cf-647a69e6aa4mr2398833a12.1.1764840915995; 
 Thu, 04 Dec 2025 01:35:15 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:15 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v5 11/15] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Thu,  4 Dec 2025 10:34:58 +0100
Message-ID: <20251204093502.50582-12-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x533.google.com
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

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a5336d92ff..1df223ee81 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.47.3


