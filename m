Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE4CCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 16:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2AtC-0000PU-J5; Fri, 26 Sep 2025 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2Ase-0008UP-O0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:01:10 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2Arp-0004KC-Qj
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:01:07 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-635fde9cd06so1768208d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758902404; x=1759507204; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sh9sNzSFrymkVeHjuXLGVzADyq3aZtwCMrZALSJegGc=;
 b=MeOKYIMamHZEuVD4O5mV2lKUZyn5vGstmirBxbW6qBhnTFuNyFy29t9W4EiOwOn7hF
 6+qREno9fLU7Ic9xyNAVoXPm99cA/vLL/WaeKk+9o10NC0QsN5KCC97mCSE8QznlfTTi
 oyc2pjIw68RNOk1fbd2ZFylfR/TfKCMaZrOO2PrnyxdKxpOWQ0tb4nJ4JEd5pa8bO3wx
 FsCG+6w08OKVBy6ai85w+9mluXLL5NZ5xI3nkYHzxC9If+tPgimKksW1OiQFpa5bGCVF
 ZYLSf0MJyVk1C4qtR3bo/oz+cvfF1pgO08l+9aXc4gfmLW8rFKs+2XSxgFlJx1Gkcohy
 qGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902404; x=1759507204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sh9sNzSFrymkVeHjuXLGVzADyq3aZtwCMrZALSJegGc=;
 b=AMLaPopVYUJJ1jH6UfRsqXQu7CTRGDvzbimZ7gb+D72ZTu3Y2mifUXx0gI32lhW6Jz
 +rCkedBWKevCn38oV6h5TSB2F3qrAptnYJ3sAyT9PrPDA+G24ETYSIOwaFx2lR0RVaJc
 IZFuCvpg0HdPBMLcWopLMqtPRWT1DiYwIbrfWY5qGTwL+AHoBOHJk2raFas26yLTuZfU
 7STB0ZujPva9v9Kmp1IVy8aPSdQFhAktS/UR+JP0vCDDHbAx8+vCc96fWtbr0g4sLyMz
 GoRet+qW3NwdEKDFvjNxomFOTrowtRDKQHTtyPY+qViiXesVx6q7vE6nT8elvXjKM3l0
 LRuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyFV4jDQf53UbJUcz3YUj+yVFZ5NF+l14vaaxxgavq7MK/SFxdPPmjGetymr3JsSNp/25kqzepAYrE@nongnu.org
X-Gm-Message-State: AOJu0YyBb+2bSoLkDwDaPZJG17RVzM3o+JZRPo73rNQe7PezSpPVYKIE
 +3a8C0g1Pbo4GDRPytfajXoKhOnnNt9NSJgZ1ZwGK65d+4kKHs9rmYAV1JhnFkL8GFq5TQeF9Jh
 kfhqK9FzuZ7vjxATd+/tNpxWNPPK0hrB3JX4ZNyEaRA==
X-Gm-Gg: ASbGncudjmwc6xfI4kjdnRM0A0g7Wo0GR8zdFUb779hGEC2ZK353LECCc2fdHptVi7d
 bTemS4AunPr2eAhSva9thLNcYwrVYPefdseAhjrOOeHeS1M9mSWvZv1BZNdgdy7dizfipk4WFCk
 5fRFdIYZCbFA0vEKRvnhSsTkOjlOvhSjuIR+8YQ0HoPRLbRhqpTW6MocnEIBip3OOEW17EfdDvA
 RbDzZEKSlJ+UfVghSw=
X-Google-Smtp-Source: AGHT+IEbyNIV/1QTmtG/utR3TCH8lGckCdynJE2NJ3FqPZUA+WZc5785CctUKxukTq/nzcJdVVLDW97v/ZDwMYLIwoE=
X-Received: by 2002:a53:8613:0:b0:636:3ff4:615d with SMTP id
 956f58d0204a3-6363ff4626emr5197963d50.52.1758902404181; Fri, 26 Sep 2025
 09:00:04 -0700 (PDT)
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
Date: Fri, 26 Sep 2025 16:59:51 +0100
X-Gm-Features: AS18NWBh1z3KAmJxBP51PWhK5xIq4kUU-EkE-0rNo11LolVrpQTXJbEbPxEkCwU
Message-ID: <CAFEAcA8x0mgrxepuKcPwLWfQF8H=giWH03+2sF9yzZ_5nk_dmw@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

The cpu_address_space_destroy() function is broken and never
called by anything. It needs rewriting to instead of trying
to destroy cpu_as, just destroy every AS the CPU has at once.
(I have some code for this.)

I'm trying to repro the setup I had last year, but I can't
figure out a setup where I can get hot-unplug to work:
the "device-del" command documented in system/cpu-hotplug.html
always fails with:

"desc": "acpi: device unplug request for not supported device type:
IvyBridge-IBRS-x86_64-cpu"

Do you know how to get this working?

thanks
-- PMM

