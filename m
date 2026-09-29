Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB5CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWid-0006K1-Jp; Tue, 29 Sep 2026 08:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWib-0006Ja-1z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:13:57 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWiZ-0002bh-HS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:13:56 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-67375a844dfso3743505d50.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790684034; cv=none;
 d=google.com; s=arc-20260327;
 b=f3BkYs6mg7gkrElhVdXNnETJfPRu0HjatT2r1dsJzJRFCuMQVqLnmrzbIcGImUO+dd
 jXHFxeoy/uEYjb8XKP+VdKDGVjX6QCybX4If8dWevw2xXJkcf8PG0oqr1o2k5uCy9qz6
 XWFfHre2N8FsvQrtLPAgidHMbsT78Z03bMCuZc6mSkxVA6U4auWOsVTpHgbP3gr094ys
 K0EpLz2A2zK9cnisAEMiA3llIy0WZ49BgdcN766O1wkcJslMWsIaA/1HtCgbDEffMAdw
 1Id947tnRQjYOoxfPgOBi9/5pVqEFqphqQ8BqpHuzLYlFg5LbiqTI3P5COtQowZT5S7e
 25zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VLg6uRoKunb++h2X5Oh0IQFqF2B/BMbAQYmBV0OhVas=;
 fh=FwY+JvRirSf9rT7rq36uEcs5QuzgraQN7XQgCQEGUB4=;
 b=QeP8jBQ1oaGg9KxnamYT9bpBNBVuFpMyN8c0+WOReS/0S6KKHQYM0G71wsnV5wNCW0
 5K+pNo0Tjq3wWRl1CJbIUyu22Td1jIGaIbX8x9IRHDxbqJsMvtIZjNskC2t8k7NiHAdh
 tfuefwAeCxX+L87lF8469Qy4a6CH2XDQl0kdSfF+U02vDDM7DZgilQ++XfxViHb2Tn/r
 1gfdQ0BtN5CUEeM/t9R1L+fCl3wqCAWWv2eghvggvwYXPbMdYfGDlHLur83AoPXaCjaL
 Pqvzh6Uu198qiHrLOT/dbv2sUX8cigZ+cEyFsTHl7s5lOdVhPM17ex7gnxuTUtVUtNj9
 hF4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790684034; x=1791288834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VLg6uRoKunb++h2X5Oh0IQFqF2B/BMbAQYmBV0OhVas=;
 b=SaT6EkP65SbjCneDJfLb50UAmvs+gmoEIEGzvT5v8RlkL4Kv6gbaCuqErcRFHalCfd
 VPfvJKU03QW5CktjNbFvKS41RXAVzYU+xvh8+GKaZ01C/Bc6T3YWxphJ2fpbOy7q7RzC
 umjzQuYhlihY73bZ5YFuQP4C79Mpnt2vnhqFfRFx1VhUNGRcOiN39kClmq0L/5O4F+UA
 8aC38vQUwzsd3U7Z/iuULKfkL4okRPSUlNxV7qOlh3SUPItquXGGz2SYz0jRFrVosFJY
 S0gaTPjwOmZ2HeFen1OHr1jkbDhOjhTEZsTbeCZlN4JbARv09T8J+toqCTBfE7R7UYg2
 8lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684034; x=1791288834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLg6uRoKunb++h2X5Oh0IQFqF2B/BMbAQYmBV0OhVas=;
 b=U2d3a+poTnBEek4iZXf1I49pcqHKddtwiOtnzdLMKZ1ckCf8tN9qV+2yZgKh/jSHSQ
 glhoogn6Z16Y7aqU0ul+HeQt83828Qlq5fizbDBOXdDRUSm7Cx1ZOCXObJ+oWkjxmsSb
 r6zmJO+t2ZdRNaSfPKdbLArbdgy9C+Nv1YxazZa4U6CYkP8fuknFCCxb+EumVH9z2fYb
 pgrnzyYGXCaOhnx1Fop3gZAWaea4w3bmmny4j4cTbV/RxNSTo4UjSTV3INZMw3z5g+OW
 pdg4TUVBzx8kBy687WrGLHj4VoVelyYgzHoZTfEBDIcX0DzaOcuHkQYX5rjLf2vcXFP6
 FlIw==
X-Gm-Message-State: AFq9FYJ3oiNNcJykGeLmTGUmG8y4Lk1uHASvjGa0F/iRDjz1C7VG+RoC
 VfAy0F5PxLTCXKJ5HwSmZgc0qu6bw7lEdgEZlT/TmxtmXTi33eJTptRPl//e+A4uRVb0v2ixQzV
 L+rHW17BELEUaeVcaumo0LjIPqrI6T0xjCBBLbDAYTQ==
X-Gm-Gg: AYBFou2X1pcoFIAx0u/tUODE45VGqqthnsSt45XQM0Y5rcEGiFE43blbgKVtulXtno1
 TgoCAAQr6KCSrfCxpbg6gTI5g3YR4oMspdh5hLU+/HulJEyEcWSQVxV4/+D3oT+GH54lxKJzuBV
 35V8syfLBtQ66jGc4tTdAGAnLjLn2MYbva2C7VW8TzZAa/6Vt0B/iRX89RYawd6Oip7u4P/mFic
 4URyy4u+GA6K8dLSXS909xu0k4BCNhtvaSnFiAtHVGEGXyQ0E/ANnTwdh9avtdFMomZjty58CD1
 Y88vFaW5dF9vztOXWJQdb36ICLAS7Zpias53FYHyr93F0ZVh+HU0tWDMQwrY6X/zPur/G56BiW5
 s7kTVbKiPAB3V6mq0hRUUaiAFOHaLwdB9Q6bCM9g=
X-Received: by 2002:a05:690c:e3c9:b0:8a9:9a2e:e34f with SMTP id
 00721157ae682-8a99a2eeef4mr40370937b3.13.1790684033632; Tue, 29 Sep 2026
 05:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260929120838.13583-1-philmd@oss.qualcomm.com>
 <20260929120838.13583-3-philmd@oss.qualcomm.com>
In-Reply-To: <20260929120838.13583-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2026 13:13:41 +0100
X-Gm-Features: AclHuK-wC6eKOthvFKJ2-qfyNPPG45NYT7BZuP7riwu0q1I4w99s9b4WTBWoDgM
Message-ID: <CAFEAcA-cjk0t5NAKLndshzoU3XXH5FTcYD=8Y4Hz9BFhkR6UDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/rx: Define exception vector constants
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
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

On Tue, 29 Sept 2026 at 13:09, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> Name RX exception vectors and trap ranges, and use the
> definitions throughout exception handling and exception
> raising.
>
> Assert that exception indexes remain within the defined
> range before accessing their vector tables.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Co-developed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

