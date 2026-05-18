Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOt1E-0000o8-8x; Mon, 18 May 2026 04:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOt1A-0000no-Lv
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:08:05 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOt17-0006Wn-Tx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:08:04 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7bd5e373d07so13410217b3.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091681; cv=none;
 d=google.com; s=arc-20240605;
 b=EWemULcfiKTEd8Ly+3Fu/FgKBmsQ+OV6SwoM1O++P6naniBz/gv0LXO465yqCP6ySj
 uNmTy7H9c4igObSrmDHt7n1k9ijyLV4iVbfeImftJ4f1rr3Q4w03gZJdJS9n/dHtXozC
 +JrzS7XA/puFia3W5pe0Y0R0Wwn4ULaGK4/LjW4rHXHdW21LTf6BmDMdoPB/3VzaDNJ2
 GnwCw7WKNybaCfiq1ygxBvQZ7WzcUVbEp0P143c8xLCd+KGL8FsSaw7gD7pJGu4834oa
 OnIhiUM8HrtS9mo2IKgdJ83ETZr4EuYtH4Bw1pHeA2k9eZ9Wk54Ux2l7/eMzELSk2gQB
 Q0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mF8/OyME8P+WqAHdnlKSikaJibRkpDmpkpdTAKme0ts=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=bO51hZJYR6cUVTxAXcLM6fxn44OvGnu5VjsehJXyVGJvGGdKjC4D5mR5GnEUc37T18
 ghraibLCBC774VtYYRk1rxOOlRXmDWYna3N7U/AapO4E+0ruv3Q9I525OVINZo1x+WQc
 pYwR0ZQ4x7+TjjtLIUk9Dn4xeNucvHcCofptqd1+m2n130pt9+k+IYSfw7ShUhznmWLh
 2UywBZxbfFxud5p2fPSDDHH2DckC/63fX21R2njTKnWdMOlf6EQvlE24hPHiw0o/D5ru
 lhUzgZQhLSPPZV1PzgwbxGNoOHQGiNNLnSpBW9ljMlJkZkax1Ks6NKINNtD1hF4SmP/A
 2UHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091681; x=1779696481; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mF8/OyME8P+WqAHdnlKSikaJibRkpDmpkpdTAKme0ts=;
 b=NtSv4t2ClMFZhxKDUXpjyL0ITMgTFqKgPUlHzIHTbJQ7tyHkcseGsg3ZmFvh+E+nGV
 bmAAvn7GoSEx+sO0aqEHAoaF6euulAoxqwSDldTf3fUgvn2rTAxEwBof+pW1Iv0TnGhk
 gObq0YaXwDUpnsvITHDJsw7bv5kc9fuMHDaZEt18AkreluFsKBHdUbFlsjryCSr8j9h/
 bsxcnTwRDvOX44QPXl1RJ/gcO4VNhdGYllAw2q1O71j9XdufMsFnxDs0DcRK4zBYxArh
 JGL36SxixZhnrvmnfbImEsWZq3YfCnIl2GSGiVgNZWgwDxbuzuxEzZuN7UN4JZzNCeda
 T+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091681; x=1779696481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF8/OyME8P+WqAHdnlKSikaJibRkpDmpkpdTAKme0ts=;
 b=BZsSILDZEiazGPXTbubCB05g63GxVIplfigjVmiXVTBN/Qg2fSaRN1RvuXhLufk1tx
 dt0q6m5E7MpobmCM5knsXEXgqU64Ec1aDVQGGPiw/ysnBKHbNfEFU42dOUM5uHVfEGyZ
 yIcY1bVO2xxQ4jxvNUXCdQXnmSjLnAkvSXFxou8VG0t2pYKQhfPwHs1dvtrBuQeg9uwf
 UZOakxudbhuYCCoy/0E2Ai+Ft/ssyg3ddMv1hgQQigOt70bHHQSrIJecQlSrw8fIl/A4
 8JtF61X6g1ZG94LczUqyXgEnixj9PqX9PU0nsg9yKmgLcUdB9+l4pXKAxH5BVZE+N3JV
 TkVw==
X-Gm-Message-State: AOJu0YzLryobqZo0GhYZFxhuaf3H+oHjniS23DVJrh90vbQmsBexjb3T
 xqd5qepuKlz6VpeIG3hMbjkuHqrDWe6gQ2w7v1ZAzO2TnNZEunvQfSqP2ez7xXl79BOGWocnjSA
 O2zzfQc9YC4sqDvk1oDf9S4GBk4FK2p9pO7sUJT4iTDIMJ0jdc7TT
X-Gm-Gg: Acq92OE+lHw85fdQmAeIeT961R8bzzDt0LGrW7vsrOWjbhLav69uaZiMRue3CaVzRBa
 fk+eQ08GYOT+eN2dHA9VvHiYvMzBM6MM042vQB0slHi+l4a4vX5x6Ic5U8CAN/TGyaOuo5/RAMk
 25VBnvpjE4TsigM3K78HvMtpI9pcmVvQILWeqknhPb2T4Ydn1TsxfLcjEpGhcGsC6n5NTXSSVB3
 kTV52WFd9hq1u53QVrBnN8f7/LT7DmLumMgTy76Q65ihoXftkmtQ4E4tf2VQd7xRQD7zC8wtAkV
 bXQ8oZ2BbujYEZLv/meVn6PZEInswyDnc1TYEwXN6a5ZDBPMACySDiocrr8F7DpgdH7dlzSp6MJ
 gXQ==
X-Received: by 2002:a05:690e:1908:b0:65e:c81:3a6f with SMTP id
 956f58d0204a3-65e2278f705mr14193995d50.27.1779091680706; Mon, 18 May 2026
 01:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-12-peter.maydell@linaro.org>
 <c9300c93-b20e-45ad-9b93-d23e19e58a80@linaro.org>
In-Reply-To: <c9300c93-b20e-45ad-9b93-d23e19e58a80@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2026 09:07:49 +0100
X-Gm-Features: AVHnY4KM6e0fH2nSqu-Vu8yKXJiNU8AC6I5kqRv5b2ZqoJYFKq0UfVabMVMTpfs
Message-ID: <CAFEAcA_Pfnv95bB+st=9V87cg964a3gh1wEX6SB31fNe6q6LeA@mail.gmail.com>
Subject: Re: [PATCH 11/12] hw/dma/omap_dma: Remove unused ifdeffed out code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Sun, 17 May 2026 at 18:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/12/26 13:34, Peter Maydell wrote:
> > The OMAP DMA device includes a lot of code which has been disabled
> > via ifdefs for over a decade. Whatever this unfinished development
> > work was, all knowledge of it is long gone, and we're unlikely to
> > be doing any serious work on this device model in future. If we
> > did, we'd likely have to start from scratch.
> >
> > Remove all the ifdeffed out code.
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> >   hw/dma/omap_dma.c | 94 -----------------------------------------------
> >   1 file changed, 94 deletions(-)
>
> There's a bunch of code that's mis-indented after removing some ifdef'd if blocks.

Yes; I deliberately didn't reindent as the patch diff would then
be harder to read. I should have put in a separate reindent patch
afterwards, though.

-- PMM

