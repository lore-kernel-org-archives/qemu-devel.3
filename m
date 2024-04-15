Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15C5C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwKOM-0006Nj-Cd; Mon, 15 Apr 2024 07:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwKOK-0006HY-HK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwKOI-0001bN-Pn
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713180049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ihlghnHroBa/DBeUjx2g6tVtZiVTglMfn3e2OTOx5tE=;
 b=Zry9JhqBoLardCYInyIZvReiatIJJXwDdkV5/2a63AlD4Io2lL9dFdgUj15QQ0IAUqOZbN
 e8R2gGq/KSUaNRgBsVLgHHaP9XcNpcQGpNRJ5g2YlAGtA7WLt3a+AVNfAwRwGkqM7091dZ
 Tu3jiXK/85upYpb0KAatn3cB7BDDLGU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-QhgFxWoXMS-YLBuJ0oNJIg-1; Mon,
 15 Apr 2024 07:20:47 -0400
X-MC-Unique: QhgFxWoXMS-YLBuJ0oNJIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24D573C10157;
 Mon, 15 Apr 2024 11:20:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F91451EF;
 Mon, 15 Apr 2024 11:20:46 +0000 (UTC)
Date: Mon, 15 Apr 2024 12:20:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>,
 Mehdi Alizadeh <mett@google.com>
Subject: Re: Hermetic virtio-vsock in QEMU
Message-ID: <Zh0NiI9ZfS5uzs5Z@redhat.com>
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On Wed, Apr 03, 2024 at 02:30:33PM -0700, Roman Kiryanov wrote:
> Hi Peter, Alex and QEMU,
> 
> I work in Android Studio Emulator and we use virtio-vsock to emulate
> devices (e.g. sensors) which live in the Emulator binary. We need to run on
> Windows and in environments without CONFIG_VHOST_VSOCK, that is why we
> cannot use vhost-vsock and invented our implementation. I tried to grep the
> QEMU8 sources and I believe virtio-vsock is not available there.
> 
> Do you think it is a good idea to implement virtio-vsock in QEMU (e.g. to
> run on Windows)? If the answer is yes, could you please point where I could
> start to build an upstreamable solution (not Android Emulator specific)? It
> is not clear to me how we should make the device available for clients
> (sensors, modem, adb, etc) in a generic way.

This issue is proposing the idea of exposing VSOCK using AF_UNIX as the
host backend, in a manner that's compatible with that used by firecracker
and cloud-hypervisor:

  https://gitlab.com/qemu-project/qemu/-/issues/2095

Recent versions of Windows support AF_UNIX these days, so hopefully that
would be satisfactory as an approach ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


