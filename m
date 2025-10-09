Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE48CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pC6-0004HM-Su; Thu, 09 Oct 2025 07:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6pC4-0004GL-8A
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6pBz-0006Rh-Op
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760010733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c7uVSn+Kn6G+Dn/w/q6K1P6gCgJrQWomLtdvAQhYcA=;
 b=OyJokswXwz79AGvmoQPH9ZxFYEWcP3h0bDG4CX4xybPAg4kx7Xh+kQErlzlgb1qB7jyIYf
 yWO3GMVmAMKMOZh0dtwPC4CdK982pzZ67WBhzdZwgmL9Wh7kwprRb2S6f9g8KlQIAWRSwY
 3N6QvmVP8gwpYDJrYbDU0jy9m5qv3CE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-YcvYj-jkM9eNF6I6Hgo07g-1; Thu,
 09 Oct 2025 07:52:09 -0400
X-MC-Unique: YcvYj-jkM9eNF6I6Hgo07g-1
X-Mimecast-MFC-AGG-ID: YcvYj-jkM9eNF6I6Hgo07g_1760010725
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C74C4195604F; Thu,  9 Oct 2025 11:52:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 512AB30001B7; Thu,  9 Oct 2025 11:52:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8525321E6A27; Thu, 09 Oct 2025 13:51:57 +0200 (CEST)
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
Subject: Re: [PATCH RFC V6 02/24] hw/core, qemu-options.hx: Introduce
 'disabledcpus' SMP parameter
In-Reply-To: <20251001010127.3092631-3-salil.mehta@opnsrc.net> (salil mehta's
 message of "Wed, 1 Oct 2025 01:01:05 +0000")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-3-salil.mehta@opnsrc.net>
Date: Thu, 09 Oct 2025 13:51:57 +0200
Message-ID: <87ikgoqoma.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add support for a new SMP configuration parameter, 'disabledcpus', which
> specifies the number of additional CPUs that are present in the virtual
> machine but administratively disabled at boot. These CPUs are visible in
> firmware (e.g. ACPI tables) yet unavailable to the guest until explicitly
> enabled via QMP/HMP, or via the 'device_set' API (introduced in later
> patches).
>
> This feature is intended for architectures that lack native CPU hotplug
> support but can change the administrative power state of present CPUs.
> It allows simulating CPU hot-add=E2=80=93like scenarios while all CPUs re=
main
> physically present in the topology at boot time.
>
> Note: ARM is the first architecture to support this concept.
>
> Changes include:
>  - Extend CpuTopology with a 'disabledcpus' field.
>  - Update machine_parse_smp_config() to account for disabled CPUs when
>    computing 'cpus' and 'maxcpus'.
>  - Update SMPConfiguration in QAPI to accept 'disabledcpus'.
>  - Extend -smp option documentation to describe 'disabledcpus' usage and
>    behavior.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c..e45740da33 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1634,6 +1634,8 @@
>  #
>  # @cpus: number of virtual CPUs in the virtual machine
>  #
> +# @disabledcpus: number of additional present but disabled(or offline) C=
PUs
> +#
>  # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
>  #     machine
>  #
> @@ -1657,6 +1659,7 @@
>  ##
>  { 'struct': 'SMPConfiguration', 'data': {
>       '*cpus': 'int',
> +     '*disabledcpus': 'int',
>       '*drawers': 'int',
>       '*books': 'int',
>       '*sockets': 'int',

We prefer words-with-dashes to wordsruntogether in QAPI/QMP, for
readability: disabled-cpus.

Missing here even before the patch: how these values are related.  That
information appears to be buried in machine_parse_smp_config(), which is
160 lines long and with too many conditionals for me to make sense of
now.

> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..83ccde341b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -326,12 +326,15 @@ SRST
>  ERST
>=20=20
>  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> -    "-smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=3D=
books][,sockets=3Dsockets]\n"
> -    "               [,dies=3Ddies][,clusters=3Dclusters][,modules=3Dmodu=
les][,cores=3Dcores]\n"
> -    "               [,threads=3Dthreads]\n"
> -    "                set the number of initial CPUs to 'n' [default=3D1]=
\n"
> -    "                maxcpus=3D maximum number of total CPUs, including\=
n"
> -    "                offline CPUs for hotplug, etc\n"
> +    "-smp [[cpus=3D]n][,disabledcpus=3Ddisabledcpus][,maxcpus=3Dmaxcpus]=
[,drawers=3Ddrawers][,books=3Dbooks]\n"
> +    "               [,sockets=3Dsockets][,dies=3Ddies][,clusters=3Dclust=
ers][,modules=3Dmodules]\n"
> +    "               [,cores=3Dcores][,threads=3Dthreads]\n"
> +    "                set the initial number of CPUs present and\n"
> +    "                  administratively enabled at boot time to 'n' [def=
ault=3D1]\n"
> +    "                disabledcpus=3D number of present but administrativ=
ely\n"
> +    "                  disabled CPUs (unavailable to the guest at boot)\=
n"
> +    "                maxcpus=3D maximum total CPUs (present + hotpluggab=
le)\n"
> +    "                  on machines without CPU hotplug, defaults to n + =
disabledcpus\n"
>      "                drawers=3D number of drawers on the machine board\n"
>      "                books=3D number of books in one drawer\n"
>      "                sockets=3D number of sockets in one book\n"
> @@ -351,22 +354,49 @@ DEF("smp", HAS_ARG, QEMU_OPTION_smp,
>      "      For a particular machine type board, an expected CPU topology=
 hierarchy\n"
>      "      can be defined through the supported sub-option. Unsupported =
parameters\n"
>      "      can also be provided in addition to the sub-option, but their=
 values\n"
> -    "      must be set as 1 in the purpose of correct parsing.\n",
> +    "      must be set as 1 in the purpose of correct parsing.\n"
> +    "                                                          \n"
> +    "      Administratively disabled CPUs: Some machine types do not sup=
port vCPU\n"
> +    "      hotplug but their CPUs can be marked disabled (powered off) a=
nd kept\n"
> +    "      unavailable to the guest. Later, such CPUs can be enabled via=
 QMP/HMP\n"
> +    "      (e.g., 'device_set ... admin-state=3Denable'). This is simila=
r to hotplug,\n"
> +    "      except all disabled CPUs are already present at boot. Useful =
on\n"
> +    "      architectures that lack architectural CPU hotplug.\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=3Dboo=
ks][,sockets=3Dsockets][,dies=3Ddies][,clusters=3Dclusters][,modules=3Dmodu=
les][,cores=3Dcores][,threads=3Dthreads]``
> -    Simulate a SMP system with '\ ``n``\ ' CPUs initially present on
> -    the machine type board. On boards supporting CPU hotplug, the option=
al
> -    '\ ``maxcpus``\ ' parameter can be set to enable further CPUs to be
> -    added at runtime. When both parameters are omitted, the maximum numb=
er
> +``-smp [[cpus=3D]n][,disabledcpus=3Ddisabledcpus][,maxcpus=3Dmaxcpus][,d=
rawers=3Ddrawers][,books=3Dbooks][,sockets=3Dsockets][,dies=3Ddies][,cluste=
rs=3Dclusters][,modules=3Dmodules][,cores=3Dcores][,threads=3Dthreads]``
> +    Simulate a SMP system with '\ ``n``\ ' CPUs initially present & enab=
led on
> +    the machine type board. Furthermore, on architectures that support c=
hanging
> +    the administrative power state of CPUs, optional '\ ``disabledcpus``=
\ '
> +    parameter specifies *additional* CPUs that are present in firmware (=
e.g.,
> +    ACPI) but are administratively disabled (i.e., not usable by the gue=
st at
> +    boot time).
> +
> +    This is different from CPU hotplug where additional CPUs are not even
> +    present in the system description. Administratively disabled CPUs ap=
pear in
> +    ACPI tables i.e. are provisioned, but cannot be used until explicitly
> +    enabled via QMP/HMP or the deviceset API.
> +
> +    On boards supporting CPU hotplug, the optional '\ ``maxcpus``\ ' par=
ameter
> +    can be set to enable further CPUs to be added at runtime. When both
> +    '\ ``n``\ ' & '\ ``maxcpus``\ ' parameters are omitted, the maximum =
number
>      of CPUs will be calculated from the provided topology members and the
> -    initial CPU count will match the maximum number. When only one of th=
em
> -    is given then the omitted one will be set to its counterpart's value.
> -    Both parameters may be specified, but the maximum number of CPUs must
> -    be equal to or greater than the initial CPU count. Product of the
> -    CPU topology hierarchy must be equal to the maximum number of CPUs.
> -    Both parameters are subject to an upper limit that is determined by
> -    the specific machine type chosen.
> +    initial CPU count will match the maximum number. When only one of th=
em is
> +    given then the omitted one will be set to its counterpart's value. B=
oth
> +    parameters may be specified, but the maximum number of CPUs must be =
equal
> +    to or greater than the initial CPU count. Product of the CPU topology
> +    hierarchy must be equal to the maximum number of CPUs. Both paramete=
rs are
> +    subject to an upper limit that is determined by the specific machine=
 type
