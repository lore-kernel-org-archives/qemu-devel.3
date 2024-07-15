Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E9AC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 02:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTBUx-00081k-9d; Sun, 14 Jul 2024 22:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTBUu-00080S-HT
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 22:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sTBUr-0001TL-Oj
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 22:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721010684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Dwjr1+pakyvD//iMH+S8hYK/5WYNs/wQ8LB/jvTJ6U=;
 b=UkQnVhzoMc3zXB5khMyWTiU+gntL2/ix5oj0RVp994ChXFVI5ocaNQsogGSPYc0gYx2qnY
 7HL9lTD+RVYyRzVsB6O6uBMyuVaBqFDRqFuqDJGVe5v/BU3hn+RggT6fW92FJi24Y9NM/9
 VCqDsd3rZpfF9naQBjpb5m3lmUZuLCU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-MGlk3BO6PoytivRjcGTiPw-1; Sun, 14 Jul 2024 22:30:39 -0400
X-MC-Unique: MGlk3BO6PoytivRjcGTiPw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-649731dd35bso2309734a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 19:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721010639; x=1721615439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Dwjr1+pakyvD//iMH+S8hYK/5WYNs/wQ8LB/jvTJ6U=;
 b=vMx81FBj9+Ls0Ur10GvE4gUvNzicarkgX50jWjRqG+NVLrfP7qObDPxwaTKDiI/zxZ
 R/0Nri0f/L1z1lAPg8lFYXkVBcBesReeoOQUIJHl13ikkZeRz95U/n7U2/aj2Sfc5VHI
 rBVDKv1e5t2BlCC9/xjYGD2peLZhxU7+Mps41F+OvjlN+0Fv4ksvVXLPzd17eykHVoKr
 s39cloJIJ1othP+XxXwjjm1nQt9NuYZAD3Z9FbGgv37KGuu1O44yfwsipgQ8Hr5BL3PO
 Hk662XGSabAEJV9botzkXo89xfFuBDdMvB+ZU7tcE5p9KxtodDvuBYjgzKFjd238RnLK
 di4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SMK2cBZkfhgfyFzGnCqP6oFrc8xU9338m/IwPx30M5iI1oi+PclXKALs8KjrgQvskdPNGPK0XDWiH84QYvYnndK49Yw=
X-Gm-Message-State: AOJu0Yw4JkrCTkGKzUyr+MoK0ZQOLndmBpuZXZ0sxYO8PplDVY7Z9Lzy
 Y1XKqFNrukdgZQnIiQ3fI5KFVJWfzqTfNWk+RFOqK0l1Kuck6ndljRyCwzPWWDCHxQanVwNvr7/
 bn3cVuKsHuXdp8iwAU86YdHRyIORSjJdnEHHbCIR1Vos48t0ulzmPYz82LXaqiJf4YonOFvsjaa
 hE0/o2oXyiGz7vhbSW3eEiQZj2jNI=
X-Received: by 2002:a05:6a20:3941:b0:1be:d5e9:b444 with SMTP id
 adf61e73a8af0-1c297d67c2fmr19202912637.0.1721010638755; 
 Sun, 14 Jul 2024 19:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdeiqarU+4MbUKdv0qbyy8ByGB3YpDzvIGAvN9jN8uL1aH4MBnXcH8EO4k/8NEMP8TxFrGkisXbC0QaRCjHQU=
X-Received: by 2002:a05:6a20:3941:b0:1be:d5e9:b444 with SMTP id
 adf61e73a8af0-1c297d67c2fmr19202892637.0.1721010638232; Sun, 14 Jul 2024
 19:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240712014407-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:30:27 +0800
Message-ID: <CACGkMEseZTupyZ6OnxtVGWdxtzp_C7M0BEKOUQAMK7tp4-i1Xg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 12, 2024 at 1:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrot=
e:
> > >
> > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > > crosvm a couple of years ago.
> > >
> > > David, I'd be particularly interested for your thoughts on the MEM_RE=
AD
> > > and MEM_WRITE commands, since as far as I know crosvm doesn't impleme=
nt
> > > anything like that.  The discussion leading to those being added star=
ts
> > > here:
> > >
> > > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redh=
at.com/
> > >
> > > It would be great if this could be standardised between QEMU and cros=
vm
> > > (and therefore have a clearer path toward being implemented in other =
VMMs)!
> >
> > Setting aside vhost-user for a moment, the DAX example given by Stefan
> > won't work in crosvm today.
> >
> > Is universal access to virtio shared memory regions actually mandated
> > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > What about screenshotting a framebuffer in virtio-gpu shared memory to
> > virtio-scsi? I guess with some plumbing in the VMM, it's solvable in a
> > virtualized environment. But what about when you have real hardware
> > that speaks virtio involved? That's outside my wheelhouse, but it
> > doesn't seem like that would be easy to solve.
>
> Yes, it can work for physical devices if allowed by host configuration.
> E.g. VFIO supports that I think. Don't think VDPA does.
>

I guess you meant iommufd support here?

Thanks


