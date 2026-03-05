Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDAAF30923
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy52v-0005iW-Q9; Thu, 05 Mar 2026 04:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy52u-0005iD-DK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:31:04 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy52s-0003Lv-SG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:31:04 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-794719afcd4so72704097b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 01:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772703061; cv=none;
 d=google.com; s=arc-20240605;
 b=lFnaKsAu4jJpJy5SZrDpKT7vBjR0q+Llb/HSxpVNgG/xIuUKBRiicGb2PPSMfQWvhY
 hOyqGdjgZpx8Zqg0oqK7NoFxzO8BaUSDWaYqHHE+J3c8U/M5JifxpHTnL2Y4m5Tc/Yva
 7U03s4c646qTmzGhWi+NPBaBiREiCOQ/9D1Vek6Jv1tqDdgmlklFM2seSTZtVs6253ek
 Xl28FGMEOL2IP9r31QiOATyF1z+vVqpX0IEnWA0OTKMivMKvDz3INwks68Hyc0BWJtmo
 UUtLB4rOs1zGbBoegUQ5pHWwt2zzFKmpuLs8HKUntJ6Za1zDvE02+omi5v8GlJ8F1rO/
 pNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tDoGGukLguIzkJFYbeEw6RZie/P8y8tXXjOxYEXSARw=;
 fh=bToQEiadr4n2aJqwLb/EO22OZxugmNFXs49jDw4JRWc=;
 b=k3Hav+0HeUYalXXEhA1tWXTsK4IDjftdNANJkKv2opWjb9uXLBHOUvKd8RfrKjC8kp
 T2qeWpJSmkGZnodrlR4V2NXSRt5EckVy6A4g1KpcRTOOsAWxmQCJ+/jSSPxGOnz95Z1J
 D6EindsCeAxTLM/HzOXgN+hH0szVVvytIZwrg8Xp6SE3EqfVxqIpkKKDx7L3d+Md+TSD
 F4MVAVhNmTYEnMwCpyPqCDajC/4uedol+z80PjyU3ikjWCk8IiesF/7NZj1ATEQYnJjX
 vp5gvGEzdHPoDE1e1ih5oUbjjEXzjj3oSMmH/RqH7iA7cS+D9z4Rbvqt5TFzhhlQmLoI
 m2Eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772703061; x=1773307861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tDoGGukLguIzkJFYbeEw6RZie/P8y8tXXjOxYEXSARw=;
 b=Pbs9gEj5RVpYSXbvWQvAiNEiqC36kjZBMaiVGTLF1dfbZ6m0iHGkXQkeDupy5CWJp8
 +HYJo9IqB8+SPmjvB8Fgmr7Fk9GF1q56j3RHlJXoKPpaUDsAkXyOTcspMF3vOalGoeHV
 JHgcjONNTBgRnmi64SYmpqXk8flG4mlKtypS99dfvEeQz/5hjqMiBNpWbq23I01IDLSG
 qafuW85LPzCIfn/MPI/uGYe6FBKdrFdzde830yXKHqrAPxlFyOVw2cFkem/VxDvBHgrU
 pq3qwoiJmwGl15msg1SdemTHh6aPjpwjEBP5ap4wqMnE5zLxvasEIuoaK5AzdLSdcsVo
 VyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772703061; x=1773307861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDoGGukLguIzkJFYbeEw6RZie/P8y8tXXjOxYEXSARw=;
 b=i0Ggnw5TxUXxLE9H3OzsQmzstupXjycVqQj0twiA/DtfWS9mX0D5n6WilYW26SbHPW
 cBeMW6kdx/fximUawK7kiDoJBOsfAS6cpd0IzHbdr0jiFcOqliIYMUGUZtjvmmayt8JG
 k3xFB8N0Z+DBsx7oAWahbP8mmc4aIqf14yUj7hT2w/NIeekHOegAjFyLfss8GcoBxXjX
 PxE9vfetcKzf2rhxui6Jp4FDQkgVD1WfZ3SMri3GQr7eOgKPD+QL9dDIkeMrnHzF96ED
 JclHt+/O++dgpWC9OvxagGxm9uwQAu5qoNtSh120oXSOwquwoU9+Uuse4XEknIh6TxtH
 dSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+Av8kldbBTp8UzRv6yO7FL0khpVbcazJiaJTSa3ckrYeUQUIO8J9+h6mI0qCTq/uBdlvi2iBnz0sJ@nongnu.org
