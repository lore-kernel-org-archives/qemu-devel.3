Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62089D132A2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tZZ-0003Rg-Gp; Mon, 04 Nov 2024 04:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t7tZV-0003Qk-Ti
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:40:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t7tZT-0000SF-0b
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730713224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwuh3zulhEMBWlop8FcPhbuXkElvZ9qgRFoz9qrb44s=;
 b=Amiq/qopjtuGOeMumoBwoawhbqYdAn5Ij+dLC5Pu2WAEFClXW0fbVPlrB1E/zr+jENBmBy
 KvR37GJgPWOpQoFCbDlXlcNCCQd1lNbGVgBp5sTLW3G7gFE6YO75YteNOpU1Uyb2w2b4jN
 HIYp9gXPj4gOQ7OZ+l4ufDxKUJIsViM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-D15WOwRCNo62LcbK7TqMyw-1; Mon, 04 Nov 2024 04:40:23 -0500
X-MC-Unique: D15WOwRCNo62LcbK7TqMyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4317391101aso26050495e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 01:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730713222; x=1731318022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwuh3zulhEMBWlop8FcPhbuXkElvZ9qgRFoz9qrb44s=;
 b=YkCKA+7HtWx2kkvpBvk/YsTG0UPtkd4bcu+ruDOaF8XiQ4pZ0CzBD3Sl8Dw6zRaM98
 0yLD0dG9kyk67T8ls/MdsZX/m3dOu1X8XZuiqf4hhK2LTP/SxqH8Ee0iFVBKO/Kz1U7t
 l2wY7shSUb6WBqLVUxl5CYfjqvpFKnXtI44H6L4NVZMhm3QkxKYyH3A2ZnFxFUpOX9Vj
 rjVU1sxrXIrm/ENoHd/M2ldzRAE44VouQNUrRV3dSNjwlCB6rYJEQT9O+oh7N4b4QglV
 c+4Egk30GncA7V8D0EYwOwumRE7FLgzI9IbJ0+WhOBeCVVHdaw6UdpgKISrpZUkPTiNr
 qxbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD2QhfXeyib3Ig/2sbLLjejkKk7/x729hCXyY6Ee4s3/dUNJgzdHtiumPXEtw8dM0m6WaZ9nyodz5b@nongnu.org
X-Gm-Message-State: AOJu0Yw2yygee4KtSkWWaxxaVFhiGIGbwXfrd35tEGWZLPlQ6Sem44/I
 ae/U8V1/K/LvQdY08ZEC5r9KgmRdpWjp/ZyzPk61kr/Sf96JC7dTNOh4KDz/ORNf/WQB2VTgK3g
 qMySmozMn3VVD5I8WgqbZWrgVQXzkopZqAu2xn9OYVYW2Xc0fb5/b
X-Received: by 2002:a05:600c:3b25:b0:432:7c08:d11e with SMTP id
 5b1f17b1804b1-4328323f5f4mr93967685e9.1.1730713221697; 
 Mon, 04 Nov 2024 01:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc26xGpDZLxKxHSdXn3ZoJ+XbVzzVheJBq124M5WWMyWeXOOgwptXah4YWoYwXtds9kcm4Kg==
X-Received: by 2002:a05:600c:3b25:b0:432:7c08:d11e with SMTP id
 5b1f17b1804b1-4328323f5f4mr93967465e9.1.1730713221224; 
 Mon, 04 Nov 2024 01:40:21 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381d0873054sm6434500f8f.113.2024.11.04.01.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 01:40:20 -0800 (PST)
Date: Mon, 4 Nov 2024 10:40:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Anthony Harivel" <aharivel@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241104104018.70db23dc@imammedo.users.ipa.redhat.com>
In-Reply-To: <D52DSJO1XHS6.1IT0XYDXDFT0E@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <D52DSJO1XHS6.1IT0XYDXDFT0E@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 22 Oct 2024 15:49:33 +0200
"Anthony Harivel" <aharivel@redhat.com> wrote:

