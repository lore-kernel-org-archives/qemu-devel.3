Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA64C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 11:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOc9i-00006U-Oq; Tue, 02 Jul 2024 07:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOc9g-0008Qc-Ks
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:58:40 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOc9d-0004rH-TN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:58:40 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-8100bee5735so180122241.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719921516; x=1720526316;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OdBeSRi4c4pSdkMqTRd9+J44UgUeAg/wq006TwLBMM8=;
 b=0nqm+Sqblar2wxgG43OGRsJDtngfWwONoJZ482qTYJLdiOQisckf2tmopHJUTBPCTR
 knChVcD6Z/ME9fPWEq3TUxZez+GS320pgm6gJS62D4dfGa6+98773aD5lJ594RLJQWY0
 oGLqWZCdqnQWK9JcNhZ2S+7tlGHtVjT31ZaqJJzJFdsSS75vnuNBx0NolKcRTth+jixx
 Ihz2BFJjQdLEqvMXaLYdUUrbDFZAEYv5EJTtyiHRezboLJBVoXcyBDgERK6VmWofU1l/
 SgYcR5gjo4MW+CKtgsgUMvXs4NBFC9HR7jX8K2+X/5jXV1n9EB6kVQQJtUyIeAWcOpcj
 XC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719921516; x=1720526316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OdBeSRi4c4pSdkMqTRd9+J44UgUeAg/wq006TwLBMM8=;
 b=mlC5kLmzFDhji/VPy2ttSuvfM67edT1s4RYfHB7dIJx72D6XOTG3IfJOs3CHzjLY1i
 zulGrAmOZyZxTSHXHAG15oNkaIdzVvvokrAfKjXMIr/pW62VT4YlvYHz9/E3xK+UF/Tx
 HEcw3+2EppDNwFI2cJgjSOZOAd5GNEqiyj9ZroTljESYeDKhkQQAxfmCCwinS5FRUAdf
 KfqNUeKr4wlGBAlbm4ajgUpTbOJ2RFNBPLQxyIF+7t9m9Ekh56bnuWmjTQHUStpmTFxX
 rafbGZ0UTGvBVDEPBL9Bg4g/hCfE2x3o3cHeVWyY427Uz0eXOKSstwRvYmXTCcHk2FeM
 WqIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoRx0GiipdeiYATl8O1DY1qOvlGlDmAagIC2juYSYS1kZ1xyxxY9Bioj3ORJWNkDvRZePfJzCl4QAc2//L/KO8nE+/0ec=
X-Gm-Message-State: AOJu0YyrO2dyOoYZJZ0wEjVv030DpVaiRm6JmxHBD9eYIICLMni9Yu9m
 EZWOarkDmYTQHoDWpkCQjkhKNr3XxEH661D2uIxm6IJI/KzY5oGw/5HD+oPRGc5+gwM6ZZkALLi
 5HPXB6vuCBgpm9esyksMSZ4TNUsySXc5XVVfW
X-Google-Smtp-Source: AGHT+IHb1S4UbPAypBoJF2EX2oynAG5/QHuYCc1rc4vrIlALlCeKOmo6AhFcYlE8Md0QsMdI0B1nHmMjtvolV3iFJP0=
X-Received: by 2002:a67:f1d6:0:b0:48f:5ad3:32df with SMTP id
 ada2fe7eead31-48faf0618f4mr6006442137.3.1719921516063; Tue, 02 Jul 2024
 04:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-1-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-1-c3cd3ee35616@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 2 Jul 2024 13:58:25 +0200
Message-ID: <CAAibmn1YzRJGHwKNu_QGFqqrNVWz1gJrALbz6C0uS3aqBAYtHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ui/cocoa: Release CGColorSpace
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000001cf53061c426f55"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::932;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x932.google.com
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

--00000000000001cf53061c426f55
Content-Type: text/plain; charset="UTF-8"

Good catch! I hadn't spotted the existing, shipping instance of this issue.

On Thu, 27 Jun 2024 at 13:17, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> CGImageCreate | Apple Developer Documentation
>
> https://developer.apple.com/documentation/coregraphics/1455149-cgimagecreate
> > The color space is retained; on return, you may safely release it.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

--00000000000001cf53061c426f55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Good catch! I hadn&#39;t spotted the exis=
ting, shipping instance of this issue.<br></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 27 Jun 2024 at 13:17, Aki=
hiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@da=
ynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">CGImageCreate | Apple Developer Documentation<br>
<a href=3D"https://developer.apple.com/documentation/coregraphics/1455149-c=
gimagecreate" rel=3D"noreferrer" target=3D"_blank">https://developer.apple.=
com/documentation/coregraphics/1455149-cgimagecreate</a><br>
&gt; The color space is retained; on return, you may safely release it.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;</blockquote><div>=C2=
=A0</div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@ph=
iljordan.eu">phil@philjordan.eu</a>&gt;</div><div><br></div></div></div>

--00000000000001cf53061c426f55--

