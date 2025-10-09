Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAE2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6mRh-0001Iv-Jh; Thu, 09 Oct 2025 04:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6mRe-0001Id-U2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6mRQ-0004zk-I6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760000157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJNs2atY5G+CU0EvB4JZA2FQVC+cgtYvJ5y+1WeUiKg=;
 b=PrJI4zXr11mqkNfkI4H94+FTE8r8W0BiGd6E0xn994Xqr04R53WfWf5AZzvoSq5DvlEL8w
 PsE9GqRHXZQvZx6e4m7nBLk2mGmTCPZfQqCeas3NZuQtrvASFy0pmN2cJu/EJ8Bgo4uWCc
 6gSV39s0MLB9pj5I3r3hn9Gn/TWx4I8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-D98z8LsaMq-f6VUaGIiplQ-1; Thu,
 09 Oct 2025 04:55:53 -0400
X-MC-Unique: D98z8LsaMq-f6VUaGIiplQ-1
X-Mimecast-MFC-AGG-ID: D98z8LsaMq-f6VUaGIiplQ_1760000149
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09BA8180035C; Thu,  9 Oct 2025 08:55:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 836261800577; Thu,  9 Oct 2025 08:55:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BED8C21E6A27; Thu, 09 Oct 2025 10:55:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  mst@redhat.com,
 salil.mehta@huawei.com,  maz@kernel.org,  jean-philippe@linaro.org,
 jonathan.cameron@huawei.com,  lpieralisi@kernel.org,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 imammedo@redhat.com,  andrew.jones@linux.dev,  david@redhat.com,
 philmd@linaro.org,  eric.auger@redhat.com,  will@kernel.org,
 ardb@kernel.org,  oliver.upton@linux.dev,  pbonzini@redhat.com,
 gshan@redhat.com,  rafael@kernel.org,  borntraeger@linux.ibm.com,
 alex.bennee@linaro.org,  gustavo.romero@linaro.org,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com,  miguel.luis@oracle.com,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 wangzhou1@hisilicon.com,  linuxarm@huawei.com,  jiakernel2@gmail.com,
 maobibo@loongson.cn,  lixianglai@loongson.cn,  shahuang@redhat.com,
 zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
In-Reply-To: <20251001010127.3092631-23-salil.mehta@opnsrc.net> (salil mehta's
 message of "Wed, 1 Oct 2025 01:01:25 +0000")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
Date: Thu, 09 Oct 2025 10:55:40 +0200
Message-ID: <87plawh2sz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

salil.mehta@opnsrc.net writes:

> From: Salil Mehta <salil.mehta@huawei.com>
>
> This patch adds a "device_set" interface for modifying properties of devi=
ces
> that already exist in the guest topology. Unlike 'device_add'/'device_del'
> (hot-plug), 'device_set' does not create or destroy devices. It is intend=
ed
> for guest-visible hot-add semantics where hardware is provisioned at boot=
 but
> logically enabled/disabled later via administrative policy.
>
> Compared to the existing 'qom-set' command, which is less intuitive and w=
orks
> only with object IDs, device_set provides a more device-oriented interfac=
e.
> It can be invoked at the QEMU prompt using natural device arguments, and =
the
> new '-deviceset' CLI option allows properties to be set at boot time, sim=
ilar
> to how '-device' specifies device creation.

Why can't we use -device?

> While the initial implementation focuses on "admin-state" changes (e.g.,
> enable/disable a CPU already described by ACPI/DT), the interface is desi=
gned
> to be generic. In future, it could be used for other per-device set/unset
> style controls =E2=80=94 beyond administrative power-states =E2=80=94 pro=
vided the target
> device explicitly allows such changes. This enables fine-grained runtime
> control of device properties.

Beware, designing a generic interface can be harder, sometimes much
harder, than designing a specialized one.

device_add and qom-set are generic, and they have issues:

* device_add effectively bypasses QAPI by using 'gen': false.

  This bypasses QAPI's enforcement of documentation.  Property
  documentation is separate and poor.

  It also defeats introspection with query-qmp-schema.  You need to
  resort to other means instead, say QOM introspection (which is a bag
  of design flaws on its own), then map from QOM to qdev.

* device_add lets you specify any qdev property, even properties that
  are intended only for use by C code.

  This results in accidental external interfaces.

  We tend to name properties like "x-prop" to discourage external use,
  but I wouldn't bet my own money on us getting that always right.
  Moreover, there's beauties like "x-origin".

