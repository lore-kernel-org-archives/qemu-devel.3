Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58BCD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPnh-0003sD-2f; Fri, 05 Jun 2026 04:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wVPnd-0003rM-K9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wVPnb-0003iG-VB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780647661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYSrTba8hJjR+mnUCveYd8ESYYg3mUGLDjQDDvfC+2A=;
 b=XC+vcTytHW7N0aV10hoSsu8T9ufg4+KSY4l5zTTWN1eK5EU9Xvphu4MYQ5YpJlSiy868k1
 9TlqzS+rU6GJ7te4iKXVf3BVSURwb487cGgXjeFjgIh9CCE5z2GDJyIx4ul+hDYO9VjTyO
 fMHhsDzDmr+fgzx+a5MhVcj5CFGF9u8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-6e5EZQF5P8SEoCI4cRr8GQ-1; Fri, 05 Jun 2026 04:20:59 -0400
X-MC-Unique: 6e5EZQF5P8SEoCI4cRr8GQ-1
X-Mimecast-MFC-AGG-ID: 6e5EZQF5P8SEoCI4cRr8GQ_1780647658
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eec2ba533so1070010f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780647658; x=1781252458; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AYSrTba8hJjR+mnUCveYd8ESYYg3mUGLDjQDDvfC+2A=;
 b=LgVekR+QTIQz5ez7wgZbn1qI5hhn6yrEHIWKSKVFrKFe/5fd6H1hv37rEJeWpfat5l
 7v2uWKuw/bqIYeM0pbC/dF5AknrAb5KJv1SHOOSHHG52LrA76pDDVSa2O1uq4xlmjH1h
 nX7P6Mi9/a1lrU2/+wTK+ETS9nY+10EIkKDIEVKUHNrArwBRdD6RBp+RSOnCNBHz6KGs
 6c59PYDcR0UKbQ43GMLlydhlPH8E1fJrRUFoAwLj3AU51JVok97TXl0jEbOEYx5QPaog
 XKDi9HUc6VJiArGPn9pvrKEGtUxNn3sipU1obhOlLmwnjJnEMQ6K5J/WTO7s2S5QEkpu
 13XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780647658; x=1781252458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYSrTba8hJjR+mnUCveYd8ESYYg3mUGLDjQDDvfC+2A=;
 b=SyaG/upD+w6u1eSgWKBRyFDezFo8pN5Lspu8y27UBYzD/9NOstSVgW4cAnpbeJeKWm
 4pVVwaUSPa0ZgFfwdIQ1N3GdsvTGFMlUEhjcusWY9OZY33ra75103TaDlzZ7HDSth9IR
 hNE9O6IakmMwqO/KTSTpYOJy8/cCL4EAFObsPl5S7bxecO+nWEPXzVkpo+hAu7AndLue
 xDTdcxvOJsys2WVLBREL3qq2og86b+jWFNd+Kvbg4qTnn33Rc/4bsZIfI61nm3PLSbzd
 X9eh8POGY6ZnEhXLhARiBNoAKSbHWMNptWFrq6NXmJULiwk8N3zE4MnsjJBlX1vh9KE6
 Ql/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fI2hPY3nQMOROT9uGcrihlNVIndWB63Csi7eaghq2kml2uAQvtraVGwJSzRNQLLQ+NL7kIUFP8KvB@nongnu.org
X-Gm-Message-State: AOJu0YzPb0jzSO4rCS2jIptzCBalSE7jLBrjt9+Zut6tNGoZiQ1lc19U
 uC8vovrA72St3c0Xt++kHiuM4hgrPTLsIvTTke3D8hsK+arvQvcngM7Zg3E2y5FT7jGFwIMMe+S
 ttBj05CScQI/zkpGshXLjST6E9PHzfuSP5ItL/pTEDFGqvyOEUJEjpcFK
X-Gm-Gg: Acq92OEjhx5RZjpw39qjqPthkHERxHkEoc+F6TvNl/ayx0Mwb12YHmYvU2KP67hwh2Z
 Thb1RvflgKUh27U4gZIPRO9dm6915aZVtr5ZVY9y8cwarquJHvIFLJb38aZ3OjnyJ2fWeHzWcqn
 CgHEaf7su74kxqThxI1Wi6lOEfQoF3FIA1KeV/2eR/cpdZrnZ0+k2CV0aCWs6dtagGL2NgYTpZH
 mZ2HfGoRcM8pFu3CKY9AaPmQsbP71JT2+ZjuD2lejM8rpCdymR/F6pjaAFDsXdGbWqrf5egwC+9
 om/w8FJSiHIGJCDoYog6aAMWgl2DfBe3eOvRpa9wjUij/tRQ6KqmbvzblL7jXyE+zexJ2OVJ3Ey
 gl3jm8Zu3vD5i2hXYPVVKniSh0/7le+k4DtVyZQ2WoSOG3eUFf3ciU/EfVEJZa5Zf6zxB4/+W5V
 2PD4pt1g==
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id
 5b1f17b1804b1-490c2a3abf2mr22957815e9.34.1780647658291; 
 Fri, 05 Jun 2026 01:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d0:b0:490:c2a3:abae with SMTP id
 5b1f17b1804b1-490c2a3abf2mr22957235e9.34.1780647657733; 
 Fri, 05 Jun 2026 01:20:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d66c8sm127960485e9.10.2026.06.05.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 01:20:57 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:20:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2 34/38] MAINTAINERS: Drop stale F: from "Linux io_uring"
Message-ID: <aiKGgo6chvFrUcbL@sgarzare-redhat>
References: <20260603064032.3733394-1-armbru@redhat.com>
 <20260603064032.3733394-35-armbru@redhat.com>
 <aiF6lwircL8PCske@sgarzare-redhat> <20260604142919.GA115597@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604142919.GA115597@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 04, 2026 at 10:29:19AM -0400, Stefan Hajnoczi wrote:
>On Thu, Jun 04, 2026 at 03:17:52PM +0200, Stefano Garzarella wrote:
>> On Wed, Jun 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
>> > We neglected to update MAINTAINERS when we dropped stubs/io_uring.c.
>> > Update it now.
>> >
>> > Fixes: 047dabef97 (block/io_uring: use aio_add_sqe(), 2025-11-03)
>> > Cc: Julia Suvorova <jusual@redhat.com>
>> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > Cc: qemu-block@nongnu.org
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> > MAINTAINERS | 1 -
>> > 1 file changed, 1 deletion(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 71383b9807..c5b6985767 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -4331,7 +4331,6 @@ R: Stefano Garzarella <sgarzare@redhat.com>
>> > L: qemu-block@nongnu.org
>> > S: Maintained
>> > F: block/io_uring.c
>> > -F: stubs/io_uring.c
>>
>> Should we add `util/fdmon-io_uring.c` in this list ?
>
>No, this section is under "Block drivers" and is specifically for qcow2,
>iscsi, raw, etc.

Oops, I missed we have sections in the MAINTAINERS file. I thought this 
entry was a generic one for io_uring support in QEMU.

>
>util/fdmon-io_uring.c is covered by util/fdmon-*.c in "Block I/O path",
>which is where AioContext and QEMU's event loop lives. 

Okay, makes sense to me, thanks for the clarification.

> The name "Block
>I/O path" is not the best fit anymore and maybe it should be changed to
>"AioContext event loop".

yeah, I agree.

Thanks,
Stefano

>
>>
>> BTW this is unrelated to this patch that LGTM:
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> >
>> > qcow2
>> > M: Kevin Wolf <kwolf@redhat.com>
>> > --
>> > 2.54.0
>> >
>>



