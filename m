Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A481CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnqD-00039b-2x; Tue, 26 May 2026 05:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnqB-00038z-Bm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:12:47 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRnq9-0005Ll-UQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:12:47 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-65c3ea2ebf7so11156393d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779786765; cv=none;
 d=google.com; s=arc-20240605;
 b=WN96qzBTxBppwECmVFtvxsO0sewHXk6Kyxc6xFIDK1BSBYebaQ6rORuzSm8s07/4Ol
 tAbzTfNDdesCB0uyuRGCa3+x9GRlW8UUl5ifynhYMEn31fVI+HhshIPPrcvFvho4nREh
 ZnFGTJiugeB6p6NeztIb1meM2cFj44sy8A3J+jP2mPcwpyjjCsRcJ6eeXhXdG4LzRQBn
 kQoVfSRKtpIz+6SrKeQ56oMPj8jFnUWdo/y7k/15a3IrLw12zJyDM1KvMGcbEdhYS5zl
 +yKdOwR+a+yktQShV3PCrW38uTTmKc/BUAT+cQQZMYD6hGWWCV0Dgde8TlCX+AEjwDHE
 4kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=HC8+meO32OsYOz+jIi6FNlPmw27OhwMZkgLT/F50Vbk=;
 fh=LFJK72Gi9kspAUivhTFeh0BJIMBMnaY6jXIBCnsw8yc=;
 b=cmXOBVtpMbntxpLr2OF8bp2GBWY6aHk5+HBDXvkIQyhNxINexPUJOUsKqEyrQKwQZ8
 BSxVvE8fAbCFndknRiP7y+oUbMit6xovYGKgtqItMqwcNCr7ek+sQeI49HwZXFAkk6MH
 c+/2vibV4ACznWFsd4Grds/t/NTNHvNcw4xQLrfRdCp9SniuUH8Z6NIPvK0FMHWCX7ga
 7t+ePcR4iebVsdK1QU4GsnliUsitq/YYE8WtwQVhX+0DyIrPnxPw/If36S+MZEBOIcRv
 BWYILRF4YbzFqe5k57tE4GDiMTLDgy9GZZZKa7riCzLW7OS4WdQlOSC4Ki7D+xLY3Tf7
 OL7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779786765; x=1780391565; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HC8+meO32OsYOz+jIi6FNlPmw27OhwMZkgLT/F50Vbk=;
 b=rIxVkQrFFPylfmBWlSgXsvJk8KygkwD9oSsFDoGCUUQ8IWMy0k3AzBushl58O5q/0K
 FE4UJCM9gFJqOd3zVMtGuIj04y+agiAxmKItIX7JPUsqY5Xzkckvn1iNujfyp1XoJ/8S
 tJalmWtZkwQnr/ai48I/U2ASbzsKZfWAOsFjohID8ZMkcec/3BKtybheDMT2I27bWFa8
 f6bR+FAlDfU2RgqfyTU69KJ6ujwRVDPEu+wfZtLQhnPgHGoEhmC2YzfMLLKYbWyGMgaI
 gBIfyHnV/UMbTDfidTlkjH2T7hO4NDI0IfJ2WzVCkT56oFQZKayLpmYlpYG81mFDvnGn
 P1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779786765; x=1780391565;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HC8+meO32OsYOz+jIi6FNlPmw27OhwMZkgLT/F50Vbk=;
 b=iBMT+b7ArkkdH/B3TCAp30KnXy1Jdcb6s274oCB/dbcqNUq7bWuZ5couw9K2cV47bq
 u4+Ulvw2htdh98Gk+jlehHdEVl7A9xNVpMZogNy3tW/D0NKW+s1eq45mDsNRPNWTVsu5
 g4cBWcyDHxxjOa4CzVAxjTEp4m86QcIAZK5P7DsTdRusFrN+qpiRZfKMKgLHr4zz6+Au
 Wqv12zOb1faJNTCgEqNXoIChQc4IuoK63tsFLZPju2d/p5fR2ml/UvYl604ETUcQ+WRW
 wPyJbeIvtmdQcSJk9iIDz21X2mvqT/fqovVEBNj/2AxJvOTwL2LZkdtQg9U39JRVBxSD
 KSwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kMQNh0Rww3oJz7ntdpXEOzYgAU2UW77fFuDDYoJXbaHP61P79SWkFSKjOMKqd08TrrVUkrc0L892V@nongnu.org
