Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C1CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4od-0003AJ-Su; Mon, 01 Sep 2025 09:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4oU-00038I-KE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:43:14 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4oS-0003be-Ti
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:43:14 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-723960ded6bso4796847b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756734191; x=1757338991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/7toJz2fvSWClyFULcOITG2IaohIQQNIefe2aHwNIg=;
 b=V3PEup+V0d+oXl1VcUgbWwHXbJmboj4fP6Jy5eFLEVkKs7UJ7yYd/Q7ujFbjtz1xJC
 oD2GuLot8fGmH4SDl0x6I8S8kBEh+BgAMIITsvdfMML+SLrfcu/huZFs763zTDu9mcbm
 x/0lbgOCMmZerIBJkM0eOH1GvDkDnOJuyPE0atsB+aRoRmI5a+UuBRdtOwdySjT8eWoK
 GBj8GAOAIAqmi+VKQuk2HPBrIHUhDoQOPeMdTQ/1GjfpKvg9EO9omS92w8icziQoEKAx
 Lo1Y/hPY4EMiX4NHm1uFcgXaPLjimj0jdx11OgaHRicHgnY4K2Hp2d86dhfKbt4xjXUQ
 740A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756734191; x=1757338991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/7toJz2fvSWClyFULcOITG2IaohIQQNIefe2aHwNIg=;
 b=hVRNVtEqPlmGKkc0WBvkicyPYJ5Zcj7wFIopT4Qf3PbIBsg4r8uDNUQ3UsUNd1OTkr
 DTiK5uvTSzdmAYABJ1CLM8LHlalhy8QsokLPb+8uQ9ZlNkq1KkbqRJpD15Rt43uvMd3R
 0enZZFNHqFfm/KNj3mWclABqtOlkneJkhKMuO8VCBHfTKQ7wV8HbVmA2rQLWK/doB6vr
 1FqtQDP+mcyyps9m5t4fap5zd4JALOI4Z0OqtlCy+rRZLnR0c4LPAdAzshdUE/OKKjO4
 jL4Y5YJBWUknqcNL5VDaxH8D8QjdINesit7cCx4UJWonta1tFhW1zTVSAsOL2BGhSdn+
 YxBw==
X-Gm-Message-State: AOJu0YwTH9ngfGz8AwtqUdnjBTl3HRDJiytCfXHIzK44qzuxl2nzgqb+
 Jmze4jn4yf3pm+AARFlq3uhXMyiveydfhoj1dX1zOHU+iCQxuJNP3u9qaQAdXoy0AS1+BxDy2a1
 VIs9PAEdTW++Sq85ZH7cQwd1XMjkONKv8ITkr8xip0Q==
X-Gm-Gg: ASbGncvw0b0GtCQEWyNY/XYJ5yOylorq9jm5QcWllEERMwncNxu1VZ1OAmOHBl6xHGS
 jL8ImK5pGNGL/o4YzYVU0foMPEeITGvCqATOdMkiZYF8YvmaIrmv9xIxDG19sHB7tpv39mip9ol
 EUi+L2Y7UCzcmI3tbEJurWa86lxB+PlAIWNghJU3yK27FZektABybiF6dKi8pMmXcjFVhIHuL7R
 br5
X-Google-Smtp-Source: AGHT+IFjVooSbAykm9jHHw+bspyTO4P3It8/dshZN0N76zJBDHSWPjODQWixMaM6yjCxBCRWSCOcKyjFt2sQYMXehUI=
X-Received: by 2002:a05:690c:3606:b0:721:248b:97a4 with SMTP id
 00721157ae682-72276509f55mr94607597b3.37.1756734185970; Mon, 01 Sep 2025
 06:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA89xRp51q2T4M3R=pOuHcGE9zJCGDpbXOz4cBhxrcU00Q@mail.gmail.com>
 <a46467e0-4984-489a-945a-b1049d1e31c2@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a46467e0-4984-489a-945a-b1049d1e31c2@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 14:42:54 +0100
X-Gm-Features: Ac12FXzy3klEsbTqz2NNw3AKKoWTySILHN2ccypf-bW5PmsdPfIhzH9rtPO4fxc
Message-ID: <CAFEAcA9mupwKojh56=SSfp5805-idVhxtQBaRdHnOziJmmL5nw@mail.gmail.com>
Subject: Re: [PATCH 00/16] memory: Stop piggybacking on memory region owners
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 1 Sept 2025 at 14:28, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> This approach is clearly not working. The problem here is that there are
> devices that never get realized (so never get unrealized either).

Yes, the "instance_init -> instance_finalize" lifecycle path
is valid: it gets used when we want to introspect a device
(e.g. find out what properties it has). device-introspect-test
does this for every device compiled into QEMU.

The instance_init -> realize -> unrealize -> instance_finalize path
on the other hand only really needs to work for pluggable devices,
because only those will get unrealized. So we have a lot of
devices where if we ever exercised this path we'd find we had
memory leaks or other bugs. (Many devices for SoC objects and
devices only used in SoC objects don't implement unrealize at all.)

> I'm thinking of a solution that fixes all possible circular references
> originated from owners without breaking anything else, but I don't have
> one for now.

I think overall I like Peter Xu's patch, with the underlying
model being "MemoryRegions are not reference counted objects
that should be considered to have a separate existence from
the device that backs them; unless they're the 'lives forever,
no owner' kind then what you want is to hold a reference to
the owning device".

-- PMM

