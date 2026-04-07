Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99D3FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACAY-0005cY-9R; Tue, 07 Apr 2026 15:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wACAI-0005R0-Hj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:32:47 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wACAG-000744-Pm
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:32:46 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65009bfdcfdso5791253d50.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590363; cv=none;
 d=google.com; s=arc-20240605;
 b=jW9RI4PeBz73ryB2GQCtRvtTEZScdu1ArovW2fkZLb8Rp/u17QtBWwA5zFqvimThac
 nCM2k+n+/OK+/zFGr1L2WZ0hodSdQBKFOFiQ0fJlRBt1HiwEiHTrlCDJakMfYdc1Y5a/
 hu/r2dCVcGII28R0xgVLd7U7bGprCS+T3AOiZNM86mP3LAnxFZXQv7EHcbQEqI3D5QLF
 d3u8/1f8ysVzFVzXZdmKc/ob7wSVWBWAx1aCCinB2rYb+uJ5y8NGSB/kcm+vXslp3rcX
 cmwX6oAHi8hdPDgINEUcELroQY6eDaQ4YOSDWR1nvgoxw1aNTfkhPCEGx37to2IUu603
 BGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a2XDJ7HdU+mACopPQGPPQUCo0r6VQfrxW6BsPjNy+ho=;
 fh=uMp/ZVuA5WVztNinbr4ZRc068dhHe8y3axHVKn5eEIA=;
 b=K84UHn5d+ghxcBoAzdZ0RwyMOyljkJyEjB8N6DIrJpuW70X9z6B6z1fU6v5i+vDBbO
 2Pf+3icbjf6fwNqf8y1sGr+Fk5IQkkHLepEgda4ivOc1cYkpSj2JdGa5z18pVA9/8nla
 r/vtHHEt4rw8XxMU5C00EwZx7ecUOBfgbXlwv/F7fWiUNAlwx2HEbfnTqDzQDjM7K8J+
 kqEhGn8tt3UDKEd2bdLUIIxN+UbJPqZcnk06lhYmNchX0ILS2OdOEFVrk3PxSyFhSo3q
 97cPJ0nHJyhaKgSan27QPzu4Fkmpeu4YQnVwq5y4YwbBpecbdefoDUayw6vyrBQiKaVD
 zb5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775590363; x=1776195163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2XDJ7HdU+mACopPQGPPQUCo0r6VQfrxW6BsPjNy+ho=;
 b=EskNZ1dVxps3bQ8FSa79Dia8UcSd0nl0RXouaoezF/FXUzdOjTjiPNDeEr9Ndd1zBc
 ey/cci9BnSKowK2rHK4+Uw4nDm9BvJvuItYD/23KprDDpKN0Irzhv8xguGoh60cRZIOi
 cgWAaVv2w44isPrGgDghZd24Ev4Q0S8Cs3xuQqLzSNXSbCE9N/Hh82cRxSO1/1dyELim
 hRIqy3WpkGhTRZVqw0eCDL51fqfjrpasIGNd1mx/rwJGK5Fq0BI+Nas/DrO3N0kirizc
 ZPj+sV8/wEV6si/qSAQ326zNqyvquFEkMTX6VQzcYsPjgvrtEMzrEma5vTgMO0GoJYxA
 x7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775590363; x=1776195163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2XDJ7HdU+mACopPQGPPQUCo0r6VQfrxW6BsPjNy+ho=;
 b=rVRJzsqZGSWfYjwyQlmE2zlAAe//K0IX4C0SdT4SV8wUb3nL5f+RedwlOy0KG4w9b5
 dEM7OqR8xupURDxTjL+/0NfsI9UVAXmVdTUil8+lDdw7mD3J5rkjCtiOffrTeGCF/2AM
 p7qX9YIjiNfzfq6U6/DFzVi5EWyl/Qr9ypxUebTCqD4Km2Rcr/HIddTwshZ7sFjcz4UO
 s5I6Ed2FJNaIzvnFTneLn+EXSxegLP/uGAPqIzIDrvGu8eCzYpt6v+4gjDUySqhBgfFa
 zC8e6dTlmIu252/y6gs6TWD8r8cRCwhaGrPenFjZzAoXHJcvruUgKfEBqfqDbdg4rXmu
 tPsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx9OuAZw9NImiQE0LeDQ+4o38lBTIcCxskCsPwPhT4QxUcojj3dz1L8fP4KMBLyXJzBEWuBGCO0C4+@nongnu.org