X-Gm-Message-State: AOJu0YzSJG0WRRqfA+zXgdBFr2BfgUzBKj+kKiwv4pP6BQwjFYSENRVt
 rz5wihAii1q73IA7n1Q2WaGlp9sSIxZnx2qFrjuwOZ142flAUI7P3963UgWjIPQ+MljIMKUL+et
 /IZVtr9buTlLbogtn6Sw+NJcB/P4cdyrqkrSKvZJpew==
X-Gm-Gg: Acq92OHFy28LDI2Y/q7plzuekxEGkgag9H+bEUiwrH19Nbu1PpmiutqiQXpt1EIidC7
 hRIsrhndCSUrJid8QNSJjGWyY/xqxZMkq381PDSon3Ducf2n1X2l0zomV3OYIdbBgqpxVlx6QZd
 RH7C/h930PMql6bA0v6Ewqoy4ZlqjV/2OPRCkbl5+FiZYzJ5P+t2GPzK47o2l31YnW0fCrV8kCi
 VzGE/det1/s9UJJIqCvcaKUaUMGYP+9Hkb9efvaXiyOl5XVLxH3fouvGwl2/F+zoRtDTkps5i/d
 afuFyI6MqrEC/ALD5rhtcUvSBDxbx44H+igusfIigYPZ108t8+HutvusR6MEGlfIrZU8NAKtAf0
 kpw==
X-Received: by 2002:a05:690e:4814:b0:650:3bbc:5375 with SMTP id
 956f58d0204a3-65ec97ca8camr12366599d50.17.1779786764743; Tue, 26 May 2026
 02:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 10:12:33 +0100
X-Gm-Features: AVHnY4JqbqpkaNYyzcpJbGnX2qAgK2vNjkBt7KywSQYX4in5oVb3UDhblChR9OY
Message-ID: <CAFEAcA8NnS99cGdAXja2Rssj7chS82iLX01WTzKxWxTUpxfG7Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] arm: OMAP: Remove some dead code
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 12 May 2026 at 21:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The arm OMAP SoC code still has some remnants of support for other
> SoCs in the family that we used to implement, and bits that were
> there for features that were never implemented and we're hardly
> likely to implement now.  This patchset removes some of that dead
> code.  (I noticed this because I was looking at the hw_error() calls
> and realized they were all in code that was dead or otherwise not
> needed any more. Then I realized there was actually quite a lot
> of dead code here...)

> Peter Maydell (12):
>   hw/arm/omap: Remove omap_mpu_model remnants
>   hw/arm/omap: Remove unused omap_mpuio functions
>   hw/arm/omap: Remove stray unused prototype
>   hw/arm/omap: Remove unused omap1_dma_irq_map[] entries
>   hw/arm/omap: Delete unused #defines
>   hw/arm/omap: Remove unused wakeup irq
>   hw/dma/omap_dma: Remove support for dma_3_0 and dma_3_2
>   hw/dma/omap_dma: Fold omap_dma_sys_read() and omap_dma_sys_write()
>     into callers
>   hw/dma/omap_dma: Remove omap_3_1_compatible_disable flag
>   hw/dma/omap_dma: Remove 3.1 mapping handling
>   hw/dma/omap_dma: Remove unused ifdeffed out code
>   hw/dma/omap_dma: Drop model argument to omap_dma_init()

I've applied all but patch 11 to target-arm.next; I'll resend
11 plus an extra patch to fix the resulting misindents.

thanks
-- PMM

