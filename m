Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6FCC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocLR-0000AI-Iq; Tue, 28 Jul 2026 03:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wocLK-00009q-Td
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wocLJ-0000N2-4H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785224111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCZz1SanrmLWK/32ASGRImroeKf/utvWCyHdyzOAil0=;
 b=CJztUB7TtOl51rk+6Bs92T/5zhxk12HG92DvqrGi6ubaiW1I5+B8qU0YPfaxixs6YLMHwS
 7fx3ZPSExLEtk2/LsRTP4jwxaJn8j6825cXaLrlmwC9YOuEaXO1buOfcgFCdI0TFmg+n8E
 /8qMJ0+OcDFijgcGlYXWP73wjcXSdmc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-ynZ70cpBMZSyfs1PpH8akw-1; Tue,
 28 Jul 2026 03:35:07 -0400
X-MC-Unique: ynZ70cpBMZSyfs1PpH8akw-1
X-Mimecast-MFC-AGG-ID: ynZ70cpBMZSyfs1PpH8akw_1785224107
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BD83195608C; Tue, 28 Jul 2026 07:35:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F24FB180044F; Tue, 28 Jul 2026 07:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9736221E6920; Tue, 28 Jul 2026 09:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 50/53] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
In-Reply-To: <20260616-qom-qapi-v2-50-cc9396b9c18c@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 16 Jun 2026 00:38:16 +0400")
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-50-cc9396b9c18c@redhat.com>
Date: Tue, 28 Jul 2026 09:35:02 +0200
Message-ID: <87wlufword.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Change DEFINE_PROP_ARRAY, the macro now uses _arrayprop##_list to
> resolve the typed list PropertyInfo (introduced in the previous patch)
> instead of the generic qdev_prop_array.
>
> This means the element type and size information is carried by the
> PropertyInfo itself rather than duplicated at each callsite. Since
> the typed list PropertyInfos encode element_info and element_size,
> the .arrayinfo and .arrayfieldsize fields are no longer set by the
> macro (they will be removed from the Property struct in the next patch).
>
> Remove qdev_prop_array, which is now unused.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
> index b155486af65..61c8ae49302 100644
> --- a/hw/intc/arm_gicv5_common.c
> +++ b/hw/intc/arm_gicv5_common.c
> @@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev, Er=
ror **errp)
>=20=20
>  static const Property arm_gicv5_common_properties[] =3D {
>      DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
> -                           cpus, TYPE_ARM_CPU, ARMCPU *),
> +                           cpus, TYPE_ARM_CPU),
>      DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
> -                      cpu_iaffids, qdev_prop_uint32, uint32_t),
> +                      cpu_iaffids, qdev_prop_uint32),
>      DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
>      DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
>      DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),

Doesn't compile for me.  I applied the series at merge commit
8333dba732.  If it compiles for you, could you push it to where I can
pull?

FAILED: [code=3D1] libsystem.a.p/hw_intc_arm_gicv5_common.c.o=20
cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/libvduse -I../subprojects/li=
bvduse -Iui -Iqapi -Itrace -Iui/shader -I/usr/include/p11-kit-1 -I/usr/incl=
ude/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server -I/usr/inc=
lude/spice-1 -I/usr/include/opus -I/usr/include/cacard -I/usr/include/nss3 =
-I/usr/include/nspr4 -I/usr/include/PCSC -I/usr/include/gstreamer-1.0 -I/us=
r/include/libdrm -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/u=
sr/include/sysprof-6 -I/usr/include/orc-0.4 -I/usr/include/libusb-1.0 -I/us=
r/include/SDL2 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/=
gio-unix-2.0 -I/usr/include/slirp -I/usr/local/include -I/usr/include/gtk-3=
.0 -I/usr/include/pango-1.0 -I/usr/include/cloudproviders -I/usr/include/ca=
iro -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/glycin-2 -I/usr/include/at=
-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/atk-1.0 -I/usr/lib64=
/pkgconfig/../../include/dbus-1.0 -I/usr/lib64/pkgconfig/../../lib64/dbus-1=
.0/include -I/usr/include/fribidi -I/usr/include/libxml2 -I/usr/include/har=
fbuzz -I/usr/include/freetype2 -I/usr/include/vte-2.91 -I/usr/include/rav1e=
 -I/usr/include/svt-av1 -I/usr/include/libvmaf -I/usr/include/webp -I/usr/i=
