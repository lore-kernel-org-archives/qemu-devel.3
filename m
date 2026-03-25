Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3485A109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RKG-0004Hu-Bs; Wed, 25 Mar 2026 12:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RKE-0004Hf-QM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:43:22 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RKD-0004HB-D0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:43:22 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-649278a69c5so64462d50.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774457000; cv=none;
 d=google.com; s=arc-20240605;
 b=l3G2Pka2I+1ONj1o+RIri/w190SpRe+QZoRJ/Qz843kTlNLL0rlE3gLQiArF149y6s
 ao6ZjOlfgKR3mToDjZPlTkSwPqou97QKaht1zsYek1EHMThBVJa/Ly2VwpB/S/XmSVYf
 JmgotVM9GCqytOHvnDmS5LosbEnBaUTWnQ2tvUHpiBtZ5I5epKqbM4NgWf6+FldufhF6
 3IuzLHboHnKLR2ChN1pue2FW3gi+oaAIz9fH2/1dVb9ysl81/hXmqO9EgwLMkc0ivu0o
 gS8QHTkb8kBQenEOdqxBh+DEeNxVldtdWenhI3owuJFxWSDMK8W70q82YGqjl63ze4Pr
 EqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0bKgSG7hFOw6SE9DlRcmlaBQSYt+zNrknLETjspTdTo=;
 fh=wTscW5iO7m35uSTIYQ3pZxPOxQqDb9ynmDWdK3BLrZs=;
 b=AblCGbodh6ilIvMbZbLoiNBCj4wDeXI2RQg7LdzC+UwGI3UOpibQbYH2Ar3gy/dIpS
 6LyIIDRmMBpjQZhACsE1XwC0YW+jYxQmNrG7cLc6r7z8Z7dqviFUUjxuYRvbV5IVSq2c
 kLDp4q62z3G8xwoiRExILaLoypYRnMumqYZmt5mQYktUYSk5YODTLnFFKsZtGCAW1D64
 QStTJYggF+pjlyaiGnQV0lRHtUp/uXgDKZClN3htuvhYpzDzDhwMt3NM0ugDXVoIG3Oy
 fCCxWk29kM0qLrDPDCZFdbsvr5jnsj8Mvg6xaq3QKqkUJIWCb/xUeL4LdOdutpB/GOq/
 emmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774457000; x=1775061800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bKgSG7hFOw6SE9DlRcmlaBQSYt+zNrknLETjspTdTo=;
 b=jGwxy2Gtnr2XyvrxZNwrHfUvQvGBPy5CTkLoUGXPGlIvwBZkpMhaWOvOm4BUViUeSo
 znyT7sI46nXBwLb13ixvth0cIruPDu0o5L9aeV9ECBQSAKd0gy6FwlSOW2g2OQse382M
 +ErCBZi3iJ33YpAQFdofOvMQ4ssWvoPZbDBknBJzfMSd9Ye2dq0ffLldCsU0BzcoMyJ9
 EnTD4hiHx4HvfM+s6mrQ6PxOUU6CTHRLpg6ytohURxmLjb91VCdEiqO3FiwjP8om0XMr
 +Ge8Yt5875ElAzEeuJC47zH9UoLQzLrGf8+VwgEG2caXbutBH3mWls0TGIBa2JMHzScT
 0VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457000; x=1775061800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0bKgSG7hFOw6SE9DlRcmlaBQSYt+zNrknLETjspTdTo=;
 b=QpVD02bIgYK8j0jHh/feqQUHBG+JdegABzA5XvliRZD+OEnS8hAkVidV+s2yMBTz14
 YlGrv3JzzVRq4GMc6pIvbzZQTzXom+crCivCR0SAtxvCzHtql9KF1Sm7WfoglVnJzyYV
 7yE8QG4BDNzCP9tf6fKX9As37DDFLEDMslQZyVlLKHQwHC03CUWrKiYnwax2dawXq9uo
 h+9jDt42tBSQ1aUBShCpt1B4OO+cn3yoYvX1KXZ7AIcu2R4hmZ9APimWhlYSsCbngsIg
 zL5madhXMhj481UVVX8fq+2zGWZtxKfR7VFxKJYFroQPJS1t4jWCEVtZbTtQUppLIoIm
 zwiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBaKEN6Li6r+pfz6ZoWOCKYTiUoauJt6zKyOGDqZsKWLwogRNktvDPUU5apv2D3MoG+EZ1ljBmupka@nongnu.org
X-Gm-Message-State: AOJu0Ywh7xX1nMGOxNJpTFELBI1ScsYh2+eIztBN/Al6k0SVzjNjnnHo
 Jl60QLYROfNgWg180/dAGzswFl5v+p9bHuL+DgGK4vCXTwPcNP6GE3GIQypNhhKQhLP5+ahNoP6
 ggQuyqyJLCSXlO2yVti9LDMBNnC8CzZs0dtztSlmE1g==
X-Gm-Gg: ATEYQzyp7kAnYNCC5KLPFeRapmDGaTpLnj1Zlr7ybUlAaOxq7jsfSxX4qQ95p6lqkcg
 WVwlAER2+nsBlB0U/kfZX2EY02zGQQgHl/XAviT7kNrcQf4qnbkOfVSB3R+na1y48d0gNA/tw7Q
 VZ6Ljl9gy0+Ou5XGLXgY+EQ1Xoe0YG8RDlVkgpuwwuVkbqMaEcrY0YVjFzQmhVj4kSU+8mAgi+d
 8bTvKp3sT9mM3zk6T52EOuwZByJiZ+8pwr2qBEShymVV4CyaSBUFlbd+blMTExAY8LgSqD/NDlY
 EUXxFenzTHw2ounXh6gwtHuwBxLgNBngOvfom2qdveJSlO1Df2czafdqmA/pLRYYSsM=
X-Received: by 2002:a05:690e:4004:b0:64e:b826:de08 with SMTP id
 956f58d0204a3-64ee606d9c2mr3973014d50.11.1774456999645; Wed, 25 Mar 2026
 09:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
 <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
 <878qbg410i.fsf@draig.linaro.org>
 <f81e71f3-fe15-459a-9c27-2aea1592d155@linaro.org>
In-Reply-To: <f81e71f3-fe15-459a-9c27-2aea1592d155@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 16:43:08 +0000
X-Gm-Features: AQROBzDLIP9iP_cqneYvqQdZXKkV8VJ4JKZxpSWhv6kj6UcpyB0YzmS7GfEZwUY
Message-ID: <CAFEAcA_HLgphjGev_+HG_1KQChEZJKk3+9qP7_q79doG1EWD3Q@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 25 Mar 2026 at 15:17, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/25/26 4:11 AM, Alex Benn=C3=A9e wrote:
> > The aim have having these more complete plugins in the source tree was
> > to ensure they where updated as APIs change as well as provide useful
> > tools compared to the more toy like implementations we use for
> > check-tcg.
> >
> > I'm not sure about having them directly in the plugins folder as their
> > implementation is meant to be separated from the core QEMU code itself.
> > Maybe tools/plugins?
>
> Fine for me.
> Peter, is that ok for you too?

It doesn't really fit with "tools/ is where we put the things
which --enable-tools causes us to build and which we document
in docs/tools". The plugins are neither of those. That's why
I thought some subdirectory of plugins/ would fit better.

-- PMM

