Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6ACCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMJ9-0005uq-AE; Wed, 24 Jun 2026 08:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcMJ6-0005ua-I9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcMJ4-0005cc-Ul
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782302532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZrC/T7uNAYFmaiqHXFMJfPrxLB8p29wu6xtKuyilIM=;
 b=AAyeswBuExNESkMicM1zo8ShviWc5TvuT9Z1tc/re26gOyWluiaeDIPMIHgMUpgJJ9rcsV
 Mb11f7R6i1efCd1FJu4p00+PsPX9Y1EybHdgDBGdRL04hREtfVz8I4Y7sSJEE6xe3OzFuK
 M7iyuWDgktVKiGx9muNyxu2DlY4nNkU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-6U-EGeK1OsGEoGojFMpf9g-1; Wed,
 24 Jun 2026 08:02:11 -0400
X-MC-Unique: 6U-EGeK1OsGEoGojFMpf9g-1
X-Mimecast-MFC-AGG-ID: 6U-EGeK1OsGEoGojFMpf9g_1782302530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD15180266D; Wed, 24 Jun 2026 12:02:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47B8F1800351; Wed, 24 Jun 2026 12:02:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1CB33180078A; Wed, 24 Jun 2026 14:02:08 +0200 (CEST)
Date: Wed, 24 Jun 2026 14:02:08 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alex Graf <graf@amazon.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
Message-ID: <ajvDMzTGk91aJl9d@sirius.home.kraxel.org>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
 <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
 <602FAB73-36A1-41A0-97AA-7541102F23A4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602FAB73-36A1-41A0-97AA-7541102F23A4@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> > I'm wondering whenever we should better keep the original file, so we
> > have the option to switch back.
> > 
> > With a boot workflow like this ...
> > 
> >  (1) boot qemu firmware
> >  (2) some efi app loads igvm with guest firmware + kernel
> >  (3) reset
> >  (4) boot guest-supplied firmware
> >  (5) guest-supplied firmware boots into the bundled kernel
> >      (without even looking at the ESP).
> > 
> > ... you are now in a situation where the guest can't load a different
> > IGVM file (say with an updated kernel) using the same workflow.
> 
> Why? Why would the fw-cfg interface not be used again to reset to a new IGVM that loads a new kernel?

The guest has no access to the qemu firmware so resetting to that (to
get the process start at (1) again) is not so easy.  Certainly harder
for the guest that for qemu doing it (or offer the option to do it via
some control bit).

The other option would be to have some linux driver for this allowing
linux tools (instead of an efi app or bootloader) loading a new igvm
file on kernel package updates.  Implies we'll need two different ways
to load IGVM files.  I'd much prefer not doing that.

> >> +++ b/include/hw/misc/vmlaunchupdate.h
> > 
> > I think it makes sense to have two include files, one for the API and
> > one for the qemu internals.
> 
> Where would you put the api header file?

standard-headers/misc/ looks good to me.

> > .. instead of signaling success indirectly by clearing fields.  There is
> > room anyway right after the version field.
> > 
> >> +    uint64_t fw_image_addr;
> >> +    uint32_t fw_image_size;
> > 
> > uint64_t?
> 
> I would leave this as 32 bits. 64 bit idvm file size is too big, no?

With u32 we'll get 4 bytes padding, so we do not safe any space in the
struct.  Also initrds can be quite big, the standard anaconda install
initrd for fedora 44 is 252M, this is not *that* far away from 32bit
max.  Also you never know what people do once they have the opportunity.
It certainly is possible to build igvm files loading your complete
multi-gigabyte workload into memory, verified by launch measurement,
then run it without ever accessing disk storage.

take care,
  Gerd


