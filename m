Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53262CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBSw-0004yi-3F; Mon, 28 Sep 2026 09:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBSs-0004yO-Mp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:32:18 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBSq-00089g-PH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:32:18 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-66f7f72a284so2812466d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602335; cv=none;
 d=google.com; s=arc-20260327;
 b=HIt2KSP5KjREmnAobaXpT0jkb/5v4Gs1xSM6wQqB+OQK0wspcrl/Inv0JFzbVdThFa
 B+rH2bie8EdA7/4JwdDQbaPH7m25UC3Xtj/+9eeFY4SuNI5HZ78GuvY/XNaua4GAPChS
 D5rgAyq6gGXwH7mZoJQ6//I/qm6wGEydgh2mhODI4ZW96QQ19/ejXdUPPS3bGnCyIO83
 iOorWD/cUGDYp9mGw+/Rp+2soa3FMNvjVLj8tgD7PPso0YSSL/vrpTsKus9wqQpDyEtn
 n0KzicQYkZUkCiQ1TvtRBMDWlregg6V7gwfzIGFY+LDJEEuERYSAXLk3OM4ucrM7lVJ/
 9MYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S2x4BjPysJO/R7Swhc9yotr0VmBgmUO5DB5in0JygH4=;
 fh=dQ04WhdsNjIRQ27j+hjNVEa+npVsWRYfI6T7SWWzDBc=;
 b=pL94KA/49VjMGv+k4EPxKeKj0LJKRTW0pLWb2K8/QO2wvDWq0J6rypVGUGC0A6GoXR
 o4GWtp6x3eu/N9c2M1xWYUnlBXrlxWlRM8ekXT5Zs7s1Q3i6K3FmwoRcuoI4MX5NNbsi
 8YFlQWbaULuTEwhXvmNy2YJFwttewn2wekJ/H5EsH2DaU7twworJC7N0clnPFgNlPQEw
 vyeofs7wtYy9FJQC6u11Q/7t1eay4qS661iDWI6bu5ukYyaZMljjzFKpsQC5FDlMayfu
 /5soAy727qUO+lrqHUEcisTyflcI4DcHAMLjE+MgamvD5vnxSu6ZXvAEbB62eLn044AR
 G1/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790602335; x=1791207135; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S2x4BjPysJO/R7Swhc9yotr0VmBgmUO5DB5in0JygH4=;
 b=y/4uh0lxRy0Vl4GqpHvzIVQAZUcMSNaJtfdVd9MBX8roKIiAR0C2vPV7gVQb9Lsqog
 hqMUWUtDLzww0WOElN641jZgpf4w879r0YQuQTnvWyBHB29YVoFZtATl2PnUcg7/JPvS
 oi/nVsnFaKxHzr9Rb0tWQ/1ZB+67T6C6+YOvgDVGYpt5wucKrf8QtADyr/T5koQHQji7
 ri4+RcMnEXgBxjeWrM8TdDZkpogm8E0k5HSJ/pS4A9b1KUzZuwEtOdtKsTUFXqXjOBhs
 1Z0oKNQnVJS+NJEgNl+QUWkY/6AMFxI/kfqV45SFmjdiiTIMCLWuwy61RU1ypFG7n8q6
 koRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602335; x=1791207135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S2x4BjPysJO/R7Swhc9yotr0VmBgmUO5DB5in0JygH4=;
 b=WLw5t4dOPNClmhMv1ikTXjc+nL0B5ePYBNikHzaNS1YirMxNgFUlz00xw2ztLp78ex
 +t78+/Kyl9wg9csSWLzMKfXhwrPOMwUYQFzT51nxIKCRfe4l0wyY53z2st1qOR3kn7dp
 SDUWOMKW0go2xeqetnMbbDgS3BPJT4cgq0KemsE5OGpxVx4tDmg7lQt7maNA8GDz+bp/
 Q8nBVnlqRImxUQJXfkckjGvRSpC7P9VtWPavs9tdOEl/04wbjVwL1PkKNQuKKQBe5til
 ncXGEC18SmLkT/G4F0nyXb7m/7cC1btzSpLNmeXA1zp2S7G8Odlhb0MxVJ9dhJ47GPmT
 i3HA==
