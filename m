Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C314CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArHC-00033Z-6m; Mon, 20 Oct 2025 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArGf-0002dO-GN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:54 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArGb-0004gx-7q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:49 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63d97bcb898so6232724d50.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972023; x=1761576823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zU23yWGtSetwuWLS5SAyqN+GewwgZYsp4hXqLSA2xTQ=;
 b=dfSwZDGlgFebw1Ea7d7jONrMErboDijUxlpLMO2K5PTBeIxFo0adN8BxhPv9eyYGhL
 RWmmUSi4qtiTx4XkFsM+j7y3nDEVR+fQfjxPrZ+JqtmSEJ7pCZkvZ/azCPnepPiLdiN2
 4sQZwowCp4BGnC+GaAvzHLiosgTLLKjXtbUkFTEvtU4yuEOrfJGcEdqK1KIMaM4B+Xkp
 9rFjHAA5i8n50nOajbhx74IFBtTuOk8sxjjDfEBSvqeTyECCFV0CUOdOjrds0ASt4AW4
 J3QqaS3S0aO1l6fu1fm8PkIIkCkE97iRvidtKQbO7Oei4Ka6HXX3XS3O0bhOlwvi8pgh
 COdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972023; x=1761576823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zU23yWGtSetwuWLS5SAyqN+GewwgZYsp4hXqLSA2xTQ=;
 b=LWdlv58V2EknTDI8praiLuqOgx+QG7XlPRlfxUVYfVJS63Xe5vxoLwrD4HXB4i7kTi
 eI3YNNRCbkH0fDqK7BbB8ZZuQyMTBQ7kfQWV5FLvqkq6kZ/YrunBm21UMOy8l4WfAYW+
 0RsZFrcTNavXf33JOrG9EfesxmRjjDpauLb93RF+sQUzC7XHKS/iYUER720soNr17hEh
 /zOtRLqoWwJiKXEEyVJUBOo6xrRPpFVaLUpOouEUDZZ0PnjowZuyuoHnkeLrJyzyKOJF
 8E8gUZJZCdSR17GJI9WJKYP3y/s2gkREA/x8xGL51/b9QBorCYNRpjuKH+PueMsvUW4q
 DZvQ==
X-Gm-Message-State: AOJu0YxbeSz6x3d5hH7lB9RKZH/0rgyopvTA5GDfXOwtiP3G1AHm27LF
 mGi5NrtcFxfTeZyJwwmybIedu11je9YMhBIwJ5iv/unQM5fAtzlmofjarrnSImjAI2suHSDuBuE
 S83uZ1ycSjUL8wTrTXxXcif1yzTmN/vtfiJBRv8Hh/A==
X-Gm-Gg: ASbGncsZU32JWi+/o3jTfsLA7D/3V2KX9AOptHs2m8ZZrjZ4fW1vC5Q8thPdW1fVtuX
 oX2HHWPLIKRXE1jGxdeyLz5hWT9nOEGr/RWZE363is0+crNEnEfMhpqMrCQ9s8Z/eptE8SKeDuq
 zeBfc2FSazGBN0HPO4fw7kSnRY3QrwOm0xaZu5EEUdkcGzaXIlVG0eo56IRv/gD3Ri9a75Zf87U
 cL20scJtNJPXvWqiWfzcdCBGg3YngC5Uwj/xvhGdh/gI3rKGmiHqKP/OtY/v7McX0XL5+yU
X-Google-Smtp-Source: AGHT+IFO0YgcTul+xEqFCMxYfaz2ABP6GsxtLdgznHaZBF0+DKOm6lmKv/9wQVGcrCr0rP0NMaWjLNW9feg9mN3MrD8=
X-Received: by 2002:a05:690e:4182:b0:633:b317:9cea with SMTP id
 956f58d0204a3-63e161794d9mr9544651d50.8.1760972023132; Mon, 20 Oct 2025
 07:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-37-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:53:31 +0100
X-Gm-Features: AS18NWD2v-qwuj8fxHMmfGbNiDThL2ftN7YvbhaAYBvBv94_M_4mI8vloIfGrr4
Message-ID: <CAFEAcA8Kvqa7vgSk-FhOfb_GCuNq3cnEihUaV08QSv8sVjmiWQ@mail.gmail.com>
Subject: Re: [PATCH v2 36/37] target/arm: Implement TLBIP VA{L}E3{IS,OS}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

