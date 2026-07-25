Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD9FC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbRo-0005IF-2z; Sat, 25 Jul 2026 08:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnbRl-0005Dj-LP
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wnbRj-0000hC-PX
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784982338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hbLu6hpA+tMulconnWW8htP+h04ki4xdYOB+8tIJplk=;
 b=VkH26RTS/4FNocdFjvt1iBS5/Gprh1e0c6OluzX/0oc5uYh8CuLlVVJ/c7TTck8MmIxTrd
 B5lui/xAax5mggnmJjFme1QfCtL17TI+KHgOxUkBXSdLjYwtBZJl/qRUTTjbQru5J6rO5S
 qr7juy5csjsJ/JMPfGRLdF08s1iQeVg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-SIYZbrIQOiCXi2lzPHHCug-1; Sat, 25 Jul 2026 08:25:37 -0400
X-MC-Unique: SIYZbrIQOiCXi2lzPHHCug-1
X-Mimecast-MFC-AGG-ID: SIYZbrIQOiCXi2lzPHHCug_1784982336
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e0234967aso958583b3a.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784982336; cv=none;
 d=google.com; s=arc-20260327;
 b=VctUg68rUNpZk+PDpqxLQssFGXjvfnClCgy7BoD1nwFNjP1Jhtvykms4Sr1OJ5hu7U
 Fa9IwiV3rRR6Z/WJ1H3Y5pyA9yLXpZVq4Rvu42EwwJ58HyExi2m4qnpVAYAcgQGL5JH/
 wOI9pLEFNg6fLvsyWlxdkSdGWDi6wsrpfNWQbnrrlk63gb4rcldEEBBM8iHSMwyv2cHg
 jB5c00pnHIecP79KHKmznp3q5kU+JDs67t7m74p6oeKrF7KCJKkzXjoOjcrBDHEG9xbr
 K02vwdrxXmI0nVuFLXEH/SnO/fEslshyGvbMdPGizYVWA3BoHbfrbeqwjvMToym40Za5
 T2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hbLu6hpA+tMulconnWW8htP+h04ki4xdYOB+8tIJplk=;
 fh=4wBBUZ8BjOyAMokcc/DbepkPpbRHeYF6hiVjL7CUbYw=;
 b=S2OrqgmuoZMYp/GMJXMKsY36hK0WGTDC+eZM4G4IOE62569un+0eYPwftp5YSQ32Tn
 E7u8BLKcXR/jCamBfAtZkWqbSKYnA3gQpaovLfFvYPtYSuBeZhZMOpsxG8lh2P4bfeM6
 vHH4Mo6iP0JX4OjABf0RPilqiBwRzQCpaPk+ZvorARwRoex0EREuOQmaJ3MN/o0WrAls
 kqpxzE3nP3YROHWAwNUlwuBoTc+n3TT1xvxqdeuVPg1iZjPp/MwMJg0kGVBLc9EOjRrc
 U9CoXv70cfZwe9ULFtDK4NWCmsls+fP5entFPpa2kAdod7mUjvPZ5XRi27e1ScVjwiQU
 MxHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784982336; x=1785587136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hbLu6hpA+tMulconnWW8htP+h04ki4xdYOB+8tIJplk=;
 b=K4V98rh5uYqXmiXjnTBrnppT8vQ6pzXNxMbIlJL6Z53TQboJ71GipUvBQeHj2FxIC5
 vG55XoXZoBaIXAIMnuqK3aF5XwUzBbJXU4U/N/n2yUwEBB6j2HpLQT5+620mbvXm8uq/
 MjM/YmEmwaxvCX98t6OCOCd+zgDiXWkY0ii2JUXum3KtVYDG6PnDwKJPdrL8jnIT91eD
 b79YN1DFAJmEYHkd56/laGawZmP0sKTIqdrVRN5bxgXCdd+8jrk/q1TNwFqf+KwLUZIx
 dn9h/tnnxs1p5yzeREt8Un+Yd4bLvqNwBpgEOj0NI5ZZd+c7oEd6t6jVQq+9kws4SBZ3
 pBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784982336; x=1785587136;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbLu6hpA+tMulconnWW8htP+h04ki4xdYOB+8tIJplk=;
 b=XRUjYW1U/2ZKF/dcuYLLeXjY1B9U38iq1HxV3eOcDtYGINbwSrUTb88rFenjELeT2m
 X11Kv+1E5Hoz4yD24vfsiqrhlPpSYnIzni6aA8NYzW1hKFtHDGgC0FhovCGln6xIVjai
 6cXVQuEQ6u9F690qPaqmCmvSIC3tzOn0QLr13+guxqk9Br6t/RG2bihGtJYbTFPbRjDo
 8Z1BvI702j2jSYpbuZBVXDN4A11tQ6Wj4raWSiCMkorHF970kI2tWa3ZXJeoF2duHjp7
 0At29qRiiNVnSg6uGNpN7LOzAWKTlntSwgFHZoFVdk2WF/Q+0VFPqMa5FuuD5pXT/nxt
 F4Fg==
