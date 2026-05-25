Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE61CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 19:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRakn-0002Qo-67; Mon, 25 May 2026 15:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRakW-0002Ng-EI
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:14:08 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRakU-0004Yo-PB
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:14:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso12170583a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 12:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779736440; cv=none;
 d=google.com; s=arc-20240605;
 b=hFvvCasaak3pXXPJgn4aLSHOeroiPemVvk8dITomgoHPA4gP+enlAUOqWp2Sa/VmSq
 Za29at/+qctAKeQx6qrq5C2I3AKcwCpdw4rpmNZfYbeDan16JeeaD796XKbIhojb27Y0
 qbLivEb/duxOq1USGw7GvVIHFj1uMvQj82S1vzGCuZDtfMM9yEw2XMu6JAoZtC7UWu6d
 eYblF3d3Oh08YXMmUaSL0EjkT4ZXlqaFNbq8CeSpP7FvmbyL6Kb1SJNeXUpSlxzmPyQi
 yqqrbRDEuSx+lIXarPkrqGb5zaJxjL6u+IbO9gOPeVtxZN1UwcqkOKpi5QTpi9n8vjfQ
 d9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kcBbYXHgL64rza1dFqCTfYEZECcOZKJVGi+Kvw0R8Cc=;
 fh=xYbP+4l2jWX4HynwyYLvgDhu17mUTsiXnTmVXqjrwqs=;
 b=TEI3el+pf0nOaNNVGEtdzbaGtOzE33JIzvT16TZK85RdMeqzX1Gvdcj3PfujtrLiTk
 rRTuubgLUi53zNuoiO4R1iMKzBKAlnjYnz2wOefmOddhcTg+3y+O5KTdmrAA5222kqWV
 pIPgcZOvzaieDS/BuUDCHsw2y2Ve5lU1SW7vtC8bw+iU8M08RSup9pbum5ovFO+5zY3O
 Ozx44LchQ9XtUG2zw3omkL6JQsNTAzhrwVg06D5fuUggvQMazhqlXDr7VpLCGnQmdhcp
 EgftYL1EctdI+8f1YeSqTYHbV90Qy01bqwL8dgOFhpz46gCN1mIVjuCmRv3zkZQ0pWwZ
 bIBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779736440; x=1780341240; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcBbYXHgL64rza1dFqCTfYEZECcOZKJVGi+Kvw0R8Cc=;
 b=bXk1wOsWWg1u0diujteqlu5+T3ygqwc/2RmpVjjHX8zE4w99cksxkvHa3P7IvFJUKf
 d7ZA2qzjFRVo5sqvAk+yK9EmQhCePls4z22WK0ar+aGYwtpaAgVMKJzsIy6CDy6WdMXn
 3D1kAtjp0jDu6htySP/pAwOoaW6+N9Vn4MD+gPkQ9t0ieKFmWmvutCh3apCuv0BstyVb
 HC8I8hn8Cp7Oieg5tpBWGWz+KV5WWAqdxj59wr2htAzPn26Qd8J3MMOYyHo4uUKjAVNy
 3+1fyN8pppPU9eqTzU/AK1pttymiUZaW/CLWCTY14gYXfzXuL7sKeQmI484krvGD1Maj
 kF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779736440; x=1780341240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcBbYXHgL64rza1dFqCTfYEZECcOZKJVGi+Kvw0R8Cc=;
 b=XHPhV4RBvPRjRcjD9ryfOml2QOTPngCX9Rj0pkdAK5fmVtF9Ux9LULUjztzgMtGkZ3
 QVq9fmi/Qwv/5MAexFrNoT5PO0v34hY4cX3JjPOI1idBwVPvvBghFsLGhPNAb6u/EhEL
 c5xAjXSC8ZZvMHMvoEucRxYb90TXJOJdJ2TWTsEwCwTEp0FpkfTTO2tkHS2rMkQHZHL/
 o6l5i6bpfioAbsgO+56hF6LUDN6FoazwZ08GKNkI/2WY+odQJNN6ivKAxUnSLmlHFopy
 O6RPd+jF79Svtrd4Tb1EHVGKLLS1frlfMpZdm5yOJ7aGqUR4xJnW5/19YDc1pthhCWko
 bFQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KjWHpJreyyGRxb57PxWQjB4RWK/WCPb+aMRpdUVMwQWs9fEyIzPNyTHRBczjXa4kF5PUPG5shPw4y@nongnu.org
X-Gm-Message-State: AOJu0YyZze+6l6AZXU04qFS4B/rX+/IcXcrRI5BMJHo7MfrfQsIpyxrp
 t4Q5BDN0vqJlRaMd0ipf3HFO5AQUfFUoA9mj3lXCEwR+zzuMNR35B2v++Yi42+uPpwu+0cGJVh5
 0P2FCa7tJ/J87vqmeCakR6knl/BDf504=
X-Gm-Gg: Acq92OHiJgLZcQASbR2YaO51M/JHGsB51qKSNnoOSER2bZOrUEX4J883QgOdbQ1+jyp
 u9RzBD2T5zfTzMxij84rrGR6+4ghDhK9rhDYe1butgqB21qP+ntovsvFrNc2Y35HfQF3riaMamy
 muvj+f82Ah3X2pH3ElBqUvzLqSxkaJGNJ+h/swBlL0Ya3gHJs6cgVLDmIFydiVzvG/K59wy7kbQ
 psvUpMBfFj5YN5MlFGpR8lRE18RPU/6rHSup/CJgHlLKaCu67IKD8hWOTeqyCKTz08+4NVftlK9
 DMUOOn9WpZHZmPUuUArLAFE2nQSdoIoDs5rbJO+lvExPmqv30yZu
