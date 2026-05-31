Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E887CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnYB-0003hh-T2; Sun, 31 May 2026 17:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnY9-0003hP-RD
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:18:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnY7-0006AC-Rt
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:18:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so97350095e9.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262302; x=1780867102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kgr/eO8gnYMMA2IdbXhwJaZa3HSy4c+IFNx1J5vmf2g=;
 b=dkYwruU49RyqK0r5BSy7+ko+ocuaiLmFvK4vUm2hIrK4kTvEOGjNHgxv9ftKcIXGfy
 HIbuBfuYHc84SUUJMNFtDWUTkSll8T8/XdlIVQKCoF2kx3ly2g6hLCMPFj+0snolOAcp
 bW2jdKLua/UOyMgseJL1U2j3YE0I+21mHdjAB+EryPzWWsui3gfl3ONfxNek+V+cQPjw
 U6+CzqE1bM91xB4WX2j+ICpnjpJkYZdHuTCXNrOn34DQEz8jyz2A8UWFhoJITjE4lFUg
 Y/UNXqmOqt5YW3BkNRZEgJTvpuw6hqtBJD7aTyrXNNguX39oSCwx2T9V8lJoQz9jYjXD
 SE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262302; x=1780867102;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kgr/eO8gnYMMA2IdbXhwJaZa3HSy4c+IFNx1J5vmf2g=;
 b=C2sRIyS5uCTsxzTqC/yDX0F+AW1QJWHOWZxLQw9LyzDRa4qN9eK7S3iW3lIv2bRNtV
 9QSopU/4EGZStcxdU7d25fgIzFKr1iedG4DL4WXorzL9+U0bou5zWKBQAJwonlbUnNc+
 zi2NcWG1QkiFDP33wFkxzQ3seN0DzBh1gXilzIPcJtOUPQwaiea9vIzfUyM5mA/H2MHy
 0UWnoCJzTfDbaVOUD7Ab3noENoZkPH5e+7aHGSyx8wLGLYWfHQojE4cBbVuUvm4bebRK
 Hhu3RxwVi2JcsuqiNF4aclieBjQKQayNPjOrQuyO0iCkoQAE2xRVpCJe0x5tW70ouXq4
 mLJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e8noCTXDish0A3cPP0uYhR5MZ8+aDXHs8aHIdO1skZwxedQ50PuClijyhkm2U1Of6SBMcxXGcKEC3@nongnu.org
X-Gm-Message-State: AOJu0YzZHWZPVoHkfSlPkwnOggdmeRIvSGsdyllvu8RF4DJpIbOaqYsP
 x+siJRIrGdMK70NRkb3tvTl5ftuT6+venYC/ro5QuCnRQk7RL3vZiHVqQxIArKYRZMw=
X-Gm-Gg: Acq92OFIUZ36fz5Y1ZaalmZuo9ERz/414bvZNu5FaQZdy1oN4U0pgh41v3Ox1jtwU6k
 2q7LntRVGKVw9IxlA4lGcuvct9sV2gMtcTI08hmE9yaEDHU3rLYKfHp1i2CEVLMH1tAdI4K6XCu
 9/Mh/qyt59gO8sgBTKeVHbMF4k6dbztRydWplp+mTDk2+NKEXIIfINU8tfG7qgvTxGKLyPaTx/a
 m/Hkfud9vnt/UJig9QCuUQq74Lif1FC1tAbGZEu1uTQx6hiFeT+YZ5YFBoNpBfPniNUTMGLN6O6
 za+tYmnQt6bMFlz2z6uyA+T+Wjeo6PEg9iaI7olDvWbOHOeYKyS9yz4nSOncsqkTFrc27Glza8e
 CpWZelg6U22TYsL+6XRrGhO5Op2eyVQDlkFZV4fciH7PYwc6n7tWEMiZ+gr4P8NfsbHc95dS+na
 Sv2ZqvQyvS0pu74YabzbKP1LQ1z5XhClOfzne8hojT4ZUHYjJMaIcH/ouyAJiFQNrC5W/TQjvUE
 AoVW7Fbl37EGTQ=
X-Received: by 2002:a05:600c:314e:b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490a2968488mr159948105e9.25.1780262302229; 
 Sun, 31 May 2026 14:18:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354c682sm19132350f8f.23.2026.05.31.14.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:18:21 -0700 (PDT)
Message-ID: <55634fc1-9dc0-4baa-bd14-8400342da285@linaro.org>
Date: Sun, 31 May 2026 23:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/38] target/hexagon: Make gen_exception_end_tb
 non-static
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529215554.606133-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/translate.h | 2 ++
>   target/hexagon/translate.c | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)

Squash with #9 where use? Otherwise explain the why?

