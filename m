Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4BC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuUeo-0001Xv-D0; Thu, 13 Aug 2026 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wuUek-0001XV-T5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:35:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wuUej-0005i2-9q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:35:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so177471166b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786624532; x=1787229332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m8yz34tzuxupe7kjoS1VX6F//7KiZyUlT1ASPCs+Z2Q=;
 b=dkA0gjG+aHY+kTpp7j6a0qTaFxgiOfThUab/h5z/7rxageDlZENSbdhRsQtanaRZj4
 rkRQlSLyvxN5opwAX5K02kZDW7w4nEhHenUZd+fhCztqoP9P3as0NaFcPD3QOkvcw5cz
 iMpVQhyPpX1nB6a7ylTfHNfyF5ODUdrYRSd0/FNG3JBOLcYj6rNzwR8cM3zgEa68imjb
 7AMpM4yJ1CFCo0msUin/2kIrS44nrIlKjNaD9tc121lfvffNdjL3pDdow4IyHm+NwGIH
 3P9AJzlBeHmPGgLbmTQUQJUu6MYRN/sEX6dTqbx4/iRt8zB7Iudfz3bWCJSEn0ikFTta
 RMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624532; x=1787229332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m8yz34tzuxupe7kjoS1VX6F//7KiZyUlT1ASPCs+Z2Q=;
 b=Di5p5tQ3wimEo0a3xWodYrUDY54JqsG2JhDMmrHastKGKRh1y13aUzovth1u435Kle
 UEO49VAK98f39iSFrvrNrP4qniU6ugTwnstDUqkKu6/4TZJXxYHYwkuXMoAj50cHjpIh
 bUJvMlGaDz6+D8f3hKbUJ6CTY1leW/sDwTGIUY4g7tC3gXMnO0p7sh+t/uoIZfmmHpdC
 SakxTxKvIAvdOOCotUyOZ10eRTGzualBI8N1XYXLRV7Pbq4VN8RtSHSao+98+a+DGz2l
 UidKpgH8D275+BIQusKPsqYxaYprTC3ifEmWtm2sucblFBwJM5P+ds48omIERqY6mzjC
 uyEw==
X-Gm-Message-State: AOJu0Yzt19ZyVl8NEXaIlzkyCMNc3HSYWnz4Xc0rYgvKU8WDmZeut9nf
 JJum4e6pwmSV4mlfu3Ws/cKzlHHRvGmiFZdMOVrUM3sgDptwlJRJ8URe
X-Gm-Gg: AR+sD11+iGHZWhjNq41xb4MHyMbnm96uQbH9BtLPyY2ZkjcOu9bAkzCa845Zi8JV7by
 i0es0TchuwcfXukxAuMgJcCGTXxEkE4z8wohG+aMH3OGGWZnnbUf1o6e6o3qvO6NCZ8Kc1cwDZu
 5rKJY1vipZ9AC+x8tZ46N8DmJkWTCU+8Ue5RhBzLnYuaUVZ5RxPJrFWrv3gfcS6/UUi4bCIbDx/
 f+rM58CMJvj9/WUpYPFlP1X2t0z7I9AN8K1/CZKuya8xJeX2jw6GqHLBFtK1OHc6P6qQEljx5Fs
 6kmr6qnZ957p3gRYmzZDB+WbKr7nnsisMs1I/IML/plQWUh55Abx0zwnvdZajjPMfJIjt5KNv7/
 dhyuQV+EYJ4EJcy+/2c/Dud14bLpz6ninCL8yYigIk5i/GxYh05zy2Fs4SC4UtixGtBYWCMJo6L
 +NR8mOiPxii2pKDgiTI4+4TEHRISAnK1oB9Q7UF96ABeq9x4j7GtiEz+GskT25JiHi0mCu+K0M+
 hrji6rN
X-Received: by 2002:a17:907:7b9c:b0:c20:f703:c411 with SMTP id
 a640c23a62f3a-c2108f37322mr229628166b.5.1786624531226; 
 Thu, 13 Aug 2026 05:35:31 -0700 (PDT)
Received: from DE-PF5B95TD.clients.cmblu.de ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2108885655sm81943366b.57.2026.08.13.05.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:35:30 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	qemu-block@nongnu.org
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
Date: Thu, 13 Aug 2026 14:35:26 +0200
Message-ID: <20260813123529.30457-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEUhbmX=azsPMmxipdeChe8imyFBwKvS4KRy5Qu-phaUBodOeg@mail.gmail.com>
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
 <20260805080540.323431-1-wafgo01@gmail.com>
 <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
 <20260810124519.34501-1-wafgo01@gmail.com>
 <CAEUhbmX=azsPMmxipdeChe8imyFBwKvS4KRy5Qu-phaUBodOeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Bin,

Thanks! I used the Icicle Kit as you suggested and posted the qtest as a
separate patch:

  [PATCH] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
  <https://lore.kernel.org/qemu-devel/20260813123210.28987-1-wafgo01@gmail.com/>

It drives the generic SDHCI model through the Cadence wrapper (SRS window
at 0x20008200) directly over MMIO under -accel qtest, and exercises two
facets against QEMU_CLOCK_VIRTUAL:

  - pacing: reports how many SDHC_TRANSFER_DELAY steps a non-interrupt
    ADMA2 chain takes to reach Transfer Complete;
  - MMIO coupling: after a chain that yields on a DMA-boundary interrupt
    descriptor, a bare interrupt-status read must not resume the pending
    transfer.

One caveat: the mmio-coupling case is written for the fixed behaviour --
it passes with your "Run ADMA independently of MMIO" (series 515264,
patch 12) applied and fails without it, so it is meant to land alongside
that change rather than on its own.

Happy to respin it or fold it into your series, whatever suits you best.

Thanks,
Wadim

