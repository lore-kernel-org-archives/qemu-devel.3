Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01351C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLCX-00085i-4h; Mon, 27 Jul 2026 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLCS-00083p-En
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLCO-0000Bd-VA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785158211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GzRicd67PSCqJGIMiq4Ufv206kn0KFMDSLYsAkX4MM=;
 b=dKy0iAv1s1e9sdZHlwpRBJFAJJkCplaWNPIMxWkA7Ont1cguG9D/EG+BowNNbj0Mi89EIv
 wE6rTt3xuv7BlQ9jtldMiR++D3AUWmxo2Xv1XSkYg554/r5uOCbJDKrmBrzGOxhTodIwBR
 5hRBfl5YTX5/KNqzbeFHjdTVDR4hB3E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-hYUftKX4MwmGRlpCf58iQg-1; Mon, 27 Jul 2026 09:16:50 -0400
X-MC-Unique: hYUftKX4MwmGRlpCf58iQg-1
X-Mimecast-MFC-AGG-ID: hYUftKX4MwmGRlpCf58iQg_1785158209
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1619289f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785158209; x=1785763009; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1GzRicd67PSCqJGIMiq4Ufv206kn0KFMDSLYsAkX4MM=;
 b=P380GMWvhBCo2dZkIneabuF7tVHQ5jW8k5tiW1R6gbJjIWwm1+/y7vDzITSfOnXEfA
 O2/bAZ6zgEn79r5GJFkyA7OA4pRGLtZl505p1s8JOuaGX/aDPM9Dm1g/tk7PNKh+6x2b
 urXZRqwjzwEyyeq0/IkDWjgYoaE/NqhQzW4bhTWjw2ImEb0Xqh6z9kYhIhITVV0xNjp8
 lnxHQRx8L6yOQIJvkdgsrKv22VFoNqLFw0lErYCcSeP3tfsOoDBLbr4bxxwXZS1PU6XX
 TTR0zRUmZfhoVMkiHL6Uc/+YHB9YrcNiSW9D5tA4Twl5BejP9FhBIFA6tCXCTK7WcDh4
 Y43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785158209; x=1785763009;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1GzRicd67PSCqJGIMiq4Ufv206kn0KFMDSLYsAkX4MM=;
 b=M1VaoPQnh843WrXaeXY24otZjeN28niz7dtX89sw/fOP1WyPU+XcS9mr2xkXm7iERL
 72usF8E98929zbknEEatLZu4j31X+Xrs76KZgICwoM8IPZtyVi6Oy22nwtmD/cbO42PO
 PllzqdHMljdLgu07Nrg/mcwC/MaIkmSQMViKhdiwj/FjY59AsPwtSZS8zmOSQNxdT2mQ
 PJDI+6HJ8Cxbp5AjS9WE2TeiTXtbEcEfTSl1G90uV/Z2+cHLQ0E6DQhMAo5bAJiX5Asm
 WFMmUR9A6c1D72SvuvTvgkp6wAjYBwovRlcl/+hqlaxwBF8tQ5WvZUyN+1bt7RvvgW+i
 b9TA==
X-Gm-Message-State: AOJu0YwT2KOj3XDwoQk89geQAzMNEJ8+mWWQSUVZHQ0qK1ctMyeYtvRD
 nFd61XoUAa970fqXj2cb52qxmeYNUUhoSmZmZ/HYX6n6s8R4LDSm1yfmxveQFRqmcKqfduf8pQT
 E6QLtprLjRZVvWw38N7Sni/h5cVsRmedT69gILr+W8yhzB773WWEsGu6S
X-Gm-Gg: AR+sD13Mf7DUwJjndxfInuZgotrxM9BQ83AMldv0dnsTiDGXnxoZhNZnPGLmt+tEIz9
 y290qQY9uyzNeDtnhapJ95Nr1Zg2t8YNMzKVuRsxK23ZHUOGXMqO2fjMm9Wbj+yehB6n16y+V3m
 YKlUf74Lw8g1fky91AqeZFEUXjOWsnxRBSYhPeUMQIOtlaC5iFVrSWroGIx6KkVdAhKUbsr/qBY
 8FvDRallCKRxoabv7VxtG16hVFag3XzSu+H9tdZm8crIdSpLJA04ec/0PrQxGD9X4Sg4KJuh2Zw
 9pI9o0Mvj4Qjt51XEyRHzATD7b7J846eoKE+c2jOSS7SJXHdhlwp2PpxPAUy5tsVMG3ayYD3i2J
 eahCBq+nUco5lOPO8z3w1Vg==
