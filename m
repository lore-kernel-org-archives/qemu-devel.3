Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF69C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qo7-00052A-Nu; Tue, 01 Sep 2026 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1Qo7-00051z-1B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:53:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x1Qo5-0007aY-Hh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:53:54 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so4214469a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788278032; cv=none;
 d=google.com; s=arc-20260327;
 b=BaAaeJUceIIBjU6ovrSkn2hXjQ7s8IEf+HccCnkg341RV78VuoL/YP9rhrLGw9GvZz
 4cw5Iq4sNJ6rTnIl4SrvmrGA0xkieJT3TbPIbBvd7fBsUwHtkD7bTzIHejIu9f4uM2Pk
 bq+0LEb+0MneTamG0bD9+Kg28GFZ4tj8Mv3dzEQCXMpfq6+N9Wm1EvS3sdh94UKob2aJ
 GM68FyPBnBT5D6HGepUKjqejr+oBMFOEwUdUepYL6/VHVSEZ1Xfe0KTgOsekeR5EOfCe
 QaANlUK3rwcet/S+7m4MPPa5mNzgg/CB8tp6adhAtBlRqKIhXtR5P2A8YXlmildbqcgJ
 rSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVaYddNfSpxB/UMC0blh9OZbdR5tEPSnaG3LM0qYrlI=;
 fh=jV04TIUfDjzYNoDhFIivgDBsLoks7SiMcTzgigNwyCQ=;
 b=F9wTdqqKYEf9EYsJouKft1DDljFp0gCR0IqXlICgKidGjwEzqyWj4bp0xWo5cDctyq
 50dcS49E7/FyZs5leSNmtKEYek3EPYKY9dm9lODNjlpTmgKRsEmGuh3OSmEcbj3DyTpr
 OpV2Pcb/XARPItItQtwVqwVWA8wdK8BpulBwJ3l1fkImOTBTYhQws6yzK9W6RKmaRv33
 3j4Hgw3bsUeet2/szLryO1rNEOw5+VgXHLfbrkierefnFOpiZY5zo/pPOKDH9n0L8A+g
 z/YpMPK8+gu5vcdHzE2tnwyYblLeRuYIhu4O1+jIVGObI3lV9u8N++l5vmUkDD9XfsWX
 CFeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788278032; x=1788882832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LVaYddNfSpxB/UMC0blh9OZbdR5tEPSnaG3LM0qYrlI=;
 b=OA7f8T9SHLsnxgdb5Wkc5NEvm4iFmxVEAdgY3EpmJsezz+FrLUhIgB8lir1o7aNqGG
 HaromR7i0eTIvmhBKiqhkh2UazTfMYECVif/7Hj+atkQuCyeOLKQZoZtyU/XymAwzMqn
 OM6EVM6VPhbKc64ezMLI/R5V1r3921AVNStmW1WF/XeyaTboIgT+1/axy2lzNPJznmFU
 MCFazzsMPVmVD9l7rrjRhgBHdVUrF+QrdivtM/BWkSWF0DroZCGJvTj07z6YmGqxRXCf
 PCwOxtRI6ufykeQNLqYC3+fYtQltgWs2xbiJzLjEq6Nqn5yn+4eb+yd8OLVi/0jSBfAz
 b8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278032; x=1788882832;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVaYddNfSpxB/UMC0blh9OZbdR5tEPSnaG3LM0qYrlI=;
 b=IA5aZxXtwSaz26YWiiP99ZBiMMYfuTcbiCn7S9LTXN3H5yuJN4n6cvYoSG6JDgFesN
 Xy1iE0LmbFKyZRNU5Nk4BZcnoyaUzJCvJHoV1LoXe1MPMI5lI7ugiOxFbp2//F/xPnWJ
 E0anYYyXF1LiI++UTC/i5UOvu9Z89IIRZmr90O25Fdb5gq0nn+m48s6aDMsg/QBDGtHc
 S9yhiMmBTK9E+0Wv1H+Ad6hjyyF/iTTGzNBIdTGrxrtXalIXNKtHvbv2kGm9Nbowr0ga
 6DYQa8U88SPpsFBKbZyS8IF0Eq0EN1sLFVk2TTeyNIbayxHWdOlE3zg7Ps1qg1vLLl3i
 dEqA==
