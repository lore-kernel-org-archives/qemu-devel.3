Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA8EC9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIhD-0007V9-AG; Mon, 12 Jan 2026 09:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIh0-0007Ls-AP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:14:52 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfIgy-0003Vj-6U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:14:49 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-646e2b3600fso5857782d50.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768227285; x=1768832085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=onWFcl5Tzy1b1GoV1iZmBqItx73dMuZ2z1Tes9jBik8=;
 b=GRcQL3TjSbhtXGfBm70vp3WpJP/G58muCSzlCtdcQtJVfvAixO7wUYfk986nyVgPVP
 utCV52qdo/sRHvPzvXN1CU0GCrwxw95K+U9Z4KjofK5Tk/C6tOzD2f4ZGUMyzGwJh9Nf
 W9/7apLEyBpOkrXng76gmyPmhMc82xeW9NCbhGcCyT3JoV6Csen1I1L0zR29PLuA/cCK
 ghqQ2XBQJKvcZwBme1aMRoLN8ns50Ifap7Ar4CkIv1XuWMHMypTvpPavnIIStgFe0No5
 qZC2tkpb2zoiYZrjjmA+ls3ZaxVPd9p+2j++d3kJzm4VItHz1RkMNrzL6G2k0xbXfwId
 NGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768227285; x=1768832085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onWFcl5Tzy1b1GoV1iZmBqItx73dMuZ2z1Tes9jBik8=;
 b=Yp5n9HyuS/E0XgdVbtsNKq5/96Vzz52mvga2bnj0GLlv0A9trJDr6BZtiNAdcey6uM
 mS0+6gldm+agKvHR2FnZE5k6KNQV/ZA0IFoZc178lSTD9xnIpZmhBhHlw6YDOi8mtd/3
 zh5n3BpSSsbWcPK/YNR9HoO4isPi2D4MH2K1WljrLTU1GPNy5XXl0AYSFymnE6z7pXhI
 aGBRU+uzsGtVrWUwMT/qP3t8pP313N9SJb9HPy+1YHnII9VmS7zs0BFxnkeiyTKZuhU5
 Z9y51Qg6X41I0/F/OnweHxn6odzOfpjUdNPIVBu9vRk6tmR7QKrbZLpJ5lx1L5N7VLWY
 9Atw==
X-Gm-Message-State: AOJu0YxwBJa0jGB7JCTwAWv4yfUrYbAikW6+w2jkKn9y+0SQl8Zo94ZG
 qUyk6WKCx1d0y0xuSVHfl2VYBzkznWsKmvAsSJ+TBmYgc5caq9nYRRMfBwd4Tzf32kZXYRnyJdN
 MJnZtI+M1ZorVkM4EZGcnFckT/tNBkZ2OSmlLlmGtXayWqPTr2vMy
X-Gm-Gg: AY/fxX7xpBdZFSM6c7W1GIR12BKjPYMTfcKYvA74E8VldOlwb8TaC4ZWr57QpxBjkdx
 PMZf51QM0kd4j8m0XpAIvctu2YYtRRVOwxYWv01o2R0PBZwy8PfrQUVeZWgAFqok3yumemqMEuw
 iWJFraTMQoKJu5JSlYH/acQ3300lOjsKPnLQlqVWY9evcT4wiD8bw7BkMCJ9A64v0gSbM7m3zUw
 2UzLH+IRmVvQCnMvCe/KARw52QRah2fQviqnHpsGFwk7KjSbCvT6lNTUlvQn2ADvJ/d/TKZoitl
 lDdDyKr2+6gjKEY+zrCEux4=
X-Google-Smtp-Source: AGHT+IFBDViaL+mHQqMngY22QeTtfvIzkyA7kNrLmXX7XZ/thMm4wcMcO2ywESiGzNcQsJ4FYTjlKGp9K6zPbN9v56U=
X-Received: by 2002:a05:690e:14c8:b0:63f:cdd3:11f3 with SMTP id
 956f58d0204a3-64723e28b8dmr10614397d50.37.1768227285442; Mon, 12 Jan 2026
 06:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 14:14:34 +0000
X-Gm-Features: AZwV_Qiqp5ClB2FKfmEaO4AkoLec1SEH3OWkVExjKheD3ob9uXr1E1i7hoi8Sb0
Message-ID: <CAFEAcA8rHp9Yx9PeqoDJxa8VzArvD7Zdegdf7-fQgw7A7nMDEw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Basic ASID2 support
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 10 Dec 2025 at 14:51, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> Enable the ID_AA64MMFR4_EL1 register, add the ASID2 field for cpu_max,
> then enable writes to FNG1, FNG0, and A2 bits of TCR2_EL1. Any change
> of ASID still causes a TLB flush.
>
> Changes since V5:
>
> - Patch 2:
>   - More specific TLB flush. Now only flushes the TLBs relevant to the
>     written register, and then only if A2 changes.
>
> Thanks to Richard Henderson for advice on TLB flushing.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
> Jim MacArthur (4):
>       target/arm: Enable ID_AA64MMFR4_EL1 register
>       target/arm: Allow writes to FNG1, FNG0, A2
>       target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
>       tests: Add test for ASID2 and write/read of feature bits

Applied to target-arm.next with the minor fixup on patch 1; thanks.

-- PMM

