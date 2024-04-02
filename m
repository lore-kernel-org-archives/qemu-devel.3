Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463DBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcWN-0006jv-O1; Tue, 02 Apr 2024 07:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcWG-0006iO-Ha
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:41:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcWB-0003mP-S8
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:41:35 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56df87057bbso162183a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712058077; x=1712662877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iXdhEj8D9AgaXWEHfz+JRhRCKc5icpIRdo3WoQFTrus=;
 b=zSSswM0WBL6cW3Lu6bzS8/voW+lKdTdcZFnsadT5glUZbR3piXTBPR1ej9e0Bb7H5O
 prQ4vJi/fN67lYPvPFBvhtfX6vs6xv9W4FupOKA/dOewMSVgQRl6mhsUc7PLBcQyEGF2
 Kq6K4kXpdtM+0MaXOlecYA8pE6A5wjc6KCFtfvPfqVGupP5a3w1cblTZ7Pdf3y/mwlBQ
 hg9bcMAgpcXGUV20XjxG/wq45SYe7ShSRtRg5LWkaEBliXW4Mh6biroNop73hri09jh+
 J9Dktcywv62noRZpgV/nHF5S6EREt5cwa1bF+Xrc7tJrc2xE5LXsB6mSwQ68MJmYlDPS
 J0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712058077; x=1712662877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXdhEj8D9AgaXWEHfz+JRhRCKc5icpIRdo3WoQFTrus=;
 b=h+9KhqtxYas+rbtCLMTFmz+eBnpMmC1wN6Sguf23lsvvDmy5Y9g0lgoyFmVwv+bqh6
 1CbeS7toQept+DqodFVAkLAsuNv1h6NSxzwyPKE3xuuKGY+VWE8t9nPZYurPAcZ4V1av
 pEorA2U/Fy9QmlZj9AuKdSJhC4YFzYHTp3x84uCQar8sgWJW4H4wF3V0pszihJnNPouj
 YaYMe/xQGRPSju/WAt9+d+Ljju69Jo0UrSIHJmVOdnpPIUzghAmjVV6m+0fCv5RkVnM6
 DnTRf4gXXQzgnI/wqoqXew4hMTOoDObWdo4CtV+CWMRE7EfY16hq7e9xROBBZnI2AFJ9
 lF3g==
X-Gm-Message-State: AOJu0Yx61tZcBoHb96USeHNR1Wh3T+CKCimKTQ9E1HNOa/9kDcI1AvbZ
 IZGRQ7yXOkExygR6WcjkAkhXkWtEKfcYEps1ZYqYgTCf0BVeo4Wm2AbJ9ks4EN5vZnPLuNfDxlG
 +UL2H637dGA20d+Hvb9jtbAOGF3ta8UaZe9hB3w==
X-Google-Smtp-Source: AGHT+IHtPeRVVZ3PuTPjmKdSEl44gpdmnFDh/FDVhYD+bG+DmcPDEeeNt/Ff6sSoiwd6n68sT4IOtFI+2d/1xA56gFc=
X-Received: by 2002:a50:c04e:0:b0:568:bc48:5f27 with SMTP id
 u14-20020a50c04e000000b00568bc485f27mr8309298edd.39.1712058077333; Tue, 02
 Apr 2024 04:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
 <CAFEAcA8UBewAHriNkbJNO9CFKgf5bBGRHntbb_y11JdfoNTvcQ@mail.gmail.com>
 <60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru>
In-Reply-To: <60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 12:41:05 +0100
Message-ID: <CAFEAcA950hP1vb-aVSFOvAmG3n2cjTsU524AsYBDAseSZh+Q4A@mail.gmail.com>
Subject: Re: [PULL 0/4] Trivial patches for 2024-04-02
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 2 Apr 2024 at 11:41, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
>
> > Author: Stefan Weil via <qemu-trivial@nongnu.org>
>
> *SIGH*  This happened *again*.
>
> > (you'll need to tell git log "--no-mailmap" to not get confused
> > by the mapping we have for the last time one of these slipped
> > through...)
>
> Now this is interesting.  And this is exactly why I haven't noticed
> it - I did pay attention to Author lines this time.  -- because
> it is displayed with mailmap applied.  How very useful.
>
> I have to use `git show --no-mailmap' to see the original " via.."
> version.

FWIW my apply-pullreq script makes this check for this:

if git shortlog --author='qemu-.*@nongnu\.org' master..staging | grep .; then
    echo "ERROR: pull request includes commits attributed to list"
    exit 1
fi

(This doesn't pass --no-mailmap, because git shortlog doesn't
take that option, and the --author match is done on the "true"
author, not the mapped one. This is the kind of orthogonality
in command line UI that we have come to expect from git ;-))

-- PMM

