Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BDCCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzUm-0006lh-KF; Fri, 12 Sep 2025 04:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzUg-0006k5-Cx
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwzUX-0006w4-GD
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757667045;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kTTrgn8+m0gcU8RSJaIG22p2M4IDAeIMXkilwpOuXhQ=;
 b=a5aRKLFkX1Uql1wxGEk3bdcPqtWGabgLARDmPkTi1OsEY6KZENUdd4dIWm15sSjn90XovW
 HsWv77Y2+N9c8Ag1vlgjXgEUV0Fj6O90ZMaIVwdNBT/ng0I2jWP2le3dK9nNwRak81bDs/
 Q3fxvfuIUnUwv6T1S5SQr6Mstq+7cCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-NTS6gpj_OeS-A6_3T3-FiA-1; Fri,
 12 Sep 2025 04:50:42 -0400
X-MC-Unique: NTS6gpj_OeS-A6_3T3-FiA-1
X-Mimecast-MFC-AGG-ID: NTS6gpj_OeS-A6_3T3-FiA_1757667040
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 137BB1800295; Fri, 12 Sep 2025 08:50:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8EE180035E; Fri, 12 Sep 2025 08:50:34 +0000 (UTC)
Date: Fri, 12 Sep 2025 09:50:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
Message-ID: <aMPe1vB3cZAlNBq1@redhat.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912042910-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912042910-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 04:41:02AM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 12, 2025 at 05:39:45AM +0200, Filip Hejsek wrote:
> > The goal of this series is to have a resizable terminal into a guest
> > without having to set up networking and using, e.g. ssh.
> > 
> > The virtio spec allows a virtio-console device to notify the guest about
> > terminal resizes in the host. Linux Kernel implements the driver part of
> > the spec. This series implement the device part in QEMU.
> > 
> > This series adds support for a resizable terminal if a virtio console
> > device is connected to the stdio backend.
> > 
> > This series also introduces resize messages that can be sent over QMP to
> > notify QEMU about the size of the terminal connented to some chardev.
> > In the libvirt setting, it will allow to implement a resizable terminal
> > for virsh console and other libvirt clients.
> > 
> > This patch series was originally authored by Szymon Lukasz and submitted
> > to qemu-devel about 5 years ago. The previous submission can be found at
> > <https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09591.html>.
> > I have updated the patches to be compatible with latest master and made
> > a few small changes of my own, including the addition of Windows support.
> > 
> > Probably the most important change I made is the swapping of rows and
> > cols fields in resize messages. I would like to hear some feedback on
> > this change from reviewers. The problem is that for a long time, the
> > Linux kernel used a different field order from what was specified in the
> > virtio spec. The kernel implementation was apparently merged around 2010,
> > while the virtio spec came in 2014, so when a previous version of this
> > patch series was being discussed here on this mailing list in 2020, it
> > was decided that QEMU should match the Linux implementation, and ideally,
> > the virtio spec should be changed.
> > 
> > However, recently, the Linux kernel implementation was changed to conform
> > to the spec: <https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c7056ddd>.
> > As a result, to be compatible with latest kernel releases, QEMU needs to
> > also use the field order matching the specification. I have changed the
> > patch to use the spec-compliant order, so it works correctly with latest
> > kernels now.
> >
> 
> Well this is not in any release yet. If you want me to revert that
> one, let me know ASAP. Maximilian?
> 
> > That leaves the issue of older kernels. There are about 15 years' worth
> > of kernel versions with the swapped field order, including the kernel
> > currently shipped in Debian stable. The effects of the swapped dimensions
> > can sometimes be quite annoying - e.g. if you have a terminal with
> > 24 rows, this will be interpreted as 24 columns, and your shell may limit 
> > line editing to this small space, most of which will be taken by your
> > prompt. The patch series in its current form provides no way to disable
> > the console size functionality,
> 
> Well I see the console-size property, no?

At least in the case of libvirt managed VMs, this series does
nothin by default, as they won't be using the 'stdio' chardev,
they'll require libvirt to first wire up the new QMP command,
and then apps using libvirt to call it. So in that sense, it'll
take a while before the effects are seen by users.

> > so users may end up worse off than if
> > the functionality were not implemented at all.
> 
> If we want to keep the Linux patch, the straight forward way is to send
> the fix to stable@ then poke at Debian at al to fix their kernels.
> 
> Another option is to make the property default to off, have
> management turn it on when guest is up to date.
> 
> But it really sounds like we should revert that Linux patch.
> I posted a revert, pls comment.

What about other non-Linux guest OS that may have correctly
implemented the virtio spec ?

At least FreeBSD appears to /not/ implemenmt resize at all:

  https://github.com/freebsd/freebsd-src/blob/main/sys/dev/virtio/console/virtio_console.c#L884

Do we have a Windows impl of virtio-console with resize support ?

Any other places we should check ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


