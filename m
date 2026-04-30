Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E72ECD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITpo-0006hR-Vm; Thu, 30 Apr 2026 12:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITpi-0006Zb-Ao
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:01:50 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITpb-0006kX-VI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:01:45 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-651c366f7efso1187104d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564887; cv=none;
 d=google.com; s=arc-20240605;
 b=SxBHbtUU12ZR+0W5K1iNthEhtEK2ziVA9z78REHv4NcFuZemOyxG6HU7VRPgA8vZcd
 IjWRlRsAFFf4Ako6pogA2om6UzNofixzpCHLn9tQuY/qER9qW+8UL/GtDGs3dUpwRYHF
 MoDt/LRlWPw69q90PpXGg0fApOf34nQ6x6Bwfy+NhBmRrfjYckLqrek4PWdp5w6Lh+RZ
 8CLEBT58OxFz1ODp/a0s383BsrTmWxMvQpDTtOABqCmbOIl9bxEiUuv5+qr+7fjWqX5P
 OrI0kTkAaAUdjLcUYDd/OMnFinhRng/UR2/ddHvEsV/5z2aJF+FlylCz8V+L3mXGf83K
 4JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Nqmuu0q1VA7O5p0Fl15oGxxc/q2JB2NepdreunCmFY=;
 fh=TGBch+i9L9x+vQVJeh6H3Zbat5wVEME4NP11pLlUfvk=;
 b=MhnOfYpHKE5fYTXm0D7w5T1TM2bYt0S3xEK6AGNi9lZujFVd5+EoSmYW4a5Ldj0K5A
 pQ6aFj4AT0TKAPat4BegLE3Th7KH2ls46Fiyhk6vCtqOKObVxbZIQ+neQ/lQlT465mMX
 gumCp9/7Nxt5Fj+zxKNWZK0+oXFcoaO+tkaNW2Ilq43jglkq1df7NJQGA1fm1Uq1qZc/
 nGTBdiCSlJgiwcNJs+HzXPX/jNAuj6Bu2PVccIwn89FI751D693YxLxB4EesY0BUKvEg
 amoDSh1VRaFzkmkJyoytQ1CMdeC+bWM8Czp0pusLnYtNfq1iaDL80+l395cBqV529WHP
 OKrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777564887; x=1778169687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Nqmuu0q1VA7O5p0Fl15oGxxc/q2JB2NepdreunCmFY=;
 b=JlZAjSbuHBXBrG+PV4WzOdDP0WqE/NtMiYtwbtfyat8gN/76Z0dMSeHec/uOZXFd+o
 TroGpZL/xlHH39FjJmCbuTxbLbM9WV5NJLEX4o9Pcyt8XmTk/0ZwqreYHcHgKi+4ZP58
 OXdKncoIt3Z/ZmZSH0VjKd/FGb/liOwWgaGqfDtjkubYhkibqorQTIBsunvwIRY+RPdM
 tBaIJH9RYhWd6zalL7D61Llnpw1oDthEZzcJ/GYwUBHh9gzijWpHuENyReHU5Iy0GzSr
 F6qRFk7rpD2iZZA+VsV/4+hLVuknEJPRrxopQI87/VoqYBbPGejdo1yVq+3aF+C5oYuk
 goow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777564887; x=1778169687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Nqmuu0q1VA7O5p0Fl15oGxxc/q2JB2NepdreunCmFY=;
 b=cHDtjZxhDikJh9y7oxXE/ss8nFYdND7bXePDQXRaqZ4njWLfIPA8sYFF9uZz+opUF6
 Y+b4ugi+qbbLwzQqr4et3ANiunCrW2vQ4Om0r98SYshZA1XqL1ax7wwTjkY3AD6j/woX
 Dtd/ergtjkNXht0su8eTrxnDOpWVxc/O9vHjw1DuWS3xZIywjQuFvR/Ak7FH4cnkJUAX
 wvXr2i7715zxPxVovGBEm3BwudELsU5usQp2+OIRX12nviw0whIy9MzY6PEtdTl5WpFb
 AK68gyskBMzZgVuDpQhVjFWRt+eOj8BCLxp+/tbx8OQBb/3SFWUKbToNUXnjSdPCGIoT
 8Deg==
X-Gm-Message-State: AOJu0YxYan72oIaBfnHg573qlEYNNWJz+6F25vIj0lrhlPKOZQRl2nl7
 Go+HntysDnZWS+duaUkFtvfIKBUGVlvtkXRnubdjKJkCVQ+9Dgihgy9pbrNA3kv2WjnXzklEl3/
 CKDue5CXCereGjqNgQ6CgnNjIrzKn97hlucR66NRwsQ==
X-Gm-Gg: AeBDiesHDAGlFXRVqk3muoPYl08+ZstVF9+9nqCZCHNxasSXS0WF8MKiijkUTt4926P
 X6bZzlGqDiXMdCXGUQw+QMITs+6KScrtJnatpCNYk/zO4w5O+AqK6wPylLCSydHu3h7sFrMctai
 /5Zehj+7TfwVnHe5Ywrc1x9kBISMSNzY2e/OkIaDWgwS1eRAe7Rui7dzisadjfXpXeEozlHCHRP
 o9ntfAjuFexLQIhLbeAP18hY0XbUqbNUcJiJG9YAg0EDu4pfj/p2Z9pvHSQm4CdGaJgatpbfkUN
 a7ZshkypoS7KzdsWqQLZVuC1ydJJFRLKWZfihKFwNENr5ljIGi4/OuJQ4+dNDy47JTis8lh6ody
 AzpaRale2S/Is
X-Received: by 2002:a53:ad4a:0:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-65c18de285amr2133354d50.34.1777564886022; Thu, 30 Apr 2026
 09:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-27-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-27-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 17:01:14 +0100
X-Gm-Features: AVHnY4KD53D6a_4F67aZzj5GNKzQNWNF6lzGEl0DrXwLi4hJylMBYawgNBgPUZE
Message-ID: <CAFEAcA9HMUcY2kVXgwxjZTptAtyhbVfFq4rPSp5buQ-9jvS8mw@mail.gmail.com>
Subject: Re: [PATCH 27/41] system/qtest: free log path on finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 27 Apr 2026 at 20:46, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> qtest_set_log allocates log via g_strdup, but no instance_finalize
> existed for the qtest type.
>
> Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  system/qtest.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index cf90cd53adb..e9e5773341f 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -1020,10 +1020,18 @@ static void qtest_class_init(ObjectClass *oc, con=
st void *data)
>                                    qtest_get_log, qtest_set_log);
>  }
>
> +static void qtest_finalize(Object *obj)
> +{
> +    QTest *q =3D QTEST(obj);
> +
> +    g_free(q->log);
> +}
> +
>  static const TypeInfo qtest_info =3D {
>      .name =3D TYPE_QTEST,
>      .parent =3D TYPE_OBJECT,
>      .class_init =3D qtest_class_init,
> +    .instance_finalize =3D qtest_finalize,
>      .instance_size =3D sizeof(QTest),
>      .interfaces =3D (const InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },

Doesn't the chr_name string have the same issue?

This pattern of "the object has a string property, and the
char *field that backs it is allocated if we give the property
a default value, and the setter has to free the old value
and strdup a copy of the new value, and you have to remember
to free the string in finalize" seems to be very common.
I wonder if there's some way we could make this less
error-prone and boilerplatey?

thanks
-- PMM