X-Received: by 2002:a05:6000:178b:b0:47f:6983:c0fd with SMTP id
 ffacd0b85a97d-47f9feaf242mr10306985f8f.48.1785158208792; 
 Mon, 27 Jul 2026 06:16:48 -0700 (PDT)
X-Received: by 2002:a05:6000:178b:b0:47f:6983:c0fd with SMTP id
 ffacd0b85a97d-47f9feaf242mr10306934f8f.48.1785158208251; 
 Mon, 27 Jul 2026 06:16:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96d4656bsm32113476f8f.21.2026.07.27.06.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:16:47 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:16:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH] vhost: Reject oversized inflight migration buffers
Message-ID: <20260727091628-mutt-send-email-mst@kernel.org>
References: <CAHntc+O1jaJhj1_k6kTHDp7u_1DdPUCKZNA_AxWYh+SKraXS8A@mail.gmail.com>
 <20260727084637-mutt-send-email-mst@kernel.org>
 <CAHntc+OJ+KMaW_rxXCFn7RjHmBHnp7=q-9TiC_P1HbqfRBhtvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHntc+OJ+KMaW_rxXCFn7RjHmBHnp7=q-9TiC_P1HbqfRBhtvA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 27, 2026 at 06:02:26AM -0700, 김승중 wrote:
> Thanks Michael. Understood.
> 
> The pre_load check was intended as an immediate mitigation, but I see
> that it does not address the VMSTATE_VBUFFER_UINT64 type confusion in
> the common load and save paths. I will defer to the generic vmstate
> fix and will not resend this patch.
> 
> I included "Fixes: CVE-2026-6426" because Mauro requested that exact
> trailer when the CVE was assigned. I understand that under the current
> QEMU security policy, vhost-user-backend-originated issues are treated
> as hardening bugs rather than security flaws.
> 
> Could you please retain the following credit on the final fix?
> 
> Reported-by: Seungjung Kim <seungjung0711@gmail.com>

Indeed, my apologies for missing that.

> Sorry about the unrelated whitespace change.
> 
> Thanks,
> Seungjung
> 
> 
> On Mon, 27 Jul 2026 08:48:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jul 27, 2026 at 05:45:47AM -0700, 김승중 wrote:
> > > The inflight buffer size is migrated as a uint64_t, but vmstate_size()
> > > reads VMS_VBUFFER sizes as int32_t. Values above INT32_MAX therefore
> > > become negative and are converted to a very large size_t while loading
> > > the buffer, allowing writes beyond the smaller memfd-backed mapping.
> > >
> > > Reject sizes that cannot be represented by vmstate_size() before
> > > allocating the destination buffer.
> > >
> > > Fixes: CVE-2026-6426
> >
> > This CVE really shouldn't be there.
> >
> > > Reported-by: Seungjung Kim <seungjung0711@gmail.com>
> > > Signed-off-by: Seungjung Kim <seungjung0711@gmail.com>
> >
> > This doen't fix it properly, it only fixes values 2g to 4g, but above 4g
> > is still wrong.
> >
> > A better fix here:
> > https://lore.kernel.org/all/9e2d0b03a60642236e6df8edde7b3562f5f9849f.1785101237.git.mst@redhat.com/
> >
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index af41841b52..82eb9407ae 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -2022,11 +2022,18 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
> > > static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> > > {
> > > struct vhost_inflight *inflight = opaque;
> > > -
> > > int fd = -1;
> >
> > pls don't make unrelated changes like this.
> >
> > > - void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > > - F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > > - &fd, errp);
> > > + void *addr;
> > > +
> > > + if (inflight->size > INT32_MAX) {
> > > + error_setg(errp, "inflight buffer size %" PRIu64
> > > + " exceeds maximum %d", inflight->size, INT32_MAX);
> > > + return false;
> > > + }
> > > +
> > > + addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > > + F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > > + &fd, errp);
> > > if (!addr) {
> > > return false;
> > > }
> > > --
> > > 2.50.1 (Apple Git-155)


