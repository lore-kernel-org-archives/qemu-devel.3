Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF08CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZo8-0005r4-Ao; Mon, 08 Jun 2026 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZnz-0005pZ-SQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:14:15 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZny-0001Mw-BS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:14:15 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6604176b575so3750399d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924452; cv=none;
 d=google.com; s=arc-20240605;
 b=D0r/YkyRrAmmZKlxePjgCjrKcIPEKks7Scfox7BhB+0CJ/oRYnP4LS/Mhl0pp9kCf3
 rHZNT5eQuIzDz46CWqubIfkDBmWtVCV7k7XnLbkduVLct3q7Ig0+pSJrVU+V+eNTMQP4
 +EU8E1qh6YySuswMMLNaZHKF5ehJvfV2Fdk5aQCHt2E/R9ECHIreQKTddQkPTZWcDViF
 CJrqZdZSkr8yuHXCXnOtalWlZjpTLArc/JhjKztsx+UaVINUHzLRDWvNhcFmlTVMVuYP
 Gaj7zhFcHZ1xd5U80kmdGa/xPkp8D2/FxisjI/h5k9OhrCL8ydcFtGo7gSEbvV3EUczA
 KcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NncB7jrcwjZa+2AeUwgi+mR8k00ar3A2idhiWuw4Tso=;
 fh=n8voE+KzJeWxBhKYZ4cXm0Dt8COf3qzb0U8Ea57bets=;
 b=cnDSeTW7HBnGMLCr5/ltYRqRpCli5AMHVO3+inJd3MK3CCIOzwHvGMupwXXKtV+OK8
 J6zCvlyelIqCeNC1MrcoFkF6NJLHoPWz6lEPhVwonVIKPE1UGl+OlCdyBjvNd2d7GRog
 Sygq4jkTC/9qt2dgDg7sIMdVyxtQ6CXakxHxdkWjGVvC66vPjBpwS00UeAjc8DDK4A9H
 JRKZutLnPzrhPeTNF54ViwTe4rSGFgceRfhnlzn0QTQbVJJTeSrpkjL8wK1AESQ0/Boz
 soSA0gm7Lh7msXGqE68rDyi2sbwlq0XA5z/dskkgVzywCBSayDjPAP5Lcv0UZB+lvNhK
 olzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780924452; x=1781529252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NncB7jrcwjZa+2AeUwgi+mR8k00ar3A2idhiWuw4Tso=;
 b=eblY65puFbLFYF8+1EnCufmWyDOP54lY1R5zoXWoH4hKpaUqoLhDx86ABU64D7UFOZ
 SLGSqcr4gM3qYV/INavcehCJRelXiw4Pjw5GbD+07jiuqE/F4Swe7vZ6UZPoRYx1/ZmN
 qPX3FU2F97sOXgfy1CZjoOdl0/eR6AAaEaUHcf+V3OB34+9lzkUm/CC6RrNXcbmvAx9W
 TSiYEhWYrErVdiaxXuk2DWqP/UGlgPbJmK7RVD99eReCFrHcLBGmGHrh5nKfZWVmgVp2
 Br4tIEQ1IK3MbNqTQAxWwzuJWckQV+VmNSrOkXnN7s20BOxV85AhW8E36RznkJi5nwdZ
 x81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924452; x=1781529252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NncB7jrcwjZa+2AeUwgi+mR8k00ar3A2idhiWuw4Tso=;
 b=KEyxEeEjC11H/5A2BSvBpLp1io0Kq+kpfP1uQzIQFFnFAqnziXgx0NvhA00mlqSDyf
 ndlYZr8oL6tooUVsTONVHwyDGy82y3WFI5UNEokIqBwvpb+EyCDgifv0Ebupy4ADXots
 +TPjQrB8UgO4rRbfBxZmUtfxQQUrfsI3/K5HnFhEiTMIkgIGabD3P/Yj7mTyRBhomhF/
 6+oxYD6jlJKW7mja/EiHFMjmqo1PiEuugXm2oUMBWDd2QJRu3yvRick9H7B2Ao2aDy6Q
 qU2aCreXVZ4y3wXC6wSug0DRZMxrVzYCYAnTMzj03+sATBNga8picHkifQYNxzmaK7xA
 JXsA==
X-Gm-Message-State: AOJu0Yw1WK19E5TZoJLgX4pu1zaFSvEhMqJ0kow0tXMYKUisxQZ6rAB9
 NtRel0wH0GBkXaefcfWDIcCyL29Y/VdRxzvpnINpG0C0eaLcXI1/gaOL2Pm+7vBdMM6EQuWLJTu
 0OOQt4a6ipJA6uRmKXeIAE2PA5nHGbvYXjPrT+4dxRA==
X-Gm-Gg: Acq92OFunTOeKYu7hr5W3hEv/U27ux+ecqrPgs3hcQfOPdGltvzfgPrFU012dGdS4Bo
 Rx90GhlF8BZ+0pxD+JT4M+G8vDfxEs30uwb+er22XwqtFpkumdoHGfVrLOTRKz2wZMfgvvI2UUF
 h08rT4Md/tqQ9WD8ySlKULMGEzqKQSgVxOuW8fl/t82Fyeu9rI1rBCF+mWwOgKLNoIt2LEfrjXv
 fT0lQd+FjBjJryOKzPueGPUo+9U60F7Hw51p3xR4qzpJhFegQ2wV9TzLvM4N4VUC7zCy+29LB8V
 D7sMIEaWWn/KZWQrBgi+HtHutV2gQrONKr1VXSMdoVVd1Xp8jnG9u6ye8O/Vc73P93gD6LbgXDi
 dYA==
X-Received: by 2002:a53:b118:0:b0:660:6f06:ae8d with SMTP id
 956f58d0204a3-6610702941amr11727589d50.64.1780924452476; Mon, 08 Jun 2026
 06:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-2-berrange@redhat.com>
In-Reply-To: <20260604165048.457860-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:13:59 +0100
X-Gm-Features: AVVi8CcV9pA0RgIADkiULP22ohaEvtRxSMqOonbRWK7Y2tsQ6chpskKk7SsCXoQ
Message-ID: <CAFEAcA8eW-gS1C8iV6cJK1vvfbSRFX02un-wabbHX7SfzahFbg@mail.gmail.com>
Subject: Re: [qemu-web RFC 1/3] contribute: reformat/restructure bug report
 guidance
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 4 Jun 2026 at 17:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The current bug report bullet points are duplicating an
> arbitrary subset of what is already requested in the gitlab
> issue template. Rewrite the guidance such that it refers to
> the issue template fields being required, where applicable.
> Restructure the text in general so that it is all a bullet
> point list rather than a strange mix of list items and
> separate paragraphs.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

