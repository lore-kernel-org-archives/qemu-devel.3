Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E7C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6jq-0005fp-VF; Wed, 29 Jul 2026 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wp6jW-0005Qg-Iq
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 12:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wp6jU-0004tA-3F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785340929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhlPvcuqgtFQwP8UB1DWn9mXVZlt9Pmzt0zx8Vi5J/U=;
 b=NFtn7o6S6bNdSUPcsO4WA71VYdml3331PUQaTZnMte7KaG97G1AKabI4KWnU68ET1bI8GQ
 uvEJWs6EQoxSULaMYeU5rmVG1Y1U4maXVTZJtAOw9bNpaIY90E3INqCM4cw2NSlaIErLpb
 7p8B/c7PNAzQExAL+8ktm9cKOnVsVWk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-RZRSffbiOqayQLcWvms2Eg-1; Wed, 29 Jul 2026 12:02:08 -0400
X-MC-Unique: RZRSffbiOqayQLcWvms2Eg-1
X-Mimecast-MFC-AGG-ID: RZRSffbiOqayQLcWvms2Eg_1785340927
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81eddfe28b4so40506357b3.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 09:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785340927; cv=none;
 d=google.com; s=arc-20260327;
 b=kn4KSjWZORdfZ9uvOcSqY7im2Nd7a+gGFcjSdC2pk1Q0NZwE8QDmCSO2a4O95bglq4
 MNgI9fItZGPjh5B4iTcXnxsHMCIrcbqvh2nDT4bi69DqcBDeH/qdtllNpIiCaAMyRlRT
 zafgwMY1X/q/MEE/2aRaj4ZiIXIN1egnHh1K4RiaEb1opjUNdtX/re2I5mEiy9Mr2YbP
 xQhZEHAG6WrmE/1LHEm0omJ7v4G0OT/niW40Kwho//dtuy7AYnGNBmR6Oxe6C3d3WbU0
 oE6+N0WV/pQbgaqPm/gJP7CkPQ8rtlX9b0gQ0tHf6dA2wetqcec2ja7PUy332ffoqhpC
 UuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rhlPvcuqgtFQwP8UB1DWn9mXVZlt9Pmzt0zx8Vi5J/U=;
 fh=Q2NquebOiZf11f0TQPe+H1Q2skcQXLSJJRg7BoeZOZI=;
 b=lXor8HR5xUSix1Y2OCh9QsfmDPzrnqV1kT88sB5bw8lFHDAMZgz1xROLxO5zbXdViD
 WU5rn3qvaCuqKNJrvCxtVIzX3Sfl2Y0+rrl917IBWUelWAyGLaGlUphNC+fgmrcYnIPo
 Kd38Z+NdGiy3TnxZVTMknUvQ4SRojQPZqcc792GA95nSzunPHxfRad+zDPtVAWzYojRW
 kmZK6XWcETzLqOFR+8t+idzC7Yd7wkwyktbHCkwlX6vE4EUDMvGHWnpnKYWZ38IPY7g6
 8LnNTgbt1acpDUdWiCjKupwPtyPznsLwGByCfap7C7jLM9ib7uwufiTnRfXZ3Uavqzzu
 7whg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785340927; x=1785945727; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rhlPvcuqgtFQwP8UB1DWn9mXVZlt9Pmzt0zx8Vi5J/U=;
 b=Up5MRPEOFokOE24nwQ+KlY8Rlqn9BYMa9+ZvC304pZU6cnNp4hpA9/PTQuh9DEnn78
 726EHXQVBXmmgQoxXyWBbO7x2/F8h/DkPvKw9+AZr8279uGeNG36uSLcbpegHBLE4RAW
 d/56rNqr3SNT3bSvn1JckpJ3UPt3uiMPeBTkXARmd66XjPlYSMmWH5D0qPChyAIA1GYJ
 QDUW14gEzW70726hYT4ePanWxNQEUgNyYLdxb2WDLvQQfhKRD+Xowwfhrdr/50eukZsk
 S3/QxAXwLZK1tlXgarF8IiAxCoToadZIJtUcasFjeEA2tkFlUWKsGwfDivpXsTCEfJD8
 U1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340927; x=1785945727;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rhlPvcuqgtFQwP8UB1DWn9mXVZlt9Pmzt0zx8Vi5J/U=;
 b=TttBCAXHrwDzzkScYcroMOKAeXTE35zwm3gBmKa/Ni4ZA0ylS0URALlNlF+UtpFb17
 1OaEGOBhrYHP1Bu61Ep50TYvZb1tY8avvHBBImrkRtYhjHJ9nQhGl4fJzUejajrYY5nw
 KGM8PQA3skYBWdMz3u6mMrsXNBFXIp14xH88KUVzrRYuJFEJomZq5/CUDTM+qngU5v8o
 IpdgEERxWMY/8RRf5YZ8R+taIHFk2fjNsGdzzYN7LG/AmkVZAAuSNtt4lx6VhcSuMqG1
 /j5AfpQ43I3MisIfVQKJTF2MT/gv7Fl3TTVerg8vIU+Yrv8RCgtZxWSQoze40KpjWn0e
 +apg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPpHd0IBVWpO8JVauiKGxNLhR7Hn7LU/5FhwJyuUlEhoe27jS2/EJ3QkQfT7mN1AMS1jhbaIrYkodh@nongnu.org
