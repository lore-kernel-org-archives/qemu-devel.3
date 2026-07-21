Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33923C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm44I-0000Q2-UE; Tue, 21 Jul 2026 02:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm44H-0000O2-IQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm44F-00048H-76
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784615702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io9AxYsRZVRpRAWDTeS4dEvf5llE1RrhCm0LyshcYPA=;
 b=O6fgYaOJ5Fh96l/jmVJfzUyXOe58h1HZFInN5P2B6esrwCLP37/eDyoeSDUWpCbbpRwVXk
 7upj6B56TmoTaE4Fl7ZLToDRfdUsBvUOnMMuPk+P5d3rdejlkfNOB+Q3pyb2rf3hHtffcd
 dsw/uW1Be6Qc9wZvQIdz3y2bPH+rx1c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-wzxJQAUMNzqWvGCT27IWnA-1; Tue,
 21 Jul 2026 02:34:58 -0400
X-MC-Unique: wzxJQAUMNzqWvGCT27IWnA-1
X-Mimecast-MFC-AGG-ID: wzxJQAUMNzqWvGCT27IWnA_1784615696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A20A1809C86; Tue, 21 Jul 2026 06:34:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91EBF1800765; Tue, 21 Jul 2026 06:34:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E88B21E6920; Tue, 21 Jul 2026 08:34:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Sergio Lopez <slp@redhat.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Jason Wang <jasowangio@gmail.com>,  Eric Blake
 <eblake@redhat.com>,  devel@lists.libvirt.org (open list:Incompatible
 changes),  xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-ppc@nongnu.org (open list:e500),  qemu-riscv@nongnu.org (open
 list:Microchip PolarFi...)
Subject: Re: [PATCH v19 03/15] net/tap: deprecate "no" as special value for
 script/downscript
