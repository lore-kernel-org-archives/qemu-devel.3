Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C4CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY1T8-0003kY-HP; Fri, 12 Jun 2026 08:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1T5-0003jv-5r; Fri, 12 Jun 2026 08:58:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wY1T3-0006Sl-CJ; Fri, 12 Jun 2026 08:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=5rBYs/HHIm4y/csun9bEP5nLvmtERZGT6ES+fZMlzpI=; b=dgfEGnnvO2o4mSLYqvbL6EZlDR
 qkofI3DaZpi1Wy63cokHVZ9ouFD0Y/FfqSx5qgCzjnp1XvGJC8Ja3kKOpvApO6ot/7nsm3hi96V/X
 QloN5KD0aAeysaCZTAUr39ya8Jp+szzLKK/NhDqry0MeJ0GUVcETCZZs5D9schQ3zY+R4zPEPzqNh
 KWUtn4nQX+2NSYKwHfEO9hChgYqfGII4G3dgDFrX+vYYmWx6+K4TDXNRrrIWifSicu3iRYdLmnoRP
 4sED9FFMeSCoB9wjNWi5E5gzK/mEBab5Yew96XFHi2Sm0qYXhLY55xDl1E0UCPCNlZuqw7Mlgc51v
 6Tclm0x2tJfAl/JJeurE5NDsb8FikkTCi6xXnnIDd1r/v4TPfZjbTr11975FU/sv8xKUGFiXGIxo2
 Z4Nlc2t7ez6DtVhDmlpUsr9jtpb42rIfhnGPzPEMEVMO1ts6BFnTqGT146K0e4a2ykAMalctxe7qm
 0I0l/XZoTDlWUGsjPLAaHVfgptH0BMCFyanj9L0PaQyK+kzZb5bqmdtOikPgI1hA+/y4gxDBgspCF
 bYG1KyJC5msqfvYvzQH9w/xaVS+2THtSXQabxRAhkatC90Yb3Mnx45d1VYYRHmeMkzjiIG+6pwNZh
 d2JfAOW7g/cGsGG2yYbtmjsykmSqM3sr3SP4l9Vys=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Feifan Qian <bea1e@proton.me>, Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 7/8] 9pfs/xen: implement response_buffer_size callback
Date: Fri, 12 Jun 2026 14:58:33 +0200
Message-ID: <4740637.LvFx2qVVIh@weasel>
In-Reply-To: <alpine.DEB.2.22.394.2606111710000.368315@ubuntu-linux-20-04-desktop>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
 <95ab978f1919cf91ea1f2a5de6c870e30e420b32.1779916560.git.qemu_oss@crudebyte.com>
 <alpine.DEB.2.22.394.2606111710000.368315@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 12 June 2026 02:23:15 CEST Stefano Stabellini wrote:
> On Wed, 27 May 2026, Christian Schoenebeck wrote:
> > Add and implement the response_buffer_size callback for the Xen
> > transport.
> > 
> > Returns the size of the response buffer from the rings in_sg, as limit
> > for 9p server while generating a response for supplied PDU.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/xen-9p-backend.c | 11 +++++++++++
[...]
> > +static size_t xen_9pfs_response_buffer_size(V9fsPDU *pdu)
> > +{
> > +    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
> > +    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
> > +    int num;
> > +
> > +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, 0);
> > +    return iov_size(ring->sg, num);
> > +}
> 
> xen_9pfs_init_out_iov_from_pdu and xen_9pfs_init_in_iov_from_pdu
> allocate ring->sg, but it would seem xen_9pfs_response_buffer_size could
> be called before xen_9pfs_init_out_iov_from_pdu and
> xen_9pfs_init_in_iov_from_pdu, therefore ring->sg could be NULL here.
> 
> If we do it this way, we avoid the NULL dereference.
> 
>    struct iovec in_sg[2];
> 
>    xen_9pfs_in_sg(ring, in_sg, &num, pdu->idx, 0);
>    return iov_size(in_sg, num);

Good catch!

/Christian