> +    chosen. Boards that support administratively disabled CPUs but do *n=
ot*
> +    support CPU hotplug derive the maximum number of CPUs implicitly:
> +    '\ ``maxcpus``\ ' is treated as '\ ``n + disabledcpus``\ ' (the tota=
l CPUs
> +    present in firmware). If '\ ``maxcpus``\ ' is provided, it must equal
> +    '\ ``n + disabledcpus``\ '. The topology product must equal this der=
ived
> +    maximum as well.
> +
> +    Note: Administratively disabled CPUs will appear to the guest as
> +    unavailable, and any attempt to bring them online must go through QM=
P/HMP
> +    commands like 'device_set'.
>=20=20
>      To control reporting of CPU topology information, values of the topo=
logy
>      parameters can be specified. Machines may only support a subset of t=
he
> @@ -425,6 +455,24 @@ SRST
>=20=20
>          -smp 2
>=20=20
> +    Examples using 'disabledcpus':
> +
> +    For a board without CPU hotplug, enable 4 CPUs at boot and provision
> +    2 additional administratively disabled CPUs (maximum is derived
> +    implicitly as 6 =3D 4 + 2):
> +
> +    ::
> +
> +        -smp cpus=3D4,disabledcpus=3D2
> +
> +    For a board that supports CPU hotplug and 'disabledcpus', enable 4 C=
PUs
> +    at boot, provision 2 administratively disabled CPUs, and allow hotpl=
ug of
> +    2 more CPUs (for a maximum of 8):
> +
> +    ::
> +
> +        -smp cpus=3D4,disabledcpus=3D2,maxcpus=3D8
> +

So, maxcpus =3D cpus + disabledcpus?

Is drawers * books * sockets * dies * clusters * modules * cores *
threads equal or greater than maxcpus?

>      Note: The cluster topology will only be generated in ACPI and exposed
>      to guest if it's explicitly specified in -smp.
>  ERST
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..2f0fd21a1f 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -736,6 +736,9 @@ static QemuOptsList qemu_smp_opts =3D {
>          {
>              .name =3D "cpus",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "disabledcpus",
> +            .type =3D QEMU_OPT_NUMBER,
>          }, {
>              .name =3D "drawers",
>              .type =3D QEMU_OPT_NUMBER,


