Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D8ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbZm-0007Kr-37; Wed, 20 May 2026 03:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPbZk-0007KS-CC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:42:44 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPbZi-0008Mi-SS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:42:44 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so4465457eec.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779262960; cv=none;
 d=google.com; s=arc-20240605;
 b=XC67MWTYPKMLue2skl7CCIG8y9MKKUv6OhVVma7CdEkVt6l0c80gz1CUF9Y0uvoXv1
 t24hZBD0JcVc6GYTECprIe3aLm/8TknQQ1//rer+SL8mIAjFfVHR14tWOFBUoolH1b2W
 FAePywrfp1LrZTHh6B2tVRNHoFDsVMuNfUJWrCBCsXfCShYsFjYEsJYueiTUi4kH9rWi
 zTA/8liXh31gtbYcej6Le7diKDi7iMPSP6d0KSKLFeVFLFgSkQAhqZrgGsfzoMg+6dn/
 bLkd4+60/PPPCbcPskPAbZ/5mil+hyjzlozFuvlUIlEqlEUM1BivZ1fIDGyoOLZvhcQu
 e3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LLvTiqnLMGczF5R1K3mJC2DJeygJ+p5TdTN24JCwyFw=;
 fh=cOsNULT/G3KmuphHDOpmhJ0EqPaEyNDPfyDGSK/csWI=;
 b=aEydD1c+2A7r8rQvlDr6MgE3jaaXgkqLEuztC8o3mNpKqVfkYwOBFypFdTl7kwKizy
 XRdpf4F+vVq5/ltjuBXND9pka+jNXNdDI+lnrHtj7yK2oNP1IOTwNsaD1KYWvtsaZ7Z7
 1SqGbFjYEvB60ZTAWUoIVeYTvptVRoFXhiLXcPQH4hjgO+NFmlHoAo12opJj/zrI7afm
 9Ct9QX5djcIoyumvNLsbZQfKEJM8pvzLViuSdC4qqiQi/Z3+Coed0j59ydevJPsRhKkJ
 qbFPLM/dkKIBH2VEPh9mRZ9V4uttvGtF64dnZM46V0iDagazfHYn6UWif/xqcBjmfUjz
 aaMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779262960; x=1779867760; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLvTiqnLMGczF5R1K3mJC2DJeygJ+p5TdTN24JCwyFw=;
 b=sx4J4emo+Eig0K6bQ1pIaKZ9FcP9wAs8NXb9oXBBEFHGwb+oDVhpyMRDbhZdY59k0r
 f49tKgAXOYxnJPd720ucoJhhWN8YFa/ZGSNHNQW4bsjhsVCzWd40b75a1Shi4MZw4NIf
 MJBNiHP1uDtc/nKRuFLVsT9zr7Gl4AkavFU2QZNKjLLKy5+eNWWpfGLDkCSmlujOaHwH
 bjOWUO8WifTHeVJ+9mv/Mcg0YmHQuu5kCbOvjELNCBDmJ4LYPhC+ct1hCLGxoULbpgG0
 KuZUA4X2A8MQs2F5BsTnUpn+wkrQu67FN8wIDPvMBKg020aH3OxPKNgHFU0NY58ONTif
 WhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779262960; x=1779867760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LLvTiqnLMGczF5R1K3mJC2DJeygJ+p5TdTN24JCwyFw=;
 b=Pw+bqALQcjqBrg5dRSJRv8jJKwTZtYYpzES7zNpUY5FDkfUifKth1iQbmZUaQ7Jx+4
 EB6Gul6jpBKn1oEoe+J0PA9LU09a4JfHCVj3Yxl4H7KeqYXl8X9DmUr2vz11HvfZWqKC
 xEnHqpyvDx9YqIcyB/PS33INliCzKMYfCXPmOD1W4MTHXCAwiOkmfOgAXh5FCZEepRXp
 mMGK/qX3WPefAN4WEBN6ysu2w2o3SDAgfodWb3jq4bpkctYlPbCi07edj//dkgAFg/ao
 Vphy9bxETcQdoMuolrr9inesaYKoRPMiJ2iOPltT4KfPWiapcIfHn/O8Bqv+qIvdzs8/
 2qLg==
X-Gm-Message-State: AOJu0Yw3LuZHMwKwgX8XaiMmziHX/39Ndze7qMaA8A2NoEpdjVP+qRNC
 IqGo1neeFhTPxmRjCBBkQz/HyLAdEV3T4wJSyr72HuzUQVivPBM6EDgFnr6IjkFW7M04gYaNwW/
 YTI2gM/aBs+PcvInuZdEPDL47iqG9Y4c=
X-Gm-Gg: Acq92OFtQBD16FtQhh48SMsvTdXFK7I+OKfFXFZgCOC9PX7W+gEyxRPAbPaNoZd5m3O
 KmV1E3Er9lc3e1pXOTep0zal+p4gJ8i12oSkuNCftzYgrzGMNKPCXa1bly3rjmAe7/+bCWnsUxX
 GK1k+N4v5qkvzZ1DZf6HPa1TVGN9AGIopOWLhXXGemSb4PxcMWrQDfVa4ggl4WZw4a+Voik2oJs
 CzbaZP7VEfm6gAB/FKp8bhMNw3HAF8wjUtLMpFx1ZnwPaiK7YfzHs+fOm9zFzYpqCSh1hzMrrfx
 CbPawgFwZybFCn6kf6OuDPSTYBarqjG1Zm11en4=
X-Received: by 2002:a05:7301:608c:b0:2df:c5bb:3720 with SMTP id
 5a478bee46e88-303984edb2dmr12944761eec.15.1779262960018; Wed, 20 May 2026
 00:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260520002645.1910740-1-dongwon.kim@intel.com>
In-Reply-To: <20260520002645.1910740-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 May 2026 11:42:27 +0400
X-Gm-Features: AVHnY4JGFAROnVUVgXAvzbcv0uKBj3GpgPGMzzFrhQK8Ryd3u6lV2YTwXaNnuVs
Message-ID: <CAJ+F1CKt2Xf5KK2tCSa7Dew1iyYn5mrdM3Qh2aj5C6hi79DoNQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Fix focus loss on re-attachment with single VC
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, May 20, 2026 at 4:33=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> When QEMU is launched with a single virtual console (e.g., using
> --nodefaults), detaching and then closing the detached window leaves
> the main window's notebook without an active focus target which makes
> keyboard unfunctional on re-attached VC.
>
> Fix this by explicitly calling gtk_widget_grab_focus on the active
> VC's focus widget during the window close handler.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 2c61b601f7..8eb1a80377 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1475,6 +1475,11 @@ static gboolean gd_tab_window_close(GtkWidget *wid=
get, GdkEvent *event,
>          vc->gfx.ectx =3D NULL;
>      }
>  #endif
> +
> +    if (vc =3D=3D gd_vc_find_by_menu(s)) {
> +        gtk_widget_grab_focus(vc->focus);
> +    }
> +

Looks ok to me. But could you share your test case? launching qemu
with just -nodefaults doesn't help reproduce your issue :)

(fwiw, I have a bunch of patches pending to fix/improve dynamic
console handling, I will try to send them later this week)

thanks

--=20
Marc-Andr=C3=A9 Lureau

