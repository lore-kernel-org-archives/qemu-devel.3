Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABBC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgVz-0000zD-JS; Thu, 30 May 2024 10:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgVx-0000yb-K5
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:12:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgVv-0001u7-PB
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:12:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-357d533b744so957180f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078338; x=1717683138; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBF/ZzD2mBBt5E4hV3YGQ8ZwzIuykJuZ8dgGkE0ISxw=;
 b=ThXaFcGo/dVJYE04DpaX4dj3+xTnhef4R8LrawF/ea3JQFf9GR2Fs2L+XWj0EdJ4wB
 sh1P6ExV4hd+fwQEKNyxcitHZrydZklAII1dFgnovL2RVKQAbki8miPhT3ffh3tbiv3t
 sAh3hrCyK/lsYCS8jj7P19KLGNgfYUjAA6HvSOM1nt36ixH3thTLw0Dxy4ECCuncoFKv
 oauDyJLKzsBfwT97cxbHF9pbM/fCDuPJcES5+7BwrDer7+4KvSzRKSxRj9PYa7BtGey+
 JF0D0V82NZ6X3JcnkAOquycZMp+T99a8xQB6gGr53Z+8s23pjP8gICLKAA4nCaRVwEhi
 wvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078338; x=1717683138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBF/ZzD2mBBt5E4hV3YGQ8ZwzIuykJuZ8dgGkE0ISxw=;
 b=Szs8Llhfugs0PR256CLZFUHnH9b9IDkw3r5yv08M1a4bwgzJDERtkZZkCf+fVv+WYb
 rbhK4Jq80jxB/TPVX5VvrZGHHFOlbYyhFFeY1sHf3Cl7FnANljWNpOyQsz5Mz3JIeFzN
 z+wRpB5wOvhdyn6W+n4G3Q4ZYwMkZq8QFlZ2YOqkns8fswg1ck9Cosk4HBOV//CumniG
 7SH0xu8AuG+Wl/WBLDEI6yq2T4p2+OWntbAKRMbSoNa8Sl8NsLgGxyDJG7ndijFEE9Yw
 w51L8U0rNCr896SUBEfhtfIdADEHMKm1IJNyQPu4Jo6vcbwaeugLKeQkPJyq2Te1NZ/P
 wO4Q==
X-Gm-Message-State: AOJu0YwrIeroMindJpeA4yoIOV6Vby5pP0fwKugjRvqLgZRvL3xlXBzY
 bf9guqRHBj9+4FvE6WJeiugF4H0ozko8bkFGkH4JRvyXhyaHETXvAiEVs896UCYWfcQBo2p5LE6
 wBNhrCTv90mZR/2tH0O1y7auTQJVcPAl6iE9t4MBM+xRn/TM6
X-Google-Smtp-Source: AGHT+IEumAsnC4GP8/3QlR0VWCp54BKFBJ1bS/IgTWCdglevXelOLmM5Cnu3LZ8BxMEVD6AYGYwiXl8MrsELyZaO0TA=
X-Received: by 2002:a5d:5109:0:b0:355:3b3:f1a3 with SMTP id
 ffacd0b85a97d-35dc0087de8mr1562001f8f.7.1717078338119; Thu, 30 May 2024
 07:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-11-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:12:07 +0100
Message-ID: <CAFEAcA8PMys3q3Cyq7Jay8-o1AO_kmCsqP=WLx+hXG_EhKhLeQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/33] target/arm: Convert SRSHL and URSHL (register)
 to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

On Tue, 28 May 2024 at 21:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

