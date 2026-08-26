Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2C3C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDLR-0002xc-5K; Wed, 26 Aug 2026 09:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDLQ-0002xH-1d
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDLO-0000oP-Dy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787749625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x/lYZBT+/0tRp8Vwg234xElW1Y2yKw8rr3UqSvIP0kE=;
 b=gBM4F/BJr6lvbiC6eQ3gK8y6ItjUBqkI51Y48z9V7LqtYT9uXSO823VerZ7/fpQna+e1f/
 Vloab+Bvlz2udXh552mWBV7GSq0ztwVUREunKa2Sp8foYY3VYO26IACShc0iVY7JsVzRAo
 /kbou9s/i+V4mOfiDnVxKtAMxf6a0Uw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-iAVqlFGTNxqTjFl6WffTtQ-1; Wed, 26 Aug 2026 09:07:03 -0400
X-MC-Unique: iAVqlFGTNxqTjFl6WffTtQ-1
X-Mimecast-MFC-AGG-ID: iAVqlFGTNxqTjFl6WffTtQ_1787749622
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so1154455a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787749622; cv=none;
 d=google.com; s=arc-20260327;
 b=TpeZk7amMhGeZJvKhF5CTGFgG8NYdh+tQk8hr8VITHzjfJYx1GLgfZKC5Eejek5wOe
 vfCyym6oihw4cEZ2MlrNFPz3igDj/ASSCHkyIenirJW6ToOTz5eDU2ua/7ZfkpAKs5Lp
 NRqDyGNoGLv74RAmkSJ3KaK1ULVvdX0g4+WDs/top6Qan+M4NS3YbbyVWc/va7PIlg3e
 W4psxTi7evNRz6LoX4soaXkihm7VRbpbBOPnlm+Wwa8Sn3xzwTURqjCgCvNZv/94JCTZ
 y9UjfQ2YsylJv3g3vHUjg6PLVvkmwagBFIC9KSu4RCT2tK1EfQyUNbXRYnbqcs8tTpvh
 H7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x/lYZBT+/0tRp8Vwg234xElW1Y2yKw8rr3UqSvIP0kE=;
 fh=PcuXpK2bfC7EoNuuaJPQqLtQ9sEGkoQsnR4/5XYLgv8=;
 b=HIGH2H/WXrAwS8rLC8D5ZlwcigWF4ZxCxwjJ3LxEZxN9xmQIwP2t4qRlXh+xFfHXxq
 Flp3+++3wCdsQ8dEBQPSMzICjn8M7bCfUtKCMeMvEICQ34cIZEw/FWE/HmiwFsQSJrWs
 yUCEtOB3FBW3gOlxb4bRb3t2hVmIOr/SCdVkAwhhyHVbVvbU4Bbh0JoDEaW+NwBi6Ibk
 eVXhqofwCo/gNJjmflfCd0L20N8vkumMR3/zhiX8osDYOciTSDBDMXD3zGnabGldJrMD
 FPo/CAB7qoxqSe22zNi5YPBkMa4Hz9yapURlsG69QoZ5tTHPTwRRlEZA4Oj8G5D6QSo2
 Ld5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787749622; x=1788354422; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x/lYZBT+/0tRp8Vwg234xElW1Y2yKw8rr3UqSvIP0kE=;
 b=Szs9Nd75wRbjg/T/LubWSkawikzFQJFr5+sGSp1IDlWp/TQSaqfn30DbncxrcrGTGb
 sT5IuxiTUGS5sIBWaMB0G1yW4fKz7hooCIYkObxBF95fZLMNqLeUXOcfN9dmZTpeOVdg
 ZZoNieeTq8aTt4gHAcBST5+MZyPsBSV5RVlJfJLrmKAeS4yVMl2f0HxWwHEZGh7+Bgo8
 NvpHwq1wwG1oIIjb2S3bE1WXZVSrAB9js+OAFH42Ikn6CjZRIBX9PeTojePQ2Yjkrn6k
 DEoPEJ9zOtXI0D/FxhFiqpnn4sYiGWsZKftIB+cBe23UyyXbByVUo7SKJjvMzcv6jlNJ
 jhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749622; x=1788354422;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/lYZBT+/0tRp8Vwg234xElW1Y2yKw8rr3UqSvIP0kE=;
 b=cgmBl5IjglpHmfelAT+V0i8X4XtrMrdAzMRp/WbxmBTKq2zEw6iZubTM1qfnQLOreH
 T+1N5Wg+qAH4dsw06W5ilCYF2MZW13Jz6n6L2cNy3AFkuzqYdkR9tlZpayesMHuB59Ss
 dCRNvYTJULWfVntI0KIV/7YC46QQnuWvfJVBwTmMafJDlpfcGjKLWDZ3oc82wNdn2aqe
 tTqgdIS9UWALUYt03T3uRrrpUfeCt8TGlzqd0XshMofk8728KbYxGy4TuYgw6+y8tgHx
 QkWI0kMjV/VWFVaakdQdVGKpGX9eUTEuaUKT6ZQ2roRtq/6tUfUOcmXKPCR/tl7zfg2V
 d1jg==
