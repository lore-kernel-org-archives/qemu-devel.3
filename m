Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B0FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOAX-0005zK-Tf; Thu, 18 Apr 2024 05:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxOAU-0005xX-7q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rxOAR-00065L-8m
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713432893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d4dZ2y/rP13ikzS1vcqBvFNTPdOo5WlT9AAmnAC/V9Y=;
 b=Eq6h44A0yPxJPxroiauNBbksJfXCOSJstpRUFp5wVHNeisl5880d1TVPOy/B6TWfrPIbKf
 UYoeDH28H+ScAyjeTwHLpV86gKn5Ne7BuJPxA8haBaai3G7+SSDHuth8/mw3A7x6XsytiJ
 8/Ez5rIvvCa5UqGkcy3YVEdKqfLj6DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-SaXS7SrWMuaST_awqHQu1Q-1; Thu, 18 Apr 2024 05:34:47 -0400
X-MC-Unique: SaXS7SrWMuaST_awqHQu1Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DB111044574;
 Thu, 18 Apr 2024 09:34:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B7B492BC7;
 Thu, 18 Apr 2024 09:34:45 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:34:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Kiryanov <rkir@google.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>,
 Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <ZiDpM7ZusU0SvH7K@redhat.com>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 17, 2024 at 12:31:41PM -0700, Roman Kiryanov wrote:
> Hi Daniel,
> 
> thank you for looking into this. I checked how VHOST_USER_VSOCK and it
> refers to the vhost-user protocol. It is implemented in the
> subprojects/libvhost-user library, but this library depends on poll.h
> and linux/vhost.h files. Do you know if it builds/works on Windows?

Stefano recently ported it to work on any POSIX platform,
but obviously that still excludes Windows:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00388.html

I'm unclear what blockers there are wrt Windows, but perhaps
Stefano (CC'd) can advise.

Personally, while I think vhost-user is a good option for the
vast majority of cases, I believe QEMU ought to natively
implement a simple self contained AF_UNIX backend for vsock,
avoiding need to depend on 3rd party software for its use.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


