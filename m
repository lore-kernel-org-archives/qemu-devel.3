Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C678EC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmY0A-0006mC-L0; Wed, 22 Jul 2026 10:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmY09-0006lP-M7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:32:49 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmY07-0002fk-Rn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 10:32:49 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-39ca300db70so99675021fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 07:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784730765; cv=none;
 d=google.com; s=arc-20260327;
 b=nbvVJtA68r7fOAaYJOzFVXCHgmZx7l9rRq/eNLClQUyKHSEWknvoq0poNkJfyqty1F
 Bcoh+qw6QOrnFvneHCGUtdPZiT0bG5pB9mWNjAWvTmP8+yFgrsXwQmPmFAf/9BTBdwFN
 4fHOiAk2/79T5by2M7sHHwrGNUuwO36wy8Ygq+AztKYs+8RAoCiTPnNvXHDDoE+ZREpI
 k6SAVi8rPKA6Qp5MnrD+1TqRKXOWNXeTeKZyuBobTOr0VZz5dapxRGtS6vncZx7vbV/y
 UxuHEtsHOWXq/7QdtvTRV6ePrNlT72fcaJYb56wYxjOg2+CrujSxjIA91HY/l4Xe6MaS
 KeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/ztR8U32v6R97uPTPFaf1+evDqJDZdvaBArglLWA4k0=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=GpDqOzJgycYYdyQDj/Dlp+s6kqo8cIk6IlCeksFz5uVawtdWrIpTWlW3FJRZ0OroGN
 zXKSB4UZlEDh8HltHI3RbgrgtHR/iJrjmVSznOzznrkwKs4HgcwqxuT2TPP4i85sddl7
 W1RYuSm5TafYX/0BOxW0JnHYFRuRdDxunAbEDkAmTZB8YNbiZy2oc2LlPOkYWJTlsw1r
 JmGvk9K7EsRqbCWJ1mT8EydVY/jCKTuqPLgGU+aXEMeVzUBdQzTpMAUwJmy1r7ewukMM
 1OOejbA1As6gvxdOELX3vytnTVaY3dWZjpLfvTcv7KMV9FZR6yDw9hB8/dgnJisJ0/9T
 HnUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784730765; x=1785335565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ztR8U32v6R97uPTPFaf1+evDqJDZdvaBArglLWA4k0=;
 b=CF/9jwFhGOPnGMIEuyWR7rtx31aQVzLCqvDddarkEHgrHOrfxgMmW/d8r/WkgTpXGz
 hyqEUNY4c5Q8tdsP08/v3VcXi3kHuchjmi3z+pSWSHgJo2KbpWe7TNWuLiKUbWf4YUPd
 msY0xR4GTiQTrBjecbNE/ipqhhNyke92oB8cpeT7bXNdBp/kcPEEK+BstBBfeIJgy+BF
 +Sjj4gHXBnGDgIXC7sC9Wo1T1xyFd8YwJUaqAQg68pt1pJBl87H8pM4fqjB4hPs/brFY
 t8ckZ69UJRgaV2L+5crMsrLS+q6HQJsNalKZNp2IPsRtYo6TJSG7aRA4cRLWxGrd1+pA
 M2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730765; x=1785335565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ztR8U32v6R97uPTPFaf1+evDqJDZdvaBArglLWA4k0=;
 b=LEZwYAmRL05uvuBcOBfi/uvdX+kVB9uHfo5Q+klmNyU5cF6D/IqI/jpRRwx2CwkBEu
 flJ6M+G391HaSExKMFGw83XG3bj+55B8BzMRm0ZvyWJxs5jiEjM2XSFwCkYH/7N54/Xr
 YZIA35L/Fp5DrYfrzsWKbzxw8jDMbWSoPhmakx62FdBardusGUg/bwY+3wnw2SmetbjK
 bUlZhQahW9xW7kpbtUYIXD5JP4+UP96OuGEuiZtT1ET0eOhA/Rb/QHw2pP5+9BFa5iLD
 iLpI5yEgeXGUt/2DhJWIHg0c6xfrS/4+ibiUnFk7tcoQqmMtzwAjbQ69Hpww9E4eHbfE
 l82g==
X-Gm-Message-State: AOJu0YwBJZ1/8fkrvHA+pUynT8HYASuIIkry/NjniwF86kFL/3N35uUs
 FnKdr26EyGNDngffWP46gfyoCEY8PJcdIP3lZv7997tA/TGpWUFL9x0V29l58RGM3xGppn2RIYZ
 gM7dObdQkbpAbVfIP411iPDRPYq8yJYk=
X-Gm-Gg: AR+sD11QqrXi+D7WySu16ktIW3nwAF008Y/5yUZEK87YtlZyibYx45zNSVfT9NliEtI
 Gi7/11MtPAnX1pmj2vsPqaQFQOLak/Ne7f+v8LDdlZ2j+nMKzVlH1OUSbBHv+8AmpCP5uwVPXD9
 t+icqdWh06vMpywAhDcnd4PmpvPdaDDXm/hfqcdV6VbvEPoolSDJT+YSh4ond1w3hj9GdcmwvqG
 RsM1jR+2ILtH0a/YH4+ZGBtx2tMYabV99PPgWh+J63nnNGJ/gd1LtTILJsS9s4QSJp7BY/hdztx
 oSTiYxUcuNPw/MSqyg==
X-Received: by 2002:a05:651c:2111:b0:39c:92e0:52ab with SMTP id
 38308e7fff4ca-39eb63ffc36mr47187211fa.28.1784730765125; Wed, 22 Jul 2026
 07:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-12-aadeshveer07@gmail.com> <al56MgEneEnIpL6E@x1.local>
