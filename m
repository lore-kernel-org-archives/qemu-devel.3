Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6925AC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmbe-0002qU-Nu; Mon, 08 Apr 2024 06:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmbU-0002px-4a
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:51:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmbS-0007qf-E3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:51:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-345e1c645c4so251467f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712573512; x=1713178312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q6iDyrflcxwblwLi3mNQ+oLA1gIyXdTAF2mwb6QdSME=;
 b=D0u2tDubPSvq/qOvu2pEOJpXxLWxwXEcAZ9K6YJAIP+XoUNN32AvqlW5eSp5O8xn/x
 HC9UIhLZF1uxX3xl/WrloFYS1nPuzX77vmXB/aWfc9UWZTXp8xdsc5YiNRPLGAPdSQIl
 Fy2bezi+t1+Du9ZsJPfth4KFlHyTTjdNghBdn4Bm5zUA54e3eMbu9SLLRBhYL5wgP7TT
 WCaCzwK2KBV5cN/huC9JDxE/BLwius81H4mBxfNox3spessYV/HQJWKCGl0bJaqgfHh3
 2uWnIaIWypHPNNprzH016lYoF72/xMBr4DNPwOr3kjOSnBtDOzlR7WxeF4TdPG+wD1HL
 H2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712573512; x=1713178312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q6iDyrflcxwblwLi3mNQ+oLA1gIyXdTAF2mwb6QdSME=;
 b=vg0wGcBK/4MZaA+q0gjyKblQYwwJvdGdaHmTyOqFi2GfmoKnSerAG4YfumpbZhb//7
 Bv5wXR4OVMV6wrOp33yf2TP4itpVAqOtcINBH356PittBdsAx/12PEbszUStmxgvZDK+
 qeGwBKr7rJP4Pt51cam8AHUAPUe3cYwGLbHu2VTtbYxkv8rbWAo5eMIn1ho4+cHd0Cw/
 CQabE+mPGYZ2F0dLC7GuvZzDIug/9+E/xtKcmJ0Sa67VG9d6hxWTC1PJdM0NCOBPDqZs
 cNJsQ594Vhl8UDPKSRWA3FRgZesGb7TPPaTZIGbNOxdqzvsEw1kPgNT/+hCaTv2CFnVE
 Q+rw==
X-Gm-Message-State: AOJu0YwkXTyQv9J82ph7pQ2w264np/6vUDCtZeIltuUPX38GlhlBhdRr
 DMERO6K0Ej3skjt5DILrQHInjhzbnxhXLkZkEc4MIdy+I9C0CR2XtVjZ9E3Ofp0Xu9DrdymhZNs
 1
X-Google-Smtp-Source: AGHT+IFPgkmH59qANmwHRzSMLzTxgxlRdPVLCY37tCHpvwQMnR74QdUAGzszNld1CkqHtV7T9u/VHg==
X-Received: by 2002:adf:f202:0:b0:343:b686:89a0 with SMTP id
 p2-20020adff202000000b00343b68689a0mr5964213wro.13.1712573512591; 
 Mon, 08 Apr 2024 03:51:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adff282000000b0033e9d9f891csm8665568wro.58.2024.04.08.03.51.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 03:51:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org, Chuhong Yuan <hslester96@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 0/2] hw/net/lan9118: Fix overflow in TX FIFO
Date: Mon,  8 Apr 2024 12:51:47 +0200
Message-ID: <20240408105149.59258-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Fix for https://gitlab.com/qemu-project/qemu/-/issues/2267

Philippe Mathieu-Daudé (2):
  hw/net/lan9118: Replace magic '2048' value by 'PKT_SIZE' definition
  hw/net/lan9118: Fix overflow in TX FIFO

 hw/net/lan9118.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.41.0


