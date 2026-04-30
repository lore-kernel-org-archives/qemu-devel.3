Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CE1CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITgZ-0001wT-4G; Thu, 30 Apr 2026 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITg2-0001p3-I8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:51:50 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITg1-0004gL-7g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:51:46 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65318dafbcbso1016308d50.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564301; cv=none;
 d=google.com; s=arc-20240605;
 b=lYfSH6Ox06B6tI2HhPWPq6DWJD9sT1Haz9i3NcMv6iXYPJmvfYBN+b5JuoZ+gL9583
 s1SXwLpCNN6ivDBye23/no1v0N+M3BS7u/9XzaUQeLPNSfG7tX0Q347d+A5NlLQPBzjk
 RVRGuPmafKrtHSomLs9Z9Woy1cpU2GmN3eg8Xk9KkCO2XWKDd0K/eJPLa8X/Tj/ybr44
 gkVYYFrr+1hW9gI6xjP+i8OC+ZAH3HS15UGp1rjR9GyatdZAozj2mKCVMrZRZY2Eo7OG
 XUuog7r04jf4IknBqSFyR/R4O1LHfNowkNjruq+Dg4hE1BakaluagQNPoRkr+5lQN0ax
 rrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xCiMC4tA6vJvaCTtDwTNRlRYCOReF+ZXex/8bgvfDno=;
 fh=yw7K3BubHk8SjCQukUdlqRWuLdMhG2KU5Qk39I/xouQ=;
 b=EOj8oH6nGqdFxaAJu32ttrbRMCV5nDtsTdxkik3s6W0+YajZaVj/aaJv81GBfWq7F9
 uTeUe+eDHdvH5X8Dcs5FznZ/6G0kfFyg6N/RdwaVIDGW3ze68QjtxlETrYfD7XTkhlyE
 wQmDRAzBTUw3jn27BSge/74BAB+gRs4ebJCDJUe0BDTL2zdIOJO46kzmEJSEvnBIRA5z
 fd3wSB95e5mGORGwfPgZxXPK8B7IeWAoAtehjtp3qGZPGOd6WxwJdlrSYDIKp8UlqPqw
 sPofMmgRtIo9akOdpA0facUU+80ivBhX85mCy/ii0s6gdLrH+Zg9Bvh/rDvBA9eAINm4
 s0sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777564301; x=1778169101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCiMC4tA6vJvaCTtDwTNRlRYCOReF+ZXex/8bgvfDno=;
 b=WmYN97vxJKHCrHSexpZuTd6ecbOpleEjJJ5v/dUw6arjkGdWfuqnYlEp/AtOMmiKe3
 LywCrfZJgifJS2YE7NKWRkZLTQzuQvtZJRK1LM4Hm4As4CdACezO0zdYK6/2BWxS/NAC
 LaATyBNXOV8eoSlQUHsV1RlWh1V/y2+E8n2qrhy8rxxvdy/QmShO7XIRYRorPeZIIA2C
 qAnJTKHyvYKLUPySGvoysoXNG6Z9HZshDcfDc6KC/uhIAtXhSXXRFX4mYptzwLCpZYvs
 5TZFSy4I4NvsE9ZWG+BFLvgbO0LXqf9q+gCgBlO30gVWLQovr6IHMBRNnqAkcPnACdAB
 5Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777564301; x=1778169101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xCiMC4tA6vJvaCTtDwTNRlRYCOReF+ZXex/8bgvfDno=;
 b=gc41Mm+/gBfB4blc5xP0qOJFBRZK2CsNI6+FKyWQS/u9dmO+Fa567168GrgIbchcLw
 GxtjOX+Khi/fcX4bgHiH5VO84E4VX0WlS3iywqxaFJefS9b+RYFbnKIJUUFldo5pXyu4
 kl7xTiC5LzbeOuThKg4IZX+oeDfgVtlp17LYl6L0DRZfBBdQuABmEUQxxI7XRGrra8vB
 dOI1BIfs8QdezOJTRh0MbrQIRYsgVde0jsTkKjE67Vfjtf+qQ4tcyk/X9Rrog3gUfpmf
 AfY19IxhtGDjuzbegl0GZrgLEH/9EdTRBQu24vFL+Odncfj1O/tm8fgj7iXFgEfNhkRo
 OV/A==
X-Gm-Message-State: AOJu0YwHas7K1vuf5sEG4EFieNHLTNlyKwWct4a+vnYh5PkoP8W39omY
 CzD+P/GMrfnXHyTyGvE5M3YkU/El3ruiaF0Jdvjzo8x8ava+kQ1cfKohoYQQ8EcTuRBnx1Z/iUm
 pgdRes4pQ71uymHKAO4Tqe4sTqhCuiNkzRSaICnlgTA==
X-Gm-Gg: AeBDiev3FEGZkMIxH9Nkk4YF2oW10QVec15k1UdzdT4P4mlj/DBvBTNrZ2UNoWe+xOn
 q1EMStTbaUPhV6pBFE/knVJPxHoqcSenrq8CazpaRKI2HDixrCpq24FL24LZ7+3Cxzyg3ZL0F3u
 KS8r+ca3Vi484Wr2um9W0s+u24SciTma2HQoVbO9iItSAoMBNyqoDOXWBPYOcL3QkW7L57msO3j
 4DL2UZKXiGiXwl8DO81teGsHmjZejgeTsKtW+4ACRu3ApknJzKNmX/okrvDLA+bJ38fyI0Egyv5
 /3XTgN0kYE3pmxw70QALFn/UkLECypjpvTWHe4oxP78mknPTGGRVypU3jtPtit5EujFN7pDRdSQ
 kSA==
X-Received: by 2002:a05:690e:1687:b0:652:f16e:952e with SMTP id
 956f58d0204a3-65c18b484c9mr2617042d50.14.1777564300819; Thu, 30 Apr 2026
 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-25-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-25-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:51:28 +0100
X-Gm-Features: AVHnY4IBJJZhmEOcVVDeaxG_03HjZi4zMLPH30k_u9yxXssu88W54ra-EWYYX20
Message-ID: <CAFEAcA9r0XpbX6_1oMOAXNo7BZBTFh_HpzZd5UnPzuuG3xix1Q@mail.gmail.com>
Subject: Re: [PATCH 25/41] scsi/pr-manager-helper: free path on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 27 Apr 2026 at 20:45, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> set_path allocates path via g_strdup, but
> pr_manager_helper_instance_finalize did not free it.
>
> Fixes: 9bad2a6b9d0a ("scsi: add persistent reservation manager using qemu=
-pr-helper")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scsi/pr-manager-helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index f6454cd80de..53432e6d606 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -284,6 +284,7 @@ static void pr_manager_helper_instance_finalize(Objec=
t *obj)
>  {
>      PRManagerHelper *pr_mgr =3D PR_MANAGER_HELPER(obj);
>
> +    g_free(pr_mgr->path);
>      object_unref(OBJECT(pr_mgr->ioc));
>      qemu_mutex_destroy(&pr_mgr->lock);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

