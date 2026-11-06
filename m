Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C1606D804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QZ2wHUZy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMul-0005Me-AS; Fri, 06 Nov 2026 11:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMuH-0005DT-RI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:35:15 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMuD-0006Ku-NP
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:35:13 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b118bea471so5665397b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:35:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982906; cv=none;
 d=google.com; s=arc-20260327;
 b=FDlwsP75bQN+8JXavH9jqQPkxPIXT5G5xZLHSOj/e4eYQbVQKLIwXZQXDnWHLKDOqT
 +niQIyIv2ztspqqxyDNn3frLG9XMeBn3PJgXs4EmEMGb6K8p66hE2xPFHDwQwXP3EpZd
 gBP99257KVnkteuTAcseSCefIju9TVa+0KX35iYlgihA/MiPh207FlSH8HUEIGKtqGLN
 +BfWNL0qAOwFgf1sOCVc5ZaSpoNQMKA5L0R850KQRLiSDpfPBXIJHS5h3Y2+dScbpVhE
 8oOb9RxzwQxUL8f5sDHqivPwxxRgg8MWflh7E43DjS2Kz5hd1L9Pja3xIJQlUrW5uFV9
 NBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5VHTT3acUfM7Uago6EoQ//pjBKk+YF6NDX5f7hiH4L8=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=oIspfhgjqw4lZFbWtGt+IePqezcmoKXG1q3eQebHDQLTmNiCGr23hr8LAWqDGhfVW3
 XMzJ81GTWt08bAA9MFf/uxPZ0ucpzyMOIFxWMwSpM4b7Vhrb++8QXWwoTUMUh5/jeuI4
 I2pZkwTl+mrYWcFTOOK6LuNuKsjdK13iGS1S0XVWUSnKz2NgkfRIc5mISBbJs3Zq3vqn
 GX+OTwVfFja2/6mXYxaYTK+8pk6tcOUrSihK3tbD+jFbdgfb/VJ7M8GLT074XwjjlJoq
 3dsgc/XqEOS9skvGjZdrrTPUQ1ACQbHwwOWhT3pFBOVHAnuPGLeUr56ghX9NSV2G1TfH
 VKpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793982906; x=1794587706; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5VHTT3acUfM7Uago6EoQ//pjBKk+YF6NDX5f7hiH4L8=;
 b=QZ2wHUZysWy/M0reZti2pMpJWd6IaMwNV9Th+jYriaZ3Jg4NP70CVqz9rGfAdWtzPU
 3+ILEQVGGW8HlfuhtsNhLpqIcklovwzrqhp1PHQZFnCfKzt1toMeey5LlSilKlmrsYlN
 TAiJKCFFZVAZB7RdwvUXNwE0xr3QTnV3DRN9pCAqb607C8cyJEoC+RVz4xKvSM9h1/G7
 tCFzHYBTI3n64+ucjYBV7UB3gRi2CBTAysiNAVazrslw/QA/QBAdZYfNaschy8nyYz8A
 X+ID97UJbJUlx/dUkoiTd8l04CqqNH5YnpGj10x5dRE9g5UWWK6cEcz7mb9otSw+e1Aq
 xm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793982906; x=1794587706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5VHTT3acUfM7Uago6EoQ//pjBKk+YF6NDX5f7hiH4L8=;
 b=t7uxKHImvcuPSe60NkAHYXPjMhumPfWUBBsMHU42LgDYs+0hGko85VQuL4eGRAQN8p
 K0+OAGowD82A29v9wx8utXZdUH5UspR3aCyCzIfa8T7uC5ax7btxKEMY3rQAfIEK5q+1
 M2MwDwJTFRX3309C/Rn+xEj2PpJypeEmJe6z76EkEVy+zTkEEJV0MGxHE3dxEYSvBW2j
 2RKG9GO3amKTnGhrAV3VXvY89fHssLp1DGRi4+ukuW8vXIe4Dc56gnK6QX+drT+d0KJQ
 xZSygA0cSKIq3EwSItlQYbt7KhFavysn8E3JBm8NafXXTiJrVM2S7bBW6Immvaepfd8I
 tQOw==
X-Gm-Message-State: APuU4Z9LRPutx/zbOBY9RQMRhp3OAAXqtO+hIHZNmkut4XcMYpyw9TLv
 zzFkQXj91AXkfqbQpitaZ2tbbG9Na7oagwow5i2j8IMjpVYgMKVRqZSCJZaVYkq/iowpqyWoamd
 aTwZ8IxjjGuab9AUHP0yQw/SNxFLEUjWI1LU+/I4F6A==
