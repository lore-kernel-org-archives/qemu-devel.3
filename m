Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CBDC55838
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrDVx-0003ct-OS; Tue, 04 Aug 2026 07:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wrDVw-0003ce-8n
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:40:56 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wrDVu-0004of-Nv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:40:56 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6688a2dceb8so2859710d50.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 04:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785843653; cv=none;
 d=google.com; s=arc-20260327;
 b=ZM0ceHiwsEzAr0XNbrBf+7QuyiuCD0Hb5LFdIzDRe98NIPtTcQHi+1UChtXQui7XAe
 jx28m0r3ANJ54FBsDOPQsG8IhbY/u4N5c9/EgSGttf49aO51RTRkm/ZTcjMLL683BQSR
 jt/rl4jpQmr8IlWdrc21JsbrsInxxXjkjlt+t9VhYqRhRWL8bUGNrhehVXyPMYnT0JgP
 k2qgHERK2Fb0Ws+6JxVVsS3/nzp+KAytW5kREtUI3TCOhGBs1xVB6uGeF3itz8NaYfsv
 ofACQptu6QZJXOH8hsoxzyzBOVn6FqVH5bnUT+LlBbNb1w+0+lge6DJgLloVcWf3RQOQ
 fzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N03HRKNejbgTa+F3mtvkpF1/AI/l56Ox/GYbQr7puFw=;
 fh=KE3wEp9BzDHz6wDa2zPlp0X2UcazmsfwKriOK7opl3U=;
 b=fwwgxJpVWXcP0szkdQmB5lZmhjcuUSVFzniVXvgLRMeX/2ydyk4frrhZ6A6ed3J4CV
 njCHLTvXlnpM0mnYcs+NG4Sj5srQYCvG9OdYLQ/g5ThavOE4T3y82muyjKzWNTga7eGk
 HSxAg2RvtJ3xouwmfD9HGYY7KhysNGpcFiIHBwi1kvBygWLJHI6PnEttCpbVFcCFx3Mq
 mVJXYMx+y3hWlwtvqXhKLCx2nRXh9RwYa3V5mh0k1E01zKSPbKH1knPNhE0+S0a+tqbN
 xfs50mgoQCWf4O8QLwlri9UTJNftRDPaalqGz5eBVIjvxdeH0iGj4YEOalzXwW/Zw/Oc
 24DQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785843653; x=1786448453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N03HRKNejbgTa+F3mtvkpF1/AI/l56Ox/GYbQr7puFw=;
 b=YsxHP9ZqGusB9S+YZGvaHfpwd8SrBzkrq7T1WXXU40DJStZqhYAD3Rb82Q+EoJkI9r
 aDHrsIE9c6Wr8bY4Uw5szyrIOLb4pwHdlvJBcWLrEoLUwczbToFFv5Ig9ZdWLrDqgcam
 MHHhc9y/n5X4vk0dQ7S1NWZs5oqBGFcDxss4ffwpZPwdfQIOyn0KtZ2s4n8Bj9Mo3L1H
 59vb6FjLAqf8YiK1diU25l2qb28m4WPflqIoAsKcXhNnEKtajVlhN6ZAS7IqZ3dBghwo
 mC/uibHGlSITAHD8oCYtxHU5Up1KNJiY5TYLQK6NuFphWgnmC/KPYMib24UScx2+i0ZJ
 I18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785843653; x=1786448453;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N03HRKNejbgTa+F3mtvkpF1/AI/l56Ox/GYbQr7puFw=;
 b=C0BaI19X0a6+ADaDDPAMRZvOqnawjTAKEk+az/F75URR68ZEqAHucjGUvmvHNXfx2j
 eeXLhoYVPaso9sTmE21KwHkjCbLagD/n5FL3fApwMUtDdasGU0GE8EIl3owrJyiG8zZb
 UdaYv64L5b7JgjaDkOFIOTKdHn4hmsYBhT2jKE/GaeLvYj5dss+D9Qo6rCKJd2RiD3TE
 8PyS8P05XPcLXZxowRal0/MimrKWAxqwK1g/5TwGqQKA8OlC2cyu6lt9+FbdK6OPNLr/
 9CP8kCP8EWsqR0LQRrFkS4uDXnaB0TMu3jq2ib8ox/JyQfl377OEq+MuyL/Tq/UVRKmM
 wg/w==
