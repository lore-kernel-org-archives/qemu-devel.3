Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40127CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIlq-0001rs-CW; Fri, 08 May 2026 06:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIlo-0001rb-MK
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:49:24 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLIln-0004XZ-0i
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:49:24 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso1815178d50.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 03:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778237362; cv=none;
 d=google.com; s=arc-20240605;
 b=jtYn5TFMoKoUphXFyHKrT03TzryXbEby9gVH0gic+On/ydBv9b/wNK0R6sMN2L5KWz
 EkrzuVC3kUof2eLfU3rZN6pxv7N0h44tL6P07ZqgGJEwvmnzWbCCLUGlG9K7nlJDShO+
 iQKk4c2hO/bO+HcrhCjC6kw0ud/hqddmPEGEFvYqBXbhWvAWEUu0+7mbHb3oQ/8btu0L
 1E5MmNgfxP6eUXycxG6OblZQwpYQUSvGFbSXETuTNRMh9tg4jvNCie0Fw4EQqhkVifLN
 rHdtP2Wef90a9z2DXw6FU/IevAyb5irmucYvmQpv08lcHtipMuD4y7h7cmyeoSdTIJEx
 f8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dbZbNhF2u6vhismLnOkuiWcCB7Qfoh7CJthKaQVIEo8=;
 fh=Ayn1XhkevTPgTEqyOLu95RHd3TUepZKYCfpV7siXqls=;
 b=Vcn2hdHyUD5zACM1ihi3rsYWXgvDs0vjhNDkvgnLop/jYB5r5aplPm2aVkMT6uzDfn
 x/khtKHFbr8jhv728Jyk0CZ2/hEBJ/nxnoeNweNYty/P5YWw8uc0bKZz9QdvmJY7NQpZ
 UMAWNFlMQ8r9vTA1y4duUeSems0wUjpBFQgdPskq0ueU2vQVed55YRrvfhnEmYAoifRm
 rPONjn9EgfMm0WTl5QTPD8LhRpIBvQIXCxAm6vHU3yZdH8IJp1JBnJFmscfHPRAmX7Li
 jARG72ujLAXK8NT7/HqY1nky/BXY8MqzkIDZA7UNFsfktqs/uAynHkmbPK7xPQqbknGe
 cegg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237362; x=1778842162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dbZbNhF2u6vhismLnOkuiWcCB7Qfoh7CJthKaQVIEo8=;
 b=wSHf390v9JqVjF75gGeWpCUMNtK/0Lw/9NxG7nykkjjcswv6/ZNlfwGwt5554FBCCW
 Z418+3aTGP/7VBrlLvuiKremZ5+tISrnoOOqwL1tqw4xnjEPATrYDbmhwys0EN51KEQB
 C1nQw5Ja4U/T2GiHncjBR8V3QJ1a/Cl+YaEG9quMRD1Aq0g1ZR82r7v2VaEtZMfvhuJJ
 aBWxd+l2VU2AETioNxRmmjorjIX51WcVnDwo84JMQiJowUBPAaYCRSZr0GS7ImaJNrue
 1BmM7v5trhksdxR3+5WWsUmy9ZW+PmMdml+0RLReUWYTAwXHw51PVyzGA9Ly62gEhqj1
 v/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237362; x=1778842162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbZbNhF2u6vhismLnOkuiWcCB7Qfoh7CJthKaQVIEo8=;
 b=ETy2zWyJ6M8QrNwCw1Qg6W+rINuqbySc8vx4vwOILr4UIsKhSS1zmCvFuVE0/Y/YMz
 z1TCL1gn+fok9eQaD6I8FhheWH12TwO6stfySSj584a4IC46mb1f6A4pJJmfiAXUrXeA
 GhzZXU4Dk8w2+yDvcCufYnoMKgMYXhnPeaDfwvlEPIaIiLVZKs6buRFchXMp9CLTObSP
 Sg4sK3a1DlKLx5okNRqwer+zssPs1+AaK2ZGsErIHN51ucYH0jySosqDEvfpuB/T39wy
 FDNNADKugI1M3nrGPhb42m95EwOux4bexbIZtMVOM+fUO6zWqbEtNqVfjpf3C9gsjaSz
 2JcA==
