Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28004CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSV1-0002ZN-D1; Mon, 11 May 2026 11:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSUs-0002YF-0z
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:24:45 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSUo-00060r-7M
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:24:41 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6579254f996so2681776d50.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513077; cv=none;
 d=google.com; s=arc-20240605;
 b=VeHjm4ejecqvfljUjhBqM8YNH8knXw+G4+D70Vv/+beaqiwWQg4LZ2oFSREXxh8eW7
 qERdRv1cxqueNPVcdsGryBvV7erFdWeTfs9Hsl5f9QOmYDUswKDV2AP4acjMnjHku1lm
 YiAV3BN3K1D+4ztjR5mqny4Ld10Nhnp2dWS0stS2bWoTaYToAstvGYpHSCq+13zRxJaV
 8ebZxhvZmB89JckdkouDnaYZePYCxiwQm5zkt8vCwmOkM0gGx23e/iwJKsuZuBEzishf
 +6SV5rVxM8HWz6V2BRsVBVipSAZEh28rKzNnEDv8xdl+qpSfu7AefVepGPo9EGN1vTBE
 5OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/2592oKrHfxZjl9hMlevnjuzicCWZKJ/yBJN/W1jPME=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=L+0CYi5VCpnIzFPjV3OH0GFh9Bgp9ulVbHMH8JR9n03LXInxsQ4qqkA9/eiiVcKwz5
 aRCSaZFPkngFJlrrfit+QjiZbRL3fRrLBs83vnvUkB2wNlOGHbNuOulMkbRaCW6bZyMp
 LW4s3U2Pgin6hMmWuwZ7H84RittU03RFdZD7010WQSWU70E68gqS7Uta3Eg9u+zTo055
 /l7rURFzirJPvLywpcY55+A4b7Xs5lnCpcLnj1IyR2Nm36BymUn6X4xLxGXZlk9l0GTe
 VDPKLcqWFk028aRrNwtCrtdmHkohmWzH5uEUSr9dZE5WuqoUCRVlmSB9G2sR+F5FEPaZ
 6RpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778513077; x=1779117877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2592oKrHfxZjl9hMlevnjuzicCWZKJ/yBJN/W1jPME=;
 b=iRGmnEk/5dz8Bm8kqzmAv4iuudc16AaR5tJa1gUPB+MPuu7NfEIL3KMqp4aYQzq2Bc
 ke1xjftWpIN6YmLGIb3bE32LI4nfUrFCoQVkUOyyp+3sb9eBYWs5xxXts4RlZ43NFhy1
 dgNqC3y9nTbTGsn3g2HU0rIgapaPsUG7VbBYdh01mZYdD9z1iNwR47seD0BQSr/LlcdF
 vsS2X7lq9K5215PRtsURYsjXQcQd/n78oRt1a/xvfpgs8xNkjxgmYIJ70GfS7Vo3cu2L
 Bqvo0ZA/kVa+DuRltcOiW5OzXAWQuVvXeNNTQXpFWdRMk+1FGEqSGe327KnKkj86a4ur
 9WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513077; x=1779117877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2592oKrHfxZjl9hMlevnjuzicCWZKJ/yBJN/W1jPME=;
 b=d0Vr5aCmAtYNiUkmLhsweIEyD63zivFOd5h061KwbJ2R2FDmjMw28dEtLr9o4od1As
 rz731hLIETZGzU3nijqc1XTqAackYNFUYET0EFDXlWXcNkOHXHzGbHuTnE1wrdDqCr0U
 q0mPWGFi5vrQknaIB3BwEqYH7xLQUtkPOhoeUQfbs85tOIun6AUBMjCO4fV1Rqt0YaGK
 lF7yTyyBaDc42ueXHAy8rjeiuzQGxcITjDtXnVVytXaM6juwbkIp5ryNlwGqX9b43hSd
 pvfYpYZ2uM8L728RVm3e9fIaxMSj3SMPDaWCA/PpL6nVhYV0SS+hHRTwT0HwENF0x5wP
 mQUw==
X-Gm-Message-State: AOJu0YwwG0sA93fAz7RoFbOKzQu09iVWvYdB39Ui0i0Iz6JhZSgaEVuY
 khBCU2AcJVwYlDzdQb2ap9y4002g0ebxqbU3Qn/P9/ddd0k2pOHL4BulHYJF+HESWcaOq6F7cHM
 WmEdM4S5JZYRjyQuM0ORweMw6aLFKo1bRKqo/lz3nng==
