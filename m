Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD7C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqx14-0005Od-Ta; Mon, 03 Aug 2026 14:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqx12-0005Lb-Uk
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:03:56 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqx11-0001xd-6J
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:03:56 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso5328713a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780233; cv=none;
 d=google.com; s=arc-20260327;
 b=aBeKwiDMTHmS7zB7N0WksJhXXv96U4wNnvt5oo0+rnpMvs7R0GxfEDrAbrXYtm+Snl
 qqk2ulgL7jtGQeRQ3Gk+GYuyXpVybzGoIRdIDCUrysMh9YHV53XhmHg/woXhAmvupUcS
 Axh9pry5gs9aqOYXpEoCIkqzo9h1ezkvZBazz6fhxesj8pmuUSCqoq4OISLbOvc2d/9I
 CIntkxngxMKWIHwbnwUHm/1/vwGwua23sR5LT4l89izpPg6h0uwkZ3J3dSo2ioBAtcdq
 cuWpcJrajfHe/TGVnRua3pdNc8GUWGPbNxPW8eLJ5OZkXwCvdj/WIpmg8Wpk0HaJ7giw
 h7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XngoENQlPTIFXB1Hcb2TbmZoVPBM7zPfK91Vv2+R1tc=;
 fh=h16i3VOeren5plqeFlaCrnhkV7gBXyQyuz2h2P5WdUQ=;
 b=X/EKBpSRo+wQEcoub4AIW9ukeTAaQHHES89K0hGLs/MNxX7eXjWv5+Pn7SLgOUZqx1
 KX/iTisVEvETmS554+36Uqs/pSf+zPAM+BoCf3ohjT2YdMaK8bciFhNyejkQHnklvpGO
 NJ5rJLybt2nzY248vs1HuvAombaUJHNRU4Ww7rPKTgcYKdH8y+jzUfHHYeDe45ph1U1d
 8NqmYQvcJ77AYxfWcc4dh/S7hpTRFi1o4e2alEfkT97AUrziYVyCRgSbiFtwFiFTh7cN
 Lqt2zB3MyEO56r8Rof1OGcMlRumIgvqBcqnoyG7I54WxzWxe+BLSyUJ/+eFWU9jv7e8h
 4LBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785780233; x=1786385033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XngoENQlPTIFXB1Hcb2TbmZoVPBM7zPfK91Vv2+R1tc=;
 b=hTNIkIR3qIzYZfpsQUGmiTfAKWwThyUsKv9TyNNwW7LaleqtzaDBbwTYbjNzWo4k3u
 aIKsgC5ZKJwkCIiKi516n0fFViwsr4lBSQUGfSvectNxdI2ta7YZqloS+v8esOp3xdTs
 /J66MFXdoF4Gqy/mon1bS5sfKfgF4NVx3LkEZ/j7NiHsBhKRqg0o5AcPpisSWZcUTzf/
 PXAm+UwknyuGDDTyJETsbl0A5XRU5snjod1+x8X+8utECUmn0jJz+aJ07WWk4eBWrpvP
 UedHep3Ysrop1hF8HS7gEv6NW+nkwxOAQIegwdWkOdZoKz1+jkX18T29l1NwGxOGJlg7
 DpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785780233; x=1786385033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XngoENQlPTIFXB1Hcb2TbmZoVPBM7zPfK91Vv2+R1tc=;
 b=lV3DJJB20oAFkpkTF1aDBBAEnU6kUYyAMlftfhMPEJDg7/gPtDYbbhQvlU4NEAuhRI
 Ra309YNTWbRfEPmjyt/gGlaw8Fb9UFBRxiK6VSDBtKlPcIY+KV6R2z04FThsQEy/25P3
 TmOAhcDxzsSMqT7pnlzVh+igHWvmFCrGPNMnzcHEbAjmCF5WZFmY9BZ8cySgEMWuno52
 je09SMKF3IvimoYV9fPvQ1eup4pgVyZ7XljiwS3N5nVSYovK+9fryIHEYu+aiO+t7sI7
 j4k8dU5PhMrG7mCBQp/2ZFdwK/myaa2f+e1eOcx+5KQKKsvgmePaUSJJg1BpKK+2BVx1
 EgIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ/lMmcQATePNoae2rBvprjTXf2P/BTXCjU1plU43e6/k2z2vWjGJrWmTLl/Dt1X7InKAIal9FgbqL@nongnu.org
X-Gm-Message-State: AOJu0YyV2ppZwPV7mB/3XwmyO+Kkpjj6LEhKwyPAU4iytBu+mz7L8ngK
 U42ki7X9jfYMuC6nJ+xSY+IS2ruCUIEpK5GQNT2iNHVGAfndjSADucFoHVVcaYsPNx0ZgWsYFs2
 u/Mht5NH4QMI0QBzYm8D+SbkUdqvCu10=
X-Gm-Gg: AR+sD10TiUCN2ZjPDVOpV7XTk/V1HdiQKXmlRwd2uMLIc70iSDKlnzLhUmKu0Xdlp8P
 ennXS6V+nSyA3TV2pVGO985MSCZz8ArANEvgt/ZDNXHbADD9/jP00l1EZIcgGik8ss+cDCEMQyp
 nt0AG5DPn48BftQX4ELPI82M1DKNRUpoAtpriKDCIae+Z/Bw9XnH9VrZtySes1HUvNrxByakyx/
 KbdFAopb/32ZukMgVmD6N/9j5GY3psXeM8w3ntbcqRPi2dLVJ7OUjfSVYHrUs05934IVsKkLoF3
 rxQ6s8A0LQtEUmSZmLHjuolQ7QirhVEnvTjwb7csDpZWkakG0NkrVcrw0Og4vRaF+i8FybT8psN
 xryPjzZoCzfT+Xw==
X-Received: by 2002:a05:6402:44d8:b0:6a0:567c:c2fe with SMTP id
 4fb4d7f45d1cf-6a0a7ce217amr7425412a12.20.1785780233016; Mon, 03 Aug 2026
 11:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260803174735.362574-1-stefanha@redhat.com>
 <anDVj0QcD5JfwT8H@redhat.com>
In-Reply-To: <anDVj0QcD5JfwT8H@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Aug 2026 14:03:40 -0400
X-Gm-Features: AUfX_mxM6rCKSJVS7zoGFnKk1jg58S87k_8yf9IVhRYnRSPcWqSd-37w0wB9KXU
Message-ID: <CAJSP0QUkz=q78OvQ7OnNUxqbRVQpwXY-4pTrtYUK8Lub+9X+Bw@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: use stable URLs for zlib tarballs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 3, 2026 at 1:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Aug 03, 2026 at 01:47:35PM -0400, Stefan Hajnoczi wrote:
> > The tarballs at https://zlib.net/zlib-X.Y.Z.tar.xz become unavailable
> > when a new release is made. This breaks the emsdk-wasm64-cross.docker
> > file that fetches the tarball and builds zlib from source.
> >
> > There is actually an archive available with a stable URL. Use that
> > instead. This does require switching from bzip2 to gzip since bzip2
> > tarballs are not available in the archive.
>
> "...from  xz to gzip since xz tarballs...."

Thanks for spotting this. I'll send a v2.

Stefan

