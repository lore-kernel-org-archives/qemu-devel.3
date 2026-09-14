Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723EC88E65
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64Ph-0007dW-JU; Mon, 14 Sep 2026 06:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x64Pf-0007dI-WD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:59:52 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x64Pe-0002gU-HB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 06:59:51 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469e211a0so1611553b3a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 03:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789383588; cv=none;
 d=google.com; s=arc-20260327;
 b=P8RHbQPiAYj4Z8B0reJBrMGNy9/QyonfwMRnIUGl9IPmNgiBt7jR59SoluyzGkiLnE
 JcmN6c4FsSn8BoWEXZauVGtva2VHU9j2EvpdTm2FLnGyj5f87YTTWLUMZYWKNe8aI+e9
 eBSoVUBPCOIuLlGOCUH8DYQO19cWwMwbWX8akiVvFiA5pLhQs56h0gc+ejKrYv2uWvgd
 +wjWm4mnhhRUG6YFhfGUJlAXS+YHTQ6cSx/xfIZ+712ckfXI5Q4hZ+5KasxhMpDFW/4Z
 BNTpcBLpUKiMDVbmdznmpMU3FzTRsHNB5rHf8TwCIgPhDp0FxUeX86VNyQDPZam/EePk
 Rq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8xkDdrhncUTP/EWF+PNKhCXJ1P6O4Iezk6tM2ZlxPvI=;
 fh=xvr9EK/LqMGZZKr5zjEszvb8Bef7Z9DLL6VRUFupeYM=;
 b=rVnbj7WXPOxuAd+2uKT5lM14THqQw2wIzzClVyMyrN7HvKYxWD0r5TypiKuTufww04
 gR3kpX78RaFs08AUQ7fWF0PXdZMf+W2u5wlBnBMwbdgmJZrg8G9D1JA9l2SEi6RDm2Pu
 LNqYMRqgxU631dODm07YgRh4noIi/putMcsnnEsrwRUGctDDz3AbquyNWyeFwDCgmBLn
 TBW3OKFUhn6YwQwRSXM2TMnrS402g8wssdHuNN7KscwtE9ziyTdKyPdui+65T9kTLebQ
 cbYolnnNnGieieYOWfUnUEMWX38vnw6KnBDQ26GgtH8bU4m/TFnpo5KBba9YrB7gp+AP
 4XJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789383588; x=1789988388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8xkDdrhncUTP/EWF+PNKhCXJ1P6O4Iezk6tM2ZlxPvI=;
 b=PJ+PDCK+qJQIWV+iQKdJfW/Ha8FbWCxvkNX7Rh6t1uAqX5tMBGCF29PBLl7cBaqMpu
 v+lc3KlaM2PKpE62LM4LSnCETCmCTX6D1+5HHEWtELJBDP/fawiVKqkuYDH+X0KvCzdv
 0gwoE1BNeL9Xl5Il1Nc2pU86G2w4JcGJ+gpjECKFc8U9Xym2RdHYADSoPQgJH0BzM3TU
 MPtc2B09dSijVioNrjpaHlEcoos11cPkop7Z2YiVopEk0gQNekb4Qtyt47i0ErfKRIEa
 zg/nQ67zgj7d9D4+Tp9p4f5YaqzqZUM6Zibl+rZiexlbVxiSoB9cmYvU4XNXAlBteY+L
 klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383588; x=1789988388;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8xkDdrhncUTP/EWF+PNKhCXJ1P6O4Iezk6tM2ZlxPvI=;
 b=ltDOZ2hk1aITRAlYf/poErbBDETceWTU3AVb0/SpWtMlauU6PSoaYNBLlig6fRo++W
 /7K1D3mDRTLev7QAcrnqioD0EhYT4GK6pMKtOpvb7sKOLI1yRwVLoSzWufwzO5P+35ow
 /Y9WcJkqbE6Q2JYaZzBz8qHZN4msw1IXENPMnb33UCCyqYgwFSOzHhIFerHd+YQKx1Xw
 GtgbZ1iw+LE5FARQFSc+XXOLazKS56L7LdC6NKLIy1lHWCRM65vMKPldnfYlCgBW/GZp
 0NZC7gxYzdxCUeVGbhg+KcvW6+CEM2T0banewSzrStpxqaAKjakjkEaK61HALj3pzf6B
 EhyQ==
X-Gm-Message-State: AFuF++mvn4UpMUxodrn9Un7QFWwSnf9FEQhet2bdRRAshl+1725obRnv
 o06z3mcjqYBC0d/GQXclYvlIcHvF1IJE7iVBRoAPp7bu7HxiECIdTsQ9FQtAZmcBxRkSGXqoDxe
 bzSl0sj6+X5kh4oUuZQE7EXT4zWDISRDBbA==
X-Gm-Gg: AYBFou0JAXU4Gz+ZRfH+yH9eQZK9wxkH9i2/dGMH8w2UB8JUMXkK1wqHsBnRNANvaao
 cmR066fZoYBcFkDsWbRthk60wXhLn24kjAUddjFT2n+aTgzqhdVSDBC42Ms5qvWilaquTIuLBa/
 5Oeiuj0iuBzihpnYmuLh0G6fNYV0ldzlZsBy8K5YjV4EKRyyZHUGlSYzPuCM8Ny5pqYIeEdbDe/
 2I1tVdaKbuXDRvhvauQf+wn/i1reHvGqCEmOm6cgJyOGzTy50qirzd7AvMZqyrVYsfNEw6Vh0Dg
 /+DNGVFD0oMPj0TgcDr+XcyhbdtQmky+pNqPIJVFD839rqxee5MYqN9MHCoGgtucVA8lyumBGa0
 CUw5GM4tp8Go=
X-Received: by 2002:a05:6a20:918f:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3db4046de0dmr3967501637.11.1789383588519; Mon, 14 Sep 2026
 03:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <CAJ+F1CKfsCkk_dtEd2YXTdT1Bno_5Z5kKJxg-22y69+cXem-qA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKfsCkk_dtEd2YXTdT1Bno_5Z5kKJxg-22y69+cXem-qA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Sep 2026 14:59:36 +0400
X-Gm-Features: AcwNN1XBJtK7FtqDPDCf6N6NsdK_vkLO-z8MY18xAAd3agV0XgTfgRnqUBfnHMU
Message-ID: <CAJ+F1CJm4j048Sv5po5zn7NRd4c25k6+VEnfDGRf4+2Tii80Zg@mail.gmail.com>
Subject: Re: [PATCH 00/27] CCID smartcard reader fixes
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Aug 31, 2026 at 3:36=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi all
>
> On Wed, Aug 5, 2026 at 3:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi,
> >
> > While tackling some CVEs issues, I also found several correctness and
> > robustness improvements/fixes. The series:
> >
> > - has 3 CVE fixes (OOB/assert)
> > - fixes xHCI compatibility
> > - some endianness fixes
> > - blocks & fixes migration
> > - better spec compliancy
> >
>
> almost a month, and no feedback. Should I just send a PR?

I don't know what else to do at this point but to beg people to take a
look or just send the PR. Any opinion?

thanks