nclude/virgl -I/usr/include/fuse3 -I/usr/include/uuid -I/usr/include/pipewi=
re-0.3 -I/usr/include/spa-0.2 -fdiagnostics-color=3Dauto -Wall -Winvalid-pc=
h -Werror -std=3Dgnu11 -O2 -g -mcx16 -msse2 -D_GNU_SOURCE -D_LARGEFILE_SOUR=
CE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero =
-fzero-call-used-regs=3Dused-gpr -fstack-protector-strong -Wempty-body -Wen=
dif-labels -Wexpansion-to-defined -Wformat-overflow=3D2 -Wformat-security -=
Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wm=
issing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-d=
eclaration -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal -Wstri=
ct-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-incl=
ude-dirs -Wno-psabi -Wno-shift-negative-value -isystem /work/armbru/qemu/li=
nux-headers -isystem linux-headers -iquote . -iquote /work/armbru/qemu -iqu=
ote /work/armbru/qemu/include -iquote /work/armbru/qemu/host/include/x86_64=
 -iquote /work/armbru/qemu/host/include/generic -iquote /work/armbru/qemu/t=
cg/x86_64 -pthread -DSTAP_SDT_V2 -fPIE -D_FILE_OFFSET_BITS=3D64 -D__USE_FIL=
E_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1 -DHWY_SHARED_DEFINE -DA=
VIF_DLL -DEB_DLL -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=
=3D1 -D_GNU_SOURCE=3D1 -D_REENTRANT -DSTRUCT_IOVEC_DEFINED -DWITH_GZFILEOP =
-DCONFIG_SOFTMMU -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/hw_intc_a=
rm_gicv5_common.c.o -MF libsystem.a.p/hw_intc_arm_gicv5_common.c.o.d -o lib=
system.a.p/hw_intc_arm_gicv5_common.c.o -c ../hw/intc/arm_gicv5_common.c
In file included from ../hw/intc/arm_gicv5_common.c:12:
/work/armbru/qemu/include/hw/core/qdev-properties.h:195:40: error: =E2=80=
=98qdev_prop_array=E2=80=99 undeclared here (not in a function); did you me=
an =E2=80=98qdev_prop_set_array=E2=80=99?
  195 |     DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,  =
     \
      |                                        ^~~~~~~~~~~~~~~
/work/armbru/qemu/include/hw/core/qdev-properties.h:88:24: note: in definit=
ion of macro =E2=80=98DEFINE_PROP=E2=80=99
   88 |         .info      =3D &(_prop),                                   \
      |                        ^~~~~
../hw/intc/arm_gicv5_common.c:193:5: note: in expansion of macro =E2=80=98D=
EFINE_PROP_LINK_ARRAY=E2=80=99
  193 |     DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
      |     ^~~~~~~~~~~~~~~~~~~~~~
../hw/intc/arm_gicv5_common.c:196:62: error: macro =E2=80=98DEFINE_PROP_ARR=
AY=E2=80=99 passed 6 arguments, but takes just 5
  196 |                       cpu_iaffids, qdev_prop_uint32, uint32_t),
      |                                                              ^
/work/armbru/qemu/include/hw/core/qdev-properties.h:166:9: note: macro =E2=
=80=98DEFINE_PROP_ARRAY=E2=80=99 defined here
  166 | #define DEFINE_PROP_ARRAY(_name, _state, _field,                   =
     \
      |         ^~~~~~~~~~~~~~~~~
../hw/intc/arm_gicv5_common.c:195:5: error: =E2=80=98DEFINE_PROP_ARRAY=E2=
=80=99 undeclared here (not in a function)
  195 |     DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
      |     ^~~~~~~~~~~~~~~~~

[...]


