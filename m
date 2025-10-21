Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A8ECCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF7c-0004Ss-CO; Tue, 21 Oct 2025 12:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBF7a-0004Sj-43
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:22:02 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBF7X-0002fN-QT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:22:01 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7815092cd22so77405317b3.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761063716; x=1761668516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6VJB5oKy8LefUWWnO+OPFQQIZ3YmoI8J9G62CvD4Psk=;
 b=QF/II7LwZ+//NrUhoyQDPDzFXGBdImJLZZqjsXH3f+MRC3OYf4IWDux3h5llYxXEN1
 JJREWwliUf2ziE8braB62P/UDv/umk6xLrX2rm7u+5AETxbPCFKNIaTs3E4BFLLrJ1gu
 lvq1x6fVSKZq5b8bELSXh8PcXSqazsiNH9NyjVPRAmzCvXsvc4Jl+pRV5iUXp3geqzZ5
 TezeRKJ/gmufEn+ubSx+mvmsFwpqhSvPvOZvGszcMVq9OPXCpCSTq4dIrVcBvC1p9BTc
 +W7CoD3QFOI5TQLz9l0iBgcG2wLfSK7ZJ87HrzdigbNFEQU7s/FFmFpJHiSjmGvP18fd
 uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063716; x=1761668516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6VJB5oKy8LefUWWnO+OPFQQIZ3YmoI8J9G62CvD4Psk=;
 b=O/jvSwPHJo4SllS1/454XOZQ+ee2ZG0kS2wfLjqG7BF2A1UixnfxEqNMMp6Y/LOuv4
 jn0/HjduOmIz56MTkxB8rqwBzmiGgRMnH1nBjtOQA/KdcLxG3A9Bq34wHD/kYI++148K
 N60uavD8YBaksZtNDU652/c4xZJK66lzB73FxovPSGy+CNEpBUg7MPNbVovBVKZFZdXL
 RqKd1TdNo63LvNHm3Dyq60emZEr3bnXKClmBxYy4kyR7wnFpXuicFo/3Z2I+6xbfoIbc
 IOz4MIalAKySYTP3gLGM8067EsJVxUIv2ib7BKhqDF7rArtA8wZugXaN+yInt17EPg74
 T2Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj75V0SNI0bcaAgF+U5InTTEg/+0A8VswPzEAF/d6fn2+LPa9O5hqEp2uqOmJqLzLITmfUmPX7DBkv@nongnu.org
X-Gm-Message-State: AOJu0Yw5xOASpH0L5uKSR8BoG/9QObFyqTcn1sEdBdMQYoOmlyoPZnm6
 PF4KazEOYfFOwJ89lxxoG9Hu+vEcTD06+EPKyiciTpL6XHHA6dRTuJLtirkTw6EUHRXyyDJYP50
 INdisExqfWikqrd8OhzNRlOL9pdWSPqX0EEg7n9h26A==
X-Gm-Gg: ASbGncuOSXO11Ty8T/c+V1u3yaUtCSY8oJt+KH+1LhEESwgLVhHuiYlQZo7vT/ffsi2
 TuwJ043TFwqJIJU9YIF0OaSqVccjFLJmsGOZ0MxxgOs0ySs8I7u06J4xc1oG0sAPc0DXDQzeFJm
 +bIJCGe3I9yhMBmp5pVck7lODKSBCPIbjUteUrlfYmNOs3+PJUHX8QczTnQIpIcwn+uHOHf275/
 WCwSUGwUm9iL7Y6R97Lg+7zbISnpKMpzWyrqQ27N+urHKas4RBfJrOV8uFryQ==
X-Google-Smtp-Source: AGHT+IER3BLOG/+PKzUqyoSnwYaTHnMBNmaheczZdwz0XWuKD3OMzbvnINenmNR3o5R7hnViE9fP9mszu0hjpvC1bYI=
X-Received: by 2002:a05:690e:1901:b0:63d:ceaa:2666 with SMTP id
 956f58d0204a3-63e161fc236mr13596901d50.63.1761063716044; Tue, 21 Oct 2025
 09:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
In-Reply-To: <aPex9SsQOup69DRI@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 17:21:44 +0100
X-Gm-Features: AS18NWDN5fgiYrRSmpLaLC2fOq4gb9qF1gM5Ki2ig0Qm0x6a7rvLRjlxO2dGZ3I
Message-ID: <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
To: Peter Xu <peterx@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 21 Oct 2025 at 17:16, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > Do you have plans for further cleanup/extension of the
> > use of Error here that would let these functions pass
> > the Error back up the chain ?
>
> It would be non-trivial though as we'll need to change VMStateInfo.get()
> API and that'll be another lot of churns.

We could at least do it in stages, so we add new fields
.get_err and .put_err that have the new API with Error*;
the calling code in migration/ uses the new functions if
they're non-NULL, otherwise falling back to the old ones.
Then we only need to update the implementations which
want to be able to return an Error. (This is the same sort
of thing we have with MemoryRegionOps and its read/write
vs read_with_attrs/write_with_attrs methods.)

The downside is we end up with another "there's two ways
you can do this" API.

-- PMM

