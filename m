Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF0E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 12:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKzid-0004hf-R9; Tue, 10 Dec 2024 07:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKziJ-0004gL-5Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 07:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKziH-0005du-D4
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 07:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733835099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPyybanmad0FLuxRatzsYWHqkMc3/rWd0IqmsyO6XOU=;
 b=VZwI6rda7rbbcmkbUdNe3XLDvGo8aePt5Ztiw8YtTKjnFh3jPkdq7D3hcU1sPNR/bDro4s
 ucO/MRhuNsOfmzs6CL5nfZrMHomd9T2gmtHNhet0D3mQSX53orrrvk11yACxLbwTWCkql3
 t2Q3XDhYjLZvJel0QFVT1NfZNRWwQxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-q18xvicqMWKeTxFWf7_Ihg-1; Tue, 10 Dec 2024 07:51:38 -0500
X-MC-Unique: q18xvicqMWKeTxFWf7_Ihg-1
X-Mimecast-MFC-AGG-ID: q18xvicqMWKeTxFWf7_Ihg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434fe2b605eso10314325e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 04:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733835097; x=1734439897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPyybanmad0FLuxRatzsYWHqkMc3/rWd0IqmsyO6XOU=;
 b=HGN1ivhgA+vZ3vMaMmlPdL5MhIiOiCBVyWqNgWPQIOWN4WyzgT/H10AH7m1whpTCzD
 Vt7rz6Bqn5f8PX0V9VMP8uwL7VZJM36FsVqtk+nE1M9qpkJQ51GQF74a6l1W7W3PZESH
 jR3nbil7vRpWrJRnkQl7cn5ltsUvasAE0wX7mYYEcWyuh+mQCiZQBQOeKi3VpgvO22+e
 a8wTNWtxKFgYlNy/r4C3lBtKaUflTNEx5hBvp6ohnyze/eUYdEmnvYhoxMRNZdlITe5c
 H5/AYWXKycFlDZs+7FBw3+7m1SyU/WtiDhVXVanBKkwt1zYjdBCFUhHgnyA/9ZzT4hkH
 m7pg==
X-Gm-Message-State: AOJu0YzC5025z3JG3EBL2vTPbAJXjUr3IyE3g2zMt7tnYyNPcX+flcDi
 hqbJ0fFaE4aV/TvUuCssXs+qWLtwwd1cTJ2VVpDaCWf8TSG991qu2ImBCUdWyC6CnKmlO0E7/Wj
 rA0GDXJMOD1Ik+sion7cmoYh5Qle8rPg55WKzVDKzuRQfn39tH5Hi
X-Gm-Gg: ASbGnctFJHYoyFUIgzaQ1aocAGo7xWQD+5tvVW/ce2o6uIouncFVvUlnvUCImEW+bKb
 wHhgQjmczd1ZYu1GuwrnzJuQhNV2EjjskNGI9sbiaQVyWZKF0cjR/QRA5RlIQY/46D4jtyNtWe3
 +H1C/64KfzAcKlmI4OWVrvFkm+o7F5WqM6nDcxCyfakWSRumaLJV+OO1vx5up4BHKRiNvoU2opj
 0l+zFazgwUc3WYl3QqbLczPKICGITKVkrP/muRDcLHJd8ioT7cHUQ16wkifyELgeQ4mKmbUzgMn
 /anvyulIKoeVPiSqkBygOqDl6Q==
X-Received: by 2002:a05:600c:3b87:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-434fffa2b17mr32631795e9.20.1733835096230; 
 Tue, 10 Dec 2024 04:51:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPHFURe9SxXSD6/iSwX7bNKwCxHV3anvx2r0ec2qVyUH7GnXYQZk9TLg794VpcGqlzt0fQQw==
X-Received: by 2002:a05:600c:3b87:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-434fffa2b17mr32631345e9.20.1733835094877; 
 Tue, 10 Dec 2024 04:51:34 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f981880csm71186785e9.44.2024.12.10.04.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 04:51:34 -0800 (PST)
Date: Tue, 10 Dec 2024 13:51:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Mackay <eric.mackay@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>
Subject: Re: [External] : Re: [RFC PATCH 0/1] ACPI: Fix missing CPU
 hotplug/hotunplug events with > 255 vCPUs
Message-ID: <20241210135133.1cad008c@imammedo.users.ipa.redhat.com>
In-Reply-To: <MN2PR10MB42694AF9F93475A6391AAC248C3D2@MN2PR10MB4269.namprd10.prod.outlook.com>
References: <20241204005636.18705-1-eric.mackay@oracle.com>
 <20241209153606.49556593@imammedo.users.ipa.redhat.com>
 <MN2PR10MB42694AF9F93475A6391AAC248C3D2@MN2PR10MB4269.namprd10.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue, 10 Dec 2024 01:22:24 +0000
Eric Mackay <eric.mackay@oracle.com> wrote:

