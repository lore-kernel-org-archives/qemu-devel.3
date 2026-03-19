Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C00E109023F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Fim-0006l0-T7; Thu, 19 Mar 2026 11:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1w3Fie-0005ug-6C
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:55:32 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1w3Fia-0008Ii-Rh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:55:31 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-94ab69af6c8so1175711241.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 08:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935726; cv=none;
 d=google.com; s=arc-20240605;
 b=LVdx81AK0EAOYxKFZhrIPaaFsOtvb1EZPfxkQxMEn/iCgUThgjEhq6wfSNCLEmvDtc
 389UIq6ni/3PXbtN0De5HE5Gc3bxE9UuL5fkoGphuxQBzK3d52dYTMzRUf53zGy/9+Tc
 h+ES2RGIGv3bhJuAwsYG4I85spX5ejyQFi6ucdimG4bX2mQQE7GxCiOuwF0mtJvFjBXT
 +fjwdH8mS1mxSmVh3w8gLPL+Sls5uDDPTot7QCRyBC/5p1k//MFjXxBN2k4MGYLrN1V+
 4DMqqCvE1xTiYOmJl93Kf2sZjZNZDoAGmR2Px0FDC6V5F5/xPovH/1/lJenI23NCcEmj
 /8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XlgYIfHoSG9G5rL55PvyCEBY2yE84ACrXyuptIAwRho=;
 fh=2jG79WZ145mxncB014P+u62UDrhJmPq3csN+TaZiZvc=;
 b=kGzaY/4QEKIaUH7SJouFFHFT3BAEo5roMYXDEyUOql3dISe7P5mI2mTbh3yYqia27b
 HQuO42MGaryvFLk1ly0T12xWWAf9QKLYd/+00WFJT7X5/CKbEr/Kp0A4wZiW1eyjFT99
 2DX8c0hLoWuChMUuhGnwpJnrg30Gl7o9KfPWgLxpd2B0KdLG6+SLlM7U67D98jM/pyLr
 bLO3Jh9H/wzmp7uVaQkEUWDYmVZBDXWPPriY6AOhci8bRsA8wnjd+pIxmId2KEatZ+ET
 qxJwo8oegQq/aWtOdFBxT2mDOvt1ohBF3ZtIXy+TlV6GrDuEcZuhJY21ScvWTDCA36o8
 Rm5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1773935726; x=1774540526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XlgYIfHoSG9G5rL55PvyCEBY2yE84ACrXyuptIAwRho=;
 b=nC564kFoya5t9sLrsbZJcOm94HOtSSdVxYKaaViJ3u8COZia1er1QgB+D2B+vw+Mxk
 U55t/Ixw5XMFy83TeGwpRJCBj0KrmJwEX7V2YduY7pS0qabGuUtzWy/jePi6H1NZhU8o
 xgGPkta4GGafzB21GNXXw5IhsA9l9TcEf0kho84ctPvbkHJi6zwf5N+crcuWusslt9ep
 CO0qCw05xFVFALimhYqS3VbudS72UQqcoZdK9aX5CSxZlXZJIodfRdwFndIxitRf+i3F
 Oi4HEkfkfAsFfFAEIMLQJ5l+iRxzPXMEalGTLedbZcnkihbHtsE/HBLwyk+/yzrCrnvJ
 wwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773935726; x=1774540526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlgYIfHoSG9G5rL55PvyCEBY2yE84ACrXyuptIAwRho=;
 b=hcLu1hbcWtBuyYOIU0lz2ytL0kIHPyfBmCRyESOx67VV4s5ned3L66R6koNWGiA732
 xYgfQVqklGJzuc21LZqUO8anjgkZbSghcF3lQoNRcijJsS6xL3DxDiYMMLx5BSPOdBTu
 XrjfcWE2jsO/l+DUxUU9m8cWJ0i+8+pwZ5o6GnCsA1exSMAElXHYsHRhIGfywiDNa1RC
 Ep+lzL9x5MQjdSMsU+uFOeyPu57UUDnTmES/U31sDenogHufFUkODvSmeTYqfpqdTGYr
 HYPIv27RpanXka9eyCxbhHFpkQ0gJHjrjKI0GuUhnEIVQ3KAo+kkylt8qwgRv3JJU88D
 pe8A==
