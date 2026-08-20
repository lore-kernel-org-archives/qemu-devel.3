Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2B1C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx57c-0006B8-5Z; Thu, 20 Aug 2026 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wx57a-0006Ao-SZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:56:02 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wx57Z-0000fV-AE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:56:02 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6688a2dceb8so1966228d50.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 08:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787241360; cv=none;
 d=google.com; s=arc-20260327;
 b=TmoRaTb2J/kPjNavgppoW4MXEiGWJEbSaxwxCLZk9R1h3uj7Ev+5oCuVJ2GenIA4rN
 A77l0JL8uA3EZOoTcfXZwtnzGVEJmt+QqNPwZQy2fp5dCnbSSoUSl7vTn9sMeXYJOYCq
 F2ThW8IKOrhWAFz2BFvlZdcxA/rwlSvRc7C/dkGb4iXClj2Tg38PPiZoEj9idvi2Sh1s
 OTtL1GBuzKI2pnXMGTLpTjeWFgYIfkobYGBa1ynUU0HaZT5+N44gJX50YFwYFiLDV/+c
 lTUJD7/7aZhkvDiPXHtCA7tHR6EO5UXX5lsX9XYLsArhsYnG9tkWK0ywO8l6IVNGHh61
 yJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zjccIQ52DjE53i8Y+JL1C8qI+OsOp4cqAVqA+eU84tQ=;
 fh=KE3wEp9BzDHz6wDa2zPlp0X2UcazmsfwKriOK7opl3U=;
 b=qxQoVxRScDSTJrkSFJNFRnbe/eTwFKJb/kjOcg0uIX0cTmFpCuwSskB06dX1h2ETLQ
 DPtkdHHlVmNZ3rZc+N3dUw7DdWHT93IgqEV+bPDOBc8y0ImIhGfhioX3WCfKMA11Wuqm
 JajZBeYsoPv3LUX6vNbXalMaZn/NkwmmrrfbSFCYQ3NSw2ggxITReaODQxz3HrLJ7HPq
 Dg1a+NVqSEVoqfcI0PzVqXCiXDghWwvC2xYBCUA0PWm9SEEZ5Hx10wZgMA5b3B3YJHCg
 9+kA+arlQH5rAhFqIZW5+7GRYEqDvtoS0Lx1GB7XVPzCBZLPQJ6Y7vPjPoo4cOXz251O
 bDNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787241360; x=1787846160; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zjccIQ52DjE53i8Y+JL1C8qI+OsOp4cqAVqA+eU84tQ=;
 b=gwrybfp0BK05IVB9jjV4NeropiQlrwAi0nlcJ3FDg0I/7ak3JDUIRa7V42Pj+lXPhP
 UFsTUFkixZn3wU/mSLia6RiR+Vo6VB2B2Qf/ewKQsoOeyBlABmOaOcn/1zF++su1drcE
 HNWMaE8Amo0gAO6ZocUoOR4nikRDcaTwvodE4G0mDa3YK7vMarWu+Zam20BkH/3pg5N3
 B0BjEM60H0GlxFirP3y7vKaFl1YC97aefxL+9FiIxaDKf+yUtV2aSjYfNMzTr+40lLeZ
 e91CTWN4Tu8Er7ikovpsWU92MDNmQoLl3U9xUqIXarcw6PfB1EVtOLfZ3BhGO0WGfOJC
 /6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787241360; x=1787846160;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zjccIQ52DjE53i8Y+JL1C8qI+OsOp4cqAVqA+eU84tQ=;
 b=VgCXdWWX7hbkql2OsexdhsLf624MrfOR/SQYib7mS1m4XXh9mTVUw3TjpTLo9vbKKh
 M+6SIJgA5ocyLpW/gxm9Y4pxgoXkuseGbJ/OObcakTR0prDatpy/rUrcSggy6xgTuJVm
 rEbryRM29XJJo/M7/cK3UlATolH+OWDtWgX5Gcn+2mZ2Ngq/aXIASVmMpckM3Fee5K6O
 YggDKGnv8i4ugQs7dHaZuyvuYdTiJeU/mgejajugZLH+fmvwIRSINuHSECf7jmjlgrAe
 yL6r+hkm7+La5yIJg1M9hJ+rzhJNXKa6t/rcdqmVBhEsiY815aKqkdMdvFlyWs5BVLp6
 a94Q==
