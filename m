Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B3C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pXC-0005Iz-Iz; Wed, 16 Sep 2026 09:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6pWp-0005I5-9s
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:18:25 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6pWn-0002bj-Kt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:18:23 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab20f4bso977322d50.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789564700; cv=none;
 d=google.com; s=arc-20260327;
 b=ew93TgMuu62mJ4iHY7z2WFMeWTDOJpe4RHN6SEg/X34kw5+EMi0i4Dfo650uIlorid
 l/AMFjvaR2sMjsudL/4ftxtO+DegKw+YzoUQacEDMdnWK0XS52wpAcGXjaOJpfg24Z6v
 ZCXDKkaPEIG0Km58coid/qfCfZ0i68VqCJpiu76UBh38ByyTjfy2FtkDXoCRRwDh86Sj
 QyYBx9ErW+9YJBkOHB+SKy/LmN1UObHclp2i0+ADPr3KlX26xhb/oGxPWiRi40vK8oZ/
 0gOMUSGPvCpCLqR+O+VfQYS0xh69eGcqZqNxFA7ynROvsnDySC8VpIhQ1B5yPg4stGgd
 D+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mlqmq8/RsaiYUeBt9fHkH+TqQ5EKxqpkrlv0TwHdpcI=;
 fh=HX/6yOwwcGcXE+wPdTTUyHfPGXheT45Z021guP59lnw=;
 b=qQwfJyvQTrYpnYAVRexp9fHnkGLvNrWkFg7RY7QK8YZb8evRNhc9XGTg8Jll1eB9yP
 PYJSHgz3Oz0BpuvOXvou8FaVEThf5mriyeWLF4ArBVggn+1cTvxkJtoqtEwNKn/MZSnA
 MbYV2wle+xGv+C714VNbQIStoB3vtzTrpk8C7sMRicIHMSfOZZGxu/+k4WQTKfezYZSP
 kRihGeifAnAoPQEa3gViWKXGwIHyIGzZ2GQvcM0arAUKTEGpTHHF5XH17NulFB83Coih
 M1c1aHLanEGtt8K+MFkMUkDJa8aiZKn9KEthAhFHFwfLKw/2HzKPZB3YJFehgPf7G5VB
 d2tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564700; x=1790169500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mlqmq8/RsaiYUeBt9fHkH+TqQ5EKxqpkrlv0TwHdpcI=;
 b=QX588GFN7fMcLnNPkKSL0WGl/j+X90zFTZKpCiEchhMOlt2B8TzKqRKqKe1wA+fGT8
 tOR38bicl92q4SxtBkaNfV+rS0OPJxTXjbyxLy37YdkVE4HkeWZkLzoyOHRJAPfm7K/Z
 hzxE2fdy3eSPzk33FSHWsKQ2rnmbX0ezvvxVcWHsi96v22Yzb82OOdUPyUzHgLtacWmN
 R8MnjwA0IpirkpEF+wHDvoq0kNhMntoMGptqGVnpub2lk1V6ruaRIkquoLpcF1lZI/Wh
 UYW95lA4b/hwlgoaAeaRYs/vhLSuPXDuycSCFAILgc6VMuQ0TAVQL+inoZR7ZrWz9Hxu
 KhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564700; x=1790169500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mlqmq8/RsaiYUeBt9fHkH+TqQ5EKxqpkrlv0TwHdpcI=;
 b=K5PLGuSNM2uG7c3El3Uy+4LFccyHGJYYC33Oxwz8c4iQWx0pav1Tdb0RjZC2yAOS8p
 IhmHxBBirOncql+6G8B4J02nWqxZvylcqztHdFxRuC4ZvO8R/N3iQQ9SEYd8YNJko5ww
 QlnSF/2L73v/zmYKs/iVrsbn3qLSOy3JSqOJ5axpCLpjxvk5k2Zg9Fu96Jih0XkyF16E
 NGW8I0PIq7bw5mSisSk+cfJ8DZfSSYLItx28QfZ/xOpSmm3Im0QES6wop7sqBpYYYyF8
 4Eq9QrN16dKxS9gPsly5xqyONK+qot9jn6kPKkyUJD4UUrwryJZbR2YcPLL2gffXyP7z
 sokQ==
