Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0954D58083
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXpM-0000Fh-Id; Mon, 25 Nov 2024 07:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFXpI-0000Dy-Vl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFXpG-0007wu-JX
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732536261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z2iBgcRwel9ZakfsjZUfLk742grt325jekiKIbw6kDY=;
 b=dG381QP4PSPxQrb561BxiRWt6gqitxbJ/UfC+xjhPbczBsBUOtmdE6JaH+w9NvA4mN37MC
 D2IhMji9NuwPd2iuz0+Cn+OUqH0WLBJsII7OtqS2kYfpIuqn0fX4hC2rI9fuD7/ypP2xk/
 0FLCGJ1oBAIeQeJUahYn/kB0LXkG9Gg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-BO-dZT_vPOew4-wT9SQvPA-1; Mon,
 25 Nov 2024 07:04:18 -0500
X-MC-Unique: BO-dZT_vPOew4-wT9SQvPA-1
X-Mimecast-MFC-AGG-ID: BO-dZT_vPOew4-wT9SQvPA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06C7D19541A0; Mon, 25 Nov 2024 12:04:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0FBA1956052; Mon, 25 Nov 2024 12:04:12 +0000 (UTC)
Date: Mon, 25 Nov 2024 12:04:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: ankeesler@google.com, mst@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
Message-ID: <Z0RnuVKPHO1T2BfV@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017215304.3916866-3-roqueh@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 17, 2024 at 09:53:04PM +0000, Roque Arcudia Hernandez wrote:
> From: Andrew Keesler <ankeesler@google.com>
> 
> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identification
> Data) is propagated by QEMU such that a virtual display presents legitimate
> metadata (e.g., name, serial number, preferred resolutions, etc.) to its
> connected guest.
> 
> This change adds the ability to specify the EDID name for a particular
> virtio-vga display. Previously, every virtual display would have the same name:
> "QEMU Monitor". Now, we can inject names of displays in order to test guest
> behavior that is specific to display names. We provide the ability to inject the
> display name from the display configuration as that most closely resembles how
> real displays work (hardware displays contain static EDID information that is
> provided to every connected host).
> 
> This new behavior must be enabled by setting the edid_name boolean property on
> the display device (it is disabled by default).
> 
> It should be noted that EDID names longer than 12 bytes will be truncated per
> spec (I think?).
> 
> Testing: verified that when I specified 2 outputs for a virtio-gpu with
> edid_name set, the names matched those that I configured with my vnc display.
> 
>   -display vnc=localhost:0,id=aaa,display=vga,head=0,name=AAA \
>   -display vnc=localhost:1,id=bbb,display=vga,head=1,name=BBB \
>   -device virtio-vga,max_outputs=2,id=vga,edid_name=true

Looking at this again, I'm thinking that it modelling this the wrong
way around.

On the QEMU side, we have a many<->many relationship between guest
display devices and host / remote display outputs.

If we assume every host / remote display output corresponds to a
separate "window" though, then we can reduce that down to  a
many:one relationship between host outputs and guest devices.

Consider this valid config:

  $ qemu-system-x86_64 \
     -vnc :1 \
     -spice port=5902,disable-ticketing \
     -display gtk \
     -device virtio-vga,max_outputs=2,id=vga

All three display outputs show the same guest display, so which
of VNC, SPICE & GTK would the virtio-vga EDID data take its names
from ?

IMHO, the name is a property of the virtio-vga "output" and the
various display backends should be honouring what that tells them
ie your configuration above should instead be:

   -display vnc=localhost:0,id=aaa,display=vga,head=0 \
   -display vnc=localhost:1,id=bbb,display=vga,head=1 \
   -device '{"driver":"virtio-vga",
             "max_outputs":2,
	     "id":"vga",
	     "outputs":[
	       {
	          "name":"AAA",
	       },
	       {
	          "name":"BBB",
	       },
	     ]}'

..whereupon we have to feed the EDID name from the device back to VNC,
so VNC can tell the client of the head name.

Note, I'm intentionally using JSON syntax for -device here, to illustrate
handling of non-scalar properties.

The set of active outputs can be turned on/off at runtime. We can declare
that the user should give names for every output at startup, upto whatever
they said for "max_outputs". That way a name is available even when non-
primary outputs are later turned on at runtime.

The secondary reason why I think names ought to be handled with -device
is that this is guest visible data, and as a general rule we aim for all
guest visible data to be controlled via properties on the frontend, and
not have the backend directly change what the guest sees.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