> Igor Mammedov, Oct 18, 2024 at 14:25:
> > On Wed, 16 Oct 2024 14:56:39 +0200
> > "Anthony Harivel" <aharivel@redhat.com> wrote:
> >  
> >> Hi Igor,
> >> 
> >> Igor Mammedov, Oct 16, 2024 at 13:52:  
> >> > On Wed, 22 May 2024 17:34:49 +0200
> >> > Anthony Harivel <aharivel@redhat.com> wrote:
> >> >    
> >> >> Dear maintainers, 
> >> >> 
> >> >> First of all, thank you very much for your review of my patch 
> >> >> [1].    
> >> >
> >> > I've tried to play with this feature and have a few questions about it
> >> >    
> >> 
> >> Thanks for testing this new feature. 
> >>   
> >> >  1. trying to start with non accessible or not existent socket
> >> >         -accel kvm,rapl=on,rapl-helper-socket=/tmp/socket 
> >> >     I get:
> >> >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: vmsr socket opening failed
> >> >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: kvm : error RAPL feature requirement not met
> >> >     * is it possible to report actual OS error that happened during open/connect,
> >> >       instead of unhelpful 'socket opening failed'?
> >> >
> >> >       What I see in vmsr_open_socket() error is ignored
> >> >       and btw it's error leak as well
> >> >    
> >> 
> >> Shame you missed the 6 iterations of that patch that last for a year. 
> >> I would have changed that directly !
> >> Anyway I take note on that comment and will send a modification.
> >>   
> >> >     * 2nd line shouldn't be there if the 1st error already present.
> >> >
> >> >  2.  getting periodic error on console where QEMU has been starter
> >> >       # ./qemu-vmsr-helper -k /tmp/sock
> >> >      ./qemu-system-x86_64 -snapshot -m 4G -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock rhel90.img  -vnc :0 -cpu host
> >> >      and let it run
> >> >
> >> >       it appears rdmsr works (well, it returns some values at least)
> >> >       however there are recurring errors in qemu's stderr(or out)
> >> >       
> >> >       qemu-system-x86_64: Error opening /proc/2496093/task/2496109/stat
> >> >       qemu-system-x86_64: Error opening /proc/2496093/task/2496095/stat
> >> >
> >> >       My guess it's some temporary threads, that come and go, but still
> >> >       they shouldn't cause errors if it's normal operation.
> >> >    
> >> 
> >> There a patch in WIP that change this into a Tracepoint. Maybe you can 
> >> SSH to the VM in meanwhile ?  
> >
> > it's just idling VM that doesn't do anything, hence the question.  
> >  
> >>   
> >> >       Also on daemon side, I a few times got while guest was running:
> >> >         qemu-vmsr-helper: Failed to open /proc at /proc/2496026/task/2496044
> >> >         qemu-vmsr-helper: Requested TID not in peer PID: 2496026 2496044
> >> >       though I can't reproduce it reliably    
> >> 
> >> This could happen only when a vCPU thread ID has changed between the 
> >> call of a rdmsr throught the socket and the hepler that read the msr.
> >> No idea how a vCPU can change TID or shutdown that fast.  
> >
> > I guess it needs to be figured out to decide if it's safe to ignore (and not print error)
> > or if it's a genuine error/bug somewhere
> >  
> >> >  3. when starting daemon not as root, it starts 'fine' but later on complains
> >> >       qemu-vmsr-helper: Failed to open MSR file at /dev/cpu/0/msr
> >> >     perhaps it would be better to fail at start daemon if it doesn't have
> >> >     access to necessary files.
> >> >    
> >> 
> >> Right taking a note on that as well.
> >> 
> >>   
> >> >  4. in case #3, guest also fails to start with errors:
> >> >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: can't read any virtual msr
> >> >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: kvm : error RAPL feature requirement not met
> >> >      again line #2 is not useful and probably not needed (maybe make it tracepoint)
> >> >      and #1 is unhelpful - it would be better if it directed user to check qemu-vmsr-helper
> >> >    
> >> 
> >> I will try to see how to improve that part. 
> >> Thanks for your valuable feedback.
> >>   
> >> >  5. does AMD have similar MSRs that we could use to make this feature complete?
> >> >    
> >> 
> >> Yes but the address are completely different. However, this in my ToDo 
> >> list. First I need way more feedback like yours to move on extending 
> >> this feature.  
> >
> > If adding AMD's MSRs is not difficult, then I'd make it priority.
> > This way users (and libvirt) won't have to deal with 2 different
> > feature-sets and decide when to allow this to be turned on depending on host.
> >  
> 
> QEMU needs to know if it runs on Intel or AMD machine in order to choose 
> which set of MSR it must read. I did not check how to achieve this at the 
> moment but I will when I will work on that.

talking to daemon in terms of power per pkg, e.t.c., we won't care
which MRSs go over wire between daemon and QEMU. Then QEMU can map
that to relevant MSRs (based on cpumodel) internally.

