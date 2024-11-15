Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669BBD68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy74-0000gq-LN; Fri, 15 Nov 2024 10:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBy72-0000gN-JT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:19:56 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBy70-0003cQ-Fm
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:19:56 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so2956311a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731683992; x=1732288792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLE5RhDMWOzzjcuKhyzIBM+Cr2nvJ31Gyh45omcf6kA=;
 b=fTZBJx4v+flT6dsAB87zuoxOFB3cyi+Eh0ZZYF+0kaPHLXS8r8SVDaQNFloMUeqygp
 3hrp4lfReLej43erW1tzo+3Ip0m4NiijONwGYuOju1oQC8HP7YhRN57DaWQ9vJGTcSoo
 URRSv9Q8+rRwJbauH5UANSzXBklf5snZsrZ+XXz2P19m/EGoDXVpzoIvWdTNxbEbbMmH
 OsZ/RhvNBgQPltm4ekBQwM52xMnK6BybXFQKw34Kf/bM2fN31btaL56KovHc/zPg4Fe3
 Wqe+tTGdy9TAuMvQkLaZoCFz8KLk9kpccZkYikq82A/t7IkKYs/UwTV1ZFftJoPnlvJ0
 M1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731683992; x=1732288792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLE5RhDMWOzzjcuKhyzIBM+Cr2nvJ31Gyh45omcf6kA=;
 b=Ez1mpexemVR2GqvavJQSPVDok728OCKtLyFRJvfVM1tn31CzR6taSztmgubV4/m876
 dkOEgZ8Qp4dzZR9JjQxNCfU6nujd5NAuutRzQdkR4P9kGKuYtv30dOy0kDfjKeJEU8NC
 DdWraDzlGKmaCM6e1L8lcUVhi1pigOue2Hl5/5NdOpWxdsW+qWQThGdhRXdIRl/2A/7W
 xl7qx7dYP2zMguXqWZbVni938ieQ89kGwvK/LWOsTOazr2vh3ffmBhJ4QQE1Ure/61+9
 Q9esZcl3Tl4kvZ0xJpZsDntwWCQcqclYQ+PD/BI0exy77Kw/ZrK0IqhxXj2w4YteGX8S
 9qIQ==
X-Gm-Message-State: AOJu0YxOdyIPIoKBqHSFSpKcfXvB2O/ihLDGZSfzh8I605R0Xv6FIW+2
 H7vkvWPSGFstZdb9rEbxPvJSNLLY+AewEftPIfy4t6K6piD59Bsfvl2jmJF8+iY8eJcowRAUMuF
 c6OxOuev7drsI5c9GCxUreipff2B+5g5Y1oeEVA==
X-Google-Smtp-Source: AGHT+IGoKE0NT9vy79hUld8kawTOUnaSCtI94X2i2WFEqWKpN3L1YHQT8KSVCxBHbLyOxO033HeucpjVek709wIY0hc=
X-Received: by 2002:a05:6402:2352:b0:5cf:40f8:aa1d with SMTP id
 4fb4d7f45d1cf-5cf8fc5d81cmr2567826a12.16.1731683991787; Fri, 15 Nov 2024
 07:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20241021190939.1482466-1-berrange@redhat.com>
In-Reply-To: <20241021190939.1482466-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:19:40 +0000
Message-ID: <CAFEAcA894Mi+WnpHKb=0odOSo4_K9GZnVQeBJjLW5HxSiYfRJw@mail.gmail.com>
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity" with
 SoB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 21 Oct 2024 at 20:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
>
> In recent times, there's been a general push back[1] against the notion
> that use of Signed-off-by in a project automatically requires / implies
> the use of legal ("real") names and greater awareness of the downsides.
>
> Full discussion of the problems of such policies is beyond the scope of
> this commit message, but at a high level they are liable to marginalize,
> disadvantage, and potentially result in harm, to contributors.
>
> TL;DR: there are compelling reasons for a person to choose distinct
> identities in different contexts & a decision to override that choice
> should not be taken lightly.
>
> A number of key projects have responded to the issues raised by making
> it clear that a contributor is free to determine the identity used in
> SoB lines:
>
>  * Linux has clarified[2] that they merely expect use of the
>    contributor's "known identity", removing the previous explicit
>    rejection of pseudonyms.
>
>  * CNCF has clarified[3] that the real name is simply the identity
>    the contributor chooses to use in the context of the community
>    and does not have to be a legal name, nor birth name, nor appear
>    on any government ID.
>
> Since we have no intention of ever routinely checking any form of ID
> documents for contributors[4], realistically we have no way of knowing
> anything about the name they are using, except through chance, or
> through the contributor volunteering the information. IOW, we almost
> certainly already have people using pseudonyms for contributions.
>
> This proposes to accept that reality and eliminate unnecessary friction,
> by following Linux & the CNCF in merely asking that a contributors'
> commonly known identity, of their choosing, be used with the SoB line.

This all makes sense to me -- we've never really had our own
independent take on the DCO, we just followed what the kernel did.

I have cc'd people listed in MAINTAINERS under "project policy"
and the more active members of the Leadership Committee to
bring it to a slightly wider circle of attention.

Unless there are any objections over the course of the next week,
I think we should commit this change, so it has my

Acked-by: Peter Maydell <peter.maydell@linaro.org>


> [1] Raised in many contexts at many times, but a decent overall summary
>     can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
> [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.m=
d
> [4] Excluding the rare GPG key signing parties for regular maintainers
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/check-dco.py         | 5 ++++-
>  docs/devel/submitting-a-patch.rst | 7 ++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> index 632c8bcce8..6a06afffe5 100755
> --- a/.gitlab-ci.d/check-dco.py
> +++ b/.gitlab-ci.d/check-dco.py
> @@ -79,7 +79,10 @@
>
>  To indicate acceptance of the DCO every commit must have a tag
>
> -  Signed-off-by: REAL NAME <EMAIL>
> +  Signed-off-by: YOUR NAME <EMAIL>
> +
> +where "YOUR NAME" is your commonly known identity in the context
> +of the community.
>
>  This can be achieved by passing the "-s" flag to the "git commit" comman=
d.
>
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-=
patch.rst
> index 83e9092b8c..10b062eec2 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
>
>     * - Check
>       - Reason
> -   * - Patches contain Signed-off-by: Real Name <author@email>
> +   * - Patches contain Signed-off-by: Your Name <author@email>
>       - States you are legally able to contribute the code. See :ref:`pat=
ch_emails_must_include_a_signed_off_by_line`
>     * - Sent as patch emails to ``qemu-devel@nongnu.org``
>       - The project uses an email list based workflow. See :ref:`submitti=
ng_your_patches`
> @@ -335,6 +335,11 @@ include a "From:" line in the body of the email (dif=
ferent from your
>  envelope From:) that will give credit to the correct author; but again,
>  that author's Signed-off-by: line is mandatory, with the same spelling.
>
> +The name used with "Signed-off-by" does not need to be your legal name,
> +nor birth name, nor appear on any government ID. It is the identity you
> +choose to be known by in the community, but should not be anonymous,
> +nor misrepresent whom you are.

Grammar nit: should be "who".

> +
>  There are various tooling options for automatically adding these tags
>  include using ``git commit -s`` or ``git format-patch -s``. For more
>  information see `SubmittingPatches 1.12
> --

thanks
-- PMM

