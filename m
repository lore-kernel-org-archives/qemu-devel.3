Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E463CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24Sd-0003vv-Bo; Fri, 26 Sep 2025 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v24Sa-0003uj-6V
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:09:48 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v24SX-00040l-Lb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:09:47 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-635401a8f5aso832583d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758877781; x=1759482581; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3+2c6cutFQ4bbOziDpxIVeZ33Ufypj7cfge+dAVOUTQ=;
 b=B4DQkCXJzB+9g1EAVtMZdIOLScIXT6jldHMV1UqfdJZ+C1QN6AehfABXvufDlaEbFQ
 ke98/zbEZJzanrwR6nn6ZGCCd8iX+ZYNDAu4pkY0O8D4m0fZvvf+qE++JrRb5C+5YMHJ
 czp1GthShoiCqvPtL0ewimeLOcurSFOSPfucyb0ufvRn1aJUt1Hv8IyeH8wT66hcXvnR
 9k43plht5E3ny2BRxc6gP6SzNHB/HQ+D7JSSGcxf3HDuEghQtE5+kNWzoc6Dp3pi+KRa
 5cBTDesvNFhN0RGnNBxyZmfyiOJco91p8lmdBVbiM/aVh1wLTlm7fK0mVxhAkOxUCday
 BezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758877781; x=1759482581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+2c6cutFQ4bbOziDpxIVeZ33Ufypj7cfge+dAVOUTQ=;
 b=clXuD2aynxic6gR4jzCH6bWNn42GF73NGs5SV9Xl9EifLI3hSoX9h9zBeXINLNwxG+
 wKvbZJ8h91M2WZ3QvlsmkqTdAjAAXdHKn8nqKIpoT9chbsevLWdtOb5Sdd7JAT6sWVtu
 tfO4yU6txMzfqrtsZ6+R/NWoOclov5ZH0bDP41Zrg211Ud/uleDHrH2YCkMDyky0KtpZ
 6D157XpXMd8KkGUR/dXUGF3dFu81fGVj95jgfiaqqgI5qhnzTb/+q2rT8VdmAUNyhlOQ
 u6gKHGUxrySA/xfC11OFWqUGYCZfgkKqTqIV/1QPGxLerCG3PtncLh47/I8Z7Fn2S/gZ
 FgJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWnK5ZIGTwKRiO/yN0qIMOnv/IEpAPKNIkh7Q5UN1WYTAkYw/ZVYkxHE2pCp4OPX+Jtp06snBW69sL@nongnu.org
X-Gm-Message-State: AOJu0YyvVyus0VTddAHhcYM6ziPSlfuY1jAOj2gVjbjqznfSiIVWDSqA
 yQb02VT4hjaxNIX8yBX7C0blYhfZ/KnofQbwUul09Ummxyv2HBjHzcnq6tkCcPQmBBJpUAhVQwm
 HSpi95h4HziS6GK/mCdUqNLc9dXDc6wC05nzZ9caO9Q==
X-Gm-Gg: ASbGnctp72kqZQw2J7Iw4x5zARW7QJIUj3gbrJuYiH1PvRfdS2UDn/C6pPSM2fXqPIG
 Y9J4jGtqzLSk01FpBtUAtWdqTWUzejXWqbmiShpWiN5QcqhLBVFWx514oqiPnGHXjbuv53wi8v8
 W8Ti27KXjecJJtezE++eCfYAyw6fRRWqN0IOkEu7RoFc1dSezmH+crHNKOLJMHTDfUtcNUiLT1s
 fmGRgYJ
X-Google-Smtp-Source: AGHT+IGUheo9Jik8sQlW28AcBMo3lL956vqQuCJQvR797srobEqpOiYPX8jvn63ZQigolUU3fbBHTi7AcjYyDGZhdrQ=
X-Received: by 2002:a05:690e:1583:10b0:636:bd92:b253 with SMTP id
 956f58d0204a3-636bd92b7b2mr3734255d50.53.1758877780805; Fri, 26 Sep 2025
 02:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
In-Reply-To: <aNWgnBV-9p6UnsYT@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 10:09:29 +0100
X-Gm-Features: AS18NWDexld_w6wrQ_l7NaC39n_cBt4EpMmAYiT2LuhkJ-TE3cgjZkyJGYSwDJ8
Message-ID: <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 25 Sept 2025 at 21:06, Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 25, 2025 at 10:03:45AM +0100, Peter Maydell wrote:
> > On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> > > Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> > > I didn't really see when the address space was destroyed, maybe there's a
> > > bug somewhere; I put that info into appendix at the end.
> >
> > This is https://gitlab.com/qemu-project/qemu/-/issues/2517
> >
> > I got blocked on that because I ran into a weird "I have some
> > memory that needs to be freed by the RCU callback, but only
> > after the callback has freed some other RCU stuff". I see
> > Paolo made a reply on that bug -- I would need to get back
> > to it and reproduce whatever it was I was doing.
>
> Thanks for the link, right that looks exactly like what I hit.
>
> I am curious if FIFO is guaranteed for RCU in general, or it is an impl
> detail only specific to QEMU.
>
> The other thing is I feel like it should be OK to reorder callbacks, if all
> the call_rcu() users can make sure the rcu-freed object is completely
> detached from the rest world, e.g. resetting all relevant pointers to NULL.
> With that, it seems the order won't matter too, because nobody will be able
> to reference the internal object anyway, so the two objects (after reseting
> all referers to NULL pointer of the inner object) are completely standalone.

The specific ordering problem for cpu_address_space is that
there's a g_new allocated array of memory which contains
the AddressSpace objects (not pointers to them). The ASes need
to be RCU-deallocated first so they can clean up their internal
data structures; only once that has happened can we free the
memory that holds the AddressSpace structs themselves.

-- PMM

