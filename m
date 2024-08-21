Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2675C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 18:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgqA6-0006c7-BC; Wed, 21 Aug 2024 14:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgqA4-0006bc-F8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 14:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgqA0-0005xW-Cy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 14:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724265257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBlvvD96RzO0MQrzOLGV6+BJW4QxBoCf12C91mRN7Ec=;
 b=GnUNthju4bxTpXdGGNsggev8Ht9lPFKJF9tvaMDqqRVzChARMb1lpDSMQq6L5oeN+xaGlr
 viwyuu29yL6axKodmopdsOwVf6vbe9P6D6snUYmNBvwbT82ohyPYnj/J1aWO+JVIRiUsWN
 8AoDEY2yDyUuqx/RW4UWSoXFdGYW3rw=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-882NSHjtOQa7u49iLtj7BA-1; Wed, 21 Aug 2024 14:34:14 -0400
X-MC-Unique: 882NSHjtOQa7u49iLtj7BA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5d601a9374cso45079eaf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 11:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724265253; x=1724870053;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nBlvvD96RzO0MQrzOLGV6+BJW4QxBoCf12C91mRN7Ec=;
 b=t4eSYuCmlNp9+nOITMDmXbDpSYUp64cwDpK2eXUhp9geiB5Xbx0kjH8Ag1obmpiejU
 1kpQk3+Zp/G3vrq0WMHXkA1zHOStZhWtq0d56FfUYQTZmPo4MfUQNPh0eDRwMgKlZC28
 vBmPmOWqlQgkud5y9YEjHIHen1DHR7Spi/MSb9u/QZQaTXT01ZAFzVF+bBhDkYAIgqRy
 iqewxTFwoeG2UPJDbQN3nLzLA5/2hJs30REDNtXeJmJaTepnzFTaZytOEzH4ujtC2tdi
 H+SqMlf6XrxCSzyp657gk/lPx2j2GxV8/D4opIvZqZ9XnZAlQrMQti2zxxMXylqqp3Xh
 +cPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxRwK1zu8FmHgw1pp11CZHylcgQKL9YOtPD3whZgDDUbhTiTbD/l27hfLquJWDhj1xu5y8KIm9aE4l@nongnu.org
X-Gm-Message-State: AOJu0YyQj15ktdSu4sxLjL5EgCB0c/C8Xlin5MP0l+ukQilJBGyP/z0G
 P0mhuyfFpTohi6g9KdzrjtxaY6EHoLqGJYnu2iuMnmSHC1pUnTxyMk4RRaZDdWkEbaIZy0i+CZI
 vOKALbPL/avCemv1/K1QXqScDQVTP0MDU+Uuayb3ehFcYJIo6kRcY
X-Received: by 2002:a05:6358:419d:b0:1af:15b5:7caa with SMTP id
 e5c5f4694b2df-1b59fbf00eemr407596455d.21.1724265253235; 
 Wed, 21 Aug 2024 11:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm5eFF9pKBZTJDGErbyaokV7D0e7Dp/YTyBK0RH7e/7I/s8Uu3RQB5GG5Yg+hrY/upNGoiyw==
X-Received: by 2002:a05:6358:419d:b0:1af:15b5:7caa with SMTP id
 e5c5f4694b2df-1b59fbf00eemr407593455d.21.1724265252791; 
 Wed, 21 Aug 2024 11:34:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd8c22sm64142496d6.14.2024.08.21.11.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 11:34:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:34:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <ZsYzIN5pM9Ad_DYn@x1n>
References: <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
 <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
 <Zr97ms6Ur9HH_EXG@x1n>
 <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 16, 2024 at 01:09:23PM -0400, Steven Sistare wrote:
