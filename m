Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C98D1AD53
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 13:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t13hx-0004E4-QP; Wed, 16 Oct 2024 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t13hu-0004Di-MW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t13hq-0000AA-5c
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729083887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YtS7wai1gtWlH9zNK5sIMJ83UyDg+78MLhmpA/pnEV4=;
 b=TamEW9dpJlRnq4YhS5Zkl8PHdzQSv5+RDEzgzP71bZsqWex4cjfXxIQZAZ/Er81uEkhd4i
 2taMBn9sdd2NDXLrXrTc+yVyXnqLUaEvLhB+zgwAhgCEDq6scHhk8oi+YNzHAl+0AsZ2zu
 i3GDQMmYTBnPs82TLaxKr805hFGaxQM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qP2RzaOIPwaTQu77K7JatQ-1; Wed, 16 Oct 2024 09:04:43 -0400
X-MC-Unique: qP2RzaOIPwaTQu77K7JatQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fb58c0df21so17808311fa.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729083882; x=1729688682;
 h=in-reply-to:references:user-agent:cc:to:from:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtS7wai1gtWlH9zNK5sIMJ83UyDg+78MLhmpA/pnEV4=;
 b=CNm7LBBl/kJI2vdM/lC5bXb76wae74TZAzm8X7ZFQT6uu4o0UY51AR7OF6O3VVgqRR
 fQfB6S9QfhovbN21IXTtMBoE0brnHEzUlO2GsOgckkvh+nT+pqnaxqR+Z7dPaf94r/eB
 xvegjqurNL+bQdOX/7pzQL1b2USbiVy812yQgsGqFVT7mKtuFZC2jmtr0bbNjsSFtWB8
 IBLTEhnw6TYpShaxmjB0grYbbxWgqjBQgBMrcU4RZmikalN53Rdao4ou49STKbf0qJ0J
 4WN4aCvzUxNKEIroS5Qg9EEaqfnDvgkBCsrTdySmbntWJxMt78QW5Fhf7EeEfqLBBD0n
 o2BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZvPU3m6K5zYtPFG16sgghPV1XT9g6b+cR8HVViM/58iQJvCJRueMmORr/xDCCJMlwb7OM06YHvUk4@nongnu.org
X-Gm-Message-State: AOJu0YwuyVCnj5oAeNnq+JAu1UhkVvs8HeLcTWbRCxRsfc+xtXnxcUDN
 lTGUOLhlw8BBGnkIwpB1RAA/ijYGzDi/YyGsgcyumad65EhJukF+RkscOsKnqdc2KDQ5LUV/Ck3
 Y6xF6Cgjd2sa5iyldm1rs51MXFOfHVckIv15WoFc3CmjqJnWYmZr6
X-Received: by 2002:a2e:be04:0:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2fb61ba26a7mr30606151fa.31.1729083881003; 
 Wed, 16 Oct 2024 06:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFShum/KY58Ogqn1ofdjlP7jSkLk/1REJcRWUWNmQoymKTMaoDG75/D0cz76z6Y6sCzR4VfA==
X-Received: by 2002:a2e:be04:0:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2fb61ba26a7mr30605581fa.31.1729083880122; 
 Wed, 16 Oct 2024 06:04:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569e9esm48470805e9.18.2024.10.16.06.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 06:04:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 15:04:39 +0200
