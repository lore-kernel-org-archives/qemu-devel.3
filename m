Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592A5C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BJU-0007YA-EQ; Mon, 14 Sep 2026 14:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6BJF-0007Ti-Mk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:21:42 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6BJ4-00062g-Bx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:21:39 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6714595153cso98823d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789410087; cv=none;
 d=google.com; s=arc-20260327;
 b=ZDgvKQvAN7Y+oswXaFS6qQNNaYcATVyd7SbL4ArHpPKitOdKj9f924n5xJDSjOww74
 emF9zquNL+qClfU9O2RBlCbSguMhmRVJOZASUxv0pkXyXzmwAn89ommmeVGjrtaFTXja
 Yx2TbLys4lFd022DqYdcXStu0ZR8bYW1MuzwIETt+3K1oN5Mhj37b1+t5LY2DXZXRY7V
 c+WsNIYbax50OFdFWD0bznPjCX0pl3/zrAb0NI5RtmYD46FOZ60ivegPOM49aHDj1XgP
 UKlt/YmUp7y5kJFAL9Z7uy9c7od8AY1Ze7kx9LY71Wp8pDUcpqrt9//0WUQ/k++GnUEy
 DMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gJIVwsqYH2Ah5mcekCYPyLfQfKzQzbJsGOyIhIdz7PM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=R66A+5WmAcMe9k1TipCWHiwWCO5HMg/1UTKmXC2RrDiz3Dx9idBR7jqzIqyRqaVCCp
 RVPMaxlhc4cBHNRmE6rmqgt4JqBZj1KIcS/mkKXMh55FcKkRDpR67MDq3ll6OstEls+E
 4b1wZaqdbIwtLXCblT/pn9BDFvdMpJt0AgFxl9ag5MTRZjAuH1WzeCeG7w5k35y+MAdL
 h7tnwLgGr9DA1jb/ZCfJFPT4py7mt7j7OCvsCTaGK+2dJhOuvgbjYw1ND2wMSzV0kWPT
 FZYpohcgR1nLhau/9Z8AiayROsNgaCT9JJbzQDEU2TxsT+iyJZ8Dgy4bmbl0JDdI/bZ7
 bPdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789410087; x=1790014887; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gJIVwsqYH2Ah5mcekCYPyLfQfKzQzbJsGOyIhIdz7PM=;
 b=eP0R7aPKYN6KGjf1V5Ogm5rUEErgauawJZFqFXT0k2sdfnVspPt0RjJAjbSdI4Mh9x
 XRjWCyqxX3P5olz2LPBYBM5ydFhNpUXyLcKkMkqBKNecJarcypHry4JvtQj39vR1bwJ8
 rv5Y+EjgpH4KfAWbPaxGXOikpN6rb1t85CnYLtlDjHsFN7Xd1afjPfXWfuD3LEnwFB6y
 ch5iNuNJcFBZh2htKVCrsaqz7qt1Hih2Frgq2r+mWDU8kuR0hlMMyJ0IhEW+yOEkwzYd
 s/yv+sDiAkryafy5y1P10fuIYA897XhWiEJwWPKW/MqNUN8Aamycdid6BlW5QaHAfcGw
 70fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789410087; x=1790014887;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gJIVwsqYH2Ah5mcekCYPyLfQfKzQzbJsGOyIhIdz7PM=;
 b=bJXHAOa9IgQpVdVLDPfIWHD5fXaa/BHMAk818ub6LSPdCtjwqdIaNvrrJGhz69IROZ
 9/OBvmlfsA4UO9H3XXDuLPktDo/QYse1jDrhyA8dwD4SDVCRg4KoAG0w14gh4N9rnS6Y
 mnnyC6PPyPNH8ckjNxByVpdgeEynkvnUltYEMw5WsusR7jjZ2dVxKpZf6vqBQF55gg36
 UCVcocfVd9EcDTMPDbRCPpYVH+lb0rgmZV2Gll8d40Jid8/cfUMREpJczklA1Iyu6w2o
 yYR1cCD2KBkMHNKXLFZdjOmA6Px2/YqXoOuIDqEqjezZs9FGQp5mtr57XTZoETY3gZsM
 dAcw==
