Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B164C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seze4-0007tc-4l; Fri, 16 Aug 2024 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seze0-0007cq-03
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezdy-00089V-4h
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723825055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzLoHDJXEyJ2UjOgFn3oYMoUmhbTiFliCp/lLie4WcM=;
 b=YTRa/EH8rsfccs01lFDiwqWG2k9Tenc4q5jsV9H1QHpK0MFnPMEPeyyJ5jvE3RpmeZppjU
 wItQ1K24c0VLqtZLzg3038Px29YwwCFK17RPxDhQRUd1OH7dZprT5sCtdnkZ35gKXWCWh7
 MTqZ4fpV2ufdV83EvclQ3W4mYqJaIJQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-hi4n2gscM06lDB1sDpXMLg-1; Fri, 16 Aug 2024 12:17:34 -0400
X-MC-Unique: hi4n2gscM06lDB1sDpXMLg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6bf7b853f0dso2633056d6.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723825053; x=1724429853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NzLoHDJXEyJ2UjOgFn3oYMoUmhbTiFliCp/lLie4WcM=;
 b=H3NKHLg6cLS88rFKd/BD5faOxxzJWu2Vxi8eFlm6sCC+IRlGPw1floEQx19CglVfLv
 BjgfV0rv0jGJzykb6xVypypnyZLhcqTXi7YG7674UwIl/O0BREvU7+OKc9N2J+/ZR+oq
 DT2otS4xqUL0GPOyYzqU3Wy85HxIGUQl63Hya6wirdSbsLBMYr1Gz6al3jXMuCeRU7AE
 ToryiWI4zODZHsTfihCs65pWbp5zwsyDpVnVFF82rhlsSEj5bRM0dpewm0azEGtu69a3
 JW9U5mesWA4kBcY/lp0qOZUTE4Hxq8tInD9vayq2Hr06DPAWESv/QChKkYlXPvbK+Q7T
 KrRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMa3yaJYbtGagEw6ig3Jsw/EVcMei6BH6yqouE0/7++hlhFTw2gaH4dn3OvCyvdjb4SSNDzhJiAS97@nongnu.org
X-Gm-Message-State: AOJu0YwTIH4zq4JvdS3hbi/HbPjHNuvDpfJClDoUmc7xGbIwWXVLw5D+
 gn71Ir0gVrbmgCXL/JolnZHqn7LkSC5QboqQ9wwegSGAUHTOd3+iEJlLTnIC0dXqqSSAqtRG79p
 uFkEgwpipzejmf8Bo5uCISaN5M9BD0/z+ekCuUSZBKgMUU+YPd2Rh
X-Received: by 2002:a05:6214:ccd:b0:6b2:af3c:f710 with SMTP id
 6a1803df08f44-6bf7cd9f4aamr20957976d6.2.1723825053199; 
 Fri, 16 Aug 2024 09:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXZ/NARZCg+rV/HGh//wjRcGvQMHaQrFgR/3G8my8ekVwAyN2K2MqTnhebEYKg9XkFMsKVRQ==
X-Received: by 2002:a05:6214:ccd:b0:6b2:af3c:f710 with SMTP id
 6a1803df08f44-6bf7cd9f4aamr20957756d6.2.1723825052776; 
 Fri, 16 Aug 2024 09:17:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd9050sm18920626d6.27.2024.08.16.09.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:17:32 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:17:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zr97ms6Ur9HH_EXG@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
 <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr93oOn9J5JLs2Rn@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
