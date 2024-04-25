Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBAAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 19:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04jP-0000hE-5y; Thu, 25 Apr 2024 15:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04jL-0000gn-9I
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:26:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s04jI-0004y5-AS
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 15:26:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so1970637a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714073158; x=1714677958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YcaSJzX+iXjH6svkMO7ZzO3LbPjWyD7bMilIn8eEuSI=;
 b=dGbSpCJWfjSoaysKUhNcoMgWqxPyMP2w40gUu6QTRlkNNapkLupG+fj+eI0M3Ek75g
 dB8GpluWSzwS2Xoq/KyUB42hVTxdr9d0t0bxYXEh6c+7EdWpFU/8bNUo6vFuiWp7Y9Rt
 BpKRKPnHIg0vF/4Yc7fsko2CVEDuGafQfImGLHx+i1mX6WgER+SLHI9wVHytvXXMYwIV
 8rFpKpTDGw69MhU2+14fVMt8gpR51i6AoLHVouqz/9wHBN6aAJQIY0xtrdj1zB0jrEGX
 AObGLnfcrEErP/7hyKVk8FGFjYa0CMkKaXLI/UCf5naZO9cJQdVWM641KmeJef6z1Hqe
 XnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714073158; x=1714677958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YcaSJzX+iXjH6svkMO7ZzO3LbPjWyD7bMilIn8eEuSI=;
 b=wolcK9BCJA+ZSiEj+uwIRnkjgS0Qelvaoi9pf2kEFA/9G7ZiExjFmjauecdvnx2lxZ
 +xa1wYNBJEA9SXk0QaWqqzFN6Ga9H+WCgT1idMz2YxfHksfUdHiqMhAD9TvpQNLHrChB
 du9y6IaQo9rfLprrCokiAzIFaooR5GUVIgmNkLsscDovaZUeX7Tm02iUL383/3cD1xlX
 U0AvVkTihLlyQOFU8Vrai6tE1CcSnoo/+aU0aBxW7OUSJqfr3ZPtifSFcyzMkt0miyWW
 OUf6I7sAeEbVtR/WsHDdAFD3zF+lBnC0zQAYxLNSTsO7TQJP0cE9gR/kduAxIY3/XQPV
 0N7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCzUNzDe3CSTdSj9vfnH+1KnhD0BaMIvIE7/R7ii4xL7wrKHHDjT190oPrvGxkgY7zJ7KL9xbtubWKCwDGgO62wC8rST8=
X-Gm-Message-State: AOJu0Yw0SJwotfg+1L9NhVs3hHof7REyC22ZOKHtuIn3G9cF5FNvTAF7
 dS6a1dN2tNDhq8pAU1HhUyAghbI590s6CT+tjs87IBGlbU0PpZeCwkoSB1qotIfOJKDw9qSEsJt
 nUrQyRRcdE75OTVjvDRKin/evs+5MJuEEfUcI8ssg1fd/mbTHyRE=
X-Google-Smtp-Source: AGHT+IFbBk3/I6XG1SnC5LNj/Z+g/tc0QNu4x2HPN9qSblo1AC5pwQ/CVXGhMZNojW2icjoV2/FGdfXnnkEjKIsbHLg=
X-Received: by 2002:a50:a455:0:b0:572:4efc:1b9c with SMTP id
 v21-20020a50a455000000b005724efc1b9cmr460940edb.11.1714073157706; Thu, 25 Apr
 2024 12:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240424181321.20844-1-adiupina@astralinux.ru>
 <CAFEAcA-=kk_TQVRLLQvH96DC-ffmDqd_hU5=z=Og8ntYGxPUeg@mail.gmail.com>
 <20240424181321.20844-2-adiupina@astralinux.ru>
In-Reply-To: <20240424181321.20844-2-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 20:25:46 +0100
Message-ID: <CAFEAcA-j2rrmU9r85DTghvOD7xr3sJfbCMb38=6UWU6n0WTPOQ@mail.gmail.com>
Subject: Re: [PATCH] fix bit fields extraction and prevent overflow
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 24 Apr 2024 at 19:13, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add a type cast and use extract64() instead of extract32()
> to avoid integer overflow on addition. Fix bit fields
> extraction according to documentation.

The commit message here says we make the handling of the
address_extension fields match the documentation, and the
version of the fixes to this function in the patch
"[PATCH v2 RFC] fix host-endianness bug and prevent overflow"
did that, but here we seem to have gone back to not changing
the shift amounts.

We also need to extract all 16 bits of the address_extension
fields, not just 12, according to the datasheet.

thanks
-- PMM

