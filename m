Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B79BC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3E6-00050u-QJ; Thu, 23 May 2024 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA3E4-0004xn-I4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA3E2-0004zg-JQ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716450657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JnhNX5l6sv4dYbo3vfAKl8tQbikqXIInNI/jBg7Ni9k=;
 b=XxbpNm+mFkYm8cG03bqMpLCQyenMaLxlYATHXQhpXz01TU3yLvACkZGBfr9kti73zPiSs8
 l3VWUoGZJhqCjIvO9mMgQSJo3H/OuxIc1zI8r3kiltPNbJXLYB3v9hxKw+bNi3NxU19cG2
 7S9lkbe5S3clYxrDW7Mz69uFHdli6rY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-9dXzkvckPBW6n1_83UAnKQ-1; Thu, 23 May 2024 03:50:35 -0400
X-MC-Unique: 9dXzkvckPBW6n1_83UAnKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82A738029EB;
 Thu, 23 May 2024 07:50:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 650FC40004D;
 Thu, 23 May 2024 07:50:34 +0000 (UTC)
Date: Thu, 23 May 2024 08:50:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: Re: [PATCH] qga: Add an interactive mode to guest-exec via VSOCK for
 Linux
Message-ID: <Zk71Bl1tGqkctSwr@redhat.com>
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
 <Zk4Y3mw2DU1KKeGV@redhat.com>
 <3438f0db-120b-493d-ab61-71311699797f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3438f0db-120b-493d-ab61-71311699797f@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, May 23, 2024 at 09:12:51AM +0200, Denis V. Lunev wrote:
> On 5/22/24 18:10, Daniel P. Berrangé wrote:
> > On Wed, May 22, 2024 at 05:06:57PM +0200, Alexander Ivanov wrote:
> > > Add an interactive mode to the guest-exec command in the QEMU Guest Agent
> > > using the VSOCK communication mechanism. It enables interactive sessions
> > > with the executed command in the guest, allowing real-time input/output.
> > > 
> > > Introduce "interactive" mode in the GuestExecCaptureOutputMode enumeration
> > > and add optional "cid" and "port" fields to the guest-exec response. In
> > > such a way user can execute guest-exec command, get CID and port number
> > > from the response and connect to the guest server. After connection user
> > > can communicate with the started process. All the data transmitted to the
> > > server is redirected to stdin. Data from stdout and stderr is redirected
> > > to the client. All data blocks are preceded by 32-bit headers (network
> > > byte order): most significant bit contains a sign of stream (stdout - 0,
> > > stderr - 1), all the other bits contain the payload size.
> > Every patch to 'guest-exec' takes us torwards re-inventing yet more
> > SSH/telnet functionality, but a poor simulation of it. For exmaple
> > this still lacks any separation of stdout/stderr streams, just
> > interleaving all their data back to the host. There is also zero
> > access control facilities beyond turning off the 'guest-exec'
> > command entirely.
> > 
> > IMHO we should really consider "arbitrary command execution" to be
> > something to be handled by a separate process. Let the guest OS admin
> > decide separately from running QEMU GA, whether they want to enable
> > arbitrary host processes to have a trival privileged backdoor into
> > their guest.
> > 
> > systemd now supports exposing SSH over VSOCK, and provides an SSH
> > proxy in the host to connect to VMs, while libvirt also has added
> > its own host SSH proxy to allow SSH based on libvirt VM name.
> > 
> > For windows guests, there is something called PowerShell Direct
> > which exposes PowerShell over vmbus under HyperV. Possibly that
> > can be enabled in QEMU too if someone understands windows & vmbus
> > enough... ?
> > 
>
> That makes a lot of sense. Why to support something that is
> already written. Though I have a note about Windows. The
> approach could be exactly the same - OpenSSH port for Windows
> is already known and on top of that VirtIO VSock driver is
> available too. Why not?

I've not tested it myself, but I would assume (hope) that the Powershell
Direct feature is available in Windows guests "out of the box". The OpenSSH
+ VSock option would require extra user install work. I tend to favour
things which will "just work" without extra config in the guest.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


