Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD2CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZqB-0006k4-R3; Mon, 08 Jun 2026 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZq7-0006h9-Cn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:16:29 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWZq5-0002XS-Rj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:16:27 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66062a414fcso4608009d50.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924584; cv=none;
 d=google.com; s=arc-20240605;
 b=JpbHdpIbYAOJw/o9c81mraLzGj2jiq768g5FrdQhuvQ5V/LMOOhq0rmXiU7eOy0T9C
 XC0tHlQciJvIPmfdqqLwgfBywXwaUVmYv9bHtExcYbC2VUThgQAllWESCiKYCA6a4e3f
 S+LXIg/mDW5z96RdlI4v4TN2lqzp7Ca4mKuq0Bv0KXxOpPQraPHgkBs1xMfxf6OLFRii
 HhvMb3xjyTNweiqtYPPAVF6xm6i06sLe+5eJH8p1B7Ko6Nj6tR6wo+fHyGN/uxREY49F
 Vr3qniRBbsR6/DAeBR1NBk6gfHz27sULHLRRpzxSZ2q+SMHjS+uUgvbcwvOdknyUBGsC
 ULJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jBzpg9t3jDbJ0o2/QWOSsQQKoXtMujFYyNGlf+di28s=;
 fh=n8voE+KzJeWxBhKYZ4cXm0Dt8COf3qzb0U8Ea57bets=;
 b=T7DGg7vL3sbFwv+TclBvXZcyL0spqc+XPERfIvLpRwfhmEglUJrCCxmzYcY5WS5Yoz
 4JyzlY9nlg8skq1lg61CE5440xoETM/hwPJTa/4C93l8zmqT0GoMS8aC1bdzEmtnh7iB
 v2wJgf5URjSM8+0jVO8XrbGo8Btz/q/SBO8Xng4bOiD7z8gvACRAdUe8sK6Dl3njsUjT
 dPImSX7csgGZNv5Gc8x3y1K/HOUq1RvsccR/rigTMqkjom0ZGocZcBTloiDt2jMChoUB
 6rFZAh5f4BDZ9SltUJp1MpjqE1CgJID3veKnJaMjScceBH0Qw+kP2CGxfkykU2w8y9Pa
 G4ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780924584; x=1781529384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBzpg9t3jDbJ0o2/QWOSsQQKoXtMujFYyNGlf+di28s=;
 b=z4FzX493mU0hvX+JjsW+FXVBc34jVG0Af8nSRHEK7byTYyvA+Fa3jeIez3uNegtCuj
 Emvrz4ufsw219JKF0Uay9BmYUuNA/Z+goE+S2v5RAPuWIZWK+2HXuVZ6sHxXEcRokEQ7
 IZSfDtLy+vXigrVkqbrT5RG7Xc4jSOXsVoU7N9/cZE/1Vek8VF6Kf1jWbFBHhA8Ou7e+
 0bQFgPh93dhkmvQrGUFRIF79bLk0+EKcHg+4DXspZF9ogpnBjJXOoc44o6kVyfupOI7f
 aeZH6qPBCE200mdlQfnBMKKk9fZZYMS5lFge+7khrsB1Xa+Q5M82uLC/Ewlw9DnLdCkI
 dNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924584; x=1781529384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jBzpg9t3jDbJ0o2/QWOSsQQKoXtMujFYyNGlf+di28s=;
 b=s1fdP8jbTWPh9wX7M3RHyiWDXUBXq+xPOe15qZ0ZyKfOLVDe3CNWV7FF24cTyrEFe+
 TLt8Nvou41tC2Lwpktp1wMp4GfG23O8u1BHIa2sDKANVYWwwCuC2OMKLN4pS9hNYv2cA
 HR74qMnN/6urqwbT6ptfo5BYsX7Ucw9i0xJH9AkdHDDddS6aUzq1Dl8k1vwyStQBfVUN
 qU2nQRiWUQSw5gU69UTTpC1lzZzqkMBCsEuARm/CeUv7pI5C9oMYnpxG3HYxr8HoVC7F
 B33zym7Wuappki585Glqmog6BxWWFiDxgO1ycd2lh6klK4ayYMNlWXpgmAzAz4KU+ng7
 6eeQ==
X-Gm-Message-State: AOJu0YyLQlnTjD3DdTEWZ4bayad8YTIBnqXQqdyntBUAlN/7LNoIfNAA
 DrIE+abh8VuPrxv8X3UezNbsciGkNJKm/x6H+4T+Tl6gimHm9plTAGXwh4mgZK14AnYqegpXdj1
 0Oyy/OyMYB1SZncfGeFyiGRnqd5epnT76DCa6cnAX2ZxHGbqokBI+
X-Gm-Gg: Acq92OF3ZosLDBFSHweuZIJeSpDt9y1RdN7xdowSROMhzX5C5lH+z4gStdxWyU/lo3v
 7HF8WQY2tClAqKcJGY7f2Q9bg4qhHlf34q5VL3RlnGrbiPezxNBSrbv9cmywiaoF0bI1w2/9+8y
 Cn7OoDXO7GkR3cDeDYS2eelejUvxvRoKdSBCQyb/U0YKTkxRDqx0qB0i8Rn2QVPojUJE4RsKk1f
 cpv9LPgUNrzcg7MrrKlYmZOWOLMQjCAeRocIJd7+mLNSi52x7a5HSZr4aMTci1xQydFcIMZaZD8
 tt6n2ehSF3UpzZSLrPePY/Y6yf8/qOd/vkXhYgbobf9U/8KCVTNWM4/fu9XVGvI5BuuPp5l71sW
 0/+b9QZrYFd2R
X-Received: by 2002:a53:cf06:0:b0:660:4538:2333 with SMTP id
 956f58d0204a3-66106f8a900mr9087005d50.50.1780924584332; Mon, 08 Jun 2026
 06:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-3-berrange@redhat.com>
In-Reply-To: <20260604165048.457860-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:16:12 +0100
X-Gm-Features: AVVi8Ce9U8Gqo9tdC98j8V-dXTu04h9J7M4DhaxnM7-xSGew-msp-VuQlaBt50Y
Message-ID: <CAFEAcA_ZQv9uDqMD_ztnnFwVXkdVmhARAihqXRW8+x=w46F0Bg@mail.gmail.com>
Subject: Re: [qemu-web RFC 2/3] contribute: add automate tool disclosure to
 bug reporting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
> A while back we added a requirement to declare the use of any
> automated tooling used in discover of security issues, and set
> a rule that the reporter must perform triage before submission
> rather than blindly reporting issues. This applies equally
> well to normal issue reporting, so copy it over from the
> security process guidance.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  contribute/report-a-bug.md | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index 6071837..fd3bc6b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -20,6 +20,13 @@ on GitLab, taking into account the following guidance.
>    to the vendor's own bug tracker instead, or reproduced with
>    an upstream QEMU build prior to submission.
>
> +* If any automated tools (AI/LLM based, traditional static
> +  analysis, or fuzzers) were used to discover the issue, the
> +  reporter is required to declare this at the start of the
> +  bug report. Users of such tools are required to perform
> +  triage of their output to validate all findings and reproducer
> +  scenarios prior to submitting a bug report.
> +
>  * Reproduce the problem directly with a QEMU command-line. Avoid
>    frontends and management stacks, to ensure that the bug is in
>    QEMU itself and not in a frontend and make it easier for


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

