Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C745C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBRS-0004US-Mi; Mon, 28 Sep 2026 09:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBRO-0004U4-RZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:30:46 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBRM-000848-HP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:30:46 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-674138cbe59so2122149d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602242; cv=none;
 d=google.com; s=arc-20260327;
 b=j19kDzj3GH59jJH6KQ0K6JxkWbb3lZkQbbWTkFBtPnf/SQvno70I9AdeezyTNxSXP9
 jumnKCz+4eJPo6PHK+to2vVBzYzQ0ifJqfgGOhaXMHMiJJOx2eSSQBJbqZEFvIPRiY5J
 jT1Nrsx2yjP2EjkgBaONae7oDDJt/DP1edk4JezSwzXr1E1IclLq5OEKglyVvWn/GAc6
 tLQbQ3dThwGK0q9PAyicXwRvPCqKPc+zMAxkBHOFVLC/gtvpfTVTPLKkLxvpyn4eoR1y
 wmTg4js8Waug4GS9auhPzXeOCTDafckOk9eqt6nV2eR1X8WyIXpNxuSDXqonpy9ppLx3
 3Oyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F61TigGnQSYhF0wVQMn6Z/FYAGBBgBYsjxIbXVVaoU0=;
 fh=dQ04WhdsNjIRQ27j+hjNVEa+npVsWRYfI6T7SWWzDBc=;
 b=LHeOZlEMomLgfKnftxG50E8ZvWml3V8NAYDcSTVjhOLG6omjDPQnGHplq0lF2WttOL
 JIh28pezd0koE6qs9VPljK+wAOlnzsp62yciQbbLo66+uMHijhhD3cO6v3BzBXhdM5aE
 0pJfLgYI0krEoHJFEVOlYesh5UGs5EaH0h/XEy0kln5QX2YKvnvsRYwPZOGoZ4ihnxtM
 A1uI3fe4k7lwNjPEIKX/zyGl2UVPQqkiJee6EMmuyY+If184Fv4P6/Ikuq6vslo8HkZU
 RU40T/ngq9aiWyw+Os3KaMdF5hqig0UiLGn9TFRI4x5NeQKNAXlgQXroOiJImg2jNBu4
 LcPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790602242; x=1791207042; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F61TigGnQSYhF0wVQMn6Z/FYAGBBgBYsjxIbXVVaoU0=;
 b=LDtmZNHtjw1ui2tsqwtpIbskx0x8klN/3LOj0CniGBc9xaIATpExDThdd86dm/i05i
 2oYdraHSOz5GRXPP6bvbpfIU/xs42iED202fQMSgSb7n8eyl4aF0JfsHQadrW9BJIKZm
 PQU/rW/4Iq/+ZpeM0KVz+hhQQ2p/hz86J/pmxGCsEQ+ygDtxSQHfnTe433AoCnKRZGnT
 zhyzbJ8XdRrmNG4WKMD7HkC39cdjON1yIxz3a8gFtbOllPB/IoAdNCyAGhyx2DuRF3EW
 DX8f/8NUUHDJDNuBAva7AAMbwvPUOJfoq4GDMHspSE8A7NXgLEX8rGHSZwD+gILk0OCk
 CVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602242; x=1791207042;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F61TigGnQSYhF0wVQMn6Z/FYAGBBgBYsjxIbXVVaoU0=;
 b=CPtiRLi8wGZHnEPgLBDlfe5aR6DFxnVbRrJAHWIiclVbRmhnB/6G0JyH1rr0/gDxR2
 Hl4DGbxFGqBsqby1l/aFZPHEsMrkuqPoZHeYsLt8gJIQyj/5xGBxBhcpQTxtGQN6jRXX
 X+lHLp1WXZv9E8ghZMYa0p3w56QcN7y3/u0eys0XfL9EDpxtR1/11314aNNJLX/rQyax
 0r23QHuVJQCJwVOSdqjyvsUqwQqhvmcmYTvcNBIEQyhHHM2mJvHFzNBFzhuKgUXZdMW+
 loh+iRVcOwcaWvFdu9dJ0uOCYFzvzxKQxU8hKC/l0izTEg6iG6mlt2J+7ZcB7O0E20rR
 8eCA==
X-Gm-Message-State: AFq9FYIo4N+UnSqMZRkWPtfzlujX+RI64eKbFIL+PLISOodLXNfSAUqm
 Ar6bMpeo7NAEThiH26/5xbYRBd8LbP0pY3vMIElgLJLZTs0t9haEXSRltklV4kjD0TKNSnC9MKH
 +OoUGxYEHIN4uaLaFI9Ejx49ScI33InJ6h6A3k4omTA==
