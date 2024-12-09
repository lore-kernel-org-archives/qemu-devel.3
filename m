Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7F2E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 14:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKes4-0004xl-OM; Mon, 09 Dec 2024 09:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKes1-0004xX-5W
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tKerx-0006wY-TE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733754974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snZHmB30c8wcMX3yTApXUTdGbEU97eR2GZ9aOEcYI4c=;
 b=RQVoMEz8fSZqA+SWnfrMWSL48mli4H8R3fbjdrswGUR5hAGLa97iFH070h41DE/EOT6c4i
 LrZfmill5ytkk+1AMU5Tf0Y0g6MwS+rl9QYOuxYfKCZq36jzTPv4J5Mm/lXufww4SH52I1
 lrJkWBXv3erx284q1wlMNNv7Phr0mOI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-l_Y8yYzbMJScTdp4RUHsNg-1; Mon, 09 Dec 2024 09:36:13 -0500
X-MC-Unique: l_Y8yYzbMJScTdp4RUHsNg-1
X-Mimecast-MFC-AGG-ID: l_Y8yYzbMJScTdp4RUHsNg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso2396997f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 06:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733754972; x=1734359772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snZHmB30c8wcMX3yTApXUTdGbEU97eR2GZ9aOEcYI4c=;
 b=QmRA9E30E97ZxM/3jRXf1R37HGJdwda1rwhe0rgjHTl7Mhd7nRlvWATuuXAePCX0pK
 McZ8MPULKCHszeHWWNm3PUtsTYBA56X+/Dg3Fdq0K5AWCz/+Zqnlf6JGiH2OsmQaYVOH
 /SzwVJmKCBJmLahhH79IAjEJCmc1po90u33OAGGPm6xOir/CvNDXCmlN2+qv1olMDWJP
 8ymw9Ek9sTbMVDm3ZNkFMyS6s0I8YjgNfUJix2paWJVRTxzJ9Rj4w5Km8+KKyGSwvft6
 Wq7SUvlPY+PgF6sszxWmYNS5pnXNJNT+TPhceOHkBMo3JYzF4Z9kN2Bd33GEa2WsPLzf
 AJMg==
X-Gm-Message-State: AOJu0Ywgkc4tbJtKw5L1i7cVn3zwvtq3z84xVGe5qRfYifJBBy8QF04H
 W52FGgKMBO3HEOiip0Vw6Rpc01EL6FYcKae4ykCW94oJteNKYe7yT87A/lreKVsekFSoasmtbHZ
 B9PjdsRBnTSeGvN8WD8qVhYLmUPO/tK8bO/8p9JPmTOjri69DH+zY
X-Gm-Gg: ASbGncs7WpmcsWQVHh9C2HoZ8EU4PAhv1mMCCD4kaawN/eGRl6Y8/yPMAtPsyzo5gwQ
 wESZJT5SMfZ+mS79opLTctw8nUj23bgAwtHPX5a2X9KP7f5o3sjkOgjvCbOaO9g6jgUPE6+yE+/
 XO2jmZTLKxBTZAm5Mi7lnLiviufu82u1CHZNgx3FqrRYZicHVhIoCfYXqxI4V1NTQ2QJM51PenX
 9/i++FlXoiJrvmGBBwOH6AUGsCHkVZ2sZtoJqLSB53Ft4AujN+RO//ttjYFFEnLfBYMqAUUknZ4
 HrDigxgNZyOz5SJM6mt5fw==
X-Received: by 2002:a05:6000:1842:b0:385:e4a7:df07 with SMTP id
 ffacd0b85a97d-386453fbb86mr426408f8f.42.1733754971789; 
 Mon, 09 Dec 2024 06:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4mQI8oMuSx1Dcx0zyTba4IOFHUolJGLB7Fx64vWkrIulf5bsrJPKfCFeM/7iq+mUlMVJGLg==
