Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67276CEF174
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syALA-0002Rs-Cg; Tue, 08 Oct 2024 09:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAL2-0002PN-V8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:33:22 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAKy-0000JY-IJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:33:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c9150f9ed4so400304a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728394393; x=1728999193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kqWhOSLxGImP3kxnfOLH8/beOxWgtnb4trmMUju46mQ=;
 b=KjsG8EnjGgXcZdkkCGjaLGQ9I7GxXo8T5wKxGaQPKfWsoX2BXkbZCE6UJ3sV+9KpDo
 2T+O60wTp9ohfzKeGUc6WibQi0ir0MyHt81E+Zt7FIK7j6gc5zSiS8cUimWAIymuM/ds
 /bDhYw0YxSqitnhUPyEhFSTLf+Ncu6xH/3Habw7Xm2/qGUBgPrnb49gkcZfW280A2UDX
 1ASxaWzPERQ4cFPbtS2sYc4fuGr1LegGf4GM9MDjS/AlyGH7Ko0F4Gw6iDS72xCFIpxw
 2QyFdiKnYxPaZJWKL30nNUXrmwuDxNSCdv3stbcBR99/zG0t5hJvvBXqbJQClYlDYTge
 SMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728394393; x=1728999193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqWhOSLxGImP3kxnfOLH8/beOxWgtnb4trmMUju46mQ=;
 b=Gi+fxe5OADlObZ5WI1jz9t9hdq2SytlahSMHDUyAsL+1xD2dUQXAsQuY8cNE4CucDp
 b0v606RV5gH6b4G2GDY8MckgdR88Sh3L+e0/pQP8MxN2xEu2TfNbOF/fTXAcU41iRycc
 sTD16/BmfmlIHn4Z2pOyBJQIDjWnj0VWVY77SYLVn7sj9X3tujiO5zr7T/WUziHPe8Vd
 r7V5gByyH3PS6p1gxdjAtsQOrZQyLXIdsJ+qNi5OSKt3/foYP28VjbJf6hcbjJU9AVLU
 sKDRb1pln/kUaGckiF7yuS0G4zhneHZMsvZUBXs8USwKZMi74dmBGcs1SHlRacQEos9q
 l4WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdbVRMSIewOrWwXs88FMXPz4LFovcLXTSrWKbwxly5RjMBT+ktEjrtjeMbbDnwG2ZVAQURuhookqnT@nongnu.org
X-Gm-Message-State: AOJu0YypWpjc3S9mjfMfag6Evws8UoWGp5leplvK/T8yG9ZSelO2opKq
 wSqrQVbMRCNQ3BvGiGoVdLvFt5xFmHNiNmXfQTIAes9F0RJ1pSoypE17jH2Z6L6eqOIGiUZoLIx
 gQgfW2gjhjEEVqQU1w8/A+b5l8Uasd07Z+UeEJg==
X-Google-Smtp-Source: AGHT+IH7Duff21tQ5mq8AF5gF/8K9fal0hevwSF37BztMfMwM5qVXk2CTdNxeBxvr+pda3vUnDyQHgUOBBtR7LCpwKI=
X-Received: by 2002:a05:6402:2350:b0:5c8:9f81:43e4 with SMTP id
 4fb4d7f45d1cf-5c8d2dfdf39mr14030189a12.7.1728394393418; Tue, 08 Oct 2024
 06:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
In-Reply-To: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 14:33:01 +0100
Message-ID: <CAFEAcA_n1nURHRAt6LXZSJ_b20VarMdbV56=_XTunMYQPosObA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Prohibit calling object_unparent() for memory
 region
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 29 Aug 2024 at 06:46, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

Hi; sorry it's taken me so long to get back to this patch,
but I've now re-read some of the discussion in the other threads.
I generally agree with your reasoning and think we do need
to update the docs here.

I think we could be more specific in this commit message; I've
suggested some expansions of it below. (Partly this is for
my own benefit working through what's going on.)

> Previously it was allowed to call object_unparent() for a memory region
> in instance_finalize() of its parent. However, such a call typically
> has no effect because child objects get unparented before
> instance_finalize().

"because child objects are properties of their owner object, and
(since commit 76a6e1cc7cc3a) we delete an object's properties before
calling the object's instance_finalize method. Deleting the
child property will unparent the child; the later calls to
object_unparent() in its owner's instance_finalize will do nothing.".

> Worse, memory regions typically gets finalized when they get unparented
> before instance_finalize().

"before instance_finalize(), because the only reference to the
MemoryRegion is the one we hold because it is a child property
of its owner, and so when object_finalize_child_property()
calls object_unref(child) the refcount drops to zero and
we finalize the MR."

> This means calling object_unparent() for
> them in instance_finalize() is to call the function for an object
> already finalized, which should be avoided.

"This doesn't cause any bad effects in the common case where we
know that the memory allocated for the MemoryRegion itself
is still valid, such as in the common case where the MR
struct is directly embedded in its owner's device state struct.
But it could potentially cause a crash if the MemoryRegion
struct was somewhere else and was freed.

Update the documentation to explicitly prohibit calling
object_unparent() in instance_finalize."

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>  docs/devel/memory.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 69c5e3f914ac..83760279e3db 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -168,11 +168,10 @@ and VFIOQuirk in hw/vfio/pci.c.

Don't we need also to change the paragraph before this, which
reads:

> If however the memory region is part of a dynamically allocated data
> structure, you should call object_unparent() to destroy the memory region
> before the data structure is freed.  For an example see VFIOMSIXInfo
> and VFIOQuirk in hw/vfio/pci.c.

?

Otherwise we have a paragraph that says "you should call
object_unparent()" followed by one that says "do not call
object_unparent()".

(Also that paragraph's reference to VFIOMSIXInfo is now
out of date -- in 2017 we removed the embedded MemoryRegion
from that struct.)

>  You must not destroy a memory region as long as it may be in use by a
>  device or CPU.  In order to do this, as a general rule do not create or
> -destroy memory regions dynamically during a device's lifetime, and only
> -call object_unparent() in the memory region owner's instance_finalize
> -callback.  The dynamically allocated data structure that contains the
> -memory region then should obviously be freed in the instance_finalize
> -callback as well.
> +destroy memory regions dynamically during a device's lifetime, and do not
> +call object_unparent().  The dynamically allocated data structure that contains
> +the memory region then should be freed in the instance_finalize callback, which
> +is called after it gets unparented.

I think some of these lines are a touch over-length, and should
be wrapped a bit earlier.

Also, this now says "don't unparent in finalize", but
vfio_bars_finalize() has code which follows the old documentation:

    if (vdev->vga) {
        vfio_vga_quirk_finalize(vdev);
        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
            object_unparent(OBJECT(&vdev->vga->region[i].mem));
        }
        g_free(vdev->vga);
    }

Is this wrong and needs changing?

>  If you break this rule, the following situation can happen:
>
> @@ -199,8 +198,9 @@ but nevertheless it is used in a few places.
>
>  For regions that "have no owner" (NULL is passed at creation time), the
>  machine object is actually used as the owner.  Since instance_finalize is
> -never called for the machine object, you must never call object_unparent
> -on regions that have no owner, unless they are aliases or containers.
> +never called for the machine object, you must never free regions that have no
> +owner, unless they are aliases or containers, which you can manually call
> +object_unparent() for.

thanks
-- PMM

