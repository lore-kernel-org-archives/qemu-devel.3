Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB5EE20A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMD5-0000sA-Vs; Fri, 06 Feb 2026 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMCv-0000m7-1f
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:49:14 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMCt-0003b2-HM
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:49:12 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7962119ff2bso4378027b3.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770385749; cv=none;
 d=google.com; s=arc-20240605;
 b=hAUUPYORpiax1Za6ouhprXkYOTAQ1N0uCbnp1pufJrr6juu72f4UNs5/xl/UDqgkWq
 7I7eS+fRltCasuWO/Js/cEZB5OesBbbrnHwReVV6ul/K53/lioj0z6Kh/kTuJUSDSlOq
 mBA7zyDEa3dHDr7EcuRVgxByUE54xJxAtFcKDnlhIEBZE1lQUqG2xv4TuNLWn0bSBhcW
 pZGkYUHUosFppsnIMGWCkY1d/X03EorZuLQIXRAlh7KG5PnzHE2Ayc1K0Nx0iFqxqEks
 DKN5Nwf2T0EqUsHWrSFNADmUdI8R+fVd94oENds9zTHZYv3bcxvWTUWE+CmYszeS5JFc
 jl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tAJxh5aYTSnA6OumxotnwqDrAnASnUjEjvi8Z615DvA=;
 fh=ab1LPBglT2PG/sPMvbpzGY6xH6vCw+rwfYiuOUOC5F4=;
 b=B/6zXudpqs9uXmS3uY7mbRRiKFzyEUKCShA+QCv5FVgt6TOBKwRSve00HWfAk4Q7JP
 shoUMkVVwuuISkMR5cFb2iCUk66zL0P2iAtO24OJjjDlQ025MKtIHo6yymf/fyyiloR6
 VGhwFrwTTz+hTzEFoo/83yfVDgSC8Nr9tmnA3sCS6OooyYaOrStCF/ZXTqWf3fS5Q5uu
 Pon20QUGoMB/mHIMHE+3W+/fX3u4fiQUNpET0NvShRQFJPoJ43PJZqbaPF20dHfOkb1K
 /MZufRNzrfxpLcEB6i02+iz2JzTVwGNHPuYNuS62M/6NAAENsBGSTtRzqlZX9L7CHw2l
 Zn2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385749; x=1770990549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAJxh5aYTSnA6OumxotnwqDrAnASnUjEjvi8Z615DvA=;
 b=lgBc51L9FV21Tjb/DwSlgAt8WxPfNFcZjcSSkQY1i+Oa5ZmJr7OAcR2RKeZYtC2YCI
 U3bO+5OyCXxIwxLUSltINoT4DZiViRwMQJKgXFWJmJCuIuLkT+wi8jnCD+ouE0LflzuB
 4FoM3ph1v/123Lw/+Utr7e+skAu4nawmaF2g+QqHIu9gkg44FLdKqQg5i8det+tyyla8
 kdu4VV1kzsbdGzo67v+l4Z4EL+hcYMEc8hZnzd95D7BQhMTvJ6H9/nCe+6EnXJZfFRGb
 EnNU4AZ3zBGRkXGCLhvv/E4HUMUer9F56whOu/bVwTFfAM65PXQvAZX2j+Vwx+9lY72j
 ZNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385749; x=1770990549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAJxh5aYTSnA6OumxotnwqDrAnASnUjEjvi8Z615DvA=;
 b=XwRluKtanD2kJYjfnzKGrMQNLb+etVrx1yRixLE9W4jYXblMROsyq7IsYbloIX+lVA
 ftZBQTorb3rPEQ1Ies1IMMmFC/BqIVuy+sWV2g5IlAG1UhEeGinWyUPPKLjyIaKhRh3i
 r6O8KLrrJHC9x8rFVbd9XFkn/WQV5zJcqI9D9WOXCmD/t9nCm6dvuCGrzA0G1ugXFMHY
 VvEWhzks/Vyx547HXtVeF4WDl2kuYQBHp7XwqlbrcxHW8pd+WbCU6K2dKX90gKK+Z/Eg
 t9qLfHtyu8V6FaGYQN0c9j5Qwr2GCOwaUE56OYkCEhTSjrOwv7DE83aPv+S2CXWNN+mU
 8++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVttxvqsSzM439syYFaAQwvhB9TK3P57kPR7tRpOi8k8kQq02N4xUwBF5AUq32l1bCtZwdtMvxJH8a7@nongnu.org
X-Gm-Message-State: AOJu0YyjIudZKCcxVnTtA0o7ClDGy6hOuaoWL/Uw2pUVoFd4od7HGOWg
 ssP4zPUrnQVJBYtbrJ4dJIsY6MBoZSTEmW6VmgUqRc6l2n5q4n37AaBy953rvGSqu60SA6l+OmW
 vOSTuXN2cs5oEYHJZztAS0MbvGu9O4O18Y30t68f5IQ==
X-Gm-Gg: AZuq6aLbQnIVbEJgro0QrN98EHG6p2dlHxLbrVDERrWxeeE0Y4B6SDdzrroOJrTd0cw
 djQRD3vU8v7g+pmSL1iWXuypC0tRMTGpaKp4ujRM6zVBySF5gmamLkcMBVExk8xBxu68cAJ0TCH
 FI9fXlHmixMRPTUTV3ev1WqHUwCmi/eLVPl/WxX5NCtVyDR3XW8izWkvUzrP44FbYUzV6R+FhyK
 kHo8RanaHP7UFa7LDIut4AvEqN+ljRGmj9QnZeugZpBP9FinqYXSSpiukjogIknDkW0Q5KC+ZdS
 2TbKX3L1QTZy4JbV2boqCRy9AyQgOukEiELBmMZvn/t+fvcdV3/WfXQ=
X-Received: by 2002:a05:690c:89:b0:794:f3df:8343 with SMTP id
 00721157ae682-7952ab6f609mr25881047b3.67.1770385748876; Fri, 06 Feb 2026
 05:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
 <67851770384370@mail.yandex-team.ru>
In-Reply-To: <67851770384370@mail.yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 13:48:56 +0000
X-Gm-Features: AZwV_QgEKmkNY4zBoPMBcwxSvd5bLg_-fLouZnLmEuFw48BUT3MKJMZeri6Ni0Y
Message-ID: <CAFEAcA9TFgGrXx9TfC1jr=VOOJzoAQqirbDOyf2PU3cMXc9iLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Feb 2026 at 13:33, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>
>
>
> According to coding style (docs/devel/style.rst):
>
> Mixed declarations (interleaving statements and declarations within
> blocks) are generally not allowed.
>
>
>        newsize = TARGET_PAGE_ALIGN(newsize);
>        newsize = REAL_HOST_PAGE_ALIGN(newsize);
>
>
>
> Hello, Laurent. Please note that I didn't touch these lines.

Laurent's comment is not about those two lines, but about
the ones above, that you don't quote in your reply. (Laurent
is following the usual mailing list style of interleaved commentary,
so his remark follows the part of your email that it is in
response to.)

> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void *addr, size_t len)
>    */
>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   {
> +    assert(block);
> +
>       const ram_addr_t oldsize = block->used_length;
>       const ram_addr_t unaligned_size = newsize;
>
> -    assert(block);
> -

You've moved a code line (the assert) above the declaration lines, so
the function used to follow this coding style rule, but now it doesn't.

thanks
-- PMM