> > > > On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> > > > > On 8/13/2024 3:46 PM, Peter Xu wrote:
> > > > > > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > > > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > > > > > processes has issues where both QEMUs want to be opening the very same
> > > > > > > > file, and only 1 of them can ever have them open.
> > > > > > 
> > > > > > I thought we used to have similar issue with block devices, but I assume
> > > > > > it's solved for years (and whoever owns it will take proper file lock,
> > > > > > IIRC, and QEMU migration should properly serialize the time window on who's
> > > > > > going to take the file lock).
> > > > > > 
> > > > > > Maybe this is about something else?
> > > > > 
> > > > > I don't have an example where this fails.
> > > > > 
> > > > > I can cause "Failed to get "write" lock" errors if two qemu instances open
> > > > > the same block device, but the error is suppressed if you add the -incoming
> > > > > argument, due to this code:
> > > > > 
> > > > >   blk_attach_dev()
> > > > >     if (runstate_check(RUN_STATE_INMIGRATE))
> > > > >       blk->disable_perm = true;
> > > > 
> > > > Yep, this one is pretty much expected.
> > > > 
> > > > > 
> > > > > > > Indeed, and "files" includes unix domain sockets.
> > > > > 
> > > > > More on this -- the second qemu to bind a unix domain socket for listening
> > > > > wins, and the first qemu loses it (because second qemu unlinks and recreates
> > > > > the socket path before binding on the assumption that it is stale).
> > > > > 
> > > > > One must use a different name for the socket for second qemu, and clients
> > > > > that wish to connect must be aware of the new port.
> > > > > 
> > > > > > > Network ports also conflict.
> > > > > > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > > > > > I forgot to promote.
> > > > > > 
> > > > > > I was thinking that's fine, as the host ports should be the backend of the
> > > > > > VM ports only anyway so they don't need to be identical on both sides?
> > > > > > 
> > > > > > IOW, my understanding is it's the guest IP/ports/... which should still be
> > > > > > stable across migrations, where the host ports can be different as long as
> > > > > > the host ports can forward guest port messages correctly?
> > > > > 
> > > > > Yes, one must use a different host port number for the second qemu, and clients
> > > > > that wish to connect must be aware of the new port.
> > > > > 
> > > > > That is my point -- cpr-transfer requires fiddling with such things.
> > > > > cpr-exec does not.
> > > > 
> > > > Right, and my understanding is all these facilities are already there, so
> > > > no new code should be needed on reconnect issues if to support cpr-transfer
> > > > in Libvirt or similar management layers that supports migrations.
> > > 
> > > Note Libvirt explicitly blocks localhost migration today because
> > > solving all these clashing resource problems is a huge can of worms
> > > and it can't be made invisible to the user of libvirt in any practical
> > > way.
> > 
> > Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
> > supported local migration somehow on top of libvirt.
> 
> Since kubevirt runs inside a container, "localhost" migration
> is effectively migrating between 2 completely separate OS installs
> (containers), that happen to be on the same physical host. IOW, it
> is a cross-host migration from Libvirt & QEMU's POV, and there are
> no clashing resources to worry about.

OK, makes sense.

Then do you think it's possible to support cpr-transfer in that scenario
from Libvirt POV?

> 
> > Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
> > to consume it (as cpr-* is only for local host migrations so far)?  Even if
> > all the rest issues we're discussing with cpr-exec, is that the only way to
> > go for Libvirt, then?
> 
> cpr-exec is certainly appealing from the POV of avoiding the clashing
> resources problem in libvirt.
> 
> It has own issues though, because libvirt runs all QEMU processes with
> seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
> and thus don't want to allow it to exec anything !
> 
> I don't know which is the lesser evil from libvirt's POV.
> 
> Personally I see security controls as an overriding requirement for
> everything.

One thing I am aware of is cpr-exec is not the only one who might start to
use exec() in QEMU. TDX fundamentally will need to create another key VM to
deliver the keys and the plan seems to be using exec() too.  However in
that case per my understanding the exec() is optional - the key VM can also
be created by Libvirt.

IOW, it looks like we can still stick with execve() being blocked yet so
far except cpr-exec().

Hmm, this makes the decision harder to make.  We need to figure out a way
on knowing how to consume this feature for at least open source virt
stack..  So far it looks like it's only possible (if we take seccomp high
priority) we use cpr-transfer but only in a container.

Thanks,

-- 
Peter Xu


