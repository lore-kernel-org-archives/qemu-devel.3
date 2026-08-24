Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E24DC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySOR-0005HE-SO; Mon, 24 Aug 2026 06:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wySOR-0005H5-2A
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:59:07 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wySOP-0000kn-HR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:59:06 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66ceaade3f1so1917613d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787569144; cv=none;
 d=google.com; s=arc-20260327;
 b=FY1lIuxqnCLrxyKAV9vJh9UdoTBK8il7XBpdXpKdRQVAoWv2IxIFbjs522GbRo3qHQ
 VntyuBGCcxSgbxIxRXD95UYWEDjC0nWlKFY2Y7LSZ+EQvFv3lkkJnXsI9qQGTuJ9lKX1
 bCIvK5t2GrKDJuV94tRpV0fUppdO2qBbNOouaE4fzx1yhEqPQOqaVB4TrzPxwVUVKgML
 tsvBE5e5tAuXe8Z/PhPxh/WgG2QZdA1wzh1eRFagtHGFpqBnv6wm8xb4iZ9KXKWSIw3x
 Ddpd0vK8pB3fywGs2UUd53slNDx/G4AAGe92WqKA9fuwwCu1oGgDyh32PLLbJ4VuRdoB
 bExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gj1pj7Aw7SevZUl5mxqOMG1++v+5MHtR55eBiUzO8tA=;
 fh=B6STahklW9K39yksOpcsN4+yLgkd6tQAAsMtrDWs4x8=;
 b=IrdZNb9knJrJtm0Y361LEccR4PRW3Oo3F7iK6LdCyRVfDNGUhEt0weOKEgDsyT3Ot7
 C32w2QQ8dBcKl/WVLu6eolCG6KD/H0r0dF7rgZiT3AScx526aVTo6Pt7PxHWYDNCWpW2
 h91qNhd8a/p54D8Ch6dSnFteyfdrFZyeYfttD3JneI8z8pfjI9QqnslRhBV++qgsFRDt
 IivN1JJpzOgU8j7dXIo0yo23DLZ/BTCJV3rG4AZVv15L1lev44d6kMdnReWrI9Jgn/Dx
 kae4VmT0tQQisAfFKqx6pPm7HblIvFspuAlof4g29f8cZq245yUs6N3wDJMuPy+z23jw
 gyZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787569144; x=1788173944; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gj1pj7Aw7SevZUl5mxqOMG1++v+5MHtR55eBiUzO8tA=;
 b=dTlSWOHI3Wlxp2D+JmTeTv4UhAKVlO5Qb498sHJZ4XtRqJ+hDIks7EY2JkjlZPW+d9
 tiH5dH5XPpHnkP6i5lqkNxCVTwFUKv2EPEzZ4Kic6ApD/cfCc60JZ+b3ExRN2Z5yhMr8
 gw979C2Gs6Nt1rZigbxdiBSbVgkOTuaSVmrBJtzXxCfdiERzv3YhLx7HZB42vdSJyLRJ
 2dWj8ZgggNJMwXR+/LBnmwSib/rMDTjtLpW/rIYMYKcUpgA63ga3nqGQUOGiqlDRExnZ
 GvCIfNi1KsjvchD4pLjYrgWJS2XmNzPy2H9T/WZUsFeekBsKW9Pdb+qmmtxgPbvLa5R6
 c6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787569144; x=1788173944;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gj1pj7Aw7SevZUl5mxqOMG1++v+5MHtR55eBiUzO8tA=;
 b=NxQdE+UFboxygJ6mAvk5jTFUjk13q/x5TIe2aaz/etOj0wHG79PpJVpQ0LBrMaZh5X
 Kiz8sFtHKey+EtzaJs+cNPUf7jk+W46UdOK25KFbBPZmDaZCMcHBNCUAYkIYvZ1xIN1r
 gii71YRgdw6LdZdcXpbwv1vw3ZrddqmScYLgmDBUh44swPDc/FBdnfCUckY3Eadl9nTF
 6sGCJP1X9QXog76CdU/V81E6AuzHkT8DUO8F8tKVWaDutn/J/fFLy8iRP4plz8q/lx2U
 WDiaIPPtmJ6XyBRimvxOoqNAe8uMpkWiuX2Ay8p4MLeU0EdI7vv4p1lsJ2mE5RZ6ZWCD
 jdPA==
