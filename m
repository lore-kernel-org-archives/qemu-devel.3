Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136F7CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 12:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3DGG-00085J-Ia; Mon, 29 Sep 2025 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3DGC-000855-27
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 08:45:45 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3DFv-0005vI-KS
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 08:45:43 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-633b6595287so3260139d50.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759149917; x=1759754717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jyP9+jtL06/tm73mNn1RnvPClvFnZ13PspnRp1VXLUM=;
 b=y6JjIlUpKyHdGMwsnQ6OajZxKdTYVdKLEuAFSpGSDDDTEmxAEs/RW+kBlTqWakakZw
 rVLY9yjJiJ8+GtMnqXcdFIuFFgVLzJgShKN7Njq+040e2KZV+GZBy1ImPXOeSt8+mhb+
 dNpM9ebco6gdT5IPyxZN6usyN0k8lYZ3LC/Vi0k7063IU35olj4JxrVdvEnaeJnpAiGu
 1bC269csndAI08c4c381+gwFxiG8w3BhXJLMkBXpu94zhDsdaC31J62bzII+NsCWQwD1
 qouM/LUzvy0C6WO38/pMaJBUWVhWv8vjIuhCX76q93A1UJhA57KdrQWhiN2lPC5gB+os
 p/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759149917; x=1759754717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jyP9+jtL06/tm73mNn1RnvPClvFnZ13PspnRp1VXLUM=;
 b=JceqFphu545vdgRgjeRkgh57qQORPsmwyWvZ9KLwtYzb2awM1C8cGDFtRS8VLeqzG3
 zSCiOyR/iIbaPkwKGMwbRjyoZTD/1VMLP3npTSnTxpotWYHcX0AFS8uziM7nG8TlrScM
 t2LpZIqJmN3c10C0g4RB08BFCy8gAFxx7WR4FMBujU4EheCTJPtSGWuz3AGkMOQ7dnRc
 ZlBeo8UEkmhIOunJ5Pxkj2FiQYgM34ZYEco2vIpuZarYbziJDIqLpDoz33IP+PP6Ai1x
 gsXs1g7e7xMTt9UTfjv5n385/uQedHnMUBnYMZfGUWdtP4PxM9Yc3+v816BPcTu90ioX
 2ncQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkGdgKDKg8h4bi+Qj/bNra8iAWP11chkdrOj9ax2DjgMsS54QRoSodzA2zs6Wwk2nlmpUUBB55lEFv@nongnu.org
X-Gm-Message-State: AOJu0Yxdq0/7BmPsgnTiMSJocY9Cgd1uWuVg9FbNqvW+RptY8GSiVwxz
 qRaG2vrpz1DbM3ygpk2URNbPQ7LINgO1tWkiLyZfBCS+NanigrxypvILHobAwUK5vLhCJOp8hJh
 MPSN6+a7CuhZso9fhBEjL/SRJv4OLtfux6WwWgxi7Qg==
X-Gm-Gg: ASbGncuB4c2vIXCXCeBa8Mua2hUh6OV2MFVMTITHjiBnre1wY91WzKYa4LTQSdnyVqn
 DrY6CHVpvBbwdv4TkZZGByJPOtfvyKBbMA270suutzYkWNPP86hHGYPjA7cq+rKNUDrZkI6Cv1R
 8n3TnX1pYb5jKPrvtbdEJarAZ63OQ/8/iq842ndghFEHQ9Io4AUvU4NoaBRT6+Qe0XSjYGFpNuN
 apQBjB1
X-Google-Smtp-Source: AGHT+IHK+EM3ua48yHYal71qUevjdZrS3If07P3raJiWSCQ8lE4o3xnPVaUBMOXGATWmetiIfjOUcqfxqDwq6gAXI3Q=
X-Received: by 2002:a05:690e:1505:b0:62d:cb07:f098 with SMTP id
 956f58d0204a3-6361a6d2effmr19321696d50.18.1759149917019; Mon, 29 Sep 2025
 05:45:17 -0700 (PDT)
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
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
 <aNauXSMiP0LUWQ5J@x1.local>
In-Reply-To: <aNauXSMiP0LUWQ5J@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Sep 2025 13:45:05 +0100
X-Gm-Features: AS18NWB7rAkpuMAb93lMBXEcoo15Q1s543eIHGHPswpxfNn7P9xRGtaIfstfsUw
Message-ID: <CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 26 Sept 2025 at 16:16, Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 26, 2025 at 10:09:29AM +0100, Peter Maydell wrote:
> > On Thu, 25 Sept 2025 at 21:06, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 10:03:45AM +0100, Peter Maydell wrote:
> > > > On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> > > > > Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> > > > > I didn't really see when the address space was destroyed, maybe there's a
> > > > > bug somewhere; I put that info into appendix at the end.
> > > >
> > > > This is https://gitlab.com/qemu-project/qemu/-/issues/2517
> > > >
> > > > I got blocked on that because I ran into a weird "I have some
> > > > memory that needs to be freed by the RCU callback, but only
> > > > after the callback has freed some other RCU stuff". I see
> > > > Paolo made a reply on that bug -- I would need to get back
> > > > to it and reproduce whatever it was I was doing.
> > >
> > > Thanks for the link, right that looks exactly like what I hit.
> > >
> > > I am curious if FIFO is guaranteed for RCU in general, or it is an impl
> > > detail only specific to QEMU.
> > >
> > > The other thing is I feel like it should be OK to reorder callbacks, if all
> > > the call_rcu() users can make sure the rcu-freed object is completely
> > > detached from the rest world, e.g. resetting all relevant pointers to NULL.
> > > With that, it seems the order won't matter too, because nobody will be able
> > > to reference the internal object anyway, so the two objects (after reseting
> > > all referers to NULL pointer of the inner object) are completely standalone.
> >
> > The specific ordering problem for cpu_address_space is that
> > there's a g_new allocated array of memory which contains
> > the AddressSpace objects (not pointers to them). The ASes need
> > to be RCU-deallocated first so they can clean up their internal
> > data structures; only once that has happened can we free the
> > memory that holds the AddressSpace structs themselves.
>
> If it's about cpu_address_space_destroy(), then IIUC it can also be done by
> providing a destroy_free() function so that instead of trying to serialize
> two rcu callbacks, we could easily serialize the operations in one
> callback.  One sample patch attached to avoid relying on order of rcu
> enqueue.

I figured out what my problem was here: like the existing
cpu_address_space_destroy(), it wants to first destroy the AS
and then free the memory the AS is using. So it does the
obvious thing:
    address_space_destroy(cpuas->as);
    g_free_rcu(cpuas->as, rcu);

This doesn't work, because address_space_destroy() sets
up an RCU callback using the 'rcu' node in the AddressSpace
struct. But then g_free_rcu() tries to do exactly the same
thing and overwrites the info in the 'rcu' node: so we never
call the do_address_space_destroy() hook.

(1) Is there some way we can make this "tried to use the RCU
node twice" assert?

(2) I think the simplest fix here is something like the
patch you propose that does the "destroy + free" in one
RCU callback.

thanks
-- PMM

