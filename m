Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074C3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeST-0002im-D0; Tue, 02 Jul 2024 10:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOeSM-0002X1-UZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:26:07 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOeSG-0003Yw-9m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:26:05 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e026a2238d8so4110068276.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719930356; x=1720535156;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7dwLDHsLu2o22t8xW0ACP/VA85rNwKuKRt0rC3E7scM=;
 b=zBOKlBkWWiL8dUnL176VS6p21V4sx19K0eC/9aVleddL4gxVhnWBuw2htZoxKpkVn4
 g/vJTbg3DrIfEABSMGWpgMVAgYjcABsCUtnXQXt1THUSl5tIU36mRcnkPSo3mWJQbEQQ
 6DKIklvNUFinXmdxOMxjXYQUVEVN9m4L2MI6iids8Fk8B9kaFNBQMoXFN0MvSzC6gGuB
 Kc9lLrG9264iMNwjrlv6+MLpF78lbpsH0JuZHXmYCoy1t7wkDhhIXTFxbTa1lqYciu8S
 ty84eV8/qwFTcCnBs53NlS81XCoPyPsRG0RV9AgvGktiHlHyWgLL08xu4KtkK6av+fvs
 h6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719930356; x=1720535156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dwLDHsLu2o22t8xW0ACP/VA85rNwKuKRt0rC3E7scM=;
 b=qt9CGl3JsIs0B7/eb7TyN3TlOL3g/gkVek8w6GQcot0fSIFOe7C6pgH5eE9AlXBmYQ
 OGXrZyeKBRQ2o+CcgbrDawcfm6Cr4xNdw3FXDd5zUVLcLvkeS2poYozDxfQrlDHv3fup
 MnilNQCzh/MbjFTUf5CRrAIf5KrbeDmiC4nJr0QPwncdQedoSBRaXpG+X3AHYLUGpQf3
 gfTWaiSMiYTCCbZb/vbXa+NtI/j59nsSTERxMnE+2RIBTPqHTtn5fKqzsUpB+j3jrRFB
 OoPDhme1ccnPHbCpaecTBniQaQOdBYcurhx5d+z+v6SPiZXakxenjndgcJs1sn9ubraD
 epjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhpw3UNpnJ3XTJPh6CJjQr5APkgnlNQDxN3SRi8LZMSlR3ydcuuHTN8AvAeSBIvkKLiLwio+vTKPKgelg4l3OFd2ZGqwU=
X-Gm-Message-State: AOJu0YwRy0vRLpZ7M8KIUgSricjrkxd4SViOvcRgYvOa28/bXtF72uPX
 tugnvYI+eZo1+z3RqUQTWCtJVbl/1uNX1O8+EefD1b3Igk8g3jjYsn2rVd5a3b+ilqTkrm8fCmk
 ljABDnYd7fs+9iPnTBqDRpg7gLZIOYUZiyWw1
X-Google-Smtp-Source: AGHT+IH4CuvTtR1Tf21I0bPPBJXqxpgpGQDTpdXdx1iFfsRcsQPpuFH/fUDqNswTeymyKv/a4MHvygyiYIVSbT4DhTM=
X-Received: by 2002:a05:690c:d82:b0:631:78a1:bb5 with SMTP id
 00721157ae682-64c73419043mr97958637b3.35.1719930355838; Tue, 02 Jul 2024
 07:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
 <CAAibmn0S+BvotSV6Sw-d17ybCu10a6Hgyu2sEUrJrzejHs9WZA@mail.gmail.com>
 <56d0c526-5d41-44a5-a737-e4eda60f61e7@linaro.org>
In-Reply-To: <56d0c526-5d41-44a5-a737-e4eda60f61e7@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 2 Jul 2024 16:25:43 +0200
Message-ID: <CAAibmn07-dRS05rgh9S2pV619AWpA00GFnnPiajCNs0tNOd72Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ui/cocoa: Add cursor composition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e61028061c447d9e"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=phil@philjordan.eu; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000e61028061c447d9e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jul 2024 at 16:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> Hi Phil,
>
> On 2/7/24 15:19, Phil Dennis-Jordan wrote:
>
> > I'm still keen on NSCursor support for absolute pointing mode though, s=
o
> > I can experiment with doing a better job of cleaning it up as part v3 o=
f
> > that patch series.
>
> Do we need a v3, or can you clean on top?
>

Sorry, I meant v3 of my NSCursor patch, not this series.

https://patchew.org/QEMU/20240625134931.92279-1-phil@philjordan.eu/

(That in turn uses the CGImage for the NSCursor as well)

So from my point of view, this series can be merged, and I'll submit v3 of
my series, which will aim to clean up the CGImage code as well as
implementing NSCursor support in absolute pointing mode.

Thanks!
Phil

--000000000000e61028061c447d9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, 2 Jul 2024 at 16:20, Philippe Mathieu-Daud=C3=A9 &l=
t;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Phil,<br>
<br>
On 2/7/24 15:19, Phil Dennis-Jordan wrote:<br>
<br>
&gt; I&#39;m still keen on NSCursor support for absolute pointing mode thou=
gh, so <br>
&gt; I can experiment with doing a better job of cleaning it up as part v3 =
of <br>
&gt; that patch series.<br>
<br>
Do we need a v3, or can you clean on top?<br></blockquote><div><br></div><d=
iv>Sorry, I meant v3 of my NSCursor patch, not this series.<br></div><div><=
br></div><div><a href=3D"https://patchew.org/QEMU/20240625134931.92279-1-ph=
il@philjordan.eu/">https://patchew.org/QEMU/20240625134931.92279-1-phil@phi=
ljordan.eu/</a></div><div><br></div><div>(That in turn uses the CGImage for=
 the NSCursor as well)</div><div><br></div><div>So from my point of view, t=
his series can be merged, and I&#39;ll submit v3 of my series, which will a=
im to clean up the CGImage code as well as implementing NSCursor support in=
 absolute pointing mode.</div><div><br></div><div>Thanks!</div><div>Phil</d=
iv><div><br></div></div></div>

--000000000000e61028061c447d9e--

