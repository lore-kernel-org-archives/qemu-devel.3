Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA9CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlfs-0004Nh-S1; Mon, 08 Apr 2024 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlfr-0004Lv-Jb
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:23 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtlfp-0006Lv-WE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:23 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so258600a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712569940; x=1713174740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xHsQHwdWozGmYntZG1DsswfJcaBGZtgyE5FZtk7H5pU=;
 b=ZGc+9F/ZL3nqiezZ9N8ajsy5j6RMcyGKE1vvwqTVWQEZdYTeaTVyjI4Kve9m5gEUDa
 og9ByjPxQXj2WHV2H03KZ+YoD2385ttCNygWBtprrHFmskeV+2+4yX5g1o/ftVfe633O
 C9XOEqGYpAoE3zgRjHKt/n360lMJGJtGiN8To4i2I2UyJLvY+D1weGZ8YDZnpzN9RZNN
 2By1ghyHxz8cnOaRpawjPCaOST0BsyBs84614ukZD8A5Y1ha43k3eE0LmnkvB8pZYeGd
 cnxQjpgDMOGopil6e33DHoB80JEbq5rOh+LZPZ11rWBw7+WbL4010ARTsqtnQBn0dHRi
 QJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569940; x=1713174740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHsQHwdWozGmYntZG1DsswfJcaBGZtgyE5FZtk7H5pU=;
 b=mwZ+l3D18+S0YIvMmQj04tlXzPBjDBdqXOgWXbMjoH6V/XSTvzAST2Kphk/MBLU9Vf
 fYldIHLIgspqS+JB68Xih068Noq/nZczM2AfAoAxpqZ7Nbx2Ac+ElITaHb8xBpYwjvrA
 Ig+UVwPKUI/ZqbgXRMafnG1YzVbi2zs31izvusLKFADmcPKG+Wadwc7Wf/UPUiieODgQ
 oaKpL+hKIbl+fi7pTmZvCBRv2jDBzN/bxRApG2Fj3N6JkhP9Hbjrxg+EddmBtadnc4fq
 Gw+fnnE2s8EjQGhrv8tv6VuGjszXWlXz0Xpk1LSRCByZFW36vk7LNMXP+uebLA11p7VX
 DqMQ==
X-Gm-Message-State: AOJu0YwxmIlwsHIx5oyo4W1PM+bG9h2D1BBuwt5S/BuOdXH8G6Bs+wgU
 GGw3ZWzYiECOYoFXyG44JfFDhPQlBmufQJ52tlhWC5cCSdbGT+PCNAj6bw9iIkNf0AyBwnvGqg3
 t
X-Google-Smtp-Source: AGHT+IEzyUYx3Z2hPfoetwIjrRn8Fw5GwLF4BI+LPsiVao8Cnun6MxDL1DxzELYMGZIfHa+zXYYi4Q==
X-Received: by 2002:a17:906:4704:b0:a4e:2bd3:a060 with SMTP id
 y4-20020a170906470400b00a4e2bd3a060mr5534297ejq.64.1712569939665; 
 Mon, 08 Apr 2024 02:52:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a170906a08e00b00a4e8353be19sm4244235ejy.224.2024.04.08.02.52.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 02:52:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 0/2] hw/misc/applesmc: Fix memory leak
Date: Mon,  8 Apr 2024 11:52:14 +0200
Message-ID: <20240408095217.57239-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Fix for https://gitlab.com/qemu-project/qemu/-/issues/2272

Philippe Mathieu-Daudé (2):
  hw/misc/applesmc: Do not call DeviceReset() from DeviceRealize()
  hw/misc/applesmc: Fix memory leak in reset() handler

 hw/misc/applesmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