> On 8/16/2024 12:17 PM, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
> > > > On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
> > > > > On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
> > > > > > On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> > > > > > > On 8/13/2024 3:46 PM, Peter Xu wrote:
> > > > > > > > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > > > > > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > > > > > > > processes has issues where both QEMUs want to be opening the very same
> > > > > > > > > > file, and only 1 of them can ever have them open.
> > > > > > > > 
> > > > > > > > I thought we used to have similar issue with block devices, but I assume
> > > > > > > > it's solved for years (and whoever owns it will take proper file lock,
> > > > > > > > IIRC, and QEMU migration should properly serialize the time window on who's
> > > > > > > > going to take the file lock).
> > > > > > > > 
> > > > > > > > Maybe this is about something else?
> > > > > > > 
> > > > > > > I don't have an example where this fails.
> > > > > > > 
> > > > > > > I can cause "Failed to get "write" lock" errors if two qemu instances open
> > > > > > > the same block device, but the error is suppressed if you add the -incoming
> > > > > > > argument, due to this code:
> > > > > > > 
> > > > > > >    blk_attach_dev()
> > > > > > >      if (runstate_check(RUN_STATE_INMIGRATE))
> > > > > > >        blk->disable_perm = true;
> > > > > > 
> > > > > > Yep, this one is pretty much expected.
> > > > > > 
> > > > > > > 
> > > > > > > > > Indeed, and "files" includes unix domain sockets.
> > > > > > > 
> > > > > > > More on this -- the second qemu to bind a unix domain socket for listening
> > > > > > > wins, and the first qemu loses it (because second qemu unlinks and recreates
> > > > > > > the socket path before binding on the assumption that it is stale).
> > > > > > > 
> > > > > > > One must use a different name for the socket for second qemu, and clients
> > > > > > > that wish to connect must be aware of the new port.
> > > > > > > 
> > > > > > > > > Network ports also conflict.
> > > > > > > > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > > > > > > > I forgot to promote.
> > > > > > > > 
> > > > > > > > I was thinking that's fine, as the host ports should be the backend of the
> > > > > > > > VM ports only anyway so they don't need to be identical on both sides?
> > > > > > > > 
> > > > > > > > IOW, my understanding is it's the guest IP/ports/... which should still be
> > > > > > > > stable across migrations, where the host ports can be different as long as
> > > > > > > > the host ports can forward guest port messages correctly?
> > > > > > > 
> > > > > > > Yes, one must use a different host port number for the second qemu, and clients
> > > > > > > that wish to connect must be aware of the new port.
> > > > > > > 
> > > > > > > That is my point -- cpr-transfer requires fiddling with such things.
> > > > > > > cpr-exec does not.
> > > > > > 
> > > > > > Right, and my understanding is all these facilities are already there, so
> > > > > > no new code should be needed on reconnect issues if to support cpr-transfer
> > > > > > in Libvirt or similar management layers that supports migrations.
> > > > > 
> > > > > Note Libvirt explicitly blocks localhost migration today because
> > > > > solving all these clashing resource problems is a huge can of worms
> > > > > and it can't be made invisible to the user of libvirt in any practical
> > > > > way.
> > > > 
> > > > Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
> > > > supported local migration somehow on top of libvirt.
> > > 
> > > Since kubevirt runs inside a container, "localhost" migration
> > > is effectively migrating between 2 completely separate OS installs
> > > (containers), that happen to be on the same physical host. IOW, it
> > > is a cross-host migration from Libvirt & QEMU's POV, and there are
> > > no clashing resources to worry about.
> > 
> > OK, makes sense.
> > 
> > Then do you think it's possible to support cpr-transfer in that scenario
> > from Libvirt POV?
> > 
> > > 
> > > > Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
> > > > to consume it (as cpr-* is only for local host migrations so far)?  Even if
> > > > all the rest issues we're discussing with cpr-exec, is that the only way to
> > > > go for Libvirt, then?
> > > 
> > > cpr-exec is certainly appealing from the POV of avoiding the clashing
> > > resources problem in libvirt.
> > > 
> > > It has own issues though, because libvirt runs all QEMU processes with
> > > seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
> > > and thus don't want to allow it to exec anything !
> > > 
> > > I don't know which is the lesser evil from libvirt's POV.
> > > 
> > > Personally I see security controls as an overriding requirement for
> > > everything.
> > 
> > One thing I am aware of is cpr-exec is not the only one who might start to
> > use exec() in QEMU. TDX fundamentally will need to create another key VM to
> > deliver the keys and the plan seems to be using exec() too.  However in
> > that case per my understanding the exec() is optional - the key VM can also
> > be created by Libvirt.
> > 
> > IOW, it looks like we can still stick with execve() being blocked yet so
> > far except cpr-exec().
> > 
> > Hmm, this makes the decision harder to make.  We need to figure out a way
> > on knowing how to consume this feature for at least open source virt
> > stack..  So far it looks like it's only possible (if we take seccomp high
> > priority) we use cpr-transfer but only in a container.
> 
> libvirt starts qemu with the -sandbox spawn=deny option which blocks fork, exec,
> and change namespace operations.  I have a patch in my workspace to be submitted
> later called "seccomp: fine-grained control of fork, exec, and namespace" that allows
> libvirt to block fork and namespace but allow exec.

The question is whether that would be accepted, and it also gives me the
feeling that even if it's accepted, it might limit the use cases that cpr
can apply to.

What I read so far from Dan is that cpr-transfer seems to be also preferred
from Libvirt POV:

  https://lore.kernel.org/r/Zr9-IvoRkGjre4CI@redhat.com

Did I read it right?

Thanks,

-- 
Peter Xu


