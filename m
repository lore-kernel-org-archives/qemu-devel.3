Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41BFC5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 15:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjKqN-0003Pr-Of; Wed, 28 Aug 2024 11:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKqE-0002nZ-0G
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:44:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjKpx-0007Si-F2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:44:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9f2b967so4003874a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724859836; x=1725464636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ey/5jFBojVMc6leQaSkGnAc0DKi6p2SSiiU0Kuw7GM=;
 b=nBn3qT6/bzKbC3j+wFPj5W/m5TFlEoOWD1+1fT4Ie4Q6fe7RfgvSFb6yu66xD4Ds6M
 bU4sizexd4eJn8h9MbENiKYw2hjhk63qopyuc0UugQvsHMOmQqTY0jenhLs1OcIG1xxe
 MLA1pN25PPmeuhLidBk7mrHX91TjSyefz0BSmvojxu16TJfngBqVKsB2ZPuT/9Gf/T6c
 kR01Pq2pYEGTxmFd6bvwAGTO7WDu2mfzH3fp80nwoAUmhKQcpMhhFz57BRtuRdfwStEk
 Ew8WxDRQ2W1Zkn9qtRM0coZoZWPWlnVfLz1VBJtIDiE+2bgCSsU9QWeIUXznHxBiQ6ak
 A6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859836; x=1725464636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ey/5jFBojVMc6leQaSkGnAc0DKi6p2SSiiU0Kuw7GM=;
 b=bFr89QlDbvGZOGt4IKX6tab4uGHLGS9/1PUJAqe9lUg+ze1OMBgZWZ8ubhuwKcd3nv
 c0CEBoUF37q6uFucJKW3YwJ2ezcYEKOySqXA5tmOMNG37WyddNkVpyMJn9JkWe/BCYs+
 hRKh6fnrQPl0E69tvk4SGGlD2nFCOf3K9eNo2yCpMoR83ejSBeOg95PUwyiuOmIMV+8e
 nZz4ITbyTrc/4bocJP7Se7eWi1MzvtiUbTcv0PVMc8znFoyCE5c1u4O+THwzFRZufqgQ
 ZNtck9cXw+RwHRnVMaa+/mdStcHOjx0S6RP0hhsaMjiKzIChkXcgqa8qHGq4+dTB+j2M
 ObWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuDDYGmWYWEnVUuRoJc2mpcCcYZlYuVYFfZCi34QxJLosdiyIZqJjAY144bsm5G3kIiSbIHGM+ppua@nongnu.org
X-Gm-Message-State: AOJu0YwoAgtrzVIMKat06FhAnfu3KaNAR4oTMVUopz/v67YpiF34kC0t
 tEKyw4/IiVePui4LLixMODuZORJ1pdxumCznk08pJxkFSdK52XhR5fsI8DUSNOpoLldQc/hVikY
 OCLnOxQC4kzEJrdFGSDPKuTO8+iPmFbkoUgFFtg==
X-Google-Smtp-Source: AGHT+IHMGinJwd/8bCYMJ71Sk8PTES6HstlxxfOFHDHlPPId09VGWVM1aOPgSK5QRJeSIb+06CkbVVirfOaolruXBqU=
X-Received: by 2002:a05:6402:2786:b0:5bb:8e11:f682 with SMTP id
 4fb4d7f45d1cf-5c214c2933dmr1574725a12.19.1724859835537; Wed, 28 Aug 2024
 08:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240828043337.14587-1-npiggin@gmail.com>
 <20240828043337.14587-2-npiggin@gmail.com>
In-Reply-To: <20240828043337.14587-2-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Aug 2024 16:43:44 +0100
Message-ID: <CAFEAcA92LaBaRRGqyvHYevfW2WgUsmJuB8jSHCyTvMkHWmuMxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: Fix record/replay error path NULL deref in
 device creation
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Aug 2024 at 05:33, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> qemu_chardev_set_replay() was being called in chardev creation to
> set up replay parameters even if the chardev is NULL.
>
> A segfault can be reproduced by specifying '-serial chardev:bad' with
> an rr=record mode.
>
> Fix this with a NULL pointer check.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: Coverity CID 1559470
> Fixes: 4c193bb129dae ("chardev: set record/replay on the base device of a muxed device")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index ba847b6e9e..47a744ebeb 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -721,7 +721,7 @@ static Chardev *__qemu_chr_new(const char *label, const char *filename,
>
>      if (strstart(filename, "chardev:", &p)) {
>          chr = qemu_chr_find(p);
> -        if (replay) {
> +        if (replay && chr) {
>              qemu_chardev_set_replay(chr, &err);
>              if (err) {
>                  error_report_err(err);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

