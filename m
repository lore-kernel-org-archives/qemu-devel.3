Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC07E9D41E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnh4d-0002zz-8x; Wed, 04 Feb 2026 12:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnh4b-0002zn-QV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vnh4a-0001rD-1B
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770227630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QNvYk0XPIL7Ls1MY/pVeHgd6/wtVq/1DJM0sMJkxpU=;
 b=JrogF2R4AuzL77L3bbfH7zjf6TplYLOFy3Mn/ZLNpZBLdeuuCQN7Ry3EijIy7ryURJTwJa
 I6eekj0/L81PQMoWhcPeBmVF7cKrbPJFK994p2LRlrDuLuFaFSABi1th7JpenCXKcckqkD
 +wdi4LSAXY0IWJKxm8wPdgYK0lqVkJ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Uz2vOcIwOsuVFyLbHnEhrg-1; Wed, 04 Feb 2026 12:53:49 -0500
X-MC-Unique: Uz2vOcIwOsuVFyLbHnEhrg-1
X-Mimecast-MFC-AGG-ID: Uz2vOcIwOsuVFyLbHnEhrg_1770227628
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-432db1a9589so105192f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 09:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770227628; cv=none;
 d=google.com; s=arc-20240605;
 b=CASXTUd7OdmYgHSWxzjQz3uqflh6Eqgwf5SZpSqk1oTgMe4ARabu4iR14mdEiHzcLs
 bocrYD2AYr7jKKvs3V9sXGHnYm++RmB0D/YgJ6poh+OjklXZjaOlHxydXQRNk7CD2+/A
 XQHqwSs3KJZbSTslPgjYqhafZeEnDW66NogZ3maM04DLKajJlh66/RO5L+oL4Z4inzWl
 3DT1UH3A6E7cxaD2MMTWsqtYzDGXDKJ0ShNgzl1P6ZjDheCuE2y20W5kY78DODpmkqyo
 KNHRJlb6BQ9rQGhC5OlZ2YwnGqbH3KXqEe2VfbhS5SH5E/iuk+WGs2ru7aqYFgMXqYPa
 b7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3QNvYk0XPIL7Ls1MY/pVeHgd6/wtVq/1DJM0sMJkxpU=;
 fh=Aqbdj/jSz5Po3e1fl7F41zRPtpJ1ExtfkaWo4ELQX9M=;
 b=BHRlhXzN8xsL9q/37YoALrA31+gGqxFFiEU6q4hCWTg9Os+xyOxaOLsN0dUVAJSDcm
 bHKyXkQxScroLn45cbTsB7yHsne0VM3mAEqSCn/+SDbtQkgDn3CtoRx1z89ePDvhL4Ek
 zIsZSqzdg9qm+qI6wkPSIslwrM0PDoxv13N+G1bhYQgZj4hReiwdG75NwAS8Dgp7LIpT
 5jCBHRNHDxLA2CtvRlC06Y8zMS4Liy703PWwxO8yZlbDD5au9uuy7VYTN7pbKKfok7eS
 eM4ZHjkht7Q1v1K9qEAKQtpkYiSBYnS/H4t50tMM6dBXVD4XxkI7okUkr0SixxclaWGw
 /fKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770227628; x=1770832428; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QNvYk0XPIL7Ls1MY/pVeHgd6/wtVq/1DJM0sMJkxpU=;
 b=fnrN1hIbQ5pZ1mNCZ1uCF3uDdEQQTFZKAdM8A4p463IaK659PCe4SPHaQ9FHWiRy/t
 DLLiG0yejRBqvnxtosd6QHRy+zoad01LheEKhKvAJY/hEi8Gs7rmU5mp4qlBQYm0DOea
 1KLYWPSkk9dMMv6ZVvSpK4iVWw1ihgzf25wbprLT86Ec8OwZWgMXUXk3uRQiFwFO8KTj
 RRNXWLYoJUWcDVrs1BbmOS4pO3QxFb8/ms5vsDhkXRxDcxEgaJyXp3rkx6WhVLz4NlQS
 DCcbGT6nJgUba/+dILr1qXsP6ukXGPROABeQYyUpofQq6CcmBKwDL6sHwS6VO/iy706h
 +f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770227628; x=1770832428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QNvYk0XPIL7Ls1MY/pVeHgd6/wtVq/1DJM0sMJkxpU=;
 b=LUQuD7w4ctebY+yZqVWPRmOAgi3nFfHTKQjpU63dENy0q0ycwLvCsLfv/dAGWxzlcL
 PUA90uVpML7WHMLu4aXXhDsc9eQpQ/xI1JNMSHlNom13F+RN92pI7sidYcgPoXCPCtV1
 KDYMAlH9Oy8mEV5fwRUD+EtClckt1pVIk0o8r5ywq8Lw4C+uxxpUvZa4rgb3UjpuF10g
 8ocayonRTKuK35sxvzQxx4OO9jMixmRBAYKRuLaHr2feaHxeOVve31EaTGPIYlqAx/2q
 yGXBmfAqxUXU0uoMEisEty+oy0vbUmEEbStd+gSh5BfvY+IOZJ1HUJTJVVteBLNHlrCe
 oBPw==