X-Gm-Message-State: AOJu0Yz1DLG5nmQDcuiDtYJLMHDRpQdy2X19OHcCh/7o83jl+EBGWOZT
 i4QW+QilXmi6AeTvMgPYsUR7xUtJu/JXoSOmjtdy/wNYn+sdrkjqggWFWjITIF66IK3WUWlQhBX
 4bisCTA2aYoZrhVyBLWxx+yp4cLbCv/0rR+BSw8UhR9CfqbAi+IR3qkn1jL4Uij9+BzgIfYtblw
 MMTxUaCsXmiP8TkDf26Lc5ojt8kVUzVIo=
X-Gm-Gg: AR+sD11LPdWkTgOtCxx1wl8lWME9WHNNrJsXoHCiIS2Sg7r0ujYR7/vlr7iNdOonPo0
 Ni56/nuN+SdVh8+smvwUKLRP0or2ENGZFHxpQ5Glf0DQMRH5YM7XX46zGo37zqfVDGhS53w6iLj
 U8vNHc4jZ0APiK2WsfeJq9C+kfHHP9nxQ35tP4thP0WWjE2EGu9S4hznBZ/WxQp22vFsWWcaerO
 Mp1zNLwkhJpqjw3
X-Received: by 2002:a05:690c:6508:b0:80e:3d45:5206 with SMTP id
 00721157ae682-81f9914017amr45200857b3.18.1785340927230; 
 Wed, 29 Jul 2026 09:02:07 -0700 (PDT)
X-Received: by 2002:a05:690c:6508:b0:80e:3d45:5206 with SMTP id
 00721157ae682-81f9914017amr45200107b3.18.1785340926584; Wed, 29 Jul 2026
 09:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
 <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
 <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
In-Reply-To: <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Jul 2026 12:01:53 -0400
X-Gm-Features: AUfX_mxRtcNVrB-P3BzWD5mfZqTllplnoE5oBNwhpeg6V34Uw6LMFRzcN22iM08
Message-ID: <CAFn=p-ZkTd5iv9UZCondYbBe6Y3Gudcv8oE-95Ttnh2O8dujEQ@mail.gmail.com>
Subject: Re: Issue with PyPI when working offline
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 9:30=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Paolo,
>
> On 13/5/26 15:36, Paolo Bonzini wrote:
> > On 5/13/26 15:04, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Hi,
> >>
> >> This is the second time I'm working offline and do a simple
> >> rebase, which triggers a re-configure, and then I'm stuck because
> >> PyPI tries to access the Internet and do not allow me to neither
> >> build nor test:
> >
> > Does it work if you configure with --disable-download?
>
> I got this issue again today:
>
> $ ../configure --disable-docs --enable-plugins
> --target-list=3Daarch64-softmmu --enable-tcg --enable-kvm
> python determined to be '/usr/bin/python3'
> python version: Python 3.14.4
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=3D1.5.0
> mkvenv: checking for pycotap>=3D1.1.0
> mkvenv: installing meson=3D=3D1.11.1, pycotap=3D=3D1.3.1
> mkvenv: checking for qemu.qmp>=3D0.0.5
> mkvenv: checking for setuptools>=3D44.1.1
> mkvenv: checking for wheel>=3D0.34.2
> mkvenv: checking for pip>=3D20.3.4
> mkvenv: installing qemu.qmp=3D=3D0.0.6
> WARNING: Retrying (Retry(total=3D4, connect=3DNone, read=3DNone,
> redirect=3DNone, status=3DNone)) after connection broken by
> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): Re=
ad
> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> WARNING: Retrying (Retry(total=3D3, connect=3DNone, read=3DNone,
> redirect=3DNone, status=3DNone)) after connection broken by
> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): Re=
ad
> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> WARNING: Retrying (Retry(total=3D2, connect=3DNone, read=3DNone,
> redirect=3DNone, status=3DNone)) after connection broken by
> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): Re=
ad
> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
>
> Indeed using --disable-download fixed it.
>
> Thanks,
>
> Phil.

Odd, it's supposed to install from the local path. I'll look.


