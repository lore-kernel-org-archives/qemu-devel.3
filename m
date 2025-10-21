Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A53CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFoP-0001VZ-GO; Tue, 21 Oct 2025 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBFoM-0001Tv-UT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBFo6-00005N-QX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761066349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cP1dSM9RvKaab8cnPzMoNOQnA+Q2oq1elXQAxtM1A5M=;
 b=ENg7Kf6UsFZyqVJ9keYe2GzBwBJWrQ/7WMl+OPR4gbBy/h3cpqmIuhZpAk3J4XoahHiPWW
 /nsLl/8UfMvPIfLjf77RJe8QT/wt+xXod+jJJuD0gCgI2eygTgadV6SWySR5FvPorqnLoM
 UZg0L/3Nefg1bZh+11J8vGHetoTJzgo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-yJH650cNMauxKGM8QkEufw-1; Tue, 21 Oct 2025 13:05:47 -0400
X-MC-Unique: yJH650cNMauxKGM8QkEufw-1
X-Mimecast-MFC-AGG-ID: yJH650cNMauxKGM8QkEufw_1761066347
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87c171369aaso3516936d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761066347; x=1761671147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP1dSM9RvKaab8cnPzMoNOQnA+Q2oq1elXQAxtM1A5M=;
 b=n8pV/4QzhYNFhYbFxJ0Wikr95m7GjyDP9vq6LtKoZcpK05Jm8wmreEsVMnxZu+wY3m
 dGZVXBPjaXeT9/nkHLalYkQ/UmEkoDRhZYQ2Tys9hLY4x5NyFbnG0uW6th2u+5lUyV2U
 pBjBdoqoWe2OF4s9sGBxU2KJI03sdnHoJQRQ6zxrAqsZVuoIpqul0706UqWlQM8Oslzl
 jsGRHSuhur4+xAc0lSWzNT8LQrRkwnP/ymvAmCO9oOtinL2PrfHgIDT3wokRvU8Sv3IC
 Nwf7hLsWbjnfUoJyQRSb6AiJ+RmQFX4l+InW9XIpMQRnkAk2a/IKRsuCRjd0MtsWc7t9
 cjLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVULZYlAunSpkSKToISlQS7H/PV0JdnXdZAz6+evYNiLPmUaMSdDNCu9329myi9fbZHjbxE4/Abpu3O@nongnu.org
X-Gm-Message-State: AOJu0YzuIkjEr49vF0BXKKLSssgJ9YuJkfaTy5AeN3r8E34ZXhaPEeT0
 XZ+JdrDEkEXC663oXaSiH1aQEo9GWuDdOQ47s85rquCzpEz6HURmVM/5stuGsVNl4hrS3pJQ5HB
 4HDqTXFP1C9ZCYqgIm31jNU18qKZTjHIaLMKEDfc1NaNmy3fBdj70oZ1F
X-Gm-Gg: ASbGncvClJNQf+I90g84cziK/0d3qgag2Z6Lt/HyuclVr2HWoAMV5hZoxEAgrvIaPug
 R6x3nOTRvKKTvmw2r3fq9c8fbmekUky/5QfJVVpwWennOEn0xCjaE0kQi+hLmlHnwuAUsQYcQtN
 +NkxFiLDxW/YR0G1qNongMtsxHAaFliY8gOQwiPRO0fo50TL9lpef7+00sdWaAUyLmmgM0EybSD
 CP22r9eAhuR3zQOxlHxE5CyA8cvVVUNMLBgV5fPhfZJjDBK0vc6dJpJuSTp59YrVVhSmQ6iLCT0
 0EPwnU0oMcl/Ipd7MLCPQI1l9dUnvr3a8ktVji95J0A4zMyhvudXy3XHghbwecjMA5Y=
X-Received: by 2002:a05:6214:d47:b0:87d:8f9e:985f with SMTP id
 6a1803df08f44-87df659e16bmr8043536d6.31.1761066346805; 
 Tue, 21 Oct 2025 10:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvd7PzVtd72Wf8YlNrpAujqM+9ucqm7UazzO+MFhXOjYTtYokM31G39YJhUEYCY9teIP3ltQ==
