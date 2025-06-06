Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA2C5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTml-0003jN-Bi; Fri, 06 Jun 2025 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTmk-0003j7-5E
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:54:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTmh-000518-VV
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:54:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60768e108baso1438467a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749203686; x=1749808486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dju44UsTwp8Dau7vS87f3K8r5WJGYDGhrOX1qfm10+g=;
 b=Q+4IZ2kiMaCkk5/DGrXfS1D1SGYpUQbSX8XxQ7fQFN0V3yNwvA8d7ANPu5L8e4Zxs8
 URm2H59sCHUNts5Fjr2v1F34Gxif5D5tOtNlD2sgl0dINeIa6wod6qMdaoYyus92Bw5u
 4xfhjnRRIrCQ/PqnT+EbvW1KFKMOq5Wrhx/0lg/Fj5eQ46TZUQvWdvN8WY9czrCmxDvJ
 9c7R7FLtfhdPW8RoASuVqabnM0UGdqKlsKNAU6mOpFrwv2He01jJYMhpuXzgNkZ+uX/B
 dRnV3KuxXmYRdaUQ+jn/R30lGFtnRvYswbFR8d499LrvoelLvsR9fwH2Eky+4lI72hlo
 ZGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749203686; x=1749808486;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dju44UsTwp8Dau7vS87f3K8r5WJGYDGhrOX1qfm10+g=;
 b=qOktI2ixDv2/xo8JRqnsQNin5eA6coDFgKPS62z9PTGTY6lQGHIqfaTIe5HmdAsnhJ
 +lOIofkrgTtNhByT/JRPXqV7C2mRhXp1ALHoIffxgIACgUQfHSDLwcOJUuDy/8unAnrV
 PdAO0MCedLuRiNcw/A//SSWj/usaAkB5ZFAoNmw2A52XHP5U9Qyjfx+YM0XGXVAkeQp2
 0KOqluD+SDD+/plK0RuAZlo0C8B3jCdx+Bm7uyGCLCGR+yItuaOXSmraf+ie3Yj0VPzl
 wyDaDX6SWdFsV5JVCTTnpYXFfPC/B6C5+j1/H8AQS9FHsiHGwVtga6ZstsjNDOktZx3t
 02YA==
X-Gm-Message-State: AOJu0Yzjf2sWecMELk8K2nY9L36UMn/KRzMrbpEM19xBqsaySOExXAS1
 U24tD0/I4dGqEKU0gP8azId2kuTWdY6njWciyu6nP1XUZgqoFx5u4kYRzvP4mDg0egE=
X-Gm-Gg: ASbGnctioAYW7dYDawig9MDvK6v6BxbuUdItW1LCPTUlNVdtVQuY7ZGPWuU6zWoY5Up
 okoo3FUKa10Qxvs0WZ0z/5AZ4S6W34vAbU3cuKQGwEhPu2cGBO5awj9abtpxAJw5Xd85A9ylSAr
 wsYHVUtTcnojEt5y6iUdw59otLpA4CZuPKnJCSOoE6gLlkG1oZ4j+ISmNsJcrTfvpMOMT89YY1X
 dSYpEf0cVuNfGhzXaXc1KdLaOUOoCl2u5xiz+OfWvC+AOwSUzfIqr4ceVeNYe1uV6+Ql5LgUWYM
 icLq3NDC8dmQnScB7kPw89lLl8pTGlF+b0CziHdr3/iP/7qWu0oshyu2oKObSM7sZ0kK7OdI0g=
 =
X-Google-Smtp-Source: AGHT+IFQSk/GWvDxii0E0KjRh3bUPkId8AI/TrlQhlj2xoC0m30zUZsAqdFzFIAByM3tm3kmtmNIIw==
X-Received: by 2002:a05:6402:2694:b0:601:89d4:968e with SMTP id
 4fb4d7f45d1cf-607748987c4mr2494413a12.27.1749203685731; 
 Fri, 06 Jun 2025 02:54:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607783c062dsm811675a12.42.2025.06.06.02.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 02:54:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6760A5F7E1;
 Fri, 06 Jun 2025 10:54:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-stable@nongnu.org,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 09/17] hw/display: re-arrange memory region tracking
In-Reply-To: <ee5115ab-b818-4746-8806-5056f3570011@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Fri, 6 Jun 2025 14:17:41 +0900")
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-10-alex.bennee@linaro.org>
 <ee5115ab-b818-4746-8806-5056f3570011@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 10:54:44 +0100
Message-ID: <875xh95h5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/06/06 1:26, Alex Benn=C3=A9e wrote:
>> QOM objects can be embedded in other QOM objects and managed as part
>> of their lifetime but this isn't the case for
>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>> need some other way of associating the wider data structure with the
>> memory region.
>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>> to
>> MemoryRegionOps for device type regions but is unused in the
>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>> reference and allow the final MemoryRegion object to be reaped when
>> its reference count is cleared.
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>
>
> I have told you that you should address all comments before sending a
> series again a few times[1][2], but you haven't done that.

I've given reasons. Thanks for your review but you don't get to veto.

> I pointed out it has no effect (fixing or improving something) other
> than adding a memory allocation, but you didn't make a reply to prove
> otherwise.

I explained the commit cover what it is doing.

>
> I also pointed out it leaks memory and you asked for a test case[4],
> but you made this pull request without giving me 24 hours to reply to
> it.

You keep bringing up theoretical issues. We have passing test cases now
and we have plenty of time to address any bugs we might discover. But
holding onto these patches is slowing down other work getting in and I
don't deem it a risk to merge as is.

>
> The situation of "[PULL 03/17] tests/tcg: make aarch64 boot.S handle
> different starting modes" is also similar. I added a comment about
> symbol naming and you gave a reasoning, but I didn't get time to
> review it either[5]. Besides, I also had a suggestion to make the code
> shorter for the past version, but it is also dismissed.
>
> I also pointed out "[PULL 11/17] ui/gtk-gl-area: Remove extra draw
> call in refresh" has an undressed comment[2][7].
>
> I would like to see improvements in how comments are addressed before
> a series is resent.

No - I'm sorry you don't get to veto a pull request because it doesn't
meet your particular standards.

I'm happy with the other review and level of testing of the patches to
put it in a pull request. I held off the other well tested patch in the
series out of an abundance of caution but will keep it in the
virtio-gpu/next tree and re-post once I've done my next sweep for my
maintainer trees.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

