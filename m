Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D364BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 12:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOcBd-0001Yx-Rs; Tue, 02 Jul 2024 08:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOcBR-0001V0-6U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:00:30 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOcBM-0006e8-Jo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:00:26 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4ef5a2f4e6cso1443190e0c.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719921623; x=1720526423;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dhauxnpLX5uvw2o7CLD8HXQv0pBl5P0T6Z0UC43nbpE=;
 b=MERy1c6n6pgQs9EMJSoN2OTgmSQkT8BXVBH1aCukPdw4J+8WkZROLWyaHYePjaTvO2
 N/fWJZ515bHwpCn/tDr3gy/yUo3yyLNYFagDACVcNNhEpOrubNedsts11lgCdXQjfYoq
 0EQkNyL/T/N3LAJ5HoqgmqnxiF9KHN74skkFg7qmFYnxH1C5MRyJJZYMnjkxepW0pv1G
 uzZukzzbNS2vUQgSp5gGuvC70x5KDVHuwdVbwB+VKfSTRpAY0bBTiFv4AMRgPBsCw892
 ahY/MxVlL2IQlp4b83utVljnK+w43o2Y3B6qHmmgaDO8J1504v3D7flpEMcKo+Pq+OzY
 MsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719921623; x=1720526423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dhauxnpLX5uvw2o7CLD8HXQv0pBl5P0T6Z0UC43nbpE=;
 b=leLxeh+EM+KzU7q5A36WjnyFV+DAfnYa+20+BB0q1VZtEgSkWm9FbFo3vS6jHgW0UR
 mFbAOUc+CG4k7SJBSZKqJ3kcXCWN416LeuwvoUbIUaTlwaLdLwzAK1cbkv3e/HdkgivK
 xAq5zjuU2VzcI0Y5l4+I7enfJZQ2gbXejI4CoW9JCEOf8eWHLGIonklZOgjPay/Hgu3Q
 glRx/XzEx6yvLEtcAliToYHyEcwxYpu5pEDV6Z9Ee8lg18bv7NuXqIBYDi+YlRL/MExG
 gJiIOaHE25JWPvCL+t2vU5KYpEVmV8cC9V/zRSdn+RjWBki/Ewj9V9HfSB0lG/A/w1PF
 o32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDsm7pXYW1t2eKT/SlYJDXm9aSjfHRcWZeWP0rkS4TNPZhDOSPaCiYphyBQVUYMfWOeAj43XV8WWd37ho5GR7t1oVOiBo=
X-Gm-Message-State: AOJu0Yz4PS0jNiO9fT/qVTBxnHXoPy3QZg2llXY1VKos8oMKIc8kV6Ys
 4JJJX2Z2t3zg4ugZILM8eSFc/qi3BKlv3VnVeb2lwCAHr7VfL8LlWNtnzGM775g1itrjQiQSoCO
 VjYuUk8Ulacz2gR2JybzaNaHWpcshhVNN8kIH
X-Google-Smtp-Source: AGHT+IFn+5U6Wwc3vE7ie90vXODv314MNu0nmYZDvBdZTkduQ/LEPDZBEbfwBeEkh+hLG9SsMCnU9iwn/GZlZzs9UG4=
X-Received: by 2002:a05:6122:3224:b0:4ef:27dc:7a9 with SMTP id
 71dfb90a1353d-4f2a5318a94mr9981006e0c.0.1719921623209; Tue, 02 Jul 2024
 05:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-2-c3cd3ee35616@daynix.com>
 <CAJ+F1CK7vghZRL3Uqw6eS_zvdAqQwzqS_MfDqzK2CwzsRMucOg@mail.gmail.com>
In-Reply-To: <CAJ+F1CK7vghZRL3Uqw6eS_zvdAqQwzqS_MfDqzK2CwzsRMucOg@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 2 Jul 2024 14:00:12 +0200
Message-ID: <CAAibmn1fGgFJTsFNzQ-WspNWmPBq=cHxgu+DTeKJ2UgmDQiX1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ui/console: Convert mouse visibility parameter
 into bool
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000064b82f061c42753f"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a32;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa32.google.com
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

--00000000000064b82f061c42753f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Jun 2024 at 14:18, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com>
wrote:

>
> On Thu, Jun 27, 2024 at 3:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com>
> wrote:
>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

--00000000000064b82f061c42753f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, 29 Jun 2024 at 14:18, Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.l=
ureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Thu, Jun 27, 2024 at 3:19=E2=80=AFPM Akihiko O=
daki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">akih=
iko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akih=
iko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br=
></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<=
a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.l=
ureau@redhat.com</a>&gt;</div><div>=C2=A0</div></div></div></blockquote><di=
v><br></div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil=
@philjordan.eu">phil@philjordan.eu</a>&gt; <br></div></div></div>

--00000000000064b82f061c42753f--