X-Received: by 2002:a05:6000:1842:b0:385:e4a7:df07 with SMTP id
 ffacd0b85a97d-386453fbb86mr426393f8f.42.1733754971407; 
 Mon, 09 Dec 2024 06:36:11 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434fd4b2898sm18957295e9.19.2024.12.09.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 06:36:10 -0800 (PST)
Date: Mon, 9 Dec 2024 15:36:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Mackay <eric.mackay@oracle.com>
Cc: qemu-devel@nongnu.org, boris.ostrovsky@oracle.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [RFC PATCH 0/1] ACPI: Fix missing CPU hotplug/hotunplug events
 with > 255 vCPUs
Message-ID: <20241209153606.49556593@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241204005636.18705-1-eric.mackay@oracle.com>
References: <20241204005636.18705-1-eric.mackay@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue,  3 Dec 2024 16:56:35 -0800
Eric Mackay <eric.mackay@oracle.com> wrote:

> ACPI hotplug with 255 or less vCPUs can use the legacy CPU hotplug interface, which does
> not support hotunplug. If it's available, hotunplug will use the modern CPU hotplug interface.
> This creates a situation where hotplug and hotunplug are using different interfaces, but
> the end result is still functional. CPUs can be hotplugged and hotunplugged at will.

only one kind of interface should be in use. And for quite a while firmware shipped
with QEMU is using QEMU provided ACPI tables, which in turn switch interface to
modern hotplug when guest OS loads ACPI tables, see:
         if (opts.has_legacy_cphp) {                                              
            method = aml_method("_INI", 0, AML_SERIALIZED);
or firmware does the switch (OVMF usecase) before guest OS. 

if any hotplug action happened before guest switched hotplug favour,
it will trigger SCI, which guest OS should process it (incl. switching
to modern interface and sending necessary device check/remove events)
once ACPI tables are processed.

> With > 255 vCPUs, both hotplug and hotunplug will use the modern ACPI interface.
> There is no priority or rules of mutual exclusion defined in this interface,
> and the behavior in the guest is implementation-defined.
> 
> Unfortunately, it is possible to have both a hotplug and hotunplug event pending
> for the same vCPU. When the guest processes its pending events, it may see the
> hotplug but ignore the hotunplug.
> 
> The most recent event is likely to reflect the desired state of the system, so
> ignoring the hotunplug event in this scenario is unacceptable.
QEMU has delivered both events as it was intended (and in order plug then unplug).
I'd say that ignoring events is a guest bug. 

With unplug, potentially if fixing guest is not an option
one can try retry device_del to trigger unplug event again.

PS:
I vaguely recall linux kernel wiping GPE state on boot during
initialization, but that is guest problem and should be fixed
on guest side.
(unexpectedly enough, Windows handles GPE state as expected)

> Repro: This can be seen in practice when a q35 VM is started in qemu, with
> maxcpus=260 or something above 255, and a few statically allocated CPUs.
> Example smp line: "-smp 4,sockets=2,dies=1,cores=65,threads=2,maxcpus=260"
> Then use libvirt to add vCPUs up to the maximum before continuing the VM. After
> the guest starts up, delete one of the vCPUs. 'lscpu' in the guest should still
> show 260.

above should work especially with unplug event happening after guest OS has booted.
Lets simplify reproducer to QEMU only (i.e. getting rid of libvirt part) and see
where it leads us.

> The proposed solution is to enforce mutual exclusion between the hotplug and hotunplug
> bits in the modern ACPI interface. Setting a new pending event will clear a previously
> pending event of the opposite type, thus preserving only the most recently requested
> state.

Once VM is in running state, clearing flags from QEMU side is not safe.
Effectively it would introduce a race with guest code.

Also I'm not sure that flags are the issue here,
Capturing some CPUHP traces on QEMU side and logs from guest side
might help to clarify what's going on. 

> Eric Mackay (1):
>   ACPI: Enforce mutual exclusion betwen CPU insertion and removal events
> 
>  hw/acpi/cpu.c         | 36 ++++++++++++++++++++++++++++++++----
>  include/hw/acpi/cpu.h |  4 ++++
>  2 files changed, 36 insertions(+), 4 deletions(-)
> 