X-Gm-Message-State: AOJu0YwBim5lib/zqLesKnB0xVTKFDvSbMmK5dE7ej1Vc/hdoNHX7Rjh
 ShqUSUvLGnQ02ycSUAbYJ1fa5vpvWEFCpJ4nU6W9cKLEXEcpWXWg3tNzAPIYRWpISvZiTdQnbwd
 zS/awTuP2VPiskATaRqrudoOIB388B2xLHaRnCsfVvxaSJBW/7Z16hyjrl5GwYxjbGncV7Obq5e
 ZpW34BSozU7eI6Qj1BZdi12YsmuWfJcY5JntaYwjU=
X-Gm-Gg: AR+sD11cEUeARHlYmRTV8NiU/I+lX5zwdXL5w62AmvyxMXCFfKtFM2xCVKHQT/1Vwh7
 WfdtPmwwQjZ9e2irhZKBm8iwDYim9R9y06DiltawoHdXDNR5KxS2rUds4JeNO96mukMMxKrNLo3
 DDZXmEmCEHdQoSNFkQzFybGvdES6XvFlbSRHuTwpdAp7RiJCYEwIkBICrhY31IAA2FqPwmuTunp
 Lh1b4NlPiuk/hs+KFEwePfSeqBt2eQpkrzuyQmcetMwaL7MHmtFK4obsOHzNNkEoCVfcrfVmAmd
 3A==
X-Received: by 2002:a05:6a00:1826:b0:847:9c06:2bef with SMTP id
 d2e1a72fcca58-84e59474684mr1625037b3a.29.1784982335796; 
 Sat, 25 Jul 2026 05:25:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1826:b0:847:9c06:2bef with SMTP id
 d2e1a72fcca58-84e59474684mr1625020b3a.29.1784982335253; Sat, 25 Jul 2026
 05:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260725122411.1769492-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260725122411.1769492-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 16:25:22 +0400
X-Gm-Features: AUfX_mxycsRZwukc_e8GipwV1vZuAHn9kiUER6DCGnWZ4HxurgF5Qw2uEG17d0w
Message-ID: <CAMxuvaym_XVTC8+B6dR=3NER-cfcjUhXQkAeazQPUjMGux31Pg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/display/qxl: validate primary surface stride
 against width
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

On Sat, Jul 25, 2026 at 4:24=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The existing validation in qxl_create_guest_primary() checks that
> abs(stride) * height fits in vgamem_size and that stride is 4-byte
> aligned, but never checks that abs(stride) is large enough to hold one
> row of pixels for the declared width and format.
>
> A malicious guest can create a primary surface with a stride much
> smaller than width * bytes_per_pixel (e.g. stride=3D4 for a 64-wide 32bpp
> surface). The spice server rejects this via red_validate_surface(), but
> the return is void and QEMU unconditionally proceeds to set up the local
> rendering state. On the next display refresh, VNC or SDL reads width *
> bytes_pp per scanline from a region backed by only stride bytes per
> row, causing a host-side out-of-bounds read.
>
> Add three checks in qxl_create_guest_primary() before creating the
> surface:
>  - reject unknown surface formats
>  - reject zero width or height
>  - reject surfaces where abs(stride) < width * bytes_per_pixel
>
> Also fix three related issues in qxl-render.c:
>  - qxl_blit() used abs_stride to advance the dst pointer into the
>    DisplaySurface, but when stride is negative the DisplaySurface is a
>    packed buffer whose stride may be smaller. Use surface_stride()
>    instead.
>  - qxl_render_update_area_unlocked() uses guest_head0_width (set via
>    QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
>    abs_stride, bypassing the new validation. Clamp the effective width
>    to abs_stride / bytes_pp to prevent out-of-bounds access while
>    tolerating the normal transient where the monitor config arrives
>    before the primary surface is resized to match.
>  - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
>    validation. Without clamping, abs_stride * height can overrun
>    vgamem_size, and the product can also overflow 32 bits (e.g.
>    abs_stride=3D16 MiB, height=3D256 wraps to zero), defeating the
>    qxl_phys2virt() bounds check. Clamp height to
>    vgamem_size / abs_stride to prevent both.
>
> Fixes: CVE-2026-16271
> Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
> v2:

oops, should be v3. not resending