* qom-set & friends effectively bypass QAPI by using type 'any'.

  Again, the bypass results in poor documentation and a defeat of
  query-qmp-schema.

* qom-set lets you mess with any QOM property with a setter callback.

  Again, accidental external interfaces: most of these properties are
  not meant for use with qom-set.  For some, qom-set works, for some it
  silently does nothing, and for some it crashes.  A lot more dangerous
  than device_add.

  The "x-" convention can't help here: some properties are intended for
  external use with object-add, but not with qom-set.

We should avoid such issues in new interfaces.

We'll examine how this applies to device_set when I review the QAPI
schema.

> Key pieces:
>   * QMP: qmp_device_set() to update an existing device. The device can be
>     located by "id" or via driver+property match using a DeviceListener
>     callback (qdev_find_device()).
>   * HMP: "device_set" command with tab-completion. Errors are surfaced via
>     hmp_handle_error().
>   * CLI: "-deviceset" option for setting startup/admin properties at boot,
>     including a JSON form. Options are parsed into qemu_deviceset_opts and
>     applied after device creation.
>   * Docs/help: HMP help text and qemu-options.hx additions explain usage =
and
>     explicitly note that no hot-plug occurs.
>   * Safety: disallowed during live migration (migration_is_idle() check).
>
> Semantics:
>   * Operates on an existing DeviceState; no enumeration/new device appear=
s.
>   * Complements device_add/device_del by providing state mutation only.
>   * Backward compatible: no behavior change unless "device_set"/"-devices=
et"
>     is used.
>
> Examples:
>   HMP:
>     (qemu) device_set host-arm-cpu,core-id=3D3,admin-state=3Denable
>
>   CLI (at boot):
>     -smp cpus=3D4,maxcpus=3D4 \
>     -deviceset host-arm-cpu,core-id=3D2,admin-state=3Ddisable
>
>   QMP (JSON form):
>     { "execute": "device_set",
>       "arguments": {
>         "driver": "host-arm-cpu",
>         "core-id": 1,
>         "admin-state": "disable"
>       }
>     }

