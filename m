Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48376CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMQG-0003nO-MW; Thu, 30 Apr 2026 04:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wIMQ0-0003mo-4H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wIMPy-00032e-PO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777536401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snZVnQoDZaVtQ1ET7rt6b7cDSDqe56B5uwNcf/nqDLM=;
 b=AvXdKRijlEgjWiOiCqKLYW6ONJW3QziSzYr733e+2OaHtkKSBpG1SLne9hAh8Hed+KbyyA
 URJzyFk9xXweOTNzhstcSgOeXNoBB+erW8+evLAZWxhTX7EK8bGFxtK/wR1LER1b6o1Gq9
 IBO6cEpwAOQnWYZ4S+1SYqP08+K/+rI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-3Ql5KDZROEqE8Tzs5iCZoA-1; Thu, 30 Apr 2026 04:06:40 -0400
X-MC-Unique: 3Ql5KDZROEqE8Tzs5iCZoA-1
X-Mimecast-MFC-AGG-ID: 3Ql5KDZROEqE8Tzs5iCZoA_1777536399
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35641c14663so773169a91.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777536399; cv=none;
 d=google.com; s=arc-20240605;
 b=Kjq1mGFH8kpJ+aEUZI8qU29TtUbrPEM8ppTCRP7ovA7GRDoFoHojCTpN88T8wj/r9k
 FJ3hmjYK6Rsx3dsG1axBZtEEfyqGNDRoep99Z5MwaMJlGk0BIPNBMqFjKAj940S2JYaW
 dQjd6u/rOFqG8vkd3NqdW1Ek5QjPODCbkldRQuoCM74Rli4aYiVlfp959rFMAIAmByN3
 ccn53Wa558qRnXVPumgBZc/YTAyOzeUA16E1bfvmt7WRoi3THO5W00fvEWrvHaL7EGdL
 Bmztg4WzOcrjO2SVnYkfYd1s18+AukJGMz04Xp78q7svfV5p6P4MeVkFfzC7OK5RcRae
 DH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=snZVnQoDZaVtQ1ET7rt6b7cDSDqe56B5uwNcf/nqDLM=;
 fh=l8EYjGkga9Y1bnur8fRa+nADtAuK2B2YM1OMwSOmkhk=;
 b=aniUyVcIW/xh/oAgtcURnk7UMbffds81/icLZYK9nHdGLSEQoK7YJtlsCWPDxG98gg
 P3QFo5hsElGa4oWxNKyO4EVlejOoiXrb+q2ifRDUoRveIwVk95yR+GeWm7iqF4pDvifI
 mel2hDEbdZK3B1oqMUWzcNPE23wlzsDCa7+VJQ1v8rT9qnKDEo5C8TxQI3vInkwwaNaB
 2qoSj8P8s+s1Brm2rGjsxZMn+62j3Re0v+OCVG2NtyVVMUkXm4dXX4tRb0nuSRi8uVos
 RLbBg+cKQl9gv0p6IQ0UNN6Ejrmx6n8iDFU4Vyfwjltk/W+d02czBtZiug9IT5ANFgj6
 6I5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777536399; x=1778141199; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snZVnQoDZaVtQ1ET7rt6b7cDSDqe56B5uwNcf/nqDLM=;
 b=hMs7XXb/lNWyB51hVKFCTfn43WOFCFapovaCHfVRly/sR6yNAF/XEUXXjX65TEWfn8
 10CjHm0GB0+wLR8JdZrnSucyGqdHfv8/WrazQU0R50DcTTm8acKNDA3RltdBnxcN57Cc
 YOHSyDhbDiM1rpXk5d+zU5T2Sv1uC38q+rF9W+2ol3E7sxp1k2f9kUV0v0U2QnDWECmX
 dxzSpW/Qekom6Lwa81sKbHpZsmkKVzg0iCedVOoou0CbTjGTMH8ITAZMWiuk24C8uUP1
 AejTVIiKkVR9y13qkb4uacHTfqdQU8fv55hd/WIZiG2LithgoXF3jLcjcfr7rT/rp1DL
 mkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536399; x=1778141199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snZVnQoDZaVtQ1ET7rt6b7cDSDqe56B5uwNcf/nqDLM=;
 b=BwIeiJvm3ZrAgpZaORQS3y3oV4BsyBytACrGzFHqDvLLC6pPrW+Eho61AOqz22cqqQ
 dd0sJN8Rx/Yg25ZmYL6y4OoYGaS6eCTUmmmJr6Y7PMwqwnnZUgDyCUFMD/hKRFOI6voE
 pgXnzi/uawC5Vuii2fYivYh/kmi4wapDurFng/qFsRL9yVDrJLzAMbbd3BB0ueJs1Cns
 6Vh3izuKU7myZ4vY7V/ekawkWM2fH+xIFGLuSez0FiBtzlc1ikURs5l3KkRAWdtWvAav
 8uDw7zPn6c4/Mm+Q+xKvZWqNqcdMMCT+h3GZL7OX/Gjkh4bO9ofMcYuytwkvB0cvtq02
 hurA==
