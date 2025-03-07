Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F1DC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfzs-0001K4-Cu; Fri, 07 Mar 2025 17:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqfyP-0000IY-H0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqfyK-0006co-Q5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYsRUGX+l1UmV71cbEratZDCQlbT4dXanq/bNKH0oSQ=;
 b=Fv6A2Fa7EaBzzziyo0P/i/1I8K14DNlvrQy+72EvmF0Qyq53+XUJnP/6pDD6DDSSZG07RV
 55mh2JCvmb7fBMzcRnUIxomgAyckgGAihrmj3vMaEvuRUifBi/bxHPMVT2kYcfRhb/Gd0P
 BwFE1/lMLGrEvfwLo2Nr1bo3CGTvJhE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-1vL6y-KOPlKkjnbT2zdvbQ-1; Fri, 07 Mar 2025 17:15:06 -0500
X-MC-Unique: 1vL6y-KOPlKkjnbT2zdvbQ-1
X-Mimecast-MFC-AGG-ID: 1vL6y-KOPlKkjnbT2zdvbQ_1741385706
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c53b4b0d69so117231485a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741385706; x=1741990506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYsRUGX+l1UmV71cbEratZDCQlbT4dXanq/bNKH0oSQ=;
 b=lmF9dGkL3RSJfXB8ReBhKKMA3PU+FKhWiL/CTnsGUT8dn37kaeR4wzymY80Cch+qnA
 LuEGiaqLqjJ+/6/fXYy4HOektER5tHvYThYcqY2zLPojy5BvtYSpX0LLYtecQi4P8b7N
 CxDhGhphVRWLK3Yj5UA2kX/EhPIcWIch+3Kxo6/7yRp1bhBhyob26tdQmKwE38B9NRjF
 Ziw2fJ9DVpMOagSH8T2Pz8G6biaTUxnxo1ks1WMaW2xFmeA46dsBesg7tjrPKyyFfyFC
 mGER3mrOqtAC4ijFJZ2MWUIaNQgTd+dARMxg5OkqHi5ygHTIYTBUB8l//USMoC0tiz0m
 w9ug==
X-Gm-Message-State: AOJu0YxmCOPIGeZ1BAEnFqiaKqUrFzhUYcXjT2OU4sxwduhDcxhNQF01
 xGXKeDqIg6hZHMSGTb3BkPM8yVreNousfJL2QhoNV8q5k6d5dh5OLgL0rMJDseCncWqwB9s0FFo
 Fp6qdO01OMNWCrY/SqjsAP5kFlBBot45z38uwwBv2gBANQKldiU1/
X-Gm-Gg: ASbGncscFkfru3zJ08GwFQEhhy+/HZc7n0zcq6KvClmANHMCkJnOc3Sg0yIIzoYS4N7
 t7PF2C9kghLyfjXCa7sKk9MZiZTO7IvKMhbbRbo9pyqBlUw4tZE5vJo/cPs+Yqj9vobiUrY3Skv
 HasQWBkP2SyO0cq/EHGeuuofkEOdPWIkJrLHTXZleFO/RjNZlWtQfpjxj11asxrZDfVl4j6RNmY
 3tqFhNYNfdaTZad7Qt8VoFsonlenObdUWunYh9bko1O+JJe8iRzLB++PySoLH4rFP53J5C0Ri5o
 m+NW8ko=
X-Received: by 2002:a05:620a:63c1:b0:7c3:d215:e9bf with SMTP id
 af79cd13be357-7c4e61eba75mr1022620985a.54.1741385706266; 
 Fri, 07 Mar 2025 14:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT/TjToUDY7p2bNBHVP45OPX5bZyESDYNhDSToz18xMrDXiC0fKsQaYCoaIUw3wJZkt5hvyQ==
X-Received: by 2002:a05:620a:63c1:b0:7c3:d215:e9bf with SMTP id
 af79cd13be357-7c4e61eba75mr1022616485a.54.1741385705935; 
 Fri, 07 Mar 2025 14:15:05 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e550ef5asm294908185a.91.2025.03.07.14.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 14:15:05 -0800 (PST)
