Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1882FEA83B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5LPm-0000WP-BP; Wed, 25 Mar 2026 06:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5LPi-0000Vd-Oa
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:24:38 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5LPh-0006ow-6J
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:24:38 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79a8e873ca1so9851967b3.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774434275; cv=none;
 d=google.com; s=arc-20240605;
 b=h0KlcCXUkEZ+3S/slmja2FN5xIsvbNSFwiLzacyUomDQW/5xpjC3cPYvUnBNp2wCNc
 mhLIRuAH3FQFCeCU0GjhbSiStxgKw0ai1ZBDm95lauPpADcW6cmR8Hke+ILm6mrpgp5+
 nJ/95++zX3WUk7mJ0XR1KuyRwvJW8xGU1eBtv0zqeEqhqc8YD+pEC5EieAtDtkwKiioL
 6BX1uo6JpXmBUZlRFTImqAENvYpMoZlwaKt5U3Q/wTJBt9njsqnUThvKVtZzt0WjoV5p
 tCH8VkR+50SbCV93KPyknY1UmvTh3R/XNpSxUvapmGu+r+ImCfuPYiQxz1ID5CnDaAvG
 j9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aQmc0dYy0Wh3SGltSJl7LCmqYiu90biNWpWo8t353AI=;
 fh=MgSwXghQJ4PELTALr7B2TiNgBRLUgy/oCeC7cm8iZ1U=;
 b=bLuPxWpYDHh2a3kQNMWZgYE7zDqvQr/Et4rNZRMZbzlC0DATqi6GzuLrf1Wr+8ZCzv
 7Mjo5/H1VcFkbLWMyyFfn6Bhhi0fDR8wMJoL+Ns15Te/RSJT9Igd6zTip593xgQ3sqaC
 BuWmTp5G+lAKPHiK/tqJ8VQz59O1y7sjljm0Eq/DVfXCOQK2aa/xmEPF0Am8t9vIAKyA
 xSHDCyslPKGvthZlbQuKbFtI+UJ18i+PAsmSVEmKcPX2RDYuNNA2sjC1p1oHWG75Yx2x
 M6OnCCO8Ld5MQstjX/RIUOgU3GZGITu9mTT7CZ4LECT9wNH9brl/4UqvLdgarFu91xw5
 iFWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774434275; x=1775039075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQmc0dYy0Wh3SGltSJl7LCmqYiu90biNWpWo8t353AI=;
 b=h2X5STqn6oW5Vf1zBy8S1Qtcsm+UEILNgonb+d/2XmpC3uwD8e1YKiEUDcyd/x4bIC
 34KALbceiuuVUm4CpM5g8VDMcZCiKw2xsayZY1k9RvXnSm2xx4ggjN0hjBsdJ9+Om2t5
 KrLuvxbWX/s2xdsABrSOnOQdfiUDIENeABX/rhT8UzBdeDsuKPO7yl0EOh0humbNzLod
 hdIulR4AQmeRvIFqd+y7BzWmMoiC0mNoV1PwEX82wlA6Xm9kZW6yOC9GcvB2w17OXtsl
 YXhCUb1faEw1kEH8jbSwQBI87PrvrqK8ZQk7lNH3YlkCSQ/hJpwtIGGTQdII8p7iuaiC
 HSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774434275; x=1775039075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aQmc0dYy0Wh3SGltSJl7LCmqYiu90biNWpWo8t353AI=;
 b=kxgMcbALu+Fk7Yhn2zVV4lY1fhPY1G0kPWdXMyUlhATTVUowJn0Zwjs1Gr+v+8sqhU
 HdG09hXCxKTIh3Ddd6W5wjjf9sSFVBJ1lX5iVJe/fUrncgEG/pkT/OrsEiGLqanAvlD5
 4z02n3pydF7qzIC31Al7IhfDUuAwxtqGZxvOFOtK0m5McIRBatnSmFDmkiW6ztPLe2hK
 DMai+1wJ/UVgh2hdqSFyyMcmQ5lsG1OeKJ6MXKsW7MS7SAFNtVxwWuZaPK+wATAOlEPK
 QWhQapW6VVxEhHiDL0BLkv9lyAKtcoEvmJ8vzKyKQCit92YLSmr1Zb5rMXACnrNjtVdB
 cYrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPEg3yGXdSkEbz2P9mRrzRDb3UQVF5XK65N0+nhI3XyEckoFzBbKzGYth+LzGjVcb3u+1craqw/lo@nongnu.org
