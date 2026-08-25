Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57BBC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypUK-00031b-3z; Tue, 25 Aug 2026 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wypUI-000315-Ag
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:38:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wypUG-0001VZ-5T
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:38:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caea3f742bso69092035ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 04:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657918; cv=none;
 d=google.com; s=arc-20260327;
 b=akSjs2IbtM+elqZfJsOy1LchbAdJ31DXAmi8fjZsYWDY9HVZ92yFWCYIQC0Cqv5/Dt
 HXBoflvA75K7qah5kQ42olt8jGgCDv7by+bb5iHn72FL4sVSAvregiciisW4wEk9hDTB
 va4R0taLTfmwXYw7gS6L3Xv5io+Ci9qM0umSlsElU4HwHLXfAq9eLXgQ94dXS/SO/wZ9
 HqGC09b/DjzPScRyoks4vN3gHpQaMsNgd7spKKy9TyE7ohC0zthSzl99wrNhM8yeFrwa
 CJrnF3kJxj0wVILGWy6sMK9TWg+kAhm3TSgRnA7OWoVlMka813LmG+DH4x0xLY6iBljC
 q9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oMH5xem/I9s/I6053bGrSxFw/+rUaWndohkBfutKNGY=;
 fh=sVEdLZrzZefL1Cm6F4P0QxX5+s/CLdF3xvWwQpUW++4=;
 b=WXgJXrhboPt6vMk62wK0hS7SHs42AJNMS4bERsKWW/xIRdMOF//8y31GLEeA9tJLB5
 S74+Q0sPXheR7NNojeomzDBzp7OxBBblfC4OMPIBD+JxaLYDjtI/0iYh7wm3jskHe4q5
 0kd9eOR6vKFPccbM7dj8IkhdD/euqfKrAV0X0wo8MsiZXBps1h6X0w+tJ0dyCejONrh7
 WGlwAyWKN0iVbV3qv0cxetn3Uhdo0+qMwXOSjkBIybQp82WVeve6nJx0rh4pY+Jt3qKe
 IVNatPAH4/nWEo+fNT6qTWNH/6jtZggBWf++gaJSFCGC2e984f3CDz+r+uB8izQFNYTm
 batA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787657918; x=1788262718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oMH5xem/I9s/I6053bGrSxFw/+rUaWndohkBfutKNGY=;
 b=UWpcc81SzK6Kepl3FeJzoPqmidm0Ak4oI2Sb98BFVYmxOW6kZBY+xIGYc5ik1nas6O
 0r66iJ4se6H2mljZMirD5Y6B2KOvXiI4dGFSQQT9LKGHQk5V7LIrwKpePiDmNA5/fkJJ
 eaq/Fsu4XzY884lgWYJWwNqT+bWIfX1nHlnzUL5ZgXYCbaXDqcPy8ni5RnDvSk9Rgi6F
 S6RHKGH68lyhlScwAR0bCTnPyqcR8Y91eYYFRKO8MzwqJXGSklHUf15z73DT+tXTmvb0
 vfcOyKwH9lEm/AYzdb1yjFvBSDCB34Ih55Di81a3pHfwTMHpJdsKVrFCyaaAOloy7FtB
 KqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787657918; x=1788262718;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oMH5xem/I9s/I6053bGrSxFw/+rUaWndohkBfutKNGY=;
 b=X80RowQBFeuvjVudHT107N6GPmMRuo6Mt7jMlawj4anisEtuwJuPe05t1m8a7qbNXc
 gNaAak32n5Jh4BtjJVnz6FxXZN6J4HWWo570DWbky8jAiBxCjdTrBMgV6dgnkM3Awc4E
 wIxsSO9MThS0ojafLCXw0hiR6R9CCvrrqAO/gtdTRRHUjQkmkWXdQhiC9h8MJow2Yr4t
 eEOAcJaBB0VmiiyEia4uKAHD35/NNxp6YC4W9YoudT1COfc3xrMIOCqdzFdbw1Kb0i7T
 4Ng4RU+OgVKF4HL87VltFW0Lw3DC9c9fJqQdXQ/0jzNtcA1JiJZJkqK5kt+D60AsRKzT
 bU9g==
X-Gm-Message-State: AFuF++mtO5DjeE0f6OQbhJJTAvMLy4HEfy+Qy8vjBLtD2k4MHlTY8KMu
 XhX2hoqPQNoQ4ytHkkRrH4bS/q42QS5bEJ8+eLcXF4mDwFgnw2KK7GZj0S+2u5TNTZwKHs6KKTa
 6g/tFDZDbhCPwdXnAA+k4ROA9QPOYfIs=
X-Gm-Gg: AR+sD11jqor5KzzImY9RhENojDfi9KuOvA37KWdM+lzczB4t8vvBvSbD2VI2l4x+guD
 hQUvQOv0Qq3KVsDR9KNOcehCFHfvsHP6eXgGdgEpXuuwbhTnnuaHXkY9OpOCHddz1HDUYr7U5gH
 LTDNN8qj2LBOOHVaoJY2HRio3EfDPYwILlVPmTI68rfcz7g1/JW3u8V5GT94uORD6ngcXhhY9EL
 LZc3nJEcVABA7zF8ffz/Ypj3BDwuXblljmwn8N83bW4AMYvBNxv2zWvl2G5VdwbNpbXjIlHb8tB
 EWDi1bPTGfGwD0D5/fZ6s+YhtvH8ablkB2PzmXi3Sp1ZbjRulSHT6ASzEm/SPi2B3nSxvZ1c8uf
 T
X-Received: by 2002:a17:902:c410:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d64afcc8d2mr562873205ad.7.1787657918034; Tue, 25 Aug 2026
 04:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260825074114.853069-1-marcandre.lureau@redhat.com>
 <ao1guN9kDZVCje1Y@redhat.com> <ao18QirIhaY5elOY@redhat.com>
In-Reply-To: <ao18QirIhaY5elOY@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:38:23 +0400
X-Gm-Features: AcwNN1V8Q26WkL_X6SBm2FqgYXF4cUEXLSGb6LkCJCBO0aqqdFCzAVzOVfTslYA
Message-ID: <CAJ+F1C+JsUfS2G1jFbHtC-VVRx8dFwhKevGMLCb9E=bwfJmkZQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: fix trace-events
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Aug 25, 2026 at 3:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Aug 25, 2026 at 10:30:32AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Aug 25, 2026 at 11:41:14AM +0400, marcandre.lureau@redhat.com w=
rote:
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > The commit 8041d1730871 accidentally removed the vmlaunchupdate.c
> > > trace events.
> >
> > More importantly CI failed to report that build failure. IIUC, this
> > is likely due to missing libigvm library. We have this available in
> > Fedora at least, not sure about other distros, but we can add igvm
> > to libvirt-ci and then to QEMU's deps list for CI.
>
> Proposed the mapping addition which will let us build-test it:
>
>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/583

thanks!

