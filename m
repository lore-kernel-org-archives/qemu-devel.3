Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF521075290
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AAN-00072n-7Z; Thu, 19 Mar 2026 05:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3AAL-00071x-Ad
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:59:45 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3AAJ-0004ul-TN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:59:45 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ca423ad53so900520d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 02:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773914382; cv=none;
 d=google.com; s=arc-20240605;
 b=EvwJx+1+psUa2/gAnctABQfg0+78UaIXBhSSepCkWHwmvJpZe2WRR8JoKN9s+P9RNS
 9U+8glWrdlLFske/nfbaCiq8DMQPhEKWB5PjKp/J5Swa2KRitkHq/lrZmX1L18KayLFC
 TzxH5qAjPfyIvjCeeSKc8P2Nwfkad8cguCSSTfFlcEV+p58r1U27hc8Uis/JKosnobA+
 EO2xTEoxGgbeD7s6MH+c+C910t8OptU++rVwPovwA7d7j3NNgMRlDxz4qAhFMPrRaGF8
 YL3/6nv57MqeIbPKCn0GhcLFUqDtQljCQfD4ytOLX/qCGqpqk6w+aH6X0gANsYvB7eJ8
 1SVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l9tqgiVeDF2QTwXIY1oClhARxh/7nCn4FvukClUXyxU=;
 fh=mtBtyw6A9HozN+7Y2jNA4ZJM1bxai+C45gGjBe8g1dg=;
 b=Pfi/uO7N6fpG8gzUZwdvJ9OHS8q8BEPIKX0mUv2BCh0UEvnJ0jjDf0F51z3nFm9D5L
 ooJO1p1ISjNToCZtt/fUgNz/Moc4sGgnheyQLwH9sry2kWO7yVDl13dTeyIUbD3dkug4
 7pnST0cQeQRsuVwRlOPW1eULL5If3SidSep7FybAd6WA0PIYOFrSpmOBUZhnI0Iv0YGw
 5DHwxFYH7HrjTB8mhCWI+aw1chh6f2bTbbFyWnFVK9TX52JBD/k7FoSk4VzPsBJCQkJz
 gz9QBSqJxOJt3hCyZ/3nPWPdPQPPFbRD4vQBvoSXZyUWd4bqyRdAJPbk4KIywe+5fTu4
 aitQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773914382; x=1774519182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l9tqgiVeDF2QTwXIY1oClhARxh/7nCn4FvukClUXyxU=;
 b=SUQ65/oHDXeNKoW7i3X7c8Sg7svVAv+B36R2G5cF8inWVhwH0/8z7qwM/yf1Hv13o3
 xZkh/eWgKrUgVK066yXbDqyX1xmISS6Rv88Usx6gszB4CTXl7YNeg9S43oZEDO73kUpG
 6uXNx6RpoSpXBq/nLXzs2vijQ0oNxc+VfzZgfC4yfUn0FJW5lKH2l8uQY9Yx9viPZ36f
 UabI77VBYpZkmyHD5Sp11glZUUrgHTwpzplCWlM5UEhuwpw/vqGkxxEiZfsO5V+7+gbL
 1TDGuTlYoraSgoVnowGZulRw7cZJMDhjOj+hPfoZARIx5+s3wlNNkLdNG/Njw9QHMv3K
 TC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773914382; x=1774519182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9tqgiVeDF2QTwXIY1oClhARxh/7nCn4FvukClUXyxU=;
 b=d5AWj7uDQrtCSyOF4IT7h7MQlSOiP57ZvVyThiyPEoblhnvgDgdpO95Hw+pAtcyInZ
 L3Qs88n/78IGZopCuPeftIaPWO49k20F+T1CzjelgL5+ah9elb3ssSxBu81AZSooc3Xo
 NT9+Hz4CnelhumRgVtLl24H/lVURdDgGWQBur6afyoBAMQDeg4VXuFypP5UfPMcJa1rX
 EMcnB/L9jcW2bx0wYAtTi/i7JfFyiBfw4yDLpsV/DCVZa+ncDJ3x6SwnZhfpEq4jbXyc
 Rfdl/aYAKs04FCkKIc5ZGNG+itwIZOcyxAYpgcwdu2OP+zr4tQ5DBDDLYmKJMfbxVjA5
 cDHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfAvbmTZ2NSjttLI9j4sLO4sE7cs88bT9/Tc5dfoUI0hTXpuY1+ZRvlLjjOXiVkhI7VMQVJe2UiHso@nongnu.org
X-Gm-Message-State: AOJu0Yz9JeD2Zc8TbCmoXAQRpra3Q0xuo55tPhnJg5eHORQI60KDkWua
 4/R/tfCcgTUf6ev4YWd05RtJ72Dr3mZEKoHozkSLqTDkMZfrtB7LBObBG2V2NXo12kzZOhTda+J
 jRvR2PdhuL2S0cxzDUBJRC3cIfx2qjrEwygemKcqQAw==
X-Gm-Gg: ATEYQzx/cFkGHglGwwTvmyUgoGdwTgsYnzV0HH7DRQxsWNSgD7ixGenutZohp8d4ZnR
 UKnbhif1Vl1L5KZaH429p3L8qroDEKnazvyDoa+qWvZgND9u8DQRr6nU0Cvl3ZnSuVSynjLlwNv
 7yOqLQ/PJ0jBHGHIzi38V29bSCq+TdmHyuRBptQrbmDJpFBNABIluk3wkKTUVZBkiSPr1p8Zu6j
 +5s9xEeQgPeydOaj61iw+slF/HuD9V3cwFj+L/OOjVZjvRQrkmtneODwh6S2vlLy4OKVUHhAI9C
 1QUYqLYCo72LyCAl6ya1XNUuz2+9pABIUZx26VL6Mao0QzGfogwfrPbDw9LOJQOHMpB5dkKv4la
 AGA==
X-Received: by 2002:a53:e1a1:0:b0:640:cccb:1fd2 with SMTP id
 956f58d0204a3-64e9146c49cmr5090061d50.33.1773914382196; Thu, 19 Mar 2026
 02:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-21-peter.maydell@linaro.org>
 <20260311141537.00003ce9@huawei.com>
In-Reply-To: <20260311141537.00003ce9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 09:59:31 +0000
X-Gm-Features: AaiRm50a1o3pKLIyazQ4KykB8ogHiUaaVsfnUZUtHi95PI9cNp5LRFGjv5DOhCU
Message-ID: <CAFEAcA-Pjbu+2u+xg7xbrsgq94yU+yYubf=iqE=YvYMGzgPyCQ@mail.gmail.com>
Subject: Re: [PATCH 20/65] hw/intc/arm_gicv5: Implement remaining set-config
 functions
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 11 Mar 2026 at 14:15, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 23 Feb 2026 17:01:27 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Implement the GICv5 functions corresponding to the stream protocol
> > SetEnabled, SetPending, SetHandling, and SetTarget commands.  These
> > work exactly like SetPriority: the IRS looks up the L2TE and updates
> > the corresponding field in it with the new value.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Trivial formatting and naming comments only.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> > +void gicv5_set_handling(GICv5Common *cs, uint32_t id,
>
> Might be worth throwing _mode in there as set_handling almost
> feels like 'set that it is being handled'  Also aligns better
> with the HM naming in the spec.

These functions are named to align with the stream protocol
command names in the spec. I agree that "set_handling_mode"
would be a nicer name, but the spec calls this command SetHandling...

thanks
-- PMM

