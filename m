Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDC3CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGn-0004Sz-FW; Thu, 28 Aug 2025 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uretR-0002Zg-M1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uretK-0003IO-GW
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756396216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aDabViE7kmq5QQOlR4//G1ztLS6JiCNZGP5+NSPQb+A=;
 b=FR+XTj+ac1kzZInGZW9sSGVvUAPTLLsDjEr1ewVv62GIFSBUie0+2NtFMU9DN8rdCnYjDc
 Sl4qdqhDC4dktf36bmzQonxnnIP2nUkOopBCtTqvkTdJQsxUQv/GonjVfiby9AQ6RAfB3D
 qqrMvdWDWGfyqxeeVxB14YMWghuAONk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-sXLUx5LzMqazxijsjnv53Q-1; Thu,
 28 Aug 2025 11:50:14 -0400
X-MC-Unique: sXLUx5LzMqazxijsjnv53Q-1
X-Mimecast-MFC-AGG-ID: sXLUx5LzMqazxijsjnv53Q_1756396213
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29F5718002CD; Thu, 28 Aug 2025 15:50:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.130])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0366B180029A; Thu, 28 Aug 2025 15:50:11 +0000 (UTC)
Date: Thu, 28 Aug 2025 16:50:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Keesler <ankeesler@google.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/display: Support per-head resolutions with
 virtio-gpu
Message-ID: <aLB6sC6qI1RN_dr4@redhat.com>
References: <20250722190824.3419413-1-ankeesler@google.com>
 <20250722190824.3419413-2-ankeesler@google.com>
 <aK8MHGgp-Dm_Lkmb@redhat.com>
 <CAGZECHOL=v50aV0vcCHdFxb69TmH7mXry2NEhu+EZZnWztRO-A@mail.gmail.com>
 <aK81yUqtwoZ9_29l@redhat.com>
 <CAGZECHNkRo=Oejh9CgAAV+Qa8f_PgdhvyOy+rAGNRG29Datt1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZECHNkRo=Oejh9CgAAV+Qa8f_PgdhvyOy+rAGNRG29Datt1Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 28, 2025 at 11:47:23AM -0400, Andrew Keesler wrote:
> > > I think we should probably report an error if xres / yres
> > > are set at the global level and also set against any individual
> > > output, so the two approaches are mutually exclusive.
> 
> > ACK - fixed for the next patch.
> 
> Doh, I ran into an error. Seems like if I don't set xres/yres, then it
> gets defaulted to 1280x800.
> 
> 
> https://gitlab.com/qemu-project/qemu/-/blob/master/include/hw/virtio/virtio-gpu.h#L175-176
> 
> So...could we just get away with documenting that if you set xres/yres
> and outputs[0].xres/yres, then the later is going to overwrite the
> former? I'm not sure how to detect if xres/yres has been set globally
> to 1280x800, or if we are just getting the defaults.
> 
> What do you think?

Oh it probably isn't worth the hassle for a mere error report. Instead
just document that per-output takes priority if both are set.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


