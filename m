Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7170C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woaKX-00018X-Ri; Tue, 28 Jul 2026 01:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1woaKW-000184-9p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:26:16 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1woaKT-0006r8-S2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:26:16 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-51c2149571dso33216681cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 22:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785216372; cv=none;
 d=google.com; s=arc-20260327;
 b=e6ETcWgS3gtLOqHT8ucCYeUe8lC/KQ+JOl31FXriD0VGd3ThE35nfl59iwF6dxyKnR
 GEwXY5ihL3Y9k21ZDdmeihGS+tbr+U9HQJxVhvY4wn9QKw79hbkJH0dRn4a8NFYwk4OW
 n/+ym+gg58hJ5C1lYeOCyGMSF5QnKpGHOPH3gHeoYPiKWUooC3vx9mLsEcJtxyE3A3tL
 yx2Zxz5FbXyshtzDzrQYArF+V4lShnx+eimi/e2kPe532cb2LY/mOW8jF0K+8KdgDjBs
 BAQb6poEnAea/dy5nNg2QU49hoE7W1+O0gpYUAvu0eXPebSpDYF3B96hkfiaAApJB9fD
 21oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lpIrAZ5pO1YTNxvl+Ecv3bG1BPpZ3Tv/Z8ThvPFI5sE=;
 fh=M5uHBkav1AM1enp1gnyJNuwdznHHEGqcL1zQRl+1jF4=;
 b=pZ1C9O1q0LJxJJXbLEf9tVbToTSmddBhnLQbW2Jc5gKg135dx75gejIXSPe/gHI+S8
 jhjYoeTj++Y49qE9rU0KwLuEwLAIy99d1ZE2OPxn7MDjlxhQ1AHSCC2jWBsMuJWFTuUO
 6wHskNCzFcUK19ut0I4TIFF+ENKPWfyqXMqHmXwzhmUQxq6AWl576scCTxgVKkZBQhRi
 pKSsVRElidD2oxpr7GZtp4cOvdZMQzIozVBo08qqUWQXMXn0QTqow3Y3A6H6qCeQaey0
 SocPSyVwvjIfkAH+AZMFo671+oVM23AiU3/8bUOe+TuZt1+ognhO+74matwsPdv2gD2j
 Pmgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785216372; x=1785821172; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lpIrAZ5pO1YTNxvl+Ecv3bG1BPpZ3Tv/Z8ThvPFI5sE=;
 b=R44wha3E7wfKdtlkMiLNcIZUtX3W3Z5F3mwtgtRUNGJBysXzCiImev6bIq/Cy8irN1
 nl6UCnblT4l09vhw4wEZcC6cUIa87kSHaE/7xUA+mUDvTW1sCaTbiRQ3JpYY/04xSHFo
 27PN5vUVReh1zmh2c+mVVr6BHf43ymt2H1tuW4NU8BrR53ac5ZWKwSHrpssTj39WljaH
 hWWExY24ElMYx3xWVnNXZojhUn/kro02F3R28fd6KsD79E1AeNSQ2lRFEgSbfrI5zlu3
 ECpgopEa99IvB73hVsAkcEHGZK59aXLvU/l5KcS81OACAtfUCUZYROFBMl/dRYyFxWp2
 g1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785216372; x=1785821172;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lpIrAZ5pO1YTNxvl+Ecv3bG1BPpZ3Tv/Z8ThvPFI5sE=;
 b=kwRtM3ejQ5aUZHI2BPAan4pK4ChxRzyhZ+X17f51KFYFVdD/Ixgbf0e9Z1F1OUgLIq
 o4IfJZ8dQhGgc6DKeXlxPr0POpoVrFeYNPAX3EfqRV1AQ7lPJ3nhGkB6gxNnbSHQoJhz
 4GZZ0WAur4/UpsvJGmnrZgU4mwMsbsP8AKvKOTKUmR3YFFyoXZIPvbmUB+b1VXhLHPyL
 TK3EkASN3mRkz6SYI3Vdu3CKC5zpowzNILq1F2flb5xaldZe0QPrsTSCn0i2ZB0Q7WAf
 80ImeU2ziuyQ7Wj3FPlVM3ROhmBsa6kR5lSIrNjRQs8INz+gX7GwwtS7cTxFXiVffSL5
 znGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rolo+ItBR4l94l0/eG1LzGIbnTcV1QYYlYwADvMfeKpfxktKYxvrnPAkvW7IW/I7capZYuHl/dE97ws@nongnu.org
