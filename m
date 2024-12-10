Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A87E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3Pr-0000AD-KW; Tue, 10 Dec 2024 11:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tL3Pq-0000A3-Gb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:48:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tL3Po-0003i5-MM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733849330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7hGeMiFdvkLZOcARTYtjQaLf/0RvCo9yQYkZXn5gzk=;
 b=GIg9Qd34Syv0IAGYb3wC4VfWXVBReuk4zhFhsmp2YiKRcRBOtyF8AaG5pdez6BZ+kz4Ekw
 ZjNJUDgie5t6zKLkNRZrKGVhIEBYGjVeBpiJAVUgb/3Ef9/pL5cD84J1Wv+d8GbE4oicoU
 6g/UZbi4jo5I5po97iutpxQKLfMtIEQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-VVFzQAcCPZasZztQMX5hqQ-1; Tue, 10 Dec 2024 11:48:49 -0500
X-MC-Unique: VVFzQAcCPZasZztQMX5hqQ-1
X-Mimecast-MFC-AGG-ID: VVFzQAcCPZasZztQMX5hqQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-844c173a6bcso105775839f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733849328; x=1734454128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n7hGeMiFdvkLZOcARTYtjQaLf/0RvCo9yQYkZXn5gzk=;
 b=A4M0JGJtfdHAY3v0RTo1UL0dcDKBRr5exfUuAww38N5NznWevgvtfQoof57I+H7kR2
 pbwn+fYF5fwJ8Z4XKM4U4i6ULge4cELTabB31E5Wdkg5FrxcX6UUBVW19yNTqGxbqBnL
 9zzmp3PJvzoaviCvs9teXsVkswbGdD96YraL6EyKngNiSZ/kLIa6Vejashk7Tf6BiU0/
 G+kl4+jRwGCSNUDbOO6d6imwJLNUyB+szuVgcOvcosvBZ7zVAq4L6BO+xZXDJrLWIWeV
 HfkAp3Cx2nOrzRcKvtztWp9LLltghFlDcT16H3Mmsy7eN6Z1zcvef52SO9P4wiZnGkv4
 6EhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUUXiiC/GIZN7FwJwrCB2nH00xR4ge3sbQrQcVz7zJb8CSmcoxUpVN5uTr19AJSgvrRQbTMRkrzecf@nongnu.org
X-Gm-Message-State: AOJu0YzSOsq0RAGpINr59MdkpHht9s8jlASWT56WYZCYm0fJaajOSE8b
 kfxhkDiZdblpBQIHtNTiNbPQnZly8WQdKH7nlJb2IOFJHrYg6m+OKEVF+VhXgGWwy1EifGhsPo9
 yFcp8MA3GQt7PN92pb8XTJmnpFnwjvHFKdPrcv4hqW8dw/i7ptkbZ
X-Gm-Gg: ASbGncsaS3DdzaaDqm8gwfa4OL9o9VsNS5GpuIsaT+ooUieWYTdoKzfFFonsB6zJW2A
 XqZTOxSpkG3WYWbk+iUxvydBUySYonOmEGPt2n59aQd1EpSJ+IZzxvBO/9ZSip6zyiylvzPjywj
 VoSJLPCsa5zAChkFNw+Ncv6YP46kqnaFd8q2vvjCpoJcUW9IOSaoClrH1WkovmCSAjXgXHMfFNm
 /Zw2HO36XwbiYxN7yM9xuvqdhHK+8rJ8Q5hB8uH7ZzRUAv7MhVwUrEGQ+NTYNbMns4ynfkTaGfV
 UUuwkFBr351v+3I=
X-Received: by 2002:a05:6e02:1c24:b0:3a7:d84c:f2b0 with SMTP id
 e9e14a558f8ab-3a811d927a6mr197563405ab.8.1733849328572; 
 Tue, 10 Dec 2024 08:48:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSj4e0eUUw188b18Ul0KxUssAhqoo7Lj0MNKSgwqEFEcO/LMdl9W7d0ImKHB/ltm5YHJI4aA==
X-Received: by 2002:a05:6e02:1c24:b0:3a7:d84c:f2b0 with SMTP id
 e9e14a558f8ab-3a811d927a6mr197563215ab.8.1733849328239; 
 Tue, 10 Dec 2024 08:48:48 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d2b5a1e1sm323480173.71.2024.12.10.08.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:48:47 -0800 (PST)
Date: Tue, 10 Dec 2024 11:48:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
Message-ID: <Z1hw7dvTe4jMgXeq@x1n>
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
 <Z1JOpadES2iV_i0v@x1n>
 <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 09, 2024 at 10:40:51AM +0300, Daniil Tatianin wrote:
> On 12/6/24 4:08 AM, Peter Xu wrote:
> 
> > On Fri, Dec 06, 2024 at 02:19:06AM +0300, Daniil Tatianin wrote:
> > > Currently, passing mem-lock=on to QEMU causes memory usage to grow by
> > > huge amounts:
> > > 
> > > no memlock:
> > >      $ qemu-system-x86_64 -overcommit mem-lock=off
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      45652
> > > 
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      39756
> > > 
> > > memlock:
> > >      $ qemu-system-x86_64 -overcommit mem-lock=on
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      1309876
> > > 
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      259956
> > > 
> > > This is caused by the fact that mlockall(2) automatically
> > > write-faults every existing and future anonymous mappings in the
> > > process right away.
> > > 
> > > One of the reasons to enable mem-lock is to protect a QEMU process'
> > > pages from being compacted and migrated by kcompactd (which does so
> > > by messing with a live process page tables causing thousands of TLB
> > > flush IPIs per second) basically stealing all guest time while it's
> > > active.
> > > 
> > > mem-lock=on helps against this (given compact_unevictable_allowed is 0),
> > > but the memory overhead it introduces is an undesirable side effect,
> > > which we can completely avoid by passing MCL_ONFAULT to mlockall, which
> > > is what this series allows to do with a new command line option called
> > > mem-lock-onfault.
> > IMHO it'll be always helpful to dig and provide information on why such
> > difference existed.  E.g. guest mem should normally be the major mem sink
> > and that definitely won't be affected by either ON_FAULT or not.
> > 
> > I had a quick look explicitly on tcg (as that really surprised me a bit..).
> > When you look at the mappings there's 1G constant shmem map that always got
> > locked and populated.
> > 
> > It turns out to be tcg's jit buffer, alloc_code_gen_buffer_splitwx_memfd:
> 
> Thanks for looking into this! I'd guessed it was something to do with JIT,
> makes sense.
> 
> >      buf_rw = qemu_memfd_alloc("tcg-jit", size, 0, &fd, errp);
> >      if (buf_rw == NULL) {
> >          goto fail;
> >      }
> > 
> >      buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
> >      if (buf_rx == MAP_FAILED) {
> >          error_setg_errno(errp, errno,
> >                           "failed to map shared memory for execute");
> >          goto fail;
> >      }
> > 
> > Looks like that's the major reason why tcg has mlockall bloated constantly
> > with roughly 1G size - that seems to be from tcg_init_machine().  I didn't
> > check kvm.
> > 
> > Logically having a on-fault option won't ever hurt, so probably not an
> > issue to have it anyway.  Still, share my finding above, as IIUC that's
> > mostly why it was bloated for tcg, so maybe there're other options too.
> 
> Yeah, the situation with KVM is slightly better, although it's still a
> ~200MiB overhead with default Q35 and no extra devices (I haven't measured
> the difference with various devices).
> 
> I think it's definitely nice to have an on-fault option for this, as
> optimizing every possible mmap caller for the rare mem-lock=on case might be
> too ambitious.

It really depends, IMHO, and that's why I didn't already ack the series.

It may be relevant to the trade-off here on allowing faults to happen later
even if mem-lock=on.  The question is why, for example in your use case,
would like to lock the memory.

Take kvm-rt as example, I believe that's needed because RT apps (running in
the guest) would like to avoid page faults throughout the stack, so that
guest workload, especially on the latency part of things, is predictable.

Here if on-fault is enabled it could beat that purpose already.

Or if the current use case is making sure after QEMU boots the memory will
always present so that even if later the host faces memory stress it won't
affect anything running the VM as it pre-allocated everything (so that's
beyond memory-backend-*,prealloc=on, because it covers QEMU/KVM memory
too).  Meanwhile locked pages won't swap out, so it's always there.

But then with on-fault, it means the pages will only be locked upon access.
Then it means the guarantee on "QEMU secures the memory on boot" is gone
too.

That's why I was thinking whether your specific use case really wants
on-fault, or you do want e.g. to have a limit on the tcg-jit buffer instead
(or same to whatever kvm was consuming), so you don't want that large a
buffer, however you still want to have all things locked up upfront.  It
can be relevant to why your use case started to use mem-lock=on before this
on-fault flag.

OTOH, I believe on-fault cannot work with kvm-rt at all already, because of
its possible faults happening later on - even if the fault can happen in
KVM and even if it's not about accessing guest mem, it can still be part of
overhead later when running the rt application in the guest, hence it can
start to break RT deterministics.

Thanks,

-- 
Peter Xu