X-Received: by 2002:a05:6402:5110:b0:66e:cf8d:6970 with SMTP id
 4fb4d7f45d1cf-6889c46833dmr7752917a12.20.1779736439911; Mon, 25 May 2026
 12:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QULyy5C0YEaxz2ChNy3_zfc5VwaMhB18R=yHDgnhBYo9w@mail.gmail.com>
 <CAJSP0QWt8Q5+yY1F6--XyvcAV3afg3msAcO6vaNDeWS=B9Oqag@mail.gmail.com>
 <CANCZdfpbDU+jCr6+Lj-ZV7h5H_ByHf=VJordfQ8OcH3+JsmJ4Q@mail.gmail.com>
 <CAJSP0QX=Uu0cy6z8oCsQK_EKJ8LUW1v3Tsd09JoAU=Py4MkRrw@mail.gmail.com>
 <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
In-Reply-To: <CANCZdfrfiVp=BiCEUzYRFFeZBpUoODBwL5b-QQgbA21Ev76noA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 May 2026 15:13:47 -0400
X-Gm-Features: AVHnY4LxXNLw8WpEdQZzGvdd1S6aRwpM8xwl6sXg4ybdUOsOxQKem2bakxHWS4M
Message-ID: <CAJSP0QWrNzf_NS1hx4c2TFRLp0Son=_kAx7qq_CeMBinEV=CNw@mail.gmail.com>
Subject: Re: FreeBSD CI after Cirrus shuts down?
To: Warner Losh <imp@bsdimp.com>
Cc: Li-Wen Hsu <lwhsu@freebsd.org>, Alex Bennee <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Mon, May 25, 2026 at 1:39=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
> On Mon, May 25, 2026 at 10:41=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>> On Mon, May 25, 2026, 11:12 Warner Losh <imp@bsdimp.com> wrote:
>>> On Mon, May 25, 2026, 8:36=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
>>>> On Mon, May 25, 2026 at 10:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
>>>> > If you have a FreeBSD build host available, you could install
>>>> > gitlab-runner on it and I can configure GitLab CI to send QEMU FreeB=
SD
>>>> > build jobs to your runner.
>>>>
>>>> QEMU has an Intel x86_64 KVM VM with 1 vCPU, 4 GB RAM, and 60 GB of
>>>> disk space available.
>>>>
>>>> The following images are available:
>>>> - FreeBSD 14.1
>>>> - FreeBSD 14.2 (ufs)
>>>> - FreeBSD 14.2 (zfs)
>>>>
>>>> I can provision the machine for you via remote console access and add
>>>> your ssh key. After initially giving you access, you would become the
>>>> maintainer of the VM and responsible for keeping it updated and
>>>> connected to QEMU's GitLab CI.
>>>>
>>>> If you would like to do this, please send me your ssh public key and
>>>> choice of FreeBSD image from the list above.
>>>
>>>
>>> Where does that list come from? Those are older versions of FreeBSD by =
now...
>>
>>
>> These images are available in OSUOSL's OpenStack instance where the VM i=
s located.
>>
>> If you can upgrade in place from FreeBSD 14 to something newer without r=
equiring console access, then that might be the simplest solution.
>>
>> Otherwise I can upload a custom image (for QEMU's i440fx machine type wi=
th virtio devices) if you send me a URL to the image.
>
>
> If this is a EFI boot, then there's no problem upgrading the ZFS image in=
 place: I just make a new boot environment (or enable it from scratch). Thi=
s doesn't need console access and if I totally mess it up, I can start over=
 from the base image :). But I can script it.

I think the boot type in OpenStack depends on the image you boot from.
The Ubuntu image I was testing with used BIOS but it should be
possible to upload a custom FreeBSD image and set it to UEFI.

> I may have to get in touch with the OSUOSL folks to see what it would tak=
e to update their image collection. It would be good for me in the long run=
. FreeBSD is likely well known enough of a name we could get some resources=
 from them.

I tried the FreeBSD 14.1 (zfs) image and don't know the default root
password (I tried empty and "root"). I think my ssh key is not being
provisioned.

If you have a FreeBSD image that I can upload, then that would be great.

If you need to chat with the OSUOSL admins, try #osuosl IRC chat on
the Libera Chat network.

> I've not setup a gitlab runner, but I see we have a gitlab runner port. I=
s there a current setup with FreeBSD as a gitlab runner? Ideally, we'd be r=
unning -current that we update from time to time and then do the builds usi=
ng the OCI containers FreeBSD now produces for 14 and 15. I even have Conta=
inerfile files for 14 and 15 I put together to compile-test bsd-user if we =
wanted to expand the gitlab stuff. I've wanted to do more than compile test=
ing + basic booting for a while now... I also have scripts that create boot=
able images (for system testing) which coincidentally have an itermediate d=
irectory that we could copy the qemu-*-static files into and use a a jail f=
or bsd-user testing.

There is no current gitlab-runner setup. Instead, QEMU ran Cirrus CI
jobs that use FreeBSD machines.

The gitlab-runner setup is fairly easy. Once you're ready to register
your runner, let me know and I'll send you the GitLab runner token
that you'll need to connect.

Stefan