X-Gm-Message-State: AFq9FYIoIBuvXrxjrlnObzC/yiuw/D9qQ69hYj9IIxAlMi3f8ir1pcmi
 HCvI7CDQL+QFnm8Kx5ONZ0PBqE6nRFezx6u6f8/+xEsg3opjj6T1KEozt+d9AXgEF9E9gRFUtOP
 P9YFxIOafgt4WkPLcw0DoQnVsnZQ4VgngiwAi2BuZJw==
X-Gm-Gg: AYBFou0fLcMmNnDIMBdkiBlWgZmA2ciqIvnjf9G0RXOXgObr18Al39ZhhbFWGTnYp/L
 sWeLSjJAG+HYnWQ9oQKIIp3fI7S43xqOxJrXRsvMOEKo7IGXcktDY3ejA8Xhq7OMac2C8M5D+3U
 ccgwOMHi9icPmGr7ZIeqPCKHxK3PD0h4fTCSSAe+rI8PIeSaT4oRNdEnCWVGp4jOJ0/9DlZi9iw
 MTPOt1WwdV5dw4eIQo9iCA4kZritAMT0hwjHTLtNKPYtyHrbS6k729xoPVK7aQw3okvzC3FDkj3
 K27BKrVEMbPBwQrDS7cli7PIlFStFY+U+ux+WUSzh5iihWaK1hjMGabfjlQRDBtLqSiabtJ/ohU
 f9gR5xr+Hd63WcdmbU61djfD0IJJXZDXMUebcvXnU
X-Received: by 2002:a05:690e:dcc:b0:674:167d:4c8c with SMTP id
 956f58d0204a3-674167e32ccmr3144554d50.103.1790602335414; Mon, 28 Sep 2026
 06:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <178983644340.22135.11298603231632238119-0@git.sr.ht>
In-Reply-To: <178983644340.22135.11298603231632238119-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 14:32:03 +0100
X-Gm-Features: AclHuK8spmh6a98nThSv0xBzDsOthcC0wyCC-u-fF7cOvOXEZhmdXem798Yn2K0
Message-ID: <CAFEAcA_+BKABAFeTLgacVd0Q0TMxyD=2qyZn_+ia_6u232icag@mail.gmail.com>
Subject: Re: [PATCH qemu 0/2] hw/char/exynos4210_uart: fix overflow in fifo
 implementation
To: "~jprx" <jravi@mit.edu>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
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

On Sat, 19 Sept 2026 at 17:47, ~jprx <jprx@git.sr.ht> wrote:
>
> The Exynos 4210 UART FIFO implementation suffers from an overflow that
> can occur when large buffers are sent into it. Specifically, this
> overflow is caused by the underlying circular buffer implementation
> making use of a store and retrieve pointer. When implemented this way, a
> circular buffer's capacity is 1 less than the size of the buffer, but
> the code as written assumes the entire buffer is available for storing
> data.
>
> If a large amount of data is sent into the UART when FIFO mode is
> enabled, the FIFO may overflow before the guest has time to receive the
> data, resulting in the first part of the message being lost.
>
> This patch series includes a qtest that demonstrates the current
> implementation suffers from an overflow that results in data truncation,
> and a fix that switches the Exynos UART FIFO implementation for fifo8,
> which does not suffer from this problem. After applying the suggested
> fix, the test passes.
>
> jprx (2):
>   tests/qtest: add test for exynos4210 uart fifo overflow bug
>   hw/char/exynos4210_uart: fix fifo overflow

Applied to target-arm.next, thanks (with the tweak noted in my
reply to the second patch). I have reversed the order of the two
patches, so that we fix the bug before adding the test case.
Otherwise in the git history there would be a point where "make check"
fails, which is awkward for "git bisect" and similar operations.

thanks
-- PMM