X-Gm-Message-State: AOJu0YykZlDz9Z/LqUlDcQwOsC6XqE6N49u/SQdmiKlhI3mt/suUf/+l
 n5IE5kny4JEPhMZcaArE5adcHLa8IdtbHpfGSzu7BRNhE+8aQuWTFht4Vp/RrB0sNOUvU3Eid79
 gHjvXOuNTgip5/nc0K8HOy8eTNudg4lw=
X-Gm-Gg: AR+sD13ACI06R2AfWuU5s2CQ+hCdUGoy+jb0xvLomGC8MAu8vQJnDw9YGZmyfmy7P52
 YztX0frSEg+qIEHDJP708FnwQHIv0fRaem84R9PGK0ac24mHaJowMI1EovKdkbbVYxGun4ZcjIv
 Gp2boX1RtGhvfcTZtbsqM6kmAZwWPtjCnv9/bkUGTapXebVUk1lRJrXUPi7UC7FFNNyY8HR6jj0
 pAHbZIMONvuqEElpCp64bHk4JLP+AAzSpyqUbhdo0UzX5nicS5EED+cZLaTXtZxeHDQMIKHnXzK
 Y5672VT67SVu7geRbEZv
X-Received: by 2002:a05:622a:5590:b0:519:51af:febd with SMTP id
 d75a77b69052e-529d71a84aamr6706211cf.46.1785216372349; Mon, 27 Jul 2026
 22:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-3-6b97c439eb28@gmail.com>
 <87fr18diqb.fsf@pond.sub.org> <20260727184305.GB371693@fedora>
In-Reply-To: <20260727184305.GB371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 27 Jul 2026 22:26:00 -0700
X-Gm-Features: AUfX_mxSnt-GY0PnlCCWT0bk37gx1u2ZFNmXlCdgYGDEDSW7ZV0Vvi_HqTb52OQ
Message-ID: <CA+spn3qUx-cBFKxR7kGoLcJ7sUQqqiiHWfcGz3uu44Mx6L5DVg@mail.gmail.com>
Subject: Re: [PATCH RFC 03/15] backends/cryptodev-vhost-user: add memory
 isolation bool
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b89f790657a5135e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000b89f790657a5135e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 11:43=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> > Maybe it's clearer to mention the potentially untrusted vhost-user
> > backend process rather than cryptodev (the virtio-crypto vhost-user
> > device)?
>
> That difference in emphasis might indeed be clearer.  The main purpose of
this patch in the series is simply to provide a means of enabling the
isolation mode that is being implemented in vhost-user.  To Markus's point,
clarifying that this is limiting access from the backend process makes sens=
e
.

--000000000000b89f790657a5135e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Mon, Jul 27, 2026 at 11:43=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D=
"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:</span></div=
><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">&gt; Maybe it&#39;s clearer to mention the potenti=
ally untrusted vhost-user<br>&gt; backend process rather than cryptodev (th=
e virtio-crypto vhost-user<br>&gt; device)?<br>
<br></blockquote><div>That difference in emphasis might indeed be clearer.=
=C2=A0 The main purpose of this patch in the series is simply to provide a =
means of enabling the isolation=C2=A0<span style=3D"background-color:transp=
arent">mode that is being implemented in vhost-user.=C2=A0 To Markus&#39;s =
point, clarifying that this</span><span style=3D"background-color:transpare=
nt"> is limiting access from the backend </span><span style=3D"background-c=
olor:transparent">process makes sense</span><span style=3D"background-color=
:transparent">.</span></div></div></div>

--000000000000b89f790657a5135e--

