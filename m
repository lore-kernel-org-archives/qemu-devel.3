Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4CAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 05:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6LId-0007YY-K2; Tue, 15 Sep 2026 01:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6LIc-0007Y4-3l
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 01:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6LIa-0004SV-FA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 01:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789448498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBrqglq4flft72EVnM04vqIxhf6OQ2wyvpn6jJVGRIg=;
 b=C6GrHuiBRV5xpIQemlCOOIIx/zQtwCtFtD3huH4x+B/HNFFtJAX6UUVs37dke97Puh9PpW
 S30h/6A7XPEf8lWorZuQIX+PprhUSKNq1FqtMe2Kc6Uzp6z9acDNgsmNAECnyjnsYQwiqA
 AP0o7i8b/ASNBMY55E6BjN2pMQeYJVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-FgOV5GWpPtuyDn-p0dHwbA-1; Tue, 15 Sep 2026 01:01:36 -0400
X-MC-Unique: FgOV5GWpPtuyDn-p0dHwbA-1
X-Mimecast-MFC-AGG-ID: FgOV5GWpPtuyDn-p0dHwbA_1789448495
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso37511195e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 22:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789448495; cv=none;
 d=google.com; s=arc-20260327;
 b=OtTZ7+liQNZSnFW+RQyYEgMdEHb39MEY2KzSvM4+vYsuPHnHt6xVxgqHKuQDrH7S4T
 3CHItYKo0iKObzyu2iW97o2NZm9LhjhJ9XgQTegxQ4utvb5wLdv716FXBllJ0DgkuseX
 FQFikVZm/zU3aCxOnvRM01jeBy5UyQZS+cbXPpFaVWUV6SXSkX7W6q233db9hSWwDRyz
 KcUZZG9M21Pv1JOEh9jhWPCnaEwoeLOqCN8mabKLiDmnCab+tmkFC6je89ajJ+/YaEE/
 NeX9vkKMAdcCDlwuOjIQ4J0Uf2k1xP3b6Ms85u0O+/b3V99vJM2bgcKSAC1ej9ABkobf
 QMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gBrqglq4flft72EVnM04vqIxhf6OQ2wyvpn6jJVGRIg=;
 fh=7vszRuysf1zG5MUmJSHwZZ4Oc2xNUHP1AQWBpiovVJY=;
 b=jJK5+gRfqnx/i6nMWSXC3eNEUQyOD9WcBQO7BKFgxUeaK1LGZzTIyAf5uz/0F1Qj3N
 HZUxDwE5kNG2QR6RY9OvjCT/5w7ie61jHeaWjCOThaHawEPrY2SZ17ubfz9yzozbPyVb
 WeK/RtZYEVs7PhO3WL/5m2EJVnbrpF5jKID+09a5B53h6qHgytm/owYTNADuhc2SRiFm
 NCBtRmXKypbIK4gfsV7eD/j3kCQh+LMyOwC1TAnD9XZ88hSPOJm2/RJZEL0ulg6/127j
 lgPx+6n38dpfbf4wVKT5Dx5dehWkiXDvD7HAd8hkZSFktGhtDiK5q+XYNHPJFS+q3JTr
 qViQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789448495; x=1790053295; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gBrqglq4flft72EVnM04vqIxhf6OQ2wyvpn6jJVGRIg=;
 b=EymHe8/p4eJr8OpEsuWd3JoW01l4nlks/NPELt3hZ/j0iki+0kzknXH/aP1UAV+eGV
 /HfCTSAQFLHovWq8Tn/omteqsRZECTQ2gIJWxpu70q3ysIGOdwqzzgLrnpC7DUhFxBKX
 JbWfW8dG14ytjEuzf1WJXxKyKiVmdtf8i9mG6zmDfglir79nscHdvSbdys71zKm4Aptk
 P6NQ0bhTrAzJdKY6Sp1z88iVXHqWqMrNK2B6h0PHryGBukMdoYBPiqbterX+AQ7gbkFG
 i2scF+OjciwnZSu+5iC663F9jEDj9BjqPamECx3TQz6mBu63XYBUx/d8q5S+PClgMUxP
 HKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789448495; x=1790053295;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gBrqglq4flft72EVnM04vqIxhf6OQ2wyvpn6jJVGRIg=;
 b=XF2qHy1Yig0hzKRZK8wFicaOnfSUiuBe5pVrzJgMSquqHxNBkkMEyCgeRjpfPRPXET
 heFZqqWk0PjgAEw/lIZSWguS7jdAB7ECCTUFkatlf/oOULxY2INZhRIb+SKnxqVBoLAU
 aogk33uEKqp6Lvt+OVWhsnv+wwRxS4Eujtv+JTFuhMWy9WQmW/iEAyQ1ypcF9KyOngCz
 jAi3QSOZs7zZrylQ6nZeVCkEx/hnLePagdMvjK0SkPsbvOOJGrQKZ/BQxIgPUGl/s6I/
 fNzBWl5ZagV1EGQ+/Duc696CqskW9pJkgoSJe0zm8yQJSXgFMdq3hq9j9qzO9Xo4Ad1P
 tvoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycyG1PItdkQyNlHgERYJafaPeKlOx71LoCodYCnTbX/vgQkOxWNoOVGZx33tdYGm9fD9IZ14THcVfM@nongnu.org