In-Reply-To: <20260714154246.1242856-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Jul 2026 18:42:31 +0300")
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-4-vsementsov@yandex-team.ru>
Date: Tue, 21 Jul 2026 08:34:51 +0200
Message-ID: <87pl0gsvec.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> The interface is ambiguous, as "no" is valid file name. So,
> using "no" as a special value to disable script is deprecated.
> Use an empty string ("script=3D" / "downscript=3D") instead.
>
> In a future version, "no" will be treated as a plain file name, just
> like any other non-empty value.
>
> Document the deprecation in docs/about/deprecated.rst, qapi/net.json,
> and qemu-options.hx. Update other docs to use empty string instead of
> "no". Add a warning.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  docs/about/deprecated.rst                  | 18 ++++++++++++++
>  docs/system/i386/microvm.rst               |  4 +--
>  docs/system/i386/xenpvh.rst                |  2 +-
>  docs/system/ppc/ppce500.rst                |  4 +--
>  docs/system/riscv/microchip-icicle-kit.rst |  2 +-
>  docs/system/riscv/sifive_u.rst             |  2 +-
>  net/tap.c                                  | 29 ++++++++++++++--------
>  qapi/net.json                              | 12 ++++++---
>  qemu-options.hx                            |  7 ++++--
>  9 files changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968fc..c4929317e3a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -71,6 +71,15 @@ flexible enough. The monitor objects have been convert=
ed to QOM, so
>  ``-mon mode=3Dcontrol`` is replaced by ``-object monitor-qmp``. The
>  short convenience options are not deprecated, only ``-mon``.
>=20=20
> +``script=3Dno`` and ``downscript=3Dno`` for ``-netdev tap`` (since 11.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The special value ``"no"`` for the ``script`` and ``downscript``
> +parameters of ``-netdev tap`` disables script execution.  This special
> +treatment of ``"no"`` is deprecated.  Use an empty string (``script=3D``
> +or ``downscript=3D``) to disable script execution instead.  In a future
> +version, ``"no"`` will be treated as a plain file name.
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>=20=20
> @@ -164,6 +173,15 @@ Use ``job-finalize`` instead.
>=20=20
>  Use ``query-accelerators`` instead.
>=20=20
> +``"no"`` as value of ``script``/``downscript`` for tap in ``netdev_add``=
 (since 11.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
'''''''''''''
> +
> +The special value ``"no"`` for the ``script`` and ``downscript``
> +parameters of ``netdev_add`` with ``type=3Dtap`` disables script
> +execution.  This special treatment of ``"no"`` is deprecated.  Use an
> +empty string instead.  In a future version, ``"no"`` will be treated as
> +a plain file name.
> +
>  Human Machine Protocol (HMP) commands
>  -------------------------------------
>=20=20
> diff --git a/docs/system/i386/microvm.rst b/docs/system/i386/microvm.rst
> index 1675e37d3e7..077ea15751e 100644
> --- a/docs/system/i386/microvm.rst
> +++ b/docs/system/i386/microvm.rst
> @@ -79,7 +79,7 @@ legacy ``ISA serial`` device as console::
>       -serial stdio \
>       -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>       -device virtio-blk-device,drive=3Dtest \
> -     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> +     -netdev tap,id=3Dtap0,script=3D,downscript=3D \
>       -device virtio-net-device,netdev=3Dtap0
>=20=20
>  While the example above works, you might be interested in reducing the
> @@ -103,7 +103,7 @@ disabled::
>       -device virtconsole,chardev=3Dvirtiocon0 \
>       -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>       -device virtio-blk-device,drive=3Dtest \
> -     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
> +     -netdev tap,id=3Dtap0,script=3D,downscript=3D \
>       -device virtio-net-device,netdev=3Dtap0
>=20=20
>=20=20
> diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
> index 904778e3f5c..862f38830b1 100644
> --- a/docs/system/i386/xenpvh.rst
> +++ b/docs/system/i386/xenpvh.rst
> @@ -42,7 +42,7 @@ case you need to construct one manually:
>        -vnc none                                       \
>        -display none                                   \
>        -device virtio-net-pci,id=3Dnic0,netdev=3Dnet0,mac=3D00:16:3e:5c:8=
1:78 \
> -      -netdev type=3Dtap,id=3Dnet0,ifname=3Dvif3.0-emu,br=3Dxenbr0,scrip=
t=3Dno,downscript=3Dno \
> +      -netdev type=3Dtap,id=3Dnet0,ifname=3Dvif3.0-emu,br=3Dxenbr0,scrip=
t=3D,downscript=3D \
>        -smp 4,maxcpus=3D4                                \
>        -nographic                                      \
>        -machine xenpvh,ram-low-base=3D0,ram-low-size=3D2147483648,ram-hig=
h-base=3D4294967296,ram-high-size=3D2147483648,pci-ecam-base=3D824633720832=
,pci-ecam-size=3D268435456,pci-mmio-base=3D4026531840,pci-mmio-size=3D33554=
432,pci-mmio-high-base=3D824902156288,pci-mmio-high-size=3D68719476736 \
> diff --git a/docs/system/ppc/ppce500.rst b/docs/system/ppc/ppce500.rst
> index c9fe0915dc5..ec5aaf14fd9 100644
> --- a/docs/system/ppc/ppce500.rst
> +++ b/docs/system/ppc/ppce500.rst
> @@ -158,14 +158,14 @@ interface at PCI address 0.1.0, but we can switch t=
hat to an e1000 NIC by:
>    $ qemu-system-ppc64 -M ppce500 -smp 4 -m 2G \
>                        -display none -serial stdio \
>                        -bios u-boot \
> -                      -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno=
,model=3De1000
> +                      -nic tap,ifname=3Dtap0,script=3D,downscript=3D,mod=
el=3De1000
>=20=20
>  The QEMU ``ppce500`` machine can also dynamically instantiate an eTSEC d=
evice
>  if =E2=80=9C-device eTSEC=E2=80=9D is given to QEMU:
>=20=20
>  .. code-block:: bash
>=20=20
> -  -netdev tap,ifname=3Dtap0,script=3Dno,downscript=3Dno,id=3Dnet0 -devic=
e eTSEC,netdev=3Dnet0
> +  -netdev tap,ifname=3Dtap0,script=3D,downscript=3D,id=3Dnet0 -device eT=
SEC,netdev=3Dnet0
>=20=20
>  Root file system on flash drive
>  -------------------------------
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
> index 9809e94b84b..7fdb96601ad 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -84,7 +84,7 @@ Then we can boot the machine by:
>    $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 -m 2G \
>        -sd path/to/sdcard.img \
>        -nic user,model=3Dcadence_gem \
> -      -nic tap,ifname=3Dtap,model=3Dcadence_gem,script=3Dno \
> +      -nic tap,ifname=3Dtap,model=3Dcadence_gem,script=3D \
>        -display none -serial stdio \
>        -kernel path/to/u-boot/build/dir/u-boot.bin \
>        -dtb path/to/u-boot/build/dir/u-boot.dtb
> diff --git a/docs/system/riscv/sifive_u.rst b/docs/system/riscv/sifive_u.=
rst
> index 8f55ae8e313..0e4dcf3e70c 100644
> --- a/docs/system/riscv/sifive_u.rst
> +++ b/docs/system/riscv/sifive_u.rst
> @@ -199,7 +199,7 @@ To boot the VxWorks kernel in QEMU with the ``sifive_=
u`` machine, use:
>=20=20
>    $ qemu-system-riscv64 -M sifive_u -smp 5 -m 2G \
>        -display none -serial stdio \
> -      -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno \
> +      -nic tap,ifname=3Dtap0,script=3D,downscript=3D \
>        -kernel /path/to/vxWorks \
>        -append "gem(0,0)host:vxWorks h=3D192.168.200.1 e=3D192.168.200.2:=
ffffff00 u=3Dtarget pw=3DvxTarget f=3D0x01"
>=20=20
> diff --git a/net/tap.c b/net/tap.c
> index fedd48c48d2..2e94b4015f6 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -92,34 +92,40 @@ static void launch_script(const char *setup_script, c=
onst char *ifname,
>  static void tap_send(void *opaque);
>  static void tap_writable(void *opaque);
>=20=20
> -static bool tap_is_explicit_no_script(const char *script_arg)
> +static bool tap_is_explicit_no_script(const char *script_arg_name,
> +                                      const char *script_arg_value)
>  {
> -    if (!script_arg) {
> +    if (!script_arg_value) {
>          return false;
>      }
>=20=20
> -    if (script_arg[0] =3D=3D '\0') {
> +    if (script_arg_value[0] =3D=3D '\0') {
>          return true;
>      }
>=20=20
> -    if (strcmp(script_arg, "no") =3D=3D 0) {
> +    if (strcmp(script_arg_value, "no") =3D=3D 0) {
> +        warn_report("%s=3Dno is deprecated; use %s=3D instead "

Maybe "'%s=3Dno' is deprecated; use '%s=3D' instead ".

> +                    "(empty string instead of 'no')",

Not sure this is needed.=20=20

> +                    script_arg_name, script_arg_name);
>          return true;
>      }
>=20=20
>      return false;
>  }

Less churn if you name the argument @script_arg_value in PATCH 01.

>=20=20
> -static char *tap_parse_script(const char *script_arg, const char *defaul=
t_path)
> +static char *tap_parse_script(const char *script_arg_name,
> +                              const char *script_arg_value,
> +                              const char *default_path)
>  {
> -    if (tap_is_explicit_no_script(script_arg)) {
> +    if (tap_is_explicit_no_script(script_arg_name, script_arg_value)) {
>          return NULL;
>      }
>=20=20
> -    if (!script_arg) {
> +    if (!script_arg_value) {
>          return get_relocated_path(default_path);
>      }
>=20=20
> -    return g_strdup(script_arg);
> +    return g_strdup(script_arg_value);
>  }
>=20=20
>  static void tap_update_fd_handler(TAPState *s)
> @@ -740,7 +746,7 @@ static bool net_init_tap_one(const NetdevTapOptions *=
tap, NetClientState *peer,
>          qemu_set_info_str(&s->nc, "helper=3D%s", tap->helper);
>      } else {
>          qemu_set_info_str(&s->nc, "ifname=3D%s,script=3D%s,downscript=3D=
%s", ifname,
> -                          script ?: "no", downscript ?: "no");
> +                          script ?: "", downscript ?: "");
>=20=20
>          if (downscript) {
>              snprintf(s->down_script, sizeof(s->down_script), "%s", downs=
cript);
> @@ -946,9 +952,10 @@ int net_init_tap(const Netdev *netdev, const char *n=
ame,
>          }
>      } else {
>          g_autofree char *script =3D
> -            tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
> +            tap_parse_script("script", tap->script, DEFAULT_NETWORK_SCRI=
PT);
>          g_autofree char *downscript =3D
> -            tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIP=
T);
> +            tap_parse_script("downscript", tap->downscript,
> +                             DEFAULT_NETWORK_DOWN_SCRIPT);
>=20=20
>          if (tap->ifname) {
>              pstrcpy(ifname, sizeof ifname, tap->ifname);
> diff --git a/qapi/net.json b/qapi/net.json
> index 8f0915c4d86..ada0329ef9d 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -399,15 +399,19 @@
>  # @fds: multiple file descriptors of already opened multiqueue capable
>  #     tap
>  #
> -# @script: script to initialize the interface.  An empty string or
> -#     "no" disables script execution.  Defaults to
> +# @script: script to initialize the interface.  An empty string
> +#     disables script execution.  Defaults to
>  #     ``<sysconfdir>/qemu-ifup``, where ``<sysconfdir>`` is the
>  #     system configuration directory at build time (typically /etc).
> +#     Using "no" to disable script execution is deprecated (since
> +#     11.2); use an empty string instead.
>  #
> -# @downscript: script to shut down the interface.  An empty string or
> -#     "no" disables script execution.  Defaults to
> +# @downscript: script to shut down the interface.  An empty string
> +#     disables script execution.  Defaults to
>  #     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the
>  #     system configuration directory at build time (typically /etc).
> +#     Using "no" to disable script execution is deprecated (since
> +#     11.2); use an empty string instead.
>  #
>  # @br: bridge name (since 2.8)
>  #
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 200949655ea..7b9a14f5b38 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3014,7 +3014,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>      "                use network scripts 'file' (default=3D" DEFAULT_NET=
WORK_SCRIPT ")\n"
>      "                to configure it and 'dfile' (default=3D" DEFAULT_NE=
TWORK_DOWN_SCRIPT ")\n"
>      "                to deconfigure it\n"
> -    "                use '[down]script=3Dno' or '[down]script=3D' to dis=
able script execution\n"
> +    "                use '[down]script=3D' to disable script execution\n"
> +    "                ('[down]script=3Dno' is deprecated and will be trea=
ted as a file name in future)\n"
>      "                use network helper 'helper' (default=3D" DEFAULT_BR=
IDGE_HELPER ") to\n"
>      "                configure it\n"
>      "                use 'fd=3Dh' to connect to an already opened TAP in=
terface\n"
> @@ -3553,7 +3554,9 @@ SRST
>      ``<sysconfdir>/qemu-ifup`` and the default network deconfigure scrip=
t is
>      ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the system
>      configuration directory at build time (typically ``/etc``).
> -    Use ``[down]script=3Dno`` or ``[down]script=3D`` to disable script e=
xecution.
> +    Use ``[down]script=3D`` to disable script execution.
> +    Using ``[down]script=3Dno`` is deprecated; in a future version it wi=
ll
> +    be treated as a plain file name.
>=20=20
>      If running QEMU as an unprivileged user, use the network helper
>      to configure the TAP interface and attach it to the bridge.

You mention what "no" does only in QMP documentation.

You mention what "no" will do in a future version only in CLI
documentation.

If information is useful enough to justify the space in one place, it's
likely useful enough in the other place, too.

Up to you.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


