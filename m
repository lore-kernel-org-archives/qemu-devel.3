Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B4FCCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF37-00076l-4w; Tue, 21 Oct 2025 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBF2n-0006tM-4L
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBF2k-00021h-Lv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761063420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Lo7+CNfsGIcNSGdYpiAnUPzCn7col2IHeF9S06Rdcc=;
 b=f+iM5A8UxpDjGYck4NqG/ljJdMavs9LMPScm4V/gAPI8KsQd7HumRKUXWhAIXUQYXI4DHF
 rQBeP8yZqr7Ftrw5JAe18Gu+dd8r53KjtkDGAkemEamAQB8PGqDetUbEW6zEXJlRUtZOQv
 l9qHiFaiV3MksbbPHuAbgEao1aMPD6c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-i0xs_BRFOvWjc4GaEFXPGA-1; Tue, 21 Oct 2025 12:16:58 -0400
X-MC-Unique: i0xs_BRFOvWjc4GaEFXPGA-1
X-Mimecast-MFC-AGG-ID: i0xs_BRFOvWjc4GaEFXPGA_1761063418
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-81d800259e3so92540376d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063418; x=1761668218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Lo7+CNfsGIcNSGdYpiAnUPzCn7col2IHeF9S06Rdcc=;
 b=GbOv+8lcd85dKr0kffe/fN35UwtqkHNweq3/hm1gk8T6B6CM042l9L4LOgXcEXt8qA
 tX+lACsyhGQFR37OczizbaJt57JpQ3ruJJInlXw8u0vpW4KKf5EnboP1b6YlukRvlcy1
 9nLiYnXv9cL508861CZdhP9VTmMZ+bqAV2E0WO5Aa7gl3fSilNr+U+gQtBwOR9JTkGGB
 PuWXHMZXI7gEuZ4jLLlr+sTICeojxsMjQas0v33SD2oyX3VmUbDW/GYnk1HPCyBZ8N1o
 4Wo9Yt4cKIibGlH/m2NmdPOts2qjIocfdEeWGKOE/dMUQgzaJckwlIWqyHBVMSmREsf2
 rFJg==
X-Gm-Message-State: AOJu0YwjJ7YPz0eHp9IGoKOFF9HCrNeToSl1Zs5fwpsZlGZowYM9gHJJ
 2HNG4t414ZChignKgBDopW/jPvQoN+Ibmx0/h0it9CQMjsgFnSf6+iz86YankYc+LytN0VG187X
 4+1L0wInsH8SNVJgXefc+/huuZAhCuwNUNn2XhydVyD1B+1sgqcljtey6
X-Gm-Gg: ASbGncuMQcNajq1D5LHMbrb2KQDKLxU2V2s1xq6HaRR0KTcXQe16NSs0vb2h1OifT1v
 CUZgdVdE+vjo5mMixHKoiuUFeoNcylDvaGMCkYbGnyNPqiCMw0WVvmAN+NKMVYnonHFgkDePd2+
 JpYuJFePwamf2Th8P3ve9WuL8GBvleg+8nhf7HuwygWACexz2ccAVaA0/2uMxaiyqrj0XDdKUh1
 xefNQGbQ+Wl/N5+4zWTMNCvYmdWQZAAMYkMX0dhp3lqvbbCCfd+h71ofs0gvrmZcbkMj7VHR6pQ
 2Yk2AvQ3L+Zx0ROL5dCiRPSMZWEIiCREZAPvfZ8WYdcNyrBUm7Rx4v4ckTk1ZrWmi4I=
X-Received: by 2002:ad4:5ae4:0:b0:87c:2868:51d4 with SMTP id
 6a1803df08f44-87c286857fdmr204932836d6.28.1761063417444; 
 Tue, 21 Oct 2025 09:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE8MYyozbH9PPCoxpJ7ndND5YfjbRDNs+vMsw/ri0Gd8KOwiEAG5CDoch4VS+R7pYBdS9kfQ==
X-Received: by 2002:ad4:5ae4:0:b0:87c:2868:51d4 with SMTP id
 6a1803df08f44-87c286857fdmr204932036d6.28.1761063416810; 
 Tue, 21 Oct 2025 09:16:56 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf5235156sm70943456d6.27.2025.10.21.09.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:16:56 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:16:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 02/45] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aPex9SsQOup69DRI@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-3-peterx@redhat.com>
 <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_230hx7mFzo=jT07heROTvjO=q7B4B73+gO_KneC6EuA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 21, 2025 at 04:43:52PM +0100, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 16:39, Peter Xu <peterx@redhat.com> wrote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that vmstate_load_state() must report an error
> > in errp, in case of failure.
> >
> > The errors are temporarily reported using error_report_err().
> > This is removed in the subsequent patches in this series,
> > when we are actually able to propagate the error to the calling
> > function using errp. Whereas, if we want the function to exit on
> > error, then error_fatal is passed.
> 
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index de35902213..e61585aa61 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1347,7 +1347,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >      }
> >
> >      /* load & apply scanout state */
> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> 
> This is in a migration VMState .get function -- shouldn't we
> be passing failure up to the caller, rather than exiting
> with error_fatal here ?
> 
> The commit message says some of this is fixed in subsequent
> patches, but as of today this is still the code in git.
> The other callsites which pass error_fatal to vmstate_load_state()
> also look wrong:
> 
> hw/s390x/virtio-ccw.c:    return vmstate_load_state(f,
> &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> hw/virtio/virtio-mmio.c:    return vmstate_load_state(f,
> &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> hw/virtio/virtio-pci.c:    return vmstate_load_state(f,
> &vmstate_virtio_pci, proxy, 1, &error_fatal);
> 
> as they are written to return an error value that they'll
> never see because of the use of error_fatal here.

Indeed a fair question to ask.

> 
> Do you have plans for further cleanup/extension of the
> use of Error here that would let these functions pass
> the Error back up the chain ?

It would be non-trivial though as we'll need to change VMStateInfo.get()
API and that'll be another lot of churns.

Arun, should we pass NULL for above three occurances, so that we will still
not brute force quit when error happens?  Do you want to send a patch?

-- 
Peter Xu