In-Reply-To: <al56MgEneEnIpL6E@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 22 Jul 2026 20:02:33 +0530
X-Gm-Features: AUfX_mwEVU9zXj9dZDu0kTazKfKkx0zCpv6zSi_J4Em5tmHyqWc2joWxmFn7z-M
Message-ID: <CA++cPvKNPEJK7d8P3ufLTyxTMAG465oht+h6948434R3UKi8hQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] docs/migration: Add documentation for fast
 snapshot load feature
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 21, 2026 at 1:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jul 14, 2026 at 07:45:47PM +0530, Aadeshveer Singh wrote:
> > Add documenatation for fast snapshot load covering an overview, the
> > architecture, usage and limitations.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  docs/devel/migration/fast-snapshot-load.rst | 81 +++++++++++++++++++++
> >  docs/devel/migration/features.rst           |  1 +
> >  2 files changed, 82 insertions(+)
> >  create mode 100644 docs/devel/migration/fast-snapshot-load.rst
> >
> > diff --git a/docs/devel/migration/fast-snapshot-load.rst b/docs/devel/m=
igration/fast-snapshot-load.rst
> > new file mode 100644
> > index 0000000000..0c0dc676fb
> > --- /dev/null
> > +++ b/docs/devel/migration/fast-snapshot-load.rst
> > @@ -0,0 +1,81 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Fast Snapshot Load
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +Fast snapshot load is an extension of the postcopy migration feature
> > +to disk loads.
> > +
> > +Unlike a usual snapshot load, which requires all VM data (RAM as well
> > +as device states) to be loaded into host RAM from the snapshot file
> > +for the guest to run, fast snapshot load uses postcopy infrastructure
> > +to load in only the required device states and load RAM pages on
> > +demand. The idea is to start the guest and serve its page faults on
>
> Suggest to replace "load RAM pages on demand" to something more general,
> like, "allows the RAM pages to be loaded after VM starts".  E.g. the eage=
r
> load thread work isn't on-demand.

replacing with a more generalized line does make sense. I will add it
in next version.

>
> > +the go, reducing the perceived resume time for large snapshots.
> > +
> > +Architecture
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +This feature combines postcopy migration and mapped-ram capabilities
> > +to load RAM pages on demand. It is done by catching guest faults using
> > +Linux ``userfaultfd`` and loading the page by calculating the offset
> > +of its location in the snapshot file using mapped-ram capabilities.
> > +
> > +Fault Thread
> > +------------
> > +The fault thread uses Linux ``userfaultfd`` to catch page faults cause=
d
> > +by guest and directly load the page from the snapshot file. It is
> > +very similar to network postcopy fault thread, with primary difference
> > +being it loads pages directly by reading from the snapshot file.
> > +
> > +Eager Thread
> > +------------
> > +Eager thread iterates over all pages in RAM and loads each page not
> > +yet loaded by fault thread. It is required as unlike network postcopy
> > +where majority of RAM has already been loaded via precopy, here entire
> > +RAM is waiting to be loaded. If there is no eager loading thread each
> > +page will only be loaded when it is required by guest. In case there
> > +are some background pages that are never/rarely accessed by guest,
> > +the system will be locked in migration state indefinitely.
> > +
> > +Synchronization
> > +---------------
> > +In order to make sure both of these threads do not load the same page
> > +twice potentially overwriting and corrupting user RAM, a bitmap is
> > +used (``RAMBlock->pending_bmap``) which tracks the pages claimed to
> > +be loaded by threads. This prevents race condition when one thread
> > +is loading the page and other one tries to do the same.
> > +
> > +Usage
> > +=3D=3D=3D=3D=3D
> > +
> > +Simply enable ``mapped-ram`` and ``postcopy-ram`` capabilities on
> > +the destination:
> > +
> > +.. code-block:: text
> > +
> > +    migrate_set_capability mapped-ram on
> > +    migrate_set_capability postcopy-ram on
> > +
> > +Use a ``file:`` URI for migration:
> > +
> > +.. code-block:: text
> > +
> > +    migrate_incoming file:/path/to/snapshot/file
> > +
> > +Limitations
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > + - Multifd
> > +    Fast snapshot load is currently incompatible with ``multifd``
> > +    capability. While ``mapped-ram`` allows for parallel disk I/O,
> > +    coupling it with ``postcopy`` capability requires additional
> > +    infrastructure.
> > +
> > + - Host OS support
> > +    Because this feautre essentially depends on ``userfaultfd``
> > +    to trap page faults, it is supported only on Linux hosts.
> > +
> > + - vhost-user
> > +    Fast snapshot load does not currently support ``vhost-user``
> > +    backends.
>
> For this one you haven't added a check in the other patch to detect it
> happening, you can add one check to see if postcopy_notifier_list is empt=
y:
> anything registered implies vhost-user enabled.

Thanks for pointing out the use of postcopy_notifier_list, will add it
in next patch.

>
> Thanks,
>
> > diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/f=
eatures.rst
> > index 9aef79e7fa..23c2a93173 100644
> > --- a/docs/devel/migration/features.rst
> > +++ b/docs/devel/migration/features.rst
> > @@ -11,6 +11,7 @@ Migration has plenty of features to support different=
 use cases.
> >     vfio
> >     virtio
> >     mapped-ram
> > +   fast-snapshot-load
> >     CPR
> >     qpl-compression
> >     uadk-compression
> > --
> > 2.55.0
> >
>
> --
> Peter Xu
>

