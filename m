Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB64C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXImS-0006qM-1U; Thu, 03 Jul 2025 08:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImM-0006pb-UE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:04 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXImI-0006cd-Ve
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:11:02 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e7dc89108bfso6979596276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544656; x=1752149456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgz7imnHQF0ifdiqI4VfQAm3LZ6FWHtpQJA9PVJnEfQ=;
 b=kRmxdpMtzR6qbjTq2ZG0iYaQfYM8Uxfbfc3fvQUQiBMXkBJVMerr/vQxiaEiVDNpS/
 CFMSNx8tUG1FMaQ0zn3/U28DnkmmC95Qr/YXZ6hahVXJ2581JPJF/LrpiRu44w65pjT9
 eg3taXLa9YKXTYKTatavbf5V+ELTQFdp0U7ZStmPtaadRq81FTIKPM8AJupmWc/Aqh/7
 9tbroWTGinb3uh2Vzm7T7VV9iJBYY3mYJ5F0jxvtj5bsK3sW+dnjiIO/7Y+mNv5Lu+Vi
 DI/N/EiPXHH3OO8KwcZBGGnNKtbXxcMMBd9grGZAxNgmA0EEmSZiXOkiELVK63/l8EHN
 pEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544656; x=1752149456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dgz7imnHQF0ifdiqI4VfQAm3LZ6FWHtpQJA9PVJnEfQ=;
 b=IuO3zujWrasYTdOZe4C6WCBmznR7n+Dw9bNCk9p4GE9W6tFCQCir6fCFIw6feFE0MP
 vN4gM1z1i5wEvRmAno+TC5DyANl5ulRYw+w+OZauJVvKqT5tCYngfMKhY9Ox7Dtbwf9q
 jfk9dLWJlzCVlf0kUDAcgfi/QsCcd4vBYZWBTt6mh11t0xzHhS8FhpG6S5g9bX7s4FBB
 nOVJkP/2zMcCGEXlP1eRxG3RbwWWjAxqB/pAgeL8iFhrq+j7jgV2hNukMBqKJH8K+2al
 T19B+NDkbsSq8NThZWHNqiVM/5AIVb5eOP8NXHW7kj2KhyIOVWScetO8af0/38jA/Fg0
 vS8w==
X-Gm-Message-State: AOJu0YyzR//gQMSBIe2qymHNDqPdTBrPTV9BX0iAajnvdwCwGj9NQb2X
 c7jZeyRxhATbJ6+zsn4+3HYxnDPg7nxJyEpCGyS9l9c2aZsHKfjxfk2EmXuyTfLH4NZNK0lN87a
 2CSn9/L09ZxcvIjiUp21nFycrOAFNEopEi2BRdNJ+Ow==
X-Gm-Gg: ASbGncssXoN91DqRd+xE/yAfPibBxBkxAWUV4zLC1MW1AFBhBXvvkwS7ivayQcqHBZf
 91lVQMKgL5QXRL8IZQ7iiYpi+JMlL7XuD+3U7MBZS7RKtv5aEgVAShIUbxx9I19W4JVaF80rWqm
 bmI7Z8SU+h5eTzZdM8blKQSDOn5nwePQqMtvJHkk836N75
X-Google-Smtp-Source: AGHT+IEMQ2sTycjmBTuPN9OlSG/bmigKmT0+3KKi2WeDXIYtJnV+yYR8rnIHYTzjGepzXI1I+xZJp9lPrwK9Rt1WDok=
X-Received: by 2002:a05:690c:b99:b0:710:f025:4077 with SMTP id
 00721157ae682-7165a32011dmr40496527b3.2.1751544656315; Thu, 03 Jul 2025
 05:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-66-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-66-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:10:44 +0100
X-Gm-Features: Ac12FXzIWLhrNH2p4jIxnuGLpYjhW9qwafzHzp7x7poguYKFicI7CJhACrvhdcw
Message-ID: <CAFEAcA8m2BO5wXY1qYA4HXMKZ-D2+oycdOPpNjXRcTPwBwyT-g@mail.gmail.com>
Subject: Re: [PATCH v3 65/97] target/arm: Split trans_WHILE to lt and gt
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use TRANS_FEAT to select the correct predicate.
> Pass the helper and a boolean to do_WHILE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 23 +++++++++--------------
>  target/arm/tcg/sve.decode      |  4 +++-
>  2 files changed, 12 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

