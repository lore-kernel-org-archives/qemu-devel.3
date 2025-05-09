Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F46C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 22:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDVq7-0003Yn-Rb; Fri, 09 May 2025 18:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDVq4-0003Pi-1d
 for qemu-devel@nongnu.org; Fri, 09 May 2025 18:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDVq1-0001Cy-5c
 for qemu-devel@nongnu.org; Fri, 09 May 2025 18:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746828299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z6LuaFaZgXuWiIhpkLgPcqYZV30Fra1paV1GNpnnc54=;
 b=AOzww9+Ob6EupQX4oGcxNWR5N4W7rdHL7XBsr/ZaaiL6zztGLnTo9OsbYKcHTscGgBXcI8
 w25rlmUfQoKVhny9KBGtvgGuxJzwmoZcxgdoETbXcEGRGUCD0/zqyXulej09kaS8+IxrJ+
 tc3atRJo7zSUcKQ0AlgNsOnZ2QwXc38=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Cbt-p4A1NUqvqDKV0Ajhig-1; Fri, 09 May 2025 18:04:57 -0400
X-MC-Unique: Cbt-p4A1NUqvqDKV0Ajhig-1
X-Mimecast-MFC-AGG-ID: Cbt-p4A1NUqvqDKV0Ajhig_1746828297
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5c82c6d72so453480885a.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 15:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746828297; x=1747433097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6LuaFaZgXuWiIhpkLgPcqYZV30Fra1paV1GNpnnc54=;
 b=JqRcrEwK0Tt1mKCwVpLYcXtvoL7nmHQ3UDrFJACiTebecKprYMlRW65+VkqgcJrIa7
 qWuGD1xXJfAryKZePIUrXwPqpv5R5HnpT363BJk7P5LYIBUTOImXFp1Yco2tdW3U9jD2
 jyU8poIymuA7rBKwenkA+W6zrTo5Q9/FJqRWo0OvK3RYMVVQhI8NmT37eR2GSFrY7Dq+
 prUYXcOwanWVXZVb9mTnMiGrwe0DTU5S9Ifiuz5+Ym1OzM6Tr8QEehvmXuJd4lJ+ju9Z
 IzWxVb900N/f4X9SLDtwwr9frGgH+mo6lX4CSJQNodT76VXWKHjb+MzjSKDvfcSil3DL
 Tk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8hvJk0RJp22Udcy63VDVOJ6tqZZGSS42NEszebc7ikPNnfDccX9aiF/eedoX/O3PcuZcXrN5wiScP@nongnu.org
X-Gm-Message-State: AOJu0YykhJbotzBdQJe1VVC8xAzyqFv/1kIrO0TSEy/GKAXF6cdYmmv2
 4HL4P07ollCbHDuP1C0j7lq4D0pN0CgTwNhad3AmrC5RtY9nKH2Jpx6NgK7FrGv0L5TYnialqo2
 zMTTJQ8oyxyKzt2dm5N8JaMp1/nq/eyHVWgoGcS4v4xTIFPEcawnT
X-Gm-Gg: ASbGnctqZ1wk+YkaTLf3mzZBPMYtMrRZ5HrGRGNFMMFPsoMLxYJjRGb6YYHKPZ9ANc2
 leIhpcEh9RQaAEA/8lLeizaLNy1PuWYEZo43Fhcg6/b3hBLGG9XN6+VHKdbbpEMT1N5+LwvC7lg
 rJg529cR0TW7LTp4cifhsTepvQC5WRVAMXOEDF3niY3w9hfLGUCGh9jWKXul7K3C3B/rAkoW4s+
 /2vKTAamQZHR0cKgSe4j9bb9tiXCVL3v7FXJuzc6gJVoK6a4uOZcI9VVvp4xw9h4hlf1Gz00xP1
 KBo=
X-Received: by 2002:a05:620a:4556:b0:7ca:bdbe:c5af with SMTP id
 af79cd13be357-7cd010f3f30mr714956885a.10.1746828297378; 
 Fri, 09 May 2025 15:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyFmF0HAqsMoNaOEkV/cE6s0zGTKUms3DPBhuCBMew07wj+WrRon5Wmnt3DjN5l+zMSXg2mA==
