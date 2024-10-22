Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFBED2C555
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FGc-00036j-4J; Tue, 22 Oct 2024 09:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3FGa-00036R-OX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t3FGX-0001gD-4Q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729604978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFP/uk36ElIKHJVFHgk+Ur8IdS679XV6CHnknkHjKxM=;
 b=jKBonzI328U4+d7eXhjB/yQ+uMgbDCVv8vTmVdoZkmS9V8UQU7DYGXFcPhSfwdBMCTxm4g
 TzV3puqQKN4sAsl6hDzq43Z8b1Q0RvaYNZgwJ+M3t5Je9ZyKSDHc6fcVLOvAQ3ZetOfIen
 UPk9+a5l79lt10zlVbMGrT5xgiUOzjU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-0RnItUX0OdmfDFB6tbg_1w-1; Tue, 22 Oct 2024 09:49:37 -0400
X-MC-Unique: 0RnItUX0OdmfDFB6tbg_1w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso42402765e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 06:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729604975; x=1730209775;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RFP/uk36ElIKHJVFHgk+Ur8IdS679XV6CHnknkHjKxM=;
 b=ZxcGC7KsD7NxdgAwwrR0dVRq74VY8iTbrsSbsrBUQVoS0iwHwZWL8l82Z+pfpmS7UA
 UykfQvAn5jCDXPRTOtALf83vcAcNDTHigKH0zUmajTtKhgnxFEF44uD+Ze61dQb74fQV
 a4LiWHyHt36WwvTLNeSJ8U3KY/sPpDCLipjInEU4O2j4t3bP6i4QvXFtfxrgvy+Z7rmr
 7aDb6x4N6wdG+6/bUXnTYU+Ibejy+WOyVYcUKHXiGzKKie4JWP1/mvH1SJYWsEtDt76n
 lzZOJtXw9ribMsp6MVYon4uDWwdK2L40zKxl8uXh4jMW9UQ5z+A8c5njXHsPCShID+tt
 EYQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwzJTrbZBhWN9Z1J2TMiy4+0Xn904kjlJqLMbi6hfASJqlNy3hvfXNlsiGpCGHJl3drLomgYndy4So@nongnu.org
X-Gm-Message-State: AOJu0YwoEirDpOCR0gb8e2Ueb1hRjIxCjroOHDj0vjperg0qj+KY+kMm
 ykUXBOmi8SqV8eU7227GTEBo/1gw/+uDoUC1eS7TG99rTeACgaExjW+jA9EuabPWYOZkq1rNS7I
 bXrU+xuZOxpK3jr/p5uFIBdH/p4xWt3YXVhwCL/VexpUc7hv0xrb+W5nXPJ5wczU=
X-Received: by 2002:a05:600c:3b9c:b0:42c:bc22:e074 with SMTP id
 5b1f17b1804b1-43161691787mr130054005e9.29.1729604974908; 
 Tue, 22 Oct 2024 06:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOKAHk++PzCc7CdP6e1vqRvuzqxqWBF6SXh5yZGpiAV//HYb/cFzdFsHFLBJK7cY8dZbiC5w==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bc22:e074 with SMTP id
 5b1f17b1804b1-43161691787mr130053715e9.29.1729604974456; 
 Tue, 22 Oct 2024 06:49:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58bc6esm89246565e9.24.2024.10.22.06.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 06:49:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 15:49:33 +0200