X-Gm-Message-State: AOJu0YyPM1kaxavBgmpfNNYIdQsl4KHBArSvcEnstYxON3cjy4tndpfp
 oxA0hrbgb1yIEtnFs5nzKWT4/1kxm83/ZhYMSswK498CDXHhf1mPzf8ZOxIeXaVOQDDsd7/B9pb
 yuQFfKFSLNCW4jf9nkdqXIB1j4yTvM5No1G+eGboGnvvmBDEFW5St
X-Gm-Gg: Acq92OH8TgYy+3NJb4cg+TFVtL5I0rnEL9yOQNfsZH59IIcPXX93MSRjVY43c/KjSLQ
 cLrRkXy/mmheYD4ZCBzAVYYJVHLkq1W0zuUgFfQpO51GCvIZnHHMivxNCJZYGB8bSTMEP0C0p7u
 rxdtBVeKChSG4ZefRAJ3NzRYFqwSu84CJ/wEj/1IpQlIb+iO/Xguc4zKX69ZbLdPrYDE2OhvXG6
 6oOn/KGFT5etFy1J2Y3U37cnr3u+7JI1zzQNAAWTUxtvHgGBQOttCvPhOt58p7hdX3/cltJqgh1
 ZcG1RTVbuuxwUH3xKYuSgx35BBjnPoXutQyt7TcMok9x8a9/9R3nPMJ3tiWoyAIcZS3nEwXeaTp
 LXj9M3LcGUIQ8
X-Received: by 2002:a05:690e:12cc:b0:65c:2ac8:ec3b with SMTP id
 956f58d0204a3-65c79b24716mr11420122d50.17.1778237361598; Fri, 08 May 2026
 03:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260508104723.2144051-1-peter.maydell@linaro.org>
In-Reply-To: <20260508104723.2144051-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 11:49:10 +0100
X-Gm-Features: AVHnY4L0Wj4J1fKzVGuA5vJiX452idSrgYsV-yBMQrEFEymNSEvkRyHK9490hpE
Message-ID: <CAFEAcA9LVvBz-kzw0Q+G=w4_XiituwQwNj32s9ArTRg3h=NQxg@mail.gmail.com>
Subject: Re: [PATCH] meson.build: Add -fzero-init-padding-bits=all
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 8 May 2026 at 11:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The C standard doesn't always guarantee that struct and union padding
> bits are zero initialized, even if the code initializes a struct.
> For QEMU, this is potentially problematic, because we often have
> structs that match data structures in guest memory, where we
> initialize them and then bulk copy them into the guest.  If the
> compiler didn't zero init the whole of the memory containing the
> struct, we could potentially leak random data from the host into the
> guest via the padding bytes.
>
> We already use -ftrivial-auto-var-init=zero, which will zero out
> padding in many of these cases, but -fzero-init-padding-bits=all
> closes some gaps, for example cases where we initialize a
> variable with a struct initializer, and cases involving unions.
>
> Follow the Linux kernel in using both options. Compare kernel
> commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").
>
> This option exists in gcc-15 and above; it's not supported
> by clang, but clang documents that it guarantees zero init
> of these cases always:
> https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
> Older gcc which don't have the option behave as if it were set.
>
> (These options are passed through the cc.get_supported_arguments()
> filter, so we don't need to do anything extra to avoid passing it to
> a compiler that doesn't recognize it.)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> CC stable just as a precautionary thing; it's safe and we
> might as well make sure the hardening options are set there.
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 5fbdc75a0f..d3df10eeef 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -684,6 +684,12 @@ hardening_flags = [
>      # it harder to take advantage of uninitialized stack
>      # data to drive exploits
>      '-ftrivial-auto-var-init=zero',
> +    # Ensure GCC zero-initializes padding bits and trailing fields in
> +    # unions. This avoids potentially leaking host data into the guest
> +    # when we init a struct and copy it into guest memory.  GCC 15 and

Whoops, I meant to say "GCC before GCC 15" here; the commit message
is correct in saying GCC 15 is where the option first appears.

> +    # clang don't have this, but they zero the padding and trailing
> +    # portions of a union by default.
> +    '-fzero-init-padding-bits=all',
>  ]
>
>  # Zero out registers used during a function call
> --
> 2.43.0
>

thanks
-- PMM

