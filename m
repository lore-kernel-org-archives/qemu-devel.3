Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E764D2CDE6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 23:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRIwz-0006yD-7Z; Thu, 04 Dec 2025 18:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRIwq-0006sz-LK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 18:41:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRIwn-00069n-5U
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 18:41:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso19560935e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764891675; x=1765496475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0a9lEmyAzomZ8/G8vxcGUZtPU+U+hhj3fDkOIktCRbQ=;
 b=yPx7PQeptsgvw6rasop+mVswlbX5LrHTs/lig4kvzkVN3wbOb6WP0vgID/UxxRlwoy
 nnCUeoGpxi0WrF+sUt9YFiHmEXV0PELNbksiz7+ob1ZPRr3m7CuzkB4r8W0O8CXblzFR
 wGE+aCKfZuayQnfgU/rO0mIkPXIyODfxi+QSb1Y95InW/NtuIgrVQqtbvR10cq84C+XA
 P6jnGqgWIk5UwQppfUi3AvWp0mEuC/gc1oX1OuGEORS5ZGOGI7EhTDAJpzXVPrX2KYeY
 CaL6kBqYBZFWlhzHEHoUMsyS25g0GsMq2qQ8LNVjzeBcJgiEx5HQxRW432g0yLI6mNd8
 UPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764891675; x=1765496475;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0a9lEmyAzomZ8/G8vxcGUZtPU+U+hhj3fDkOIktCRbQ=;
 b=YtLr8R5YS4VXMr6a8eUdNd68DYEYGLTVaHKwo96CciWpf/OD3YHcsPXWlT0LvhiPRz
 w0DUhmwVnQi80SgHaaRV/KMFRFunvR3To43mighOCyqQstkoWj1pD+ezW4YH60qY1TXM
 R6DPKVDa5gdBPP69qMyp4yC+cllHoINenSrTX3tvIo0lkdeut9GRrm2RDwpXcTg7bfiY
 q9NGjr2r3hpUZs8koVbdPGVTR3NcOR9mmOmqo8TAI/31s6UtfunJ2SWRgJgGH+zpFzQl
 bqeOND7Wsb4zaCTyBO0SIPwLpc7R7PvFRuuQLibuQ5KH7LMKSMHKvJ2UPwFT9C4Buq4q
 6U/A==
X-Gm-Message-State: AOJu0Yz77vxyl8xt6u1ALMJZ2ySF5ClOHJnSmO7YVrdovDFDc4wIN5tc
 7c0qnokgG27/OatrwMhDEi6GpoMG+sRLyc2FkcDFNC5QSLfdn4zXJNZ5dq4rQGdkXLc=
X-Gm-Gg: ASbGncv4aUBogZ/qIhpR28uRMqnxTfeeaiSBGR2TKl9mS2d3ezHMZW3pggod/AcgNNg
 TvKSl76FMxmIOHfNqcXlPW5BFLVRtA5Io/xORzhvcercqlUmgRWxgDe6OfnxN6omJ+ttDKjCFp+
 0FOXfBmC3q1cU4g4aAn+KTCCbmRxP1xNUv4xQ7LwfgHwurr0al8swvLUDOvYTVVz2TCNDoQ7CGd
 0PcSOi85FkRv5cNhrhWjXsog2izUR97jd8QGFlQo52c8OtvBot1xYTgD+CXArdDqX6GOPaUQwqB
 GQRfta5TZRaF8XMzqo2MEhd1dpSuW36d5N9fu2fEfNofLnHYw8LvSjLC/qS2Oh3+2kwfULcO7ne
 Rq180QOKhngC7q0DMDgdm3v90vJhFRZnIcbwbK7rupnlb+tzDkFjRq+RTTNST5HyFKNWieO05mF
 9dH07LUl4cYq8=
X-Google-Smtp-Source: AGHT+IGg1pr8yKIdwoUXgMTgyox9GiariMgsZ12OYNUxsQ/HhCzItasjVkr4/Mt1HHI2dGRrFIZ2fQ==
X-Received: by 2002:a05:600c:45d5:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-4792aee03aamr83257445e9.7.1764891675371; 
 Thu, 04 Dec 2025 15:41:15 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793092c039sm52710235e9.5.2025.12.04.15.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:41:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D8F305F7E9;
 Thu, 04 Dec 2025 23:41:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH for 10.2?] gitlab-ci.d/cirrus: Update the FreeBSD job to
 v14.3
In-Reply-To: <20251204205025.2423326-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Thu, 4 Dec 2025 23:50:23 +0300")
References: <20251204205025.2423326-1-mjt@tls.msk.ru>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Thu, 04 Dec 2025 23:41:13 +0000
Message-ID: <87ldjhstly.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> The FreeBSD 14.2 job fails since the image disappeared
> from the cloud.  We already bumped FreeBSD image to 14.3
> in tests/vm in c8958b7eb4 (part of v10.1.0).
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .gitlab-ci.d/cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 75b611418e..a8faaf8d08 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -37,7 +37,7 @@ x64-freebsd-14-build:
>      NAME: freebsd-14
>      CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
>      CIRRUS_VM_IMAGE_SELECTOR: image_family
> -    CIRRUS_VM_IMAGE_NAME: freebsd-14-2
> +    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
>      CIRRUS_VM_CPUS: 8
>      CIRRUS_VM_RAM: 8G
>      UPDATE_COMMAND: pkg update; pkg upgrade -y

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