X-Gm-Message-State: AOJu0YzFHanSHUThSsMUKS69KAbBx5MlyjlmQS5QWSiQ58PnzirvNUVA
 V8EOLtIJDPYoX9luYU8jozkxXZovPD7mznWTp8D37/CEx/nbGzvyEHbkqKCoO9FQvKh2qMskPxM
 2w72tVYxalUXaFq9HlwkfoVRf43rCiQA6lA/LQEKoj+QRKif/o+gqn98I+bfBJ9f551+lJUD5vm
 VQ5FwcNO648yz6yHQF4AaQewkx4JDlijGMjlhhXBAfv1xKm4XpnErSVM0X7/L3ipsYzUAb1C3Jw
 eE6yoy2salZ6cxXgK8tNpcF6nmNDya+xAyTnUMWU+JeegvZ07fUZZn1Jw6Pljkyb3O+SLuPZhCZ
 DEkfTdtYGwmd7fIZ+MHkbTc9CbeofNDkyFZBpYW6Rqkqa1xsfWs7GwEPqdFDSzf49b5RnQC3
X-Gm-Gg: ATEYQzxisXHREzvjJLndpHIH6LE7Q9U3/TrD5Ev/Yg+b90Ozba+BMjEVxnrwTx/PqRe
 Nsj+5MAvfq96gqdrBpsOG7bi6UyNnUZsrDJqmQI2wvC6ALgk1NYLEDl8jP1gyR4mbJvPwjMizdc
 B9TA+tqCdlPI8PAuL11D1wzbpMibbe2WMwsAnv+pyiwMVR8mcpFZrTQxAacyYsA8y+bxALDu4BX
 9Oq8NrUEMpNA6FE35WVLfvq4RI3qxwTnk8wy8jfBILWePU0DnVUQRbO1rQDxcPsaTxjAFewoh/U
 EnpV+ZY=
X-Received: by 2002:a05:6102:6a83:b0:601:f3e0:9eb1 with SMTP id
 ada2fe7eead31-60294f5ffdemr1958253137.0.1773935725872; Thu, 19 Mar 2026
 08:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260306165717.3360110-1-berrange@redhat.com>
In-Reply-To: <20260306165717.3360110-1-berrange@redhat.com>
From: Avi Kivity <avi@scylladb.com>
Date: Thu, 19 Mar 2026 17:55:14 +0200
X-Gm-Features: AaiRm50H_Fo_WTBpozOJdqucxbHJK0kcit119D0Y_sBDZjMboEzVAbkNRJHNQOA
Message-ID: <CAF950WJuGSoAPy8FFJM5uLwxS98S-KefRresLdAtjL92u+a6hg@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>
Content-Type: multipart/alternative; boundary="000000000000cba3c1064d62987d"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: permerror client-ip=2607:f8b0:4864:20::934;
 envelope-from=avi@scylladb.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000cba3c1064d62987d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 6:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> These are both currently set to QEMU specific hardcoded defaults,
> and in common with other block devices, should allow user overrides.
>
> The pre-existing serial field should also be length checked to
> detect & report invalid user input instead of silently truncating.
>
> Daniel P. Berrang=C3=A9 (4):
>   include/block: define constants for NVME string fields
>   hw/nvme: report error for oversized 'serial' parameter
>   hw/nvme: add user controlled 'model' property
>   hw/nvme: add user controlled 'firmware-version' property
>
>
Ping on this, I'd really like to see it merged.

--000000000000cba3c1064d62987d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, =
2026 at 6:57=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">These are both currently set to QEMU spe=
cific hardcoded defaults,<br>
and in common with other block devices, should allow user overrides.<br>
<br>
The pre-existing serial field should also be length checked to<br>
detect &amp; report invalid user input instead of silently truncating.<br>
<br>
Daniel P. Berrang=C3=A9 (4):<br>
=C2=A0 include/block: define constants for NVME string fields<br>
=C2=A0 hw/nvme: report error for oversized &#39;serial&#39; parameter<br>
=C2=A0 hw/nvme: add user controlled &#39;model&#39; property<br>
=C2=A0 hw/nvme: add user controlled &#39;firmware-version&#39; property<br>=
<br></blockquote><div><br></div><div>Ping on this, I&#39;d really like to s=
ee it merged.</div><div>=C2=A0</div></div></div>

--000000000000cba3c1064d62987d--

