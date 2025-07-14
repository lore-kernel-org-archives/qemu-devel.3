Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA4EC83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubG17-0006GC-5o; Mon, 14 Jul 2025 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubFwf-0004Yc-01
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubFwc-000818-CP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752487072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYaCaOC1HgCpDgtqWAsjztzzwyVqIvIDL5IM9FlnsPc=;
 b=iVR4oa/1br1DCWnYmExPMaM1aMCaaHP4Mgl7c84porVJoV6/hiOk0zeCQJRmoZmYQsUuj6
 dLdBvdPwhJRRULTebZaZ2fCWvqcd8F0jJsTnzdpk5ojn/YlCPkeY7vHO/fXEBxDWRsy527
 xG5PZhaL30BdNjnjvyLO6fGz3H4VI1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-LHaJF_CkOUKWsBXBjp9_nQ-1; Mon, 14 Jul 2025 05:57:51 -0400
X-MC-Unique: LHaJF_CkOUKWsBXBjp9_nQ-1
X-Mimecast-MFC-AGG-ID: LHaJF_CkOUKWsBXBjp9_nQ_1752487070
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2656357f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 02:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752487070; x=1753091870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYaCaOC1HgCpDgtqWAsjztzzwyVqIvIDL5IM9FlnsPc=;
 b=BUSE3Zv9O1Dy2f85gsUgA0FvmZHUFw6tZpfdk4myj6A3aIDZDwYJ3Tkv0Lt+43zbwM
 mRqIB2CjfS8q6ZWTg7XgKD3uVuiIyq3i2906Q2jCNHqGUIBHt52dEkU5i3OATuZ212pu
 86H+NmiGB9QpiGzEN1t3pILGQdMsW4WMft/T0QEFs/lMiTB6Vqzl291g6M3Mop1bBDb6
 +wRIDXCkMz6eBp637BOesyh7cZmWVHLVAEqspRP4yelqbraiyjkPqvHEv9VH7LQ9zHRV
 /lqnViZYGpMvTLQEzfflOTl92LTPrJ/UBFqykk/iycG6by5qJ/D+pUXJ7KB2bvADD3ar
 VZAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP30ulB2YQD1DZ3klqxrYPNXXQHM6VtEDqHfJNxLxFx0CKrya9ooN7dk3hZdHKeoW04mT1q/CcUO8t@nongnu.org
X-Gm-Message-State: AOJu0YwI4NWQRZl/iHF/rAEeoS55z37Blb2b6IlqhP+eKzdNGzVpUMce
 /jPXmm2/eqN+5HyMXjAXOfrxkTGo5ldpN+2fzUFSXH0WiButolwk/mciWUW80Pi0NMxm0WYCOwj
 rdE3LJapnpi+KdSgxTcSal8XnOEU2Pud8fw2HqbuweZTCoCpCOAqTILo5
X-Gm-Gg: ASbGncurj/YZgFLJevZfTRcUm7b5A011ERK3K26sk9YiggyUuMcz8j9FVnQSvmE84c3
 uFoQxjcvxNNWtf2Pu+l6ePPUo0P09XYp7B8Osu1Y2r9705XZ00/6BuSkmRqBeZYRCaadUQmjVe0
 xbq5CDYywGgyLC9ekJ1z/EiiKfYj0S3ngdEVgNxbe1MN3om9YtD8DvxGKJPnW9tVh+W5Mjw/wka
 REe/JD5o8Td4D2UzkutCIIukAbFnk0kZJflT4DFmZzkM67ox7nja1m4q9SRcnIexMUYL8HP2Zx4
 OshD3LL28TTbdiVQy3Ene9L6IXQghXZa
X-Received: by 2002:a05:6000:3108:b0:3b5:e2b3:1ad8 with SMTP id
 ffacd0b85a97d-3b5e7f1135fmr13252964f8f.10.1752487069827; 
 Mon, 14 Jul 2025 02:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMeKOwLF5W2UrNIcbu/v93uxQK8VXtzWuvFIY+R9JilmT06goN2EiveEUadxgToWnTIt61uQ==
