Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F343EC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8j2-0000lW-TW; Wed, 26 Aug 2026 04:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wz8j1-0000lL-Sr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:11:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wz8j0-0007UO-BJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:11:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so394296a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 01:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731869; cv=none;
 d=google.com; s=arc-20260327;
 b=MHRDhgHNdrzveElTdU8p0RViq8dxawIMGMia63W45Fz2JL5Jg/s2zgT7vM8ccKa8q8
 x+nNiTcGK/dnPMBOn9u7zyTV2E+mlgv3GycJqQ66oVSyqfQLtr6J6wO76ius77FDkZNJ
 AYbHrdZ/FLvYMRkA3F7/7b4KPzvp4GM8SIxUoCp1viH8xOrhSjR87BWpmDXQYfWnajJh
 E/yuLse0L1N381iz1w80Iib1v7Ui48lI3msSZ/YaVRd4nWUjdpUZ1WpLAGZi1SyYNy0A
 q4yOJwFQLv6YFVckwrrIsQBJaonglha15FxXBNQUGkOG1RvTr84rev76dSBGBSprmlum
 8gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LUHFE8tZqRZwERb4Pc66oka9x28ymfMXqeQJmdEGXoc=;
 fh=k2bc4N0C04cfzXGcSWibgHW/HMUMklaoisOB1yFxlww=;
 b=tBl1lfsIMROgQzN6rg5N0KOcgO9aW1E6MOqqzkb6RlMRDGKAJFLOLvTnCYuMv+KWQG
 Ufskui17qtc+diZzXwqXhXsesGm71JKeMup+/h4N2xyGC6xyxQ+ek58IuXZ7SWbEEEw+
 JRosFqPdbpJGxl1WZTa6jWt4vBJlU/MN5nJXtoRyZqCCSE6CSqSrM6xQ6MX16eNwVfhQ
 6NGfrI44QA5DorXodnJ0/GSvLTpbNjtErDi8TVwSMHfe3iS00jHr65kkT8zk3ZkC1cXL
 dulrejyZtcvg2N/xIZzeDTtemOGHzQdRun87cBPjQP/H+6tf8QZ4aMvvGWIqXrK4xULr
 /Evw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787731869; x=1788336669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LUHFE8tZqRZwERb4Pc66oka9x28ymfMXqeQJmdEGXoc=;
 b=JJxc+9Y/v4RO4nU3OCHXV70QUuTussAUj3YbCC/asjGuUmOpziEnJcMSIBRmpXmdpH
 LK/AS+x3C3oTVa9PxNXi2qZs0GMVysood0yfXYNNizd5XbzgOeidfjnuXPVSYesK9kH7
 CLEYi/n812RanLCEBPXGH2ygZQfLdbxXgJ/zrwJdgVdnF46AUcw2XqkcdONhHLOcDQt4
 05k2/sufS5oS9NfCGIUx6X/fZes6epgaPIuOzx7YTiA04Ztb9efzankvkp1dvCNvp3wz
 gy6s8AmgYCSLJP9yrZDAEyVLlzC2pSUL3TuLDgLjQWibF60N9N4e/V0XrMgCWvcXUo8c
 V/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731869; x=1788336669;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LUHFE8tZqRZwERb4Pc66oka9x28ymfMXqeQJmdEGXoc=;
 b=WMO31DZENgJi/GRnEKXJA/JvVCKAUbtFppRAEFWhejJIHqYeZbxD++A4YM7bIY2O4l
 keaMJ252p2cxPXbUXk6+LnUMs/mrM7NA+gSzBEUiL4ZSoQO0T19hd4HgjMT77sjVllxF
 C56aB4JUI9YL9KWdWUJ4oC3oNYo6l+QYyiA5eD5hUHdGaA7HiYIkjio4j0+f5Slb+gH1
 KRd0cGtASYAMifCYddfg58WOblTfuiAwXAjauJF12/U9aWuQhdRbFDH4fTyauQFk0yij
 t1Bz9/ENktcC33OM102iABV2Hr+HbQBfOjDmtLOlLXhbr+9cHLszGzXR2akGe1RrgsOn
 m6PA==
X-Gm-Message-State: AFuF++krJX61nMKt8HHoLhR/i+QyHsuu6/JG9uB+gjNYLxu0iLScC6x8
 WykHjP2gi50Fn/ypuV/zou7VtqXm59w+9yjo2hmIFiLocSJSrPmQ5jRN7rPt3iQ8b94yamB+ukh
 XjdPONfsA97Khx8VatV3PYtcDRdqrDO4o6xSTqcE=
X-Gm-Gg: AR+sD11aiMdWo6nL0e2tKAQwpK9IZGA7EyDACzyFbrymh/8rt7ip1uyaSzCKxSsw5Km
 m6KIhDLYHgkL2wrYFXA8A4VnqLp98Odts6tDi4u80j9JNGNqNsI/LXbmm4sNOI5QmWAA5jWc+Ad
 3x5QDYDnm7WYWG10v6q1dHBsDdHSg6leS71YLOvDFP2UG5OJt2GqeLB1Kd05erdaZ7VhvuhX4cR
 cF1v3uIiy0HTL254PRKD1pM9/+IxF9WXQymt96qPi3aZPxWojluLg6HgBpeVDFNmZKDPo/XXxcn
 phu5s5oG6kKGD/1JLsk8mRlRcm0qmzFo3g+tJu36WOJpctCPoagt6PYcXQBPExml/ghTusLTLiA
 T
X-Received: by 2002:a05:6a21:6110:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cf83b224e0mr9275420637.12.1787731868747; Wed, 26 Aug 2026
 01:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 12:10:57 +0400
X-Gm-Features: AcwNN1W7-yudiprXeXrR3GdZ__W3hNmRMv6wetlNx7QdvWrEi0zCbGrYEeSK5io
Message-ID: <CAJ+F1CKwNr=6wVaO+tXa876EzoPjYfQC3qx=em3C4BSW7wRC8Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, den@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52f.google.com
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

Hi Andrey

On Tue, Aug 25, 2026 at 9:26=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> We've experienced crashes when spice-server aborts on migration target
> when processing an invalid/stale guest address pointer.  While those are
> hard to reproduce, it seems they can be fairly easily avoided by simply
> skipping commands with invalid addresses in qxl_post_load.

I would rather try to find the root cause, rather than applying a
post-load workaround. It may be related to this issue
https://gitlab.com/qemu-project/qemu/-/work_items/3766 (confidential):
there is a lack of resource tracking, when a guest release
slot/cursors etc, the track commands may not be correctly updated - or
preventing resource release. Unfortunately, spice/qxl is no longer
maintained - we should clearly mark this device as unsecure imho.

> Andrey Drobyshev (3):
>   hw/display/qxl: factor out qxl_guest_phys2virt()
>   hw/display/qxl: validate replayed commands in qxl_post_load
>   hw/display/qxl: trace skipped stale loadvm commands
>
>  hw/display/qxl.c        | 132 +++++++++++++++++++++++++++++-----------
>  hw/display/trace-events |   1 +
>  2 files changed, 97 insertions(+), 36 deletions(-)
>
> --
> 2.47.1
>
>