X-Gm-Message-State: AFuF++kt6LUA3wVbCaz7CMtuOzJZCyzBlnRTeezwbRkcHMEBdLIIgfSE
 K9v5oEX0Ys7r5T7iFcIuE+kqWYt3DUkPQ1RLSLblHXiRwmuZkFVF4kReNqsMeIuPCwaiCupET+d
 j5ANAVzS1HnR/G0o8ouZqUY8kSekbC79piHeIcK5pSg==
X-Gm-Gg: AR+sD11FhnrhmFiBvgy0wLi7aWvDnpf6pisPrGCem5+ryzov/H/R/Vi99Xq4WCr5VGd
 a2HLeTCGDqqYcfMLjznQu888XrhBLv/cQxm8APnqjVu28PnMGk6ZmoEkHeZUc/jKvkPz79oIKqX
 6a/lVpUFUmXzUBC3pyIUu9tQCt9pRLFjvJ75FwVW8j2JVWuxG4vAgV6GBlZB6nq7aNfpUljYv2C
 gIy98Zr+kWORCWPjNGBTE1bxVQrjyPEa9DArjs202XavlDFC9ZGfHfDGEnphMy+0uNHYEHhz9tS
 0qWvF6tL6Xzz+qcAu1gcSUo7I1YZZGsvBKZQOPbAlES5pdaXB5R0AGJpPQjHzMUik7tijvLZll1
 Y/XrMyuY6FMd9RZICGqBQ+jzZDio+Bg==
X-Received: by 2002:a53:ef05:0:b0:667:bae0:e55e with SMTP id
 956f58d0204a3-66ce4a10079mr5795417d50.4.1787569143739; Mon, 24 Aug 2026
 03:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260707110300.1918153-1-armbru@redhat.com>
 <20260707110300.1918153-36-armbru@redhat.com>
 <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
 <87o6erssjf.fsf@pond.sub.org>
In-Reply-To: <87o6erssjf.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 11:58:52 +0100
X-Gm-Features: AcwNN1V27i3RbIbv-0dp1qfm4vLjUbM980gGvewuM3PuDu2DdC9Hs4r0jdugDuo
Message-ID: <CAFEAcA-bN5aRaZPsiZoT_zpoZkiTgUupGnCn4OaWNG_rMRw7=g@mail.gmail.com>
Subject: Re: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Krempa <pkrempa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 24 Aug 2026 at 11:48, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Can we be more precise in deprecation messages of this kind, please?
> > This warning is not enough for the user to be able to figure out how
> > to change their existing command line.
> >
> > I had to look into deprecated.rst, check the git history to see which
> > commit added the deprecation, then find out how this commit was adjusting
> > the examples in the tree.
> >
> > Notably, "-object monitor-hmp" appears to require an "id=" despite
> > nothing actually caring what that ID is,
>
> Yes, -object requires @id regardless of object type.  It calls
> object_new_with_props_from_qdict() via user_creatable_add_qapi().
> Together, they create the object at /objects/ID.

Yes, but usually you need the ID because it's going to plug into
some other option somewhere else; other options like -drive
can take an id=, but don't insist on it if you don't need it, and
some options like chardev are only useful if you connect them to
something else by using the ID elsewhere in the command line, so
whether they require id= or not never comes up. So the idea of an
option requiring an ID even though it is never referenced anywhere
else may well be new to the user.

Mostly I mention it because otherwise I think the typical user is
going to do what I did, i.e. replace "-mon" with "-object monitor-hmp"
and then immediately get a different error from QEMU. The warning
being more precise could save them a step.

> >                                          and the warning message
> > doesn't say how to determine whether your existing -mon option
> > should be changed to monitor-hmp or monitor-qmp. The deprecated.rst
> > docs do say that part, but don't mention the ID bit.
>
> Fair points.
>
> Is this just "do better in the future", or are you also asking for a
> patch to improve this warning?

Both, preferably :-)

There's an argument that the deprecation warning could look at the
option the user actually provided and emit the exact right new
option to use instead. But I don't think that's something we've
ever done before for deprecations.

-- PMM