Message-Id: <D52DSJO1XHS6.1IT0XYDXDFT0E@redhat.com>
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Igor Mammedov" <imammedo@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
User-Agent: aerc/0.18.2-69-g1c54bb3a9d11
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Igor Mammedov, Oct 18, 2024 at 14:25:
> On Wed, 16 Oct 2024 14:56:39 +0200
> "Anthony Harivel" <aharivel@redhat.com> wrote:
>
>> Hi Igor,
>>=20
>> Igor Mammedov, Oct 16, 2024 at 13:52:
>> > On Wed, 22 May 2024 17:34:49 +0200
>> > Anthony Harivel <aharivel@redhat.com> wrote:
>> > =20
>> >> Dear maintainers,=20
>> >>=20
>> >> First of all, thank you very much for your review of my patch=20
>> >> [1]. =20
>> >
>> > I've tried to play with this feature and have a few questions about it
>> > =20
>>=20
>> Thanks for testing this new feature.=20
>>=20
>> >  1. trying to start with non accessible or not existent socket
>> >         -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/socket=20
>> >     I get:
>> >       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/t=
mp/socks: vmsr socket opening failed
>> >       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/t=
mp/socks: kvm : error RAPL feature requirement not met
>> >     * is it possible to report actual OS error that happened during op=
en/connect,
>> >       instead of unhelpful 'socket opening failed'?
>> >
>> >       What I see in vmsr_open_socket() error is ignored
>> >       and btw it's error leak as well
>> > =20
>>=20
>> Shame you missed the 6 iterations of that patch that last for a year.=20
>> I would have changed that directly !
>> Anyway I take note on that comment and will send a modification.
>>=20
>> >     * 2nd line shouldn't be there if the 1st error already present.
>> >
>> >  2.  getting periodic error on console where QEMU has been starter
>> >       # ./qemu-vmsr-helper -k /tmp/sock
>> >      ./qemu-system-x86_64 -snapshot -m 4G -accel kvm,rapl=3Don,rapl-he=
lper-socket=3D/tmp/sock rhel90.img  -vnc :0 -cpu host
>> >      and let it run
>> >
>> >       it appears rdmsr works (well, it returns some values at least)
>> >       however there are recurring errors in qemu's stderr(or out)
>> >      =20
>> >       qemu-system-x86_64: Error opening /proc/2496093/task/2496109/sta=
t
>> >       qemu-system-x86_64: Error opening /proc/2496093/task/2496095/sta=
t
>> >
>> >       My guess it's some temporary threads, that come and go, but stil=
l
>> >       they shouldn't cause errors if it's normal operation.
>> > =20
>>=20
>> There a patch in WIP that change this into a Tracepoint. Maybe you can=
=20
>> SSH to the VM in meanwhile ?
>
> it's just idling VM that doesn't do anything, hence the question. =20
>
>>=20
>> >       Also on daemon side, I a few times got while guest was running:
>> >         qemu-vmsr-helper: Failed to open /proc at /proc/2496026/task/2=
496044
>> >         qemu-vmsr-helper: Requested TID not in peer PID: 2496026 24960=
44
>> >       though I can't reproduce it reliably =20
>>=20
>> This could happen only when a vCPU thread ID has changed between the=20
>> call of a rdmsr throught the socket and the hepler that read the msr.
>> No idea how a vCPU can change TID or shutdown that fast.
>
> I guess it needs to be figured out to decide if it's safe to ignore (and =
not print error)
> or if it's a genuine error/bug somewhere
>
>> >  3. when starting daemon not as root, it starts 'fine' but later on co=
mplains
>> >       qemu-vmsr-helper: Failed to open MSR file at /dev/cpu/0/msr
>> >     perhaps it would be better to fail at start daemon if it doesn't h=
ave
>> >     access to necessary files.
>> > =20
>>=20
>> Right taking a note on that as well.
>>=20
>>=20
>> >  4. in case #3, guest also fails to start with errors:
>> >       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/t=
mp/sock: can't read any virtual msr
>> >       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/t=
mp/sock: kvm : error RAPL feature requirement not met
>> >      again line #2 is not useful and probably not needed (maybe make i=
t tracepoint)
>> >      and #1 is unhelpful - it would be better if it directed user to c=
heck qemu-vmsr-helper
>> > =20
>>=20
>> I will try to see how to improve that part.=20
>> Thanks for your valuable feedback.
>>=20
>> >  5. does AMD have similar MSRs that we could use to make this feature =
complete?
>> > =20
>>=20
>> Yes but the address are completely different. However, this in my ToDo=
=20
>> list. First I need way more feedback like yours to move on extending=20
>> this feature.
>
> If adding AMD's MSRs is not difficult, then I'd make it priority.
> This way users (and libvirt) won't have to deal with 2 different
> feature-sets and decide when to allow this to be turned on depending on h=
ost.
>

QEMU needs to know if it runs on Intel or AMD machine in order to choose=20
which set of MSR it must read. I did not check how to achieve this at the=
=20
moment but I will when I will work on that.