X-Received: by 2002:a05:6214:d47:b0:87d:8f9e:985f with SMTP id
 6a1803df08f44-87df659e16bmr8042656d6.31.1761066346232; 
 Tue, 21 Oct 2025 10:05:46 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028aef65sm73049326d6.50.2025.10.21.10.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 10:05:45 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:05:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPe9Z0IiEI6mzCdY@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
 <aPex9SsQOup69DRI@x1.local>
 <CAFEAcA85DRf5918ea9N66+Z7M_vVGNy+-SdSx17E5MGOf_cbMA@mail.gmail.com>
 <aPe4yBqkPTiDiYXq@x1.local>
 <CAFEAcA8e7qKGm7vq-8TFC40VMfoGU_O5+U0rrKG+Z8M3fVdRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8e7qKGm7vq-8TFC40VMfoGU_O5+U0rrKG+Z8M3fVdRfg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:49:51PM +0100, Peter Maydell wrote:
> On Tue, 21 Oct 2025 at 17:46, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 05:21:44PM +0100, Peter Maydell wrote:
> > > On Tue, 21 Oct 2025 at 17:16, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> > > > > Do you have plans for further cleanup/extension of the
> > > > > use of Error here that would let these functions pass
> > > > > the Error back up the chain ?
> > > >
> > > > It would be non-trivial though as we'll need to change VMStateInfo.get()
> > > > API and that'll be another lot of churns.
> > >
> > > We could at least do it in stages, so we add new fields
> > > .get_err and .put_err that have the new API with Error*;
> > > the calling code in migration/ uses the new functions if
> > > they're non-NULL, otherwise falling back to the old ones.
> > > Then we only need to update the implementations which
> > > want to be able to return an Error. (This is the same sort
> > > of thing we have with MemoryRegionOps and its read/write
> > > vs read_with_attrs/write_with_attrs methods.)
> > >
> > > The downside is we end up with another "there's two ways
> > > you can do this" API.
> >
> > Right, the other thing is get()/put() logically should only be used for
> > primitives...  I wished they're never used in complicated ways.
> >
> > IOW, in an ideal world, get()/put() should only fail because of qemufile
> > channel errors, rather than anything else.
> 
> I suppose so, but that seems like something in practice
> we make a lot of use of. It's really handy to be able to
> say "this is how you obtain the integer you wanted to put
> in the migration stream" -- we do a fair amount of that
> in target/arm/machine.c for instance. But those don't
> need to return a failure, I suppose.

That's exactly what pre_save() / post_load() should do, IMHO.

Taking example of the arm's case here:

static int put_fpscr(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field, JSONWriter *vmdesc)
{
    ARMCPU *cpu = opaque;
    CPUARMState *env = &cpu->env;
    uint32_t fpscr = vfp_fpcr_fpsr_needed(opaque) ? 0 : vfp_get_fpscr(env);

    qemu_put_be32(f, fpscr);
    return 0;
}

The .pre_save() should be exactly the logic that generalize whatever we
have had in QEMU's structs into a pure uint32_t, put that into a temp
u32. Then migration should be able to transfer that using whatever way it
prefers.  When using qemufile API, it should use vmstate_info_uint32 so as
to not open-code qemu_put_be32().

Now, we have a major issue with qemufile and all the APIs that bound to it
when we want to move the IO layers from qemufile to iochannels, exactly
because we lack such abstraction layer, where we mixed up "this is how you
obtain the integer" and "send this integer to the wire" operations in one
API.

It would be ideal if the IO part can be left to generic primitives like
vmstate_info_uint32 in this case, then it's easier when we want to convert
to using iochannels rather than qemufile APIs.  iochannels are more
flexible in many ways (e.g., multifd only support iochannels, not
qemufiles).  Mneanwhile qemufile is a known bad API... :(

> 
> > Then, descriptive errors for get()/put() may not even be needed..  OTOH,
> > complicated structs (like virtio_gpu_load...) should really be done in
> > VMSDs already, and anything can fail outside -EIO should be done only in
> > pre_save() / post_load() / ...
> 
> You can't return an Error from a post_load callback either :-)

We can, after this pull landed. :)  Please see:

[PULL 25/45] migration: Add error-parameterized function variants in VMSD struct

-- 
Peter Xu