X-Gm-Message-State: AOJu0Yw2rde51moRizv3UXxaX4bU592HCcEV1j7U0pfNZCWo5rfC/auT
 Z3uYubnRE1WdPNgXlGdNT9RxzqxbQtRK+ZFORDE9vlr/n0Och9Okqxi0SewxkcvuCicbb9vLWGw
 11HtKDeT+sXTv/7BYthg186U2OVs+2HIIdFpdEys/49lPzG+OX1clp2+UoHmSJPO2BQhFfBvm+f
 otqSuo/zkOIc+g53WVWeeTPvenZsNALRA=
X-Gm-Gg: AZuq6aIHyS6YxFtx1hgJUbhTD4eoq6+pTufuY/gttY6JIZgcdKeqBxYFNfkv+w9Fpc6
 kZnt06c+mrvrFbTeLwtTeslw+teLVPYs1a9W6Ek1QMG4Jhx7dmsmvIHfQHneq6xSWzRiHY5YC1M
 U3cmHdydpXI1GhY+fzi7xLHfnHnOjY7B8pq7UIUqPU7+YxDP4N0zjWjkqutS1nXNbwl1eTTjpnt
 w1ornBVI3I+kVfGBNVGTQK1H5hoL+n+Va8tc35qRrWPb0d8JCMvwrrDdfYFWLxz7zZp0A==
X-Received: by 2002:a05:6000:4008:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-43618057605mr5702616f8f.40.1770227627898; 
 Wed, 04 Feb 2026 09:53:47 -0800 (PST)
X-Received: by 2002:a05:6000:4008:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-43618057605mr5702579f8f.40.1770227627495; Wed, 04 Feb 2026
 09:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
 <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
 <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
 <CAFn=p-aforipvpRhUyLbStYPSRC4Pc0Oadcq8HzT7GzEGL+BnQ@mail.gmail.com>
In-Reply-To: <CAFn=p-aforipvpRhUyLbStYPSRC4Pc0Oadcq8HzT7GzEGL+BnQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Feb 2026 18:53:36 +0100
X-Gm-Features: AZwV_Qihu1G79mmYsN2B95lOAZsXx_gWyGfijyZS6Ib0ozeJ7tghzMbmc2XyPYg
Message-ID: <CABgObfYOYykc+af+HawH9-vVj7vpUikrVPYDmY-ykD8cEVv-TQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 4, 2026 at 6:03=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>> Use whatever is in bookworm or 22.04?
>>
>
> OpenSUSE Leap 15.6 and 22.04 until April

Technically for OpenSUSE we would use py3XX-setuptools;
py310-setuptools in particular is 67.6. But yeah, 22.04 is the oldest
at this point and we might as well pick that one for our accepted
version.

> https://gitlab.com/jsnow/repology-dashboard
>
> 44.x

And 0.42.0 for wheel.

Paolo