X-Gm-Message-State: AOJu0YxQn0KCaMuk61I/x40WPJHia0h4dCOKmtzutf6Fx9cdSth6gUeU
 XI+BY6NBWYoPJGfgcv7ewz4Uh1swkdH2Q4NWs5Izqa4LJmE82E/sCKf4y0hJEFh2AHN7WwTpt+O
 JOzs3OJE7K7B1eoAV99ram41TYZtbCF/nm/U/tP/Vzw==
X-Gm-Gg: ATEYQzzEUsw67iAFGDL5ljNfYSn5CYCSwf2prIMpZuDdnFwrRV6PtskV7b+mfClFl7o
 GJsCGntRk2LbP+dK7aisvkYbowuzYN6W+9DoLvpSEVI9KbAyN8g455ScscHmqVvgS19B0Nb+iGs
 2YgDi0Nn11WIH9NuPgd0OEPmHoAClkM08elMX+m22Fc+k/wLkyt0Q3PtMHUf7QnMf7NnMKlrITy
 gBab+4iuLI8HNuLje8N12M2WkN5iIkhadNlIArO2qnwv6klJtlLDxgsRTb5kdPYjXM/5Ryy7dT8
 aYHzmmqSJvXoUB9Rb8XK6beJkFzJaq/19q6dQl9ne1Jto/0XjOCG4lQb4iyyZnaZNWg=
X-Received: by 2002:a05:690e:b8a:b0:64c:9703:a84b with SMTP id
 956f58d0204a3-64ee53b47b2mr2595552d50.7.1774434275374; Wed, 25 Mar 2026
 03:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <2c0d6ae0-eb06-4eed-87fe-0954ae59d951@tls.msk.ru>
 <fc32bb67-ea52-4244-9ad7-c18db3be339e@tls.msk.ru>
 <acOoVWw3jXfkfion@redhat.com>
In-Reply-To: <acOoVWw3jXfkfion@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 10:24:23 +0000
X-Gm-Features: AaiRm53eM4OCabwg868vwo2J0ALE5DEWQ8zclFMOt50vHfaCn0j8kJVDnwVC9aI
Message-ID: <CAFEAcA-Jzh0Wan9Dh+Pe9S3cHPeexV5mLaD+juXS8L9eMMd43g@mail.gmail.com>
Subject: Re: QEMU requires a 64-bit CPU host architecture?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 25 Mar 2026 at 09:19, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Mar 25, 2026 at 11:08:41AM +0300, Michael Tokarev wrote:
> > On 20.03.2026 09:45, Michael Tokarev wrote:
> > > Hi!
> > >
> > > Is it intentional that qemu does not build utilities on 32bit hosts
> > > anymore?
> >
> > This is
> >
> > commit 372ec46b9f1215f48a4717f2b7ed969f65bfadc6
> > Author: Richard Henderson <richard.henderson@linaro.org>
> > Date:   Thu Dec 18 09:56:27 2025 +1100
> >
> >     meson: Reject 32-bit hosts
> >
> >     32-bit hosts have been deprecated since 10.0.
> >
> > How would one build qemu-img and especially qemu-guest-agent, say,
> > on i386 or armhf?
> >
> > I tried removing this error message from meson.build (in $subject),
> > but it fails to build even the qga due to errors in atomic.h, -
> > even if these aren't used by qga.
> >
> > That smells like a bad decision, - to drop qga and qemu-img support
> > on 32bit architectures.  Especially qga.
>
> IMHO dropping the block related tools is reasonable, as if you keep
> that, the dependencies that need to remain 32-bit compatible ripple
> out across a very large part of the codebase.
>
> Not having qga though feels like a pretty undesirable consequence,
> given our message overall is that we were dropping host support but
> keeping 32-bit emulation.

Yes, I'm not sure we quite realised that we would be no longer
building QGA for 32-bits. How much effort would it be to
reinstate that?

-- PMM

