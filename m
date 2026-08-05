Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF527C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrWo7-0000Ke-9l; Wed, 05 Aug 2026 04:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wrWo5-0000KA-J6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:16:57 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wrWo3-000088-Vv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 04:16:57 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-667bae10ba3so713772d50.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 01:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785917814; cv=none;
 d=google.com; s=arc-20260327;
 b=MwsRCAhnaIoHuHLpzOemyCXELV4EBRjqehi729NJ+WRlbuomFpCJARdqVjDDyvJkVr
 9FIzIkA9vZGwqDkTizDq0lLmh9FH80JzqVhfwefOtbmmEyoKBxGrfC7ga84vow3XteP3
 skO7qtSnQpAdpK9RO6PWabv0krC9KZ/daOWSbv+yBB6sLAkDASv7TGkoG0/bNIHwA0w3
 abxWEdd2BG2GwzmMG7qCLHKYTKFkPAF0Oq4ibd6i1q3B9+T42YG1uWUMRX2u5BEtGVJx
 JzKet/6Y4f6MGagRb/txrrpVY9eNaSn3vX2usvoTasJ0BBP9VhG7YSQ4At/HukyQvnXq
 IasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ImbS7COKELAOt/Dz6PVXo7FmXM5CNVcV82zVIevCp1g=;
 fh=KE3wEp9BzDHz6wDa2zPlp0X2UcazmsfwKriOK7opl3U=;
 b=DjF4Qe/K4Z1gd2cv30neQOV6jyU2i1ljEObdQ3T0d2DW7mTZpYEvFaHPOTIEILYk/0
 zcd0DTSa+76mHSg7QmEyOFuA3Pzfc/udfia9EapACpKoOaicyik7gL0MENZvZoO/jIXY
 ZO03tsO99TSaZ29KztufS4AU31ZYuGSTQ3owYKdrrT1T1yOK/omO10CTx8OPNmcDnaCL
 EcRzJdFmauwjapF5Vo3KD9+xoQOnuTLa8bQTqQb6i4owXm7PgKcy8dC+FyMzwVeUgMMx
 9Y3AnM798FTuiZlqnjxS+/qQthkeFAx6c4rq9ABH2yAHZ/w3tURf7PmmwReU/nT9U5g3
 c+nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785917814; x=1786522614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ImbS7COKELAOt/Dz6PVXo7FmXM5CNVcV82zVIevCp1g=;
 b=CBndPaN5/RZEXjX/Tmh769nKBZkJ0p+vwJ7zd4Kqlccq3tAPkOCMsfrr23RXN4QeEE
 uF0+5GHaNCM+huCnbwuU07GdQ1M/GNKP4XKsgu9SbYnyKhm1pTYOcv/h87tMl5yQQoQN
 h2L2HR1jYafsmzn2LjEOq0LewcUoxbxr68U0DyizIhpUADhp+3X9fb8b5IIvQP4UU6pQ
 L4VOonHdzGmIxx29DCKF/SMhm4Yz8UrXxtNbSuQkdB4Hgw293RFY0ICnSSG+hQZJFp8r
 PHVu2GTHnt1yXdZe46dHmfFSaU+pM/NQKZh5jAUM/gkNJTV3n+B4WZ4LCd+AItxHt+T6
 WxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785917814; x=1786522614;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ImbS7COKELAOt/Dz6PVXo7FmXM5CNVcV82zVIevCp1g=;
 b=ewlwt81DdRx6z5e1mN7vNlsbsSgyAlbL77Bfqkp+WXrkoRs5vHy8Wbnh/tAeRre8w+
 j76CkaBOiMkEDxNSzV+brHRWO6Neum4e0MxofPXHf8yBBn3D2uf/xpk+JMzNq4vfctW5
 ZrXXNxbEc56fm+5wyC/UMgFk2Iz+uLLSYsO0aL/CDF88rmWXy9bn64pGl+eXaMJmLroB
 qFNWe/Mk/D8QX6lmoo2TBkotbrBB5Z844Hy4H7yMARJLror59+wH7goQpB6q5uxqa3rS
 ZdWBwhJ7KhOfJjOD5L2no42blqwyu8bfQ1h4tVq+LqHeMFprV8SwUsb/5nwPOIQ5YnXX
 mGLQ==
X-Gm-Message-State: AOJu0Yx/rNDFA1vIY4EkGFeU389Nks3P+ZVRqnqgyKW7VrY/5yj0VgCH
 zHcX5/pbiOWBQla1BxFbeLhaJqvk5IyQrerOJegaG2lZUD8IHV+nwP9CaMWW3zcI4IPEonOYfjG
 fOdFwJ8TygYrNoP72leZz9MNo0J/QgXw=
