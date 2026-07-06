Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B95C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfBX-0000Ck-DR; Mon, 06 Jul 2026 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wgfBU-0000Ak-Ec
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wgfBR-0000L6-U0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso4164781a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783328407; cv=none;
 d=google.com; s=arc-20260327;
 b=UgdPP4KUGOtOH5hmmsUMyk8VnojsNIbsXf3Qjv8zoYVzTSWkyuFBBvGUTe/7fhT1rB
 ZCguN8IhbSGHvE3KdlIu20BxATZ60m2d0YWTiHWFal+qXoazHAHqoWE2YSGx/KhmdnxG
 /lMDkglRkykcPuT8ey+Eq5jtlYrZKFeJ4d4uH8X8wL+q8a570o1qLPeBu/NaXnAOR39l
 aQWuV3K7pORmJuzMxwYjNLBaApmg51GLdBnHVzwUOwUzIon07vbbsf1dBc6hJ+ydIzu7
 Wi+wFabF7gZdXcpGAVwv6qv8TM8xPsS99psHaPcD5E+rUUp6nQziTVOeojnJNJQSrue1
 JhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TOLX3/I5M0KfV6o40KVZ3nYbZL6Dz/tzGnvGZT5jE2w=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=VzVQWi1vNEMRc8t/0fawIJtHzHvoFX0FP2fOYS7XV82lZOBGdSSSuP7mpExRg5g5dl
 UZbnHAFIuQt3rGfg1x+ncPVbRfghlCL8TlAXw2pczGV05fdSPhqR20+HgGTYPP8VcpNu
 eAax3LZaHDqMkpfbVdrLceQyZlUUXMRCxio8I7VyaNDw7j2ur2N4jzinAJS5v0RlYjd0
 1B30iIzZRX1hY4LfSXZmmbNjBzzBjCyCnkz3jKuIY9yubuisM6HXWcYpsB6CpTiTCT/s
 TZaivCuV+lYNF2vDw2YJ0R9nCX1rNMMDQ9NDwPZM5HL4sSCQKxe68ch/AiVkrlTUVkq7
 CvoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783328407; x=1783933207; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOLX3/I5M0KfV6o40KVZ3nYbZL6Dz/tzGnvGZT5jE2w=;
 b=JiyatV8zFiQ5POBhLZQWqyh5NJWZT5X5kOTG0wjp5sQuVFLxWSbNaY53cvySDjwXuh
 B9PPoPNL9iQ0OpptLSJuz1yVL4dvknes93PDU/OUw2Iah9M/WRR7Vi/yGifZOkobF7uT
 z01iyg4+173s3XRBLcR7Y5W1qmvAIpeoJ1aNNvLYoOul20jt9dz15ghqfaH30/Vp2jka
 lYDl07apQItIiaSkoL/LllbQgIk3Y3ohOQ6pAGgRpzudyraIrM9IWotmtE/Rd50sKjHD
 d2kTWiZl9PyKaZ8p1U14V8HmWSy3qWt5Q/3HdZ1GiWZ8HcU6vnLzVpSUL4Rzjh/kmzTU
 u53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328407; x=1783933207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOLX3/I5M0KfV6o40KVZ3nYbZL6Dz/tzGnvGZT5jE2w=;
 b=P2yJTtMNGVpDO1tpD9NcwYNQjDyfYvNCN3mvVD84KlsyURyy2841yJFswy1pRJBhYT
 It53tipJTW1ceUxGWv2s+9UN3fBIqPSxvrgI1opJcvfqLu5oAeHb3UOyU85vwizY25C8
 96FTvQarZMKRuqlBiknyCDSbHEaYvAHVnrGm1kW4X6flCTg6bmikspmf+gHMuiehJ+77
 PNweEukwF1Imbe/QF7XGSr4FO2XR6sE21/FFAKPaL2X5Ly2p56xupamHY8mbLn9oS2aL
 txc0RsJfRGK0ppAxaeAXlk4a0+basDoM+AcfP4T+j3DWS5PSqo1APWLaWU/jdx6jD8Cb
 Llww==
X-Gm-Message-State: AOJu0YyqFvkwTvDIHN/wscaUTe2rljgK6Nnf+eRaem+yjN5FazfuVdrB
 9EE6ZmwchXCgadDNbNvkM/TG5V90v7gYC2rC/KZIImemDSDJKPouGCufFm7pje2AVmCybdtnb9H
 LjX5Zba2rZWyop281ZbWrUasZd3UPTSw=
X-Gm-Gg: AfdE7cm+HakBRYgIzYyf88x2A1OWWWtpTFxWNJshUxgTacGGQNMnzUivlyuGEYFtvGF
 Jdf86q+ucSVLptuDGTa29XOHsWwUv8z0LNTCnF/wWIlGANmBwa3LBKU549K2AVksybblNT7Ilhm
 dXdkUEvZ+NkHt7I9sxh7SzJFviIRwS47AMRTE+I5wKvRwQFE+7lSd6L+FcJqtK7U9ylMpCDqBLh
 9eIAJlLkFYdwqUp8eHkKKqtUctfK0rP7aJ+YTmpzTaIF1EExrmekzTlLVCgFCPJeGs7GP4juM9l
 Z0j3BIs=
X-Received: by 2002:a05:6402:4014:b0:698:b55b:4806 with SMTP id
 4fb4d7f45d1cf-69a1a4c7eabmr2993764a12.38.1783328407045; Mon, 06 Jul 2026
 02:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-9-zhangckid@gmail.com>
 <20260701161642.GB413397@fedora>
In-Reply-To: <20260701161642.GB413397@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 6 Jul 2026 16:59:30 +0800
X-Gm-Features: AVVi8Ce6APgLlQIddIpGiGg_zrTdPMrfq-TpH2p_Xtfe2QB4QIpVulpUaf1tkdE
Message-ID: <CAK3tnv+qwj9=rgg3-pF-GYDQm9LbxCOrcr9EkO1dNtk0kBw8oA@mail.gmail.com>
Subject: Re: [PATCH V9 08/17] monitor: switch to
 iothread_unsafe_get_aio_context()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x536.google.com
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

On Thu, Jul 2, 2026 at 2:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:42PM +0800, Zhang Chen wrote:
> > Since previous patches introduced explicit monitor tracking and referen=
ce
> > counting via IOThreadHolder during initialization, standard global call=
s
> > to iothread_get_aio_context() are no longer appropriate for raw context
> > fetches.
> >
> > Switch the remaining fallback sites in monitor_suspend(), monitor_resum=
e(),
> > and monitor_init_qmp() to use iothread_unsafe_get_aio_context(). This a=
ligns
> > with the new safe ref/unref lifecycles introduced for monitor tracking.
>
> Why is the unsafe API used here? monitor_data_init() now takes a
> reference and gets the AioContext. Can you use that AioContext here
> instead of fetching it with iothread_unsafe_get_aio_context()?

Because we have some comments from this series V8 patches:
https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg00375.html

If OK, I will back to the V8 code and follow the [PATCH V9 06/17] comments,
https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07323.html
based on Daniel's series for monitor parts in V10.

Thanks
Chen