X-Gm-Message-State: AFuF++nIysGf95E/U2zijaVPlThgfLOeF29lzDSM0e9VXoX5ALyQEYtD
 YJdgXC0eSx8dxrwlz23XTIlKvaj/M30NWHdXooL8U0nKR15HUaQ84fqc7bT/oHVa0EoLpe/zyjc
 8BuO3ee04DC5u+n5xYivQkgEJvwQ8XFQ=
X-Gm-Gg: AR+sD11JHaFMM01rApvhZ27U36emBoHqCHDuSSe4oueL+KKgExavBFJRf0wXUsOiczQ
 hwTLmTmlWhRQYsf9T0wzDInvEVOJP8Y5kpDd4DnhXyyAVNMAbjHOdn0Gv4fK7VmxoViF5on6DMw
 Rvr9SjgABtN2Z0Jm0fbi2g1NTgzArVfF0z19vXjODne+O8b+0y1lmQ0GKP104oFdHoZTlGg0a/p
 OH5DRA/I+2c2eYDzDRHzpLJGjg6eX8V4kEjlqAsXQc+af22WnRRJhvLY1iulgeOCSjJNGTEl29/
 pWYmG5kZo/mSHz5hE7lwDVQDkc29TPq+I8vU8/uAnGr3
X-Received: by 2002:a53:dccc:0:b0:667:a12c:4402 with SMTP id
 956f58d0204a3-66ccb56049cmr3607259d50.11.1787241359896; Thu, 20 Aug 2026
 08:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
 <20260805080540.323431-1-wafgo01@gmail.com>
 <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
 <20260810124519.34501-1-wafgo01@gmail.com>
 <CAEUhbmX=azsPMmxipdeChe8imyFBwKvS4KRy5Qu-phaUBodOeg@mail.gmail.com>
 <20260813123529.30457-1-wafgo01@gmail.com>
In-Reply-To: <20260813123529.30457-1-wafgo01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 20 Aug 2026 23:55:48 +0800
X-Gm-Features: AcwNN1VIpET882paivyYSaHOWhF73in6BDGj0KJj6THyNjmmYZmdXjSfA7Co-XA
Message-ID: <CAEUhbmUvUvccVrz85_-eVDARqEKVsrjL=EAs0FFSVqjD1WHXiw@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12f.google.com
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

HI Wadim,

On Thu, Aug 13, 2026 at 8:35=E2=80=AFPM Wadim Mueller <wafgo01@gmail.com> w=
rote:
>
> Hi Bin,
>
> Thanks! I used the Icicle Kit as you suggested and posted the qtest as a
> separate patch:
>
>   [PATCH] tests/qtest: add Cadence SDHCI ADMA pacing/MMIO reproducer
>   <https://lore.kernel.org/qemu-devel/20260813123210.28987-1-wafgo01@gmai=
l.com/>
>
> It drives the generic SDHCI model through the Cadence wrapper (SRS window
> at 0x20008200) directly over MMIO under -accel qtest, and exercises two
> facets against QEMU_CLOCK_VIRTUAL:
>
>   - pacing: reports how many SDHC_TRANSFER_DELAY steps a non-interrupt
>     ADMA2 chain takes to reach Transfer Complete;
>   - MMIO coupling: after a chain that yields on a DMA-boundary interrupt
>     descriptor, a bare interrupt-status read must not resume the pending
>     transfer.
>
> One caveat: the mmio-coupling case is written for the fixed behaviour --
> it passes with your "Run ADMA independently of MMIO" (series 515264,
> patch 12) applied and fails without it, so it is meant to land alongside
> that change rather than on its own.
>
> Happy to respin it or fold it into your series, whatever suits you best.
>

Thank you for the qtests patch! I will include your patch in my Icicle
Kit v2 patch.

Regards,
Bin