X-Gm-Message-State: AOJu0Yx1shKQoYXhNMF0S3veCCr0Z+rcXm5AB+/7wEUp+i401UfnvlUG
 8Om2aDjH/BAgk48XBb96yxLUJ1N85lBnuU/szqH6cfM6DGY0g3LfiO7ytfrcBFOHyTILIXNzeC3
 gIr7bDSuE3kBPdZrBx5L1bOcfNxwQJ+RcdyyGK9AqWw==
X-Gm-Gg: ATEYQzwvcx8qzbHAXNDffp6A378W8RNYnApqbvhSRIvcPkqUkngo6z6wdUGMmZxg+I0
 Dy5nl7kPBFrrNPQ1or5al9kr7U7R01Y0ggUxYCZ+QCh/ox6yRGqDZo8Ilk0rCnMxXek706CN7gp
 wi0UiaULtlQH8+xkWFVtxBtjXmkfbMTmmzhZGCA3m/xIIg3d5JE57cs1r/9e354QYZtKNIJDBlI
 cRyxHUOvjWyNfH5y/VBcOJD5Yn9pKyGgHaalT1qd9kJcsASeaNsM0VsLG6kjSafgrfDtTiPkoJy
 qaK2JLNpp51jCz2J2Rq1ubT0mSE9rvMGgCZtXwsUKz2TSGBIpIBph234UtT0bq/kscw=
X-Received: by 2002:a05:690c:670a:b0:798:58be:324d with SMTP id
 00721157ae682-798c6d042ddmr39867387b3.55.1772703061234; Thu, 05 Mar 2026
 01:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-13-shentey@gmail.com>
 <87ikbbixy5.fsf_-_@pond.sub.org>
 <CAFEAcA_WYkAYccog-BiA6MJAvoFVwa6niKvFZ7UpLjzkRyd6aA@mail.gmail.com>
 <87fr6eocfc.fsf@pond.sub.org>
In-Reply-To: <87fr6eocfc.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 09:30:49 +0000
X-Gm-Features: AaiRm52bSeGJD1lQtiMyl4LniLGXSmafvCc640lpMO97fckjyIgvBsHKps7UTAg
Message-ID: <CAFEAcA8CTLsKxJ8iza9T3bSafdgaM0dag2=KXqWLdMiXAHiGGQ@mail.gmail.com>
Subject: Re: QOM parent type "sys-bus-device" vs. "device"
To: Markus Armbruster <armbru@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 5 Mar 2026 at 09:25, Markus Armbruster <armbru@redhat.com> wrote:
> > Disentangling reset is extremely painful -- I don't even know
> > what it ought to be doing. Maybe propagating along the QOM tree?
>
> I think this would make more sense.  Unlike the qtree, the QOM
> composition tree contains all devices, and reflects the actual
> composition.  It's certainly closer to the real reset tree than the
> qtree is.  Is it close enough?  I don't know.  If yes, there's our reset
> tree.  If no, I guess we could still use it as a base, with manually
> corrected reset lines where the QOM composition tree is off.

Yes. We really don't want to add more boilerplate requirements
to how you write "container" type devices like SoC objects.
It's already bad enough that you have to have an instance_init
that manually calls instance_init on all your subcomponents,
and a realize that calls realize on all of them. If we add
a requirement that you need to have reset methods for 3 phases
that call reset on all your subcomponents, people are going to
forget. We need the default to be "do the thing that's right
almost every time", not "do the thing that's wrong".

(And then of course there is the "how do we get there from
here?" question :-))

thanks
-- PMM