>>=20
>> >  6. What happens to power accounting if host constantly migrates
>> >     vcpus between sockets, are values we are getting still correct/mea=
ningful?
>> >     Or do we need to pin vcpus to get 'accurate' values?
>> > =20
>>=20
>> It's taken into account during the ratio calculation which socket the=20
>> vCPU has just been scheduled. But yes the value are more 'accurate' when=
=20
>> the vCPU is pinned.
>
> in worst case VCPUs might be moved between sockets many times during
> sample window, can you explain how that is accounted for?
>

If one vCPU is moving socket during the sample period then it is=20
detected and not taken into account.

That said, if your system is bouncing vCPU back and forth between socket=20
then you will experience a lot of caches misses, cpu caches trashes,=20
context switches, increase of memory latency (numa issues), etc. This=20
will lead to performance degradation and VM performance being very poor.=20
Then you should probably fix it.=20

> Anyways, it would be better to have some numbers in doc that would
> clarify what kind of accuracy we are talking about (and example
> pinned vs unpinned), or whether unpinned case measures average
> temperature of patients in hospital and we should recommend
> to pin vcpus and everything else.
>

I totally understand that I can add more clarification in the=20
documentation that might be obvious for some but not for other. Like=20
isolating your VM properly will give better result.=20

But I won't give any number. It doesn't make sens. Accuracy is not the=20
goal of this feature, it never was and it never will. First of all=20
because RAPL is not accurate for power monitoring. You want accuracy?=20
Use a Power Metering device.=20
You want a reproducible way to compare power energy between=20
A and B in order to optimize your software ? Use can use RAPL and so=20
this feature that shows good reproducible results.

> Also actual usecase examples for the feature should be mentioned
> in the doc. So users could figure out when they need to enable
> this feature (with attached accuracy numbers). Aka how this
> new feature is good for end users and what they can do with it.
>

Got it. More documentation, use case, examples.=20
I will see what can be added to QEMU documentation.


>> >  7. do we have to have a dedicated thread for pooling data from daemon=
?
>> >
>> >     Can we fetch data from vcpu thread that have accessed msr
>> >     (with some caching and rate limiting access to the daemon)?
>> > =20
>>=20
>> This feature is revolving around a thread. Please look at the=20
>> documentation is not already done:
>>=20
>> https://www.qemu.org/docs/master/specs/rapl-msr.html#high-level-implemen=
tation
>>=20
>> If we only fetch from vCPU thread, we won't have the consumption of the=
=20
>> non-vcpu thread. They are taken into account in the total.
>
> one can collect the same data from vcpu thread as well,
> the bonus part is that we don't have an extra thread
> hanging around and doing work even if guest never asks
> for those MSRs.
>
> This also leads to a question, if we should account for
> not VCPU threads at all. Looking at real hardware, those
> MSRs return power usage of CPUs only, and they do not
> return consumption from auxiliary system components
> (io/memory/...). One can consider non VCPU threads in QEMU
> as auxiliary components, so we probably should not to
> account for them at all when modeling the same hw feature.
> (aka be consistent with what real hw does).
>
>> Thanks again for your feedback.=20
>>=20
>> Anthony
>>=20
>>=20
>> >> In this version (v6), I have attempted to address all the problems=20
>> >> addressed by Daniel and Paolo during the last review.=20
>> >>=20
>> >> However, two open questions remains unanswered that would require the=
=20
>> >> attention of a x86 maintainers:=20
>> >>=20
>> >> 1)Should I move from -kvm to -cpu the rapl feature ? [2]
>> >>=20
>> >> 2)Should I already rename to "rapl_vmsr_*" in order to anticipate the=
=20
>> >>   futur TMPI architecture ? [end of 3]=20
>> >>=20
>> >> Thank you again for your continued guidance.=20
>> >>=20
>> >> v5 -> v6
>> >> --------
>> >> - Better error consistency in qio_channel_get_peerpid()
>> >> - Memory leak g_strdup_printf/g_build_filename corrected
>> >> - Renaming several struct with "vmsr_*" for better namespace
>> >> - Renamed several struct with "guest_*" for better comprehension
>> >> - Optimization suggerate from Daniel
>> >> - Crash problem solved [4]
>> >>=20
>> >> v4 -> v5
>> >> --------
>> >>=20
>> >> - correct qio_channel_get_peerpid: return pid =3D -1 in case of error
>> >> - Vmsr_helper: compile only for x86
>> >> - Vmsr_helper: use qio_channel_read/write_all
>> >> - Vmsr_helper: abandon user/group
>> >> - Vmsr_energy.c: correct all error_report
>> >> - Vmsr thread: compute default socket path only once
>> >> - Vmsr thread: open socket only once
>> >> - Pass relevant QEMU CI
>> >>=20
>> >> v3 -> v4
>> >> --------
>> >>=20
>> >> - Correct memory leaks with AddressSanitizer =20
>> >> - Add sanity check for QEMU and qemu-vmsr-helper for checking if host=
 is=20
