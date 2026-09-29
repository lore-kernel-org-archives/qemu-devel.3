Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C84CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBdPx-0005Y9-GM; Tue, 29 Sep 2026 15:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBdPm-0005Tl-K7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBdPh-0006GI-Rf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790709771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nkQawFi870blXokLMMTBCs2OhJlO/jCjlLq88b+hS9M=;
 b=CEG7JTtrYe4IFelMtW2EbOk1qVD6+7Ka5jrraycvhqTPOUsGsFGuRVPrN3qlnhIrYHUoQi
 9ilrV6phke19t4ZSVGrUF3aIX9nz55Rq5zSbdfr6de3IImisABkDTFs5wt4VfT42Q9Wmdq
 fNGGMkJ+51DVfrIhL6KkNw3pS3cCxug=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-QMGk61nIN6m4rmeHcqzkjA-1; Tue, 29 Sep 2026 15:22:49 -0400
X-MC-Unique: QMGk61nIN6m4rmeHcqzkjA-1
X-Mimecast-MFC-AGG-ID: QMGk61nIN6m4rmeHcqzkjA_1790709769
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53333acddb5so85944061cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790709769; x=1791314569; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nkQawFi870blXokLMMTBCs2OhJlO/jCjlLq88b+hS9M=;
 b=fAkG7TNhGIyIahQloX/WB/NQbDubrOWsCQG8Bghzsa8qKO2Rwcy8VATuTS7wEnPWc2
 YnjERQSk3SoLFu/28B0jJDG+UhkrDT/Xc34udq9Ugoe9tEFWkZU2cESVoACCgOQzeUUV
 vrKoqKcYLE/XeuYAR6MBTp3TxlpYiRk/uDDJPHNnBsvfGtczAcB2X7PSHwcUB7wnjOLL
 2Vy+6EfwsGckr135oDHeTHkoPQteWAyhNGAUSyp5C24gxWdjTv7CwTY+YfLBM/2ozE69
 f1kCI4dkKSB57h2A0g4bwYNgW8njq+TtrAeu8l2x9zB6zXYiP9Of/kiY3cxHOapwJGYQ
 MLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790709769; x=1791314569;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nkQawFi870blXokLMMTBCs2OhJlO/jCjlLq88b+hS9M=;
 b=MeFLqSWLWeygxwZX/NhfPeYfFU7FEGlYMJowanO5NUQJOXzQzfW57nGHT8z0S1YKqq
 cCaCkhxBXm5jf2BUEPgK838jrOly/wJbFP96fYfVCZwgY2nEM8Gztio6cZt7+bY5S3xL
 cqvns8ywh1wNjbkTY3Q1ixYY4FYc8oaz/VsfhfDTe/qAnnm2//NOq8yqMTCnrYVtehjt
 bwUNHtGV/+mNtbsFrIp37F9seff731OcnF6cPt9Usglt2pZgqtLvqw/0cAx4oK+X1KVf
 EIPDT45gkg8ZXdrsaO8+cunKtms+qAXo3VERVDBuNJ+gCIDRoLlGOhgVkq/B5RiZBHfJ
 WI4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMt4ezcXTqb0gidDB02r2WU63BGdVzGxWb6tFDY6JVqJ3owR8suZC3Kr7e9YWV60TyOMPqFOjEeinO@nongnu.org
X-Gm-Message-State: AFuF++n0j3Ixbp0IEK9DwOS85iYo3LQMqvyoGkLF/tmKWchku03uLUPf
 o8BtV7k9SN49eZengoZhQb3ZEv/V0inZq/ymus4JjltkTvlNvX2GXMIuL0CiJUlossBpdEJ5nhU
 yQrQxC0zx5yCN8oi7KMpNRsl5HG1ucoyPY/OK0SBd8Nvs5EcywKAso/43
X-Gm-Gg: AYBFou2uyVucCEuLZuDSxsXUaLWjmu0kfFs2yN3aPUdYiva3pmLx5ix6Kr6x0AkXnPp
 o6zQ1R2FWhJToIePXzceYQZoJwhwFyqZmdc5jQHAznD6J92SiAwGTPHFvrDdNyc4bqx6JyElQae
 9PfRHvnA3rLroxDolkVP122f6fNM6V+zGvKy53m9JNDtc/ILpkKrmNVvR32EvOGbZ/HN+WQ6X2y
 +fqDfAb4dwVKMhGuR4D1Ivv4v032rFeYx+2tLE5USmjFd8XKpabadu/S5WROI+CHXy0E29swW8Q
 8DXpvMSzxjQ0k36MFskT1MgimD7pYI87N2zewISaDs7A2OP0mnkYrXv22Ebn7s6+o/msblU=
X-Received: by 2002:ac8:594c:0:b0:532:e7d4:281c with SMTP id
 d75a77b69052e-5336a394fd6mr4980351cf.24.1790709768775; 
 Tue, 29 Sep 2026 12:22:48 -0700 (PDT)
X-Received: by 2002:ac8:594c:0:b0:532:e7d4:281c with SMTP id
 d75a77b69052e-5336a394fd6mr4979601cf.24.1790709768050; 
 Tue, 29 Sep 2026 12:22:48 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53369bd31besm2421991cf.23.2026.09.29.12.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:22:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:22:46 -0400
From: Peter Xu <peterx@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v8 04/17] migration: forbid snapshots under Xen
Message-ID: <arwQBnGBbCgv8srv@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
 <arwCADGhCZenoYke@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b7d2302dfa4b48480e45423ffaceb93ce2239e7b.camel@infradead.org>
 <arwOl9OvOlXJTtwS@zhexu-thinkpadt14gen5.rmtcaon.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arwOl9OvOlXJTtwS@zhexu-thinkpadt14gen5.rmtcaon.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 29, 2026 at 03:16:39PM -0400, Peter Xu wrote:
> On Tue, Sep 29, 2026 at 07:34:50PM +0100, David Woodhouse wrote:
> > On Tue, 2026-09-29 at 14:22 -0400, Peter Xu wrote:
> > > On Tue, Sep 29, 2026 at 08:23:23PM +0300, Andrey Drobyshev wrote:
> > > > The snapshot RAM-saving path does not support Xen's memory mappings.
> > > > Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
> > > > same way they are refused for CPR migration modes.
> > > > 
> > > > Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > > 
> > > Acked-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Paul Durrant <paul@xen.org>
> > 
> > Hm, but surely if QEMU is running as a device model for a Xen domain,
> > all it should be saving and restoring is that device model. It's then
> > up to Xen and its toolstack to migrate the domain and its memory.
> > 
> > We've had guest-transparent live migration working on Xen, as well as
> > in-place update of QEMU on the same host. Surely all of those require
> > save/load support?
> 
> Looks like I was wise copying more people..
> 
> I knew Xen had qmp_xen_save_devices_state(), I was thinking that is the
> save support wiring together with Xen's facilities.
> 
> I confess I never know what is the load support, and I was taking it for
> granted RAM was managed elsewhere, so load perhaps the same.
> 
> So I suppose this is still a question to the author, or maybe Akihiko?

Ok, I just noticed xen also has @xen-load-devices-state, so maybe this is
the answer. I suppose Xen should be using those, rather than the default
savevm/loadvm.

Note, that what this patch changes (migrate_can_snapshot()) only affects
savevm/loadvm command.

Thanks,

-- 
Peter Xu


