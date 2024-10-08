Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B2CCEF177
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAq7-0001bB-Gw; Tue, 08 Oct 2024 10:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAq0-0001aC-W9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApz-0005or-7W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c881aa669fso6900142a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396317; x=1729001117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3zM5SZzFFXff1PcUoOOg2pzr9xc0jKIhsNlrWCEwrQ=;
 b=G/V81+hEkLq6uysD8HXeUMIdDHh0UwWH3GYQNPAlAKhz2tNEoC4OR4ztgaHx6l2gVH
 duyu6u1ihxpIvKAgoKU2QLK/WVSryvpMoriPJYWYKhvmYIBOPFO55T1pPn+8uxyvWBEq
 W6GGHfAYaZqx0/Hg/Z0+fHilnTUhpjEvQdIByjA5XapaBF/zrB1BEfKQ1IAB8i8nwIGV
 MzJbcAUkM3Wyr2yuKI8P3u6/2jeUvr9nQc5c89BOZBBHtJedy37gnMsDo3ilNJCUxrdU
 P8rOqeBVWqE9EYX0BxNlu7VoPf+i5bH9FxfQrS4x5QbcIsJ4vz8GKqLTYhXUwsLPg1dP
 SugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396317; x=1729001117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3zM5SZzFFXff1PcUoOOg2pzr9xc0jKIhsNlrWCEwrQ=;
 b=gPjq9WaI52GxTilxrkqFDXpSyW3XErfMa4SrF+Q0E+U2o6AlqssvS8UwBeOg4RqVLQ
 NRYAf8jc0nX+l5KS1/4NZPM5wRSfIN6CJ+fyMVpbjnrRDUfUZkR3uo1Ks9aqIlKB5/WE
 fUDRAPvC0jZnBaqtmPdY+j2itK8HPlxMJdWLW9pWEp85xDayz7YmbuLf7+zv1XkJFrPt
 kxzqAN2G2uKzoLKlfnwtbh/LhHhwC65RTYxZhGKvRcWr7b3ch97nOH6jw3y7UMID4YoK
 V2euxFKOwtm5rfhpKGZDgC1q8ti8qg/dEUIVgktUz5oQykYyDXFUu04pQkLQM2GbU2kj
 FTOQ==
X-Gm-Message-State: AOJu0YwcK6vUiFChfqUchuxVhBTRz56vLjaDxNy4flJZmGVYobtOpqgg
 UUckzrUtjIj3bbKG1Cjs8wzszikIKfdagUD8er/mAG3IsGwOfnFRFDbjfoemvNp6LZDaU5EK8CX
 K2ZMjPlgZVBgy55JnbC7Kj43eT5IxEJodrKA3Yw==
X-Google-Smtp-Source: AGHT+IHNjcrGqvYeAx+CtcWJD/2XeNoJIOWs0WM7Cu599a18mWnVOQWoNyZ2UU1PgsioPILapS7mhcrrDQaS9ndYOJ4=
X-Received: by 2002:a05:6402:2350:b0:5c5:b679:cf29 with SMTP id
 4fb4d7f45d1cf-5c8d2d00fc6mr12862570a12.1.1728396316888; Tue, 08 Oct 2024
 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-5-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:05:06 +0100
Message-ID: <CAFEAcA-dvX_4evZJ98WwB=Wkkf3N5BDER9aoV2WA7pzn=kmXqw@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] include/exec/memop: Rename get_alignment_bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename to use "memop_" prefix, like other functions
> that operate on MemOp.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

