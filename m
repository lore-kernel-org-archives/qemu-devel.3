Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7092C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqKW-00018j-N2; Fri, 01 Aug 2025 10:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhqKD-0000qt-Sm
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:01:44 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhqKA-0006NR-JO
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:01:33 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b6d27113fso8510417b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754056889; x=1754661689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S7nN585j+6dnpyyFLpPNGlhyr7gwvW8TXy3XpaaAmkU=;
 b=N1lFie9NPe8tGUiTxxoC56kKdd1XnvTZhcL5g2AbziMEkHkZwwZ3NXmU0Do2COZo8k
 yRea4daFRaCN/ntJ1Xt4Q7NvPpjKa2YnuAZh5JREJqddkm6I7ynZu1vlRsOwrbXAvxU9
 J6E+S8ElhbaDTG+nNUzAZiKLMr2kAvwSsLyBQOCCmW8jhLeJseVWQej4AN8il6T4Nb57
 3WC6xdNMDQ2063Sb+9aUpCjLK40bgE+ShJqUE6JM5TTipOjHslsT3iFPmjPURR2i/voJ
 G5IfKedOfNco91Ap/XmnL2UvxfBCJQBsWgCIA6HLcZOVaDUGW853ZrHby1yGikGAXfcK
 OiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754056889; x=1754661689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S7nN585j+6dnpyyFLpPNGlhyr7gwvW8TXy3XpaaAmkU=;
 b=fILx7jM5IxhApg/4utAVZ8QuguVlRSBQNtV3QHix86T9saBbftUlzWhDNDThdYTBxH
 gGnQ2+YCOLhEunAI9nsBry52HquuZ8sK2rrICcvX3vygnzbdzaULzsPm2q+ziD92CzNO
 gOZPLfsKGvtQLSRkAoKDOGaYH49yHEU4oDLVuSHtsmqNKNnWLzKJ+mcnuDQqzn7SPiaD
 kmX5DylPVE9YEBtT2w8qTplqarXs+uotREpvqxWsMU1GEWmbpu3WhSTgMADGyOcCByoK
 OGxgTgWt2BEFlj9vnwkL0nAeGWbOlxKB664oHOARWVgeryQYzFoJ8zUkpOTRKLEpB/Ml
 gdKw==
X-Gm-Message-State: AOJu0Yx5o5UHP9CyHBhCmEeHnMvU8o/Q0YVOrqNPwn/nFTYK5u76E/EG
 1FmGoV8qBLvjaBjeYka2R7nfjkC3X5GPrgCIdwOHp4WHX2+iAY6O5irMwgCfabgg6+tramU6gII
 u0pLxkS9lYtN/WOPX5UDLqcbnZhYcWKosDV3PJ+wj6w==
X-Gm-Gg: ASbGncvDwTEf2KXwEvnAi45vAl9pNiD20HIzATkn+4hZis+rX/Jnya1CnMDlp6PSyOZ
 0mMs4T8SVof49+Mt4ulazd0M8QvITpoOKf+gynUs44ACkBTRWeKgirecJk8XA1D1VIAYKwOxzAN
 K/c8RwTENXMVVfJjkQxiURRupfkOfW70uQZxpmNbnTR7ZjwMnFjYSgPtntXEesaWUYhmDWtNXTh
 V7IluYwC0q+wOV8ZD8=
X-Google-Smtp-Source: AGHT+IH/deJo7yuxOzNzwa/PGK4jWcprNX1TSiCVB0z/mulY26kgHSXpzAHCKppZnbBs2Xq3V/C5WT7f5B71tnmOaVU=
X-Received: by 2002:a05:690c:6903:b0:71b:6bec:7f23 with SMTP id
 00721157ae682-71b6d802729mr35888667b3.32.1754056888729; Fri, 01 Aug 2025
 07:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:01:17 +0100
X-Gm-Features: Ac12FXz5pkLWBVblD9zAC_qgBHzbspl1y2mXBaktih8OjnOh1z4Mg2iYFbe8uVA
Message-ID: <CAFEAcA8DqD+iBOaQu0M1_-1AiWna0pgf+gD39+x+nNx+9c45LA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/arm: Fix big-endian handling for NEON and
 SVE gdb remote debugging
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 22 Jul 2025 at 18:37, Vacha Bhavsar
<vacha.bhavsar@oss.qualcomm.com> wrote:
>
> Upon examining the current implementation for getting/setting SIMD
> and SVE registers via remote GDB, there is a concern about mixed
> endian support. This patch series aims to address this concern and
> allow getting and setting the values of NEON and SVE registers via
> remote GDB regardless of the target endianness.

Thanks; I've applied these patches to target-arm.next (with
a bit of tweaking of the commit messages).

Something seems to have gone wrong with the creation of
this cover letter, by the way: it lists a lot of
patches that aren't in it.

> Glenn Miles (12):
>   ppc/xive2: Fix calculation of END queue sizes
>   ppc/xive2: Use fair irq target search algorithm
>   ppc/xive2: Fix irq preempted by lower priority group irq

[etc]

thanks
-- PMM

