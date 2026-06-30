Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F5BC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weXMh-0000fD-FJ; Tue, 30 Jun 2026 08:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1weXMf-0000ep-Qb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1weXMe-00085b-44
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 08:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782821694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsgQ05J3IM9pT8gzR6K93v0u7ubw3BDuulLMWVi8m7I=;
 b=Np7Wz/SP0HeQCJ5ZmYmiyholDNa8qDsTLEH13E21XGNZWtmvpxnS7FuwBE/MA6xbhA3dJ9
 njOuHgrXU4ml+P1NipzKr8G34Yfde0aBQbMe2zDEQQkCw1frfsSxUEd6GDwV7RFJJgtqHd
 xpYJcyxdVJR/P7++ICtnsraXiqSIYsQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-CuuIn91YOcSOnYdXNOa1xw-1; Tue, 30 Jun 2026 08:14:52 -0400
X-MC-Unique: CuuIn91YOcSOnYdXNOa1xw-1
X-Mimecast-MFC-AGG-ID: CuuIn91YOcSOnYdXNOa1xw_1782821691
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493bc2ce23bso5448185e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782821691; x=1783426491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsgQ05J3IM9pT8gzR6K93v0u7ubw3BDuulLMWVi8m7I=;
 b=mhBf+1p+C4GkHrHWLhGKzue2+DUv6+ZtC2+6wunauCdUG6xH9kzC5mbvjBelvioQCg
 pymTB40JK5a8Mq4Gs7/2OnAY9AJ+5xvJzMJAIqjZsWaTDnS290KsPM9tDiUPPosjPU4P
 M2eDcptRCe0RzyOk12cogeTqKUdnaGlst421lftPmPSqAR1O4NqaaBoF/1rmoOd9W2kh
 +QX5ErINdEmhk+7M6cpP1qaz5snXHTIzTZCLLVJOiYnmmOsRGfWUkcTjT+xdS75YaoVr
 w5zG92On4oW/EmMuEDFuxuohMqfLgYJYQ990GH2i+b5VUYbnUhvxvXR1xaZH2AgdktbB
 ZhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782821691; x=1783426491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZsgQ05J3IM9pT8gzR6K93v0u7ubw3BDuulLMWVi8m7I=;
 b=f2YFxf4AGBwfiboGLk8wDyvf/ZvI7hggtLxuDJRpMGNKggEZD1TNac0DW7lSkv64Po
 QRtpft1wA80M4fPMOBXEFgvzmdis4yqaKG+z1ctImVQZNCr3rc08oB7bHEt2oP9m5Sa8
 qgkFxIjKzQzZVVHDM2IoxmDw6OOqS4SuIfizbK+DpeqMQb3Elpc0EAEpoF+wTXAFXEVO
 ONOk45Jmue6PoY223eBV6wMg7z1RtTSAFG0MWnQT/O5bQQ1GLx0h5fN2v8rppblajFrD
 WxSxmtJH06/TOJUkw6WbJYnAGp5UbQ3rGJB1Y2lKYUXJaBbdC8zGuEe4Qt2TDzD5Mh6k
 a5qg==
X-Gm-Message-State: AOJu0YyI/0b6Kdh6tPJwllVffdw2CTM5vhkKlLr1xLC3gNRlyLpX0uY1
 4fyNXrwyeprnGDrmqRXn42JJf4Zl4Y7U2OG1xYScgxj1fvM+kJclJx0sp9ClNjPjINbrXwJOkoR
 VXfscn5jw5NHEaXbyFvZMnu9JD0oKphe4Iek8xQbbI1J58AVhnlgGP/ii
X-Gm-Gg: AfdE7cnA4WQPApnix8v6MVGh40cWoJPLEY3wiUM34voZVO5IEb7okEpoyIUPCoYNNN2
 qD+x+3fI7qWMEorwniGK95Go3UINrVSNl/TwGbFHB+MD7B3KS4/RxWILOxv87upwqAmXklZuMqK
 SGTyki+y4jB8EQQZB2Vki0JFkkjdDyi4ToR3yE7zx9kUNaiBM/8nkrb2TA66cmSs6V8hj/LSaVE
 TDzI0Fy3HCCht4/wLZpfciFi3TntETee1fl0hfk5Z7+zxefnAbM14y4gdSqm8Ay96qShvwY73d/
 9YfIz3uj9BSNspCcAHHxCMz8EXByopoeEjc+f+qHZFVChIGjr/u3v6mAsaHXfqzCkkGytI8=
X-Received: by 2002:a05:600c:5391:b0:492:3fc4:bd6b with SMTP id
 5b1f17b1804b1-493b827df5bmr52379105e9.7.1782821691389; 
 Tue, 30 Jun 2026 05:14:51 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:492:3fc4:bd6b with SMTP id
 5b1f17b1804b1-493b827df5bmr52378645e9.7.1782821690961; 
 Tue, 30 Jun 2026 05:14:50 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cd88e8sm64261165e9.7.2026.06.30.05.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:14:50 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:14:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eauger@redhat.com,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v3 17/17] sbsa-gwdt: limit compare_value to INT64_MAX
Message-ID: <20260630141447.7cc20ba0@imammedo>
In-Reply-To: <CAFEAcA8DzTCP_z9mkHK7QHwMvk8bVb1z7mtN80MsYOZ49ZPx3w@mail.gmail.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-18-imammedo@redhat.com>
 <CAFEAcA8DzTCP_z9mkHK7QHwMvk8bVb1z7mtN80MsYOZ49ZPx3w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 29 Jun 2026 15:48:48 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 24 Jun 2026 at 11:29, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > QEMU timer subsystem uses int64_t, so WCV values with bit 63 set
> > overflow and cause the timer to fire immediately. The SBSA spec
> > defines WCV as an unsigned 64-bit compare value, so such values
> > are valid per spec and represent far-future deadlines (however
> > unpractical).
> >
> > Windows in GTDT mode writes WCV in two 32-bit halves while the
> > watchdog is running:
> >
> >  sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
> >  sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
> >  sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
> >  sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
> >  sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)
> >
> > The intermediate WCVU write (0xffffffff) creates a WCV above
> > INT64_MAX, which overflows QEMU's signed timer and fires
> > immediately =E2=80=94 triggering WS0 =3D> WS1 =3D> reboot before the fi=
nal
> > WCVU write lands.
> >
> > Clamp WCV to INT64_MAX to avoid timer API overflow. =20
>=20
> This bug doesn't exist as described in the current upstream
> version of this device, because we don't use WCVU/WCVL in
> calculating the timeout (only WORU/WORL, which are forced to
> 48 bits wide on write). This suggests that either you have
> introduced it in this series, in which case it would be better
> to not do that, or else that it exists in a different form
> in current upstream, in which case it would be better to
> fix it first in the patchset, so it can be cc:stable for
> backports.

it's masked by missing timer reschedule on WCV update,
that preceding patch #16 fixes.
So yes it's ordering issue.

perhaps it's better split this patches into independed series,
given that the last 14-17 patches are fixing native GWDT
behavior for Windows usecase (which would still not work
due to too large timeouts)
and that it's not directly related to this series (linux uses
normal refresh approach with native gwdt mode), and WDAT mode
peddled by this series work fine with both Windows and Linux.

With the last 4 patches we still need to convince MS to fix large
timeouts on their side to make native gwdt work as expected.


>=20
> thanks
> -- PMM
>=20