X-Gm-Message-State: AFuF++krUo0XQazufCbNW3ms6OHK2BAtKcJD1ZyuqTFX5Yp8374NVDrK
 vhP8KYJrHDeOVbWTI9/gBTU8/di1qm+BmdyUX9mDNhcopMrlnWUEizB4FIFPB3tdREBcIqLW5iH
 kkzMRUUDGUhVPVkrFK9R1qHv2NaMUjog=
X-Gm-Gg: AYBFou3EU2+DuOBojSOC4bezBKmveguG4EjQ0qL+8n5iIjFYr3OmdG7qCL5UcU7v+lx
 vfhVwbYDdfRdNiodor1YSqGaYDg8hjOJIsGK7Qnw+vv+FOqsSdHKPnDz3lm8HgMCZ2kXR9Lw8a0
 M6lUqTXGrUQjOTbgIJddXko314p6DyPHVaKSAG+qqVpasgFvReGXqVWzMbAZz+4awkFdVfPS+Xh
 l52Q1qV2JPp+WYZaa3eS6Lvg2DMzPLEkD31yDbi5OPMJ3myJ5iL3gb4sy5KNJ+IlvohC3LT7k5h
 +fhLVS3EPCSiyi69iZ4W3LVXguAYdW0BEZiYIv5zTVrdlWvvCy8sIajSww3kifuhspJukeICGjV
 z
X-Received: by 2002:a17:90a:1182:b0:399:1b64:e0d7 with SMTP id
 98e67ed59e1d1-3991b64e5dcmr6139932a91.19.1788278031701; Tue, 01 Sep 2026
 08:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFH9MbUdL=HuSvqpwHF-1yo-MeCGREQoqKjdT7us=5CiKSxp3w@mail.gmail.com>
In-Reply-To: <CAFH9MbUdL=HuSvqpwHF-1yo-MeCGREQoqKjdT7us=5CiKSxp3w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Sep 2026 19:53:39 +0400
X-Gm-Features: AcwNN1WAPmnehheeLvKcCHGpr0sN0lqnP4GsFK9Zrs6qUL4QVChaq2k3lZhYSsg
Message-ID: <CAJ+F1CJHpTLPdacLa31J1m_oUkH-TZ0MOpQJNwMAt806sdZmNg@mail.gmail.com>
Subject: Re: qemu-vdagent guest to host clipboard sync
To: rick vernam <rtvernam@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102b.google.com
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

Hi Rick

On Tue, Sep 1, 2026 at 3:57=E2=80=AFPM rick vernam <rtvernam@gmail.com> wro=
te:
>
> Hello,
>
> With -display dbus, clipboard sync only works host to guest; guest to hos=
t fails without any failure messaging.
>
> The guest's 'clipboard-grab' message is received correctly by ui/vdagent.=
c, but ui/dbus-clipboard.c:dbus_clipboard_update_info() drops it before it =
ever reaches the D-Bus display client.
> Checking info->has_serial in dbus_clipboard_update_info() always fails fo=
r guest to host as has_serial is never assinged:
>
> if (self_update || !info->has_serial) {
>     return;
> }
>
> Steps to reproduce:
> 1. Start QEMU with:
>    "-display dbus,gl=3Don -chardev qemu-vdagent,...,name=3Dvdagent,clipbo=
ard=3Don -device virtserialport,...,name=3Dcom.redhat.spice.0"
> 2. Connect a D-Bus display client implementing "org.qemu.Display1.Clipboa=
rd"
> 3. In the guest, copy text to the clipboard.
> 4. Observe on the host side.
>
> Expected result:
> Guest clipboard content is forwarded to the D-Bus client via "Clipboard.G=
rab".
>
> Actual result:
> Nothing is forwarded. "dbus_clipboard_update_info()" returns early, a sub=
sequent "Clipboard.Request" from the host fails with "Empty clipboard".
>
> Fix tested locally:
> Removing the check of info->has_serial resolves the issue with no observe=
d regression on Windows or Linux guests:
>
> -    if (self_update || !info->has_serial) {
> +    if (self_update) {
>          return;
>      }
>
> I didn't really consider an approach of setting info->has_serial as that =
looked like a larger patch, and it appears dbus_clipboard_grab() takes a si=
milar approach to this fix by setting has_serial unconditionally for host t=
o guest clipboard sync.
>
> I believe this if statement has been unchanged since the initial commit f=
f1a5810f61f78b47ddad995f49bcc70171d9e38 "ui/dbus: add clipboard interface".

What's your guest agent? Can you send a patch with all the details and
proprosed fix, rather than a regular mail?

thanks!

--=20
Marc-Andr=C3=A9 Lureau

