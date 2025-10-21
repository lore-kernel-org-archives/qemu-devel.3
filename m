Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544A9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFYn-0005iK-R2; Tue, 21 Oct 2025 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBFYl-0005i5-Gl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:50:07 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBFYj-0006pd-4C
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:50:07 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-633c1b740c5so5703353d50.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761065403; x=1761670203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gOpV5fFv8tfqvTRbZfhAOH93r44shCFG7sAH2eMKtqA=;
 b=X6qIL22tQTuNYuMNzzxhJU7ubU0cXJznklZ7mZlaOveXetWO/94rhIoEM/u9fhRYOK
 mlqa/+zK+Y4tIgbYjDAeco2ZkA13S36dQihN9pWMy4Pjp2ei7RmEAMoNi+2Wa5PrTgNd
 KPQburpWKWhcQzDH3xaJHtlqNsjJUPVPm2cmQdsu8TtusKn2E1NmBqYL9INue36aMc61
 iCLzjgJeW/Zj/cOXXsA52A2QP5BrVhe65QEEtnxMEjFFAP2FwcvMjS2RogfwNmk//Jj5
 bkbnfPxhGY53OPzCSHUsljhGlHc/0nHG0ABzN6WV8UZaZ9BHCn2vxRJZao24HKQAbBNO
 VJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065403; x=1761670203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOpV5fFv8tfqvTRbZfhAOH93r44shCFG7sAH2eMKtqA=;
 b=Av0BdjCh2i2SvgjGBtjc/LY/mEE8Mu9edXyWs5Z0DeYCVQXD4OHARUi4e1wufeo2rv
 QrmkPH5zhg3xrlRL3dm1yeIUDVg8KYlEAlptQoaEZUDPvAwCnFRcHjxbXZ+AMoRsg38s
 14w/noV+VU6aHNk4z4ecywtUw134JbEWo+i59ZcosaVm9W7s+68sdeV3vYVuh6vprLji
 oNd1hl9oo05UovReMoZg6ddd/5capgfmyOIlzDcib1PFbZU5mYvZmxhrnbaG1UlcCv4b
 0NEX2end+5arUg26pNU1ndZDuWzF0pb2G96499g9zVNfLXmMypSA1ZtRIZKC+6WQS8RX
 h0XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcVHWqLxPe+I9AikFh3ebFhEpRB3SESHoo96iuHJOq+KIyfwICumXjkJ2K/gdnxTPgn98RB0F7yufh@nongnu.org
X-Gm-Message-State: AOJu0YxX9opmWMb41dmxZ8/Hyu5i9B6w6jPiOaPzcvPwCSeu9ZQXlcr5
 1L2ExqmTZ0tXHOUSCepYL6itIeqeQC4IED6gfwPnPdlCdap7HWmK4Kcz+YP4Y3VBpOK5B3RroHM
 PrQEWyWULLUtCHfM5pziR/pMfR6omLu2tdzZK9BhaTw==
X-Gm-Gg: ASbGncsU3UUCkGIb3lZemsIEavSoswC9+guvBuC1yVY3T6A0tvU5U/yAzjMKyhLCXcl
 9TXS24QZ2hq9uL3fhclLZSfo+vtDf6oMOBYsgpoHAFkGnpNK+sZqweN+HU6Dvy4Zhs0fh8ji7B5
 jrbC469NP9ouuYS9YTgB2MtM0JjCXqBgkS5LXaUGBFKs55hGyjc+VMxLvszA74HwKjBWTEYosW9
 GuOB6ZsX/hjgFlvBeYGO7tnfwedju1lSccyP1o1VAnIrRCwsmJUA48rUBvSUQ==
X-Google-Smtp-Source: AGHT+IEtsXrL3qGyHhIV/SiZ6yWHoFJBszViA4+VRxMolRPptBWnO1m4gqZjD5PGNO3F6uOks+6LKbQxJghEYri5p7E=
X-Received: by 2002:a05:690e:130e:b0:636:15d5:aae5 with SMTP id
 956f58d0204a3-63e1617937fmr14178023d50.10.1761065403294; Tue, 21 Oct 2025
 09:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
 <aPe4yBqkPTiDiYXq@x1.local>
In-Reply-To: <aPe4yBqkPTiDiYXq@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 17:49:51 +0100
X-Gm-Features: AS18NWDtvbaOZU7JDyIxt4AFAsabSoX8qiu-tD1M3tU-bSYwDeArZmdbQVsz7ng
Message-ID: <CAFEAcA8e7qKGm7vq-8TFC40VMfoGU_O5+U0rrKG+Z8M3fVdRfg@mail.gmail.com>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
To: Peter Xu <peterx@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 21 Oct 2025 at 17:46, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 21, 2025 at 05:21:44PM +0100, Peter Maydell wrote:
> > On Tue, 21 Oct 2025 at 17:16, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > > > Do you have plans for further cleanup/extension of the
> > > > use of Error here that would let these functions pass
> > > > the Error back up the chain ?
> > >
> > > It would be non-trivial though as we'll need to change VMStateInfo.get()
> > > API and that'll be another lot of churns.
> >
> > We could at least do it in stages, so we add new fields
> > .get_err and .put_err that have the new API with Error*;
> > the calling code in migration/ uses the new functions if
> > they're non-NULL, otherwise falling back to the old ones.
> > Then we only need to update the implementations which
> > want to be able to return an Error. (This is the same sort
> > of thing we have with MemoryRegionOps and its read/write
> > vs read_with_attrs/write_with_attrs methods.)
> >
> > The downside is we end up with another "there's two ways
> > you can do this" API.
>
> Right, the other thing is get()/put() logically should only be used for
> primitives...  I wished they're never used in complicated ways.
>
> IOW, in an ideal world, get()/put() should only fail because of qemufile
> channel errors, rather than anything else.

I suppose so, but that seems like something in practice
we make a lot of use of. It's really handy to be able to
say "this is how you obtain the integer you wanted to put
in the migration stream" -- we do a fair amount of that
in target/arm/machine.c for instance. But those don't
need to return a failure, I suppose.

> Then, descriptive errors for get()/put() may not even be needed..  OTOH,
> complicated structs (like virtio_gpu_load...) should really be done in
> VMSDs already, and anything can fail outside -EIO should be done only in
> pre_save() / post_load() / ...

You can't return an Error from a post_load callback either :-)

-- PMM

