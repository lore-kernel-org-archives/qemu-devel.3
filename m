Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93EB10F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6CCb-00088k-Ni; Fri, 27 Mar 2026 14:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6CCQ-00086G-T6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:46:28 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6CCO-0002px-OU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:46:26 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65006c99d38so228122d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774637180; cv=none;
 d=google.com; s=arc-20240605;
 b=N7foHAlqo32Hj3umHDTGA6ScSwVQ/B2rLFa6DEYW/Dt71PZrB6Ds4/bnzX5v6RArTG
 Dz46cYYrtW+2bKjSSSiBd7TMPsf5XwfeWCJrs/u6qZwLFjjuROosSV94aAAlcN0N8yTf
 Ph+J76OwWMpKxqOBqjAD4jxqcJDAl/UoFWg/vSgtVq/JRvj0AJ7AK9UWlWTV4/X+DjUC
 ZzDdSUwtLWqe1j6EqOKxtuvd/rKpAXpFI46/eCiXbDSdptXj8mc07u9Gw/XNE0tq7FJZ
 vUUaQ7wt79icXIZ4+nMvJBgqbSeJ9hGqUvovhaTyOI2aoGc+ERsazIvbgT1PtgjH+sNc
 N2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vo1vNJohjwePCOE1U/4xs4BMACehosBhajnI7Fo4Agk=;
 fh=qJo+eYuOX1Hs9gvlBO+6VP2wDkpE7Fo9OW/RrPQyPo0=;
 b=A4ykpnSHhpIsbuAnvlOiZcPFKWJFYoMtjid35KWEnNnyw2EyLyl9h+LOBptXNR2lH6
 YA9PBBNYgGlw7nhvWapTMqIAbXgwJmeCM4F/wmSERAuoLrNZH1w9nu/huDJbMzMkOtCM
 ojwxXhm1AqQ3S55z18qiiQeud9gyugPd3CdqJITmEFP8rE6u8e+We7ja/Q1PIvO3cZdR
 vv0B3Keg3txtsCUElCSKGxzHcf9QFKWx/p6TTLZOgqLbk5nqurFkCW1HZycmOGTo5X/c
 LE4tVYnUqWn/76XAWTmGSuZnoIp+cY5PxnRwweTBGV/LmEu9uRoaLrX/6fUdj1/tXmP5
 b9hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774637180; x=1775241980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vo1vNJohjwePCOE1U/4xs4BMACehosBhajnI7Fo4Agk=;
 b=AvuYKPm0erPZEuCroHKZU1eAXrwj20/mEr6yRQBMzfud3sL7Cd8NrZ+ClPpFIlNTPi
 oXxo+Gzvpt26PFdLJVamGxSty/0XGlZzsaW1UF9HFOS/+LN2gugjjBXyfXjev94gx0BW
 MkzHQyKQ6VWomWsQ7w9gt/w9lO3p+7uIeap0pVabT5vBe+TVw1ECz+6bLzqPJ25Q4eiA
 7b5MIXqkYtQiYK0UKA0rq9xk66FfveCrxO55rRUkliSlHgIGx96YettAt21MLu0I6RZ0
 gI9m5nfYSAlcs291YHo3FWnpIB3MncFoN95o56i2sheSSj19xwBkUNYUTsN3/uP9fyZu
 P7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774637180; x=1775241980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vo1vNJohjwePCOE1U/4xs4BMACehosBhajnI7Fo4Agk=;
 b=RhiHI6/z4U+zP+jEOCsjXja+TtnJNd3zXTsBE+05nJ5ujP2WpzXe+bnap9fhZqHber
 StFmiSfO282xxoFZg5F7OWkHmwalnIei/292m784xuGUV6tUMgwyBIgLclF13W2OU9be
 VaYQUcVAWA8lGkNry6hM1/6ScllBpI6NXatMbWGwi3xOyFVQ1DsFhBknYqRsA+Tr3ijP
 CkZUNYCRkid3JLU359fScKzbAajeepfin2nmtHK2GZhQ9cAM+Ub+ICvCHYdYdkpPDMbw
 trBiL586j6ZlVFC4xHpGCfLs/Y54dQldzrnKvyouMAfc+s7VX+2pX+WSwuA3z6xtq7IV
 7qmg==
X-Gm-Message-State: AOJu0YzdGQPzfcDMAFq2RCD+eEvuoW5fBZPP43/WQxQcJxsK+rSP9ZU2
 Bipbj37VhQdTMiKS55S7kHwoGLcQqT6xZy1QZDpz0atRkGNxuinAh4utMNDi3rbSzEIDqkxuMkx
 GRHu03PwBtRitVVS767ozNwHAWezWIrEPZhJkU/U1uQ==
X-Gm-Gg: ATEYQzyAQf0eHbbb3J/wdly/+q7JEwOQ0mMk6yLG9DoHxklj+pIHnmzAZJq8QkKcKUw
 bMU4kM+wH3ObXMK/Z675CnieDi84uW+sox+aJ/Q+9xoz6R0t4yBz3b8Fa2xNicb0cUrZtEyoyQw
 TXZizzNzOgIz0n7AZtgcgWDkMQ+euIz1eSXXD7TU7lbxs5Pku9PKGlXSwuSOCliFpGUT++F/NB0
 ZaYehU8Vabk+jHPxIMJIsG0pY1YIZc/jMA4mUzDTgPCzRblO6wm5p25IVjwjjTEIyQaqoifbDA8
 BM4md6OuhMqj/rTGQ7mK3Dfdr+57dDtsjj4QpLRwhRKT8Z2CQjyO7eGCowJpZ97jjFs=
X-Received: by 2002:a05:690e:4850:b0:64e:ebb4:1bd3 with SMTP id
 956f58d0204a3-64ff71d6b14mr2680737d50.26.1774637180134; Fri, 27 Mar 2026
 11:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260327174701.364328-1-pbonzini@redhat.com>
In-Reply-To: <20260327174701.364328-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 18:46:06 +0000
X-Gm-Features: AQROBzDIeU7F3PZuHOniHL1CJUWd_7LZMrrttdQBM9qDgkhyfaLvzJD28WAKArI
Message-ID: <CAFEAcA8R0qGsaBAQLgAGRgU1H+4JRpRCa8TaeAcdYo25R=dQww@mail.gmail.com>
Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 27 Mar 2026 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Fix an off-by-one issue in QEMU's HPET read and write MMIO handlers.
> Both handlers check timer_id > s->num_timers instead of timer_id >=
> s->num_timers, allowing a guest to access one timer beyond the valid
> range.
>
> The affected slot is initialized properly in hpet_realize, which goes
> through all HPET_MAX_TIMERS elements of the array, so even though
> it is not reset in hpet_reset() the bug does not cause any use of
> uninitialized host memory.  Because of this, and also because (even
> though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
> its MMIO region, the bug has no security implications.
>
> Commit 869b0afa4fa ("rust/hpet: Drop BqlCell wrapper for num_timers",
> 2025-06-06) silently fixed the same bug in rust/hw/timer/hpet/src/device.rs.
>
> Reported-by: Yuma Kurogome, Ricerca Security, Inc. <yumak@ricsec.co.jp>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

If we can only fit 24 timers into the MMIO region, should we do one of:
 * lower HPET_MAX_TIMERS
 * enlarge the MMIO region
 * leave HPET_MAX_TIMERS where it is but make realize enforce
   that num_timers <= 24 ?

thanks
-- PMM