X-Gm-Gg: Acq92OG1SwFUkqlUpeAkUIUFWsCUNPn3/xHwS76CIkzPPeWcbaoi6DqlC5vazdKRe4m
 zCGjzIWl7Px6aqYeYWCFi3E85hgRgNOzt6m6FvfObUKhT2nr6KuMyBi1XDV4bAOOL8z/F59aJqd
 DmAEH03SqINm+0v8MbNUExpyw3i4D9u1LnpD7Zowq9q6tdurLPBaNEjOtT5uCGhA84iIrxInHGA
 7sS0g2u+VneubyZw0o6eS2o5olj5gQjGzi7G7/wQxnQN5QWVQxa3hjEtppJmUGaFJ32H97xmlru
 vMrUYY+1aYdyxsrv9bd34KT1jUAAmBIITsPOd917e/S78h8jeQjZ3lwdkAuYHl6cAjsfC/ZJmEX
 mtQ==
X-Received: by 2002:a53:d014:0:b0:65c:39db:7ab7 with SMTP id
 956f58d0204a3-65c79e34de7mr22689729d50.55.1778513076721; Mon, 11 May 2026
 08:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260511141049.1293449-1-peterx@redhat.com>
 <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
 <agHs1PcxZYJtba4W@x1.local> <agHzQnXFQbnam-RF@x1.local>
In-Reply-To: <agHzQnXFQbnam-RF@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:24:24 +0100
X-Gm-Features: AVHnY4JpnPbtqmZ97la-qZdHWepKzQBU5jjw0twcyBFWbNBENrlcEx5UOaiXiok
Message-ID: <CAFEAcA8L_BgfHEUnJhWCJ9-aMPUadbvQWGrF2UAW8vE53JP=6A@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc expected
 downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 11 May 2026 at 16:18, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 10:51:00AM -0400, Peter Xu wrote:
> > On Mon, May 11, 2026 at 03:26:06PM +0100, Peter Maydell wrote:
> > > On Mon, 11 May 2026 at 15:10, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > > > that the value will be calculated on-demand.  One side effect on the change
> > > > is QEMU will allow the calculation to happen anytime even if there's no
> > > > transfer happening for a short while.
> > > >
> > > > PeterM reported an ubsan report from clang when running migration-test with
> > > > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > > > concurrently so some of the src QEMU may not get chance to push any data,
> > > > causing mbps to be 0:
> > > >
> > > > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> > > >
> > > > Fix it by checking mbps non-zero before the devision.
> > > >
> > > > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  migration/migration.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index b6f78eb3ac..b06e577328 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -1044,12 +1044,18 @@ static bool migrate_show_downtime(MigrationState *s)
> > > >  /* Return expected downtime (unit: milliseconds) */
> > > >  int64_t migration_downtime_calc_expected(MigrationState *s)
> > > >  {
> > > > +    double bw;
> > > > +
> > > >      if (mig_stats.dirty_sync_count <= 1) {
> > > >          return migrate_downtime_limit();
> > > >      }
> > > >
> > > > -    return mig_stats.dirty_bytes_last_sync /
> > > > -        migration_get_switchover_bw(s) * 1000;
> > > > +    bw = migration_get_switchover_bw(s) * 1000;
>
> PS: I think I got the math wrong, not that it matters anymore.. :(
>
> > > > +    if (!bw) {
> > > > +        return INT64_MAX;
> > > > +    }
> > > > +
> > > > +    return mig_stats.dirty_bytes_last_sync / bw;
> > >
> > > I think this is still UB if bw is a value that's nonzero
> > > but still small enough that mig_stats.dirty_bytes_last_sync / bw
> > > is greater than INT64_MAX. It might be more robust to do
> > > something like:
> > >
> > >     double expected = mig_stats.dirty_bytes_last_sync /
> > >         migration_get_switchover_bw(s) * 1000;
> > >
> > >     if (expected >= (double)INT64_MAX) {
> > >         return INT64_MAX;
> > >     }
>
> This actually fails to fix the ubsan issue and I can still reproduce,
> because the ubsan issue was a Nan reported, where it seems when Nan found
> in normal such evaluations it'll return FALSE.  I'll need to use:
>
>         if (expected < (double)INT64_MAX) {
>             return (int64_t)expected;
>         }
>

Hmm, how do we get a NaN ?

-- PMM