X-Gm-Message-State: AFuF++kfv9/EmNrDmpnTeSTiphd4q99D76+9NiB7wCly8SifLxrv9ex6
 bFXghf7i7/SYmsrqcFHjywUOBXUCXC09tCojO/U6L+c1Zj7Ni9/qKOv9VKpwyO4L6e5EzRXcaLh
 r9MGTZcyTez3LwuVlWXw0jPJlZr9Lg1YymQpJiMcyvQ==
X-Gm-Gg: AYBFou0dSYhuDTqe6ONUE+qssmcU5hqzgp1vM9p2TFM/YrPjI5EJVL2Ji55eRxyCNvq
 GiWDt8C2LSJKmnBPRNrUSrGxubL2Yoq4ZgOp28lvWkZhu7rUC1Mxg4QnXE1r3G/1+JFc/t5KyMs
 UHCUmSBb2Xx1ePjbmlihdGEhl7cS7naoIWFYN/WgU0tPOEg2lgGzmV1DRARph4xGhhifB/YTfrw
 2DNS+Pyc8AYZ05vpFQlx5dO8lzifBQqAIWwqLkbUBOILOCirTc6pj31Xt86nf0Wu4Gj9fGu1JQP
 b224nFJlvwi9g8BssHXXk26FztzTUnWRUg8YBqIcC/D/8aBABQrKhFyT40zVDl27Gjv9S3kWovJ
 4pe9VUNUaXBWkNTJaZZiUsNwACrCLFlSn/0v/tCI=
X-Received: by 2002:a05:690e:190d:b0:66f:b454:5872 with SMTP id
 956f58d0204a3-67154fa0fcdmr135312d50.22.1789410087172; Mon, 14 Sep 2026
 11:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
 <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
 <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
 <72dd2ada-3b4d-4563-860a-86bf6c6a8a90@linaro.org>
In-Reply-To: <72dd2ada-3b4d-4563-860a-86bf6c6a8a90@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 19:21:15 +0100
X-Gm-Features: AcwNN1WOoZK8WHiuz9hJ3D7TwBPkXIWyG0rg1hXCnEGBe6ndfQz4xLISzP5txSE
Message-ID: <CAFEAcA_7eYjtgXVidEMsG9ztZf1Zy8A4Qip_baSGxdNRQQKj6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 14 Sept 2026 at 19:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/14/26 07:51, Peter Maydell wrote:
> > On Mon, 14 Sept 2026 at 18:21, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 9/13/26 23:16, Peter Maydell wrote:
> >>> On Thu, 6 Aug 2026 at 18:32, Richard Henderson
> >>> <richard.henderson@linaro.org> wrote:
> >>>>
> >>>> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
> >>>> within the range which are not explicitly listed.  Previously we chose
> >>>> not to honor the TID3 bit.
> >>>>
> >>>> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
> >>>> on these registers, so we might as well honor HCR_EL2.TID3 too.
> >>>
> >>> I thought we agreed not to change the behaviour here? Is this
> >>> just a "forgot to update commit message" thing?
> >> Oh, yes.  Because I did update the code to test for v8 in translate.c.
> >
> > So what does this patch do? Is it just a no-behaviour-change
> > refactor so we have a place to add the SCR_EL3.TID3 check
> > in the following patch ?
> It does what it says on the tin -- it honors HCR_EL2.TID3 for undefined
> registers.  We currently only do this via access_tid3 for defined registers.

But there aren't any genuinely UNDEFINED encodings in the TID3
space, are there? The ID register space has to RES0, not UNDEF,
for reserved encodings, and so we have cpreg structs for
all the reserved encodings in the ID space.

We give the ones in the TID3 space either the access_tid3() accessfn
(which honours HCR_TID3 only for v8) or access_v7a_tid3() (which
always traps on HCR_TID3 and which we use for exactly the set of
registers that were defined in v7A).

-- PMM

