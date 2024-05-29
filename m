Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2B6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 11:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCH2M-0002rO-Gn; Wed, 29 May 2024 07:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCH2L-0002r5-45
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCH2J-00048S-I2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716980401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pRFLYBG9LjHe5dycymnUkyieEMP80peH2j2K8ESFoGA=;
 b=QGVogdLYnq13witZGDmQeBAB/m2H2bE3NlWpyWD7xTKmd2k/0a/jdlrF0fuGhCL2QP/KA0
 qM1ZTchsq1CFgAJHbmTWO1PtgN1h6jLA3NQzUWt4oJcMIOtFRXkFWnWrQD3rGtBsR/qm2E
 tQrnzuvgTb9kz8DF4LK0KZLRLMGz4bk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-V7R5TyddNDuHakLnO_tWrg-1; Wed,
 29 May 2024 06:59:54 -0400
X-MC-Unique: V7R5TyddNDuHakLnO_tWrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 771F41C0512D;
 Wed, 29 May 2024 10:59:54 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAA18C15BB1;
 Wed, 29 May 2024 10:59:52 +0000 (UTC)
Date: Wed, 29 May 2024 12:59:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Jin Cao <jojing64@gmail.com>, Ilya Dryomov <idryomov@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de,
 hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
Subject: Re: block snapshot issue with RBD
Message-ID: <ZlcKp6gdIFdSsi_X@redhat.com>
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
 <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
 <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
 <CAOi1vP8nJVsvvsmG5Ac4sd+9NPA8v8t=7Sao0f7-qNb129p=OA@mail.gmail.com>
 <fb2ea759-1a7e-4c0e-ab0d-3ec4c04dc503@gmail.com>
 <5993acdc-f8ec-4fa8-bb97-952c3a56ae6d@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5993acdc-f8ec-4fa8-bb97-952c3a56ae6d@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 29.05.2024 um 12:14 hat Fiona Ebner geschrieben:
> I bisected this issue to d3007d348a ("block: Fix crash when loading
> snapshot on inactive node").
> 
> > diff --git a/block/snapshot.c b/block/snapshot.c
> > index ec8cf4810b..c4d40e80dd 100644
> > --- a/block/snapshot.c
> > +++ b/block/snapshot.c
> > @@ -196,8 +196,10 @@ bdrv_snapshot_fallback(BlockDriverState *bs)
> >  int bdrv_can_snapshot(BlockDriverState *bs)
> >  {
> >      BlockDriver *drv = bs->drv;
> > +
> >      GLOBAL_STATE_CODE();
> > -    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
> > +
> > +    if (!drv || !bdrv_is_inserted(bs) || !bdrv_is_writable(bs)) {
> >          return 0;
> >      }
> >  
> 
> So I guess the issue is that the blockdev is not writable when
> "postmigrate" state?

That makes sense. The error message really isn't great, but after
migration, the image is assumed to be owned by the destination, so we
can't use it any more. 'cont' basically asserts that the migration
failed and we can get ownership back. I don't think we can do without a
manual command reactivating the image on the source, but we could have
one that does this without resuming the VM.

Kevin