X-Gm-Gg: AR+sD13H0f6ZfEdOqhFAi5T44TKmutNgfzD8lcozO4YvPJHjFO8aRjHHU92BX8Ee/My
 2Kd/4ASBFtn0PQb3GsiKNcc31LEoK7ST8eBEVD4InuOeeZk61CSBHeCD+Bq0YRmqTozg/iat3pv
 eWXYUCZFQTsrRe16YscmvRZ5PprXx+jTnV7/efIN8lm98VuvEnZaL9jijNH6Q1eSQyh1VuOP0mR
 MolettpoE/mdqte3iDhZJT36A43MkCeM7R6QbmP99DqRcmQ6dBq73/RpSrgbk+AVbHUTsSyQ2jj
 3kUKbCGK9+iB3LOAkM8cHtnZIjcXiv5dlxYjC80G6ncb
X-Received: by 2002:a05:690e:d0e:b0:669:8a3e:c5ff with SMTP id
 956f58d0204a3-6699abf42c5mr2767526d50.35.1785917814140; Wed, 05 Aug 2026
 01:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
 <20260805080540.323431-1-wafgo01@gmail.com>
In-Reply-To: <20260805080540.323431-1-wafgo01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Aug 2026 16:16:42 +0800
X-Gm-Features: AUfX_mxu3bPSUyqIT9m2W1acsciivxatiEltQyP719FPoj19PgVShSlhWKUOvos
Message-ID: <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12d.google.com
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

On Wed, Aug 5, 2026 at 4:05=E2=80=AFPM Wadim Mueller <wafgo01@gmail.com> wr=
ote:
>
> Hi Bin,
>
> Thanks a lot for the pointer -- I gave it a go. Let me share what I saw,
> with a couple of caveats up front, since I'm not sure I tested it fairly.
>
> Caveat 1: series 515264 doesn't apply on the tree I'm on -- it seems to
> build on earlier SD/SDHCI rework I don't have yet (e.g.
> SDHCIState.sdma_boundary_paused, sdhci_sdma_transfer_active, the Host
> Control 2 migration), so patches 07-11 and 13 didn't build against my
> base. So I couldn't test the series as-is.

Sorry about that, I should have mentioned that the following SDMA fix
should be applied first:
https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D513930

> Caveat 2: to still get a data point I hand-applied only what I understood
> to be the core idea of patch 12 -- driving ADMA purely from the transfer
> timer and no longer resuming it from MMIO reads/writes -- on top of my
> AM64x tree. That's my approximation of your change, so I may well be
> misrepresenting it; please correct me if so.
>
> With that approximation, over 15 hands-off boots each of the same
> unmodified image (a ~28 MiB CMD18 ADMA2-64 read), counting the U-Boot
> "Timeout for status update" failures:
>
>   baseline (sliced sdhci_do_adma, ADMA resumed from MMIO):    7/15 time o=
ut
>   patch-12 approximation (ADMA timer-only, MMIO-decoupled):  10/15 time o=
ut
>   my patch (complete non-INT chains in one pass):             0/15
>
> I don't want to read too much into 7 vs 10 (small sample, overlapping),
> but what I take from it is that the timer-only approximation still timed
> out in most boots here, i.e. it doesn't seem to cover this particular
> failure, whereas completing the chain in one pass avoided it in every run=
.
>
> My guess as to why -- and this is only a guess -- is that the two things
> might be different facets of the same symptom:
>
>  - Your patch, as I understand it, targets a status *read* itself
>    executing a pending ADMA batch and thus returning late.
>
>  - What bites us on AM64x looks more like the *batched* transfer racing a
>    guest-side timeout: sdhci_do_adma still does only
>    SDHC_ADMA_DESCS_PER_DELAY descriptors per call and reschedules
>    SDHC_TRANSFER_DELAY ns later on QEMU_CLOCK_VIRTUAL, so a big transfer
>    is spread over many virtual-clock round-trips and U-Boot's timeout (in
>    guest time) can expire mid-transfer. If that's right, keeping the
>    per-batch reschedule would leave that race in place, which might be wh=
y
>    the approximation didn't help here.
>
> So my hunch is the two changes may be complementary rather than
> alternatives -- but I could easily be wrong about your patch given I only
> approximated it. Would it help if I rebased onto a base with the
> prerequisite SD rework and tested the actual series, or if I shared the
> AM64x reproducer? Whatever's most useful to you.

Yeah, please share the AM64x reproducer. I could investigate a bit more.

Regards,
Bin