X-Gm-Gg: AYBFou3XfBi8xXUsfMUwscI1Mhxv0ty/DGbIxrkAeCMkMChRMdH2jCpBu6GitxxBQ+z
 sTDfYVC8Kaof2W8xtPrZVoilQFbrccWdTwALcpMegoPFCrsxtQsJZf9nffiw7BTDa9XFOTETtMA
 hEuMaUY9tvWw0lq2QLuoFIAQf/5dYQtoM80ewgCWx4hGWaUyeIQUFC9bJtNTj3EhjbY/vxeC+25
 +9QQ5iff/0VkFP2KP+CckhfhbWLU/PuHJakW8nVYrokUWLL54tRgJVqOp1w/v6Le/aKhOMex7IH
 4tTCvp/nx+Zn5Wkofp1kFCV4EQg22aGlPQrEIZfPIt3+mxrvgeXMX27FnAvMQ5czUy0LqTuNgxj
 qv640QRHsRu6bgVykaibRnSeqzMsnqCNOVkY5OJs=
X-Received: by 2002:a05:690e:148d:b0:675:4453:fb45 with SMTP id
 956f58d0204a3-675445405f2mr1366862d50.16.1790602242046; Mon, 28 Sep 2026
 06:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <178983644340.22135.11298603231632238119-0@git.sr.ht>
 <178983644340.22135.11298603231632238119-2@git.sr.ht>
In-Reply-To: <178983644340.22135.11298603231632238119-2@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 14:30:29 +0100
X-Gm-Features: AclHuK-Y2UKJo6WZXmQDaSE5O3SHJlovVSHlpIt-ecOAGy96VYCb9U_rMNbHqus
Message-ID: <CAFEAcA8W+h+0G5fqTyzOvbLss7_shkQ-OuDGgw867O=WPB5THw@mail.gmail.com>
Subject: Re: [PATCH qemu 2/2] hw/char/exynos4210_uart: fix fifo overflow
To: "~jprx" <jravi@mit.edu>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sat, 19 Sept 2026 at 17:47, ~jprx <jprx@git.sr.ht> wrote:
>
> From: jprx <jravi@mit.edu>
>
> The Exynos 4210 UART FIFO implementation uses a circular buffer with a
> store and retrieve pointer. When implemented this way, a circular
> buffer's capacity is 1 less than the size of the backing buffer, because
> there is no way to disambiguate the empty and full states (when the
> store pointer == retrieve pointer).
>
> When exynos4210_uart_can_receive is called, it may report that the
> entire is buffer is available for receiving data, as
> fifo_empty_elements_number may incorrectly report that the FIFO capacity
> is equal to the entire buffer size (rather than 1 less than the size).
>
> If this happens, a full FIFO buffer's worth of data will be read into
> the circular buffer, the store pointer will wrap around back to its
> starting value, and the FIFO will reset back to the empty state. The
> next time exynos4210_uart_can_receive is called, it will report the
> entire buffer is empty instead of full, and promptly allow the data to
> be overwritten before the guest has received it.
>
> The consequence is that if a message is sent into the UART (eg. via a
> chardev) longer than the FIFO's buffer length, the first part of the
> message will be lost due to this overflowing behavior, and only the last
> part of the message will be received.
>
> This patch fixes this bug by refactoring the Exynos 4210 UART to make
> use of the fifo8 implementation, which is implemented via a head pointer
> and length field, and therefore has capacity equal to the buffer length
> and is immune to this behavior.
>
> The Exynos 4210 UART FIFO test now passes instead of timing out.
>
> Signed-off-by: Joseph Ravichandran <jravi@mit.edu>

Thanks for this patch; as well as fixing the bug, it's much
nicer that the device is no longer rolling its own FIFO code,
as demonstrated by the diffstat.

> ---
>
> One thing I wasn't sure about is whether we need to save rx_capacity and
> tx_capacity in the vmstate description. Since these are linked to the
> rx-size and tx-size properties respectively I wasn't sure if they need
> to be saved explicitly or not, so I didn't include them.
>
> The only place either field gets used after the UART is realized is when
> rx_capacity is read for a call to trace_exynos_uart_rxsize, but
> otherwise the capacity info gets baked into the fifo8s after they are
> created and should be covered by the VMSTATE_FIFO8.

Yes, that's correct -- data that is constant for the life of the
device (which includes most QOM property information) doesn't need
to be in the migration state. The receiving end QEMU must be
configured identically to the sending one, and so its property
values will be the same.

We don't migrate the tx fifo here, but we didn't before, and
the code doesn't even use it, so that's fine (we would only want
a TX fifo if anybody updated this UART model to avoid using
qemu_chr_fe_write_all()).

>  static const VMStateDescription vmstate_exynos4210_uart = {
>      .name = "exynos4210.uart",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .post_load = exynos4210_uart_post_load,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT(rx, Exynos4210UartState, 1,
> -                       vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
> +        VMSTATE_FIFO8(rx, Exynos4210UartState),
>          VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
>                               EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)),
>          VMSTATE_END_OF_LIST()

This is a change in the format of the data that goes out on the
wire, which makes it a migration compatibility break. That's fine
for this device, because we don't use it in any boards where
we care about cross-QEMU-version compatibility. But it does mean
we need to bump the value in version_id and minimum_version_id here,
so that if a user does try the cross-version migration they get
a useful error message about the version mismatch rather than
silent wrong interpretation of the migration stream data.

Other than that, this patch is good. So I'll do that version
bump tweak when I apply it to target-arm.next, to save you needing
to do a respin.

thanks
-- PMM