X-Gm-Message-State: AOJu0YwlEw7I+1VZiDOdUlT6EO8Jd+zJWGqj53DVJTNx+LBrJ+tE8Ai7
 swNjs2wIDaKHL6pXqfNn28RxbU7mmbYYpP5h58uzozwXNZkKeCPXZ8EvJX6AM0MzuubGjzr5kTc
 Q7vTblwC26R5hODBkg2ckDi8euY3bhi/ZjWr9lCB+0w==
X-Gm-Gg: AeBDiev3mOJva/A/yxTdKtTCXJE4OauLwtFkh0H/v8dl9Ww6QXeDrlt3IVaWyMcLjlu
 4Jp4kc0Bq5umffL9DqlpaVDSCcyEw8m7mxs5e0if0qV9Okgq3HZdmzv34HCLo/nY8R/WCsZ13cy
 888BSszVt0Be+twCBNhLDIUnDCLGaQS/5INdzCR0Sg+/oIGDT0JGZ7W3LMZxF2D8qMWaXlwIFyi
 hhmKWDJI/Ml0MDCp+NMGvcIrZttOnfOGS9CKM4cK3fc8z/ADp/tLUuurHYWaqT4a46S9fw9fD6K
 DAUk4E6/PbO/bdGQdH3NCsBFaR6gEALKVlSjYxAiJOmsw5dQqWo2yHa9VR5VK8JMMmE=
X-Received: by 2002:a05:690e:4197:b0:650:38c4:2df5 with SMTP id
 956f58d0204a3-6504888d785mr15416462d50.66.1775590363279; Tue, 07 Apr 2026
 12:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <878qb27dkm.fsf@draig.linaro.org>
 <518c29ac-0477-4a5b-a724-85f6f81bef7c@tls.msk.ru>
 <2c806426-3b9a-4118-8ef2-049422cc174c@tls.msk.ru>
In-Reply-To: <2c806426-3b9a-4118-8ef2-049422cc174c@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2026 20:32:31 +0100
X-Gm-Features: AQROBzCmspuEpEvUskB0clcCTWis10d7ZozcwLstvqW-5x84pMClAwa1Cbvb77E
Message-ID: <CAFEAcA9RNe8OoZSfg-T8ii65b4Vxz4bjjZDuyMBNxdaVeFJvag@mail.gmail.com>
Subject: Re: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent on
 32bit hosts
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Helge Deller <deller@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 7 Apr 2026 at 20:19, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 05.04.2026 20:46, Michael Tokarev wrote:
> > On 04.04.2026 22:03, Alex Benn=C3=A9e wrote:
> >> Michael Tokarev <mjt@tls.msk.ru> writes:
> >>
> >>> This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
> >>> buildable on 32bit hosts again.  The patches are simple enough to be
> >>> picked up for 11.0.  The one from Helge is marked as RFC still, but
> >>> I'd love for it to be accepted the way it is.
> >>>
> >>> All patches has been on qemu-devel previously, I just collected them
> >>> into a single batch.
> >>
> >> How are you configuring the 32bit build. I'm trying:
> >>
> >>    '../../configure' '--disable-docs' '--disable-system' '--disable-
> >> user' '--cross-prefix=3Di686-linux-gnu-'
> >>
> >> but failing with:
> >>
> >>    Command line: `i686-linux-gnu-gcc -m64 -I/usr/include/glib-2.0 -I/
> >> usr/lib/i386-linux-gnu/glib-2.0/include -I/usr/
> >
> >
> >>        9 |      QEMU_BUILD_BUG_ON(sizeof(size_t) !=3D GLIB_SIZEOF_SIZE=
_T);
> >>          |      ^~~~~~~~~~~~~~~~~
> >
> > Umm.  This is all mixed up.
> >
> >   -m64?
> >   -I/usr/include/glib-2.0 goes before -I/usr/lib/i386...glib/ ?
>
> I see what's going on.
>
> ./configure ...
> ...
> WARNING: unrecognized host CPU, proceeding with 'uname -m' output 'x86_64=
'
>
> And it use i686-linux-gnu-gcc -m64 due to this.  And everything's
> screwed up from this point on.
>
> I haven't looked at this in more details, but that's the key point.
> It is qemu's ./configure which does the wrong here.  Or the right,
> depending on your PoV - for qemu, i386 is an unsupported cpu
> entirely.

You can override that guess by passing '--cpu=3D<whatever>'.
Really we ought to remove that "guess based on uname" code path
entirely and require anybody whose CPU type we don't guess to
specify the architecture.

-- PMM