Message-Id: <D4X92W5XEBK9.FA1VLA0EBZ6O@redhat.com>
Subject: Re: [PATCH v6 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Igor Mammedov" <imammedo@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
User-Agent: aerc/0.18.2-69-g1c54bb3a9d11
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20240522153453.1230389-4-aharivel@redhat.com>
 <20241016141751.01443340@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241016141751.01443340@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

Hi Igor,

I will let Paolo or Daniel answering those architecture questions, they=20
are more qualified than me.=20

Thanks
Anthony


Igor Mammedov, Oct 16, 2024 at 14:17:
> On Wed, 22 May 2024 17:34:52 +0200
> Anthony Harivel <aharivel@redhat.com> wrote:
>
>> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
>> interface (Running Average Power Limit) for advertising the accumulated
>> energy consumption of various power domains (e.g. CPU packages, DRAM,
>> etc.).
>>=20
>> The consumption is reported via MSRs (model specific registers) like
>> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
>> 64 bits registers that represent the accumulated energy consumption in
>> micro Joules. They are updated by microcode every ~1ms.
>>=20
>> For now, KVM always returns 0 when the guest requests the value of
>> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
>> these MSRs dynamically in userspace.
>>=20
>> To limit the amount of system calls for every MSR call, create a new
>> thread in QEMU that updates the "virtual" MSR values asynchronously.
>>=20
>> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
>> thread updates the vMSR values with the ratio of energy consumed of
>> the whole physical CPU package the vCPU thread runs on and the
>> thread's utime and stime values.
>>=20
>> All other non-vCPU threads are also taken into account. Their energy
>> consumption is evenly distributed among all vCPUs threads running on
>> the same physical CPU package.
>>=20
>> To overcome the problem that reading the RAPL MSR requires priviliged
>> access, a socket communication between QEMU and the qemu-vmsr-helper is
>> mandatory. You can specified the socket path in the parameter.
>>=20
>> This feature is activated with -accel kvm,rapl=3Dtrue,path=3D/path/sock.=
sock
>>=20
>> Actual limitation:
>> - Works only on Intel host CPU because AMD CPUs are using different MSR
>>   adresses.
>>=20
>> - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
>>   the moment.
>>=20
>> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c           |  27 +++
>>  docs/specs/index.rst          |   1 +
>>  docs/specs/rapl-msr.rst       | 155 ++++++++++++
>>  include/sysemu/kvm_int.h      |  32 +++
>>  target/i386/cpu.h             |   8 +
>>  target/i386/kvm/kvm.c         | 431 +++++++++++++++++++++++++++++++++-
>>  target/i386/kvm/meson.build   |   1 +
>>  target/i386/kvm/vmsr_energy.c | 344 +++++++++++++++++++++++++++
>>  target/i386/kvm/vmsr_energy.h |  99 ++++++++
>>  9 files changed, 1097 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/specs/rapl-msr.rst
>>  create mode 100644 target/i386/kvm/vmsr_energy.c
>>  create mode 100644 target/i386/kvm/vmsr_energy.h
>>=20
>
>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index c0be9f5eedb8..f455e6b987b4 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3745,6 +3745,21 @@ static void kvm_set_device(Object *obj,
>>      s->device =3D g_strdup(value);
>>  }
>> =20
>> +static void kvm_set_kvm_rapl(Object *obj, bool value, Error **errp)
>> +{
>> +    KVMState *s =3D KVM_STATE(obj);
>> +    s->msr_energy.enable =3D value;
>> +}
>> +
>> +static void kvm_set_kvm_rapl_socket_path(Object *obj,
>> +                                         const char *str,
>> +                                         Error **errp)
>> +{
>> +    KVMState *s =3D KVM_STATE(obj);
>> +    g_free(s->msr_energy.socket_path);
>> +    s->msr_energy.socket_path =3D g_strdup(str);
>> +}
>> +
>>  static void kvm_accel_instance_init(Object *obj)
>>  {
>>      KVMState *s =3D KVM_STATE(obj);
>> @@ -3764,6 +3779,7 @@ static void kvm_accel_instance_init(Object *obj)
>>      s->xen_gnttab_max_frames =3D 64;
>>      s->xen_evtchn_max_pirq =3D 256;
>>      s->device =3D NULL;
>> +    s->msr_energy.enable =3D false;
>>  }
>> =20
>>  /**
>> @@ -3808,6 +3824,17 @@ static void kvm_accel_class_init(ObjectClass *oc,=
 void *data)
>>      object_class_property_set_description(oc, "device",
>>          "Path to the device node to use (default: /dev/kvm)");
>> =20
>> +    object_class_property_add_bool(oc, "rapl",
>> +                                   NULL,
>> +                                   kvm_set_kvm_rapl);
>> +    object_class_property_set_description(oc, "rapl",
>> +        "Allow energy related MSRs for RAPL interface in Guest");
>> +
>> +    object_class_property_add_str(oc, "rapl-helper-socket", NULL,
>> +                                  kvm_set_kvm_rapl_socket_path);
>> +    object_class_property_set_description(oc, "rapl-helper-socket",
>> +        "Socket Path for comminucating with the Virtual MSR helper daem=
on");
>> +
>>      kvm_arch_accel_class_init(oc);
>>  }
>
> it seems, RAPL is x86 specific feature, so why it is in generic KVM code =
instead of
> target/i386/kvm/kvm.c: kvm_arch_accel_class_init()
>
>> =20
>> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
>> index 1484e3e76077..e738ea7d102f 100644
>> --- a/docs/specs/index.rst
>> +++ b/docs/specs/index.rst
>> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>>     virt-ctlr
>>     vmcoreinfo
>>     vmgenid
>> +   rapl-msr
>> diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
>> new file mode 100644
>> index 000000000000..1202ee89bee0
>> --- /dev/null
>> +++ b/docs/specs/rapl-msr.rst
>> @@ -0,0 +1,155 @@
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +RAPL MSR support
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +The RAPL interface (Running Average Power Limit) is advertising the acc=
umulated
>> +energy consumption of various power domains (e.g. CPU packages, DRAM, e=
tc.).
>> +
>> +The consumption is reported via MSRs (model specific registers) like
>> +MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are =
64 bits
>> +registers that represent the accumulated energy consumption in micro Jo=
ules.
>> +
>> +Thanks to the MSR Filtering patch [#a]_ not all MSRs are handled by KVM=
. Some
>> +of them can now be handled by the userspace (QEMU). It uses a mechanism=
 called
>> +"MSR filtering" where a list of MSRs is given at init time of a VM to K=
VM so
>> +that a callback is put in place. The design of this patch uses only thi=
s
>> +mechanism for handling the MSRs between guest/host.
>> +
>> +At the moment the following MSRs are involved:
>> +
>> +.. code:: C
>> +
>> +    #define MSR_RAPL_POWER_UNIT             0x00000606
>> +    #define MSR_PKG_POWER_LIMIT             0x00000610
>> +    #define MSR_PKG_ENERGY_STATUS           0x00000611
>> +    #define MSR_PKG_POWER_INFO              0x00000614
>> +
>> +The ``*_POWER_UNIT``, ``*_POWER_LIMIT``, ``*_POWER INFO`` are part of t=
he RAPL
>> +spec and specify the power limit of the package, provide range of param=
eter(min
>> +power, max power,..) and also the information of the multiplier for the=
 energy
>> +counter to calculate the power. Those MSRs are populated once at the be=
ginning
>> +by reading the host CPU MSRs and are given back to the guest 1:1 when
>> +requested.
>> +
>> +The MSR_PKG_ENERGY_STATUS is a counter; it represents the total amount =
of
>> +energy consumed since the last time the register was cleared. If you mu=
ltiply
>> +it with the UNIT provided above you'll get the power in micro-joules. T=
his
>> +counter is always increasing and it increases more or less faster depen=
ding on
>> +the consumption of the package. This counter is supposed to overflow at=
 some
>> +point.
>> +
>> +Each core belonging to the same Package reading the MSR_PKG_ENERGY_STAT=
US (i.e
>> +"rdmsr 0x611") will retrieve the same value. The value represents the e=
nergy
>> +for the whole package. Whatever Core reading it will get the same value=
 and a
>> +core that belongs to PKG-0 will not be able to get the value of PKG-1 a=
nd
>> +vice-versa.
>> +
>> +High level implementation
>> +-------------------------
>> +
>> +In order to update the value of the virtual MSR, a QEMU thread is creat=
ed.
>> +The thread is basically just an infinity loop that does:
>> +
>> +1. Snapshot of the time metrics of all QEMU threads (Time spent schedul=
ed in
>> +   Userspace and System)
>> +
>> +2. Snapshot of the actual MSR_PKG_ENERGY_STATUS counter of all packages=
 where
>> +   the QEMU threads are running on.
>> +
>> +3. Sleep for 1 second - During this pause the vcpu and other non-vcpu t=
hreads
>> +   will do what they have to do and so the energy counter will increase=
.
>> +
>> +4. Repeat 2. and 3. and calculate the delta of every metrics representi=
ng the
>> +   time spent scheduled for each QEMU thread *and* the energy spent by =
the
>> +   packages during the pause.
>> +
>> +5. Filter the vcpu threads and the non-vcpu threads.
>> +
>> +6. Retrieve the topology of the Virtual Machine. This helps identify wh=
ich
>> +   vCPU is running on which virtual package.
>> +
>> +7. The total energy spent by the non-vcpu threads is divided by the num=
ber
>> +   of vcpu threads so that each vcpu thread will get an equal part of t=
he
>> +   energy spent by the QEMU workers.
>> +
>> +8. Calculate the ratio of energy spent per vcpu threads.
>> +
>> +9. Calculate the energy for each virtual package.
>> +
>> +10. The virtual MSRs are updated for each virtual package. Each vCPU th=
at
>> +    belongs to the same package will return the same value when accessi=
ng the
>> +    the MSR.
>> +
>> +11. Loop back to 1.
>> +
>> +Ratio calculation
>> +-----------------
>> +
>> +In Linux, a process has an execution time associated with it. The sched=
uler is
>> +dividing the time in clock ticks. The number of clock ticks per second =
can be
>> +found by the sysconf system call. A typical value of clock ticks per se=
cond is
>> +100. So a core can run a process at the maximum of 100 ticks per second=
. If a
>> +package has 4 cores, 400 ticks maximum can be scheduled on all the core=
s
>> +of the package for a period of 1 second.
>> +
>> +The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed t=
ime of a
>> +process with the [pid] as the process ID. It gives the amount of ticks =
the
>> +process has been scheduled in userspace (utime) and kernel space (stime=
).
>> +
>> +By reading those metrics for a thread, one can calculate the ratio of t=
ime the
>> +package has spent executing the thread.
>> +
>> +Example:
>> +
>> +A 4 cores package can schedule a maximum of 400 ticks per second with 1=
00 ticks
>> +per second per core. If a thread was scheduled for 100 ticks between a =
second
>> +on this package, that means my thread has been scheduled for 1/4 of the=
 whole
>> +package. With that, the calculation of the energy spent by the thread o=
n this
>> +package during this whole second is 1/4 of the total energy spent by th=
e
>> +package.
>> +
>> +Usage
>> +-----
>> +
>> +Currently this feature is only working on an Intel CPU that has the RAP=
L driver
>> +mounted and available in the sysfs. if not, QEMU fails at start-up.
>> +
>> +This feature is activated with -accel
>> +kvm,rapl=3Dtrue,rapl-helper-socket=3D/path/sock.sock
>> +
>> +It is important that the socket path is the same as the one
>> +:program:`qemu-vmsr-helper` is listening to.
>> +
>> +qemu-vmsr-helper
>> +----------------
>> +
>> +The qemu-vmsr-helper is working very much like the qemu-pr-helper. Inst=
ead of
>> +making persistent reservation, qemu-vmsr-helper is here to overcome the
>> +CVE-2020-8694 which remove user access to the rapl msr attributes.
>> +
>> +A socket communication is established between QEMU processes that has t=
he RAPL
>> +MSR support activated and the qemu-vmsr-helper. A systemd service and s=
ocket
>> +activation is provided in contrib/systemd/qemu-vmsr-helper.(service/soc=
ket).
>> +
>> +The systemd socket uses 600, like contrib/systemd/qemu-pr-helper.socket=
. The
>> +socket can be passed via SCM_RIGHTS by libvirt, or its permissions can =
be
>> +changed (e.g. 660 and root:kvm for a Debian system for example). Libvir=
t could
>> +also start a separate helper if needed. All in all, the policy is left =
to the
>> +user.
>> +
>> +See the qemu-pr-helper documentation or manpage for further details.
>> +
>> +Current Limitations
>> +-------------------
>> +
>> +- Works only on Intel host CPUs because AMD CPUs are using different MS=
R
>> +  addresses.
>> +
>> +- Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at t=
he
>> +  moment.
>> +
>> +References
>> +----------
>> +
>> +.. [#a] https://patchwork.kernel.org/project/kvm/patch/20200916202951.2=
3760-7-graf@amazon.com/
>> +.. [#b] https://man7.org/linux/man-pages/man5/proc.5.html
>> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
>> index 3f3d13f81669..1d8fb1473bdf 100644
>> --- a/include/sysemu/kvm_int.h
>> +++ b/include/sysemu/kvm_int.h
>> @@ -14,6 +14,9 @@
>>  #include "qemu/accel.h"
>>  #include "qemu/queue.h"
>>  #include "sysemu/kvm.h"
>> +#include "hw/boards.h"
>> +#include "hw/i386/topology.h"
>> +#include "io/channel-socket.h"
>
>
> I'm skeptical about pulling in x86 specific headers into generic kvm head=
er,
> (it's miracle that it builds at all), and by extension 'board.h' as well
>
> can it be refactored in a way that you won't need to pull in 'board.h'
> and avoid using x86 specific code in generic KVM code?
> (which also applies to added below KVMHostTopoInfo)
>
>
>>  typedef struct KVMSlot
>>  {
>> @@ -50,6 +53,34 @@ typedef struct KVMMemoryListener {
>> =20
>>  #define KVM_MSI_HASHTAB_SIZE    256
>> =20
>> +typedef struct KVMHostTopoInfo {
>> +    /* Number of package on the Host */
>> +    unsigned int maxpkgs;
>> +    /* Number of cpus on the Host */
>> +    unsigned int maxcpus;
>> +    /* Number of cpus on each different package */
>> +    unsigned int *pkg_cpu_count;
>> +    /* Each package can have different maxticks */
>> +    unsigned int *maxticks;
>> +} KVMHostTopoInfo;
>> +
>> +struct KVMMsrEnergy {
>> +    pid_t pid;
>> +    bool enable;
>> +    char *socket_path;
>> +    QIOChannelSocket *sioc;
>> +    QemuThread msr_thr;
>> +    unsigned int guest_vcpus;
>> +    unsigned int guest_vsockets;
>> +    X86CPUTopoInfo guest_topo_info;
>> +    KVMHostTopoInfo host_topo;
>> +    const CPUArchIdList *guest_cpu_list;
>> +    uint64_t *msr_value;
>> +    uint64_t msr_unit;
>> +    uint64_t msr_limit;
>> +    uint64_t msr_info;
>> +};
>> +
>>  enum KVMDirtyRingReaperState {
>>      KVM_DIRTY_RING_REAPER_NONE =3D 0,
>>      /* The reaper is sleeping */
>> @@ -117,6 +148,7 @@ struct KVMState
>>      bool kvm_dirty_ring_with_bitmap;
>>      uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size =
*/
>>      struct KVMDirtyRingReaper reaper;
>> +    struct KVMMsrEnergy msr_energy;
>>      NotifyVmexitOption notify_vmexit;
>>      uint32_t notify_window;
>>      uint32_t xen_version;
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index ccccb62fc353..c3891c1a6b4e 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -397,6 +397,10 @@ typedef enum X86Seg {
>>  #define MSR_IA32_TSX_CTRL		0x122
>>  #define MSR_IA32_TSCDEADLINE            0x6e0
>>  #define MSR_IA32_PKRS                   0x6e1
>> +#define MSR_RAPL_POWER_UNIT             0x00000606
>> +#define MSR_PKG_POWER_LIMIT             0x00000610
>> +#define MSR_PKG_ENERGY_STATUS           0x00000611
>> +#define MSR_PKG_POWER_INFO              0x00000614
>>  #define MSR_ARCH_LBR_CTL                0x000014ce
>>  #define MSR_ARCH_LBR_DEPTH              0x000014cf
>>  #define MSR_ARCH_LBR_FROM_0             0x00001500
>> @@ -1790,6 +1794,10 @@ typedef struct CPUArchState {
>> =20
>>      uintptr_t retaddr;
>> =20
>> +    /* RAPL MSR */
>> +    uint64_t msr_rapl_power_unit;
>> +    uint64_t msr_pkg_energy_status;
>> +
>>      /* Fields up to this point are cleared by a CPU reset */
>>      struct {} end_reset_fields;
>> =20
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index c5943605ee3a..8767c8e06028 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>
> I'd also suggest to move most of rapl related code added here to vmsr_ene=
rgy.c,
> and leave only msr access plumbing here.
> (this file is already huge and adding 400+ loc isn't helping its readabil=
ity at all)
>
>> @@ -16,9 +16,12 @@
>>  #include "qapi/qapi-events-run-state.h"
>>  #include "qapi/error.h"
>>  #include "qapi/visitor.h"
>> +#include <math.h>
>>  #include <sys/ioctl.h>
>>  #include <sys/utsname.h>
>>  #include <sys/syscall.h>
>> +#include <sys/resource.h>
>> +#include <sys/time.h>
>> =20
>>  #include <linux/kvm.h>
>>  #include "standard-headers/asm-x86/kvm_para.h"
>> @@ -26,6 +29,7 @@
>> =20
>>  #include "cpu.h"
>>  #include "host-cpu.h"
>> +#include "vmsr_energy.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/hw_accel.h"
>>  #include "sysemu/kvm_int.h"
>> @@ -2519,7 +2523,8 @@ static int kvm_get_supported_msrs(KVMState *s)
>>      return ret;
>>  }
>> =20
>> -static bool kvm_rdmsr_core_thread_count(X86CPU *cpu, uint32_t msr,
>> +static bool kvm_rdmsr_core_thread_count(X86CPU *cpu,
>> +                                        uint32_t msr,
>>                                          uint64_t *val)
>>  {
>>      CPUState *cs =3D CPU(cpu);
>> @@ -2530,6 +2535,53 @@ static bool kvm_rdmsr_core_thread_count(X86CPU *c=
pu, uint32_t msr,
>>      return true;
>>  }
>> =20
>> +static bool kvm_rdmsr_rapl_power_unit(X86CPU *cpu,
>> +                                      uint32_t msr,
>> +                                      uint64_t *val)
>> +{
>> +
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    *val =3D cs->kvm_state->msr_energy.msr_unit;
>> +
>> +    return true;
>> +}
>> +
>> +static bool kvm_rdmsr_pkg_power_limit(X86CPU *cpu,
>> +                                      uint32_t msr,
>> +                                      uint64_t *val)
>> +{
>> +
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    *val =3D cs->kvm_state->msr_energy.msr_limit;
>> +
>> +    return true;
>> +}
>> +
>> +static bool kvm_rdmsr_pkg_power_info(X86CPU *cpu,
>> +                                     uint32_t msr,
>> +                                     uint64_t *val)
>> +{
>> +
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    *val =3D cs->kvm_state->msr_energy.msr_info;
>> +
>> +    return true;
>> +}
>> +
>> +static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu,
>> +                                        uint32_t msr,
>> +                                        uint64_t *val)
>> +{
>> +
>> +    CPUState *cs =3D CPU(cpu);
>> +    *val =3D cs->kvm_state->msr_energy.msr_value[cs->cpu_index];
>> +
>> +    return true;
>> +}
>> +
>>  static Notifier smram_machine_done;
>>  static KVMMemoryListener smram_listener;
>>  static AddressSpace smram_address_space;
>> @@ -2564,6 +2616,340 @@ static void register_smram_listener(Notifier *n,=
 void *unused)
>>                                   &smram_address_space, 1, "kvm-smram");
>>  }
>> =20
>> +static void *kvm_msr_energy_thread(void *data)
>> +{
>> +    KVMState *s =3D data;
>> +    struct KVMMsrEnergy *vmsr =3D &s->msr_energy;
>> +
>> +    g_autofree vmsr_package_energy_stat *pkg_stat =3D NULL;
>> +    g_autofree vmsr_thread_stat *thd_stat =3D NULL;
>> +    g_autofree CPUState *cpu =3D NULL;
>> +    g_autofree unsigned int *vpkgs_energy_stat =3D NULL;
>> +    unsigned int num_threads =3D 0;
>> +
>> +    X86CPUTopoIDs topo_ids;
>> +
>> +    rcu_register_thread();
>> +
>> +    /* Allocate memory for each package energy status */
>> +    pkg_stat =3D g_new0(vmsr_package_energy_stat, vmsr->host_topo.maxpk=
gs);
>> +
>> +    /* Allocate memory for thread stats */
>> +    thd_stat =3D g_new0(vmsr_thread_stat, 1);
>> +
>> +    /* Allocate memory for holding virtual package energy counter */
>> +    vpkgs_energy_stat =3D g_new0(unsigned int, vmsr->guest_vsockets);
>> +
>> +    /* Populate the max tick of each packages */
>> +    for (int i =3D 0; i < vmsr->host_topo.maxpkgs; i++) {
>> +        /*
>> +         * Max numbers of ticks per package
>> +         * Time in second * Number of ticks/second * Number of cores/pa=
ckage
>> +         * ex: 100 ticks/second/CPU, 12 CPUs per Package gives 1200 tic=
ks max
>> +         */
>> +        vmsr->host_topo.maxticks[i] =3D (MSR_ENERGY_THREAD_SLEEP_US / 1=
000000)
>> +                        * sysconf(_SC_CLK_TCK)
>> +                        * vmsr->host_topo.pkg_cpu_count[i];
>> +    }
>> +
>> +    while (true) {
>> +        /* Get all qemu threads id */
>> +        g_autofree pid_t *thread_ids =3D
>> +            thread_ids =3D vmsr_get_thread_ids(vmsr->pid, &num_threads)=
;
>> +
>> +        if (thread_ids =3D=3D NULL) {
>> +            goto clean;
>> +        }
>> +
>> +        thd_stat =3D g_renew(vmsr_thread_stat, thd_stat, num_threads);
>> +        /* Unlike g_new0, g_renew0 function doesn't exist yet... */
>> +        memset(thd_stat, 0, num_threads * sizeof(vmsr_thread_stat));
>> +
>> +        /* Populate all the thread stats */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            thd_stat[i].utime =3D g_new0(unsigned long long, 2);
>> +            thd_stat[i].stime =3D g_new0(unsigned long long, 2);
>> +            thd_stat[i].thread_id =3D thread_ids[i];
>> +            vmsr_read_thread_stat(vmsr->pid,
>> +                                  thd_stat[i].thread_id,
>> +                                  thd_stat[i].utime,
>> +                                  thd_stat[i].stime,
>> +                                  &thd_stat[i].cpu_id);
>> +            thd_stat[i].pkg_id =3D
>> +                vmsr_get_physical_package_id(thd_stat[i].cpu_id);
>> +        }
>> +
>> +        /* Retrieve all packages power plane energy counter */
>> +        for (int i =3D 0; i < vmsr->host_topo.maxpkgs; i++) {
>> +            for (int j =3D 0; j < num_threads; j++) {
>> +                /*
>> +                 * Use the first thread we found that ran on the CPU
>> +                 * of the package to read the packages energy counter
>> +                 */
>> +                if (thd_stat[j].pkg_id =3D=3D i) {
>> +                    pkg_stat[i].e_start =3D
>> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
>> +                                  thd_stat[j].cpu_id,
>> +                                  thd_stat[j].thread_id,
>> +                                  s->msr_energy.sioc);
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +
>> +        /* Sleep a short period while the other threads are working */
>> +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
>> +
>> +        /*
>> +         * Retrieve all packages power plane energy counter
>> +         * Calculate the delta of all packages
>> +         */
>> +        for (int i =3D 0; i < vmsr->host_topo.maxpkgs; i++) {
>> +            for (int j =3D 0; j < num_threads; j++) {
>> +                /*
>> +                 * Use the first thread we found that ran on the CPU
>> +                 * of the package to read the packages energy counter
>> +                 */
>> +                if (thd_stat[j].pkg_id =3D=3D i) {
>> +                    pkg_stat[i].e_end =3D
>> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
>> +                                  thd_stat[j].cpu_id,
>> +                                  thd_stat[j].thread_id,
>> +                                  s->msr_energy.sioc);
>> +                    /*
>> +                     * Prevent the case we have migrate the VM
>> +                     * during the sleep period or any other cases
>> +                     * were energy counter might be lower after
>> +                     * the sleep period.
>> +                     */
>> +                    if (pkg_stat[i].e_end > pkg_stat[i].e_start) {
>> +                        pkg_stat[i].e_delta =3D
>> +                            pkg_stat[i].e_end - pkg_stat[i].e_start;
>> +                    } else {
>> +                        pkg_stat[i].e_delta =3D 0;
>> +                    }
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +
>> +        /* Delta of ticks spend by each thread between the sample */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            vmsr_read_thread_stat(vmsr->pid,
>> +                                  thd_stat[i].thread_id,
>> +                                  thd_stat[i].utime,
>> +                                  thd_stat[i].stime,
>> +                                  &thd_stat[i].cpu_id);
>> +
>> +            if (vmsr->pid < 0) {
>> +                /*
>> +                 * We don't count the dead thread
>> +                 * i.e threads that existed before the sleep
>> +                 * and not anymore
>> +                 */
>> +                thd_stat[i].delta_ticks =3D 0;
>> +            } else {
>> +                vmsr_delta_ticks(thd_stat, i);
>> +            }
>> +        }
>> +
>> +        /*
>> +         * Identify the vcpu threads
>> +         * Calculate the number of vcpu per package
>> +         */
>> +        CPU_FOREACH(cpu) {
>> +            for (int i =3D 0; i < num_threads; i++) {
>> +                if (cpu->thread_id =3D=3D thd_stat[i].thread_id) {
>> +                    thd_stat[i].is_vcpu =3D true;
>> +                    thd_stat[i].vcpu_id =3D cpu->cpu_index;
>> +                    pkg_stat[thd_stat[i].pkg_id].nb_vcpu++;
>> +                    thd_stat[i].acpi_id =3D kvm_arch_vcpu_id(cpu);
>> +                    break;
>> +                }
>> +            }
>> +        }
>> +
>> +        /* Retrieve the virtual package number of each vCPU */
>> +        for (int i =3D 0; i < vmsr->guest_cpu_list->len; i++) {
>> +            for (int j =3D 0; j < num_threads; j++) {
>> +                if ((thd_stat[j].acpi_id =3D=3D
>> +                        vmsr->guest_cpu_list->cpus[i].arch_id)
>> +                    && (thd_stat[j].is_vcpu =3D=3D true)) {
>> +                    x86_topo_ids_from_apicid(thd_stat[j].acpi_id,
>> +                        &vmsr->guest_topo_info, &topo_ids);
>> +                    thd_stat[j].vpkg_id =3D topo_ids.pkg_id;
>> +                }
>> +            }
>> +        }
>> +
>> +        /* Calculate the total energy of all non-vCPU thread */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            if ((thd_stat[i].is_vcpu !=3D true) &&
>> +                (thd_stat[i].delta_ticks > 0)) {
>> +                double temp;
>> +                temp =3D vmsr_get_ratio(pkg_stat[thd_stat[i].pkg_id].e_=
delta,
>> +                    thd_stat[i].delta_ticks,
>> +                    vmsr->host_topo.maxticks[thd_stat[i].pkg_id]);
>> +                pkg_stat[thd_stat[i].pkg_id].e_ratio
>> +                    +=3D (uint64_t)lround(temp);
>> +            }
>> +        }
>> +
>> +        /* Calculate the ratio per non-vCPU thread of each package */
>> +        for (int i =3D 0; i < vmsr->host_topo.maxpkgs; i++) {
>> +            if (pkg_stat[i].nb_vcpu > 0) {
>> +                pkg_stat[i].e_ratio =3D pkg_stat[i].e_ratio / pkg_stat[=
i].nb_vcpu;
>> +            }
>> +        }
>> +
>> +        /*
>> +         * Calculate the energy for each Package:
>> +         * Energy Package =3D sum of each vCPU energy that belongs to t=
he package
>> +         */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            if ((thd_stat[i].is_vcpu =3D=3D true) && \
>> +                    (thd_stat[i].delta_ticks > 0)) {
>> +                double temp;
>> +                temp =3D vmsr_get_ratio(pkg_stat[thd_stat[i].pkg_id].e_=
delta,
>> +                    thd_stat[i].delta_ticks,
>> +                    vmsr->host_topo.maxticks[thd_stat[i].pkg_id]);
>> +                vpkgs_energy_stat[thd_stat[i].vpkg_id] +=3D
>> +                    (uint64_t)lround(temp);
>> +                vpkgs_energy_stat[thd_stat[i].vpkg_id] +=3D
>> +                    pkg_stat[thd_stat[i].pkg_id].e_ratio;
>> +            }
>> +        }
>> +
>> +        /*
>> +         * Finally populate the vmsr register of each vCPU with the tot=
al
>> +         * package value to emulate the real hardware where each CPU re=
turn the
>> +         * value of the package it belongs.
>> +         */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            if ((thd_stat[i].is_vcpu =3D=3D true) && \
>> +                    (thd_stat[i].delta_ticks > 0)) {
>> +                vmsr->msr_value[thd_stat[i].vcpu_id] =3D \
>> +                                        vpkgs_energy_stat[thd_stat[i].v=
pkg_id];
>> +          }
>> +        }
>> +
>> +        /* Freeing memory before zeroing the pointer */
>> +        for (int i =3D 0; i < num_threads; i++) {
>> +            g_free(thd_stat[i].utime);
>> +            g_free(thd_stat[i].stime);
>> +        }
>> +   }
>> +
>> +clean:
>> +    rcu_unregister_thread();
>> +    return NULL;
>> +}
>> +
>> +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
>> +{
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>> +    struct KVMMsrEnergy *r =3D &s->msr_energy;
>> +    int ret =3D 0;
>> +
>> +    /*
>> +     * Sanity check
>> +     * 1. Host cpu must be Intel cpu
>> +     * 2. RAPL must be enabled on the Host
>> +     */
>> +    if (is_host_cpu_intel()) {
>> +        error_report("The RAPL feature can only be enabled on hosts\
>> +                      with Intel CPU models");
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    if (!is_rapl_enabled()) {
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    /* Retrieve the virtual topology */
>> +    vmsr_init_topo_info(&r->guest_topo_info, ms);
>> +
>> +    /* Retrieve the number of vcpu */
>> +    r->guest_vcpus =3D ms->smp.cpus;
>> +
>> +    /* Retrieve the number of virtual sockets */
>> +    r->guest_vsockets =3D ms->smp.sockets;
>> +
>> +    /* Allocate register memory (MSR_PKG_STATUS) for each vcpu */
>> +    r->msr_value =3D g_new0(uint64_t, r->guest_vcpus);
>> +
>> +    /* Retrieve the CPUArchIDlist */
>> +    r->guest_cpu_list =3D mc->possible_cpu_arch_ids(ms);
>> +
>> +    /* Max number of cpus on the Host */
>> +    r->host_topo.maxcpus =3D vmsr_get_maxcpus();
>> +    if (r->host_topo.maxcpus =3D=3D 0) {
>> +        error_report("host max cpus =3D 0");
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    /* Max number of packages on the host */
>> +    r->host_topo.maxpkgs =3D vmsr_get_max_physical_package(r->host_topo=
.maxcpus);
>> +    if (r->host_topo.maxpkgs =3D=3D 0) {
>> +        error_report("host max pkgs =3D 0");
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    /* Allocate memory for each package on the host */
>> +    r->host_topo.pkg_cpu_count =3D g_new0(unsigned int, r->host_topo.ma=
xpkgs);
>> +    r->host_topo.maxticks =3D g_new0(unsigned int, r->host_topo.maxpkgs=
);
>> +
>> +    vmsr_count_cpus_per_package(r->host_topo.pkg_cpu_count,
>> +                                r->host_topo.maxpkgs);
>> +    for (int i =3D 0; i < r->host_topo.maxpkgs; i++) {
>> +        if (r->host_topo.pkg_cpu_count[i] =3D=3D 0) {
>> +            error_report("cpu per packages =3D 0 on package_%d", i);
>> +            ret =3D 1;
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    /* Get QEMU PID*/
>> +    r->pid =3D getpid();
>> +
>> +    /* Compute the socket path if necessary */
>> +    if (s->msr_energy.socket_path =3D=3D NULL) {
>> +        s->msr_energy.socket_path =3D vmsr_compute_default_paths();
>> +    }
>> +
>> +    /* Open socket with vmsr helper */
>> +    s->msr_energy.sioc =3D vmsr_open_socket(s->msr_energy.socket_path);
>> +
>> +    if (s->msr_energy.sioc =3D=3D NULL) {
>> +        error_report("vmsr socket opening failed");
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    /* Those MSR values should not change */
>> +    r->msr_unit  =3D vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, r->pid,
>> +                                    s->msr_energy.sioc);
>> +    r->msr_limit =3D vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, r->pid,
>> +                                    s->msr_energy.sioc);
>> +    r->msr_info  =3D vmsr_read_msr(MSR_PKG_POWER_INFO, 0, r->pid,
>> +                                    s->msr_energy.sioc);
>> +    if (r->msr_unit =3D=3D 0 || r->msr_limit =3D=3D 0 || r->msr_info =
=3D=3D 0) {
>> +        error_report("can't read any virtual msr");
>> +        ret =3D 1;
>> +        goto out;
>> +    }
>> +
>> +    qemu_thread_create(&r->msr_thr, "kvm-msr",
>> +                       kvm_msr_energy_thread,
>> +                       s, QEMU_THREAD_JOINABLE);
>> +out:
>> +    return ret;
>> +}
>> +
>>  int kvm_arch_get_default_type(MachineState *ms)
>>  {
>>      return 0;
>> @@ -2768,6 +3154,49 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>                           strerror(-ret));
>>              exit(1);
>>          }
>> +
>> +        if (s->msr_energy.enable =3D=3D true) {
>> +            r =3D kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
>> +                               kvm_rdmsr_rapl_power_unit, NULL);
>> +            if (!r) {
>> +                error_report("Could not install MSR_RAPL_POWER_UNIT \
>> +                                handler: %s",
>> +                             strerror(-ret));
>> +                exit(1);
>> +            }
>> +
>> +            r =3D kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
>> +                               kvm_rdmsr_pkg_power_limit, NULL);
>> +            if (!r) {
>> +                error_report("Could not install MSR_PKG_POWER_LIMIT \
>> +                                handler: %s",
>> +                             strerror(-ret));
>> +                exit(1);
>> +            }
>> +
>> +            r =3D kvm_filter_msr(s, MSR_PKG_POWER_INFO,
>> +                               kvm_rdmsr_pkg_power_info, NULL);
>> +            if (!r) {
>> +                error_report("Could not install MSR_PKG_POWER_INFO \
>> +                                handler: %s",
>> +                             strerror(-ret));
>> +                exit(1);
>> +            }
>> +            r =3D kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
>> +                               kvm_rdmsr_pkg_energy_status, NULL);
>> +            if (!r) {
>> +                error_report("Could not install MSR_PKG_ENERGY_STATUS \
>> +                                handler: %s",
>> +                             strerror(-ret));
>> +                exit(1);
>> +            }
>> +            r =3D kvm_msr_energy_thread_init(s, ms);
>> +            if (r) {
>> +                error_report("kvm : error RAPL feature requirement not =
meet");
>> +                exit(1);
>> +            }
>> +
>> +        }
>>      }
>> =20
>>      return 0;
>> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
>> index e7850981e62d..3996cafaf29f 100644
>> --- a/target/i386/kvm/meson.build
>> +++ b/target/i386/kvm/meson.build
>> @@ -3,6 +3,7 @@ i386_kvm_ss =3D ss.source_set()
>>  i386_kvm_ss.add(files(
>>    'kvm.c',
>>    'kvm-cpu.c',
>> +  'vmsr_energy.c',
>>  ))
>> =20
>>  i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>> diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy=
.c
>> new file mode 100644
>> index 000000000000..acf0fc0a2fb3
>> --- /dev/null
>> +++ b/target/i386/kvm/vmsr_energy.c
>> @@ -0,0 +1,344 @@
>> +/*
>> + * QEMU KVM support -- x86 virtual RAPL msr
>> + *
>> + * Copyright 2024 Red Hat, Inc. 2024
>> + *
>> + *  Author:
>> + *      Anthony Harivel <aharivel@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "vmsr_energy.h"
>> +#include "io/channel.h"
>> +#include "io/channel-socket.h"
>> +#include "hw/boards.h"
>> +#include "cpu.h"
>> +#include "host-cpu.h"
>> +
>> +char *vmsr_compute_default_paths(void)
>> +{
>> +    g_autofree char *state =3D qemu_get_local_state_dir();
>> +
>> +    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL=
);
>> +}
>> +
>> +bool is_host_cpu_intel(void)
>> +{
>> +    int family, model, stepping;
>> +    char vendor[CPUID_VENDOR_SZ + 1];
>> +
>> +    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
>> +
>> +    return strcmp(vendor, CPUID_VENDOR_INTEL);
>> +}
>> +
>> +int is_rapl_enabled(void)
>> +{
>> +    const char *path =3D "/sys/class/powercap/intel-rapl/enabled";
>> +    FILE *file =3D fopen(path, "r");
>> +    int value =3D 0;
>> +
>> +    if (file !=3D NULL) {
>> +        if (fscanf(file, "%d", &value) !=3D 1) {
>> +            error_report("INTEL RAPL not enabled");
>> +        }
>> +        fclose(file);
>> +    } else {
>> +        error_report("Error opening %s", path);
>> +    }
>> +
>> +    return value;
>> +}
>> +
>> +QIOChannelSocket *vmsr_open_socket(const char *path)
>> +{
>> +    g_autofree char *socket_path =3D NULL;
>> +
>> +    socket_path =3D g_strdup(path);
>> +
>> +    SocketAddress saddr =3D {
>> +        .type =3D SOCKET_ADDRESS_TYPE_UNIX,
>> +        .u.q_unix.path =3D socket_path
>> +    };
>> +
>> +    QIOChannelSocket *sioc =3D qio_channel_socket_new();
>> +    Error *local_err =3D NULL;
>> +
>> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
>> +    qio_channel_socket_connect_sync(sioc,
>> +                                    &saddr,
>> +                                    &local_err);
>> +    if (local_err) {
>> +        /* Close socket. */
>> +        qio_channel_close(QIO_CHANNEL(sioc), NULL);
>> +        object_unref(OBJECT(sioc));
>> +        sioc =3D NULL;
>> +        goto out;
>> +    }
>> +
>> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
>> +out:
>> +    return sioc;
>> +}
>> +
>> +uint64_t vmsr_read_msr(uint32_t reg, uint32_t cpu_id, uint32_t tid,
>> +                       QIOChannelSocket *sioc)
>> +{
>> +    uint64_t data =3D 0;
>> +    int r =3D 0;
>> +    Error *local_err =3D NULL;
>> +    uint32_t buffer[3];
>> +    /*
>> +     * Send the required arguments:
>> +     * 1. RAPL MSR register to read
>> +     * 2. On which CPU ID
>> +     * 3. From which vCPU (Thread ID)
>> +     */
>> +    buffer[0] =3D reg;
>> +    buffer[1] =3D cpu_id;
>> +    buffer[2] =3D tid;
>> +
>> +    r =3D qio_channel_write_all(QIO_CHANNEL(sioc),
>> +                              (char *)buffer, sizeof(buffer),
>> +                              &local_err);
>> +    if (r < 0) {
>> +        goto out_close;
>> +    }
>> +
>> +    r =3D qio_channel_read(QIO_CHANNEL(sioc),
>> +                             (char *)&data, sizeof(data),
>> +                             &local_err);
>> +    if (r < 0) {
>> +        data =3D 0;
>> +        goto out_close;
>> +    }
>> +
>> +out_close:
>> +   return data;
>> +}
>> +
>> +/* Retrieve the max number of physical package */
>> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus)
>> +{
>> +    const char *dir =3D "/sys/devices/system/cpu/";
>> +    const char *topo_path =3D "topology/physical_package_id";
>> +    g_autofree int *uniquePackages =3D g_new0(int, max_cpus);
>> +    unsigned int packageCount =3D 0;
>> +    FILE *file =3D NULL;
>> +
>> +    for (int i =3D 0; i < max_cpus; i++) {
>> +        g_autofree char *filePath =3D NULL;
>> +        g_autofree char *cpuid =3D g_strdup_printf("cpu%d", i);
>> +
>> +        filePath =3D g_build_filename(dir, cpuid, topo_path, NULL);
>> +
>> +        file =3D fopen(filePath, "r");
>> +
>> +        if (file =3D=3D NULL) {
>> +            error_report("Error opening physical_package_id file");
>> +            return 0;
>> +        }
>> +
>> +        char packageId[10];
>> +        if (fgets(packageId, sizeof(packageId), file) =3D=3D NULL) {
>> +            packageCount =3D 0;
>> +        }
>> +
>> +        fclose(file);
>> +
>> +        int currentPackageId =3D atoi(packageId);
>> +
>> +        bool isUnique =3D true;
>> +        for (int j =3D 0; j < packageCount; j++) {
>> +            if (uniquePackages[j] =3D=3D currentPackageId) {
>> +                isUnique =3D false;
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (isUnique) {
>> +            uniquePackages[packageCount] =3D currentPackageId;
>> +            packageCount++;
>> +
>> +            if (packageCount >=3D max_cpus) {
>> +                break;
>> +            }
>> +        }
>> +    }
>> +
>> +    return (packageCount =3D=3D 0) ? 1 : packageCount;
>> +}
>> +
>> +/* Retrieve the max number of physical cpu on the host */
>> +unsigned int vmsr_get_maxcpus(void)
>> +{
>> +    GDir *dir;
>> +    const gchar *entry_name;
>> +    unsigned int cpu_count =3D 0;
>> +    const char *path =3D "/sys/devices/system/cpu/";
>> +
>> +    dir =3D g_dir_open(path, 0, NULL);
>> +    if (dir =3D=3D NULL) {
>> +        error_report("Unable to open cpu directory");
>> +        return -1;
>> +    }
>> +
>> +    while ((entry_name =3D g_dir_read_name(dir)) !=3D NULL) {
>> +        if (g_ascii_strncasecmp(entry_name, "cpu", 3) =3D=3D 0 &&
>> +            isdigit(entry_name[3])) {
>> +            cpu_count++;
>> +        }
>> +    }
>> +
>> +    g_dir_close(dir);
>> +
>> +    return cpu_count;
>> +}
>> +
>> +/* Count the number of physical cpu on each packages */
>> +unsigned int vmsr_count_cpus_per_package(unsigned int *package_count,
>> +                                         unsigned int max_pkgs)
>> +{
>> +    g_autofree char *file_contents =3D NULL;
>> +    g_autofree char *path =3D NULL;
>> +    g_autofree char *path_name =3D NULL;
>> +    gsize length;
>> +
>> +    /* Iterate over cpus and count cpus in each package */
>> +    for (int cpu_id =3D 0; ; cpu_id++) {
>> +        path_name =3D g_strdup_printf("/sys/devices/system/cpu/cpu%d/"
>> +            "topology/physical_package_id", cpu_id);
>> +
>> +        path =3D g_build_filename(path_name, NULL);
>> +
>> +        if (!g_file_get_contents(path, &file_contents, &length, NULL)) =
{
>> +            break; /* No more cpus */
>> +        }
>> +
>> +        /* Get the physical package ID for this CPU */
>> +        int package_id =3D atoi(file_contents);
>> +
>> +        /* Check if the package ID is within the known number of packag=
es */
>> +        if (package_id >=3D 0 && package_id < max_pkgs) {
>> +            /* If yes, count the cpu for this package*/
>> +            package_count[package_id]++;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/* Get the physical package id from a given cpu id */
>> +int vmsr_get_physical_package_id(int cpu_id)
>> +{
>> +    g_autofree char *file_contents =3D NULL;
>> +    g_autofree char *file_path =3D NULL;
>> +    int package_id =3D -1;
>> +    gsize length;
>> +
>> +    file_path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%d"
>> +        "/topology/physical_package_id", cpu_id);
>> +
>> +    if (!g_file_get_contents(file_path, &file_contents, &length, NULL))=
 {
>> +        goto out;
>> +    }
>> +
>> +    package_id =3D atoi(file_contents);
>> +
>> +out:
>> +    return package_id;
>> +}
>> +
>> +/* Read the scheduled time for a given thread of a give pid */
>> +void vmsr_read_thread_stat(pid_t pid,
>> +                      unsigned int thread_id,
>> +                      unsigned long long *utime,
>> +                      unsigned long long *stime,
>> +                      unsigned int *cpu_id)
>> +{
>> +    g_autofree char *path =3D NULL;
>> +    g_autofree char *path_name =3D NULL;
>> +
>> +    path_name =3D g_strdup_printf("/proc/%u/task/%d/stat", pid, thread_=
id);
>> +
>> +    path =3D g_build_filename(path_name, NULL);
>> +
>> +    FILE *file =3D fopen(path, "r");
>> +    if (file =3D=3D NULL) {
>> +        pid =3D -1;
>> +        return;
>> +    }
>> +
>> +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u =
%*u %*u"
>> +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
>> +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
>> +           utime, stime, cpu_id) !=3D 3)
>> +    {
>> +        pid =3D -1;
>> +        return;
>> +    }
>> +
>> +    fclose(file);
>> +    return;
>> +}
>> +
>> +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
>> +pid_t *vmsr_get_thread_ids(pid_t pid, unsigned int *num_threads)
>> +{
>> +    g_autofree char *task_path =3D g_strdup_printf("%d/task", pid);
>> +    g_autofree char *path =3D g_build_filename("/proc", task_path, NULL=
);
>> +
>> +    DIR *dir =3D opendir(path);
>> +    if (dir =3D=3D NULL) {
>> +        error_report("Error opening /proc/qemu/task");
>> +        return NULL;
>> +    }
>> +
>> +    pid_t *thread_ids =3D NULL;
>> +    unsigned int thread_count =3D 0;
>> +
>> +    g_autofree struct dirent *ent =3D NULL;
>> +    while ((ent =3D readdir(dir)) !=3D NULL) {
>> +        if (ent->d_name[0] =3D=3D '.') {
>> +            continue;
>> +        }
>> +        pid_t tid =3D atoi(ent->d_name);
>> +        if (pid !=3D tid) {
>> +            thread_ids =3D g_renew(pid_t, thread_ids, (thread_count + 1=
));
>> +            thread_ids[thread_count] =3D tid;
>> +            thread_count++;
>> +        }
>> +    }
>> +
>> +    closedir(dir);
>> +
>> +    *num_threads =3D thread_count;
>> +    return thread_ids;
>> +}
>> +
>> +void vmsr_delta_ticks(vmsr_thread_stat *thd_stat, int i)
>> +{
>> +    thd_stat[i].delta_ticks =3D (thd_stat[i].utime[1] + thd_stat[i].sti=
me[1])
>> +                            - (thd_stat[i].utime[0] + thd_stat[i].stime=
[0]);
>> +}
>> +
>> +double vmsr_get_ratio(uint64_t e_delta,
>> +                      unsigned long long delta_ticks,
>> +                      unsigned int maxticks)
>> +{
>> +    return (e_delta / 100.0) * ((100.0 / maxticks) * delta_ticks);
>> +}
>> +
>> +void vmsr_init_topo_info(X86CPUTopoInfo *topo_info,
>> +                           const MachineState *ms)
>> +{
>> +    topo_info->dies_per_pkg =3D ms->smp.dies;
>> +    topo_info->cores_per_die =3D ms->smp.cores;
>> +    topo_info->threads_per_core =3D ms->smp.threads;
>> +}
>> +
>> diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy=
.h
>> new file mode 100644
>> index 000000000000..16cc1f4814f6
>> --- /dev/null
>> +++ b/target/i386/kvm/vmsr_energy.h
>> @@ -0,0 +1,99 @@
>> +/*
>> + * QEMU KVM support -- x86 virtual energy-related MSR.
>> + *
>> + * Copyright 2024 Red Hat, Inc. 2024
>> + *
>> + *  Author:
>> + *      Anthony Harivel <aharivel@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef VMSR_ENERGY_H
>> +#define VMSR_ENERGY_H
>> +
>> +#include <stdint.h>
>> +#include "qemu/osdep.h"
>> +#include "io/channel-socket.h"
>> +#include "hw/i386/topology.h"
>> +
>> +/*
>> + * Define the interval time in micro seconds between 2 samples of
>> + * energy related MSRs
>> + */
>> +#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
>> +
>> +/*
>> + * Thread statistic
>> + * @ thread_id: TID (thread ID)
>> + * @ is_vcpu: true if TID is vCPU thread
>> + * @ cpu_id: CPU number last executed on
>> + * @ pkg_id: package number of the CPU
>> + * @ vcpu_id: vCPU ID
>> + * @ vpkg: virtual package number
>> + * @ acpi_id: APIC id of the vCPU
>> + * @ utime: amount of clock ticks the thread
>> + *          has been scheduled in User mode
>> + * @ stime: amount of clock ticks the thread
>> + *          has been scheduled in System mode
>> + * @ delta_ticks: delta of utime+stime between
>> + *          the two samples (before/after sleep)
>> + */
>> +struct vmsr_thread_stat {
>> +    unsigned int thread_id;
>> +    bool is_vcpu;
>> +    unsigned int cpu_id;
>> +    unsigned int pkg_id;
>> +    unsigned int vpkg_id;
>> +    unsigned int vcpu_id;
>> +    unsigned long acpi_id;
>> +    unsigned long long *utime;
>> +    unsigned long long *stime;
>> +    unsigned long long delta_ticks;
>> +};
>> +
>> +/*
>> + * Package statistic
>> + * @ e_start: package energy counter before the sleep
>> + * @ e_end: package energy counter after the sleep
>> + * @ e_delta: delta of package energy counter
>> + * @ e_ratio: store the energy ratio of non-vCPU thread
>> + * @ nb_vcpu: number of vCPU running on this package
>> + */
>> +struct vmsr_package_energy_stat {
>> +    uint64_t e_start;
>> +    uint64_t e_end;
>> +    uint64_t e_delta;
>> +    uint64_t e_ratio;
>> +    unsigned int nb_vcpu;
>> +};
>> +
>> +typedef struct vmsr_thread_stat vmsr_thread_stat;
>> +typedef struct vmsr_package_energy_stat vmsr_package_energy_stat;
>> +
>> +char *vmsr_compute_default_paths(void);
>> +void vmsr_read_thread_stat(pid_t pid,
>> +                      unsigned int thread_id,
>> +                      unsigned long long *utime,
>> +                      unsigned long long *stime,
>> +                      unsigned int *cpu_id);
>> +
>> +QIOChannelSocket *vmsr_open_socket(const char *path);
>> +uint64_t vmsr_read_msr(uint32_t reg, uint32_t cpu_id,
>> +                       uint32_t tid, QIOChannelSocket *sioc);
>> +void vmsr_delta_ticks(vmsr_thread_stat *thd_stat, int i);
>> +unsigned int vmsr_get_maxcpus(void);
>> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus);
>> +unsigned int vmsr_count_cpus_per_package(unsigned int *package_count,
>> +                                         unsigned int max_pkgs);
>> +int vmsr_get_physical_package_id(int cpu_id);
>> +pid_t *vmsr_get_thread_ids(pid_t pid, unsigned int *num_threads);
>> +double vmsr_get_ratio(uint64_t e_delta,
>> +                      unsigned long long delta_ticks,
>> +                      unsigned int maxticks);
>> +void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState =
*ms);
>> +bool is_host_cpu_intel(void);
>> +int is_rapl_enabled(void);
>> +#endif /* VMSR_ENERGY_H */