X-Gm-Message-State: AFuF++nlzKYeMcNdPk/HVSTca5qszBZIc4Y3nM/mfEzc8Qb7GuoaakYH
 1vqoCsvsNw8IkfrZU9CFCRlSm6beFtgmcEl0tJisiKs3pmx2dPBuiWPxbyqQVa32+wMjQycb4/6
 Ygfp58ZSrQ8abuS+rBQbDZfNurUUT4WBCxS16Ocw0mKjnKY0mJld1dqf2yhFgPLeeswsIZsYIJe
 VmQmcwGI0DfBM71EZ1U9nMr0Vg95lx6nA=
X-Gm-Gg: AR+sD10P2lHyw3cfdwXFrWZ+C3Dp0OcS0QfBeRQ3rVeVWO0zifB2kpaDpTRB84cWWNr
 rO/JUHPPUx/iyRqUqkZ7BkeI3iyINIyGbt8SFYMBwCV34dBwtq6zA/JL/7uSV3K2NnzHkAAhYdE
 FaytR+dUvZtwg5Y/Cs5hGsKenq9UEoflZWCq5doVQrG8FFMXjIteLq6XqQfoat203c5tgqUzS30
 z3lWVmCbJFvUqp2xaJjWy8amDGSare60TxorIEXf6fNIvcbSkb+3pYPe3Z69keaOaj6YE26TJJ6
 Yg==
X-Received: by 2002:a05:6a21:998e:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3cf8465a25bmr10778269637.13.1787749621839; 
 Wed, 26 Aug 2026 06:07:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:998e:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3cf8465a25bmr10778097637.13.1787749621226; Wed, 26 Aug 2026
 06:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
 <a415e322-f75e-43bf-9f0b-beacdc04c33f@oss.qualcomm.com>
In-Reply-To: <a415e322-f75e-43bf-9f0b-beacdc04c33f@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 17:06:49 +0400
X-Gm-Features: AcwNN1UBaVhH_wa5YWzGEHJ9vpUnpZLqib41JZSqgLqWowLNEHgNayoUBvsFqak
Message-ID: <CAMxuvaxwjtQa+4N1_rTLK0PuefNCE3oTkkTFbGTaGi4AUcz4Jw@mail.gmail.com>
Subject: Re: [PATCH v4 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Aug 26, 2026 at 4:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 25/8/26 21:09, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > mon_cpu_path and reset_seen are only used by HMP monitors; move them
> > from the base Monitor struct into MonitorHMP to properly encapsulate
> > HMP-specific state.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   monitor/hmp-cmds.c         | 16 +++++++++-------
> >   monitor/hmp.c              |  9 +++++----
> >   monitor/monitor-internal.h |  4 ++--
> >   monitor/monitor.c          |  1 -
> >   4 files changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 6b1114fdaf13..6718fec97047 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict=
)
> >   /* Set the current CPU defined by the user. Callers must hold BQL. */
> >   int monitor_set_cpu(Monitor *mon, int cpu_index)
> >   {
> > +    MonitorHMP *hmp_mon =3D MONITOR_HMP(mon);
>
> s/_mon// please

It is gone by the end of the series, I'd not bother here.
thanks

>
> >       CPUState *cpu;
> >
> >       cpu =3D qemu_get_cpu(cpu_index);
> >       if (cpu =3D=3D NULL) {
> >           return -1;
> >       }
> > -    g_free(mon->mon_cpu_path);
> > -    mon->mon_cpu_path =3D object_get_canonical_path(OBJECT(cpu));
> > +    g_free(hmp_mon->mon_cpu_path);
> > +    hmp_mon->mon_cpu_path =3D object_get_canonical_path(OBJECT(cpu));
> >       return 0;
> >   }
>