X-Gm-Message-State: AOJu0YxlmUIgIpjnpP+wZD/34COpySJKamOqdPUHL0U0DlsEkH2Z29eI
 ycCs7Gk4S4vY9S7uiqWzduRJek6xNGBih34XqTVkLe7fMlbDeWKI3mapJ1MTBfih3Q+zF9w06T8
 0Nkuj/9ap3iUL456KOwjTjbA6B5HG05U=
X-Gm-Gg: AR+sD12BJzhB2qCTwWf/rgLJFTKSqPcaWXTHWbiMjwaM0UN2QyYN6sk5b6e03skdcPt
 XTNaWqNUjgyo9aY3Na9YUehyS1cwRdjNMqmWHpKgl+N1QCitxWmhQaPQMM0N9/R5dpmKk5EORnt
 vh0T6APtZD7wj9EV6h4ZfWgYhgHdbClY1q+ZJg7SyEaoUBPPhtICxLFYvvknJLgmTv1DyMQ3HEP
 3FLDkIrPnf2qZ8wfq3Xo4L5dgcRy3d3FcMsOyenvUpeC0Hc2PKK7jkQAw2DUdvxVdJRLXWBrnYB
 qsabOV81+ODLifEmMQlpfgCLFUlwGnl49wbRlbVh4CmoSCBRz/34ij0=
X-Received: by 2002:a05:690e:440d:b0:669:4843:f2e2 with SMTP id
 956f58d0204a3-6694f1b7275mr12839803d50.36.1785843652908; Tue, 04 Aug 2026
 04:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260804081459.8007-1-wafgo01@gmail.com>
In-Reply-To: <20260804081459.8007-1-wafgo01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 4 Aug 2026 19:40:39 +0800
X-Gm-Features: AUfX_mwSBdtdBDxbPjghhMQ_fxBZjTrhlQG-mFtAc86QZeHjEX1yv5IJUsSeup4
Message-ID: <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Wadim,

On Tue, Aug 4, 2026 at 4:15=E2=80=AFPM Wadim Mueller <wafgo01@gmail.com> wr=
ote:
>
> sdhci_do_adma() processes at most SDHC_ADMA_DESCS_PER_DELAY descriptors
> per invocation and then reschedules itself SDHC_TRANSFER_DELAY ns later
> on QEMU_CLOCK_VIRTUAL.  For a large bulk transfer this spreads the DMA
> across hundreds of virtual-clock round-trips, advancing the guest's
> virtual time between descriptor batches.
>
> A guest that bounds the transfer with its own data/status timeout
> (counted in guest time) can then see that timeout expire mid-transfer.
> Concretely, U-Boot on a TI AM64x reading a ~28 MiB image with a single
> CMD18 multi-block ADMA2 read intermittently aborts with "Timeout for
> status update" and falls back to (failing) distro boot.  The transfer
> itself is correct; only the artificial per-batch pacing triggers the
> guest timeout.
>
> Run a descriptor chain that carries no SDHC_ADMA_ATTR_INT attribute to
> completion within a single call.  Chains that do request a DMA-boundary
> interrupt still deliver it and reschedule exactly as before, so a guest
> relying on that pacing is unaffected.
>
> Now that the per-call bound is gone, cap the number of descriptors
> processed per call so that a malformed or circular descriptor list (a
> self-referencing link, or a persistently faulting non-END/non-INT
> descriptor) cannot spin the calling thread forever; on overflow, break
> to the existing reschedule path so the main loop stays responsive.
>
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  hw/sd/sdhci-internal.h |  9 +++++++++
>  hw/sd/sdhci.c          | 23 +++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>

Would you please try this series to see if this fixes the issue you
saw on TI AM64x?
https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D515264

Regards,
Bin