X-Received: by 2002:a05:620a:4556:b0:7ca:bdbe:c5af with SMTP id
 af79cd13be357-7cd010f3f30mr714953485a.10.1746828297007; 
 Fri, 09 May 2025 15:04:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f63ba2sm193642885a.44.2025.05.09.15.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:04:56 -0700 (PDT)
Date: Fri, 9 May 2025 18:04:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
Message-ID: <aB58BQQ12aosCalh@x1.local>
References: <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
 <87plhdfs9o.fsf@suse.de> <7cd3c-6800c580-4b5-10622a60@195456151>
 <871ptqg6u9.fsf@suse.de> <151d8c-680a4080-15-6f9ea10@196998929>
 <aB0Swile4IjxTUsd@x1.local>
 <193e5a-681dfa80-3af-701c0f80@227192887>
 <aB4rhlVGCSk7IwoE@x1.local>
 <1b54a0-681e7080-273-3299e580@146025174>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b54a0-681e7080-273-3299e580@146025174>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 09, 2025 at 11:14:41PM +0200, Marco Cavenati wrote:
> On Friday, May 09, 2025 18:21 CEST, Peter Xu <peterx@redhat.com> wrote:
>  
> > So you don't really need to take sequence of snapshots?  Hmm, that sounds
> > like a completely different use case that I originally thought.
> 
> Correct
> 
> > Have you thought of leveraging ignore-shared and MAP_PRIVATE for the major
> > chunk of guest mem?
> > 
> > Let me explain; it's a very rough idea, but maybe you can collect something
> > useful.
> > 
> > So.. if you keep reloading one VM state thousands of times, it's better
> > first that you have some shmem file (let's imagine that's enough.. you
> > could have more backends) keeping the major chunk of the VM RAM image that
> > you migrated before into a file.
> > 
> > Say, the major part of guest mem is stored here:
> > 
> >   PATH_RAM=/dev/shm/XXX
> > 
> > Then you migrate (with ignore-shared=on) to a file here (NOTE: I _think_
> > you really can use file migration in this case with VM stopped first, not
> > snapshot save/load):
> > 
> >   PATH_VM_IMAGE=/tmp/VM_IMAGE_YYY
> > 
> > Then, the two files above should contain all info you need to start a new
> > VM.
> > 
> > When you want to recover that VM state, boot a VM using this cmdline:
> > 
> >   $qemu ... \
> >   -object memory-backend-file,mem-path=$PATH_RAM,share=off
> >   -incoming file:$PATH_VM_IMAGE
> > 
> > That'll boot a VM, directly loading the shmem page cache (always present on
> > the host, occupying RAM, though, outside of VM lifecycle, but it's part of
> > the design..), loading VM image would be lightning fast because it's tiny
> > when there's almost no RAM inside.  No concern on mapped-ram at all as the
> > rest RAMs are too trivial to just be a stream.
> > 
> > The important bit is share=off - that will mmap() the VM major RAM as
> > MAP_PRIVATE, then it'll do CoW on the "snapshot" you made before, whenever
> > you writes to some guest pages during fuzzing some functions, it copies the
> > shmem page cache over.  shmem page cache should never change its content.
> > 
> > Sounds working to you?
> 
> I didn't know much about these options, cool, thanks for the explanation.
> 
> My only concern is that I'd have to restart the QEMU process for each iteration.
> Honestly I've never measured the impact it would have but I fear that it would 
> be noticeable since the goal is to restore many times a second. What do you
> think?

It may depends on how "many times" are defined. :) IIUC, booting QEMU could
still be pretty fast, but yes, worth measuring.

If that works at least functionally (which also needs some double checking
I guess..), it would be great if you would compare the perf difference
v.s. your solution, that'll be very helpful material for reviewers to read
when/if you're going to propose the feature.

> (Also, snapshots conveniently take care of the disk as well, but this shouldn't 
> be too big of a deal.)

True, I didn't take disks into consideration.  Maybe disk files can be
snapshotted and recovered separately using either qcow2's snapshots, or
using snapshots on modern file systems like btrfs.  Good to know you seem
to have ways to work it out in all cases.

-- 
Peter Xu