X-Gm-Gg: AYBFou2wO8eOCwLbYy+1eN/cl5fTXWeoD3AKaG71V0OBu7Rwj8VZDl9SlQlt6nPl54J
 +VjDEIjLYDSOtQBkqZT4R9OZUakKX4I2wVWvsBJY33+1Drn7sqoyOGgHrhQHKIRBXfys6udq+pR
 gdasHqtBlWOp4P59ej6S52KU/WxT0h5G/HBfbo+RjD/hRyAspsKrrYxFvj+FjskiVEZDE/zv99i
 RKepkNy5KKSep+FKz51TlpdXUvLM1wMOeHWY4lT9vqr0GDosgklpkGyRo2MLWKiMp4+BcW1QzFF
 aoGLWy5xjk7eGCqZWcVl0rspHxynxpqauKPjehF0HQT51Dwin8eDeXQaj7/yhXM0af2DpZ7eUls
 Xa3uaUuuuhoOGFvL7dd37ucpgM/lfvcgQcGP8Xx6FFzJu+M5TurPMn85xEAsjNxbv2t+++ogo7r
 dbu5VdOCjo7C23zQll/OhscQPdMyNMAffIpvGj5XHW3g==
X-Received: by 2002:a05:690c:386:b0:8b0:a28d:6450 with SMTP id
 00721157ae682-8b341ac56d1mr16598857b3.40.1793982906295; Fri, 06 Nov 2026
 08:35:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019131608.3155474-1-peter.maydell@linaro.org>
 <CAFEAcA_GmyC=zY65pc12idvo0JNk8KpA8vQY5UL8SWAmX3PNRA@mail.gmail.com>
 <CAFEAcA8Lr5j6XjPqUPJzCDkBRhcyPivyRHEB30aLEYHmcWnXNQ@mail.gmail.com>
 <87pkwsinga.fsf@suse.de>
In-Reply-To: <87pkwsinga.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 16:34:55 +0000
X-Gm-Features: AclHuK83ddAQv93Sd_SZMfuaDErqtLHJtnS7uwBVTCw815sz6h5OjFVsFp6OOcU
Message-ID: <CAFEAcA-q7NYTppip-SoZmsikKBTwKDPJJiYcK_Dbr9Ha++ewUQ@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 14:35, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Ping for review from the migration folks on this one, and especially
> > on the followup query at the bottom about version_ids in the
> > vmstates using this macro.
> >
> > thanks
> > -- PMM
> >
> > On Mon, 19 Oct 2026 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> On Mon, 19 Oct 2026 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> >
> >> > The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
> >> > to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
> >> > only be used in migration when the vmstate struct that uses
> >> > VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
> >> > how we define other VMSTATE_FOO which don't take an explicit
> >> > version_id, which is to use a version argument of 0 (e.g. all the
> >> > common macros like VMSTATE_UINT32 are written to pass 0 to their
> >> > VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
> >> > how we define VMSTATE_PTIMER_ARRAY.
> >> >
> >> > The practical effect of this is that users of VMSTATE_PTIMER in
> >> > vmstate structs which explicitly or implicitly have a version_id of 0
> >> > were actually not getting their ptimers migrated.
> >> >
> >> > This affects:
> >> >  vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
> >> >  vmstate_k230_wdt in hw/watchdog/k230_wdt.c
> >> >  vmstate_imx2_wdt in hw/watchdog/wdt_imx2.c
> >> >
> >> > which are used in:
> >> >  * Arm imx-based machines
> >> >  * Arm Xilinx versal and zynq machines
> >> >  * RISC-V K230 machine
> >> >
> >> > Most ptimer users are unaffected because they took the usual approach
> >> > of explicitly setting their starting version_id to 1.
> >> >
> >> > Fix the version_id in this field.  This is a migration compatibility
> >> > break for all the above listed devices/machines.  Since the timers
> >> > involved are in devices where the timer is usually stopped (e.g.  the
> >> > watchdogs only have the timer active when the watchdog is enabled and
> >> > counting down), the consequences of the bug are likely not visible to
> >> > most users.
> >> >
> >> > We could perhaps attempt to preserve migration compatibility here,
> >> > but none of the affected machine types are versioned and so we do not
> >> > promise cross-version compatibility, so do the simple thing.
> >> >
> >> > Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
> >> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
> >> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> > ---
> >> > Not cc: stable because it's a migration format change and we
> >> > don't generally backport those.
> >> >
> >> > As an aside, is the expected way to write a new vmstate to give it
> >> > an explicit version_id of 1? If so, maybe we should look at the
> >> > vmstate structs which don't define one and so get the default 0.
> >> > Or is that just some odd quirk I've picked up because lots of
> >> > existing code uses 1 as its first version ID value?
>
> Well, the version difference is compatibility mechanism, so I don't
> think there can be any prescription on which version to use. The vmsd
> version_id should match or be greater than the field->version_id for the
> fields contained in that version.

I mean it as a style question -- we mostly seem to use "start at 1",
so should we actually say "that's the way to write it" somewhere?
Or should we say "preferred style is start at 0, we were getting it
wrong before"? I'd rather not have "randomly 0 or 1 depending on
author's whim" :-)

> >> Followup query: should we also bump the version_id on the three
> >> affected vmstate structs, to make it clearer that the migration
> >> compat break has happened? Or does it not matter?
> >>
>
> We should, otherwise the old src QEMU (field_id=1,version_id=0) won't
> save the state that the new dst QEMU (field_id=0,version_id=0) will
> expect to be able to load. That errors out migration in the best case
> and causes a crash in the worst.

OK, I'll send a v2 that does that. (In the meantime one of the
three affected devices had a version bump for unrelated reasons
so isn't affected by this bug any more.)

-- PMM