X-Gm-Message-State: AFuF++nv+IkWwUL0A5mIiLq4z7AMZuWu6u07/fyntbKDIjNb6uRWdp1N
 MLZTDkQZ612KBGyaZBAXuxQI5P26WTa1s072U92bfxWxJIXGDnglrg2EGO5xM7Dsd6eqetNPW20
 hFNpEe2+kD3jNVFNDoVLqPkrc4m/J5+eS2NU/RGFWWi3NcfVf4DMyopIo1jxbI4oy3Zi2KJg9ot
 3ysxY79wwPDzTllhrLIfmbyO0UrlU4rwc=
X-Gm-Gg: AYBFou3butUQ+moHM7F3liyn23wZjF1hyiIQG2+r1ms7K7ahohcChwMo9qtUal1q2ze
 Kjhq/2/L6qgh3lMQFzr04pnL2jKM04+L9r+7DYcepmLRnI67aZkGh/gE2ubvd4RWGnMJAJ3rUIY
 9ltYRP0VXoQl1pwxiDZttfbLChboW+Mp68aBiUEuDD20d8r2x5Pv1QxftjM0s8K8kMBnGay2PIJ
 /917R+R6+9hkXo+0cQiR2YsYa4xxjU+HaBhKaAaMTZQ/9H5s7CRiarBJ2+6zA==
X-Received: by 2002:a05:600c:4e41:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49e7a65cec4mr68678785e9.3.1789448495486; 
 Mon, 14 Sep 2026 22:01:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4e41:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49e7a65cec4mr68678465e9.3.1789448495090; Mon, 14 Sep 2026
 22:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <ccd9e4ad-2469-46f7-b60e-01c21fa99953@oss.qualcomm.com>
In-Reply-To: <ccd9e4ad-2469-46f7-b60e-01c21fa99953@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Sep 2026 07:01:20 +0200
X-Gm-Features: AcwNN1UVcI2tJnKTIGe11pHymYU_TAlvq9Z9B01j8xGPYPUWHzRNa-OcBv9rj7U
Message-ID: <CABgObfYuT3tKBHi_qsM1w17ZCH=eKigkFejY6O8jzhjHMx638w@mail.gmail.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Aniket Sahu <asahu1x@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, Joshua Daley <jdaley@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 14, 2026 at 7:17=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
> roms/Makefile find cross compilers by itself without relying on
> config-host.mak.
> If my analysis is correct, the only components that need to be fixed
> are: pc-bios/vof, pc-bios/s390x, and pc-bios/optionrom.
>
> If it works for you, I can replicate roms/Makefile logic for cross
> compilers directly for those components, which would remove the need to
> reintroduce anything on configure side.
>
> By the way, why do those pc-bios components have not been added to roms
> like the rest?

Because roms/ components are vendored and the binaries are updated
whenever the upstream version changes. The (badly named) pc-bios/
directories instead are part of QEMU. To ensure that they don't
bitrot, they are built from scratch as long as you have the compiler.

Paolo


