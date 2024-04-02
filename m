Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3046BCD128D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf5v-000350-G8; Tue, 02 Apr 2024 10:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf5a-0002HN-GC
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:26:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf5L-0000KV-AZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:26:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso3778903f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067954; x=1712672754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdHptW6/vmFiZMZ88dmnQIm/hdJiCEdE6JKu99L0Ilk=;
 b=HufWAAgk8e40SvOjg0tlNYJouxNf/WRJIsa/JTaf7qt1POY5ahqP+yxAKBbfd7wK/c
 N1XBjAJh2CdA32lcFd6QrR5TZiPFk/veOVV9Ff8hQmpEr7jO2TM7briplrmGo7In2R+j
 SOncngXqQltxGwHOTkceeVLdSJaJxZ4fJVfPQRhw5FY9S9+Uy4/qOhQZUoSJE/co9MND
 e51mCiL6I0P2o7PVbJqf3zC7FOhhwotULmpD8T0U61/OasfHFYZLsE7m8Q0joQZeBz+c
 XcZLrq6aZUhF+uCyoLoDLWbAHsIluooP1WxS5P/weF3s1nEom0MwP/3q9vyTzVveUNob
 /9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067954; x=1712672754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdHptW6/vmFiZMZ88dmnQIm/hdJiCEdE6JKu99L0Ilk=;
 b=aJcNr8E/H91KmEk9tplF2ow9FQ0R/1uEfBRXMEWcZO2QMIb5/cngCUftapHE4rE29D
 p6tQuQ8vtFijvSj8rVjn+ofGV3dX4KhEHQi7BTdKxldJLG9VVYcXBo39B5dp32ifCtVi
 n/+OBQ0hs0Pxrqo1m2h6Po7BMTKr99cXSsI9pnLdpvcYzhH/Tz2DaO8gaAcRHmwt5uju
 imq4oOpuKuc42yI6Vq8LV5Roq5JArq7S7vN3KLVcbBFo6AJ0tFjIPHMOiXhqmgReEJ5F
 EN64+HLRhqAygYI0HbtA0/J0ZZnpExZGXaLEAybs1LrzOMV0tC1H22LRjChUX/kH/e88
 B1vQ==
X-Gm-Message-State: AOJu0Yx60YbPPi77obqJ0M9IxjkK1V3C7WR4xnt7/IrSIdjuwVZT4jCn
 8LBIZ+To1MBj4ue0XjHQMXZk/3GTjBjwh2BaC2067WSMPhCNzQs0cNqh6G9/RX0y7WAxEhUFQur
 LzjA=
X-Google-Smtp-Source: AGHT+IFiVGIz6hUw63J+oL2x0lH56xk6vCoRVjjs++gnHuYH9IqZW9qRKSwmwiEaIaW8+7hUAoQS0Q==
X-Received: by 2002:a5d:6451:0:b0:33d:2775:1e63 with SMTP id
 d17-20020a5d6451000000b0033d27751e63mr8411023wrw.41.1712067954632; 
 Tue, 02 Apr 2024 07:25:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a7bc2a9000000b0041552dbc539sm13501997wmk.11.2024.04.02.07.25.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Subject: [PULL 12/15] hw/nvme: fix -Werror=maybe-uninitialized
Date: Tue,  2 Apr 2024 16:24:27 +0200
Message-ID: <20240402142431.70700-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../hw/nvme/ctrl.c:6081:21: error: ‘result’ may be used uninitialized [-Werror=maybe-uninitialized]

It's not obvious that 'result' is set in all code paths. When &result is
a returned argument, it's even less clear.

Looking at various assignments, 0 seems to be a suitable default value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Message-ID: <20240328102052.3499331-18-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c2b17de987..127c3d2383 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5894,7 +5894,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
     uint32_t nsid = le32_to_cpu(cmd->nsid);
-    uint32_t result;
+    uint32_t result = 0;
     uint8_t fid = NVME_GETSETFEAT_FID(dw10);
     NvmeGetFeatureSelect sel = NVME_GETFEAT_SELECT(dw10);
     uint16_t iv;
-- 
2.41.0


