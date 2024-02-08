Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A604DC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8vS-0001ku-Rv; Thu, 08 Feb 2024 13:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rY8vP-0001ZR-0p
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:15:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rY8vL-0006zn-Aa
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707416097;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3H4EvIXd9aP1wxhPeHwPAYkpz/tGo+Cq3aiHcisBPBk=;
 b=GTz+fLDPLhnS+9G9hi2/KsyiXnTRL1QLZ0jgHm/wPt1FwVdn0vM1NbuTgkTQN+88NIBZY8
 uLBmz2uiYaUEMATR5ti55S4KxsbOe3evsAbCBWQxAVzMdzcUKciAPiJWqk5gWDqc10j0pw
 iZBxZzE6ZHTFlhVZuTNmXKjqIe2ueyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-H67fqmOaPY-0imjjwgtVOQ-1; Thu, 08 Feb 2024 13:14:54 -0500
X-MC-Unique: H67fqmOaPY-0imjjwgtVOQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5DA0830DCE;
 Thu,  8 Feb 2024 18:14:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13C81492BFA;
 Thu,  8 Feb 2024 18:14:52 +0000 (UTC)
Date: Thu, 8 Feb 2024 18:14:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Subject: Re: migration-test random intermittent failure, openbsd VM
Message-ID: <ZcUaG3ACY2fDKhPE@redhat.com>
References: <CAFEAcA8p9BKCrn9EfFXTpHE+5w-_8zhtE_52SpZLuS-+zpF5Gg@mail.gmail.com>
 <87plx6bzo8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plx6bzo8.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 03:04:23PM -0300, Fabiano Rosas wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> +cc Daniel.
> 
> > Random intermittent in migration-test when running the tests
> > in the openbsd VM (i.e. what you get from 'make -C build vm-build-openbsd')
> > Any ideas?
> 
> Where's your HEAD at?
> 
> >
> > 106/847 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
> >            ERROR          157.51s   killed by signal 6 SIGABRT
> > ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> > stderr:
> > qemu-system-x86_64: multifd_send_sync_main: channel 12 has already quit
> > qemu-system-x86_64: TLS handshake failed: The TLS connection was
> > non-properly terminated.
> > qemu-system-x86_64: TLS handshake failed: Error in the push function.
> > qemu-system-x86_64: Failed to connect to '127.0.0.1:23083': Address
> > already in use
> 
> Looks like a legitimate port clash here when doing the TLS
> connection. It seems the test is not prepared to deal with it.

The migration-test.c code always says to listen on ':0' so the
kernel dynamically allocates an address, we when query that
port and connect to it.  So we should never fail on listen/bind
server side.

The error message though is about the client side as it says
"failed to connect".

I've no idea how on earth you trigger "Address already in use" as
a client !

Every outbound connection does require a port, but QEMU always
leave the port on 0, so the kenrel dynamically allocates an
outbound port. Somehow this is failing, but I can't see how
it is QEMU's fault ?!?!?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


