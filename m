Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E2FFD8FE4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfXQ-0007mX-FT; Thu, 26 Feb 2026 12:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfXO-0007hJ-FE
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:34 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvfXM-0008Vr-UV
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:34 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad79df972so1474061d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:52:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772128352; cv=none;
 d=google.com; s=arc-20240605;
 b=Nlc6E9UB3EdSdP3Akx7IoYqGk14Psc9QegcU8eR5B6OAJGs651MjrpiIng2fR+fwb8
 8Uq+VLVMdQZz1ElkIQ5IB1pwCsT7zklGvo/Vd5jmHkk4puQ/n9fqmQbphtULcGpnxxBs
 ilGRgvf8mtAmlY379ZktvU047qM007Rc5TtqMJIOMXXX6cXo00j/9NzMDjO+7baPZDlh
 W1KSDn8QBysByIX39oPjCrr4PspFUuCrknMPPsMb+4o7cw6UEyKJhI33HURN1s/sd7yK
 yfsH/DJVfEgDZ/Kie5bEX7IuFJ+o+jQJznlskFGMOCYBW/Q8VWC78bF+pF2rrRE0EBeX
 CPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bvgZT1pdvN1sWV5i4q+V5E2bmmd3IumBF2IGI/ai+XA=;
 fh=SRQlc7DCgygFOBv11PrxbJLVVjtVgcAU5BH1r8sN9tc=;
 b=LhFknHi36FutItL/0gs8HltUYy785aReBqkh0oZdpBk/UKcAbhgXJ65BkulLjfD/rV
 TXOHK7yfQZnSdNkczMlLlMKlMDvLEKNaq7Sds9K0HkQKdTDuLmYbR0EdzHLlRH0ilGgK
 5pt5JvHI8zsewIPGjFssR381E5AGtwgEVq6Rifh2MNkmEwaUpn3RU7nvZFmWj9PO+N0P
 9k4WMd5vzV9zEvKtKMu1+O+aOna4KUG3mEBu9Mq3QrR4p6cKxACa7g5qK4Bz1UXHL0nu
 FV/enUFvSHAm4zceY6rJnwJnGJlMosVGDqqUFGzy8vBXNgh8onRZ4Bj/Ave1KzwSSY76
 RriA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772128352; x=1772733152; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvgZT1pdvN1sWV5i4q+V5E2bmmd3IumBF2IGI/ai+XA=;
 b=whtwqQqDpYl4+hyhoX3Y2QdDKJFKMMAUgv2bMY7u+/uJeZAjo7ntY6UUapGq0L4o7B
 lZ+66FO3F/q+o6QPQMClSJTeu7SoU8s2iyumA8VJ9Pmxl/Wc2cz6YIEuj838GffSuvVK
 gU4M3js3kT0Xi7Xs2HQx3Z1MKv3GHW3p1xQJwYl0LlT4MsMIX98JxiXSd175N3Jj95u+
 jQeI8xaqX/8MROtx17WxmqOZdakVmC3HCWwUHX2licX3uof64Umk4JA2EAC8NI4jQquY
 1eJXs/IOYJQ3+C9rzydzJk5XP/9Ho5xTv1JoRuoC8m0XNPrwLzRpGl0vx7bJFA1wchs+
 Ogzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772128352; x=1772733152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bvgZT1pdvN1sWV5i4q+V5E2bmmd3IumBF2IGI/ai+XA=;
 b=GIgu9n7eIp2/al0DD03eN7i6oKWUxNSM8nrEnAtxTfcEcyZc4dJ6eNR7dswWl9B7wA
 wDOhA5uJDbmmdl6uz5dp6L8M6lVcgN2X76Cz0Q+o8rJej1S9PAk+HWdc3FiLv+LX5liz
 K+I29A+CGxIEgB+WpPeTSWU8qGo2h4aAFKewZG6waQkEQxaHwtaaVqPpcAtepGEy4TCV
 w+7ZiF5Ijw5yOE1kuapqEUbfz3COAQBpxhKDdnNxlLIDfFcQo4Jmpr8t1P6v/vvI+LGj
 1/DEnN6mFVDULYO7hR3xpEFMw+5lOuibKMJDXDrmY+P38138J4rDHJWPBOBHX8pCmZJv
 fPtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgP0hU1+kQFtOenZqSTHvmOsLpZSinvktVKXBybzRWRjnBpCgop0oIboqc5H5UoZFRfJxCUGcOfgkU@nongnu.org
X-Gm-Message-State: AOJu0YwtVlyJ4/5wNJAeem+t/ICIjes+4+yCdKzL18Z3cUiXCFY1/JCQ
 oHyEkh49gzCbHmin/zr5kDfbAhkn9YlP4ylvxVtDkugRid/zUW0C3c+ahvv3ubMpisM09gaVJoN
 XR2Qk1FW6IrvJLVajN3cVksZcpqV7uhrHuNXStW/Rrw==
X-Gm-Gg: ATEYQzwfhzjM4sh3SwSOO6pTv5lhqBJmiPdQmn/LTdaIpxCrOc0d+DONdlITobcXUlW
 8PCXB16wCE914y80aO4z9+wrN0Dp6BBou9No5cRXMYbpCENscQhDCybhGliIxYlD/gg+VI99xVq
 1yd1y9GxIg094K4Kmu/g92x48Sq/vd6gmXVkZcdEvgmXvyhCdZipdapWhJoBTdYJB8gWlVlsZ6Q
 ftHeUlLX+fDryg0tzrFVZd/4pPmRyrQTKj4Z2qCZeBxkbFAY5AV3xEwRY/sNAxvLdQ8nXYD85Iv
 4a5H5sVwxeYOBIs/zdc4s9rT3xa1Ln6CIlJCJFSyDSLIiNxFoyea28Tqyed0il70K8Ml+u9FXpl
 tXQ==
X-Received: by 2002:a05:690e:44f:b0:646:7c25:5f86 with SMTP id
 956f58d0204a3-64cc20e4bdcmr111487d50.27.1772128351729; Thu, 26 Feb 2026
 09:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20260225191255.955585-1-jsnow@redhat.com>
 <aaBOxS7bCODGq4Ry@redhat.com>
In-Reply-To: <aaBOxS7bCODGq4Ry@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 17:52:19 +0000
X-Gm-Features: AaiRm51t_MK1P2bBLygxDOkkGjMPt46Gw73Fn0mGQnO_41gCRYyTcDu7TE3cGNQ
Message-ID: <CAFEAcA-BHr4h+2U8DOU73PFSFSNakixeUSk_9iT9iCg6+f1X2w@mail.gmail.com>
Subject: Re: [PATCH] configure: allow PyPI access for python 'tooling'
 dependencies
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 26 Feb 2026 at 13:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Feb 25, 2026 at 02:12:55PM -0500, John Snow wrote:
> > We actually do not allow our meson requirements to be fetched online
> > because we strictly prefer the vendored version. Move the tooling group
> > installation to a different invocation that does allow PyPI to be
> > accessed when configure is run without explicitly disabling PyPI access=
.
> >
> > This will allow QEMU to download and install python3-wheel for you if
> > you don't have it in your host environment.
>
> IOW, with this patch the behaviour is now:
>
>   * Host  python3-wheel -> already works
>   * No python3-wheel -> auto downloads
>   * No python3-wheel && --disable-downloads -> fail
>
> previously the 2nd case there was behaving the same as the
> 3rd  which was wrong.

Thanks; I've applied this patch at John's request to git to unbreak
builds for people who happen not to have their distro's python3-wheel
installed.

-- PMM