X-Gm-Message-State: AFuF++mYdy8rV0YJPambQa2+cxDDYSdr61FPae+LZz1W7iN9+vY/TVbk
 N13UZs4ElyQHP0RM5182jN+oIULsNiFEbsTMCdGB9B0ZG/JTWQpuXjo7J2e3AWOWruwy258pfel
 XokEgq9JajFc1dDdps8dtxBA7lW0EYdk=
X-Gm-Gg: AYBFou2+U5hN1JG+tRgwMSOtIUE6Lt8le2ljSajK7fuJl4mAzKm3Az+RjTjismPJrJq
 fyjDb2xqG1qyXcFBDkG5uXJlpG5sjWSVLpkxzTAw30yDQUfdsnO4TQKtIeCkiXXQoYL6Lu2+5+1
 Bmw9y2CYI/y/sSoDT6b3rNl8SCSW8lf7PUB0WYY0lQ8kno6UCgqZ5xKJPA+AUs32Z1OTrMQ8vVe
 lWXaT57oA5AORJT2zEZg0xLp8Za3I2xPp5A57pchAdeTuvS1mg8qt80O4RtSC6jRkvCeCynEKSg
 qNMqr5VOZdSUl3nQtT0m/EAwZ6p9KqZ/BkgrgGzVIszbk5i3upkAP6DaC49E+tEvOgS8Kt9sVa8
 13c9hTDR5j4o=
X-Received: by 2002:a05:690e:803:20b0:671:3392:7d68 with SMTP id
 956f58d0204a3-671632fd96bmr552034d50.90.1789564699697; Wed, 16 Sep 2026
 06:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
In-Reply-To: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Sep 2026 17:18:05 +0400
X-Gm-Features: AcwNN1WH4euw5aKv8mqaqUEDpaKVMA5M7keTEqBW-mChcrUrnhmGtiq8t4ClciA
Message-ID: <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
Subject: Re: QMP: exposing the host TAP interface name
To: Tim Foerster <tim.foerster@hetzner.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 16, 2026 at 10:22=E2=80=AFAM Tim Foerster via qemu development
<qemu-devel@nongnu.org> wrote:
>
> Hi,
>
> I'd like to query the host TAP interface name of a network backend via QM=
P, especially when the TAP FD is passed to QEMU using SCM_RIGHTS
> and then assigned to a backend through fd=3D.
>
> In my current setup, retrieving this information externally requires CAP_=
SYS_PTRACE. This gives the management process far more access
> than needed and conflicts with the Landlock sandboxing I want to apply, d=
ue to Landlock's ptrace restrictions [1].
>
> QEMU already owns the FD, and tap_fd_get_ifname() can retrieve the name u=
sing TUNGETIFF on Linux. For a TAP passed through fd=3D, x-query-
> network currently reports the following (simplified):
>
> {
>   "name": "hostnet0",
>   "type": "tap",
>   "info-str": "fd=3D42"
> }
>
> I'd like to obtain the actual interface name in a structured field, regar=
dless of how the TAP was created or passed to QEMU. For example:
>
> {
>   "name": "hostnet0",
>   "type": "tap",
>   "info-str": "fd=3D42",
>   "data": {
>     "ifname": "vnet7"
>   }
> }
>
> Would extending x-query-network be the preferred approach? If so, would y=
ou prefer a dedicated ifname field or a type-specific data object
> selected by the existing type field?

x- QMP commands are not meant for any other usage than debugging and
testing (in fact, we should probably exclude them in production
builds!). In particular, this command is currently only meant to be a
HMP "info network" substitute for test/debugging only atm.

>
> Personally, I'd prefer an approach that is reasonably easy to backport do=
wnstream to older QEMU releases. Since x-query-network is
> relatively new, extending it would also require bringing that command to =
releases which don't have it yet, potentially increasing the
> backporting effort.
>
> A type-specific data object could also accommodate additional TAP propert=
ies later, such as multiqueue mode or vnet_hdr. However, those
> are outside my current scope, I only need the interface name.

I'd suggest a new query-network-tap(name: hostnet0) -> TAPInfo command
for your specific case. Eventually, later, NetworkClientInfo could
later embed that data.

Let see what other people & maintainers think

thanks

--=20
Marc-Andr=C3=A9 Lureau