X-Gm-Message-State: AOJu0YzNESY3WY8NLXXgwNN6AbRiM2LIFnlGf+xCxDGWVKtVXLIf1IxA
 /rupgmUPKpQf83At0xALYsL6f9Fs29AMW9IYXwutnpUZyfOa/PBpzBrx5be6qc1lVzHoBJWGJqX
 RoWjaiOBDk4Zfm+MPJmoNfL47emMY543rqPsgdR8Ebbq4B7WQbKZHhm3V8A0+OZy9f06R5r3wSq
 iL6JkCMwT8wNUnYenkzAkgMlGPWVD1dPoPzgKsBIawYA==
X-Gm-Gg: AeBDievEJ/rcR1AGIdn/pEWlYW8mM5qZQWsS6skQxtNjMqxvEqQQudYUNLdg0BQDfO8
 00h2QlvOruCRKyvltf4qblb4hZKn7+5untS7EGuC0OVCnn1PcVopBIyVYSeCIZBj5UsR08NeF1Y
 aB8gaLQRLaBs7HJY9e+7D/O5I+rAXveN5bExlncnWxibRRnd+fkosIlqXOAmubIwr8TPWFy2ire
 I8jwwN6BnAEmZ0zPPnO0/1fm8r7HK1vs3JGMN3JLZMDU/Y84kZPbFXFGfBJsakbHRsFaRSfO+bH
 n4YKMn01aiN0Z8dEkXZcUNOUF9MNehT5y94=
X-Received: by 2002:a05:6a21:3086:b0:398:8d38:c60c with SMTP id
 adf61e73a8af0-3a3cf7f1e01mr2139367637.55.1777536398985; 
 Thu, 30 Apr 2026 01:06:38 -0700 (PDT)
X-Received: by 2002:a05:6a21:3086:b0:398:8d38:c60c with SMTP id
 adf61e73a8af0-3a3cf7f1e01mr2139177637.55.1777536395831; Thu, 30 Apr 2026
 01:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
 <20260430-qemu-vnc-v3-12-be96757428d0@redhat.com>
 <e4c137e8-30dd-0d94-b21b-1040fef6495e@eik.bme.hu>
In-Reply-To: <e4c137e8-30dd-0d94-b21b-1040fef6495e@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 12:06:23 +0400
X-Gm-Features: AVHnY4JHwvZJrFzfBH9EKBnm03Ho_JS0D-5jFlH_-DNwqcxF9lYE0EZwzKOpdc4
Message-ID: <CAMxuvaxgfCGST_fzGCK4uHtAJ=x8zGQyL-Mswu5VtEtR1z55=Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/26] ui: move FONT_WIDTH/HEIGHT to vgafont.h
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Thu, Apr 30, 2026 at 2:50=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Thu, 30 Apr 2026, Marc-Andr=C3=A9 Lureau wrote:
> > Since those values are related to the VGA font, it make sense to move
> > them here.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > ui/console-vc.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/ui/console-vc.c b/ui/console-vc.c
> > index b9da9ddf30d..457d071c774 100644
> > --- a/ui/console-vc.c
> > +++ b/ui/console-vc.c
> > @@ -13,6 +13,7 @@
> > #include "ui/console.h"
> > #include "ui/vgafont.h"
> > #include "ui/cp437.h"
> > +#include "ui/vgafont.h"
> >
> > #include "pixman.h"
> > #include "trace.h"
>
> Patch does not seem to contain what the commit message says. Maybe a
> rebase error?

Indeed, this patch is already applied. Thanks for the catch.