> On Mon,  9 Dec 2024 15:36:06 +0100
> Igor Mammedov imammedo@redhat.com<mailto:imammedo@redhat.com> wrote:
> 
> > On Tue,  3 Dec 2024 16:56:35 -0800
> > Eric Mackay eric.mackay@oracle.com<mailto:eric.mackay@oracle.com> wrote:
> >  
> >> ACPI hotplug with 255 or less vCPUs can use the legacy CPU hotplug interface, which does
> >> not support hotunplug. If it's available, hotunplug will use the modern CPU hotplug interface.
> >> This creates a situation where hotplug and hotunplug are using different interfaces, but
> >> the end result is still functional. CPUs can be hotplugged and hotunplugged at will.  
> >
> > only one kind of interface should be in use. And for quite a while firmware shipped
> > with QEMU is using QEMU provided ACPI tables, which in turn switch interface to
> > modern hotplug when guest OS loads ACPI tables, see:
> >          if (opts.has_legacy_cphp) {
> >             method = aml_method("_INI", 0, AML_SERIALIZED);
> > or firmware does the switch (OVMF usecase) before guest OS.
> >
> > if any hotplug action happened before guest switched hotplug favour,
> > it will trigger SCI, which guest OS should process it (incl. switching
> > to modern interface and sending necessary device check/remove events)
> > once ACPI tables are processed.
> >  
> >> With > 255 vCPUs, both hotplug and hotunplug will use the modern ACPI interface.
> >> There is no priority or rules of mutual exclusion defined in this interface,
> >> and the behavior in the guest is implementation-defined.
> >>
> >> Unfortunately, it is possible to have both a hotplug and hotunplug event pending
> >> for the same vCPU. When the guest processes its pending events, it may see the
> >> hotplug but ignore the hotunplug.
> >>
> >> The most recent event is likely to reflect the desired state of the system, so
> >> ignoring the hotunplug event in this scenario is unacceptable.  
> >
> > QEMU has delivered both events as it was intended (and in order plug then unplug).
> > I'd say that ignoring events is a guest bug.
> >
> > With unplug, potentially if fixing guest is not an option
> > one can try retry device_del to trigger unplug event again.
> >
> > PS:
> > I vaguely recall linux kernel wiping GPE state on boot during
> > initialization, but that is guest problem and should be fixed
> > on guest side.
> > (unexpectedly enough, Windows handles GPE state as expected)  
> 
> Consider the scenario where a hotplug is requested, the hotplug bit is then set.
> ACPI event is sent to the guest. Before guest can act on it (either timing or
> perhaps the guest is paused), unplug is requested for that same CPU, and the
> unplug bit is now set. ACPI event is sent to guest again. The guest now wakes
> up or becomes able to perform work, sees there is a pending ACPI event. The
> guest now requests to read ACPI_CPU_FLAGS_OFFSET_RW, and sees both plug and
> unplug are set. How does it know which to do first?

looking at the code some more, it looks like 2 parties are at fault
 1. linux kernel clearing GPE status bits on boot without processing events,
    (if it had processed pending CPU hotplug event, that would have cleared all
     insert flags which are NOPs at this point)
 2. a bug in CPU_SCAN_METHOD AML code, which doesn't take remove event branch
    if there is insert event on the same CPU. So #1 effectively hides unplug
    until user triggers the next (un)plug event.
    Unplug request is just a request and if it didn't happen for some reason
    the user shall repeat it.
    However it doesn't excuse QEMU behavior which effectively doesn't process
    pending remove event in the same scan loop.


> >> Repro: This can be seen in practice when a q35 VM is started in qemu, with
> >> maxcpus=260 or something above 255, and a few statically allocated CPUs.
> >> Example smp line: "-smp 4,sockets=2,dies=1,cores=65,threads=2,maxcpus=260"
> >> Then use libvirt to add vCPUs up to the maximum before continuing the VM. After
> >> the guest starts up, delete one of the vCPUs. 'lscpu' in the guest should still
> >> show 260.  
> >
> > above should work especially with unplug event happening after guest OS has booted.
> > Lets simplify reproducer to QEMU only (i.e. getting rid of libvirt part) and see
> > where it leads us.  
> 
> The guest has not processed the hotplug events that took place before the guest
> OS booted. There is nothing to tell the guest OS that it needs to check ACPI
> event flags, or to clear the hotplug bits since the CPUs are already present.
> When the unplug comes, this is the first time the guest OS knows to check for
> hotplug/unplug events. When it reads ACPI_CPU_FLAGS_OFFSET_RW it will see that
> hotplug is still set for all the CPUs that came online before it booted, and it
> will recognize they are already present. For the CPU that a unplug was
> requested, the hotplug bit was never cleared prior, so the
> ACPI_CPU_FLAGS_OFFSET_RW read will show both hotplug and unplug flags set. It's
> now implementation-defined in the guest what it wants to do, or whether it
> assigns priority to one event type or the other.
> 
> Agreed, the libvirt part shouldn't be important. I can come up with instructions for QEMU-only repro.

one way to reproduce it would be use qmeu with uefi,
boot till grub prompt and then do device_del and let guest to finish boot.
The 2nd device_del works as workaround.


> >> The proposed solution is to enforce mutual exclusion between the hotplug and hotunplug
> >> bits in the modern ACPI interface. Setting a new pending event will clear a previously
> >> pending event of the opposite type, thus preserving only the most recently requested
> >> state.  
> >
> > Once VM is in running state, clearing flags from QEMU side is not safe.
> > Effectively it would introduce a race with guest code.  
> 
> Yes, I see what you mean. Agreed this is not safe.
> 
> > Also I'm not sure that flags are the issue here,
> > Capturing some CPUHP traces on QEMU side and logs from guest side
> > might help to clarify what's going on.  
> 
> Will work on providing those traces and logs
> 
> >> Eric Mackay (1):
> >>   ACPI: Enforce mutual exclusion betwen CPU insertion and removal events
> >>
> >>  hw/acpi/cpu.c         | 36 ++++++++++++++++++++++++++++++++----
> >>  include/hw/acpi/cpu.h |  4 ++++
> >>  2 files changed, 36 insertions(+), 4 deletions(-)
> >>  