Date: Fri, 7 Mar 2025 17:15:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
Message-ID: <Z8tv53G5s9MLYv6f@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <Z8ssc0NETt9KJjTG@x1.local> <87tt84u0d2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tt84u0d2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Mar 07, 2025 at 04:06:17PM -0300, Fabiano Rosas wrote:
> > I never tried vsock, would it be used in any use case?
> >
> 
> I don't know, I'm going by what's in the code.
> 
> > It seems to be introduced by accident in 72a8192e225cea, but I'm not sure.
> > Maybe there's something I missed.
> 
> The code was always had some variation of:
> 
> static bool transport_supports_multi_channels(SocketAddress *saddr)
> {
>     return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
>            strstart(uri, "vsock:", NULL);
> }
> 
> Introduced by b7acd65707 ("migration: allow multifd for socket protocol
> only").

Looks like a copy-paste error..  I found it, should be 9ba3b2baa1
("migration: add vsock as data channel support").

https://lore.kernel.org/all/2bc0e226-ee71-330a-1bcd-bd9d097509bc@huawei.com/
https://kvmforum2019.sched.com/event/Tmzh/zero-next-generation-virtualization-platform-for-huawei-cloud-jinsong-liu-zhichao-huang-huawei
https://e.huawei.com/sa/material/event/HC/e37b9c4c33e14e869bb1183fab468fed

So if I read it right.. the VM in this case is inside a container or
something, then it talks to an "agent" on a PCIe device which understands
virtio-vsock protocol.  So maybe vsock just performs better than other ways
to dig that tunnel for the container.

In that case, mentioning vsock is at least ok.

[...]

> >> +After the channels have been put into a wait state by the sync
> >> +functions, the client code may continue to transmit additional data by
> >> +issuing ``multifd_send()`` once again.
> >> +
> >> +Note:
> >> +
> >> +- the RAM migration does, effectively, a global synchronization by
> >> +  chaining a call to ``multifd_send_sync_main()`` with the emission of a
> >> +  flag on the main migration channel (``RAM_SAVE_FLAG_MULTIFD_FLUSH``)
> >
> > ... or RAM_SAVE_FLAG_EOS ... depending on the machine type.
> >
> 
> Eh.. big compatibility mess. I rather not mention it.

It's not strictly a compatibility mess.  IIUC, it was used to be designed
to always work with EOS.  I think at that time Juan was still focused on
making it work and not whole perf tunings, but then we found it can be a
major perf issue if we flush too soon.  Then if we flush it once per round,
it may not always pair with a EOS.  That's why we needed a new message.

But hey, you're writting a doc that helps everyone.  You deserve to decide
whether you like to mention it or not on this one. :)

IIRC we updated our compat rule so we maintain each machine type for only 6
years.  It means the whole per-iteration + EOS stuff can be removed in 3.5
years or so - we did that work in July 2022.  So it isn't that important
either to mention indeed.

> 
> > Maybe we should also add a sentence on the relationship of
> > MULTIFD_FLAG_SYNC and RAM_SAVE_FLAG_MULTIFD_FLUSH (or RAM_SAVE_FLAG_EOS ),
> > in that they should always be sent together, and only if so would it
> > provide ordering of multifd messages and what happens in the main migration
> > thread.
> >
> 
> The problem is that RAM_SAVE_FLAGs are a ram.c thing. In theory the need
> for RAM_SAVE_FLAG_MULTIFD_FLUSH is just because the RAM migration is
> driven by the source machine by the flags that are put on the
> stream. IOW, this is a RAM migration design, not a multifd design. The
> multifd design is (could be, we decide) that once sync packets are sent,
> _something_ must do the following:
> 
>     for (i = 0; i < thread_count; i++) {
>         trace_multifd_recv_sync_main_wait(i);
>         qemu_sem_wait(&multifd_recv_state->sem_sync);
>     }
> 
> ... which is already part of multifd_recv_sync_main(), but that just
> _happens to be_ called by ram.c when it sees the
> RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream, that's not a multifd
> design requirement. The ram.c code could for instance do the sync when
> some QEMU_VM_SECTION_EOS (or whatever it's called) appears.

I still think it should be done in RAM code only.  One major goal (if not
the only goal..) is it wants to order different versions of pages and
that's only what the RAM module is about, not migration in general.

From that POV, having a QEMU_VM_* is kind of the wrong layer - they should
work for migration in general.

Said so, I agree we do violate it from time to time, for example, we have a
bunch of subcmds (MIG_CMD_POSTCOPY*) just for postcopy, which is under
QEMU_VM_COMMAND.  But IIUC that was either kind of ancient (so we need to
stick with them now.. postcopy was there for 10 years) or it needs some
ping-pong messages in which case QEMU_VM_COMMAND is the easiest.. IMHO we
should still try to stick with the layering if possible.

-- 
Peter Xu


