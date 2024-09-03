Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE7CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZlu-0001Lb-OV; Tue, 03 Sep 2024 16:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZlp-00010U-Bi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:04:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slZlj-0003NY-9G
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:04:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so36976235e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725393889; x=1725998689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OY76Qt8T9LK/vUD7hekByl1wPB2B9FXxv8XnTxxgVPw=;
 b=B/ZOxTpuh2krsFR1iyl2QpP+beC/sDGN8akad8Pli4PxIuh2GCHi5l6pZUVSgvrwA+
 RsXrEqJU0+lt9uFKC9/3Bi9WK3E7Fs20pH17JXPEzp9HXqbtlbvGlLVjWfYh6nnst3/s
 aut5VjKa5OG/hiU1sjJ7G+rW0riOYUriSUwAc1me5hfmaC2tyk928Ho+61H2+9A3F/NI
 G6hxgtt+hErSVzDw3Ui/DFPdpJWSoENUBbmax+D564ffRLdDsRH0y8Pb1r9LEIMRadd+
 ttJfp17+W1fyBo1bgdeU3M6P5g9+bsbXBZtViiDvrkaTYdG3sFXIKb/9puxJUGVMF4A1
 /FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725393889; x=1725998689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OY76Qt8T9LK/vUD7hekByl1wPB2B9FXxv8XnTxxgVPw=;
 b=cvjzarcuW3dWh5rzcObEKsI1xtJZMokCNDVzkDF7wJcFxDr0ZLds5SHSa8J4lJTLil
 myvFRP77YLaHjDKPTRjYbHqW4u2A6UPXLhhGaLbyOm4GAzc1GIRmWzWxpEDnUr4HW9dT
 8WgHTMW/lTWEsR3H5oY1kfJ+7G3RBx2cUuPTRlvo51C6tkoWvC3T+cpOjHLAfa9YnBBj
 c5GBipkAN0leurcQm2xR7LUEmd106EGNtuaMxO/cPx9OwALXa836jQhOcyE7o3eqEnsw
 CjPt27GeQQstXKN6d0eGfsh+ffSbLOBWDIwW4JekeI0Umkgok97dOy81X02NmNQ9aeeC
 9SBw==
X-Gm-Message-State: AOJu0YwHMyxUcOAUAxb+1RWKaEARSZ5zdkKKZei2kvZTh9qAOsBcCWJf
 29NF1HDiq0JixKO0quV85Fs6ABtBdMBCjVAywYzIKjT9P+Ix453ql6+4gLR8EpPkBATWRk9sVyA
 6
X-Google-Smtp-Source: AGHT+IE6kltQ4YDPoiHdbKwpu00UGFwGPTich2hp7agH6ATmfYgnBTd31v0FJeSquxsZaRPRczBO/w==
X-Received: by 2002:a05:600c:a01:b0:426:6857:3156 with SMTP id
 5b1f17b1804b1-42bb01edd50mr174313115e9.27.1725393888727; 
 Tue, 03 Sep 2024 13:04:48 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e33d83sm181906235e9.44.2024.09.03.13.04.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 13:04:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 0/2] hw/sd: Remove a pair of legacy methods
Date: Tue,  3 Sep 2024 22:04:44 +0200
Message-ID: <20240903200446.25921-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The omap2_mmc device -- deprecated and about to be
removed -- was the last user of the legacy sd_set_cb()
and sd_enable() methods. Remove them too along with
the me_no_qdev_me_kill_mammoth_with_rocks kludge.

Based-on: <20240903160751.4100218-1-peter.maydell@linaro.org>

Philippe Mathieu-Daudé (2):
  hw/sd: Remove legacy sd_set_cb()
  hw/sd: Remove legacy sd_enable()

 include/hw/sd/sd.h            |  1 -
 include/hw/sd/sdcard_legacy.h | 10 -------
 hw/sd/sd.c                    | 50 +++++++----------------------------
 3 files changed, 10 insertions(+), 51 deletions(-)

-- 
2.45.2