> 
> >>   
> >> >  6. What happens to power accounting if host constantly migrates
> >> >     vcpus between sockets, are values we are getting still correct/meaningful?
> >> >     Or do we need to pin vcpus to get 'accurate' values?
> >> >    
> >> 
> >> It's taken into account during the ratio calculation which socket the 
> >> vCPU has just been scheduled. But yes the value are more 'accurate' when 
> >> the vCPU is pinned.  
> >
> > in worst case VCPUs might be moved between sockets many times during
> > sample window, can you explain how that is accounted for?
> >  
> 
> If one vCPU is moving socket during the sample period then it is 
> detected and not taken into account.
> 
> That said, if your system is bouncing vCPU back and forth between socket 
> then you will experience a lot of caches misses, cpu caches trashes, 
> context switches, increase of memory latency (numa issues), etc. This 
> will lead to performance degradation and VM performance being very poor. 
> Then you should probably fix it.

yep, it's bad config, but typical for overcommit scenario.
if we can't get correct measurement in this case,
then at least printing a warning once could be nice.

(it would be better to refuse starting without vCPU pinning,
but given pinning isn't done by QEMU, I don't see a way to do that.) 

> > Anyways, it would be better to have some numbers in doc that would
> > clarify what kind of accuracy we are talking about (and example
> > pinned vs unpinned), or whether unpinned case measures average
> > temperature of patients in hospital and we should recommend
> > to pin vcpus and everything else.
> >  
> 
> I totally understand that I can add more clarification in the 
> documentation that might be obvious for some but not for other. Like 
> isolating your VM properly will give better result. 
> 
> But I won't give any number. It doesn't make sens. Accuracy is not the 
> goal of this feature, it never was and it never will. First of all 
> because RAPL is not accurate for power monitoring. You want accuracy? 
> Use a Power Metering device. 
> You want a reproducible way to compare power energy between 
> A and B in order to optimize your software ? Use can use RAPL and so 
> this feature that shows good reproducible results.
> 
> > Also actual usecase examples for the feature should be mentioned
> > in the doc. So users could figure out when they need to enable
> > this feature (with attached accuracy numbers). Aka how this
> > new feature is good for end users and what they can do with it.
> >  
> 
> Got it. More documentation, use case, examples. 
> I will see what can be added to QEMU documentation.
> 
> 
> >> >  7. do we have to have a dedicated thread for pooling data from daemon?
> >> >
> >> >     Can we fetch data from vcpu thread that have accessed msr
> >> >     (with some caching and rate limiting access to the daemon)?
> >> >    
> >> 
> >> This feature is revolving around a thread. Please look at the 
> >> documentation is not already done:
> >> 
> >> https://www.qemu.org/docs/master/specs/rapl-msr.html#high-level-implementation
> >> 
> >> If we only fetch from vCPU thread, we won't have the consumption of the 
> >> non-vcpu thread. They are taken into account in the total.  
> >
> > one can collect the same data from vcpu thread as well,
> > the bonus part is that we don't have an extra thread
> > hanging around and doing work even if guest never asks
> > for those MSRs.
> >
> > This also leads to a question, if we should account for
> > not VCPU threads at all. Looking at real hardware, those
> > MSRs return power usage of CPUs only, and they do not
> > return consumption from auxiliary system components
> > (io/memory/...). One can consider non VCPU threads in QEMU
> > as auxiliary components, so we probably should not to
> > account for them at all when modeling the same hw feature.
> > (aka be consistent with what real hw does).
> >  
> >> Thanks again for your feedback. 
> >> 
> >> Anthony
> >> 
> >>   
> >> >> In this version (v6), I have attempted to address all the problems 
> >> >> addressed by Daniel and Paolo during the last review. 
> >> >> 
> >> >> However, two open questions remains unanswered that would require the 
> >> >> attention of a x86 maintainers: 
> >> >> 
> >> >> 1)Should I move from -kvm to -cpu the rapl feature ? [2]
> >> >> 
> >> >> 2)Should I already rename to "rapl_vmsr_*" in order to anticipate the 
> >> >>   futur TMPI architecture ? [end of 3] 
> >> >> 
> >> >> Thank you again for your continued guidance. 
> >> >> 
> >> >> v5 -> v6
> >> >> --------
> >> >> - Better error consistency in qio_channel_get_peerpid()
> >> >> - Memory leak g_strdup_printf/g_build_filename corrected
> >> >> - Renaming several struct with "vmsr_*" for better namespace
> >> >> - Renamed several struct with "guest_*" for better comprehension
> >> >> - Optimization suggerate from Daniel
> >> >> - Crash problem solved [4]
> >> >> 
> >> >> v4 -> v5
> >> >> --------
> >> >> 
> >> >> - correct qio_channel_get_peerpid: return pid = -1 in case of error
> >> >> - Vmsr_helper: compile only for x86
> >> >> - Vmsr_helper: use qio_channel_read/write_all
> >> >> - Vmsr_helper: abandon user/group
> >> >> - Vmsr_energy.c: correct all error_report
> >> >> - Vmsr thread: compute default socket path only once
> >> >> - Vmsr thread: open socket only once
> >> >> - Pass relevant QEMU CI
> >> >> 
> >> >> v3 -> v4
> >> >> --------
> >> >> 
> >> >> - Correct memory leaks with AddressSanitizer  
> >> >> - Add sanity check for QEMU and qemu-vmsr-helper for checking if host is 
> >> >>   INTEL and if RAPL is activated.
> >> >> - Rename poor variables naming for easier comprehension
> >> >> - Move code that checks Host before creating the VMSR thread
> >> >> - Get rid of libnuma: create function that read sysfs for reading the 
> >> >>   Host topology instead
> >> >> 
> >> >> v2 -> v3
> >> >> --------
> >> >> 
> >> >> - Move all memory allocations from Clib to Glib
> >> >> - Compile on *BSD (working on Linux only)
> >> >> - No more limitation on the virtual package: each vCPU that belongs to 
> >> >>   the same virtual package is giving the same results like expected on 
> >> >>   a real CPU.
> >> >>   This has been tested topology like:
> >> >>      -smp 4,sockets=2
> >> >>      -smp 16,sockets=4,cores=2,threads=2
> >> >> 
> >> >> v1 -> v2
> >> >> --------
> >> >> 
> >> >> - To overcome the CVE-2020-8694 a socket communication is created
> >> >>   to a priviliged helper
> >> >> - Add the priviliged helper (qemu-vmsr-helper)
> >> >> - Add SO_PEERCRED in qio channel socket
> >> >> 
> >> >> RFC -> v1
> >> >> ---------
> >> >> 
> >> >> - Add vmsr_* in front of all vmsr specific function
> >> >> - Change malloc()/calloc()... with all glib equivalent
> >> >> - Pre-allocate all dynamic memories when possible
> >> >> - Add a Documentation of implementation, limitation and usage
> >> >> 
> >> >> Best regards,
> >> >> Anthony
> >> >> 
> >> >> [1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.html
> >> >> [2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.html
> >> >> [3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.html
> >> >> [4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.html
> >> >> 
> >> >> Anthony Harivel (3):
> >> >>   qio: add support for SO_PEERCRED for socket channel
> >> >>   tools: build qemu-vmsr-helper
> >> >>   Add support for RAPL MSRs in KVM/Qemu
> >> >> 
> >> >>  accel/kvm/kvm-all.c                      |  27 ++
> >> >>  contrib/systemd/qemu-vmsr-helper.service |  15 +
> >> >>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
> >> >>  docs/specs/index.rst                     |   1 +
> >> >>  docs/specs/rapl-msr.rst                  | 155 +++++++
> >> >>  docs/tools/index.rst                     |   1 +
> >> >>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
> >> >>  include/io/channel.h                     |  21 +
> >> >>  include/sysemu/kvm_int.h                 |  32 ++
> >> >>  io/channel-socket.c                      |  28 ++
> >> >>  io/channel.c                             |  13 +
> >> >>  meson.build                              |   7 +
> >> >>  target/i386/cpu.h                        |   8 +
> >> >>  target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
> >> >>  target/i386/kvm/meson.build              |   1 +
> >> >>  target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
> >> >>  target/i386/kvm/vmsr_energy.h            |  99 +++++
> >> >>  tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++
> >> >>  tools/i386/rapl-msr-index.h              |  28 ++
> >> >>  19 files changed, 1831 insertions(+), 1 deletion(-)
> >> >>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
> >> >>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
> >> >>  create mode 100644 docs/specs/rapl-msr.rst
> >> >>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
> >> >>  create mode 100644 target/i386/kvm/vmsr_energy.c
> >> >>  create mode 100644 target/i386/kvm/vmsr_energy.h
> >> >>  create mode 100644 tools/i386/qemu-vmsr-helper.c
> >> >>  create mode 100644 tools/i386/rapl-msr-index.h
> >> >>     
> >>   
> 