X-Received: by 2002:a05:6000:3108:b0:3b5:e2b3:1ad8 with SMTP id
 ffacd0b85a97d-3b5e7f1135fmr13252932f8f.10.1752487069275; 
 Mon, 14 Jul 2025 02:57:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b600a39281sm4265645f8f.73.2025.07.14.02.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 02:57:48 -0700 (PDT)
Date: Mon, 14 Jul 2025 05:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: vhost-vdpa potential fd leak (coverity issue)
Message-ID: <20250714055556-mutt-send-email-mst@kernel.org>
References: <CAFEAcA816sEoqZOzSwX9q1zzJEQ_mMpenLW7fBu5MEbM=aFymQ@mail.gmail.com>
 <20250710123945-mutt-send-email-mst@kernel.org>
 <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rwmbufb2zk6grtmrksfthav6ntm7ddsodqfrpjwjt6njbacx62@7hikurlwh3kl>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jul 14, 2025 at 11:18:51AM +0200, Stefano Garzarella wrote:
> On Thu, Jul 10, 2025 at 12:40:43PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 10, 2025 at 04:46:34PM +0100, Peter Maydell wrote:
> > > Hi; Coverity complains about a potential filedescriptor leak in
> > > net/vhost-vdpa.c:net_init_vhost_vdpa(). This is CID 1490785.
> > > 
> > > Specifically, in this function we do:
> > >     queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
> > >                                                  &has_cvq, errp);
> > >     if (queue_pairs < 0) {
> > >         [exit with failure]
> > >     }
> > >     ...
> > >     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
> > >     for (i = 0; i < queue_pairs; i++) {
> > >        ...
> > >        ncs[i] = net_vhost_vdpa_init(..., vdpa_device_fd, ...)
> > >        ...
> > >     }
> > >     if (has_cvq) {
> > >        ...
> > >        nc = net_host_vdpa_init(..., vdpa_device_fd, ...)
> > >        ...
> > >     }
> > > 
> > > So if queue_pairs is zero we will malloc(0) which seems dubious;
> > > and if queue_pairs is zero and has_cvq is false then the init
> > > function will exit success without ever calling net_vhost_vdpa_init()
> > > and it will leak the vdpa_device_fd.
> > > 
> > > My guess is that queue_pairs == 0 should be an error, or possibly
> > > that (queue_pairs == 0 && !has_cvq) should be an error.
> > > 
> > > Could somebody who knows more about this code tell me which, and
> > > perhaps produce a patch to make it handle that case?
> > 
> > Historically queue_pairs == 0 was always same as 1, IIRC.
> 
> Yep, also looking at vhost_vdpa_get_max_queue_pairs() it returns 1 if
> VIRTIO_NET_F_MQ is not negotiated, or what the device expose in the config
> space in the `max_virtqueue_pairs` field.
> 
> In the spec we have:
>     The device MUST set max_virtqueue_pairs to between 1 and 0x8000
> inclusive, if it offers VIRTIO_NET_F_MQ.
> 
> So, IMHO we can just change the error check in this way:
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 58d738945d..8f39e5a983 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1813,7 +1813,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>      queue_pairs = vhost_vdpa_get_max_queue_pairs(vdpa_device_fd, features,
>                                                   &has_cvq, errp);
> -    if (queue_pairs < 0) {
> +    if (queue_pairs <= 0) {
>          qemu_close(vdpa_device_fd);
>          return queue_pairs;
>      }
> 
> I'll send a patch if no one complain.
> 
> > 
> > > Q: should this file be listed in the "vhost" subcategory of
> > > MAINTAINERS?
> > > At the moment it only gets caught by "Network device backends".
> 
> Maybe yes, but it's really virtio-net specific.
> @Michael WDYT?
> 
> Thanks,
> Stefano


vhost kind of includes all vhost things. Not an issue if it's
in both places, I think.