>> >>   INTEL and if RAPL is activated.
>> >> - Rename poor variables naming for easier comprehension
>> >> - Move code that checks Host before creating the VMSR thread
>> >> - Get rid of libnuma: create function that read sysfs for reading the=
=20
>> >>   Host topology instead
>> >>=20
>> >> v2 -> v3
>> >> --------
>> >>=20
>> >> - Move all memory allocations from Clib to Glib
>> >> - Compile on *BSD (working on Linux only)
>> >> - No more limitation on the virtual package: each vCPU that belongs t=
o=20
>> >>   the same virtual package is giving the same results like expected o=
n=20
>> >>   a real CPU.
>> >>   This has been tested topology like:
>> >>      -smp 4,sockets=3D2
>> >>      -smp 16,sockets=3D4,cores=3D2,threads=3D2
>> >>=20
>> >> v1 -> v2
>> >> --------
>> >>=20
>> >> - To overcome the CVE-2020-8694 a socket communication is created
>> >>   to a priviliged helper
>> >> - Add the priviliged helper (qemu-vmsr-helper)
>> >> - Add SO_PEERCRED in qio channel socket
>> >>=20
>> >> RFC -> v1
>> >> ---------
>> >>=20
>> >> - Add vmsr_* in front of all vmsr specific function
>> >> - Change malloc()/calloc()... with all glib equivalent
>> >> - Pre-allocate all dynamic memories when possible
>> >> - Add a Documentation of implementation, limitation and usage
>> >>=20
>> >> Best regards,
>> >> Anthony
>> >>=20
>> >> [1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.ht=
ml
>> >> [2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.ht=
ml
>> >> [3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.ht=
ml
>> >> [4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.ht=
ml
>> >>=20
>> >> Anthony Harivel (3):
>> >>   qio: add support for SO_PEERCRED for socket channel
>> >>   tools: build qemu-vmsr-helper
>> >>   Add support for RAPL MSRs in KVM/Qemu
>> >>=20
>> >>  accel/kvm/kvm-all.c                      |  27 ++
>> >>  contrib/systemd/qemu-vmsr-helper.service |  15 +
>> >>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
>> >>  docs/specs/index.rst                     |   1 +
>> >>  docs/specs/rapl-msr.rst                  | 155 +++++++
>> >>  docs/tools/index.rst                     |   1 +
>> >>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
>> >>  include/io/channel.h                     |  21 +
>> >>  include/sysemu/kvm_int.h                 |  32 ++
>> >>  io/channel-socket.c                      |  28 ++
>> >>  io/channel.c                             |  13 +
>> >>  meson.build                              |   7 +
>> >>  target/i386/cpu.h                        |   8 +
>> >>  target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
>> >>  target/i386/kvm/meson.build              |   1 +
>> >>  target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
>> >>  target/i386/kvm/vmsr_energy.h            |  99 +++++
>> >>  tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++=
++
>> >>  tools/i386/rapl-msr-index.h              |  28 ++
>> >>  19 files changed, 1831 insertions(+), 1 deletion(-)
>> >>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>> >>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>> >>  create mode 100644 docs/specs/rapl-msr.rst
>> >>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>> >>  create mode 100644 target/i386/kvm/vmsr_energy.c
>> >>  create mode 100644 target/i386/kvm/vmsr_energy.h
>> >>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>> >>  create mode 100644 tools/i386/rapl-msr-index.h
>> >>  =20
>>=20


