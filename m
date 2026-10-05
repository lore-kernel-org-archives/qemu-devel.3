Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC00CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeqH-0007Iy-RW; Mon, 05 Oct 2026 05:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDeqA-0007IU-43
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:18:34 -0400
Received: from mail-yx2-x2b.google.com ([2607:f8b0:4864:41::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDeq8-00040s-ET
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:18:33 -0400
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8ad0c8eac08so9401067b3.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191911; cv=none;
 d=google.com; s=arc-20260327;
 b=URWH2cIwN15MH0+7cFx7O5UNTdpAT+0cpYEHl0JFzbQyg/HMjI9sWxNVLpUvty9Gdq
 +W+qZ6Bu6hf/GEYmvCvEibDglMPV+q9ClQGXpMxZt//Zydr9D8W96cE2SWbR0z4xu+Cn
 zFj0Gjj4p/y6UFxIVdvvk3lIYn62Iy23miBHdt5lzDa5w3Zbksdm5ge8skj9GkORrMhY
 mUo3S1i6gFnrdDt6gRw6BCir2b3ckD1lFlZ56ycT9OR0Dwt3W4tNB/3q2+wF3QYVgoOg
 IE7Hx9IG7/Az7GuF9zysb0afNDhByfLE9xvW7Pg8hBWmVBa1QselgXwhWve9bROfFCm5
 EEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UpwCXd6XmIrFOY9h2iXrcSniKBp6sSDaPVEm6KEbgrs=;
 fh=skaqemkmEYcyFg+X1G92An4ZvipxzcY0utyF4fq/fUc=;
 b=pUDtP7nfngdzmYRDawpXFunq3aqpqAW4j8Bo1lddEv44uoA6GOvqkdR6IYxUa3D2Zj
 iDCcFIIiEN9Frwr4X1o2DMhjx75Q2j6gIAFXykDzxlsNpXFTbUjbMSaJWAw/rwCyZ38y
 lairu7pnA+g5f78UFDUysjpkNdQQaJHfVnTNaM80zwF1wxq5m8bUhkWU6w5b/T+jRl9i
 Ku5EIIQ+HuDyp8VvSrQAVH5NHS5dQ4g08//tsU+s8M+Bc15ifrgUqp4+HaymuKG7Yacv
 3ADZfsqxhO96GH1HPfgrSCtaLySvHSk4RiDFeeuq25FaVF8T3Y7XC2RGP99osEFGD2FS
 kaPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791191911; x=1791796711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UpwCXd6XmIrFOY9h2iXrcSniKBp6sSDaPVEm6KEbgrs=;
 b=aBLOCo6cagd7n8Kwja07rD/IRSkNI4YEJeM/ehtrZvOfJNFOKHQiXgTGIlVH+nTO5l
 xE/DXTk9IkrNY01hX4FbYhHQFBWze2NjQyTgvD+y86UOmz63/OrhDBEPczNNF8IzCtsz
 OyrxofoKrBmcAhwNN3O/0YkHPjQxXbcyNzJPHkQp9hNnC8bY4xhyYMaU9g0RKQxg89pZ
 fyTLTM/JnFDWZI8Q5BB7AyYfFzDMp07nYz59NNofVh99KhUNXxC+lsq+G6eKj7iTjqK2
 94j6IBR+A4Cu+nCwLsvbtuaZGp9gO0IDxk7usj1Yr4r/JuyQeqH2aP2SSo21+cYnccJZ
 buSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791191911; x=1791796711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UpwCXd6XmIrFOY9h2iXrcSniKBp6sSDaPVEm6KEbgrs=;
 b=KQi/r1NVgnFqnyJ7ugQHIero4mrYF9wcZy+J3BIZJ9YasTbZlgPSK3kXfnEDzg7enr
 8Kv2vrjEj2kwOM4Hqn37XAoH85c8d9ZMzmxY/X8EBsCudA9xf8IeDJTqm6iWgwJ2wTtc
 me+a17Yyla00ke/B7iug8JCUX2ib9L2ACj5IkgDhZMHJGRSMji7DwldRwiL/x3SkuCOK
 xMbQC5FG7pOFOOQ8dAoCURsrZPNpqDlX6ujRflGORAktJ2mWl57VGO1i9JTpD7DqWlrY
 OWOXjrX7rQ5mA3HTmWFFyYd14ag4e9fjwnZSDcfXUozuf5gq0ahdOHo74MB0pkauAYyT
 YJKA==
X-Gm-Message-State: AFq9FYIixXz3Mi930l9qbPJ4++37UUqM26P5iZxwHyKWATD/CDyTYTVr
 KibDR6sbNyzMOkJqvwcl1PX5L3XsudcQhhm5JnrISj1Q/N5Gn0q+KSHZi+QGEBGYDP+EtnLFh5I
 aLS3LqppaAK7leBt4p9y97BBoGEdvtJVmVEL+dPT97g==
X-Gm-Gg: AYBFou2fSZEb2cHrwEUroR5xGVs6thg57XFCte9HXNKJOeDIyI5qSSKw40zhpJ+1gBB
 d6v8RIzpJI4dDeNDgQUmUD/Ck1iLBBj+OtDKfFXZWBViIkqiTrf0mWJ6CvXkwA1n3lXefFDXJBc
 6M0gqZBn5Ipj9pIErI3SESt1ChMHMgLaQd+WCVPwfHNuvhLzxNxlX3yIddlYThKjOvewSXsOAK5
 rKIX49gJOV/Nij7VC33ZOdl0TyeoyvTiK6tqhgcZmSNQD9P+ThN8B1FoWWcYUVZ7lLDwehv2B2G
 aL8JiONj2SXQxb7VqKoL73cx4qKmZgBGdFmOhbbjdaoq9eFbCKsQQ4KtGQQJRzo4JF5afasf6Up
 Uoc1rOAiqZG+5llScHXHtvhDLFDPKOW6DMk/FFAI=
X-Received: by 2002:a05:690c:ed6:b0:8ae:81e8:a719 with SMTP id
 00721157ae682-8ae81e8ae1amr26929087b3.62.1791191910673; Mon, 05 Oct 2026
 02:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-32-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-32-ccbef537cbeb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 10:18:18 +0100
X-Gm-Features: AclHuK-WKMjyk8tdK8S9BZgf3HecTb4v29EwNrraYxBflF4Uz8__xqWN0v7he8w
Message-ID: <CAFEAcA_piHxiTAqzHmvFW4JY01kHFnh9cUg9qiLe5om=8xBg4Q@mail.gmail.com>
Subject: Re: [PATCH 32/63] hw/char/exynos4210_uart: enforce 32-bit MMIO access
 size
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Pavee Hui <phui@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 4 Oct 2026 at 11:25, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Set .impl min/max_access_size to 4 bytes so the memory subsystem
> synthesizes sub-word guest accesses into 32-bit handler calls. The
> read/write handlers ignore the size parameter and always operate on full
> 32-bit register values, so without this QEMU would not extract the
> correct byte or halfword from the result.
>
> Reported-by: Pavee Hui <phui@google.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/exynos4210_uart.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index 7240ff7b5c24..8774d4bb43d7 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -506,6 +506,10 @@ static const MemoryRegionOps exynos4210_uart_ops =3D=
 {
>          .max_access_size =3D 4,
>          .unaligned =3D false
>      },
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
>  };

This needs to come with more than just this as a commit message
and change. What is a test case / situation that failed here?
What does the data sheet say? Etc.

thanks
-- PMM