{"error": {"class": "CommandNotFound", "desc": "The command device_set has =
not been found"}}

Clue below.

> NOTE: The qdev_enable()/qdev_disable() hooks for acting on admin-state wi=
ll be
> added in subsequent patches. Device classes must explicitly support any
> property they want to expose through device_set.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>  hmp-commands.hx         |  30 +++++++++
>  hw/arm/virt.c           |  86 +++++++++++++++++++++++++
>  hw/core/cpu-common.c    |  12 ++++
>  hw/core/qdev.c          |  21 ++++++
>  include/hw/arm/virt.h   |   1 +
>  include/hw/core/cpu.h   |  11 ++++
>  include/hw/qdev-core.h  |  22 +++++++
>  include/monitor/hmp.h   |   2 +
>  include/monitor/qdev.h  |  30 +++++++++
>  include/system/system.h |   1 +
>  qemu-options.hx         |  51 +++++++++++++--
>  system/qdev-monitor.c   | 139 +++++++++++++++++++++++++++++++++++++++-
>  system/vl.c             |  39 +++++++++++
>  13 files changed, 440 insertions(+), 5 deletions(-)

Clue: no update to the QAPI schema, i.e. the QMP command does not exist.

>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index d0e4f35a30..18056cf21d 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -707,6 +707,36 @@ SRST
>    or a QOM object path.
>  ERST
>=20=20
> +{
> +    .name       =3D "device_set",
> +    .args_type  =3D "device:O",
> +    .params     =3D "driver[,prop=3Dvalue][,...]",
> +    .help       =3D "set/unset existing device property",
> +    .cmd        =3D hmp_device_set,
> +    .command_completion =3D device_set_completion,
> +},
> +
> +SRST
> +``device_set`` *driver[,prop=3Dvalue][,...]*
> +  Change the administrative power state of an existing device.
> +
> +  This command enables or disables a known device (e.g., CPU) using the
> +  "device_set" interface. It does not hotplug or add a new device.
> +
> +  Depending on platform support (e.g., PSCI or ACPI), this may trigger
> +  corresponding operational changes =E2=80=94 such as powering down a CP=
U or
> +  transitioning it to active use.
> +
> +  Administrative state:
> +    * *enabled*  =E2=80=94 Allows the guest to use the device (e.g., CPU=
_ON)
> +    * *disabled* =E2=80=94 Prevents guest use; device is powered off (e.=
g., CPU_OFF)
> +
> +  Note: The device must already exist (be declared during machine creati=
on).
> +
> +  Example:
> +      (qemu) device_set host-arm-cpu,core-id=3D3,admin-state=3Ddisabled
> +ERST

How exactly is the device selected?  You provide a clue above: 'can be
located by "id" or via driver+property match'.

I assume by "id" is just like device_del, i.e. by qdev ID or QOM path.

By "driver+property match" is not obvious.  Which of the arguments are
for matching, and which are for setting?

If "id" is specified, is there any matching?

The matching feature complicates this interface quite a bit.  I doubt
it's worth the complexity.  If you think it is, please split it off into
a separate patch.

Next question.  Is there a way for management applications to detect
whether a certain device supports device_set for a certain property?

Without that, what are management application supposed to do?  Hard-code
what works?  Run the command and see whether it fails?

I understand right now the command supports just "admin-state" for a
certain set of devices, so hard-coding would be possible.  But every new
(device, property) pair then requires management application updates,
and the hard-coded information becomes version specific.  This will
become unworkable real quick.  Not good enough for a command designed to
be generic.

> +
>      {
>          .name       =3D "cpu",
>          .args_type  =3D "index:i",

[...]

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 83ccde341b..f517b91042 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -375,7 +375,10 @@ SRST
>      This is different from CPU hotplug where additional CPUs are not even
>      present in the system description. Administratively disabled CPUs ap=
pear in
>      ACPI tables i.e. are provisioned, but cannot be used until explicitly
> -    enabled via QMP/HMP or the deviceset API.
> +    enabled via QMP/HMP or the deviceset API. On ACPI guests, each vCPU =
counted
> +    by 'disabledcpus=3D' is provisioned with '\ ``_STA``\ ' reporting Pr=
esent=3D1
> +    and Enabled=3D0 (present-offline) at boot; it becomes Enabled=3D1 wh=
en brought
> +    online via 'device_set ... admin-state=3Denable'.
>=20=20
>      On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' par=
ameter
>      can be set to enable further CPUs to be added at runtime. When both
> @@ -455,6 +458,15 @@ SRST
>=20=20
>          -smp 2
>=20=20
> +    Note: The cluster topology will only be generated in ACPI and exposed
> +    to guest if it's explicitly specified in -smp.
> +
> +    Note: Administratively disabled CPUs (specified via 'disabledcpus=3D=
' and
> +    '-deviceset' at CLI during boot) are especially useful for platforms=
 like
> +    ARM that lack native CPU hotplug support. These CPUs will appear to =
the
> +    guest as unavailable, and any attempt to bring them online must go t=
hrough
> +    QMP/HMP commands like 'device_set'.
> +
>      Examples using 'disabledcpus':
>=20=20
>      For a board without CPU hotplug, enable 4 CPUs at boot and provision
> @@ -472,9 +484,6 @@ SRST
>      ::
>=20=20
>          -smp cpus=3D4,disabledcpus=3D2,maxcpus=3D8
> -
> -    Note: The cluster topology will only be generated in ACPI and exposed
> -    to guest if it's explicitly specified in -smp.
>  ERST
>=20=20
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> @@ -1281,6 +1290,40 @@ SRST
>=20=20
>  ERST
>=20=20
> +DEF("deviceset", HAS_ARG, QEMU_OPTION_deviceset,
> +    "-deviceset driver[,prop[=3Dvalue]][,...]\n"
> +    "                Set administrative power state of an existing devic=
e.\n"
> +    "                Does not hotplug a new device. Can disable or enabl=
e\n"
> +    "                devices (such as CPUs) at boot based on policy.\n"
> +    "                Example:\n"
> +    "                    -deviceset host-arm-cpu,core-id=3D2,admin-state=
=3Ddisabled\n"
> +    "                Use '-deviceset help' for supported drivers\n"
> +    "                Use '-deviceset driver,help' for driver-specific pr=
operties\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-deviceset driver[,prop[=3Dvalue]][,...]``
> +    Configure an existing device's administrative power state or propert=
ies.
> +
> +    Unlike ``-device``, this option does not create a new device. Instea=
d,
> +    it sets startup properties (such as administrative power state) for
> +    a device already declared via -smp or other machine configuration.
> +
> +    Example:
> +        -smp cpus=3D4
> +        -deviceset host-arm-cpu,core-id=3D2,admin-state=3Ddisabled
> +
> +    The above disables CPU core 2 at boot using administrative offlining.
> +    The guest may later re-enable the core (if permitted by platform pol=
icy).
> +
> +    ``state=3Denabled|disabled``
> +        Sets the administrative state of the device:
> +        - ``enabled``: device is made available at boot
> +        - ``disabled``: device is administratively disabled and powered =
off
> +
> +    Use ``-deviceset help`` to view all supported drivers.
> +    Use ``-deviceset driver,help`` for property-specific help.
> +ERST
> +
>  DEF("name", HAS_ARG, QEMU_OPTION_name,
>      "-name string1[,process=3Dstring2][,debug-threads=3Don|off]\n"
>      "                set the name of the guest\n"
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 2ac92d0a07..1099b1237d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -263,12 +263,20 @@ static DeviceClass *qdev_get_device_class(const cha=
r **driver, Error **errp)
>      }
>=20=20
>      dc =3D DEVICE_CLASS(oc);
> -    if (!dc->user_creatable) {
> +    if (!dc->user_creatable && !dc->admin_power_state_supported) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
>                     "a pluggable device type");
>          return NULL;
>      }
>=20=20
> +    if (phase_check(PHASE_MACHINE_READY) &&
> +        (!dc->hotpluggable || !dc->admin_power_state_supported)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
> +                   "a pluggable device type or which supports changing p=
ower-"
> +                   "state administratively");
> +        return NULL;
> +    }
> +
>      if (object_class_dynamic_cast(oc, TYPE_SYS_BUS_DEVICE)) {
>          /* sysbus devices need to be allowed by the machine */
>          MachineClass *mc =3D MACHINE_CLASS(object_get_class(qdev_get_mac=
hine()));
> @@ -939,6 +947,76 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>=20=20
> +void qmp_device_set(const QDict *qdict, Error **errp)
> +{
> +    const char *state;
> +    const char *driver;
> +    DeviceState *dev;
> +    DeviceClass *dc;
> +    const char *id;
> +
> +    driver =3D qdict_get_try_str(qdict, "driver");
> +    if (!driver) {
> +        error_setg(errp, "Parameter 'driver' is missing");
> +        return;
> +    }
> +
> +    /* check driver exists and we are at the right phase of machine init=
 */
> +    dc =3D qdev_get_device_class(&driver, errp);
> +    if (!dc) {

Since qdev_get_device_class() sets an error when it fails, *errp is not
null here, ...

> +        error_setg(errp, "driver '%s' not supported", driver);

... which makes this wrong.  Caught by error_setv()'s assertion.

Please test your error paths.

> +        return;
> +    }
> +
> +    if (migration_is_running()) {
> +        error_setg(errp, "device_set not allowed while migrating");
> +        return;
> +    }
> +
> +    id =3D qdict_get_try_str(qdict, "id");
> +
> +    if (id) {
> +        /* Lookup by ID */
> +        dev =3D find_device_state(id, false, errp);
> +        if (errp && *errp) {
> +            error_prepend(errp, "Device lookup failed for ID '%s': ", id=
);
> +            return;
> +        }
> +    } else {
> +        /* Lookup using driver and properties */
> +        dev =3D qdev_find_device(qdict, errp);
> +        if (errp && *errp) {
> +            error_prepend(errp, "Device lookup for %s failed: ", driver);
> +            return;
> +        }
> +    }
> +    if (!dev) {
> +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                  "No device found for driver '%s'", driver);
> +        return;
> +    }
> +
> +    state =3D qdict_get_try_str(qdict, "admin-state");
> +    if (!state) {
> +        error_setg(errp, "no device state change specified for device %s=
 ",
> +                   dev->id);
> +        return;
> +    } else if (!strcmp(state, "enable")) {
> +
> +        if (!qdev_enable(dev, qdev_get_parent_bus(DEVICE(dev)), errp)) {
> +            return;
> +        }
> +    } else if (!strcmp(state, "disable")) {
> +        if (!qdev_disable(dev, qdev_get_parent_bus(DEVICE(dev)), errp)) {
> +            return;
> +        }
> +    } else {
> +        error_setg(errp, "unrecognized specified state *%s* for device %=
s",
> +                   state, dev->id);
> +        return;
> +    }
> +}
> +
>  int qdev_sync_config(DeviceState *dev, Error **errp)
>  {
>      DeviceClass *dc =3D DEVICE_GET_CLASS(dev);

[...]


