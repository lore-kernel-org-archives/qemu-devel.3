Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F5CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWG0-00045t-Eb; Thu, 28 May 2026 04:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSWFv-00045a-OI
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:38:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSWFu-0004lx-4b
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:38:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so83141375e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779957496; x=1780562296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X1tiSGh83808gb/CV6tNRSwoS8PAqMGkvTgjlCBstIo=;
 b=otny2XZTkeXLtipSDblwap6jar6Adu036MNJdYY1um+iurIhM2Ln2SXljCnZ+fcptl
 BbdbHCUZXzqh5o8AhP/uHxuqPdP3S8Rxrs/hzItzEK6ciTG/FWRSgkoBg66/SOmMQipf
 agneCVvm8akeJ3aJgbEdpKqUGJhAsoMuB/qQ5NEaTH6NSpGER27V1PMmlaRPx8f6KBG9
 M8gbMYBuu4obNMdOs1n0YHFD4hxsAUoWESs8ms+3n6ANSKF6Y+xmariGOAAI/WMPAZ7V
 BSooHyKW6UT7Aff0ZXYYVU2p5UQiv+Gc+luK15KoFLwbgEXduuTSpn9mR/IQ9kzhLb0F
 fP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779957496; x=1780562296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1tiSGh83808gb/CV6tNRSwoS8PAqMGkvTgjlCBstIo=;
 b=THzjMAUwU2y1i13sXv6Bm48JtIOFPW8M5GkKmB0jho45McQaJNOxXX4nB2bzyPSEKi
 QVI7r4Ua0+ErfC7ktp+bEO/qvCWk0eGbHdukFlY7HCAcQaCBGcoya2Oz7wXhYmvBjgSZ
 +QSGLIRT9XugOPn6M4h0etGZ4y2R7QBYxgYhGZ+4ahuAIxBjXmDa8tdQ3bhATToxvBXA
 1TvAOCNNaesZiikDcaJ9lE5fZvwCu5294L3WOhjqD3adZU1B65Un0Ka57NxDCRoDzSNh
 Y8pALRyqXeIgRHAeGBG/t20+HLtpuW2IEhgs6BHbJQaq+Iab6ZMUKNXLUNVM1t0+QggR
 Ehig==
X-Gm-Message-State: AOJu0YyP8JvfnvWneT7bp5VHHebnJm3tdyXIxBzLlNjrPxGOirpVPNkQ
 Ppn8NVkGljcnjwa6BPHyZHOSbJmUXtx4FNTsbEyVZjbr/bRKOwO3xGLv9xCaEWIoOKinJ3XIiMK
 edV6hPEgFjQ==
X-Gm-Gg: Acq92OFtcXbHxmyqhu+h1tSlqBmxOVIczNWn/oh2gjFoh9wRllsuKl7L5ybzvPXIFBN
 oqLE2PqSpyQz+N5ivcBWoSpTUqVEiwnMJOJMQFiBpvIL+YHfJh8pUKTmT27AobVcDnycsQbIwF3
 Z4Z15IIdYbjTRxm6qVFx4CY+7ZhQbv1pGR9Q/htrnGcEk+ycAQzyG5w3cugMW3mNKrZc47IUSgP
 x+V7Vcy8L9qzTnb1mUFkPCSz1ru4PCUsdGJCvChKvnn9P1LiXQ7yBxODuGOtUoYP2E9BSitY6dG
 P9fHGclrbKOzIe3t03C7vIFVWYTuf2gH2K0XIKwTS95tkWQBQE03QCJdcBbZqf4eU4QD8ZlScb0
 RnpND1x84i3RhdKFdRTV329Ra71B1+P/kNWVSJXDGPdh3WB4cj74MitegNBDs9IWKc46sQCqzSF
 S15f8oTa7Uihz7wyeP/2NQ2gl/12Cd/fA96522Wb0FF01nPyTXAf6Z38e7nb4YBqEwvg==
X-Received: by 2002:a05:600c:8214:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-490947855eamr11036045e9.1.1779957496029; 
 Thu, 28 May 2026 01:38:16 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb549e79sm12933413f8f.7.2026.05.28.01.38.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 01:38:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] mailmap: Update email addresses for Daniel Henrique Barboza
Date: Thu, 28 May 2026 10:38:14 +0200
Message-ID: <20260528083814.32795-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I suppose your gmail one could also go
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 273661c758e..6335fbd6c84 100644
--- a/.mailmap
+++ b/.mailmap
@@ -82,6 +82,8 @@ Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
+Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <dbarboza@ventanamicro.com>
+Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <danielhb@linux.vnet.ibm.com>
 David Hildenbrand <david@kernel.org> <david@redhat.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <fred.konrad@greensocs.com>
-- 
2.53.0


